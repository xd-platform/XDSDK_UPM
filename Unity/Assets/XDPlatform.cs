﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;  
using System.Runtime.InteropServices;

public class XDPlatform : MonoBehaviour {

	void Start()
	{

	}

	void Update () {
		
	}
		
	void OnGUI() {

		if (GUI.Button (new Rect (80, 80, 100, 100), "初始化")) {

			xdsdk.XDSDK.SetCallback (new XDSDKHandler ());

			xdsdk.XDSDK.Init ("d4bjgwom9zk84wk", 1);
		}

		if(GUI.Button(new Rect(280,80,100,100),"登录")) {  

			xdsdk.XDSDK.Login ();
		}  

		if(GUI.Button(new Rect(480,80,100,100),"登出")) {  

			xdsdk.XDSDK.Logout ();
		}


		if (GUI.Button (new Rect (80, 200, 100, 100), "用户中心")) {

			xdsdk.XDSDK.OpenUserCenter ();
		}

		if(GUI.Button(new Rect(280,200,100,100),"支付")) {  

			Dictionary<string, string> info = new Dictionary<string,string>();
			info.Add("OrderId", "1234567890123456789012345678901234567890");
			info.Add("Product_Price", "1");
			info.Add("EXT", "abcd|efgh|1234|5678");
			info.Add("Sid", "2");
			info.Add("Role_Id", "3");
			info.Add("Product_Id", "XDSDKPoint");
			info.Add("Product_Name", "648大礼包");
			xdsdk.XDSDK.Pay (info);
		}  

		if(GUI.Button(new Rect(480,200,100,100),"账号ID")) {  

			sdk_debug_msg (xdsdk.XDSDK.GetAccessToken ());
		}



		if (GUI.Button (new Rect (80, 320, 100, 100), "版本号")) {

			sdk_debug_msg (xdsdk.XDSDK.GetSDKVersion());
		}

		if(GUI.Button(new Rect(280,320,100,100),"隐藏游客")) {  

			xdsdk.XDSDK.HideGuest ();
		}  

		if(GUI.Button(new Rect(480,320,100,100),"隐藏QQ")) {  

			xdsdk.XDSDK.HideQQ ();
		}



		if (GUI.Button (new Rect (80, 440, 100, 100), "隐藏WX")) {

			xdsdk.XDSDK.HideWX ();
		}

		if(GUI.Button(new Rect(280,440,100,100),"显示VC")) {  

			xdsdk.XDSDK.ShowVC ();
		}  

		if(GUI.Button(new Rect(480,440,100,100),"QQWeb")) {  

			xdsdk.XDSDK.SetQQWeb ();
		}

		if (GUI.Button (new Rect (80, 560, 100, 100), "WXWeb")) {

			xdsdk.XDSDK.SetWXWeb ();
		}

		if (GUI.Button (new Rect (280, 560, 100, 100), "isLogedIn")) {

			sdk_debug_msg (xdsdk.XDSDK.IsLoggedIn ().ToString());
		}
	}

	[DllImport("__Internal")]
	private static extern void sdk_debug_msg(string msg);
}
