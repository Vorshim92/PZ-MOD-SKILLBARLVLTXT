local old_drawXp = CharacterCreationProfession.drawXpBoostMap

CharacterCreationProfession.drawXpBoostMap = function(self, y, item, alt)
    -- 1) Salvo la drawTexture originale
    local old_drawTexture = self.drawTexture

    -- 2) Definisco una funzione "filtro"
    local function new_drawTexture(obj, texture, x, y, alpha, r, g, b)
        -- Se la texture è "whiteBar", la salto:
        if texture == CharacterCreationProfession.instance.whiteBar then
            return
        end
        -- Altrimenti chiamo davvero la drawTexture originale
        old_drawTexture(obj, texture, x, y, alpha, r, g, b)
    end

    -- 3) Sostituisco temporaneamente self.drawTexture
    self.drawTexture = new_drawTexture

    -- 4) Chiamo la funzione vanilla (che tenterà di disegnare la whiteBar)
    local newY = old_drawXp(self, y, item, alt)

    -- 5) Rimetto tutto a posto
    self.drawTexture = old_drawTexture
    local scrollBarWidth = 13
    local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

    local dy = (self.itemheight - self.fontHgt) / 2
    local hc = getCore():getGoodHighlitedColor()
    local blitH = FONT_HGT_SMALL
    local blitW = math.floor(blitH / (10/3))
    local blitGap = math.floor(blitW/4)
    local blitXOffset = getTextManager():MeasureStringX(UIFont.Small, "+ 100%")+scrollBarWidth
    local greenBlitsX = self.width - (blitXOffset + 12 * (blitW+blitGap))
    local yy = y
    local textWid = getTextManager():MeasureStringX(UIFont.Small, item.text)
    if 16 + textWid > greenBlitsX - 4 then
        yy = y + self.fontHgt
    end

    for i = 1,item.item.level do
        self:drawTextureScaled(CharacterCreationProfession.instance.whiteBar, greenBlitsX+(i * (blitW+blitGap)), (yy) + dy, blitW, blitH, 1, hc:getR(), hc:getG(), hc:getB())
    end

    -- Nuovo codice per il testo del livello
    local levelText = "Lvl "..tostring(item.item.level)
    local textWidth = getTextManager():MeasureStringX(UIFont.Small, levelText)
    self:drawText(levelText, greenBlitsX - textWidth - blitGap, yy + dy, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Small)
    -- 6) Restituisco il risultato
    return newY
end