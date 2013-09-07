function loadLifeforms (t)
    t.char = {
        ["dead"]    = ' ',
        ["alive"]   = '#',
        ["newline"] = '$',
    }
    t.lf = {
        {"eater", "##  $#   $ ###$   #"},
        {"block", "##$##"},
        {"glider", " # $  #$###"},
        {"blinker", "###"},
        {"r-pentomino", "  #$###$ # $"},
        {"glider-gun", "24 #11 $22 # #11 $12 ##6 ##12 ##$11 #3 #4 ##12 ##$##8 #5 #3 ##14 $##8 #3 # ##4 # #11 $10 #5 #7 #11 $11 #3 #20 $12 ##22 $"}
    }
    t.count = #t.lf
end
