/**
 * @author milkmidi
 */
package com.milkmidi.p2p {		
	import com.milkmidi.p2p.view.P2PRoom;
	import com.milkmidi.p2p.view.P2PRoom2;
	import flash.display.DisplayObject;
	CONFIG::air{
	import flash.display.StageAspectRatio;
	}
	import milkmidi.qnx.display.QnxMain;
	
	[SWF(width = "800", height = "480", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntry extends QnxMain{		
		
	
		public function MainEntry()  {			
			super(false);
		}	
		override protected function createChildren():void {
			//container.addChild( new P2PRoom );
			CONFIG::air{
			stage.setAspectRatio( StageAspectRatio.LANDSCAPE );						
			}
			container.addChild( new P2PRoom2 );
		}
		
	
		
	
		
	}
}