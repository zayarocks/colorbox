// Victorian Watercolor Box — Top Tray
// Millimeters

wall = 5;
floor = 3;
height = 25;

// Interior dimensions
left = 180;
right = 70;
top = 40;
middle = 40;
bottom = 90;

width = left + right + 3*wall;      // 265
length = top + middle + bottom + 4*wall; // 190

difference() {
    cube([width, length, height]);

    translate([wall, wall, floor])
        cube([width-2*wall, length-2*wall, height]);
}

// Horizontal dividers
for (y = [bottom+wall, bottom+middle+2*wall])
    translate([wall, y, floor])
        cube([width-2*wall, wall, height-floor]);

// Vertical divider (top two rows only)
translate([left+wall, bottom+2*wall, floor])
    cube([wall, top+middle+wall, height-floor]);