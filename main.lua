local color_area = dxCreateShader("assets/color_area.fx")
local hue_slider = dxCreateTexture("assets/hue_slider.png")

local rt = dxCreateRenderTarget(128, 128)

local c = tocolor(255, 0, 0)

dxSetShaderValue(color_area, "gColor", unpack({ 255 / 255, 0, 0 }))

addEventHandler("onClientRender", root, function()
	dxDrawImage(0, 0, 128, 128, rt)
	dxDrawImage(128 + 4, 0, 8, 128, hue_slider)

	dxDrawRectangle(0, 128, 16, 16, c)
end)

addEventHandler("onClientClick", root, function(s_Button, s_State, x, y)
	if s_Button == "left" and s_State == "down" then
		if (x >= 0 and x < 128) and (y >= 0 and y < 128) then
			local buffr = dxGetTexturePixels(rt)

			c = tocolor(dxGetPixelColor(buffr, x - 0, y - 0))
		end

		if (x >= 128 + 4 and x <= 128 + 4 + 8) and (y >= 0 and y <= 128) then
			local buffr = dxGetTexturePixels(hue_slider)
			local r, g, b = dxGetPixelColor(buffr, x - 128 + 4, y + 5)

			dxSetShaderValue(color_area, "gColor", r / 255, g / 255, b / 255)
		end
	end
end)

setTimer(function()
	dxSetRenderTarget(rt, true)

	dxDrawImage(0, 0, 128, 128, color_area)

	dxSetRenderTarget()
end, 500, 0)

showCursor(true)
