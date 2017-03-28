camera {	
	location <0, 2, -400>		           
	look_at <0,10,0>       	
}                


plane { y, -220
		pigment { checker rgb <0.1, 0.1, 0.1> rgb <1.0, 1.0, 1.0> scale 5 }
		finish { reflection 0.2 ambient 0.4 }
	}

	fog {
		distance 1000
		color rgb 0.9
		fog_offset 2
		fog_alt 5
		fog_type 2
	} 