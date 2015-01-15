%platforms
platnum := 15           %number of platforms

new platform, platnum   %makes the platform array bigger

platform (1).height := ground_height + 100
platform (1).x1 := 100
platform (1).width := 150

platform (2).height := ground_height + 100
platform (2).x1 := 400
platform (2).width := 150

platform (3).height := ground_height + 200
platform (3).x1 := 250
platform (3).width := 100

platform (4).height := ground_height + 300
platform (4).x1 := 50
platform (4).width := 170

platform (5).height := ground_height + 410
platform (5).x1 := 240
platform (5).width := 100

platform (6).height := ground_height + 500
platform (6).x1 := 470
platform (6).width := 130

platform (7).height := ground_height + 250
platform (7).x1 := 520
platform (7).width := 100

platform (8).height := ground_height + 600
platform (8).x1 := 200
platform (8).width := 150

platform (9).height := ground_height + 600
platform (9).x1 := 0
platform (9).width := 150

platform (10).height := ground_height + 730
platform (10).x1 := 130
platform (10).width := 100

platform (11).height := ground_height + 680
platform (11).x1 := 0
platform (11).width := 60

platform (12).height := ground_height + 830
platform (12).x1 := 300
platform (12).width := 150

platform (13).height := ground_height + 940
platform (13).x1 := 120
platform (13).width := 130

platform (14).height := ground_height + 1040
platform (14).x1 := 300
platform (14).width := 90

platform (15).height := ground_height + 1140
platform (15).x1 := 500
platform (15).width := 139


%collection items

cakenum := 13       %how many sweets to collect

new food, cakenum   %to make the food array bigger

food (1).img := blueLolly
food (1).picx1 := 500                               %picture x coordinates
food (1).picy1 := platform (1).height + cakehover   %picture x coordinates
food (1).imgH := Pic.Height (food (1).img)          %height
food (1).imgW := Pic.Width (food (1).img)           %width
food (1).picx2 := food (1).picx1 + food (1).imgW    %picture x2 coordinates
food (1).picy2 := food (1).picy1 + food (1).imgH    %picture y2 coordinates
food (1).show := true                               %if the cake should show up
food (1).addPoints := false                         %if a point should be added to the score

food (2).img := cake
food (2).picx1 := 100
food (2).picy1 := platform (2).height + cakehover
food (2).imgH := Pic.Height (food (2).img)
food (2).imgW := Pic.Width (food (2).img)
food (2).picx2 := food (2).picx1 + food (2).imgW
food (2).picy2 := food (2).picy1 + food (2).imgH
food (2).show := true
food (2).addPoints := false

food (3).img := candyCane
food (3).picx1 := 300
food (3).picy1 := platform (3).height + cakehover
food (3).imgH := Pic.Height (food (3).img)
food (3).imgW := Pic.Width (food (3).img)
food (3).picx2 := food (3).picx1 + food (3).imgW
food (3).picy2 := food (3).picy1 + food (3).imgH
food (3).show := true
food (3).addPoints := false

food (4).img := strawberry
food (4).picx1 := 100
food (4).picy1 := platform (4).height + cakehover
food (4).imgH := Pic.Height (food (4).img)
food (4).imgW := Pic.Width (food (4).img)
food (4).picx2 := food (4).picx1 + food (4).imgW
food (4).picy2 := food (4).picy1 + food (4).imgH
food (4).show := true
food (4).addPoints := false

food (5).img := chocolate
food (5).picx1 := 300
food (5).picy1 := platform (5).height + cakehover
food (5).imgH := Pic.Height (food (5).img)
food (5).imgW := Pic.Width (food (5).img)
food (5).picx2 := food (5).picx1 + food (5).imgW
food (5).picy2 := food (5).picy1 + food (5).imgH
food (5).show := true
food (5).addPoints := false

food (6).img := birthday
food (6).picx1 := 500
food (6).picy1 := platform (6).height + cakehover
food (6).imgH := Pic.Height (food (6).img)
food (6).imgW := Pic.Width (food (6).img)
food (6).picx2 := food (6).picx1 + food (6).imgW
food (6).picy2 := food (6).picy1 + food (6).imgH
food (6).show := true
food (6).addPoints := false

food (7).img := strawberry
food (7).picx1 := 550
food (7).picy1 := platform (7).height + cakehover
food (7).imgH := Pic.Height (food (7).img)
food (7).imgW := Pic.Width (food (7).img)
food (7).picx2 := food (7).picx1 + food (7).imgW
food (7).picy2 := food (7).picy1 + food (7).imgH
food (7).show := true
food (7).addPoints := false

food (8).img := birthday
food (8).picx1 := 10
food (8).picy1 := platform (8).height + cakehover
food (8).imgH := Pic.Height (food (8).img)
food (8).imgW := Pic.Width (food (8).img)
food (8).picx2 := food (8).picx1 + food (8).imgW
food (8).picy2 := food (8).picy1 + food (8).imgH
food (8).show := true
food (8).addPoints := false

food (9).img := blueLolly
food (9).picx1 := 10
food (9).picy1 := platform (11).height + cakehover
food (9).imgH := Pic.Height (food (9).img)
food (9).imgW := Pic.Width (food (9).img)
food (9).picx2 := food (9).picx1 + food (9).imgW
food (9).picy2 := food (9).picy1 + food (9).imgH
food (9).show := true
food (9).addPoints := false

food (10).img := cake
food (10).picx1 := 250
food (10).picy1 := platform (10).height + 100
food (10).imgH := Pic.Height (food (10).img)
food (10).imgW := Pic.Width (food (10).img)
food (10).picx2 := food (10).picx1 + food (10).imgW
food (10).picy2 := food (10).picy1 + food (10).imgH
food (10).show := true
food (10).addPoints := false

food (11).img := candyCane
food (11).picx1 := 400
food (11).picy1 := platform (12).height + 130
food (11).imgH := Pic.Height (food (11).img)
food (11).imgW := Pic.Width (food (11).img)
food (11).picx2 := food (11).picx1 + food (11).imgW
food (11).picy2 := food (11).picy1 + food (11).imgH
food (11).show := true
food (11).addPoints := false

food (12).img := birthday
food (12).picx1 := 400
food (12).picy1 := platform (14).height + cakehover
food (12).imgH := Pic.Height (food (12).img)
food (12).imgW := Pic.Width (food (12).img)
food (12).picx2 := food (12).picx1 + food (12).imgW
food (12).picy2 := food (12).picy1 + food (12).imgH
food (12).show := true
food (12).addPoints := false

food (13).img := strawberry
food (13).picx1 := 500
food (13).picy1 := platform (15).height + 50
food (13).imgH := Pic.Height (food (13).img)
food (13).imgW := Pic.Width (food (13).img)
food (13).picx2 := food (13).picx1 + food (13).imgW
food (13).picy2 := food (13).picy1 + food (13).imgH
food (13).show := true
food (13).addPoints := false
