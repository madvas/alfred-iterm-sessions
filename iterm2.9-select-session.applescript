set q to "1 1"

set theQuery to "{query}"
set params to theSplit(theQuery, " ") of me
set terminalIndex to first item of params as integer
set tabIndex to second item of params as integer
set sessionIndex to third item of params as integer

tell application "iTerm"
	if (terminalIndex = -1)
		set newWindow to (create window with default profile)
	else
		set theWindow to window terminalIndex
		tell theWindow
			select
			activate
			if (tabIndex = -1)
				set newTab to (create tab with default profile)
			else
				tell tab tabIndex
					select
					activate
					tell session sessionIndex to select
				end tell
			end if
		end tell
	end if
end tell

on theSplit(theString, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	set AppleScript's text item delimiters to oldDelimiters
	return theArray
end theSplit
