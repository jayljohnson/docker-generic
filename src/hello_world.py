from tenacity import retry

def hello_world(name: str = None):
    if not name:
        name = "world"
    result = f"Hello, {name}"
    print(result)
    return result

hello_world()

@retry()
def simulate_failure():
    simulate_failure.count += 1
    # Fail every 3rd call
    if simulate_failure.count % 3 == 0:
        raise RuntimeError(f"A simulated error has happened.  {simulate_failure.count}")
    else:
        print(f"Call number: {simulate_failure.count}")
        return simulate_failure.count
simulate_failure.count = 0

def hello_retries():
    for attempt in range(0,10):
        call_number = simulate_failure()
        hello_world(name=attempt)
        print(f"Attempt made: {attempt}, call number {call_number}")

hello_retries()
