tol = 0.4;

engine_radius = 17.5 / 2;
engine_height = 70;

nose_assembly_height = 26.25;
nose_assembly_thickness = 1.2;
nose_assembly_slot_height = 5;
nose_assembly_radius = engine_radius + nose_assembly_thickness;

module a8_3_engine() {
  cylinder(engine_height, engine_radius + tol, engine_radius + tol);
}

module parabolic_cone(height, radius) {
  difference() {
    scale([1, 1, height / radius]) {
      sphere(radius);
    }

    translate([0, 0, -4 / 2 * radius]) {
      cube(4 * radius * [1, 1, 1], true);
    }
  }
}

difference() {
  // the nose cone
  parabolic_cone(nose_assembly_height, nose_assembly_radius);

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
