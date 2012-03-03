-- WARNING: This script uses the clipboard.
-- This script is made to be used with TaskPaper. I took bits and pieces here and there to emulate the behavior of the Things "clipping" behavior when opening the Quick Entry panel.
-- IMPORTANT: You should modify lines 15-16 to your own keyboard shortcut for the Quick Entry panel in TaskPaper.
-- And some warning: You might also have to uncomment the lines 121-124 if the Quick Entry panel doesn't get the focus when you trigger this script.
-- 
-- So far, the script covers these cases:
-- Apple Mail: Entry with the sender's name, the email's subject and a link to the email.
-- Finder: Link to the file as a unix file path
-- Safari & Chrome & WebKit: Url of the current tab-- 
-- iTunes: Entry with "Artist - Song title (Album title)"
-- Clipboard: I left some commented out code, that attempted to grab the selection as text, but it never worked.
-- Otherwise: Open the Quick Entry Panel

-- EDIT YOUR SHORTCUT HERE
set _shortcutModifier to {control down, option down, shift down, command down}
set _shortcutKey to space

set found to false --If something has been copied. If not the Quick Entry window is not opened
set _app to GetCurrentApp()

--if Mail, get sender and link to mail
if _app is "Mail" then
	tell application "Mail"
		set theSelection to the selection
		repeat with theMessage in theSelection
			set theSubject to subject of theMessage
			--set theDate to date received of theMessage 
			# Use this line if you also want the sender's email address
			-- set theName to sender of theMessage
			set theName to extract name from sender of theMessage
			set {tid, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "%"}
			#set theItems to text items of theMessage's message id 
			set theItems to theMessage's message id
			set theItems to text items of theItems
			set AppleScript's text item delimiters to "%25"
			set messageURL to theItems as rich text
			set AppleScript's text item delimiters to tid
			set messageURL to "message://%3C" & messageURL & "%3E"
			# Edit this line with the items you want.
			set the clipboard to theName & " Ñ " & theSubject & "
	" & messageURL
			set found to true
		end repeat
	end tell
	
	-- If Finder, get file path	
else if _app is "Finder" then
	set thisFile to selection of application "Finder" as alias
	set filePath to (POSIX path of thisFile) as text
	set filePath to urlencode(filePath)
	set filePath to "file://" & filePath
	set the clipboard to filePath
	set found to true
	
	--If Safari or WebKit, get URL	
else if _app is in {"Safari", "WebKit"} then
	using terms from application "Safari"
		tell application _app
			set theURL to (URL of front document as string)
			--set thePageTitle to (name of front document as string)
			set the clipboard to theURL
			set found to true
		end tell
	end using terms from
	--If Chrome, get URL
else if _app is "Chrome" or _app is "Google Chrome" then
	tell application "Google Chrome"
		set theURL to (URL of active tab of first window)
		set the clipboard to theURL
		set found to true
	end tell
	--If iTunes, get the  Artist - Title (Album)
else if _app is "iTunes" then
	set theString to ""
	tell application "iTunes"
		set theSelection to selection
		repeat with theTrack in theSelection
			set theArtist to artist of theTrack
			set theTitle to name of theTrack
			set theAlbum to album of theTrack
			set theString to theArtist & " - " & theTitle & " (" & theAlbum & ")
"
		end repeat
		set the clipboard to theString
		set found to true
	end tell
	
	--Will try to grab the selection as text. (Doesn't quite work.)
else
	(*
set curClipboard to the clipboard
	tell application "System Events" to (keystroke "c" using {command down})
	set theSelection to the clipboard as text
	if (theSelection is not curClipboard) then
		set the clipboard to theSelection
		set found to true
	end if
*)
end if

--Open quick entry panel, paste as a comment and put cursor to enter task
if found then
	tell application "System Events"
		-- 
		delay 0.3
		keystroke _shortcutKey using _shortcutModifier
		delay 0.2
		keystroke return using {command down, control down}
		keystroke tab
		keystroke "v" using command down
		delay 0.2
		key code {123, 126} using command down -- left and up
		key code {124} using command down -- right
	end tell
	
	-- EDIT: You may have to uncomment this block if the focus is not set to the Quick Entry panel.
	--tell application "TaskPaper"
	--activate
	--end tell
	
	-- If no special action can be taken, open the quick entry panel anyway	
else
	tell application "System Events"
		keystroke _shortcutKey using _shortcutModifier
	end tell
end if

on GetCurrentApp()
	tell application "System Events"
		get short name of first process whose frontmost is true
	end tell
end GetCurrentApp

on urlencode(x)
	set TheCode to do shell script "python -c 'import sys, urllib; print urllib.quote(sys.argv[1])' " & quoted form of (x)
	return TheCode
end urlencode

on replaceText(find, replace, someText)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set someText to text items of someText
	set text item delimiters of AppleScript to replace
	set someText to "" & someText
	set text item delimiters of AppleScript to prevTIDs
	return someText
end replaceText