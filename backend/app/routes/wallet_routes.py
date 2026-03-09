from fastapi import APIRouter, HTTPException, Depends
from typing import List
from ..services.wallet_service import WalletService
from ..schemas.wallet_schema import WalletOut, WalletUpdate
from ..services.auth_service import AuthService

router = APIRouter(prefix="/wallet", tags=["Wallet"])


@router.get("/", response_model=WalletOut)
async def get_user_wallet(current_user=Depends(AuthService.get_current_user)):
    """
    Get current user's wallet details
    """
    wallet = await WalletService.get_wallet_by_user(current_user.id)
    return wallet


@router.post("/add", response_model=WalletOut)
async def add_funds(amount: float, current_user=Depends(AuthService.get_current_user)):
    """
    Add funds to user's wallet
    """
    if amount <= 0:
        raise HTTPException(status_code=400, detail="Amount must be greater than zero")
    wallet = await WalletService.add_funds(current_user.id, amount)
    return wallet


@router.post("/withdraw", response_model=WalletOut)
async def withdraw_funds(amount: float, current_user=Depends(AuthService.get_current_user)):
    """
    Withdraw funds from user's wallet
    """
    if amount <= 0:
        raise HTTPException(status_code=400, detail="Amount must be greater than zero")
    wallet = await WalletService.withdraw_funds(current_user.id, amount)
    if not wallet:
        raise HTTPException(status_code=400, detail="Insufficient balance")
    return wallet