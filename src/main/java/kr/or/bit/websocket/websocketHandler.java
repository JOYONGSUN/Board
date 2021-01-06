package kr.or.bit.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.bit.dto.user;

@Controller
public class websocketHandler extends TextWebSocketHandler{
		//로그인한 전체 회원 관리
		List<WebSocketSession> sessionList = new ArrayList<>();
		// 1대1
		Map<String, WebSocketSession>	userSessionsMap = new HashMap<>();
		
		//서버에 접속 성공했을때
		@Override
		public void afterConnectionEstablished(WebSocketSession session) {
			System.out.println("afterConnectionEstablished: "+session);
			sessionList.add(session);
			String senderEmail = getEmail(session);
			userSessionsMap.put(senderEmail, session);
			System.out.println("연결됨:"+getEmail(session));
		}
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			System.out.println("받음:"+message);
			String senderId = getEmail(session);
			for(WebSocketSession sess: sessionList) {
					sess.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
			}
		}
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
			sessionList.remove(session);
			System.out.println("끊김:"+session.getId());
		}
		private String getEmail(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			user loginUser = (user)httpSession.get("user");
			
			if(loginUser == null) {
				return session.getId();
			}else {
				return loginUser.getEmail();
			}
				
		}
}
