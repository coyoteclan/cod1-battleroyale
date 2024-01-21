init()
{
    self.stats = [];
    self.stats["name"] = "";
    self.stats["totalKills"] = (int)0;
    self.stats["totalDeaths"] = (int)0;
    self.stats["points"] = (int)0;
    
    self.guid = assignGuid(self.name);
}

loadMyStats()
{
    filename = level.workingdir + "br_stats/" + self.guid + ".dat";
    self iprintln(filename);
    if(fexists(filename)) {
        file = fopen(filename, "r");
        if(file != -1) {
            data = fread(0, file);
            if(!isDefined(data) || data == "") {
                fclose(filename);
                return;
            }
            fclose(filename);
            values = explode(data, ":");
            if(isDefined(values)) {
                level iprintln(values.size);
            }
            self.stats["totalKills"] = values[1];
            self.stats["totalDeaths"] = values[2];
            self.stats["points"] = values[3];
            wait 1;
            self iprintln("Loaded^1! ^7Points: ^7" + self.stats["points"] + " Total Kills: ^7" + self.stats["totalKills"] + " Total Deaths: ^7" + self.stats["totalDeaths"]); // Will remove it later
        }
        else {
            level iprintln("Error opening " + filename + "^1!");
        }
    }
    else {
        level iprintln("This stats file doesn't exist... yet. ^7" + filename + "^1!");
    }
}

saveMyStats()
{
    self.stats["totalKills"] += self.score;
    self.stats["totalDeaths"] += self.deaths;
    filename = level.workingdir + "br_stats/" + self.guid + ".dat";
    file = fopen(filename, "w");
    if(file == -1) {
        level iprintln("error opening " + filename);
        fclose(filename);
        return;
    }
    data = self.name + ":" + self.stats["totalKills"] + ":" + self.stats["totalDeaths"] + ":" + self.points;
    fwrite(data, file);
    wait 0.5;
    fclose(file);
}

addTolist()
{
    if(!isDefined(plistFile))
        plistFile = level.workingdir + "br_stats/playerlist.dat";
    file = fopen(plistFile, "a");
    if(file != -1) {
        data = "";
        data += self.name;
        data += "%%" + self.guid;
        data += "\n";
        fwrite(data, file);
    }
    fclose(file);
    level iprintln("Added ^7" + self.name + " to player list^1!");
}

explode(s, delimiter)
{
    j = 0;
    temparr[j] = "";    
    
    for (i= 0; i < s.size; i++)
    {
        if (s[i] == delimiter)
        {
            j++;
            temparr[j] = "";
        }
        else
            temparr[j] += s[i];
    }
    return temparr;
}

assignGuid(name)
{
    int = 0;
    for(i=0;i<name.size;i++)
    {
        ch = name[i];
        
        int += charToDigit(ch);
    }
    int %= 10000;
    return int;
}

charToDigit(ch)
{
    switch (ch)
    {
        case "a":   return 100; break;   case "b":   return 101; break;
        case "c":   return 102; break;   case "d":   return 103; break;
        case "e":   return 104; break;   case "f":   return 105; break;
        case "g":   return 106; break;   case "h":   return 107; break;
        case "i":   return 108; break;   case "j":   return 109; break;
        case "k":   return 110; break;   case "l":   return 111; break;
        case "m":   return 112; break;   case "n":   return 113; break;
        case "o":   return 114; break;   case "p":   return 115; break;
        case "q":   return 116; break;   case "r":   return 117; break;
        case "s":   return 118; break;   case "t":   return 119; break;
        case "u":   return 120; break;   case "v":   return 121; break;
        case "w":   return 122; break;   case "x":   return 123; break;
        case "y":   return 124; break;   case "z":   return 125; break;
        case "0":   return 126; break;   case "1":   return 127; break;
        case "2":   return 128; break;   case "3":   return 129; break;
        case "4":   return 130; break;   case "5":   return 131; break;
        case "6":   return 132; break;   case "7":   return 133; break;
        case "8":   return 134; break;   case "9":   return 135; break;
        case "-":   return 136; break;   case ">":   return 137; break;
        case "<":   return 138; break;   case "(":   return 139; break; 	
        case ")":   return 140; break;   case "!":   return 141; break; 	
        case "@":   return 142; break;   case "#":   return 143; break; 	
        case "$":   return 144; break;   case "%":   return 145; break; 	
        case "&":   return 146; break;   case "*":   return 147; break; 	
        case "[":   return 148; break;   case "]":   return 149; break; 	
        case "{":   return 150; break;   case "}":   return 151; break; 	
        case ":":   return 152; break;   case ".":   return 153; break; 	
        case "?":   return 154; break;   case "^":   return 155; break;
        case "A":   return 156; break;   case "B":   return 156; break;
        case "C":   return 157; break;   case "D":   return 158; break;
        case "E":   return 159; break;   case "F":   return 160; break;
        case "G":   return 161; break;   case "H":   return 162; break;
        case "I":   return 163; break;   case "J":   return 164; break;
        case "K":   return 165; break;   case "L":   return 166; break;
        case "M":   return 167; break;   case "N":   return 168; break;
        case "O":   return 169; break;   case "P":   return 170; break;
        case "Q":   return 171; break;   case "R":   return 172; break;
        case "S":   return 173; break;   case "T":   return 174; break;
        case "U":   return 175; break;   case "V":   return 176; break;
        case "W":   return 177; break;   case "X":   return 178; break;
        case "Y":   return 179; break;   case "Z":   return 180; break;
        case "/":   return 181; break;   case "+":   return 182; break;
        case "~":   return 182; break;   case "`":   return 183; break;
        default:    return 0;
    }
}
