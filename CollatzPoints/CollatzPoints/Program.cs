using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollatzPoints
{
    public class Strand
    {        
        public int StartNumber { get; set; }     
        public List<int> Numbers = new List<int>();
    }
    class Program
    {

        static void Main(string[] args)
        {                        
            
            var strands = new List<Strand>();
            

            for (int i = 13; i < 30; i++)
            {
                var strand = new Strand();
                strand.StartNumber = i;

                var y0 = i;          
                while (y0 > 2)
                {                
                    strand.Numbers.Add(y0);
           
                    if (y0 % 2 == 0)
                    {
                        y0 = y0 / 2;
                    }
                    else
                    {
                        y0 = y0 * 3 + 1;
                    }                
                }

                strands.Add(strand);
           
            }

            var outputStrings = new List<string>();
            for (int strandIndex = 0; strandIndex < strands.Count; strandIndex++)
            {
                var strand = strands[strandIndex];
                for (int index = 0; index < strand.Numbers.Count; index++)
                {
                    var number = strand.Numbers[index];
                    Debug.WriteLine(index + "\t" + number);
                    var coordinates = "<" + index + "," + number + ",0>";
                    var rvalue = (float)strandIndex/(float)strands.Count;
                    var color = "<" + rvalue + ",1,0>";

                    var output = coordinates + "," + color + ",";
                    //output = coordinates;
                    outputStrings.Add(output);
                }
            }


            var outputFile = "C:\\Dropbox\\PovRay\\collatz\\test.txt";

            if (File.Exists(outputFile))
            {
                File.Delete(outputFile);
            }

            File.WriteAllLines(outputFile,outputStrings.ToArray());



        }
    }
}
