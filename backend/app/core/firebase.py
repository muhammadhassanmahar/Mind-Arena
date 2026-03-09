import firebase_admin
from firebase_admin import credentials, auth
from app.core.config import settings

firebase_app = None

def initialize_firebase():
    global firebase_app

    if not firebase_admin._apps:
        cred = credentials.Certificate(settings.FIREBASE_CREDENTIAL_PATH)
        firebase_app = firebase_admin.initialize_app(cred)

    return firebase_app


def verify_firebase_token(id_token: str):
    try:
        decoded_token = auth.verify_id_token(id_token)
        return decoded_token
    except Exception as e:
        raise Exception("Invalid Firebase Token")