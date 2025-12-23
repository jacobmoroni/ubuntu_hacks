import smtplib
from email.mime.text import MIMEText

# === CONFIGURATION ===
gmail_user = 'novatori.llc@gmail.com'
gmail_pass = 'kjux hqem hvmn gkcm'  # Use an App Password if you have 2FA enabled
recipient_number = '7145985938'
carrier_gateway = 'tmomail.net'  # Change based on carrier
message_body = 'Hello from Python via email-to-SMS!'

# === CONSTRUCT EMAIL ===
# to_address = f'{recipient_number}@{carrier_gateway}'
to_address = "jacobmoroniolson@gmail.com" 
msg = MIMEText(message_body)
msg['From'] = gmail_user
msg['To'] = to_address
msg['Subject'] = ''  # SMS ignores subject lines

# === SEND ===
try:
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
        smtp.login(gmail_user, gmail_pass)
        smtp.sendmail(gmail_user, to_address, msg.as_string())
        print("Text sent successfully!")

except Exception as e:
    print(f"Error: {e}")

