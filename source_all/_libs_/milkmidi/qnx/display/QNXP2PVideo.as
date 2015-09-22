/**
 * @author milkmidi
 * @date created 2012/06/27/
 */
package milkmidi.qnx.display {		
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import milkmidi.p2p.events.PeerEvent;
	import milkmidi.p2p.PeerGroup;
	import milkmidi.utils.ResizeUtil;
	import qnx.ui.core.Container;
	import qnx.ui.core.Containment;
	import qnx.ui.core.InvalidationType;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.UIComponent;
	
	public class QNXP2PVideo extends UIComponent{		
		protected static const PUBLISH_NAME		:String = "multicast";		
		
		public static const BROADCASTER	:int = 0;
		public static const RECEIVER	:int = 1;
		
		
		private var _video	:Video;
		private var _p2p	:PeerGroup;
		private var _mode	:int;
		private var _camera	:Camera;
		//__________________________________________________________________________________ Constructor
		public function QNXP2PVideo( pP2P:PeerGroup , pMode:int)  {						
			
			__startWidth = 320;
			__startHeight = 240;
			this._video = new Video(320, 240);
			
			this.addChild(_video);
			this._mode = pMode;
			this._p2p = pP2P;
			this._p2p.addEventListener(PeerEvent.NET_STREAM_CONNECT_SUCCESS , onNetStreamConnectSuccess);		
			super();
			this.sizeUnit = SizeUnit.PERCENT;
			this.size = 100;
			this.containment = Containment.BACKGROUND;
		}		
		
		private function onNetStreamConnectSuccess(e:Event):void {
			if (this._mode == BROADCASTER) {
				this._camera = Camera.getCamera();
				if(_camera){					
					this._camera.setMode(320, 240, 12);						
					this._camera.setQuality(50000, 0);						
					//cam.setKeyFrameInterval(15);
					this._p2p.netStream.attachCamera(_camera);						
					//_p2p.netStream.bufferTime=1;
					this._p2p.netStream.publish(PUBLISH_NAME);						
					this._video.attachCamera(_camera);
				}else{
					//writeText("NoCamera");
				}					
			}else {
				this._p2p.netStream.play(PUBLISH_NAME);				
				this._video.attachNetStream(_p2p.netStream);		
			}
			
		}
		override protected function validate(property:String = "all"):void {
			if ( isInvalid( InvalidationType.SIZE) ) {
				//_video.width = width;
				//_video.scaleY = _video.scaleX;
				//ResizeUtil.resize( this._video , this  );
				trace( this.width , this.height );
				this.graphics.clear();
				this.graphics.beginFill(0x000000, .5);
				this.graphics.drawRect(0, 0, width, height);
				this.graphics.endFill();
			}
			super.validate(property);
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package