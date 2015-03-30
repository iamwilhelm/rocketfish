// buri.scad

engine_radius = 17.5 / 2;
engine_height = 70;

nose_assembly_thickness = 1.2;

// the engine
//cylinder(engine_height, engine_radius, engine_radius);

// the nose cone
difference() {
  scale([1, 1, 3]) {
    sphere(engine_radius + nose_assembly_thickness);
  }
  translate([0, 0, -4 / 2 * engine_radius]) {
    cube(4 * engine_radius * [1, 1, 1], true);
  }
}

