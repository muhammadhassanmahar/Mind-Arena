import os
from pydantic import BaseSettings


class Settings(BaseSettings):
    APP_NAME: str = "Puzzle Contest API"

    FIREBASE_PROJECT_ID: str = os.getenv("FIREBASE_PROJECT_ID", "")
    FIREBASE_CREDENTIAL_PATH: str = os.getenv("FIREBASE_CREDENTIAL_PATH", "")

    SECRET_KEY: str = os.getenv("SECRET_KEY", "supersecretkey")
    ALGORITHM: str = "HS256"

    DATABASE_URL: str = os.getenv(
        "DATABASE_URL",
        "sqlite:///./puzzle_contest.db"
    )


settings = Settings()