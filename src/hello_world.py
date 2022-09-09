from tenacity import retry

def hello_world(name: str = None):
    if not name:
        name = "world"
    result = f"Hello, {name}"
    print(result)
    return result
