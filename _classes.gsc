init()
{
    self thread assignClass();
}

assignClass()
{
    switch(self.pers["camouflage"])
    {
        case "american":
            self.class = &"Armored";
            self.maxhealth = 125;
            self.bodyarmor += 100;
            self.hpacks += (int)1;
            break;
        
        case "german":
            self.class = &"Defender";
            self.maxhealth = 150;
            self.health = 125;
            self.bodyarmor += 70;
            self.hpacks += (int)3;
            self.ammobox += 1;
            break;
        
        case "russian":
            self.class = &"Assassin";
            self.bodyarmor += 50;
            self.hpacks += (int)2;
            self.ammobox += 1;
            break;
        
        case "british":
            self.class = &"Engineer";
            self.bodyarmor += 70;
            self.hpacks += (int)2;
            self.ammobox += 2;
            break;
    }
}