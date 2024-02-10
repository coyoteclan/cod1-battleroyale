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
        if(file != -1)
            data = fread(0, file); // codextended.so bug?
        fclose(file); // all-in-one chunk

        if(isDefined(data)) {
            values = maps\mp\gametypes\_misc::explode(data, "\n");
            for(i = 0; i < data.size; i++) {
                if(!isDefined(data[i])) // crashed here for some odd reason? this should never happen
                    continue; // crashed here for some odd reason? this should never happen
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
    data = self.name + ":" + self.stats["totalKills"] + ":" + self.stats["totalDeaths"] + ":" + self.points;
    filename = level.workingdir + "br_stats/" + self.password + ".dat";
    file = fopen(filename, "w");
    if(file != -1)
        fwrite(data, file);
    wait 0.5;
    fclose(file);
}

addTolist()
{
    plistFile = level.workingdir + "br_stats/playerlist.dat";
    if(!fexists(plistFile)) {
        file = fopen(plistFile, "w");
        fwrite("", file);
        fclose(file);
    } //Will move it to somewhere else
    file = fopen(plistFile, "r");
    if(file != -1)
        content = fread(0, file);
    fclose(file);
    
    savedPlayers = maps\mp\gametypes\_misc::explode(content, "\n")
    for(i=0;i<savedPlayers.size;i++)
    {
        if(self.name == savedPlayers[i])
            return;
    }
    data = self.name;
    data += "\n";
    file = fopen(plistFile, "w");
    if(file != -1)
        fwrite(data, file);
    fclose(file);
    level iprintln("Added ^7" + self.name + " to player list^1!");
}