from typing import List
from bson import ObjectId
from fastapi import HTTPException

from ..database.database import db
from ..schemas.wallet_schema import WalletCreate, WalletOut

WALLET_COLLECTION = db.get_collection("wallets")


async def create_wallet(wallet_data: WalletCreate) -> WalletOut:
    # Check if wallet already exists for the user
    existing = await WALLET_COLLECTION.find_one({"user_id": wallet_data.user_id})
    if existing:
        raise HTTPException(status_code=400, detail="Wallet already exists for this user")

    wallet_dict = wallet_data.dict()
    result = await WALLET_COLLECTION.insert_one(wallet_dict)
    wallet_dict["id"] = str(result.inserted_id)
    return WalletOut(**wallet_dict)


async def get_wallet(user_id: str) -> WalletOut:
    wallet = await WALLET_COLLECTION.find_one({"user_id": user_id})
    if not wallet:
        raise HTTPException(status_code=404, detail="Wallet not found")
    wallet["id"] = str(wallet["_id"])
    return WalletOut(**wallet)


async def add_funds(user_id: str, amount: float) -> WalletOut:
    wallet = await get_wallet(user_id)
    new_balance = wallet.balance + amount
    await WALLET_COLLECTION.update_one(
        {"_id": ObjectId(wallet.id)},
        {"$set": {"balance": new_balance}}
    )
    wallet.balance = new_balance
    return wallet


async def withdraw_funds(user_id: str, amount: float) -> WalletOut:
    wallet = await get_wallet(user_id)
    if wallet.balance < amount:
        raise HTTPException(status_code=400, detail="Insufficient funds")
    new_balance = wallet.balance - amount
    await WALLET_COLLECTION.update_one(
        {"_id": ObjectId(wallet.id)},
        {"$set": {"balance": new_balance}}
    )
    wallet.balance = new_balance
    return wallet


async def list_wallets() -> List[WalletOut]:
    wallets_cursor = WALLET_COLLECTION.find()
    wallets = []
    async for wallet in wallets_cursor:
        wallet["id"] = str(wallet["_id"])
        wallets.append(WalletOut(**wallet))
    return wallets