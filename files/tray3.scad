// Victorian Watercolor Box — Tray 3
// All measurements in millimeters

wall = 5;
floor = 3;
height = 25;

// Same exterior dimensions as trays 1 and 2
width = 265;
length = 190;

// Compartments
top = 50;
side = 65;
middle_top = 65;

// Circular wells
circle_diameter = 45;
middle_circle_diameter = 30;
circle_wall = 3;
circle_height = 12;

// Divider positions
top_y = length - 2*wall - top;

left_x = wall + side;
right_x = width - 2*wall - side;

middle_divider_y = top_y - wall - middle_top;

// Outer tray
difference() {
    cube([width, length, height]);

    translate([wall, wall, floor])
        cube([width-2*wall, length-2*wall, height]);
}

// Main horizontal divider
translate([wall, top_y, floor])
    cube([width-2*wall, wall, height-floor]);

// Three lower columns
for (x = [left_x, right_x])
    translate([x, wall, floor])
        cube([wall, top_y-wall, height-floor]);

// Middle column horizontal divider
translate([left_x+wall, middle_divider_y, floor])
    cube([right_x-left_x-wall, wall, height-floor]);

// Circular compartment
module circle_compartment(x, y, diameter) {
    translate([x, y, floor])
        difference() {
            cylinder(
                h = circle_height,
                d = diameter + 2*circle_wall,
                $fn = 64
            );

            translate([0, 0, -0.1])
                cylinder(
                    h = circle_height + 0.2,
                    d = diameter,
                    $fn = 64
                );
        }
}

// Four circles in outside columns
for (x = [wall+side/2, width-wall-side/2])
    for (y = [
        wall + (top_y-wall)/4,
        wall + 3*(top_y-wall)/4
    ])
        circle_compartment(x, y, circle_diameter);

// Three circles in bottom middle compartment
middle_start_x = left_x + wall;
middle_width = right_x - middle_start_x;

for (i = [0:2])
    circle_compartment(
        middle_start_x + (i+0.5)*middle_width/3,
        wall + (middle_divider_y-wall)/2,
        middle_circle_diameter
    );