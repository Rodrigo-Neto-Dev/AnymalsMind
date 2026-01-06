ysp += 0.1 * _gravity;
xsp = 0;

set_camera();
check_menus();
check_mouse();

transform();
execute_behaviors();

#region BIRD
    if (current_animal == "Bird") {
		//
	}
#endregion

#region BEAR
    if (current_animal == "Bear") {
		//
	}
#endregion

#region FROG
    if (current_animal == "Frog") {
		//
	}
#endregion

#region CAT
    if (current_animal == "Cat") {
		//
	}
#endregion

#region GRIFFON -> BIRD + CAT
    if (current_animal == "Griffon") {
		//
    }
#endregion

prepare_move();
execute_move();
