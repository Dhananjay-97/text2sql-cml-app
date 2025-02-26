import os
import socket

def validate():
    print("Validating environment variables...")
    HR = os.environ.get("OPENAI_CHAT_MODEL") or None
    BANK = os.environ.get("BANK") or None
    MUSIC = os.environ.get("MUSIC") or None
    WATERFALL = os.environ.get("WATERFALL") or None
    OPENAI_API_KEY = os.environ.get("OPENAI_API_KEY") or None
    OPENAI_CHAT_MODEL = os.environ.get("OPENAI_CHAT_MODEL") or None

    if OPENAI_API_KEY is None:
            print("ERROR: missing required environment variables: OPENAI_API_KEY")
            exit(1)

validate()
