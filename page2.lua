local composer = require("composer")
local scene = composer.newScene()
local arrastarMotoserra = require("arrastarSoltar1")

local seguinte, anterior

local function abrirWelcome(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page1", "slideRight", 800)
        return true
    end
end

local function abrirPage2(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page3", "slideLeft", 800)
        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/fundo01.png", display.contentWidth, display.contentHeight * 2)
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, -150

    transition.to( planetaImg, { time=400, y=200, transition=easing.inExpo } )

    local options1 = {
        text = "As arvores ajudam a evitar a erosão do solo, ão responsáveis por melhorar a umidade relativa do ar devido à evapotranspiração. As árvores das florestas liberam grande quantidade de água por evaporação, ajudando na formação das chuvas e regulação do clima; Fornecem sombra que ajuda a reduzir a temperatura do ambiente.",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.1),
        width = 600,
        font = native.systemFont,
        fontSize = 38
    }
    local myText1 = display.newText(options1)

    seguinte = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    seguinte.x = display.contentWidth * 0.9
    seguinte.y = display.contentHeight + 250

	anterior = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    anterior.x = display.contentWidth * 0.1
    anterior.y = display.contentHeight + 250


	transition.to( anterior, { rotation=180 } )

    sceneGroup:insert(background)
    sceneGroup:insert(myText1)
    sceneGroup:insert(arrastarMotoserra)
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
