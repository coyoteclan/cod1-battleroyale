init()
{
	[[ level.logwrite ]]( "maps\\mp\\gametypes\\_buymenu.gsc::init()", true );
	
	level.points = [];
	level.points[ "buy_armor_10" ] = 100;
	level.points[ "buy_armor_25" ] = 250;
	level.points[ "buy_armor_50" ] = 500;
	level.points[ "buy_damage_10" ] = 100;
	level.points[ "buy_damage_25" ] = 250;
	level.points[ "buy_healthpack" ] = 100;
	level.points[ "mortar" ] = 5000;
	level.points[ "buy_panzer" ] = 1000;
	level.points[ "buy_nades" ] = 500;
	
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
            wait 1;
            self.hud_hpacks setValue(self.hpacks);
            break;
        default:
            break;
    }
}

shophud() {
    self endon("death");
    self endon("spawned_spectator");

    if(!isPlayer(self)) {
        return;
    }
    self.hpacks = (int)1;
    if(getCvarInt("br_healthpacks")) {
        self.hpacks = getCvarInt("br_healthpacks");
    }
    //hud_hpacks destroy();

    self.hud_hpacks = newClientHudElem(self);
    self.hud_hpacks.x = 9;
    self.hud_hpacks.y = 286;
    self.hud_hpacks.label = &"Healthpacks^1: ^7";
    //self.hpnum = self.hpacks;
    self.hud_hpacks setValue(self.hpacks);
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
        self.hud_hpacks setValue(self.hpacks);
        wait 10;
    }
    else
        self iprintln("You are ^2broke^7, you don't have any healthpacks ^3:(");
}