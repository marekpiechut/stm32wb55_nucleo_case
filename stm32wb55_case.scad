include <roundedCube.scad>

$fa = 1;
$fs = 0.4;

height =  15;
cover_distance = 6;

pcb = [[0, 2], [11, 2], [13, 0], [46, 0], [48, 2], [70.7, 2], [70.7, 57.2], [31, 57.2], [29, 59.7], [29, 64.6], [0, 64.6], [0, 0]];

module usb_holes() {
	roundedCube([25, 20, 9], 1, false, true, false);
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
	translate([34.5, -8, 4.5]) usb_holes();
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
		translate([0, 10, 0]) cube([0.3, 1, height]);
		translate([0, 54.4 , 0]) cube([0.3, 1, height]);
		translate([70.4, 10, 0]) cube([0.3, 1, height]);
		translate([70.4, 49 , 0]) cube([0.3, 1, height]);
	}
}

module the_cover() {
	union() {
		difference() {
			linear_extrude(height + cover_distance) {
				offset(r=4.4) {
					polygon(pcb);
				}
			}
			translate([0, 0, -3]) linear_extrude(height + cover_distance + 1) {
				offset(r=2.4) {
					polygon(pcb);
				}
			}
			translate([1, 1, -2]) roundedCube([13, 57, 50]);
			translate([5, 1, -2]) roundedCube([13, 57, 500]);
			translate([34.5, -8, -1]) roundedCube([25, 20, 14.5], 1, false, true, false);
			translate([35.25, 28.5, height + cover_distance - 0.4]) radiation();
		}
		translate([-2.4, 15, 0]) cube([0.3, 1, height + cover_distance]);
		translate([-2.4, 49.4 , 0]) cube([0.3, 1, height + cover_distance]);
		translate([72.8, 15, 0]) cube([0.3, 1, height + cover_distance]);
		translate([72.8, 44 , 0]) cube([0.3, 1, height + cover_distance]);
	}
}

the_case();
the_cover();
//translate([0, -80, 0]) the_case();