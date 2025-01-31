local vanilla_drawXp = CharacterCreationProfession.drawXpBoostMap

function CharacterCreationProfession:drawXpBoostMap(y, item, alt)
    local newY = vanilla_drawXp(self, y, item, alt)

    local dy = (self.itemheight - self.fontHgt) / 2
    local hc = getCore():getGoodHighlitedColor()
    local lvlWidth = getTextManager():MeasureStringX(UIFont.Small, "Lvl "..item.item.level)
    
    local yForText = newY - self.itemheight

    self:drawText("Lvl "..item.item.level,
                  self.width - (68 + 10 * 4) - lvlWidth - 5,
                  yForText + dy,
                  hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Small)

    return newY
end
