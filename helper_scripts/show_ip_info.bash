#!/bin/bash

# Temp arrays to store info
declare -a vendors types ips netmasks conns ifaces

parse_ip_cidr() {
  # This will parse a cidr ipaddress (ip/netmask_bitflag) into ip and netmask
  input="$1"
  ip="${input%/*}"
  cidr="${input#*/}"
  b=$((0xffffffff ^ ((1 << (32 - cidr)) - 1)))
  netmask=$(printf "%d.%d.%d.%d" $((b>>24&255)) $((b>>16&255)) $((b>>8&255)) $((b&255)))
  echo "ip=$ip netmask=$netmask"
}


# Collect data using process substitution (avoids losing variable state)
while read -r iface; do
    type=$(nmcli -g GENERAL.TYPE device show "$iface" 2>/dev/null)
    conn=$(nmcli -g GENERAL.CONNECTION device show "$iface" 2>/dev/null)
    ip_full=$(nmcli -g IP4.ADDRESS device show "$iface" 2>/dev/null)
    vendor=$(udevadm info "/sys/class/net/$iface" 2>/dev/null | grep -i 'ID_VENDOR_FROM_DATABASE=' | cut -d= -f2 | cut -d' ' -f1)
    model=$(udevadm info "/sys/class/net/$iface" 2>/dev/null | grep -i 'ID_MODEL=' | cut -d= -f2 | cut -d' ' -f1)

    [ -z "$vendor" ] && vendor="Unknown"
    [ -z "$model" ] && model=""
    [ -z "$type" ] && type="unknown"
    [ -z "$conn" ] && conn="unmanaged"

    IFS='|' read -ra cidrs <<< "$ip_full"
    count=${#cidrs[@]}
    for idx in "${!cidrs[@]}"; do
      trimmed=$(echo "${cidrs[$idx]}" | xargs)  # xargs trims leading/trailing whitespace
      eval $(parse_ip_cidr "$trimmed")

      if [ "$idx" -eq 0 ]; then
        vendors+=("$vendor")
        models+=("$model")
        types+=("$type")
        ips+=("$ip")
        netmasks+=("$netmask")
        conns+=("$conn")
        ifaces+=("$iface")
      else
        vendors+=("")
        models+=("")
        types+=("")
        ips+=("$ip")
        netmasks+=("$netmask")
        conns+=("")
        ifaces+=("")
      fi
    done


done < <(
    ifconfig | awk '
    /^[a-zA-Z0-9]/ { iface=$1; sub(":", "", iface) }
    /inet / && $2 != "127.0.0.1" {
        print iface
    }'
)

# Calculate max widths
max_vendor_len=15; max_model_len=20; max_type_len=15; max_iface_len=15; max_ip_len=18; max_mask_len=18; max_conn_len=20
max_vendor=6; max_model=6; max_type=4; max_iface=5; max_ip=2; max_mask=7; max_conn=10
for i in "${!vendors[@]}"; do
    (( ${#vendors[i]} > max_vendor )) && max_vendor=${#vendors[i]}
    (( ${#models[i]} > max_model )) && max_model=${#models[i]}
    (( ${#types[i]} > max_type )) && max_type=${#types[i]}
    (( ${#ifaces[i]} > max_iface )) && max_iface=${#ifaces[i]}
    (( ${#ips[i]} > max_ip )) && max_ip=${#ips[i]}
    (( ${#netmasks[i]} > max_mask )) && max_mask=${#netmasks[i]}
    (( ${#conns[i]} > max_conn )) && max_conn=${#conns[i]}
done

# Adjust max widths to fit within defined limits
if [ $max_vendor -gt $max_vendor_len ]; then
    max_vendor=$max_vendor_len
fi
if [ $max_model -gt $max_model_len ]; then
    max_model=$max_model_len
fi
if [ $max_type -gt $max_type_len ]; then
    max_type=$max_type_len
fi
if [ $max_iface -gt $max_iface_len ]; then
    max_iface=$max_iface_len
fi
if [ $max_ip -gt $max_ip_len ]; then
    max_ip=$max_ip_len
fi
if [ $max_mask -gt $max_mask_len ]; then
    max_mask=$max_mask_len
fi
if [ $max_conn -gt $max_conn_len ]; then
    max_conn=$max_conn_len
fi

# Print aligned output
total_length=$(($max_vendor + $max_model + $max_type + $max_iface + $max_ip + $max_mask + $max_conn + 18))
term_width=$(($(tput cols) - 2))
if [ $total_length -gt $term_width ]; then
    shrink_by=$(($total_length - $term_width))
    if [ $max_model -gt $shrink_by ]; then
        max_model=$(($max_model - $shrink_by))
        max_model_len=$max_model
        total_length=$term_width
    else
        # If model can't absorb all, set to minimum and adjust total_length
        max_model=1
        max_model_len=1
        total_length=$(($total_length - ($max_model - 1)))
    fi
fi
printf -- '-%.0s' $(seq 1 $(($total_length + 2)))
echo
printf "| %-*s %-*s | %-*s | %-*s | %-*s | %-*s | %-*s |\n" \
      "$max_vendor" "Vendor" \
      "$max_model" "Model" \
      "$max_type" "Type" \
      "$max_iface" "IFace" \
      "$max_ip" "IP" \
      "$max_mask" "Netmask" \
      "$max_conn" "Connection"
printf '|'
printf -- '-%.0s' $(seq 1 $total_length)
printf '|'
echo
for i in "${!vendors[@]}"; do
  printf "| %-*s %-*s | %-*s | %-*s | %-*s | %-*s | %-*s |\n" \
        "$max_vendor" "${vendors[i]:0:$max_vendor_len}" \
        "$max_model" "${models[i]:0:$max_model_len}" \
        "$max_type" "${types[i]:0:$max_type_len}" \
        "$max_iface" "${ifaces[i]:0:$max_iface_len}" \
        "$max_ip" "${ips[i]:0:$max_ip_len}" \
        "$max_mask" "${netmasks[i]:0:$max_mask_len}" \
        "$max_conn" "${conns[i]:0:$max_conn_len}"
done
printf -- '-%.0s' $(seq 1 $(($total_length + 2)))
echo

