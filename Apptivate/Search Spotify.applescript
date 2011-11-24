-- Search in Spotify
tell application "Spotify"
	activate
	delay 0.2
	tell application "System Events"
		keystroke "f" using {command down, option down}
	end tell
end tell