%File Name: Final Project.t
%Author: Annlee
%Date: Dec 9, 2011
%Description: Vertical Scrolling platform game that involves a goal to reach and items to collect. There are 3 levels, 9 sprites to choose from and

import "Other files/BSprite.tu"

%------------------------------BASIC VARIABLES-------------------------------%

%-----------Window variables-------------%
var window : int        %set variable for window

%assigning a new window (so the window can close when the quit button is pressed
window := Window.Open ("graphics:640;610, offscreenonly, position:center;middle, nobuttonbar, title: Eat the Sweets")

%if the window should close
var closeWindow := false

%-----------Loading screen---------------%
var loading := Pic.FileNew ("images/sprites/level/Loading....bmp")

%draw loading pic
Pic.Draw (loading, 270, 300, picCopy)       %so if its on a slow comp, the user doesnt think the program is broken

%--------------Play Input----------------%
%key input
var chars : array char of boolean

%mouse location
var x, y, button : int

%==============================IMAGES================================%
%---------Game popup pictures------------%
%game screen pics
var titleScreen := Pic.FileNew ("images/title.bmp")
var helpScreen := Pic.FileNew ("images/help screen.bmp")
var characterSelection := Pic.FileNew ("images/character select.bmp")
var gameoverScreen := Pic.FileNew ("images/gameover.bmp")
var levelClearScreen := Pic.FileNew ("images/level clear.bmp")
var levelClearScreen_b := Pic.FileNew ("images/level clear_b.bmp")

%---------------Game buttons-------------%
%title screen buttons
var playButton := Pic.FileNew ("images/play clicked.bmp")
var helpButton := Pic.FileNew ("images/help clicked.bmp")
var optionsButton := Pic.FileNew ("images/options clicked.bmp")
var quitButton := Pic.FileNew ("images/quit clicked.bmp")
var backButton := Pic.FileNew ("images/back clicked.bmp")
var GameOver_YesButton := Pic.FileNew ("images/gameover yes clicked.bmp")
var LevelClear_YesButton := Pic.FileNew ("images/levelclear yes clicked.bmp")
var LevelClear_YesButton_b := Pic.FileNew ("images/levelclear yes clicked_b.bmp")
var noButton := Pic.FileNew ("images/no clicked.bmp")

%------------Other game images------------%
%other game screen images
var charSel := Pic.FileNew ("images/CharSel.bmp")
var bonusImg := Pic.FileNew ("images/bonus.bmp")

%level intro
var Level1 := Pic.FileNew ("images/sprites/level/level 1.bmp")
var Level2 := Pic.FileNew ("images/sprites/level/level 2.bmp")
var Level3 := Pic.FileNew ("images/sprites/level/level 3.bmp")

%============================LEVEL SCORES===========================%
%------------Level Points----------------%
%how many points the player has
var lvlPoints := 0      %adds each time the player gets an item
var totalScore := 0     %is the total score the player has at the end of the game
var bonus := 100        %bonus points

%font
var font1 := Font.New ("Georgia:20")

%which level the player is on
var level := 1              %default to level 1
var LevelTitle := Level1    %level intro pic

%------------------Goal------------------%
%goal post
var goalx, goaly : int
var goal := Pic.FileNew ("images/sprites/level/goal.bmp")
var goalWidth := Pic.Width (goal)
var goalHeight := Pic.Height (goal)
var goalx2, goaly2 : int


%================================PLAYER=============================%
%----------Player's character------------%
%player location defaults
var x1, y1 := 0     %location
x1 := -100

%character sprites
var playerSprite : array 1 .. 9 of int
playerSprite (1) := BSprite.New (x1, y1, "images/sprites/characters/bunny.bmp")
playerSprite (2) := BSprite.New (x1, y1, "images/sprites/characters/divine bird.bmp")
playerSprite (3) := BSprite.New (x1, y1, "images/sprites/characters/dragon.bmp")
playerSprite (4) := BSprite.New (x1, y1, "images/sprites/characters/hog.bmp")
playerSprite (5) := BSprite.New (x1, y1, "images/sprites/characters/hot air balloon.bmp")
playerSprite (6) := BSprite.New (x1, y1, "images/sprites/characters/owl.bmp")
playerSprite (7) := BSprite.New (x1, y1, "images/sprites/characters/ryo ho.bmp")
playerSprite (8) := BSprite.New (x1, y1, "images/sprites/characters/unicorn.bmp")
playerSprite (9) := BSprite.New (x1, y1, "images/sprites/characters/yeti.bmp")

var chrSel := 5                             %which charater the player chose
var player := playerSprite (chrSel)         %the player's sprite
var playerHeight := BSprite.Height (player) %getting the height of the sprite
var playerWidth := BSprite.Width (player)   %getting the width of the sprite
var y2 := y1 + playerHeight                 %y2 of the sprite
var x2 := x1 + playerWidth                  %x2 of the sprite

%----------------Movement----------------%
%velocity (speed of player)
var xv := 0.0   %setting to 0 and a real number
var yv := 0.0   %setting to 0 and a real number

%jumping
var g := 1.0            %gravity
var ground := true      %used to indicate if player is on a platform
const friction := 0.97  %to reduce horizontal movement

var jumpSpeed := 15     %how high the player can jump
var runSpeed := 1       %how fast the player runs

%======================LEVEL PLATFORMS AND ITEMS====================%
%ground
var ground_height := 120        %where the ground is

%how fast the level scrolls
var scrollSpeed := 1

%----------------Platforms---------------%
%creating new type of variable
type platformDimensions :
    record
	height, x1, width : int
    end record

%flexible array of platform dimensions
var platform : flexible array 1 .. 0 of platformDimensions

%how many platforms per level
var platnum : int

%-----------------SWEETS-----------------%
%creating new type for sweets
type addPoints :
    record
	img, imgH, imgW, picx1, picy1, picx2, picy2 : int
	show, addPoints : boolean
    end record

%flexible array of sweets
var food : flexible array 1 .. 0 of addPoints
var cakenum : int       %how many sweets to collect
var cakehover := 4      %how high above the platform the items should be

%sweets images
var blueLolly := Pic.FileNew ("images/sprites/food/Blue lollypop.bmp")
var cake := Pic.FileNew ("images/sprites/food/cake.bmp")
var candyCane := Pic.FileNew ("images/sprites/food/Candy Cane.bmp")
var strawberry := Pic.FileNew ("images/sprites/food/Strawberry Cake.bmp")
var chocolate := Pic.FileNew ("images/sprites/food/Chocolate Cake.bmp")
var birthday := Pic.FileNew ("images/sprites/food/Birthday Cake.bmp")

%---------------THE LEVEL----------------%
%level 1 platforms and sweet locations
include "Levels/level 1.t"

%---------------BACKGROUND--------------%
%level background image type
type backgroundIMG :
    record
	img, height : int
    end record

%background images for different levels
var bg : array 1 .. 3 of backgroundIMG
bg (1).img := Pic.FileNew ("images/day1.bmp")         %level 1
bg (1).height := Pic.Height (bg (1).img)
bg (2).img := Pic.FileNew ("images/night.bmp")        %level 2
bg (2).height := Pic.Height (bg (2).img)
bg (3).img := Pic.FileNew ("images/sunshine1.bmp")    %level 3
bg (3).height := Pic.Height (bg (3).img)

var background := bg (1).img            %which bg to use for level
var backgroundHeight := bg (1).height   %how big the image is

%default location of the images
var BGy := 0

%--------------GAME OVER----------------%
var gameover := false   %if the game is over
var retry := false      %if the user wants to retry the level

%---------------------------------PROCEDURES---------------------------------%

procedure playerControl
    %key pressed is the up arrow and the player is on screen and touching the ground
    if chars (KEY_UP_ARROW) and y2 < maxy and ground = true then
	yv := jumpSpeed     %jump by adding to the y velocity
    end if

    %key pressed is the left arrow and the player is on screen
    if chars (KEY_LEFT_ARROW) and x1 > 0 then
	xv -= runSpeed      %subtract 1 from the players y velocity
    end if

    %key pressed is the right arrow and the player is on screen
    if chars (KEY_RIGHT_ARROW) and x2 < maxx then
	xv += runSpeed      %add 1 from the players y velocity
    end if

    %so the player doesn't slide off platforms too much
    xv *= friction
    yv *= 0.99

    %bringing player (in a jump) to ground and stay on screen
    if (y1 >= ground_height + 1) then           %if the bottom of the box not touching the ground
	yv -= g                                 %subtract gravity from the velocity until the player moves down and touches the ground
	ground := false                         %not touching the ground (player is midjump)

    elsif (y1 <= ground_height + 1) then        %if the bottom of the box is on the ground then
	yv := 0                                 %stop the box
	y1 := ground_height                     %move the box to the ground
	ground := true
    end if


    %Platform collisions
    for platcoll : 1 .. platnum
	%platform collision
	if y1 <= platform (platcoll).height + 2 and y1 >= platform (platcoll).height - 20 and x1 <= platform (platcoll).x1 + platform (platcoll).width and x2 >= platform (platcoll).x1 and yv < 0 then
	    %if moving down
	    y1 := platform (platcoll).height
	    yv := 0
	    ground := true
	elsif y1 <= platform (platcoll).height + 2 and y1 >= platform (platcoll).height - 20 and x1 <= platform (platcoll).x1 + platform (platcoll).width and x2 >= platform (platcoll).x1 and yv > 0
		then
	    %if moving up
	    y1 := platform (platcoll).height
	    ground := true
	end if


	%platform bottom collision
	if y2 >= platform (platcoll).height - 15 and y2 <= platform (platcoll).height - 1 and x1 <= platform (platcoll).x1 + platform (platcoll).width and x2 >= platform (platcoll).x1 and yv > 0 then
	    yv := -yv
	end if

    end for

    %slowing player down
    if xv > 0 then          %if the player is moving then
	xv -= 0.5           %slow it down
    elsif xv < 0 then
	xv += 0.5
    end if

    %left border
    if x1 < 0 then          %if the player is past the left side of the screen
	x1 := 0             %move the box to the edge of the screen
	xv := 0             %stop the box

	%right border
    elsif x2 > maxx then            %if the box has passed the right side of the screen then
	x1 := maxx - playerWidth    %move the box to the edge of the screen
	xv := 0                     %and stop the box
    end if

    %moving the player
    x1 += round (xv)            %adds the velocity to the x position to create movement
    y1 += round (yv)            %adds the velocity to the y position to create movement
    x2 := x1 + playerWidth      %the right side of the box = the left side plus 10 pixels
    y2 := y1 + playerHeight     %keeps the box the same size
end playerControl

%player selection
proc CharacterSel
    View.Set ("title:Eat the Sweets - Options")

    loop
	%mouse location
	mousewhere (x, y, button)

	%background
	Pic.Draw (characterSelection, 0, 0, picCopy)

	%if hover over the image then
	if x >= 36 and y >= 374 and x <= 94 and y <= 410 then
	    Pic.Draw (charSel, 36, 368, picCopy)    %show an underline

	    %if clicked, then assign the player
	    if button = 1 then
		chrSel := 1
		exit
	    end if

	elsif x >= 99 and y >= 374 and x <= 157 and y <= 410 then
	    Pic.Draw (charSel, 99, 368, picCopy)
	    if button = 1 then
		chrSel := 2
		exit
	    end if

	elsif x >= 163 and y >= 374 and x <= 221 and y <= 410 then
	    Pic.Draw (charSel, 163, 368, picCopy)
	    if button = 1 then
		chrSel := 3
		exit
	    end if

	elsif x >= 227 and y >= 374 and x <= 285 and y <= 410 then
	    Pic.Draw (charSel, 227, 368, picCopy)
	    if button = 1 then
		chrSel := 4
		exit
	    end if

	elsif x >= 290 and y >= 374 and x <= 348 and y <= 410 then
	    Pic.Draw (charSel, 290, 368, picCopy)
	    if button = 1 then
		chrSel := 5
		exit
	    end if

	elsif x >= 354 and y >= 374 and x <= 412 and y <= 410 then
	    Pic.Draw (charSel, 354, 368, picCopy)
	    if button = 1 then
		chrSel := 6
		exit
	    end if

	elsif x >= 418 and y >= 374 and x <= 476 and y <= 410 then
	    Pic.Draw (charSel, 418, 368, picCopy)
	    if button = 1 then
		chrSel := 7
		exit
	    end if
	elsif x >= 482 and y >= 374 and x <= 540 and y <= 410 then
	    Pic.Draw (charSel, 482, 368, picCopy)
	    if button = 1 then
		chrSel := 8
		exit
	    end if
	elsif x >= 548 and y >= 374 and x <= 606 and y <= 410 then
	    Pic.Draw (charSel, 548, 368, picCopy)
	    if button = 1 then
		chrSel := 9
		exit
	    end if
	end if

	View.Update
	cls
    end loop

end CharacterSel

%instructions
proc HelpMenu
    View.Set ("title:Eat the Sweets - Help")

    loop
	mousewhere (x, y, button)
	Pic.Draw (helpScreen, 0, 0, picCopy)    %background

	%back button
	if x >= 55 and y >= 29 and x <= 146 and y <= 67 then
	    Pic.Draw (backButton, 55, 29, picMerge)

	    %go back to menu screen
	    if button = 1 then
		exit
	    end if
	end if

	View.Update
	cls
    end loop
end HelpMenu

%menu screen
proc title_screen
    View.Set ("title:Eat the Sweets - Menu")

    loop
	mousewhere (x, y, button)   %mouse location
	Input.KeyDown (chars)       %key input

	Pic.Draw (titleScreen, 0, 0, picCopy)   %background

	%press space to start game
	if chars (' ') then
	    delay (100)
	    exit
	end if

	%play button
	if x >= 36 and y >= 345 and x <= 270 and y <= 402 then
	    Pic.Draw (playButton, 36, 342, picMerge)

	    %start game
	    if button = 1 then
		delay (100)
		exit

	    end if

	    %help button
	elsif x >= 36 and y >= 266 and x <= 270 and y <= 323 then
	    Pic.Draw (helpButton, 36, 262, picMerge)

	    %instructions screen
	    if button = 1 then
		delay (150)
		cls
		HelpMenu
		delay (150)
		View.Set ("title:Eat the Sweets - Menu")
	    end if

	    %options button
	elsif x >= 36 and y >= 193 and x <= 270 and y <= 250 then
	    Pic.Draw (optionsButton, 36, 188, picMerge)

	    %show the player selection screen
	    if button = 1 then
		delay (150)
		cls
		CharacterSel
		player := playerSprite (chrSel)
		delay (200)
		View.Set ("title:Eat the Sweets - Menu")
	    end if


	    %quit button
	elsif x >= 517 and y >= 21 and x <= 608 and y <= 59 then
	    Pic.Draw (quitButton, 517, 21, picCopy)
	    if button = 1 then

		%close the window
		closeWindow := true
		exit
	    end if
	end if

	View.Update
	cls
    end loop
end title_screen

%drawing the level
proc LevelDraw

    %scroll the ground
    ground_height -= scrollSpeed

    %draw platforms
    for platdraw : 1 .. platnum
	platform (platdraw).height -= scrollSpeed   %scroll levle

	%draw the white part and then the outline
	drawfillbox (platform (platdraw).x1, platform (platdraw).height, platform (platdraw).x1 + platform (platdraw).width, platform (platdraw).height - 15, white)
	drawbox (platform (platdraw).x1, platform (platdraw).height, platform (platdraw).x1 + platform (platdraw).width, platform (platdraw).height - 15, black)
    end for

    %ground
    drawline (0, ground_height, maxx, ground_height, 16)

end LevelDraw

%item collection
proc collect
    for fColl : 1 .. cakenum

	%move the sweets as the level is scrolling down
	food (fColl).picy1 -= scrollSpeed
	food (fColl).picy2 -= scrollSpeed

	%if you get a sweet then
	if x2 - 3 >= food (fColl).picx1 and y2 - 3 >= food (fColl).picy1 and x1 + 3 <= food (fColl).picx2 and y1 + 3 <= food (fColl).picy2 and food (fColl).show then
	    food (fColl).addPoints := true      %add to level points
	    food (fColl).show := false          %hide the sweet
	else
	    food (fColl).addPoints := false     %else, dont add any points
	end if

	%if player didnt get the item yet then show the sweet
	if food (fColl).show then
	    Pic.Draw (food (fColl).img, food (fColl).picx1, food (fColl).picy1, picMerge)
	end if

	%adding to level points
	if food (fColl).addPoints then
	    lvlPoints += 10

	end if

    end for
end collect

%the actual level 
proc Level
    Input.KeyDown (chars)

    %moving the player
    playerControl

    %scrolling the background image
    Pic.Draw (background, 0, BGy, picCopy)
    BGy -= scrollSpeed

    %if the top of the bg image is reached
    if BGy = (-backgroundHeight) + maxy then
	scrollSpeed := 0
    end if

    %the goal post's location
    goalx := (platform (platnum).x1 + (platform (platnum).width div 2)) - 10
    goalx2 := goalx + goalWidth
    goaly := platform (platnum).height

    %goal
    Pic.Draw (goal, goalx, goaly, picMerge)

    %This Draws our player
    BSprite.Move (x1, y1, player)

    %drawing the level
    LevelDraw

    %putting the stuff to collect
    collect

end Level

%if player passes level
proc LevelClear

    %if player reaches the flag
    if x1 >= goalx - 10 and y1 >= goaly - 10 and x2 <= goalx2 - 5 and y1 <= goaly + 2 then
	View.Set ("title:Eat the Sweets - Level Cleared!")

	%make it reach the ground
	y1 := goaly

	%pause game
	scrollSpeed := 0

	%add to total score
	totalScore += lvlPoints

	%if the user got all the sweets, then bonus points
	if lvlPoints = cakenum * 10 then
	    totalScore += bonus
	end if

	delay (300)

	loop
	    Input.KeyDown (chars)

	    mousewhere (x, y, button)

	    %if it is the last level, show the last level popup
	    if level = 3 then
		Pic.Draw (levelClearScreen_b, 0, 0, picMerge)
	    else
		Pic.Draw (levelClearScreen, 0, 0, picMerge)
	    end if

	    %level score and total score
	    Font.Draw (intstr (lvlPoints), 311, 391, font1, 38)
	    Font.Draw (intstr (totalScore), 311, 344, font1, 38)

	    %if they got all the sweets then put the bonus pic
	    if lvlPoints = cakenum * 10 then
		Pic.Draw (bonusImg, 400, 345, picMerge)
	    end if

	    %press space to restart game at level 1
	    if chars (' ') then
		gameover := false
		level += 1
		retry := true
		exit
	    end if

	    %yes button
	    if x >= 131 and y >= 188 and x <= 261 and y <= 232 then

		%if it is level 3, then when hovering over button, say restart
		if level = 3 then
		    Pic.Draw (LevelClear_YesButton_b, 131, 188, picCopy)

		    %else, just say next level
		else
		    Pic.Draw (LevelClear_YesButton, 131, 188, picCopy)
		end if

		if button = 1 then
		    gameover := false
		    retry := true
		    delay (100)
		    level += 1  %next level
		    exit
		end if

	    elsif x >= 362 and y >= 188 and x <= 492 and y <= 232 then
		Pic.Draw (noButton, 362, 188, picCopy)
		if button = 1 then
		    retry := false
		    delay (100)
		    gameover := true

		    exit
		end if

	    end if

	    View.Update

	end loop


    end if
end LevelClear

%if user fails the level
proc LevelOver

    if y2 <= 0 then      %if the player is below the bottom of the screen then
	View.Set ("title:Eat the Sweets - Game Over")

	%pausing the game
	scrollSpeed := 0
	runSpeed := 0
	jumpSpeed := 0

	%so the player stays offscreen
	y2 := -2

	loop
	    Input.KeyDown (chars)

	    mousewhere (x, y, button)

	    %draw the gameover popup
	    Pic.Draw (gameoverScreen, 0, 0, picMerge)

	    %how many points the user gained from the level
	    Font.Draw (intstr (lvlPoints), 311, 391, font1, 38)

	    %total score the player has
	    Font.Draw (intstr (totalScore), 311, 344, font1, 38)

	    %you can press space to retry
	    if chars (' ') then
		gameover := false
		retry := true
		exit
	    end if

	    %yes button
	    if x >= 131 and y >= 188 and x <= 261 and y <= 232 then
		Pic.Draw (GameOver_YesButton, 131, 188, picCopy)

		%if clicked, then retry the level
		if button = 1 then
		    gameover := false
		    delay (100)
		    retry := true
		    exit
		end if

		%no button
	    elsif x >= 362 and y >= 188 and x <= 492 and y <= 232 then
		Pic.Draw (noButton, 362, 188, picCopy)

		%if clicked, then go back to menu screen
		if button = 1 then
		    retry := false
		    delay (100)
		    gameover := true

		    exit
		end if

	    end if

	    View.Update

	end loop
    end if

end LevelOver

cls     %clear screen from the loading pic


%----------------------------------THE GAME-----------------------------------%
loop     %title screen
    Music.PlayFileLoop ("Other files/Just Be Friends.mp3")

    title_screen

    %close the window when the user clicks the exit button
    if closeWindow then
	Window.Close (window)
	closeWindow := false
	Music.PlayFileStop
	exit
    end if

    level := 1

    loop     %main game

	loop %level loop

	    %setting new level defaults
	    ground_height := 120
	    BGy := 0
	    lvlPoints := 0

	    %where the player starts in each level
	    x1 := 0
	    y1 := 0

	    %which level to load
	    if level = 1 then
		View.Set ("title:Eat the Sweets - Level 1")
		background := bg (1).img    %level 1 bg image
		include "Levels/level 1.t"         %level 1 platform and item locations
		totalScore := 0             %resetting the score to 0
		LevelTitle := Level1        %level title screen

	    elsif level = 2 then
		View.Set ("title:Eat the Sweets - Level 2")
		cls
		background := bg (2).img
		include "Levels/level 2.t"
		LevelTitle := Level2

	    elsif level = 3 then
		View.Set ("title:Eat the Sweets - Level 3")
		cls
		background := bg (3).img
		include "Levels/level 3.t"
		LevelTitle := Level3

	    end if

	    loop    %level title screen
		cls
		Pic.Draw (background, 0, BGy, picCopy)
		Pic.Draw (LevelTitle, 250, 300, picMerge)

		View.Update

		Time.DelaySinceLast (600)

		exit
	    end loop    %level 1 title screen

	    scrollSpeed := 1        %makes the level start scrolling down
	    runSpeed := 1           %enabling movement
	    jumpSpeed := 15         %enabling jumping

	    loop    %level play
		
	    %redos the level or loads next level
		if retry then
		    retry := false
		    
		    %if last level
		    if level = 4 then   %if 'level 4' then make it back to level 1
			level := 1
		    end if
		    exit
		
		    %if player said not to redo level then exit game
		elsif gameover then
		    exit
		else
		    Level       %load level
		    put "Level Score: ", lvlPoints : 3, "     Level: ", level       %level score
		    
		    View.Update
		    
		    %level cleared
		    LevelClear
		    
		    %or game over'd
		    LevelOver

		    Time.DelaySinceLast (17) %makes the controls less responsive and easier to control
		    View.Update              %brings the drawn images to the screen
		    cls                      %erases everything on the screen so only the currently drawn frame will show

		end if

	    end loop     %end level game
	    
	    %if user said to exit game then exit this loop
	    if gameover then
		exit
	    end if

	end loop     %level 1
	
	%if user said to exit game then exit this loop as well (which brings us back to title screen
	if gameover then
	    gameover := false
	    exit
	end if

    end loop         %main game

end loop         %end title screen loop

