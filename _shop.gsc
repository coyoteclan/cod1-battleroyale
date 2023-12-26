health() {
    self endon("death");
    self endon("spawned_spectator");

    if(!isPlayer(self)) {
        return;
    }
    if(!isDefined(self.hpacks)) {
        self.hpacks = getCvarInt("br_healthpacks");
    }
    hud_hpacks destroy();

    hud_hpacks = newClientHudElem();
    hud_hpacks.x = 9;
    hud_hpacks.y = 286;
    hud_hpacks.label = &"Healthpacks^1: ^7";
    hpnum = self.hpacks;
    hud_hpacks setValue(hpnum);
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