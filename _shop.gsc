health() {
    self endon("death");
    self endon("spawned_spectator");

    if(!isPlayer(self)) {
        return;
    }
    self.hpacks = 1;
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
    }
    else
        self iprintln("You are ^2broke^7, you don't have any healthpacks ^3:(");
}