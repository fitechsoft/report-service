package com.fitechsoft.report.controller;

import com.alibaba.fastjson.JSONObject;
import com.fitechsoft.flow.core.FFProcess;
import com.fitechsoft.flow.core.FFProcessRegistry;
import com.fitechsoft.flow.core.FFTask;
import com.fitechsoft.report.flow.ReportProcess;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping(value="report")
public class ReportController {
	/**
	 * activiti测试页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String listProcess(HttpServletRequest request, Model model) {
		List<FFProcess> processList = FFProcessRegistry.getProcessRegistry().getRegisteredProcessesByCategory(ReportProcess.REPORT_PROCESS);
		model.addAttribute("processList", processList);
		return "index";
	}

    /**
     * 查询指定用户的任务列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/listTasks")
    public String listTasks(HttpServletRequest request,Model model) {
        //用户ID
        String user_id = request.getParameter("user");
        //流程ID
        String proc_def_id = request.getParameter("process");
        try {
            user_id = new String(user_id.getBytes("iso8859-1"),"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        //************************
        // 待办列表
        List<FFTask> todoList = FFTask.getToDoTasksForUser(proc_def_id, user_id);

        model.addAttribute("toDoList", todoList);
        return "activitiList";
    }


	/**
	 * 开启并指派一个新的任务
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/startProcess", method = { RequestMethod.POST })
	public String startProcess(HttpServletRequest request,Model model) {
		//工作流引擎任务ID
		String processName = request.getParameter("process");
		//开启并指派一个任务流程
		String user = request.getParameter("user");

        FFProcess process = FFProcessRegistry.getProcessRegistry().getRegisteredProcessesByName(processName);

        return process.startInstance(null).toString();
	}

	/**
	 * 执行任务流程节点
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/handleTask", method = { RequestMethod.GET })
	public String handleTask(HttpServletRequest request,Model model) {
		//用户ID
		String user_id = request.getParameter("user");
		//任务ID
		String task_id_ = request.getParameter("task");
		//回调该task_id_任务流程节点详情

        return FFTask.getTask(task_id_).toString();

	}
	/**
	 * 提交任务流程节点
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/completeTask", method = { RequestMethod.POST,RequestMethod.GET })
	public void complete(HttpServletRequest request,HttpServletResponse response) throws Exception {

		//操作人
		String user = request.getParameter("user");
		try {
			user = new String(user.getBytes("iso8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//当前执行的任务ID
		String task_id_ = request.getParameter("task_id_");
		//跳转条件
		String action = request.getParameter("redirect");
		
		FFTask.getTask(task_id_).complete();

	}

//
//	@RequestMapping(value="/toProcImagePage/{proc_inst_id}")
//	public String toProcImagePage(HttpServletRequest request, Model model,@PathVariable("proc_inst_id") String proc_inst_id){
//		ProcessInstance pi = activitiService.getProcessInstance(proc_inst_id);
//		model.addAttribute("proc_def_id", pi.getProcessDefinitionId());
//		model.addAttribute("proc_def_name", pi.getProcessDefinitionName());
//		model.addAttribute("proc_inst_id", proc_inst_id);
//		model.addAttribute("basePath", this.basePath(request));
//		return "processImage";
//	}
//	@RequestMapping(value="/procImage")
//	public void procImage(HttpServletResponse response,@RequestParam("proc_inst_id") String proc_inst_id) throws Exception{
//		InputStream imageStream = activitiService.createProcImage(proc_inst_id);
//		OutputStream out = response.getOutputStream();
//		byte[] b = new byte[1024];
//		while(imageStream.read(b)!=-1){
//			out.write(b);
//		}
//		imageStream.close();
//		out.flush();
//		out.close();
//	}
//
//	/**
//	 * 流程部署
//	 * @param request
//	 * @param response
//	 * @return
//	 */
//	@RequestMapping(value = "/deployFlows")
//	public @ResponseBody String deployFlows(HttpServletRequest request) {
//		//bpmn文件路径
//		String fileName = request.getParameter("fileName");
//		//部署完成后生成的流程编码，用于流程任务控制
////		String loadbpmnpath = CommonConst.getProperties("loadbpmnpath");
//		String proc_def_id_ = repositoryService.processDeployment(activitiService.getBpmnPath(request)+"/"+fileName);
//		System.out.println("部署完成proc_def_id_:"+proc_def_id_);
//		return proc_def_id_;
//	}
//	/**
//	 * 流程删除
//	 * @param request
//	 * @param response
//	 * @return
//	 */
//	@RequestMapping(value = "/delFlows")
//	public @ResponseBody String delFlows(HttpServletRequest request) {
//		//bpmn文件路径
//		String deploymentId = request.getParameter("deploymentId");
//		String proc_def_id_ = request.getParameter("proc_def_id_");
//		//部署完成后生成的流程编码，用于流程任务控制
//		repositoryService.delProcDeployment(deploymentId);
//		JSONObject obj = new JSONObject();
//		obj.put("retObj", "删除流程proc_def_id_:"+proc_def_id_);
//		return obj.toJSONString();
//	}
//
//	private String basePath(HttpServletRequest request){
//		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//		return basePath;
//	}
//
//	@RequestMapping("ss")
//	public @ResponseBody String ss(){
//		String ss = "{'id':1,'templateName':'zqmxb','fields':{'银行机构代码':{'id':null,'oid':null,'fieldName':'银行机构代码','fieldLength':20,'sqlType':'VARCHAR','fieldValue':'a11'},'银行持债企业代码':{'id':null,'oid':null,'fieldName':'银行持债企业代码','fieldLength':20,'sqlType':'VARCHAR','fieldValue':'a22'},'金融许可证':{'id':null,'oid':null,'fieldName':'金融许可证','fieldLength':20,'sqlType':'VARCHAR','fieldValue':'a33'},'银行持债企业名称':{'id':null,'oid':null,'fieldName':'银行持债企业名称','fieldLength':20,'sqlType':'VARCHAR','fieldValue':'a44'},'ID':{'id':null,'oid':null,'fieldName':'ID','fieldLength':10,'sqlType':'INT','fieldValue':1},'内部机构号':{'id':null,'oid':null,'fieldName':'内部机构号','fieldLength':20,'sqlType':'VARCHAR','fieldValue':'a55'}}}";
//		JSONObject json = JSONObject.parseObject(ss);
//		return json.toJSONString();
//	}
//	@RequestMapping("sss")
//	public String sss(Model model,HttpServletRequest request){
//		model.addAttribute("basePath", this.basePath(request));
//		return "test";
//	}
}
