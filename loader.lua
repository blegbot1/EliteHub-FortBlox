-- ============================================================
--  ELITE HUB | Fort Blox — LOADER
--  Загружает актуальный скрипт напрямую с GitHub.
--  Использование: вставь этот файл в executor и запусти (Execute).
-- ============================================================

local URL = "https://raw.githubusercontent.com/blegbot1/EliteHub-FortBlox/refs/heads/main/EliteHub.lua"

-- защита только от случайного двойного запуска (5 секунд),
-- чтобы можно было спокойно перезапустить лоадер после обновления
local g = getgenv()
local now = os.clock()
if g.ELITE_HUB_LOADED_AT and (now - g.ELITE_HUB_LOADED_AT) < 5 then
    warn("[ELITE HUB] только что запущен, подожди 5 сек")
    return
end
g.ELITE_HUB_LOADED_AT = now

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
    g.ELITE_HUB_LOADED_AT = nil
    warn("[ELITE HUB] ошибка загрузки:", err)
    error("[ELITE HUB] не удалось загрузить скрипт: " .. tostring(err))
end

print("[ELITE HUB] готово")