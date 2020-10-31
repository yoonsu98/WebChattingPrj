package com.gaon.prj.chatting.svc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.google.cloud.translate.Translate;
import com.google.cloud.translate.Translate.TranslateOption;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
@Service
public class SingleChatImpl implements SingleChatSVC {

	@Override
	public Map<String, String> getTransChat(HashMap<String, String> chat) {
		// TODO Auto-generated method stub
		Map<String, String> transchat_map = new HashMap<String, String>();
		
		String API_KEY = "AIzaSyD4chqKBNMMRvFoy6rSRLRf4kHVMISLLx8";
	    Translate translate = TranslateOptions.newBuilder().setApiKey(API_KEY).build().getService();
	 
	 
	    String text = chat.get("chat");
	    
	    // 언어 감지
	    String sourcLang = translate.detect(text).getLanguage();
        
	    if (!sourcLang.equals("en")){
			Translation translation = translate.translate( text,
			TranslateOption.sourceLanguage(sourcLang), TranslateOption.targetLanguage("en"));
			
		    String transchat = translation.getTranslatedText();
		    transchat_map.put("trans_chat", transchat);
	    }
	    else {
	    	transchat_map.put("trans_chat", text);
	    }
		return transchat_map;
	}

}
