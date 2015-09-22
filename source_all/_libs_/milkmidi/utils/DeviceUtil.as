/**
 * @author milkmidi
 * http://milkmidi.blogspot.com
 */
package milkmidi.utils {   
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	//import flash.display.StageAspectRatio;
	import flash.system.Capabilities;

    public class DeviceUtil {
		//
		private static var _actionBarHeight:int = 0;
		static public function get actionBarHeight():int {	return _actionBarHeight;		}		
		static public function set actionBarHeight(value:int):void {
			_actionBarHeight = value;
			trace( "DeviceUtil.actionBarHeight : " + _actionBarHeight );
		}
		
		//
		private static var _devicesScale	:Number = 1;
		static public function get devicesScale():Number {	return _devicesScale;		}		
		static public function set devicesScale(value:Number):void {
			_devicesScale = value;
			trace( "DeviceUtil.devicesScale : " + _devicesScale );
		}
		public static function devicesScaleObj ( pObj:DisplayObject ):void {
			pObj.scaleX = _devicesScale;
			pObj.scaleY = _devicesScale;
		}
		
        public static const DESKTOP		:String = "Desktop";
        public static const ANDROID		:String = "Android";
        public static const AMAZON		:String = "Amazon";
        public static const NOOK		:String = "Nook";
        public static const PLAYBOOK	:String = "PlayBook";
        public static const IPAD		:String = "iPad";
        public static const IPHONE		:String = "iPhone";
		
        private static var _deviceName	:String;
        private static var _stage		:Stage;		
		
		private static var _dpiScale	:Number = NaN;
		public static function get dpiScale():Number {	
			if ( isNaN( _dpiScale )) {
				//_dpiScale = Math.max( 1, Capabilities.screenDPI / 160);		
				_dpiScale = Capabilities.screenDPI / 160;		
			}
			
			if (isDesktop) {
				_dpiScale = 1;
			}
			
			return _dpiScale;	
		}		
		
		/**
		 * 初始化
		 * @param	pStage
		 */
		public static function init(pStage:Stage) : void      {
			if (_stage) {
				return;
			}
            _stage = pStage;
			
			log( "deviceName:" + deviceName);									
			log( "stageWidth:" + stageWidth + "x" +stageHeight);									
			log( "fullScreenWidth:" + fullScreenWidth + "x" +fullScreenHeight);									
			log( "screenResolutionX:" + Capabilities.screenResolutionX + "x" +Capabilities.screenResolutionY);												
			log( "screenDPI:" +  Capabilities.screenDPI);					
			log( "dpiScale:" +  dpiScale);			
		}
		private static function log(...arg):void {
			trace.apply( null , ["[DeviceUtil]"].concat( arg ));			
		}
		
		/**
		 * 
		 * @param	pStage
		 * @param	pAspectRatio
		 
		public static function fixIphone3Size( pStage:Stage , pAspectRatio:String ):Sprite {
			
			switch ( true ) {
				case pAspectRatio == StageAspectRatio.LANDSCAPE && Capabilities.screenResolutionX <= 480:
				case pAspectRatio == StageAspectRatio.PORTRAIT && Capabilities.screenResolutionX <= 320:
					var wrap:Sprite = new Sprite;
					wrap.addChild( pStage.getChildAt( 0 ) );
					wrap.width = pAspectRatio == StageAspectRatio.LANDSCAPE ? 480 : 320;
					wrap.scaleY = wrap.scaleX;
					
					pStage.addChild( wrap );						
					return wrap;
			}			
			return null;
			
		}*/
		
		/**
		 * 滿版時的寬度
		 */
		public static function get fullScreenWidth():int {	return _stage.fullScreenWidth;		}
		/**
		 * 滿版時的高度
		 */
		public static function get fullScreenHeight():int {	return _stage.fullScreenHeight;		}
		
		/**
		 * 場景寬度
		 */
		public static function get stageWidth():int {	return _stage.stageWidth;		}
		/**
		 * 場景高度
		 */
		public static function get stageHeight():int {	return _stage.stageHeight;		}
		
		/**
		 * 是否為桌機
		 */
		public static function get isDesktop() : Boolean  {     return deviceName == DESKTOP;        }		
        public static function get isAndroid() : Boolean  {     return deviceName == ANDROID;        }
        public static function get isAmazon() : Boolean   {     return deviceName == AMAZON;        }
        public static function get isPlayBook() : Boolean {     return deviceName == PLAYBOOK;        }
        public static function get isNook() : Boolean     {     return deviceName == NOOK;        }
        public static function get isIOS() : Boolean      {     return deviceName == IPHONE || deviceName == IPAD;        }
		public static function get isIPad():Boolean 	  {		return deviceName == IPAD;		}
       
		/**
		 * 得到裝置的名稱
		 */
        public static function get deviceName() : String        {
            if ( _deviceName == null ) { 								
				var os:String = Capabilities.os.toLowerCase();
                if (os.indexOf("playbook") > -1)
				{
                    _deviceName = PLAYBOOK;
                }
                else if (os.indexOf("iphone") > -1)
				{
                    _deviceName = os.indexOf("ipad") > -1 ? (IPAD) : (IPHONE);
                }
                else if (Capabilities.manufacturer.toLowerCase().indexOf("android") > -1 || os.indexOf("android") > -1)
                {
                    _deviceName = ANDROID;
                }
				else if ( os.indexOf('windows') > -1 )
				{
					_deviceName = DESKTOP;
				}
            }            
            return _deviceName;
        }
		
		
		
		
    }
}
