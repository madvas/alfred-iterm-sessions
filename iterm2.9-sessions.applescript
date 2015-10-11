set theQuery to ""

set xmlResult to "<?xml version=\"1.0\"?>
<items>
"
set sessionsList to {}

tell application "iTerm"
	set i to 0
	repeat with theTerm in windows
		set i to i + 1
		set j to 0
		tell theTerm
			repeat with aTab in tabs
				set j to j + 1
				set k to 0
				tell aTab
					repeat with aSession in sessions
						set k to k + 1
						tell aSession
							if length of theQuery > 0 then
								if theQuery is in name then
									set xmlResult to addSessionItem(name, id, i, j, k, xmlResult) of me
								end if
							else
								set xmlResult to addSessionItem(name, id, i, j, k, xmlResult) of me
							end if
						end tell
					end repeat
				end tell
			end repeat
		end tell
	end repeat
	set xmlResult to addSessionItem("Create new tab in window " & theQuery, "new_tab", theQuery, -1, 1, xmlResult) of me
	set xmlResult to addSessionItem("Create new window", "new_win", -1, 1, 1, xmlResult) of me
end tell

set xmlResult to xmlResult & "</items>"
xmlResult

on addSessionItem(sessionName, sessionId, windowIndex, tabIndex, sessionIndex, xmlResult)
	set sessionName to escapeString(sessionName)
	set res to xmlResult & "<item uid=\""
	set res to res & sessionId & "\""
	set res to res & " arg=\"" & windowIndex & " " & tabIndex & " " & sessionIndex & "\""
	set res to res & " autocomplete=\"" & sessionName & "\""
	set res to res & ">"
	set res to res & "<icon>icon.png</icon>"
	set res to res & "<title>" & sessionName & "</title>"
	set res to res & "<subtitle>window: " & windowIndex & ", tab: " & tabIndex & ", session: " & sessionIndex & "</subtitle>"
	set res to res & "</item>
	"
	return res
end addSessionItem

on escapeString(toEscape)
	set res to replaceChars(toEscape, "\"", "&quot;")
	set res to replaceChars(res, "'", "&apos;")
	set res to replaceChars(res, "&", "&amp;")
	set res to replaceChars(res, ">", "&gt;")
	set res to replaceChars(res, "<", "&lt;")
	return res
end escapeString

on replaceChars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replaceChars
