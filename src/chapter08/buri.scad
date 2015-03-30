//buri.scad

tol = 0.4;

engine_radius = 17.5 / 2;
engine_height = 70;

nose_assembly_thickness = 1.2;
nose_assembly_slot_height = 5;

module a8_3_engine() {
  cylinder(engine_height, engine_radius + tol, engine_radius + tol);
}

difference() {
  // the nose cone
  difference() {
    scale([1, 1, 3]) {
      sphere(engine_radius + nose_assembly_thickness);
    }
    translate([0, 0, -4 / 2 * engine_radius]) {
      cube(4 * engine_radius * [1, 1, 1], true);
    }
  }

  translate([0, 0, nose_assembly_slot_height]) {
    mirror([0, 0, 1]) {
      // the engine
      // remove the '#' that was in front of the cylinder()
      a8_3_engine()

      // the inner dome
      sphere(engine_radius + tol);
    }
  }
}


