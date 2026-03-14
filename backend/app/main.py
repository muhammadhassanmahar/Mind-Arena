from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from motor.motor_asyncio import AsyncIOMotorClient
from beanie import init_beanie

from app.core.config import settings
from app.models.models import UserModel, ContestModel, WalletModel, LeaderboardModel
from app.routes import auth_routes, contest_routes, wallet_routes, leaderboard_routes

app = FastAPI(
    title=settings.APP_NAME,
    version="1.0.0",
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include Routers
app.include_router(auth_routes.router)
app.include_router(contest_routes.router)
app.include_router(wallet_routes.router)
app.include_router(leaderboard_routes.router)


@app.get("/")
async def root():
    return {"message": "Puzzle Contest Backend Running"}


@app.get("/health")
async def health_check():
    return {"status": "ok"}


# MongoDB / Beanie Initialization
@app.on_event("startup")
async def app_init():
    """
    Initialize crucial application services
    """

    # MongoDB Client
    client = AsyncIOMotorClient(settings.MONGO_URI)
    db = client[settings.MONGO_DB_NAME]

    # Initialize Beanie with your document models
    await init_beanie(
        database=db,
        document_models=[
            UserModel,
            ContestModel,
            WalletModel,
            LeaderboardModel
        ]
    )

    print("✅ Database initialized successfully")