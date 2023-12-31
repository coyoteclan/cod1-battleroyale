init()
{
	
	level.points = [];
	level.points[ "buy_armor_10" ] = 100;
	level.points[ "buy_armor_25" ] = 250;
	level.points[ "buy_armor_50" ] = 500;
	level.points[ "buy_damage_10" ] = 100;
	level.points[ "buy_damage_25" ] = 250;
	level.points[ "buy_healthpack" ] = 100;
	level.points[ "mortar" ] = 1000;
	level.points[ "buy_panzer" ] = 500;
	level.points[ "buy_nades" ] = 200;
	
	level.pointsnames = [];
	level.pointsnames[ "buy_armor_10" ] = "100 Armor";
	level.pointsnames[ "buy_armor_25" ] = "250 Armor";
	level.pointsnames[ "buy_armor_50" ] = "500 Armor";
	level.pointsnames[ "buy_damage_10" ] = "+10 Damage Increase";
	level.pointsnames[ "buy_damage_25" ] = "+25 Damage Increase";
	level.pointsnames[ "buy_healthpack" ] = "a Healthpack";
	level.pointsnames[ "mortar" ] = "Mortar Strike";
	level.pointsnames[ "buy_panzer" ] = "a Panzerfaust";
	level.pointsnames[ "buy_nades" ] = "Flashbangs";

}

menuHandler(response) {
    if(self.sessionstate != "playing")
        return;
    
    if(!isDefined(level.points[response])) {
        self iprintln("That item is not available on shop!");
        return;
    }
    if(self.points < level.points[response]) {
        self iprintln("You're too ^1poor^7. Can't ^3afford ^7that!");
        return;
    }
    else {
        //self buyItem(response);
        if(self buyItem(response)) {
            self iprintlnbold( "You bought ^2" + level.pointsnames[ response ] + "^7 for " + level.points[ response ] + " points." );
            self.points -= level.points[response];

        }
    }
}

buyItem(response) {
    switch(response)
    {
        case "buy_healthpack":
            self.hpacks++;
            wait 0.5;
            //self.hud_hpacks setValue(self.hpacks);
            //break;
            return true;
            
        case "buy_armor_10":
            if(self.bodyarmor >= 500) {
                self iprintlnbold("You already have max armor!");
                return false;
            }
            else if(self.bodyarmor + 100 > 500) {
                self.bodyarmor = 500;
                wait 0.5;
                return true;
            }
            else {
                self.bodyarmor += 100;
                return true;
            }
        
        case "buy_armor_25":
            if(self.bodyarmor >= 500) {
                self iprintlnbold("You already have max armor!");
                return false;
            }
            else if(self.bodyarmor + 250 > 500) {
                self.bodyarmor = 500;
                wait 0.5;
                return true;
            }
            else {
                self.bodyarmor += 250;
                return true;
            }
        
        case "buy_armor_50":
            if(self.bodyarmor >= 500) {
                self iprintlnbold("You already have max armor!");
                return false;
            }
            else if(self.bodyarmor == 0) {
                self.bodyarmor += 500;
                wait 0.5;
                return true;
            }
            else if(self.bodyarmor > 0) {
                self.bodyarmor = 500;
                return true;
            }
        
        case "buy_damage_10":
            if(self.damageinc >= 25) {
                self iprintlnbold("You already have max damage increase.");
                return false;
            }
            else if(self.damageinc + 10 > 25) {
                self.damageinc = 25;
                return true;
            }
            else {
                self.damageinc += 10;
                return true;
            }
        
        case "buy_damage_25":
            if(self.damageinc >= 25) {
                self iprintlnbold("You already have max damager increase.");
                return false;
            }
            else if(self.damageinc + 25 > 25) {
                self.damageinc = 25;
                return true;
            }
            else {
                self.damageinc += 25;
                return true;
            }
        
        case "buy_panzer"
        default:
            return false;
    }
}

shophud() {
    self endon("death");
    self endon("spawned_spectator");

    if(!isPlayer(self)) {
        return;
    }
    self.points = (int)10;
    if(getCvarInt("br_startpoints")) {
        self.points = getCvarInt("br_startpoints");
    }

    self.hpacks = (int)1;
    if(getCvarInt("br_starthealthpacks")) {
        self.hpacks = getCvarInt("br_starthealthpacks");
    }
    //hud_hpacks destroy();
    self.bodyarmor = (int)0;
    if(getCvarInt("br_startbodyarmor")) {
        self.bodyarmor = getCvarInt("br_startbodyarmor");
    }

    self.damageinc = (int)0;

    self.hud_points = newClientHudElem(self);
    self.hud_points.x = 531;
    self.hud_points.y = 310;
    self.hud_points.label = &"Points^1: ^7";

    self.hud_hpacks = newClientHudElem(self);
    self.hud_hpacks.x = 531;
    self.hud_hpacks.y = 326;
    self.hud_hpacks.label = &"Healthpacks^1: ^7";

    self.hud_armor = newClientHudElem(self);
    self.hud_armor.x = 531;
    self.hud_armor.y = 342;
    self.hud_armor.label = &"Armor^1: ^7";

    self.hud_damageinc = newClientHudElem(self);
    self.hud_damageinc.x = 531;
    self.hud_damageinc.y = 358;
    self.hud_damageinc.label = &"Damage Upgrade^1: ^7";

}

throwHealth() {
    if(self.hpacks > 0) {
        if(isDefined(level.healthqueue[level.healthqueuecurrent]))
            level.healthqueue[level.healthqueuecurrent] delete();
        
        level.healthqueue[level.healthqueuecurrent] = spawn("item_health", self.origin + (0, 0, 1));
        level.healthqueue[level.healthqueuecurrent].angles = (0, randomInt(360), 0);

        level.healthqueuecurrent++;
        if(level.healthqueuecurrent >=16)
            level.healthqueuecurrent = 0;

        self.hpacks -= 1;
        wait 10;
    }
    else
        self iprintln("You are ^2broke^7, you don't have any healthpacks ^3:(");
}

AliveTimeReward() {
    while(isPlayer(self) && isAlive(self))
    {
        wait level.alivetime;
        self.points += level.alivepoints;
        wait 0.5;
    }
}
