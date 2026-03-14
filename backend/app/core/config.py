# app/core/config.py
import os
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    APP_NAME: str = "Puzzle Contest API"

    # ===== Firebase =====
    FIREBASE_PROJECT_ID: str = os.getenv("FIREBASE_PROJECT_ID", "")
    FIREBASE_CREDENTIAL_PATH: str = os.getenv("FIREBASE_CREDENTIAL_PATH", "")

    # ===== Security =====
    SECRET_KEY: str = os.getenv("SECRET_KEY", "supersecretkey")
    ALGORITHM: str = "HS256"

    # ===== MongoDB Atlas =====
    MONGO_URI: str = os.getenv(
        "MONGO_URI",
        "mongodb+srv://immaharhasaan_db_user:G2ufOtP7tQt4v7Tr@cluster0.xyatjhd.mongodb.net/?retryWrites=true&w=majority"
    )

    MONGO_DB_NAME: str = os.getenv(
        "MONGO_DB_NAME",
        "mind_arena_db"
    )

    # ===== Optional SQLite (backup / legacy) =====
    DATABASE_URL: str = os.getenv(
        "DATABASE_URL",
        "sqlite:///./puzzle_contest.db"
    )

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()