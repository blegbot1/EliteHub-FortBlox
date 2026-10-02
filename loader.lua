-- ============================================================
--  ELITE HUB | Fort Blox — LOADER
--  Загружает актуальный скрипт напрямую с GitHub.
--  Использование: вставь этот файл в executor и запусти (F5 / Execute).
-- ============================================================

local URL = "https://raw.githubusercontent.com/blegbot1/EliteHub-FortBlox/refs/heads/main/EliteHub.lua"

-- защита от двойного запуска в одной сессии
if getgenv().ELITE_HUB_LOADED then
    warn("[ELITE HUB] уже загружен в этой сессии")
    return
end
getgenv().ELITE_HUB_LOADED = true

print("[ELITE HUB] загрузка:", URL)

local ok, err = pcall(function()
    local src = game:HttpGet(URL, true)
    if type(src) ~= "string" or #src < 100 then
        error("пустой или битый ответ (" .. tostring(src) .. ")")
    end
    local chunk = loadstring(src, "EliteHub")
    if not chunk then
        error("loadstring вернул nil — синтаксис в файле сломан")
    end
    chunk()
end)

if not ok then
    getgenv().ELITE_HUB_LOADED = nil
    warn("[ELITE HUB] ошибка загрузки:", err)
    error("[ELITE HUB] не удалось загрузить скрипт: " .. tostring(err))
end

print("[ELITE HUB] готово")