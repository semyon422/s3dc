local s3dc = require("s3dc")

local sensitivity = 0.5
local speed = 500
local width, height
function love.load()
	width, height = love.graphics.getDimensions()

	s3dc.load()
	s3dc.show(0, 0, width, height)
	s3dc.angle.yaw = math.pi / 4

	local font = love.graphics.newFont(60)
	love.graphics.setFont(font)
	love.graphics.setLineWidth(4)
end

function love.draw()
	width, height = love.graphics.getDimensions()
	local fps = love.timer.getFPS()

	s3dc.draw_start()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("line", 0, 0, height, height)
	love.graphics.rectangle("fill", height * 0.25, height * 0.25, height / 2, height / 2)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.print("FPS: " .. fps, height * 0.25, height * 0.25)

	s3dc.draw_end()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("FPS: " .. fps)
end

function love.update(dt)
	local dx = speed * dt
	if love.keyboard.isDown("a") then
		s3dc.left(dx)
	elseif love.keyboard.isDown("d") then
		s3dc.right(dx)
	end
	if love.keyboard.isDown("w") then
		s3dc.forward(dx)
	elseif love.keyboard.isDown("s") then
		s3dc.backward(dx)
	end
	if love.keyboard.isDown("lshift") then
		s3dc.down(dx)
	elseif love.keyboard.isDown("space") then
		s3dc.up(dx)
	end
end

function love.keypressed(key)
	if key == "escape" then
		s3dc.show()
	end
end

local dragging
function love.mousepressed()
	dragging = true
	love.mouse.setRelativeMode(true)
end

function love.mousereleased()
	dragging = false
	love.mouse.setRelativeMode(false)
end

function love.mousemoved(x, y, dx, dy)
	if dragging then
		s3dc.rotate(math.rad(dx) * sensitivity, math.rad(dy) * sensitivity)
	end
end

