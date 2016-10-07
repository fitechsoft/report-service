<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="${basePath}/jquery-1.9.1.min.js"></script>
<body>
<table border="1">
	<tr>
		<td>bpmn文件名称</td>
		<td>操作</td>
	</tr>
	<#if bpmnFiles?exists>
		<#list bpmnFiles as c>
			<tr>
	    		<td>${c }</td>
	    		<td><input name="createProc" type="button" value="生成流程实例" val="${c }"/></td>
	    	</tr>
		</#list>
	</#if>
</table>

<table border="1">
	<tr>
		<td>proc_def_id</td>
		<td>bpmn名称</td>
		<td>资源</td>
		<td>操作</td>
	</tr>
	<#if processList?exists>
		<#list processList as process>
			<tr>
	    		<td>${process.id!'' }</td>
	    		<td>${process.name!''}</td>
	    		<td>${process.resourceName!''}</td>
	    		<td><input name="delProc" type="button" value="删除" val="${process.deploymentId }" val2="${process.id }"/></td>
	    	</tr>
		</#list>
	</#if>
</table>
<h4>新建2：</h4>
<form name="createOpen" action="${basePath}/activiti/createAndOpenTaskForm" target="_blank" method="POST">
	流程定义ID：<input name="proc_def_id_" />
	发起人：<input name="user" />
	<input type="button" onclick="javascript:createNewFlow();" value="新建流程"/>
</form>

<h4>任务列表：</h4>
<form action="${basePath}/activiti/listTask" target="taskListFrame">
	流程定义ID：<input name="proc_def_id">
	用户：<input name="user_id">
	<input type="submit" value="查询任务"/>
</form>
<iframe name="taskListFrame" style="width:1000;height:600"></iframe>
</body>
</html>
<script type="text/javascript">
  	function createNewFlow(){
  		if(createOpen.proc_def_id_.value == ""){
  			alert("请正确填写流程定义id");
  			return;
  		}
  		if(createOpen.user.value == ""){
  			alert("请正确填写发起人");
  			return;
  		}
  		createOpen.submit();
  	}
  	 $(function(){
	  	$("input[name='createProc']").click(function(){
	  		$.ajax({
				url : '${basePath}/activiti/deployFlows',
				dataType : 'json',
				data : {
					"fileName" : $(this).attr("val")
				},
				success:function(obj){
					alert(obj);
					location.reload();
				},
				error:function(){
				}
			});
	  	});
	  	$("input[name='delProc']").click(function(){
	  		$.ajax({
				url : '${basePath}/activiti/delFlows',
				dataType : 'json',
				data : {
					"deploymentId" : $(this).attr("val"),
					"proc_def_id_" : $(this).attr("val")
				},
				success:function(obj){
					alert(obj);
					location.reload();
				},
				error:function(){
				}
			});
	  	});
	  });
  </script>
