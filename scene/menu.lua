menu = {}

function menu.load()
    --dimensions 
    local margin = 100
    w,h = (width-3*margin)/2, (height-3*margin)/2

    --the 4 possible options
    charts = {}
    charts[1] = {width = w, height = h, x = margin    , y = margin, name = "BAR CHART"} --bar
    charts[2] = {width = w, height = h, x = margin*2+w, y = margin, name = "LINE CHART"} --line
    charts[3] = {width = w, height = h, x = margin    , y = margin*2+h, name = "SCATTER PLOT"} --scatter
    charts[4] = {width = w, height = h, x = margin*2+w, y = margin*2+h, name = "AREA CHART"} --area

    --for the selecting animation
    select_rect = {}
    for i = 1, #charts do
        select_rect[i] = {}
        select_rect[i].x = charts[i].x/2 
        select_rect[i].y = charts[i].y/2 
        select_rect[i].width = 0
        select_rect[i].height = 0
    end
    
    grow_speed = 6

end

function menu.update(dt)
    --playing the animation
    for i = 1, #charts do
        if(mouse_x >= charts[i].x and mouse_x <= charts[i].x + charts[i].width) and (mouse_y >= charts[i].y and mouse_y <= charts[i].y + charts[i].height) then --if mouse over the option
            select_rect[i].x = select_rect[i].x - grow_speed
            select_rect[i].y = select_rect[i].y - grow_speed
            select_rect[i].width = select_rect[i].width + 2*grow_speed
            select_rect[i].height = select_rect[i].height + 2*grow_speed
            --max size
            if(select_rect[i].x <= charts[i].x and select_rect[i].y <= charts[i].y) then
                select_rect[i].x = charts[i].x
                select_rect[i].y = charts[i].y
                select_rect[i].width = charts[i].width
                select_rect[i].height = charts[i].height

            end
        else --if out of rect
            --set to default 
            select_rect[i].x = charts[i].x + charts[i].width/2
            select_rect[i].y = charts[i].y + charts[i].height/2
            select_rect[i].width = 0
            select_rect[i].height = 0
        end
    end
end

function menu.mousepressed(x,y,mouseID)
    if mouseID == 1 then
        for i = 1, #charts do
            if((x >= charts[i].x and x <= charts[i].x + charts[i].width) and (y >= charts[i].y and y <= charts[i].y + charts[i].height)) then
                if i == 1 then
                    current_scn = bar_chart
                elseif i == 2 then
                    current_scn = line_chart
                elseif i == 3 then
                    current_scn = scatter_plot
                else
                    current_scn = area_chart
                end
                current_scn.load()
            end
        end
    end
end

function menu.keypressed(key)
    
end

function menu.draw()
    for i = 1, #charts do
        love.graphics.setColor(white)
        love.graphics.rectangle("line", charts[i].x, charts[i].y, charts[i].width, charts[i].height)
        love.graphics.setColor(red)
        love.graphics.rectangle("fill", select_rect[i].x, select_rect[i].y, select_rect[i].width, select_rect[i].height)
        love.graphics.setColor(white)
        love.graphics.print(charts[i].name, (charts[i].x + charts[i].width/2) - (love.graphics.getFont():getWidth(charts[i].name)/2), (charts[i].y + charts[i].height/2)-4)
    end
    
end

return menu