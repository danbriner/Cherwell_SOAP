using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Cherwell
{
    /// <summary>
    /// Summary description for Triangle
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Triangle : System.Web.Services.WebService
    {

        [WebMethod]
        public string FindVerticesByRowAndColumn(char Row, int Column)
        {
            try
            {
                return FindVertices(Row, Column);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public string FindVerticesByRowColumn(string RowColumn)
        {
            char Row;
            int Column;

            try
            {
                if (!char.TryParse(RowColumn.Substring(0, 1), out Row))
                {
                    throw new Exception("Invalid Row Value");
                }

                if (!int.TryParse(RowColumn.Substring(1), out Column))
                {
                    throw new Exception("Invalid Column Value");
                }

                string result = FindVertices(Row, Column);
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string FindVertices(char Row, int Column)
        {
            string result = "";

            try
            {
                ValidateRow(Row);
                ValidateColumn(Column);

                // If we can determine which even/odd pair of triangles we are working with, we already know all of the points on the square and therefore the two points on the hypotenuse.
                // Since there are 6 "squares", we can use the column number to determine the "index".
                int lowX = 10 * ((Column - 1) / 2);
                int highX = 10 * ((Column + 1) / 2);

                // Determine the "index" of the row based on A being the first and at the origin (top left since we're dealing with pixels).
                int RowInt = (int)Row - (int)'A';

                // From the index we multiply by 10 to get the pixels.
                int lowY = 10 * RowInt;
                int highY = 10 * (RowInt + 1);

                // Now we need to determine which is the 3rd point and for that we just need to know if it's the even or odd triangle.
                if (Column % 2 == 1)
                {
                    result = "{" + lowX.ToString() + "," + lowY.ToString() + "},{" + highX.ToString() + "," + highY.ToString() + "},{" + lowX.ToString() + "," + highY.ToString() + "}";
                }
                else
                {
                    result =  "{" + lowX.ToString() + "," + lowY.ToString()+ "},{" + highX.ToString() + "," + highY.ToString() + "},{" + highX.ToString() + "," + lowY.ToString() + "}";
                }

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ValidateRow(char Row)
        {
            try
            {
                if (Row < 'A' || Row > 'F')
                {
                    throw new Exception("Row out of bounds");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ValidateColumn(int Column)
        {
            try
            {
                if (Column < 1 || Column > 12)
                {
                    throw new Exception("Column out of bounds");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public string FindTriangleByVertices(int V1x, int V1y, int V2x, int V2y, int V3x, int V3y)
        {
            try
            {
                ValidateVertex(V1x);
                ValidateVertex(V1y);
                ValidateVertex(V2x);
                ValidateVertex(V2y);
                ValidateVertex(V3x);
                ValidateVertex(V3y);

                string result = FindTriangle(V2x, V2y);
                return result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        private string FindTriangle(int V2x, int V2y)
        {
            try
            {
                // Since we are looking for a particular triangle (shape given in the document) then we only need to know a single point to determine which it is.
                // I picked the top left point because it was easier for my math.  :)
                int X = V2x / 10;
                int Y = V2y / 10;

                char Row = (char)((int)'A' + Y);
                int Column = X * 2 + 1;

                return Row.ToString() + Column.ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ValidateVertex(int Vertex)
        {
            try
            {
                if (Vertex < 0 || Vertex > 60)
                    throw new Exception("Invalid Point");

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
