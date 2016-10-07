<html>
  <head>
    <title>测试流程图</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <body>
  	<label>流程定义ID：${proc_def_id!'' }</label><br/>
  	<label>流程名称：${proc_def_name!'' }</label><br/>
  	<label>流程实例ID：${proc_inst_id!'' }</label><br/>
    <img src="${basePath}/activiti/procImage?proc_inst_id=${proc_inst_id!'' }" />
  </body>
</html>