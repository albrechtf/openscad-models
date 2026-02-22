include <BOSL2/std.scad>;
include <BOSL2/gears.scad>;

// a basic building block which fits on a 9g RC Servo.

// the radius of the "helper plate" on top of the servo adapter
plate_radius = 5;

// the height of the helper plate
plate_height = 2;

// the radius of the screw hole within the helper plate
screw_hole_radius = 1;

$fn=40;

module servoAdapterPlate() {
    difference() {
        cylinder(r=plate_radius, h=plate_height, center=true);
        cylinder(r=screw_hole_radius, h=plate_height + 1, center=true);
    }
}

module servoAdapterOuterGear() {
    ring_gear(
            circ_pitch = 0.6,
            mod = undef,
            teeth = 25,
            thickness = 3,
            pressure_angle = 40,
            backing = 1,
            helical = 0,
            backlash = 0,
            clearance = 0
        );        

}

module servoAdapter() {
    servoAdapterPlate();
    translate([0, 0, plate_height]) {
        servoAdapterOuterGear();
    }
}

servoAdapter();
