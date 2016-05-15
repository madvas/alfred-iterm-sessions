on alfred_script(q)
set params to theSplit(q, " ") of me
set terminalIndex to first item of params as integer
set sessionIndex to second item of params as integer

tell application "iTerm"
	set theTerminal to window terminalIndex
	tell theTerminal
		select
		activate
		tell tab sessionIndex
				select			
		end tell
	end tell
end tell
end alfred_script


on theSplit(theString, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	set AppleScript's text item delimiters to oldDelimiters
	return theArray
end theSplit

