health() {
    self endon("death");

    if(!isPlayer(self)) {
        return;
    }
    if(!isDefined(self.hpacks)) {
        self.hpacks = getCvarInt("br_healthpacks");
    }
}