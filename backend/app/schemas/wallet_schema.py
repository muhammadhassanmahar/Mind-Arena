from motor.motor_asyncio import AsyncIOMotorClient

# MongoDB connection details
MONGO_DETAILS = "mongodb://localhost:27017"
DATABASE_NAME = "puzzle_contest_db"

# MongoDB client and database
client = AsyncIOMotorClient(MONGO_DETAILS)
database = client[DATABASE_NAME]

# Collections
users_collection = database.get_collection("users")
contests_collection = database.get_collection("contests")
results_collection = database.get_collection("results")
wallets_collection = database.get_collection("wallets")


# Helper to get database (for LeaderboardService)
def get_db():
    return database


# ---------------- Helper functions ---------------- #

def user_helper(user: dict) -> dict:
    return {
        "id": str(user.get("_id")),
        "uid": user.get("uid", ""),
        "email": user.get("email", ""),
        "name": user.get("name", ""),
        "created_at": user.get("created_at")
    }


def contest_helper(contest: dict) -> dict:
    return {
        "id": str(contest.get("_id")),
        "title": contest.get("title", ""),
        "puzzle_image": contest.get("puzzle_image", ""),
        "user_id": contest.get("user_id", ""),
        "created_at": contest.get("created_at")
    }


def result_helper(result: dict) -> dict:
    return {
        "id": str(result.get("_id")),
        "contest_id": result.get("contest_id", ""),
        "score": result.get("score", 0),
        "created_at": result.get("created_at")
    }


def wallet_helper(wallet: dict) -> dict:
    return {
        "id": str(wallet.get("_id")),
        "user_id": wallet.get("user_id", ""),
        "balance": wallet.get("balance", 0.0),
        "created_at": wallet.get("created_at")
    }