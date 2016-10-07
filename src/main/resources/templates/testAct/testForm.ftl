<html>
  <head>
    <title>打开任务</title>
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
  	<input type="hidden" id="user" value="${user_id }"/>
  	<input type="hidden" id="task_id" value="${taskObj.task_id}"/>
  	<input type="hidden" id="action"/>
  	<table class="mytable" width="800" border="1">
    	<tr>
    		<th width="30%">表单内容</th>
    	</tr>
    	<tr>
    		<td width="30%">
    			<#if (relation?size > 0)>
	    			<#list relation as relat>
	    				{procInstId==${relat.procInstId};bussinessId==${relat.bussinessId}}
	    			</#list>
    			<#else>
    			<#-- 表单内容 -->
	    			<table width="450px" border="1" style="TABLE-LAYOUT.fixd;WORD-BREAK:break-all;">
				    	<tr id="dataTitle">
				    		<th>选择</th>
				    		<th>id</th>
				    		<th>name</th>
				    		<th>desc</th>
				    	</tr>
				    </table>
			    </#if>
    		</td>
    	</tr>
    </table>
    <table class="mytable" width="800" border="1">
    	<tr>
    		<th width="30%">任务名</th>
    		<th width="30%">接手人</th>
    	</tr>
		<tr>
    		<td>${taskObj.task_name!''}</td>
    		<td>${user_id!'' }</td>
    	</tr>	
    </table>
    <table class="mytable" width="800" border="1">
    	<tr>
    		<td>处理：</td>
    		<td>
    		<#list taskObj.actionFlows as actionFlow>
    			${actionFlow.nextType!'' }|${actionFlow.action!'' }
    			<input type="button" onclick="javascipt:completeTask('${actionFlow.action!''}')" value="${actionFlow.name!'' }"/>
    		</#list>
    		</td>
    	</tr>
    	<tr>
    		<td>接收人：${taskObj.nextTasks?size}</td>
    		<td>
    		<#if taskObj.nextTasks?? && (taskObj.nextTasks?size>0)>
    			<input type="hidden" name="nodeList" value="${taskObj.nextTasksId}" />
    			<#list taskObj.nextTasks as flowType>
					||${flowType.nextTaskId!''}--${flowType.nextTaskName!''}--${flowType.nextTaskType!''}||
					<input type="text" name="${flowType.nextTaskId!''}"/>
				</#list>
			<#else>
				<#--  &&('endEvent' != taskObj.actionFlows[0].nextType||'endEvent' != taskObj.actionFlows[1].nextType -->
				<#if taskObj.actionFlows?? && (taskObj.actionFlows?size>0)>
					<#assign flows = 0 >
					<#list taskObj.actionFlows as actionFlow>
						<#if 'endEvent'!=actionFlow.nextType>
							<#assign flows = flows+1 >
						</#if>
					</#list>
				</#if>
				<#if (flows>0)>
					<input type="text" name="nextUser" id="nextUser"/>
				</#if>
    		</#if>
    		</td>
    	</tr>
    </table>
  </body>
  	<script type="text/javascript">
		function completeTask(action){
			var datas = "";
  			$("input[name='chkb']:checked").each(function(){
  				datas += $(this).val()+';';
  			});
  			$.ajax({
				url : '${basePath}/test/commitTask',
				dataType : 'json',
				data : {
					"task_id" : $("#task_id").val(),
					"nextUser" : $("#nextUser").val(),
					"action" : action,
					"data" : datas
				},
				success:function(obj){
					alert(obj);
					window.opener.location.href = window.opener.location.href;
					window.close();
				},
				error:function(){
				}
			});
		}
		 $(function(){
	  	 	(function(){
	  	 		$.ajax({
					url : '${basePath}/test/todoData',
					success:function(obj){
						var table = "";
						$.each(JSON.parse(obj),function(idx,data){
							table += "<tr>";
							table += "<td><input type='checkBox' value='"+data.id+"' name='chkb'></td>";
							table += "<td>"+data.id+"</td>";
							table += "<th>"+data.name1+"</td>";
							table += "<th>"+data.desc1+"</th>";
							table += "</tr>";
						})
						$("#dataTitle").after(table);
					},
					error:function(){
					}
				});
	  	 	})();
		  	
		  });
	</script>
</html>