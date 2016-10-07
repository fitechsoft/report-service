<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="${basePath}/jquery-1.9.1.min.js"></script>
<body>
<table border="1">
	<tr>
		<td>id</td>
		<td>银行机构代码</td>
		<td>银行持债企业代码</td>
		<td>金融许可证</td>
	</tr>
	
</table>

</body>
</html>
<script type="text/javascript">
  	 $(function(){
  	 	(function(){
  	 		$.ajax({
				url : '${basePath}/activiti/ss',
				success:function(obj){
					var data = JSON.parse(obj);
					$.each(data.fields, function(idx, obj1) {
					    alert(obj1.fieldName+"==="+obj1.fieldValue);
					});
				},
				error:function(){
				}
			});
  	 	})();
	  	
	  });
  </script>
