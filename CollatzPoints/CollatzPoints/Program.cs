using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollatzPoints
{
    public class Node
    {
        public int number { get; set; }

        public Node(int number)
        {
            this.number = number;
        }
    }
    public class Edge
    {
        public int startNumber { get; set; }
        public int endNumber { get; set; }
        public bool upwards { get; set; }

        public Edge(int startNumber, int endNumber)
        {            
            this.startNumber = startNumber;
            this.endNumber = endNumber;
            if (startNumber > endNumber)
            {
                upwards = true;
            }
        }

    }
    class Program
    {

        static void Main(string[] args)
        {
            var startPoint = 13;
            var points = new List<int>();
            var nodes = new List<Node>();
            var edges = new List<Edge>();

            for (int i = 3; i < 10; i++)
            {
                var y0 = i;
                var y1 = y0;
                while (y0 > 2)
                {
                    var node = new Node(y0);
                    nodes.Add(node);

                    points.Add(y0);
                    if (y0 % 2 == 0)
                    {
                        y0 = y0 / 2;
                    }
                    else
                    {
                        y0 = y0 * 3 + 1;
                    }

                    var edge = new Edge(y1, y0);
                    var existingEdge = edges.FirstOrDefault(e => e.startNumber == y1 && e.endNumber == y0);
                    if (existingEdge == null)
                    {
                        edges.Add(edge);
                    }
                    
                    y1 = y0;
                }
            }


            foreach (var edge in edges)
            {
                Debug.WriteLine(edge.startNumber + "\t" + edge.endNumber + "\t" + edge.upwards);
            }




        }
    }
}
