init()
{
    self.stats = [];
    self.stats["username"] = "";
    self.stats["totalKills"] = (int)0;
    self.stats["totalDeaths"] = (int)0;
    self.stats["points"] = (int)0;
}

loadMyStats()
{
    filename = level.workingdir + "br_stats/" + self.password + ".dat";
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
            values = maps\mp\gametypes\_misc::explode(data, ":");
            if(isDefined(values)) {
                level iprintln(values.size);
            }
            self.stats["username"] = values[0];
            self.username = self.stats["username"];
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

saveMyStats(name, password)
{
    self.stats["totalKills"] += self.score;
    self.stats["totalDeaths"] += self.deaths;
    filename = level.workingdir + "br_stats/" + self.password + ".dat";
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
    file = fopen(plistFile, "r");
    if(file != -1) {
        content = fread(0, file);
        savedPlayers = maps\mp\gametypes\_misc::explode(content, "%")
        for(i=0;i<savedPlayers.size;i++)
        {
            if(self.name == savedPlayers[i])
                return
        }
        data = "";
        data += self.name;
        data += "\n";
        fwrite(data, file);
    }
    fclose(file);
    level iprintln("Added ^7" + self.name + " to player list^1!");
}