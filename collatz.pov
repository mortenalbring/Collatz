#include "math.inc"


camera {	
	location <0, 0, -40>		           
	look_at <0,10,0>       	
	rotate <0,0,0>
}                

light_source {
  0*x
  color rgb 1.0
  area_light
  <8, 0, 0> <0, 0, 8>
  6, 4
  adaptive 3
  translate <0, 0, -10>
}


plane { y, -2
		pigment { checker rgb <0.1, 0.1, 0.1> rgb <1.0, 1.0, 1.0> scale 5 }
		finish { reflection 0.2 ambient 0.4 }
}        
	

sky_sphere {
		pigment { gradient y
			color_map {
				[0 rgb <0.5, 0.6, 1> ]
				[1 rgb <0, 0, 1> ]
			}
		}
		pigment { 
		    wrinkles turbulence 0.1
			color_map {
				[0 rgbt <1,1,1,1>]
				[0.5 rgbt <0.98, 0.99, 0.99, .6>]
				[1 rgbt <1, 1, 1, 1>]
		}
        scale <.8, .1, .8>
    }
} 
          
          
#local x0 = 13;
#local x1 = x0;
#local iteration = 0;     
#declare maxArraySize = 20;
#declare calcArray = array[maxArraySize];   

#local Identifier = 0;
#while (Identifier < maxArraySize) 
    #declare calcArray[Identifier] = 0;
    #local Identifier = Identifier + 1;
#end


#while(x1 > 1) 

    
    #declare isEven = even(x0);                                 
    #if (isEven = 1)
        #declare x0 = x0 / 2;
    #else 
        #declare x0 = (x0 * 3) + 1;   
    #end                       
    
    #declare calcArray[iteration] = x0;
    
    #declare x1 = x0;
    #declare iteration = iteration + 1;                     
	                                      	                                                                    
#end                                   

#local Identifier = 0;
#while (Identifier < maxArraySize) 
    #local y0 = calcArray[Identifier];
    #if (y0 > 0) 
    
                    
        sphere { <Identifier,y0,0>, 1
            texture { 
                pigment { 
                    color rgb<1.00, 0.55, 0.00>
                    filter 0.7
                }
                finish { phong 1.0 reflection 0.00}
            } 
    
            scale<1,1,1>  rotate<0,0,0>  
        }
        
        text { ttf "arial.ttf", str(y0,5,0), 0.02, 0.0
    
           texture{ pigment{ color rgb<0,0,0>*1.3 }               
                    finish { phong 0.1 }
                  } 
    
           scale<1,1.25,1>*0.8
           translate<Identifier-1,y0,0>
          } 
    #end    
    
    #local Identifier = Identifier + 1;
#end



            
	