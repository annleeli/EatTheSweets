%Bacchus' Sprites
%version 1.3  -I have a thing about the Number 13... Best Number!

/*
The Commands

BSprite.New(x,y:int,filename:string):int 
    The New function is used to assign a Sprite to an Integer variable so that it can then be refered back to and moved around with that variable. ie: like Pic.FileNew 

BSprite.Move(x,y,spriteID:int) 
    The Move procedure is used to move the Sprite around the screen. It will move the Sprite from it previous location to the specified x and y 

BSprite.Change(filename:string,spriteID:int) 
    The Change procedure is used to Change the existing Sprite to a new Picture. 

BSprite.Free(spriteID:int) 
    The Free procedure is used to free a Sprite and to just save space. ie: like Pic.Free 

BSprite.Update(spriteID:int) 
    The Update procedure is used to redraw the specified Sprite above others 

BSprite.UpdateAll 
    The UpdateAll procedure is to completly redraw all Sprites, starts and the first created 

BSprite.ColorBack(spriteID,color:int) 
    The ColorBack procedure is to set the Transparent Color of the Sprite, default setting is white (0) 

BSprite.Mirror(spriteID:int) 
    The Mirror procedure is used to Mirror the Sprite; flip the Sprite Horizontally 

BSprite.Flip(spriteID:int) 
    The Flip procedure is used to Flip the Sprite; flip the Sprite Vertically 

BSprite.Rotate(spriteID,angle,rotatex,rotatex:int) 
    The Rotate procedure is used to rotate the Sprite to a desired angle, the Rotation point is specified by the rotatex and rotatey. ie:similar to Pic.Rotate 

BSprite.Mode(spriteID:int,mode:int) 
    The Mode procedure is used to specify the desired Picture mode for the Sprite (use like a normal Picture, picCopy, picXor, picMerge), default setting is picMerge *Thxs Cervantes 

BSprite.Height(spriteID:int):int 
    The Height function returns the value in Pixels that the Height of the Sprite is 

BSprite.Width(spriteID:int):int 
    The Width function returns the value in Pixels that the Width of the Sprite is 

*/
unit
module BSprite
    export New, Move, Change, ColorBack, Mirror, Flip, Rotate, Height, Width, Mode,
	Free, Update, UpdateAll

    const MaxSprite := 200 %The maximum amount of Sprites allowed

    var unused : flexible array 1 .. 0 of int

    var sprite : flexible array 1 .. 0 of
	record
	    pic : int
	    x, y : int
	    background : int
	    transClr : int
	    mode : int
	end record

    fcn up (word : string) : string
	var endword : string := ""
	for caps : 1 .. length (word)
	    if ord (word (caps)) >= 97 & ord (word (caps)) <= 122 then
		endword += chr (ord (word (caps)) - 32)
	    else
		endword += word (caps)
	    end if
	end for
	result endword
    end up

    proc Update (picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Update

    proc UpdateAll
	for draw_all : 1 .. upper (sprite)
	    if sprite (draw_all).pic ~= 0 then
		Pic.Draw (sprite (draw_all).pic, sprite (draw_all).x, sprite (draw_all).y, sprite (draw_all).mode)
	    end if
	end for
    end UpdateAll

    proc Free (var picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	new unused, upper (unused) + 1
	unused (upper (unused)) := picID
	Pic.Free (sprite (picID).pic)
	Pic.Free (sprite (picID).background)
	sprite (picID).pic := 0
	sprite (picID).background := 0
	picID := 0
    end Free

    proc Mode (picID : int, mode : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	sprite (picID).mode := mode
    end Mode

    fcn Height (picID : int) : int
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	result Pic.Height (sprite (picID).pic)
    end Height

    fcn Width (picID : int) : int
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	result Pic.Width (sprite (picID).pic)
    end Width

    proc ColorBack (picID, clr : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	sprite (picID).transClr := clr
    end ColorBack

    proc drawBack (picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	var x, y : int
	if sprite (picID).x < 0 then
	    x := 0
	elsif sprite (picID).x > maxx then
	    x := maxx
	else
	    x := sprite (picID).x
	end if
	if sprite (picID).y < 0 then
	    y := 0
	elsif sprite (picID).y > maxy then
	    y := maxy
	else
	    y := sprite (picID).y
	end if
	Pic.Draw (sprite (picID).background, x, y, picCopy)
    end drawBack

    proc storeBack (picID : int)
	var x, y, x1, y1 : int
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	if sprite (picID).x < 0 then
	    x := 0
	elsif sprite (picID).x > maxx then
	    x := maxx
	else
	    x := sprite (picID).x
	end if
	if sprite (picID).y < 0 then
	    y := 0
	elsif sprite (picID).y > maxy then
	    y := maxy
	else
	    y := sprite (picID).y
	end if
	if sprite (picID).x + Pic.Width (sprite (picID).pic) < 0 then
	    x1 := 0
	elsif sprite (picID).x + Pic.Width (sprite (picID).pic) > maxx then
	    x1 := maxx
	else
	    x1 := sprite (picID).x + Pic.Width (sprite (picID).pic)
	end if
	if sprite (picID).y + Pic.Height (sprite (picID).pic) < 0 then
	    y1 := 0
	elsif sprite (picID).y + Pic.Height (sprite (picID).pic) > maxy then
	    y1 := maxy
	else
	    y1 := sprite (picID).y + Pic.Height (sprite (picID).pic)
	end if
	var redraw : flexible array 1 .. 0 of int
	for test_back : 1 .. upper (sprite)
	    if test_back ~= picID then
		if sprite (test_back).pic ~= 0 then
		    if (x >= sprite (test_back).x & x <= sprite (test_back).x + Width (test_back))|
			    (x1 >= sprite (test_back).x & x1 <= sprite (test_back).x + Width (test_back)) then
			if (y >= sprite (test_back).y & y <= sprite (test_back).y + Height (test_back))|
				(y1 >= sprite (test_back).y & y1 <= sprite (test_back).y + Height (test_back)) then
			    drawBack (test_back)
			    new redraw, upper (redraw) + 1
			    redraw (upper (redraw)) := test_back
			end if
		    elsif (sprite (test_back).x >= x & sprite (test_back).x <= x1)|
			    (sprite (test_back).x + Width (test_back) >= x &
			    sprite (test_back).x + Width (test_back) <= x1) then
			if (sprite (test_back).y >= y & sprite (test_back).y <= y1)|
				(sprite (test_back).y + Height (test_back) >= y &
				sprite (test_back).y + Height (test_back) <= y1) then
			    drawBack (test_back)
			    new redraw, upper (redraw) + 1
			    redraw (upper (redraw)) := test_back
			end if
		    end if
		end if
	    end if
	end for
	sprite (picID).background := Pic.New (x, y, x1, y1)
	assert sprite (picID).background > 0 %If error then didnt make background
	for decreasing draw : upper (redraw) .. 1
	    Update (redraw (draw))
	end for
    end storeBack

    proc Mirror (picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	drawBack (picID)
	var tmp : int := Pic.Mirror (sprite (picID).pic)
	assert tmp > 0
	var tmp2 : int := Pic.Mirror (tmp)
	assert tmp2 > 0
	Pic.Free (sprite (picID).pic)
	sprite (picID).pic := Pic.Mirror (tmp2)
	assert sprite (picID).pic > 0 %If error then pic didnt mirror properly
	Pic.Free (tmp)
	Pic.Free (tmp2)
	Pic.Free (sprite (picID).background)
	storeBack (picID)
	Pic.SetTransparentColor (sprite (picID).pic, sprite (picID).transClr)
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Mirror

    proc Flip (picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	drawBack (picID)
	var tmp : int := Pic.Flip (sprite (picID).pic)
	assert tmp > 0
	var tmp2 : int := Pic.Flip (tmp)
	assert tmp2 > 0
	Pic.Free (sprite (picID).pic)
	sprite (picID).pic := Pic.Flip (tmp2)
	assert sprite (picID).pic > 0 %If error then pic didnt flip properly
	Pic.Free (tmp)
	Pic.Free (tmp2)
	Pic.Free (sprite (picID).background)
	storeBack (picID)
	Pic.SetTransparentColor (sprite (picID).pic, sprite (picID).transClr)
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Flip

    proc Rotate (picID, angle, rotatex, rotatey : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	drawBack (picID)
	var tmp : int := Pic.Mirror (sprite (picID).pic)
	assert tmp > 0
	var tmp2 : int := Pic.Mirror (tmp)
	assert tmp2 > 0
	Pic.Free (sprite (picID).pic)
	sprite (picID).pic := Pic.Rotate (tmp2, angle, rotatex, rotatey)
	assert sprite (picID).pic > 0 %If error then didnt rotate pic properly
	Pic.Free (tmp)
	Pic.Free (tmp2)
	Pic.Free (sprite (picID).background)
	storeBack (picID)
	Pic.SetTransparentColor (sprite (picID).pic, sprite (picID).transClr)
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Rotate

    fcn New (x, y : int, filename : string) : int
	var spriteNum : int
	if upper (unused) > 0 then
	    spriteNum := unused (1)
	    for removeElement : 1 .. upper (unused) - 1
		unused (removeElement) := unused (removeElement + 1)
	    end for
	    new unused, upper (unused) - 1
	else
	    new sprite, upper (sprite) + 1
	    spriteNum := upper (sprite)
	    assert spriteNum <= MaxSprite %If error then over Max amount of Sprites
	end if
	sprite (spriteNum).pic := Pic.FileNew (filename)
	assert sprite (spriteNum).pic > 0 %if error, could not find pic
	sprite (spriteNum).x := x
	sprite (spriteNum).y := y
	sprite (spriteNum).transClr := 0 %default color of transparent color
	sprite (spriteNum).mode := picMerge %Default Merge
	storeBack (spriteNum)
	Pic.SetTransparentColor (sprite (spriteNum).pic, sprite (spriteNum).transClr)
	Pic.Draw (sprite (spriteNum).pic, sprite (spriteNum).x, sprite (spriteNum).y, picMerge)
	result spriteNum
    end New

    proc Move (x, y : int, picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	drawBack (picID)
	sprite (picID).x := x
	sprite (picID).y := y
	Pic.Free (sprite (picID).background)
	storeBack (picID)
	Pic.SetTransparentColor (sprite (picID).pic, sprite (picID).transClr)
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Move

    proc Change (filename : string, picID : int)
	assert picID > 0 & picID <= upper (sprite) %If error then pic not made yet
	Pic.Free (sprite (picID).pic)
	drawBack (picID)
	sprite (picID).pic := Pic.FileNew (filename)
	assert sprite (picID).pic > 0 %if error could not find pic
	Pic.Free (sprite (picID).background)
	storeBack (picID)
	Pic.SetTransparentColor (sprite (picID).pic, sprite (picID).transClr)
	Pic.Draw (sprite (picID).pic, sprite (picID).x, sprite (picID).y, sprite (picID).mode)
    end Change

end BSprite
