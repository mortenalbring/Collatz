#include "math.inc"


camera {	
	location <0, 0, -60>		           
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
	


#macro drawCollatzPoints(calcArray)                             
	#local i = 0;
	#while (i < maxArraySize) 
		#local y0 = calcArray[i];
		#local y1 = 0;
    
    
    
		#if ((i+1) < maxArraySize) 
			#local y1 = calcArray[i+1];
		#end
    
		#if (y0 > 0)                      
			sphere { <i,y0,0>, 1
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
			   translate<i-1,y0,0>
			  } 
		#end                                   
    
		#if ((y0 > 0) & (y1 > 0)) 
			//drawBetweenPoints(i,i+1,y0,y1)

			cylinder { <i,y0,0>,<i+1,y1,0>, 0.30 

			   texture { pigment { color rgb<1,1,1> filter 0.8 }                   
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
#while (collatzStart <= endCollatzNumber)
	makeCollatzPoints(calcArray,collatzStart,0)
	drawCollatzPoints(calcArray)
	#declare collatzStart = collatzStart + 1;
#end


