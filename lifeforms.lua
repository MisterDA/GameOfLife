function loadLifeforms (t)
    t.char = {
        ["dead"]    = ' ',
        ["alive"]   = '#',
        ["newline"] = '$',
    }
    t.lf = {
        {"block", "##$##"},
        {"glider", " # $  #$###"},
        {"blinker", "###"},
        {"r-pentomino", "4 $ #  $3# $  # "},
        {"t", " 3#$  # $4 $4 "},
        {"phoenix", "4 #3 $  # #3 $6 # $##6 $6 ##$ #6 $3 # #  $3 #4 "},
        {"acorn", "8 $8 $ #6 $3 #4 $##  3# $8 $8 $8 "},
        {"rabbits", "#3 3#$$#  # $ #5 "},
        {"glider-gun", "24 #11 $22 # #11 $12 ##6 ##12 ##$11 #3 #4 ##12 ##$##8 #5 #3 ##14 $##8 #3 # ##4 # #11 $10 #5 #7 #11 $11 #3 #20 $12 ##22 $"}
    }
end
