import json

# Paths to the input JSON and output GD script
quests_json_path = "data\world\quests.json"
quest_signals_gd_path = "scripts/global/QuestSignals.gd"

def add_quest_signals(quests_json_path, quest_signals_gd_path):
    # Load quests.json
    with open(quests_json_path, "r") as file:
        quests_data = json.load(file)

    # Extract quest signals
    quest_signals = []
    for quest_key, quest_details in quests_data["quests"].items():
        if "signal" in quest_details:
            quest_signals.append(f"signal {quest_details['signal']}")

    # Read the existing GD script
    with open(quest_signals_gd_path, "r") as file:
        existing_gd_content = file.readlines()

    # Append new signals, avoiding duplicates
    existing_signals = {line.strip() for line in existing_gd_content if line.strip().startswith("signal ")}
    new_signals = [signal for signal in quest_signals if signal not in existing_signals]

    # Write updated GD script back
    with open(quest_signals_gd_path, "w") as file:
        file.writelines(existing_gd_content)  # Keep existing content
        if new_signals:
            file.write("\n")  # Separate with a new line
            file.write("\n".join(new_signals) + "\n")  # Add new signals

    print(f"Added {len(new_signals)} new signals to {quest_signals_gd_path}.")

# Run the function
add_quest_signals(quests_json_path, quest_signals_gd_path)
