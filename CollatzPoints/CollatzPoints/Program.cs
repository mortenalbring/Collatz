using System;
using System.Collections.Generic;
using System.Diagnostics;
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
            

            for (int i = 3; i < 30; i++)
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

            foreach (var strand in strands)
            {
                for (int index = 0; index < strand.Numbers.Count; index++)
                {
                    var number = strand.Numbers[index];
                    Debug.WriteLine(index + "\t" + number);
                }
            }
            
        }
    }
}
