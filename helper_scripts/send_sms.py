import os
from pathlib import Path
from mailgun.client import Client

key: str = os.environ["MAILGUN_API_KEY"]
domain: str = os.environ["MAILGUN_DOMAIN"]
client: Client = Client(auth=("api", key))


def post_message() -> None:
    # Messages
    # POST /<domain>/messages
    data = {
        "from": os.getenv("MESSAGES_FROM", "postmaster@sandboxd43920e0e97d497a8758edfd28d8c569.mailgun.org"),
        "to": os.getenv("MESSAGES_TO", "jacobmoroniolson@gmail.com"),
        "subject": "testing",
        "text": "Trying this ",
        "o:tag": "Python test",
    }

    req = client.messages.create(data=data, domain=domain)
    print(req.json())


post_message()
