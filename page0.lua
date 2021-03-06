local composer = require("composer")
local planeta = require("planetaAnimado")
local scene = composer.newScene()

local seguinte, anterior

local function abrirWelcome(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("welcome", "slideRight", 800)
        return true
    end
end

local function abrirTela1(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page1", "slideLeft", 800)
        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/fundo.png", display.contentWidth, display.contentHeight * 2)
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, -150

    transition.to( planetaImg, { time=400, y=200, transition=easing.inExpo } )

    local options1 = {
        text = "Preservar o meio ambiente é fundamental, afinal, é nele onde estão os recursos naturais necessários para a nossa sobrevivência, como água, alimentos e matérias-primas. Sem esses recursos, todas as formas de vida do planeta poderão acabar.",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.1),
        width = 600,
        font = native.systemFont,
        fontSize = 50
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
    sceneGroup:insert(planeta.character)
    sceneGroup:insert(myText1)
    sceneGroup:insert(seguinte)
    sceneGroup:insert(anterior)

    planeta.animation()
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        seguinte.touch = abrirTela1
        anterior.touch = abrirWelcome
        seguinte:addEventListener("touch", seguinte)
        anterior:addEventListener("touch", anterior)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        seguinte:removeEventListener("touch", seguinte)
        anterior:removeEventListener("touch", anterior)

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
