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
	

sky_sphere {
		pigment { gradient y
			color_map {
				[0 rgb <0.5, 0.6, 1> ]
				[1 rgb <0, 0, 1> ]
			}
		}
		pigment { 
		    wrinkles turbulence clock
			color_map {
				[0 rgbt <1,1,1,1>]
				[0.5 rgbt <0.98, 0.99, 0.99, .6>]
				[1 rgbt <1, 1, 1, 1>]
		}
        scale <.8, .1, .8>
    }
} 

	