from fastapi import Header, HTTPException
from app.core.firebase import verify_firebase_token


async def get_current_user(authorization: str = Header(None)):
    if authorization is None:
        raise HTTPException(
            status_code=401,
            detail="Authorization header missing"
        )

    try:
        token = authorization.split(" ")[1]
    except Exception:
        raise HTTPException(
            status_code=401,
            detail="Invalid authorization format"
        )

    try:
        decoded_token = verify_firebase_token(token)
        return decoded_token
    except Exception:
        raise HTTPException(
            status_code=401,
            detail="Invalid Firebase token"
        )