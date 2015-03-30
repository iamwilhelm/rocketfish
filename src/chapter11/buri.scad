ARR = "print";
tol = 0.4;

engine_radius = 17.5 / 2;
engine_height = 70;

nose_assembly_height = 26.25;
nose_assembly_thickness = 1.2;
nose_assembly_slot_height = 5;
nose_assembly_radius = engine_radius + nose_assembly_thickness;

module with_tol(size) {
  resize(size + tol * [1, 1, 1]) {
    children();
  }
}

// chops off model on entire side of plane
module chop(r, plane) {
  difference() {
    children();

    theta = plane[0] == 0 ? 0 : atan(plane[1] / plane[0]);
    phi_abs = atan(sqrt(pow(plane[0], 2) + pow(plane[1], 2)) / plane[2]);
    phi_sign = plane[0] > 0 ? phi_abs : -phi_abs;
    phi = plane[2] >= 0 ? phi_sign : phi_sign + 180;
    
    // cut off below plane
    rotate([0, 0, theta])
      rotate([0, phi, 0])
        translate(-r * [0, 0, 1])
          //with_tol((2 * r) * [1, 1, 1])
            cube((2 * r) * [1, 1, 1], true);
  }
}

module a8_3_engine() {
  with_tol([engine_radius * 2, engine_radius * 2, engine_height]) {
    cylinder(engine_height, engine_radius, engine_radius);
  }
}

module parabolic_cone(height, radius) {
  chop(10, [0, 0, 1]) {
    scale([1, 1, height / radius]) {
      sphere(radius);
    }
  }
}

module nose_assembly(height, radius, thickness, slot_inset) {
  difference() {
    // the nose cone
    parabolic_cone(height, radius);

    translate([0, 0, slot_inset]) {
      mirror([0, 0, 1]) {
        // the engine
        // remove the '%' that was in front of the cylinder()
        a8_3_engine();

        // the inner dome
        sphere(radius - thickness + tol);
      }
    }
  }
}

module buri() {
  if (ARR == "assembly") {
    // The arragement when the part is assembled
  } else if (ARR == "explode") {
    // The arragement when the part is exploded
  } else if (ARR == "print") {
    // The arragement when the part is to be printed

    nose_assembly(nose_assembly_height, nose_assembly_radius,
                  nose_assembly_thickness, nose_assembly_slot_height);
  }
}

buri();

