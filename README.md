# randstr

    perl randstr.pl [option] [num]

# Synopsis

    perl randstr.pl 5    #=> +/2ox
    perl randstr.pl -d 5 #=> 91486
    perl randstr.pl -w 5 #=> vkDrV
    perl randstr.pl -m 5 #=> 4Md8g
    perl randstr.pl -l 5 #=> jajnu
    perl randstr.pl -u 5 #=> OKKQX
    perl randstr.pl      #=> 5Gwl1PJsNCL0lrqdHty5wGhy66kz61ixwm11qFZchU3LyweQlVc9GEmdY/lLD2QytB8qWifJDo520tGg0Aktu8HiFlwnF+VJV97w
                         # Unless num, output 100 chars.

# Options

    -d --digit           Set digit
    -w --word            Set words
    -m --mix             Set digit & words
    -l --lower           Set lower case
    -u --upper           Set upper case
    -h --help            Show help

