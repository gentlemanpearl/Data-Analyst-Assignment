def remove_duplicates(input_string):
    result = ""
    for char in input_string:
        if char not in result:
            result += char
            
    return result

if __name__ == "__main__":
    test_cases = ["hello world", "programming", "aabbcc", "abc"]
    
    print("Removing duplicates from strings using a loop:\n" + "-"*45)
    for tc in test_cases:
        print(f"Original: '{tc}' -> Unique: '{remove_duplicates(tc)}'")
