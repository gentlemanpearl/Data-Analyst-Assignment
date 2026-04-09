def convert_minutes(total_minutes):
    hours = total_minutes // 60
    minutes = total_minutes % 60
    
    if hours == 0:
        return f"{minutes} minutes"
    elif minutes == 0:
        return f"{hours} {'hr' if hours == 1 else 'hrs'}"
    else:
        return f"{hours} {'hr' if hours == 1 else 'hrs'} {minutes} minutes"

if __name__ == "__main__":
    test_cases = [130, 110, 60, 45, 121]
    
    print("Converting minutes to human readable format:\n" + "-"*40)
    for tc in test_cases:
        print(f"{tc} becomes \"{convert_minutes(tc)}\"")
