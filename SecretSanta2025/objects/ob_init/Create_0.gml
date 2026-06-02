log("Game initialized.");


// COOLMATH GAMES QUIT SECTION
    domain = url_get_domain();

    if(domain != "https://www.coolmath-games.com" &&
    domain != "m.coolmathgames.com" &&
    domain != "dev.coolmathgames.com" &&
    domain != "edit-stage.coolmathgames.com" &&
    domain != "stage.coolmathgames.com" &&
    domain != "edit.coolmathgames.com" &&
    domain != "www.coolmathgames.com" &&
    domain != "https://www.coolmathgames.com" &&
    domain != "m.coolmath-games.com" &&
    domain != "dev.coolmath-games.com" &&
    domain != "edit-stage.coolmath-games.com" &&
    domain != "stage.coolmath-games.com" &&
    domain != "edit.coolmath-games.com" &&
    domain != "www.coolmath-games.com")
    {
        game_end();
        exit;
    }
// 

// prevent default scaling behaviour:
surface_resize(application_surface, RES_W, RES_H);
display_set_gui_size(RES_W, RES_H);
window_set_size(RES_W * WINDOW_SCALE, RES_H * WINDOW_SCALE);
window_center();


room_goto(rm_clicktofocus);
