def hello_world(name: str = None):
    if not name:
        name = "world"
    result = f"Hello, {name}"
    print(result)
    return result

hello_world()