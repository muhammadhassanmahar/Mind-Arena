from typing import List
from bson import ObjectId
from fastapi import HTTPException
from datetime import datetime

from ..database.database import db
from ..schemas.wallet_schema import WalletCreate, WalletOut


class WalletService:

    WALLET_COLLECTION = db.get_collection("wallets")

    @staticmethod
    async def create_wallet(wallet_data: WalletCreate) -> WalletOut:
        existing = await WalletService.WALLET_COLLECTION.find_one(
            {"user_id": wallet_data.user_id}
        )
        if existing:
            raise HTTPException(
                status_code=400,
                detail="Wallet already exists for this user"
            )

        wallet_dict = wallet_data.model_dump()
        wallet_dict["created_at"] = datetime.utcnow()

        result = await WalletService.WALLET_COLLECTION.insert_one(wallet_dict)

        wallet_dict["id"] = str(result.inserted_id)

        return WalletOut(**wallet_dict)

    @staticmethod
    async def get_wallet(user_id: str) -> WalletOut:
        wallet = await WalletService.WALLET_COLLECTION.find_one({"user_id": user_id})

        if not wallet:
            raise HTTPException(
                status_code=404,
                detail="Wallet not found"
            )

        wallet["id"] = str(wallet["_id"])

        return WalletOut(**wallet)

    @staticmethod
    async def add_funds(user_id: str, amount: float) -> WalletOut:
        wallet = await WalletService.get_wallet(user_id)

        new_balance = wallet.balance + amount

        await WalletService.WALLET_COLLECTION.update_one(
            {"_id": ObjectId(wallet.id)},
            {"$set": {"balance": new_balance}}
        )

        wallet.balance = new_balance
        return wallet

    @staticmethod
    async def withdraw_funds(user_id: str, amount: float) -> WalletOut:
        wallet = await WalletService.get_wallet(user_id)

        if wallet.balance < amount:
            raise HTTPException(
                status_code=400,
                detail="Insufficient funds"
            )

        new_balance = wallet.balance - amount

        await WalletService.WALLET_COLLECTION.update_one(
            {"_id": ObjectId(wallet.id)},
            {"$set": {"balance": new_balance}}
        )

        wallet.balance = new_balance
        return wallet

    @staticmethod
    async def list_wallets() -> List[WalletOut]:

        wallets_cursor = WalletService.WALLET_COLLECTION.find()

        wallets = []

        async for wallet in wallets_cursor:
            wallet["id"] = str(wallet["_id"])
            wallets.append(WalletOut(**wallet))

        return wallets