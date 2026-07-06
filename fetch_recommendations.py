import os
import json
import requests

login_url = "https://seasonal-job-matching-898a9d15a9e5.herokuapp.com/api/users/login"
password = "Password123!"
output_file = r"D:\Projects\Seasonal-job-matching-platform-mobile\recmmomendsForUsers.txt"

profiles_emails = {
    # "Abdelrahman Mashaal": "abdelrahmanmashaal@gmail.com",
    # "Abdelrahman Mohamed": "abdelrahman.moh984@gmail.com",
    # "Ahmed Bahig": "ahmedbahig2003@gmail.com",
    # "Ahmed Hossam": "ahmed.hossamnabih@gmail.com",
    # "Ahmed Ismail": "es-ahmed.ismael2026@alexu.edu.eg",
    # "Ahmed Nasser": "am26339@gmail.com",
    # "Ahmed Zaki": "ahmed525zaki@gmail.com",
    # "Baher Adawy": "baheradawy_new@gmail.com",
    # "Mariem Mohamed": "mariemmohamed1421@gmail.com",
    # "Moataz Fahmy": "motaz.fahmy.hassan@gmail.com",
    "Samia Hafez": "samia.hafez@example.com"
}

compiled_output = []

print("Starting to fetch recommended jobs...\n")

for name, email in profiles_emails.items():
    print(f"Logging in: {name}...")
    token = None
    user_id = None
    
    try:
        r = requests.post(login_url, json={"email": email, "password": password})
        if r.status_code == 200:
            data = r.json()
            token = data.get("token")
            user_id = data["user"]["id"]
            print(f" -> Login Success! User ID: {user_id}")
        else:
            print(f" -> Login Failed (Status {r.status_code}): {r.text}")
    except Exception as e:
        print(f" -> Login Exception: {e}")
        
    if not token or not user_id:
        print(f" -> Skipping recommendations for {name} due to auth failure.\n")
        compiled_output.append(f"==================================================\nUser: {name}\n==================================================\nAUTH FAILURE\n\n")
        continue
        
    headers = {
        "Authorization": f"Bearer {token}"
    }
    
    rec_url = f"https://seasonal-job-matching-898a9d15a9e5.herokuapp.com/api/users/{user_id}/recommended-jobs"
    print(f" -> Fetching recommendations...")
    try:
        r_rec = requests.get(rec_url, headers=headers)
        if r_rec.status_code == 200:
            print(" -> Recommendations retrieved successfully.")
            raw_data = r_rec.json()
            formatted_json = json.dumps(raw_data, ensure_ascii=False, indent=2)
            
            section = (
                f"==================================================\n"
                f"User: {name} (User ID: {user_id})\n"
                f"==================================================\n"
                f"{formatted_json}\n\n"
            )
            compiled_output.append(section)
        else:
            print(f" -> Failed to fetch (Status {r_rec.status_code}): {r_rec.text}")
            compiled_output.append(f"==================================================\nUser: {name} (User ID: {user_id})\n==================================================\nAPI ERROR (Status {r_rec.status_code}): {r_rec.text}\n\n")
    except Exception as e:
        print(f" -> Exception during fetch: {e}")
        compiled_output.append(f"==================================================\nUser: {name} (User ID: {user_id})\n==================================================\nEXCEPTION: {e}\n\n")
        
    print()

with open(output_file, "w", encoding="utf-8") as f:
    f.writelines(compiled_output)

print(f"Done! Written all consolidated recommendations to {output_file}")
