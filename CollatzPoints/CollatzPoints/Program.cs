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
    
        public Edge(int number1, int number2)
        {            
            if (number1 < number2)
            {
                startNumber = number1;
                endNumber = number2;
            }
            else
            {
                startNumber = number2;
                endNumber = number1;
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

            for (int i = 3; i < 1000; i++)
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
                    var existingEdge = edges.FirstOrDefault(e => e.startNumber == edge.startNumber && e.endNumber == edge.endNumber);
                    if (existingEdge == null)
                    {
                        edges.Add(edge);
                    }
                    else
                    {
                        break;
                    }
                    
                    y1 = y0;
                }
            }

            var startNumbers = edges.OrderBy(e => e.startNumber).Select(e => e.startNumber).Distinct().ToList();

            foreach(var startNumber in startNumbers)
            {
                var outgoingEdges = edges.Where(e => e.startNumber == startNumber).ToList();

                foreach(var outgoingEdge in outgoingEdges)
                {
                    Debug.WriteLine(startNumber + "\t" + outgoingEdge.endNumber);
                }
            }           

        }
    }
}
