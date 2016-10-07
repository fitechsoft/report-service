<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		.mytable {
    		width : 500px;
    		align : center;
    		border : 1px solid gray;
    		cellpadding : 0;
    		cellspacing : 0;
    		border-collapse:collapse;
    	}
		.mytable tr{
    		height : 24px;
    	}
	</style>
  </head>
  <script type="text/javascript" src="${basePath}/jquery-1.9.1.min.js"></script>
  <body> 
  	<form action="" name="myForm" id="myForm">
  	<input type="hidden" name="datas" id="datas" />
  	<#-- 
  	<input type="button" id="startFlow" value="开启流程" /><br/>-->
    <table width="450px" border="1" style="TABLE-LAYOUT.fixd;WORD-BREAK:break-all;">
    	<tr>
    		<th>选择</th>
    		<th>id</th>
    		<th>name</th>
    		<th>desc</th>
    	</tr>
    	<#if list?exists>
    		<#list list as domain>
    			<tr>
					<td><input type="checkBox" value="${domain.id!''}" name="chkb"></td>
		    		<td>${domain.id!''}</td>
		    		<td>${domain.name1!''}</td>
		    		<td>${domain.desc1!''}</td>
		    	</tr>
    		</#list>
    	<#else>
    		<td colspan="7" align="center">无待办</td>
    	</#if>
    </table>
    </form>
  </body>
  <script type="text/javascript">
  	$(function(){
  		$("#startFlow").click(function(){
  			var datas = "";
  			$("input[name='chkb']:checked").each(function(){
  				datas += $(this).val()+';';
  			});
  			$("#datas").val(datas);
  			$("#myForm").attr("action","${basePath}/test/startFlow").submit();
  		});
  	});
  </script>
</html>