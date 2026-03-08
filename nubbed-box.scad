include <MCAD/boxes.scad>

/*
A box with a lid. The inset of the lid is a little bit angled for easy insert.
For a tighter fit, there are nubs on each side of the inset which fit into holes
within the body of the box. Once closed, the box will hard to be opened - you can use
the helper slits to insert e.g. a screwdriver to lever the lid open.
This is very useful for cases you do not want to open often, without glueing or
screwing them close.
*/

// parts to render. 0 = both, 1 = bottom, 2 = lid
parts = 0; // [0:Both, 1:Bottom, 2:Lid]

// total width of the box
outer_width = 60; // [10:1000]

// total length of the box
outer_length = 90; // [10:1000]

// total height of the box
outer_height = 40; // [10:1000]

// height of the lid part
lid_height = 5; // [3:100]

// inset height of the lid part
lid_inset_height = 6; // [0:50]

// Thickness of the box' walls
wall_thickness = 2; // [1:10]

// outer radius of rounded corners of the box
outer_radius = 2; // [0:50]

// radius of rounded corners inside the box
inner_radius = 1; // [0:50]

// radius of the nubs
dot_radius = 0.8; // [0:0.1:10]

// slit height for latching open. Set to 0 for no slits
slit_height = 2; // [0:100]

// slit width for latching open.
slit_width = 6; // [0:100]

$fn = 40;

module nubBoxSlit() {
	if (slit_height > 0) {
    	translate([-1, 0, outer_height - lid_height - slit_height])
        	roundedCube([wall_thickness + 2, slit_width, slit_height + 1], inner_radius, false, false);
	}
}

module myBoxBottom()
{
	difference()
	{
		roundedCube([ outer_width, outer_length, outer_height ], outer_radius, false, false);
		translate([ wall_thickness, wall_thickness, wall_thickness ])
		    roundedCube([ outer_width - wall_thickness * 2, outer_length - wall_thickness * 2, outer_height ], inner_radius,
		            false, false);
		translate([ 0, 0, outer_height - lid_height ])
		    cube([ outer_width, outer_length, outer_height ]);
		translate([
			wall_thickness + dot_radius - dot_radius * 0.4, outer_length * 0.25,
			outer_height - lid_height - lid_inset_height * 0.5
		])
		    sphere(dot_radius * 1.1);
		translate([
			wall_thickness + dot_radius - dot_radius * 0.4, outer_length * 0.75,
			outer_height - lid_height - lid_inset_height * 0.5
		])
		    sphere(dot_radius * 1.1);
		translate([
			outer_width - (wall_thickness + dot_radius - dot_radius * 0.4), outer_length * 0.25,
			outer_height - lid_height - lid_inset_height * 0.5
		])
		    sphere(dot_radius * 1.1);
		translate([
			outer_width - (wall_thickness + dot_radius - dot_radius * 0.4), outer_length * 0.75,
			outer_height - lid_height - lid_inset_height * 0.5
		])
		    sphere(dot_radius * 1.1);
        translate([0, outer_length * 0.75 - slit_width * 1.5, 0])
            nubBoxSlit();
        translate([0, outer_length * 0.25 + slit_width * 0.5, 0])
            nubBoxSlit();
        translate([outer_width - wall_thickness, outer_length * 0.75 - slit_width * 1.5, 0])
            nubBoxSlit();
        translate([outer_width - wall_thickness, outer_length * 0.25 + slit_width * 0.5, 0])
            nubBoxSlit();
	}


}

module myBoxLid()
{
	lid_inset_factor = 1.1; // should be left unchanged.

	difference()
	{
		roundedCube([ outer_width, outer_length, lid_height + outer_radius ], outer_radius, false, false);
		translate([ 0, 0, lid_height ])
            cube([ outer_width, outer_length, outer_radius ]);
	}
	difference()
	{
		hull()
		{
			translate([ wall_thickness, wall_thickness, lid_height - inner_radius ])
			    roundedCube([ outer_width - wall_thickness * 2, outer_length - wall_thickness * 2, inner_radius * 2 ],
			            inner_radius, false, false);
			translate([
				wall_thickness * lid_inset_factor, wall_thickness * lid_inset_factor, lid_height + lid_inset_height -
				inner_radius
			])
			    roundedCube(
                    [
                        outer_width - wall_thickness * lid_inset_factor * 2,
                        outer_length - wall_thickness * lid_inset_factor * 2, inner_radius * 2
                    ],
                    inner_radius, false, false);
		}
		translate([ wall_thickness * (1 + lid_inset_factor), wall_thickness * (1 + lid_inset_factor), lid_height ])
    		roundedCube(
                [
                    outer_width - wall_thickness * (1 + lid_inset_factor) * 2,
                    outer_length - wall_thickness * (1 + lid_inset_factor) * 2, lid_inset_height + inner_radius * 2
                ],
                inner_radius, false, false);
	}

	translate([ wall_thickness + dot_radius * 0.33, outer_length * 0.25, lid_height + lid_inset_height * 0.5 ])
    	sphere(dot_radius);
	translate([ wall_thickness + dot_radius * 0.33, outer_length * 0.75, lid_height + lid_inset_height * 0.5 ])
	    sphere(dot_radius);
	translate([
		outer_width - (wall_thickness + dot_radius * 0.33), outer_length * 0.25, lid_height + lid_inset_height * 0.5
	])
	    sphere(dot_radius);
	translate([
		outer_width - (wall_thickness + dot_radius * 0.33), outer_length * 0.75, lid_height + lid_inset_height * 0.5
	])
	    sphere(dot_radius);
}

if (parts == 0 || parts == 1) {
	myBoxBottom();
}
if (parts == 0 || parts == 2) {
	translate([ -outer_width - 10, 0, 0 ]) myBoxLid();
}

