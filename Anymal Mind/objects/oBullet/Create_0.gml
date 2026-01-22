damage_to_p1 = 1;
damage_to_p2 = 1;
damage_to_enemy = 2;
damage_to_boss = 1;

life = 720;           // frames until despawn (prevents infinite bullets)

hit_radius = 6;       // collision radius for point-distance hits
pierce = true;        // goes through walls AND through targets (multi-hit)
hit_same_target_cooldown = 6; // stops rapid multi-hits each frame

// store per-instance last hit times using a ds_map
hit_cd = ds_map_create();