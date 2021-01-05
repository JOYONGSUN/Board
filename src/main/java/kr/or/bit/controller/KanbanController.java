package kr.or.bit.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import kr.or.bit.dto.card;
import kr.or.bit.dto.kanban;
import kr.or.bit.dto.list;
import kr.or.bit.service.KanbanService;

/*
파일명: KanbanController.java
설명: 칸반 보드에서 리스트와 카드 추가,수정,삭제 및 정렬 작업 후 db에 저장
작성일: 2020-12-28 ~ 
작성자: 문지연,변재홍
*/
@Controller
public class KanbanController {
	
		@Autowired
		private View jsonview;
		
		@Autowired
		private KanbanService kanbanservice;
		
		@RequestMapping(value = "kanbanboard.htm", method = RequestMethod.GET)
		public String home() {
				return "project/project_main";
		}
	
		//kanban update 
		@ResponseBody
		@RequestMapping(value = "updateKanban.pie", method = RequestMethod.POST)
		public View updateKanban(@RequestBody kanban k,
								 @RequestParam("projectNum") int projectNum,
								 Model model) {
			List<list> kanban = k.getKanban();//한 프로젝트의 전체 리트와 카드 
			
			System.out.println("프로젝트 번호 : "+projectNum);
			System.out.println("칸반 리스트의 갯수: "+kanban.size()); 
			
			for(int i = 0; i < kanban.size(); i++) {
				
				System.out.println(kanban.get(i).getList_order_num()+"번째 카드 리스트"+"////리스트 고유 번호"+
								   kanban.get(i).getList_seq());// << 이 녀석을 업데이트 (각 리스트 하나)
				
				HashMap<String,Object> listAndProjectNum = new HashMap<String,Object>();//db update시 파라미터 담을 해쉬맵 
				
				listAndProjectNum.put("list", kanban.get(i));//리스트 한개 
				listAndProjectNum.put("projectNum", projectNum);//프로젝트 번호 
				
				kanbanservice.updateKanbanList(listAndProjectNum);//리스트 업데이트 
				 
				ArrayList<card> cardList = kanban.get(i).getCardList();
				for(int j = 0; j < cardList.size(); j++) {
					System.out.println((i+1)+"번째 카드리스트의  "+"카드정렬번호 : "+cardList.get(j).getCard_order_num()+"////"+
									   (i+1)+"번째 카드리스트의  "+"카드이름 : "+cardList.get(j).getCard_name()+"////"+
									   (i+1)+"번째 카드리스트의  "+"카드고유번호 : "+cardList.get(j).getCard_seq());
					
					HashMap<String,Object> cardAndProjectNum = new HashMap<String,Object>();//db update시 파라미터 담을 해쉬맵 
					cardAndProjectNum.put("card", cardList.get(j));//카드 한개 
					cardAndProjectNum.put("projectNum", projectNum);//프로젝트 번호 
					
					kanbanservice.updateWholeCard(cardAndProjectNum);//카드 업데이트 
				}
			}
			model.addAttribute("success", "success");
			return jsonview;
		}
		
		//해당 프로젝트의 해당되는 칸반 객체를 뷰에게 전달  
		@RequestMapping(value = "loadKanban.pie", method = RequestMethod.POST)
		public View loadKanban(@RequestParam("projectNum") int projectNum, Model model) {
			System.out.println("프로젝트 넘버 : "+projectNum);
			
			ArrayList<card> cardlist = kanbanservice.loadWholeCard(projectNum);
			ArrayList<list> listList = kanbanservice.loadWholeList(projectNum);
			
			for (int i = 0; i < listList.size(); i++) {
				ArrayList<card> li = new ArrayList<card>();
				for(int j = 0; j < cardlist.size(); j++) {
					String order_num = cardlist.get(j).getCard_order_num();
					String result = order_num.substring(0, order_num.indexOf("-"));//" - " 대쉬를 중심으로 앞에 있는 글자들 
					int resultInteger = Integer.parseInt(result);
					if(resultInteger == listList.get(i).getList_order_num()) {//리스트의 오더 번호와 카드의 앞 자리 ex) "3-1" 에서는 3과 같으면 li에 카드를 넣어줌 
						li.add(cardlist.get(j));
					}
				}
				listList.get(i).setCardList(li);//리스트 하나에 정렬번호가 같은 카드들이 들어있는 카드리스트를 삽입 
			}
			
	        Collections.sort(listList, new Comparator<list>() { //리스트들을 정렬해줌 
	            @Override
	            public int compare(list l1, list l2) {//비교하는 대상 값 
	                if (l1.getList_order_num() < l2.getList_order_num()) {
	                    return -1;
	                } else if (l1.getList_order_num() > l2.getList_order_num()) {
	                    return 1;
	                }
	                return 0;
	            }
	        });
	        
	        //여기까지 오면 리스트는 리스트 order_num 순서에 맞게 정렬됨 
	        for(int i = 0; i < listList.size(); i ++) {
	            Collections.sort(listList.get(i).getCardList(), new Comparator<card>() {//리스트의 카드를 정렬해줌 
		            @Override
		            public int compare(card c1, card c2) {//비교하는 대상 값 
		                if (Integer.parseInt(c1.getCard_order_num().substring(c1.getCard_order_num().indexOf("-")+1)) < 
		                	Integer.parseInt(c2.getCard_order_num().substring(c2.getCard_order_num().indexOf("-")+1))) {
		                    return -1;
		                } else if (Integer.parseInt(c1.getCard_order_num().substring(c1.getCard_order_num().indexOf("-")+1)) > 
		                		   Integer.parseInt(c2.getCard_order_num().substring(c2.getCard_order_num().indexOf("-")+1))) {
		                    return 1;
		                }
		                return 0;
		            }
		        });
	        }
	        
	        //여기까지 오면 카드까지 정렬됨 
			model.addAttribute("listList", listList);
			System.out.println(listList);	
			return jsonview;
		}
		
		//Make_kanban_List 
		@ResponseBody
		@RequestMapping(value = "makeKanbanList.pie", method = RequestMethod.POST)
		public View makeKanbanList(@RequestBody list li,
	  							   @RequestParam("projectNum") int projectNum, Model model) {
					
					System.out.println(li);
					
					HashMap<String,Object> listInfoAndProjectNum = new HashMap<String,Object>();//db update시 파라미터 담을 해쉬맵 
					listInfoAndProjectNum.put("list", li);
					listInfoAndProjectNum.put("projectNum", projectNum);
					boolean check  = kanbanservice.insertKanbanListService(listInfoAndProjectNum);
					
					if(check) {
						int getLiSeq = kanbanservice.getListSeqService(projectNum);
						System.out.println("리스트 인서트 성공");
						model.addAttribute("data", getLiSeq);
						return jsonview;
					}
					model.addAttribute("data", false);
					return jsonview;
				}
		
		//get_Last_List_Num
		@ResponseBody
		@RequestMapping(value = "getLastListNum.pie", method = RequestMethod.POST)
		public View getLastListNum(@RequestParam("projectNum") int projectNum, Model model) {
			
		int lastNum = kanbanservice.getLastListNumService(projectNum);
		model.addAttribute("data", lastNum);
					return jsonview;
			}
		
		//Make_kanban_card
		@ResponseBody
		@RequestMapping(value = "makeKanbanCard.pie", method = RequestMethod.POST)
		public View makeKanbanCard(@RequestBody card c,
	  							   @RequestParam("projectNum") int projectNum, Model model) {
					
					HashMap<String,Object> cardInfoAndProjectNum = new HashMap<String,Object>();//db update시 파라미터 담을 해쉬맵 
					cardInfoAndProjectNum.put("card", c);
					cardInfoAndProjectNum.put("projectNum", projectNum);
					boolean check  = kanbanservice.insertKanbanCardService(cardInfoAndProjectNum);
					
					if(check) {
						int getCardSeq = kanbanservice.getCardSeqService(projectNum);
						System.out.println("카드 인서트 성공");
						model.addAttribute("data", getCardSeq);
						return jsonview;
					}
					model.addAttribute("data", false);
					return jsonview;
				}
		
		//edit_list_title
		@ResponseBody
		@RequestMapping(value = "editKanbanListTitle.pie", method = RequestMethod.POST)
		public View editKanbanListTitle(@RequestBody list li, Model model){
					kanbanservice.editKanbanListTitleService(li);
					System.out.println("제목 수정 완료");
					
					model.addAttribute("data", "success");
					return jsonview;
			}
		
		//delete_list_and_card
		@ResponseBody
		@RequestMapping(value = "deleteKanbanList.pie", method = RequestMethod.POST)
		public View deleteKanbanList(@RequestBody list li,
									 @RequestParam("projectNum") int projectNum,
									 Model model){
			
					kanbanservice.deleteKanbanListAndCardService(li);
					System.out.println("리스트 삭제 완료");
					model.addAttribute("data", "success");
					return jsonview;
			}
		
		//delete_card
		@ResponseBody
		@RequestMapping(value = "deleteKanbanCard.pie", method = RequestMethod.POST)
		public View deleteKanbanCard(@RequestBody card ca,
									 @RequestParam("projectNum") int projectNum,
									 Model model){
					kanbanservice.deleteKanbanCardService(ca);
					model.addAttribute("data", "success");
					return jsonview;
			}
		//edit_Card_title
		@ResponseBody
		@RequestMapping(value = "editKanbanCardTitle.pie", method = RequestMethod.POST)
		public View editKanbanCardTitle(@RequestBody card ca, Model model){
					kanbanservice.editKanbanCardTitleService(ca);
					System.out.println("카드 제목 수정 완료");
					
					model.addAttribute("data", "success");
					return jsonview;
			}
		
		
	}
