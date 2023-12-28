## Battle royale gametype for Call of Duty 1 (2003)
Supported multiplayer patch: **1.1**
Not compatible with CoDaM.
### Some setup instructions

- make the server to use ***fs_game*** not to override some players *main* folder files.
- pack everything in the ***assets*** into ***zz_assets.pk3*** (or any name) and put  in the *fs_game* folder, this file must be downloaded by the client.
- setup ***br.gsc*** in a *pk3* file like a stock gametype and put it in the *fs_game* folder.
  - give the priority to this pk3 over the assets one, because the assets pk3 contains a file named *br.gsc* too
- use the *zh_frenzy* map version of this repo.
- use the CoDExtended server extension.
  - i suggest [my fork](https://github.com/raphael12333/codextended-server) e.g. to allow non-living players to talk without showing messages to alive players
___
### Some TODO
- Prevent players from getting stuck in each other when exiting plane
  - MiscMod's [_newspawn function](https://github.com/cato-a/CoDaM_MiscMod/blob/4db1d420b87b766eb9bffb352a7d9c13eaa0c851/___CoDaM_MiscMod/codam/_mm_mmm.gsc#L379) might help
- Make the zone to move when shrinking
- Fill roofs and holes on the map
- Show the full zone on compass instead of just the center
- Create models and animations for skydiving
  - applying animations might require to add a `setAnim` GSC command to CoDExtended, like libcod
___
#### [Some videos](https://www.youtube.com/playlist?list=PLTiI1XPSd-uVS_saGvqfgk7hgguxHc1Y0)
#### [More](https://coyote.rf.gd/battleroyale)
___
#### Some credits
- ***zh_frenzy*** map: thanks to zilch
- The [Killtube](https://www.killtube.org/) community
- [cod.pm](https://cod.pm/)
  - Thanks to Cato
- [CoDExtended](https://github.com/xtnded/codextended)
- [vCoDMods](https://www.vcodmods.com/)
- ***Base*** parachute model*: [Parachute - Low Poly](https://skfb.ly/ootAq) by calebcram is licensed under [Creative Commons Attribution](http://creativecommons.org/licenses/by/4.0/).
- ***Shop*** from Cheese's [Zombies Mod](https://github.com/thecheeseman/zombies_v5_r13)
