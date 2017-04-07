#include "math.inc"


camera {	
	location <0, 0, -30>		           
	look_at <0,15,0>       	
	rotate <0,0,0>
}                

      
light_source {
  <0,0,0>             // light's position 
  color rgb 1.0       // light's color
  area_light
  <8, 0, 0> <0, 0, 8> // lights spread out across this distance (x * z)
  4, 4                // total number of lights in grid (4x*4z = 16 lights)
  adaptive 0          // 0,1,2,3...
  jitter              // adds random softening of light
  circular            // make the shape of the light circular
  orient              // orient light
  translate <40, 80, -40>   // <x y z> position of light
}
      





plane { y, -2
		pigment { checker rgb <0.1, 0.1, 0.1> rgb <1.0, 1.0, 1.0> scale 50 }
	//	finish { reflection 0.2 ambient 0.4 }
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

#declare maxArraySize = 200;

#macro drawBetweenPoints(x0,x1,y0,y1)            

	#local startPoint = 0;
	#local endPoint = 0;

	#if (y0 > y1)
		#local startPoint = y1;
		#local endPoint = y0;
	#else
		#local startPoint = y0;
		#local endPoint = y1;
	#end

	#local diff = (endPoint - startPoint);
	
	#local increment = ((x1-x0) / diff);

	
	#local j = startPoint;
	#local p = 0;
	#while(j<endPoint)

		#local xx = x0 + ((x0/diff)*p);
		sphere {<xx,j,0> 0.5}
		#local j = j + 1;
		#local p = p + 1;

	#end
#end

#macro makeCollatzPoints(calcArray,start,startIndex)                   
	#local xxx0 = start;
	#local xxx1 = xxx0;
	#local arrayIndex = startIndex;     
	#declare calcArray = array[maxArraySize];   

	#local i = 0;
	#while (i < maxArraySize) 
		#declare calcArray[i] = 0;
		#local i = i + 1;
	#end


	#while(xxx1 > 1)     
		#debug concat("Start: ",str(start,5,0)," Array Index ", str(arrayIndex,5,0)," x0 ",str(xxx0,5,0), "\n")

		#local isEven = even(xxx0);                                 
		#if (isEven > 0)
			#local xxx0 = xxx0 / 2;
		#else 
			#local xxx0 = (xxx0 * 3) + 1;   
		#end                       
    
		#declare calcArray[arrayIndex] = xxx0;
		
    
		#local xxx1 = xxx0;
		#local arrayIndex = arrayIndex + 1;                     	                                      	                                                                    
	#end      
#end
	


#macro drawCollatzPoints(calcArray,startCollatzNumber,seriesCount)                             
	#local i = 0;          
	#local seriesColor = rgb<0.55 + (startCollatzNumber/100) , 0.2, 0.20>;
	
	#while (i < maxArraySize) 
		#local y0 = calcArray[i];
		#local y1 = 0;
    
    
    
		#if ((i+1) < maxArraySize) 
			#local y1 = calcArray[i+1];
		#end
    
		#if (y0 > 0)  
		                    
			sphere { <i,y0,startCollatzNumber>, 1
				texture { 
					pigment { 
						color seriesColor
						filter 0.7
					}
					finish { phong 1.0 reflection 0.00}
				} 
    
				scale<1,1,1>  rotate<0,0,0>  
			}
                             
                             /*
			text { ttf "arial.ttf", str(y0,5,0), 0.02, 0.0
    
			   texture{ pigment{ color rgb<0,0,0>*1.3 }               
						finish { phong 0.1 }
					  } 
    
			   scale<1,1.25,1>*0.8
			   translate<i-1,y0,startCollatzNumber>
			  }                         
			  */
			  
		#end                                   
    
		#if ((y0 > 0) & (y1 > 0)) 
			//drawBetweenPoints(i,i+1,y0,y1)

			cylinder { <i,y0,startCollatzNumber>,<i+1,y1,startCollatzNumber>, 0.80 

			   texture { pigment { color seriesColor filter 0.8 }                   
						 finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
					   } 

			   scale <1,1,1> rotate<0,0,0> translate<0,0,0>
			 }       
		#end
    
    
		#local i = i + 1;
	#end
#end


#declare calcArray = array[maxArraySize];
#declare startFrom = (13+int(clock));

#declare startCollatzNumber = 13;
#declare endCollatzNumber = (startCollatzNumber+int(clock));
#declare collatzStart = startCollatzNumber;
#declare seriesCount = 0;
/*
#while (collatzStart <= endCollatzNumber)    


	makeCollatzPoints(calcArray,collatzStart,0)
	drawCollatzPoints(calcArray,collatzStart,seriesCount)
	#declare seriesCount = seriesCount + 1;
	#declare collatzStart = collatzStart + 1;
#end
 */
                   
#local maxPoints = clock;                   
#local drawnPoints = 0; 
#local camerazPos = -30 - (2*clock);

#fopen MyFile "test.txt" read
  #while ((defined(MyFile)) & (drawnPoints < maxPoints))
    #read (MyFile,var_coords1,var_coords2,var_color)        
    sphere { var_coords1, 1               
        texture { 
            pigment { color var_color }
        }          
                      
    }   
    
    cylinder { var_coords1, var_coords2, 0.9
                  texture { pigment { color var_color filter 0.8 }                   
						 finish  { phong 0.5 reflection{ 0.00 metallic 0.00} } 
					   }
        }
    #local drawnPoints = drawnPoints + 1; 
    #debug concat(str(drawnPoints,5,0)," ",str(maxPoints,5,0),"\n")
        
        camera {	location <0, 20, camerazPos>}                

        
  #end                   
