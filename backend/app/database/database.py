# app/database/database.py

from motor.motor_asyncio import AsyncIOMotorClient
from bson.objectid import ObjectId
from typing import Optional, Dict, Any

# ---------------- MongoDB Connection ---------------- #
MONGO_DETAILS = "mongodb://localhost:27017"  # Change this to your MongoDB URI
DATABASE_NAME = "puzzle_contest_db"          # Database name

# MongoDB client and database
client = AsyncIOMotorClient(MONGO_DETAILS)
db = client[DATABASE_NAME]  # ✅ Exporting 'db' object for services

# Collections
users_collection = db.get_collection("users")
contests_collection = db.get_collection("contests")
results_collection = db.get_collection("results")
wallets_collection = db.get_collection("wallets")


# ---------------- Helper Functions ---------------- #

def user_helper(user: Dict[str, Any]) -> dict:
    """Convert a user document to a dictionary"""
    return {
        "id": str(user.get("_id")),
        "uid": user.get("uid", ""),
        "email": user.get("email", ""),
        "name": user.get("name", ""),
        "created_at": user.get("created_at")
    }


def contest_helper(contest: Dict[str, Any]) -> dict:
    """Convert a contest document to a dictionary"""
    return {
        "id": str(contest.get("_id")),
        "title": contest.get("title", ""),
        "puzzle_image": contest.get("puzzle_image", ""),
        "user_id": contest.get("user_id", ""),
        "created_at": contest.get("created_at")
    }


def result_helper(result: Dict[str, Any]) -> dict:
    """Convert a result document to a dictionary"""
    return {
        "id": str(result.get("_id")),
        "contest_id": result.get("contest_id", ""),
        "score": result.get("score", 0),
        "created_at": result.get("created_at")
    }


def wallet_helper(wallet: Dict[str, Any]) -> dict:
    """Convert a wallet document to a dictionary"""
    return {
        "id": str(wallet.get("_id")),
        "user_id": wallet.get("user_id", ""),
        "balance": wallet.get("balance", 0.0),
        "created_at": wallet.get("created_at")
    }