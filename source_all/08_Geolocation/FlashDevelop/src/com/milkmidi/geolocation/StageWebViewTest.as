/**
 * @author milkmidi
 */
package com.milkmidi.geolocation
{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.system.*;
	import milkmidi.qnx.display.*;
	import milkmidi.utils.DeviceUtil;
	import qnx.ui.buttons.*;
	import qnx.ui.core.*;
	
	public class StageWebViewTest extends QnxMain	{
		
		// StageWebView
		private var _sv		:StageWebView;
		// 將網頁存成圖片的按鈕
		private var _saveBtn:LabelButton;
		
		public function StageWebViewTest()		{
			super(false);		
		}		
		override protected function createChildren():void{			
			// 建立 LabelButton
			_saveBtn = new LabelButton();
			_saveBtn.label = "SAVE";
			// 置網頁的最下方
			_saveBtn.containment = Containment.DOCK_BOTTOM;
			_saveBtn.addEventListener(MouseEvent.CLICK, onSaveClickHandler);			
			
			// 依裝置的 dpi 做縮放
			var scale:Number = Math.max( 1,  Capabilities.screenDPI / 160 );			
			_saveBtn.scaleX = scale ;
			_saveBtn.scaleY = scale;
			container.addChild(_saveBtn);
			
			// 筆者開發的 DeviceUtil 類別
			// 用來得知目前的裝置相關資訊
			DeviceUtil.init( stage );				
			if (StageWebView.isSupported) {
				// 載入筆者的 blog
				loadMilkmidiBlogspot();
				
				// 載入資料夾下的 html 檔
				//loadLocalHtml();
			}		
		}
		private function loadMilkmidiBlogspot():void {
			_sv = new StageWebView();
			_sv.stage = stage;
			// 指定 viewPort 大小
			_sv.viewPort = new Rectangle(0, DeviceUtil.actionBarHeight, stage.stageWidth, stage.stageHeight - _saveBtn.height - DeviceUtil.actionBarHeight);							
			// 載入網頁
			_sv.loadURL("http://milkmidi.blogspot.com");	
		}
		private function loadLocalHtml():void {
			var path:String;
			if (DeviceUtil.isDesktop) { // 判斷如果目前是桌機版的話				
				// 桌機版用此方法載入
				path = new File(new File("app:/www/about.html").nativePath).url;	
			}else {
				// 行動裝置版用此方法載入
				path = copyFile( "www", "about.html");									
			}				
			_sv.loadURL( path );
		}
		
		/**
		 * 複製檔案, 以決解行動裝置無法載入的路徑問題
		 * @param	folderName 資料夾名稱
		 * @param	indexName html檔名
		 * @param	once 是否 只複製一次
		 * @return
		 */
		public static function copyFile(folderName:String, indexName:String, once:Boolean = true):String {			
			var source:File = File.applicationDirectory.resolvePath(folderName);
			var destination:File = File.applicationStorageDirectory;
			if (!destination.resolvePath(indexName).exists || !once)			
				source.copyTo(destination, true);
			return "file://" + destination.resolvePath(indexName).nativePath;
		}
		
		override protected function atResize():void {
			container.setSize( stage.stageWidth, stage.stageHeight-122 );		
			if (_sv) {
				_sv.viewPort = new Rectangle(0, 122, stage.stageWidth, stage.stageHeight - _saveBtn.height - 122);								
			}
		}		
		private function onSaveClickHandler(e:MouseEvent):void		{
			trace("Save Image");
			// 建立 BitmapData 類別
			var bitmapData:BitmapData = new BitmapData(_sv.viewPort.width, _sv.viewPort.height);			
			
			// 將 StageWebView 目前的畫面輸出至 bitmapData
			_sv.drawViewPortToBitmapData(bitmapData);
			if (CameraRoll.supportsAddBitmapData)			{
				// 儲存圖片
				new CameraRoll().addBitmapData(bitmapData);
			}
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			
			try {
				_sv.dispose();				
			}catch (err:Error){
			
			}
		}
		
	
	} //__________________________________________________________________________________ End Class
} //__________________________________________________________________________________ End Package