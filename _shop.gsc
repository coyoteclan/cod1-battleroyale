health() {
    self endon("death");
    self endon("spawned_spectator");

    if(!isPlayer(self)) {
        return;
    }
    if(!isDefined(self.hpacks)) {
        self.hpacks = getCvarInt("br_healthpacks");
    }
    hud_hpacks = newClientHudElem();
    hud_hpacks.label = &"Healthpacks^1: ^7"
    hud_hpacks.x = 9;
    hud_hpacks.y = 286;
    hud_hpacks setValue(self.hpacks);
}