#!/usr/bin/env python

import dbus
import json
import sys
import subprocess
import time

def get_player_property(player_interface, prop):
    try:
        return player_interface.Get("org.mpris.MediaPlayer2.Player", prop)
    except dbus.exceptions.DBusException:
        return None

def get_seconds(microseconds):
    return microseconds // 1000000 if isinstance(microseconds, int) else None
    
def get_all_mpris_data():
    session_bus = dbus.SessionBus()
    bus_names = session_bus.list_names()

    players = []
    positions = {}

    for name in bus_names:
        if "org.mpris.MediaPlayer2." in name:
            try:
                player = session_bus.get_object(name, "/org/mpris/MediaPlayer2")
                player_interface = dbus.Interface(player, "org.freedesktop.DBus.Properties")
                metadata = get_player_property(player_interface, "Metadata")
                playback_status = get_player_property(player_interface, "PlaybackStatus")

                if playback_status != "Stopped":
                    shuffle = bool(get_player_property(player_interface, "Shuffle"))
                    loop_status = get_player_property(player_interface, "LoopStatus")
                    can_go_next = bool(get_player_property(player_interface, "CanGoNext"))
                    can_go_previous = bool(get_player_property(player_interface, "CanGoPrevious"))
                    can_play = bool(get_player_property(player_interface, "CanPlay"))
                    can_pause = bool(get_player_property(player_interface, "CanPause"))
                    volume = get_player_property(player_interface, "Volume")
                    volume = round(volume, 2) * 100 if volume is not None else None
                    length = get_seconds(metadata.get("mpris:length", None))

                    data = {
                        "name": name.replace("org.mpris.MediaPlayer2.", ""),
                        "title": metadata.get("xesam:title", "Unknown"),
                        "artist": metadata.get("xesam:artist", ["Unknown"])[0],
                        "album": metadata.get("xesam:album", "Unknown"),
                        "artUrl": metadata.get("mpris:artUrl", None),
                        "status": playback_status,
                        "length": length,
                        "shuffle": shuffle,
                        "loop": loop_status,
                        "volume": volume,
                        "canGoNext": can_go_next,
                        "canGoPrevious": can_go_previous,
                        "canPlay": can_play,
                        "canPause": can_pause,
                    }

                    players.append(data)
                    
                    position = get_seconds(get_player_property(player_interface, "Position"))
                    positions[data["name"]] = {"position": position}

            except dbus.exceptions.DBusException:
                pass

    return players, positions
    
if __name__ == "__main__":
    prev_positions = None
    prev_players = None
    
    while True:
        players, positions = get_all_mpris_data()
        
        if players != prev_players:
            prev_players = players
            sys.stdout.write(json.dumps(players) + "\n")
            sys.stdout.flush()
    
        if positions != prev_positions:
            prev_positions = positions
            subprocess.run(["eww", "update", f"mpris_positions={json.dumps(positions)}"])
        time.sleep(0.1)