<%@page contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title><借阅图书/title>
    </head>
    <body>
        <h1 align="center">借阅图书</h1>
        
            <form id="bookdadd" name="bookadd" method="post" action="servlet/BookLendServlet">
                <table>
                    <tr>
                        <td align=right>图书条形码:</td>
                        <td>
                            <input name="bookcode" type="text" title="图书条形码"/>
                        </td>
                    </tr>
                    <tr>
                        <td align=right>读者借书证号码:</td>
                        <td>
                            <input name="readerid" type="text" title="借书证号码"/>
                        </td>
                    </tr>
                    
                    <tr>
                        <td align=right></td>
                        <td align="right">
                            <input type="submit" title="借书"/>
                        </td>
                    </tr>
                </table>
            </form>
       
    </body>
</html>