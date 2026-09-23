from fastapi import FastAPI

app = FastAPI(title="marketing-mix-model")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
