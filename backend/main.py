from datetime import datetime
from typing import List

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel


class HealthResponse(BaseModel):
    status: str
    timestamp: str


class SourceSummary(BaseModel):
    title: str
    url: str
    publisher: str


class ResultSummary(BaseModel):
    title: str
    prompt: str
    infographic_url: str
    article_excerpt: str
    sources: List[SourceSummary]


app = FastAPI(
    title="Research Infographic Studio API",
    description="Minimal API for the Research Infographic Studio proof of concept.",
    version="0.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["*"],
)


@app.get("/api/v1/health", response_model=HealthResponse)
async def health_check() -> HealthResponse:
    return HealthResponse(status="ok", timestamp=datetime.utcnow().isoformat() + "Z")


@app.get("/api/v1/demo-result", response_model=ResultSummary)
async def demo_result() -> ResultSummary:
    return ResultSummary(
        title="Climate Action Progress",
        prompt="Summarize global climate action since 2020",
        infographic_url="/assets/infographic-climate.png",
        article_excerpt="Global climate action has accelerated across renewable investments, EV adoption, and policy commitments.",
        sources=[
            SourceSummary(
                title="COP26 Climate Summit Recap",
                url="https://www.example.com/cop26",
                publisher="Global Climate Times",
            ),
            SourceSummary(
                title="Renewable Energy Investment Trends",
                url="https://www.example.com/renewables",
                publisher="Energy Analytics",
            ),
        ],
    )
