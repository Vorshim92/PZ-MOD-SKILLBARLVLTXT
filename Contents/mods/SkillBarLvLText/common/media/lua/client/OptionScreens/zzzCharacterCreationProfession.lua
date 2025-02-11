local vanilla_drawXp = CharacterCreationProfession.drawXpBoostMap

function CharacterCreationProfession:drawXpBoostMap(y, item, alt)
    local newY = vanilla_drawXp(self, y, item, alt)
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


    -- Nuovo codice per il testo del livello
    local levelText = "Lvl "..tostring(item.item.level)
    local textWidth = getTextManager():MeasureStringX(UIFont.Small, levelText)
    self:drawText(levelText, greenBlitsX - textWidth - blitGap, yy + dy, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Small)

    return newY
end