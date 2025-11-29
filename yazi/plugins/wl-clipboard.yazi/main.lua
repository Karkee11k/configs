-- Meant to run at async context. (yazi system-clipboard)

local selected_or_hovered = ya.sync(function()
	local tab, paths = cx.active, {}
	for _, u in pairs(tab.selected) do
		paths[#paths + 1] = tostring(u)
	end
	if #paths == 0 and tab.current.hovered then
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)
    
local get_cwd = ya.sync(function()
    return tostring(cx.active.current.cwd)
end)

function copy()
    ya.manager_emit("escape", { visual = true })
    local urls = selected_or_hovered()

    if #urls == 0 then
        return ya.notify({ title = "System Clipboard", content = "No file selected", level = "warn", timeout = 5 })
    end

    -- ya.notify({ title = #urls, content = table.concat(urls, " "), level = "info", timeout = 5 })

    -- format the urls for `text/uri-list` specification
    local function encode_uri(uri)
        return uri:gsub("([^%w%-%._~:/])", function(c)
            return string.format("%%%02x", string.byte(c))
        end)
    end

    local file_list_formatted = ""
    for _, path in ipairs(urls) do
        -- each file path must be uri-encoded and prefixed with "file://"
        file_list_formatted = file_list_formatted .. "file://" .. encode_uri(path) .. "\r\n"
    end

    local status, err =
        Command("wl-copy"):arg("--type"):arg("text/uri-list"):arg(file_list_formatted):spawn():wait()

    if status or status.succes then
        ya.notify({
            title = "System Clipboard",
            content = "Successfully copied the file(s) to system clipboard",
            level = "info", timeout = 5,
        })
    end

    if not status or not status.success then
        ya.notify({
            title = "System Clipboard",
            content = string.format("Could not copy selected file(s) %s", status and status.code or err),
            level = "error",
            timeout = 5,
        })
    end
end

function paste() 
    local output, err = Command("wl-paste"):arg("--type"):arg("text/uri-list"):arg("--no-newline"):stderr(Command.PIPED):output()
    if not output.status.success then 
        return notify(string.format("Couldn't paste: %s", output.stderr), "error")
    end

    local cmd = Command("cp"):arg("-r")
    for line in string.gmatch(output.stdout, "[^\r\n]+") do
        local path = line:gsub("^file://", "")
        path = path:gsub("%%(%x%x)", function(hex) return string.char(tonumber(hex, 16)) end)
        cmd:arg(path)
    end

    local status, err = cmd:arg(get_cwd()):spawn():wait()
    if status and status.success then 
        notify("Pasted successfully!")
    else
        notify(string.format("Couldn't paste: %s", status and status.code or err), "error")
    end
end

function notify(content, level)
    ya.notify({
        title = "System Clipboard",
        content = content,
        level = level or "info",
        timeout = 5,
    })
end


return {
	entry = function(self, job)
        if job.args.copy then copy() else paste() end
	end,
}
