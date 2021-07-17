local Assets = {}
Assets.__index = Assets

function Assets.load()
    local fnt = love.graphics.newFont
    local font = {
        main = 'assets/fonts/Iceberg-Regular.ttf'
    }
    Assets.fonts = {
        main__20 = fnt(font.main, 20),
        main__24 = fnt(font.main, 24),
        main__28 = fnt(font.main, 28),
        main__32 = fnt(font.main, 32),
        main__48 = fnt(font.main, 48),
        main__64 = fnt(font.main, 64)
    }
end

return Assets
