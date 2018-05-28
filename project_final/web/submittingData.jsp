<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<html><head><title>upFile</title></head>
<body>
<%
    // get all cookies
    Cookie[] cookies = request.getCookies();
    // get all address
    String buyerAddrCookie = "";
    String userNameCookie = "";
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";
    String freelancerContractDeployed = "";
    String clientContractDeployed = "";
    System.out.println("Page submittingData.jsp");
    for (int i = 0; i < cookies.length; i++) {
        if ("buyerAddrCookie".equals(cookies[i].getName())) {
            buyerAddrCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user address : " + buyerAddrCookie);
        }
        if ("userNameCookie".equals(cookies[i].getName())) {
            userNameCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user name : " + userNameCookie);
        }
        if ("buyerContractAddrCookie".equals(cookies[i].getName())) {
            buyerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("buyer contract address : " + buyerContractAddrCookie);
        }
        if ("sellerContractAddrCookie".equals(cookies[i].getName())) {
            sellerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("seller contract address : " + sellerContractAddrCookie);
        }
        if ("freelancerContractDeployed".equals(cookies[i].getName())) {
            freelancerContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("freelancer contract address : " + freelancerContractDeployed);
        }
        if ("clientContractDeployed".equals(cookies[i].getName())) {
            clientContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("client contract address : " + clientContractDeployed);
        }
    }

    int MAX_SIZE = 102400 * 102400;
    String rootPath;
    DataInputStream in = null;
    FileOutputStream fileOut = null;
    // The name of server
    String serverName = request.getServerName();
    String realPath = request.getRealPath(serverName);
    realPath = realPath.substring(0,realPath.lastIndexOf("/"));

    // Set root path
    rootPath = realPath + "/upload/" + freelancerContractDeployed + "/";
    System.out.println("Root path is : " + rootPath);

    // get the type of posted request
    String contentType = request.getContentType();

    try{
        // read data
        in = new DataInputStream(request.getInputStream());
        // save data as byte array
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while(totalBytesRead < formDataLength){
            byteRead = in.read(dataBytes,totalBytesRead,formDataLength);
            totalBytesRead += byteRead;
        }

        // Build string from byte array
        String file = new String(dataBytes);
        // Get filename
        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
        int lastIndex = contentType.lastIndexOf("=");
        // Get boundary of data
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        // Get save name
        String fileName = rootPath + saveFile;
        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n",pos) + 1;
        pos = file.indexOf("\n",pos) + 1;
        pos = file.indexOf("\n",pos) + 1;
        int boundaryLocation = file.indexOf(boundary,pos) - 4;
        // get start and end position
        int startPos = ((file.substring(0,pos)).getBytes()).length;
        int endPos = ((file.substring(0,boundaryLocation)).getBytes()).length;
        // check whether this file exists
        File checkFile = new File(fileName);
        if(checkFile.exists()){
            out.println("<p>" + saveFile + "Replace this file.</p>");
        }
        // check whether the path exists
        File fileDir = new File(rootPath);
        if(!fileDir.exists()){
            System.out.println("Make new dir");
            fileDir.mkdirs();
        }
        // build output stream, then write data
        fileOut = new FileOutputStream(fileName);
        fileOut.write(dataBytes,startPos,(endPos - startPos));
        fileOut.close();
        out.println(saveFile + "Upload succeed.</p>");
    }catch(Exception ex){
        throw new ServletException(ex.getMessage());
    }
%>
</body>
</html>