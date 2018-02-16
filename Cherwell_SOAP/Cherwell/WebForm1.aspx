<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Cherwell.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Find Vertices from Triangle: <br />
        <asp:TextBox ID="txtTriangle" runat="server"></asp:TextBox><br />
        <asp:Button ID="btnFindVertices" Text = "Submit" runat="server" OnClientClick="FindVertices();" /><br />
    </div>
    <br />
    <hr />
    <br />
    <div>
        Find Triangle from Vertices: <br />
        X1: <asp:TextBox ID="txtVX1" runat="server"></asp:TextBox><br />
        Y1: <asp:TextBox ID="txtVY1" runat="server"></asp:TextBox><br />
        X2: <asp:TextBox ID="txtVX2" runat="server"></asp:TextBox><br />
        Y2: <asp:TextBox ID="txtVY2" runat="server"></asp:TextBox><br />
        X3: <asp:TextBox ID="txtVX3" runat="server"></asp:TextBox><br />
        Y3: <asp:TextBox ID="txtVY3" runat="server"></asp:TextBox><br />
        <asp:Button ID="btnFindTriangle" Text = "Submit" runat="server" OnClientClick="FindTriangle();" /><br />
    </div>
    </form>

    <script type="text/javascript">

        function FindVertices() {
            var xmlHTTP;
            if (window.XMLHttpRequest) {
                xmlHTTP = new window.XMLHttpRequest;
            }
            else {
                try {
                    xmlHTTP = new ActiveXObject("MSXML2.XMLHTTP.3.0");
                }
                catch (ex) {

                }
            }
            xmlHTTP.open("POST", "http://localhost:64504/Triangle.asmx", true);
            xmlHTTP.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
            xmlHTTP.setRequestHeader("SOAPAction", "http://tempuri.org/FindVerticesByRowColumn");

            input = document.getElementById('<%= txtTriangle.ClientID %>').value
            
            strRequest = "<?xml version='1.0' encoding='utf-8'?>";
            strRequest = strRequest + "<soap:Envelope " + "xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' " + "xmlns:xsd='http://www.w3.org/2001/XMLSchema' " + "xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>";
            strRequest = strRequest + " <soap:Body>";
            strRequest = strRequest + "<FindVerticesByRowColumn xmlns='http://tempuri.org/'><RowColumn>" + input + "</RowColumn></FindVerticesByRowColumn >";
            strRequest = strRequest + "</soap:Body>";
            strRequest = strRequest + "</soap:Envelope>";


            xmlHTTP.onreadystatechange = function () {
                if (xmlHTTP.readyState == 4 && xmlHTTP.status == 200) {
                    alert(xmlHTTP.responseText);
                }
            }
            var xmlResponse = xmlHTTP.send(strRequest);
        }

        function FindTriangle() {
            var xmlHTTP;
            if (window.XMLHttpRequest) {
                xmlHTTP = new window.XMLHttpRequest;
            }
            else {
                try {
                    xmlHTTP = new ActiveXObject("MSXML2.XMLHTTP.3.0");
                }
                catch (ex) {

                }
            }
            xmlHTTP.open("POST", "http://localhost:64504/Triangle.asmx", true);
            xmlHTTP.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
            xmlHTTP.setRequestHeader("SOAPAction", "http://tempuri.org/FindTriangleByVertices");

            vX1 = document.getElementById('<%= txtVX1.ClientID %>').value
            vY1 = document.getElementById('<%= txtVY1.ClientID %>').value
            vX2 = document.getElementById('<%= txtVX2.ClientID %>').value
            vY2 = document.getElementById('<%= txtVY2.ClientID %>').value
            vX3 = document.getElementById('<%= txtVX3.ClientID %>').value
            vY3 = document.getElementById('<%= txtVY3.ClientID %>').value

            strRequest = "<?xml version='1.0' encoding='utf-8'?>";
            strRequest = strRequest + "<soap:Envelope " + "xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' " + "xmlns:xsd='http://www.w3.org/2001/XMLSchema' " + "xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>";
            strRequest = strRequest + " <soap:Body>";
            strRequest = strRequest + "<FindTriangleByVertices xmlns='http://tempuri.org/'><V1x>" + vX1 + "</V1x><V1y>" + vY1 + "</V1y><V2x>" + vX2 + "</V2x><V2y>" + vY2 + "</V2y><V3x>" + vX3 + "</V3x><V3y>" + vY3 + "</V3y></FindTriangleByVertices >";
            strRequest = strRequest + "</soap:Body>";
            strRequest = strRequest + "</soap:Envelope>";

            xmlHTTP.onreadystatechange = function () {
                if (xmlHTTP.readyState == 4 && xmlHTTP.status == 200) {
                    alert(xmlHTTP.responseText);
                }
            }
            var xmlResponse = xmlHTTP.send(strRequest);

        }

        function processReqChange() 
        {
            if (req.readyState == 4 && req.status == 200) {
                var response = req.responseXML.documentElement;
                alert(response);
            }
        }
    </script>
</body>
</html>
