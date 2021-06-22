include <roundedCube.scad>

$fa = 1;
$fs = 0.4;

height =  15;

pcb = [[0, 2], [11, 2], [13, 0], [45, 0], [47, 2], [70.5, 2], [70.5, 57], [31, 57], [29, 59.5], [29, 64.4], [0, 64.4], [0, 0]];

module usb_holes() {
	roundedCube([24.5, 20, 5], 1, false, true, false);
}

module exterior() {
	linear_extrude(height) {
		offset(r=2) {
				polygon(pcb);
		}
	}
}

module interior() {
	translate([0, 0, 2]) linear_extrude(height) {
		polygon(pcb);
	}
	translate([34.5, -8, 6]) usb_holes();
}

module battery_hole() {
	translate([45, 25.4, -1]) cylinder(h = 20, r = 15, center = true, $fn = 6);
}

module logo() {
	linear_extrude(height = 1, center = true)
	rotate([180, 0, 0])
	resize([12, 15, 0])
	import("dayone-logo.svg", center = true);
}

module radiation() {
	linear_extrude(height = 1, center = true)
	resize([24, 24, 0])
	import("radiation.svg", center = true);
}

module the_case() {
	union() {
		difference() {
			exterior();
			interior();
			battery_hole();
			translate([14, 28, 0]) logo();
		}
		translate([0, 10, 0]) cube([0.6, 1, height]);
		translate([0, 54.4 , 0]) cube([0.5, 1, height]);
		translate([69.9, 10, 0]) cube([0.6, 1, height]);
		translate([69.9, 49 , 0]) cube([0.5, 1, height]);
	}
}

module the_cover() {
	union() {
		difference() {
			linear_extrude(height) {
				offset(r=2.4) {
					polygon(pcb);
				}
			}
			translate([0, 0, -3]) linear_extrude(height + 1) {
				offset(r=0.4) {
					polygon(pcb);
				}
			}
			translate([4, 1, -2]) roundedCube([13, 55, 20]);
			translate([53, 1, -2]) roundedCube([13, 55, 20]);
			translate([34.5, -8, -1]) roundedCube([24.5, 20, 10], 1, false, true, false);
			translate([35.25, 28.5, height - 0.4]) radiation();
		}
		translate([-0.4, 10, 0]) cube([0.5, 1, height]);
		translate([-0.4, 54.4 , 0]) cube([0.5, 1, height]);
		translate([70.4, 10, 0]) cube([0.5, 1, height]);
		translate([70.4, 49 , 0]) cube([0.5, 1, height]);
	}
}

//the_case();
the_cover();
translate([0, -80, 0]) the_case();