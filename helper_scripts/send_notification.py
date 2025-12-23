import requests

topic = "jacob_build_notification"
message = "Notification from Python"
requests.post(f"https://ntfy.sh/{topic}",
          data=message.encode(encoding='utf-8'))
