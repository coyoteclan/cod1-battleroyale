log( type, a0, a1, a2, a3, a4, a5, a6, a7, a8,
			b0, b1, b2, b3, b4, b5, b6, b7, b8, b9 )
{
	if ( !game[ "mapstarted" ] )
		return;

	switch ( type )
	{
	  case "connect":
	  case "join":
	  	if ( isdefined( a0 ) && isPlayer( a0 ) )
	  		logPrint( "J;" + a0.name + "\n" );
	  	break;
	  case "disconnect":
	  case "quit":
	  	if ( isdefined( a0 ) && isPlayer( a0 ) )
	  		logPrint( "Q;" + a0.name + "\n" );
	  	break;
	  case "killed":
	  	player = a0;
	  	eAttacker = a1;
	  	iDamage = a2;
	  	sMeansOfDeath = a3;
	  	sWeapon = a4;
	  	sHitLoc = a5;

		lpselfname = player.name;

		if ( isPlayer( eAttacker ) )
		{
			lpattackname = eAttacker.name;
		}
		else
		{
			lpattackname = "world";
		}

		logPrint( "K;" + lpselfname + ";" + sWeapon + ";" + lpattackname + ";" + iDamage +
			";" + sMeansOfDeath + ";" + sHitLoc + "\n" );
		break;
	  case "winner":
	  	msg = a0;
	  	for ( i = 0; i < a1.size; i++ )
	  	{
	  		player = a1[ i ];
	  		if ( isPlayer( player ) )
		  		msg += ( ";" + player.name );
	  	}
		logPrint( "W;" + msg + "\n");
		break;
	  case "action":
	  	player = a0;
	  	team = a1;
	  	name = a2;
	  	action = a3;
		logPrint( "A;" + name + ";" + action + "\n" );
	  	break;
	  default:
	  	printLn( 0, "gamelog/log:: ^1WARNING: ^3UNKNOWN LOG TYPE^7 |", type, "|" );
	  	break;
	}

	return;
}