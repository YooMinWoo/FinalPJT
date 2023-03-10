package superPms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import superPms.service.Alert_Service;
import superPms.vo.SuperEmpDept;

@Controller
public class Alert_Controller {
  
   @Autowired
   private Alert_Service service; 
   // http://localhost:7080/FinalPJT/alert.do
   
   @GetMapping("/alert.do")  
   public String alertList(Model d,HttpSession session) {
	  SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
      d.addAttribute("alertList", service.alertList(sObj.getId()));
      d.addAttribute("alertCount", service.alertCount(sObj.getId()));
      return "WEB-INF\\suminView\\alert.jsp";
   }
   
   @RequestMapping("/alertState.do")
   public String alertState(@RequestParam("no")int no) {
      service.alertState(no);
      return "WEB-INF\\\\suminView\\\\alert.jsp";
   }
//   @RequestMapping("/alertList.do")
//   public String alertAjax(@RequestParam("id")String id,Model d) {
//      d.addAttribute("alertList", service.alertList(id));
//      return "WEB-INF\\\\suminView\\\\alert.jsp";
//   }
   
}