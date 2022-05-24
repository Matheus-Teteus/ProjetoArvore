local composer = require("composer")
local scene = composer.newScene()

local seguinte, anterior

local function abrirWelcome(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page2", "slideRight", 800)
        return true
    end
end

local function abrirPage2(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page4", "slideLeft", 800)
        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/fundo.png", display.contentWidth, display.contentHeight * 2)
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, -150

    local imginfo = display.newImageRect(sceneGroup, "assets/globomaos.png", display.contentWidth*0.8, display.contentHeight * 0.8)
    imginfo.anchorX = 0
    imginfo.anchorY = 0
    imginfo.x, imginfo.y = 90, -200

    local options1 = {
        text = "Conter o desmatamento é mais efetivo do que plantar novas áreas. Mesmo assim, iniciativas de restauração florestal são muito importantes. O Brasil possui uma área equivalente ao estado de Minas Gerais em pastagens degradadas, o que mostra que o país não precisa desmatar novas áreas.",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.1),
        width = 600,
        font = native.systemFont,
        fontSize = 46,
        aling = "center",
    }
    local myText1 = display.newText(options1)
    myText1:setFillColor( 0, 0, 0 )

    seguinte = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    seguinte.x = display.contentWidth * 0.9
    seguinte.y = display.contentHeight + 250

	anterior = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    anterior.x = display.contentWidth * 0.1
    anterior.y = display.contentHeight + 250


    transition.to( anterior, { rotation=180 } )

    sceneGroup:insert(background)
    sceneGroup:insert(imginfo)
    sceneGroup:insert(myText1)
    sceneGroup:insert(seguinte)
	sceneGroup:insert(anterior)

end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        anterior.touch = abrirWelcome
        seguinte.touch = abrirPage2
        anterior:addEventListener("touch", anterior)
        seguinte:addEventListener("touch", seguinte)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        anterior:removeEventListener("touch", anterior)
        seguinte:removeEventListener("touch", seguinte)

    elseif phase == "did" then

    end
end

function scene:destroy(event)
    local sceneGroup = self.view

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
