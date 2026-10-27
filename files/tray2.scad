// Victorian Watercolor Box — Second Tray
// All dimensions in millimeters

wall = 5;
floor = 3;
height = 25;

width = 265;
length = 190;

// Sections
grid_height = 100;     // 90 requested + 10 to match top tray
middle_height = 25;
bottom_height = 45;

// Pan grid
columns = 6;
rows = 4;
grid_width = 210;

// Circular wells
well_diameter = 24;
well_wall = 3;
well_height = 12;

// Section positions, bottom to top
bottom_y = wall;
middle_y = bottom_y + bottom_height + wall;
grid_y = middle_y + middle_height + wall;

// Grid dimensions
cell_width = grid_width / columns;
cell_height = grid_height / rows;

// Seventh column starts after grid
side_x = wall + grid_width;

// Main tray
difference() {
    cube([width, length, height]);

    translate([wall, wall, floor])
        cube([width - 2*wall,
              length - 2*wall,
              height]);
}

// Horizontal section dividers
for (y = [middle_y - wall, grid_y - wall])
    translate([wall, y, floor])
        cube([width - 2*wall, wall, height - floor]);

// Seventh column
translate([side_x, grid_y, floor])
    cube([wall, grid_height, height - floor]);

// Six-column grid
for (i = [1:columns-1])
    translate([wall + i*cell_width, grid_y, floor])
        cube([wall, grid_height, height - floor]);

// Four grid rows
for (j = [1:rows-1])
    translate([wall, grid_y + j*cell_height, floor])
        cube([grid_width, wall, height - floor]);

// Five circular compartments
for (i = [0:4])
    translate([
        wall + (i + 0.5)*(width - 2*wall)/5,
        bottom_y + bottom_height/2,
        floor
    ])
        difference() {
            cylinder(h = well_height,
                     d = well_diameter + 2*well_wall,
                     $fn = 64);

            translate([0, 0, -0.1])
                cylinder(h = well_height + 0.2,
                         d = well_diameter,
                         $fn = 64);
        }