from typing import Optional, List
from datetime import datetime
from beanie import Document, Indexed
from pydantic import BaseModel, Field


# ===== User Model =====
class User(Document):
    email: Indexed(str, unique=True)
    name: str
    password_hash: str
    created_at: datetime = Field(default_factory=datetime.utcnow)
    is_active: bool = True

    class Settings:
        name = "users"

    class Config:
        schema_extra = {
            "example": {
                "email": "user@example.com",
                "name": "John Doe",
                "password_hash": "hashed_password",
                "is_active": True,
            }
        }


# ===== Contest Model =====
class Contest(Document):
    title: str
    description: Optional[str]
    puzzle_image: Optional[str]
    start_time: datetime
    end_time: datetime
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Settings:
        name = "contests"

    class Config:
        schema_extra = {
            "example": {
                "title": "Daily Puzzle",
                "description": "Solve the 3x3 puzzle",
                "puzzle_image": "https://example.com/puzzle.jpg",
                "start_time": "2026-03-10T00:00:00Z",
                "end_time": "2026-03-10T23:59:59Z",
            }
        }


# ===== Wallet Model =====
class Wallet(Document):
    user_id: str
    balance: float = 0.0
    currency: str = "USD"
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Settings:
        name = "wallets"

    class Config:
        schema_extra = {
            "example": {
                "user_id": "user_id_here",
                "balance": 100.0,
                "currency": "USD",
            }
        }


# ===== Leaderboard Model =====
class Leaderboard(Document):
    user_id: str
    contest_id: str
    score: int
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Settings:
        name = "leaderboards"

    class Config:
        schema_extra = {
            "example": {
                "user_id": "user_id_here",
                "contest_id": "contest_id_here",
                "score": 150,
            }
        }