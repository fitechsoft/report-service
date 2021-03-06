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
  
  <body> 
  	待办列表：<br/>
    <table width="950px" border="1" style="TABLE-LAYOUT.fixd;WORD-BREAK:break-all;">
    	<tr>
    		<th width="10%">流程实例ID</th>
    		<th width="15%">流程名</th>
    		<th width="15%">任务名</th>
    		<th width="15%">创建时间</th>
    		<th width="10%">接手人</th>
    		<th width="20%">候选人</th>
    		<th width="15%">处理</th>
    	</tr>
    	<#if toDoList?exists>
    		<#list toDoList as toDo>
    			<tr>
					<td>${toDo.proc_inst_id!''}</td>
		    		<td>${toDo.procName!''}</td>
		    		<td>${toDo.taskName!''}</td>
		    		<td>${toDo.assingedTime!''}</td>
		    		<td>${toDo.assignee!''}</td>
		    		<td>
						<#if toDo.getCandidate?exists>
							<#list toDo.candidate as cant>
								${cant!''},
							</#list>
						</#if>
					</td>
		    		<td>
		    			<input type="button" value="处理" onclick="javascript:window.open('${basePath}/activiti/openTaskForm?user_id=${toDo.assignee!''}&task_id_=${toDo.taskId!''}')"/>
		    			<input type="button" value="流程图" onclick="javascript:window.open('${basePath}/activiti/toProcImagePage/${toDo.proc_inst_id!''}')" />
		    		</td>
		    	</tr>
    		</#list>
    	<#else>
    		<td colspan="7" align="center">无待办</td>
    	</#if>
    </table>
    
   	 已办列表：<br/>
    <table width="800" border="1">
    	<tr>
    		<th width="25%">流程名</th>
    		<th width="25%">任务名</th>
    		<th width="25%">处理人</th>
    		<th width="25%">办结时间</th>
    	</tr>
    	<#if doneList?exists>
    		<#list doneList as done>
    			<tr>
		    		<td>${done.procName!''}</td>
		    		<td>${done.taskName!''}</td>
		    		<td>${done.doneUser!''}</td>
		    		<td>${done.doneTime!''}</td>
		    	</tr>
    		</#list>
    	<#else>
    		<tr>
	    		<td colspan="4" align="center">无已办</td>
	    	</tr>
    	</#if>
    </table>
  </body>
</html>