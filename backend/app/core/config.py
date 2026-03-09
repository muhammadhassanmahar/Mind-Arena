# app/core/config.py
import os
from pydantic_settings import BaseSettings


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

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()