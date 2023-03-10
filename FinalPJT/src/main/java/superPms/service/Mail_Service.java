package superPms.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import superPms.dao.Mail_Dao;
import superPms.vo.Mail;
import superPms.vo.MailFile;
import superPms.vo.MailSch;


@Service
public class Mail_Service {
	
	@Autowired
	private Mail_Dao dao;
	
	@Value("${mail.upload}")
	private String upload;

	public void insSender(Mail ins) {
		dao.insSender(ins);
		String fname = ins.getReport().getOriginalFilename();
		if(!fname.equals("")) {
			uploadFile(ins.getReport());
			MailFile f = new MailFile();
			f.setFname(fname);
			dao.insertUploadFile(f);
		}
		
	}
	public void insReceiver(Mail ins) {
		dao.insReceiver(ins);
		String fname = ins.getReport().getOriginalFilename();
		if(!fname.equals("")) {
			uploadFile(ins.getReport());
			MailFile f = new MailFile();
			f.setFname(fname);
			dao.insertUploadFile(f);
		}
		
	}
	
	private void uploadFile(MultipartFile f){
	    String fname = f.getOriginalFilename();
	    File fObj = new File(upload+fname);
	    try{
	       f.transferTo(fObj);
	    }catch(Exception e){
	          System.out.println("업로드예외:"+e.getMessage());
	    }         
	}
	  
	public List<Mail> mySendMail(MailSch sch){
		
		  // 1. 총페이지 수
        sch.setCount(dao.totCntSend(sch));
        // 2. 현재페이지 번호(클릭한)
        if(sch.getCurPage()==0) {
           sch.setCurPage(1);
        }
        // 3. 한페이지에 보일 데이터 갯수
        //   - 초기화면 현재 페이지 번호 0 ==> default설정
        if(sch.getPageSize()==0) {
           sch.setPageSize(15);
        }
        // 4. 총페이지 수.(전체데이터/한페이지에 보일 데이터 건수)
        //    한번에 보일 데이터 건수 5건일 때, 총건수11 ==> 3페이지
        sch.setPageCount(
              (int)Math.ceil(
              sch.getCount()/(double)sch.getPageSize())
              );
        // 블럭의 [이후]에 대한 예외 처리..
        if(sch.getCurPage()>sch.getPageCount()) {
           sch.setCurPage(sch.getPageCount());
        }         
        
        // 5. 마지막 번호
        sch.setEnd(sch.getCurPage()*sch.getPageSize());
        sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
        // 6. 블럭처리
        //    1) 블럭 크기 지정
        sch.setBlockSize(5);
        //    2) 블럭 번호 지정 : 현재페이지번호/블럭의 크기 올림 처리
        int blocknum = (int)Math.ceil(sch.getCurPage()/
                 (double)sch.getBlockSize());
        //    3) 마지막 블럭
        int endBlock = blocknum*sch.getBlockSize();
        if(endBlock>sch.getPageCount()) {
           endBlock = sch.getPageCount();
        }
        sch.setEndBlock(endBlock);
        //     4) 시작 블럭
        
        if(blocknum!=0)
            sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
        // 
		return dao.mySendMail(sch);
	}
	

	public Mail sendDetail(int mailno) {
		Mail m = dao.sendDetail(mailno);
		m.setFname(dao.getMailFile(mailno));
		return m;
	}
	public Mail receiveDetail(int mailno) {
		Mail m = dao.receiveDetail(mailno);
		m.setFname(dao.getMailFile(mailno));
		return m;
	}
	public String getMailFile(int mailfno) {
		return dao.getMailFile(mailfno);
	}
	
	public List<Mail> myReceiveMail(MailSch sch){
		  // 1. 총페이지 수
        sch.setCount(dao.totCntReceive(sch));
        // 2. 현재페이지 번호(클릭한)
        if(sch.getCurPage()==0) {
           sch.setCurPage(1);
        }
        // 3. 한페이지에 보일 데이터 갯수
        //   - 초기화면 현재 페이지 번호 0 ==> default설정
        if(sch.getPageSize()==0) {
           sch.setPageSize(15);
        }
        // 4. 총페이지 수.(전체데이터/한페이지에 보일 데이터 건수)
        //    한번에 보일 데이터 건수 5건일 때, 총건수11 ==> 3페이지
        sch.setPageCount(
              (int)Math.ceil(
              sch.getCount()/(double)sch.getPageSize())
              );
        // 블럭의 [이후]에 대한 예외 처리..
        if(sch.getCurPage()>sch.getPageCount()) {
           sch.setCurPage(sch.getPageCount());
        }         
        
        // 5. 마지막 번호
        sch.setEnd(sch.getCurPage()*sch.getPageSize());
        sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
        // 6. 블럭처리
        //    1) 블럭 크기 지정
        sch.setBlockSize(5);
        //    2) 블럭 번호 지정 : 현재페이지번호/블럭의 크기 올림 처리
        int blocknum = (int)Math.ceil(sch.getCurPage()/
                 (double)sch.getBlockSize());
        //    3) 마지막 블럭
        int endBlock = blocknum*sch.getBlockSize();
        if(endBlock>sch.getPageCount()) {
           endBlock = sch.getPageCount();
        }
        sch.setEndBlock(endBlock);
        //     4) 시작 블럭
        if(blocknum!=0)
        sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
        // 
		return dao.myReceiveMail(sch);
	}
	
	public void uptSendState(int mailno) {
		dao.uptSendState(mailno);
	}
	public void uptReceiveState(int mailno) {
		dao.uptReceiveState(mailno);
		
	}
	public void delSendMail(int mailno) {
		dao.delSendMail(mailno);
	}
	public void delReceiveMail(int mailno) {
		dao.delReceiveMail(mailno);
	}
	public void delFile(int mailno) {
		dao.delFile(mailno);
	}
	
	
}
