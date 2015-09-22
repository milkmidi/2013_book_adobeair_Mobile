/**
 * @author milkmidi
 */
package com.milkmidi.stagevideo.media {		
	
	public class NetStatusInfoCode {		
		
		// 連線嘗試已成功。
		public static const NetConnection_Connect_Success	:String = "NetConnection.Connect.Success";
		
		// 連線已成功關閉。
		public static const NetConnection_Connect_Closed	:String = "NetConnection.Connect.Closed";
		
		// 連線嘗試已失敗
		public static const NetConnection_Connect_Failed	:String = "NetConnection.Connect.Failed";
		
		// 播放已經開始。
		public static const NetStream_Play_Start	:String = "NetStream.Play.Start";
		
		// 播放已經停止。
		public static const NetStream_Play_Stop		:String = "NetStream.Play.Stop";
		
		// 因為播放清單重設而造成。注意：在 AIR 3.0 for iOS 中不受支援。
		public static const NetStream_Play_Reset	:String = "NetStream.Play.Reset";
		
		// 串流已暫停。
		public static const NetStream_Pause_Notify	:String = "NetStream.Pause.Notify";
		
		// 串流已繼續播放
		public static const NetStream_Unpause_Notify:String = "NetStream.Unpause.Notify";
		
		
		// "status"	資料已經完成串流，而剩下的緩衝區將會被清空。注意：在 AIR 3.0 for iOS 中不受支援。		
		public static const NetStream_Buffer_Flush	:String = "NetStream.Buffer.Flush";
		
		
		// "status"	緩衝區已填滿，串流將會開始播放。		
		public static const NetStream_Buffer_Full	:String = "NetStream.Buffer.Full";
		
		
		// "status"	Flash Player 接收資料的速度不夠快，無法填入緩衝區。資料流將會中斷，直到緩衝區重新填滿為止；屆時將會送出 NetStream.Buffer.Full 訊息，而串流也會重新開始播放。		
		public static const NetStream_Buffer_Empty	:String = "NetStream.Buffer.Empty";
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package