/*    
    Copyright (c) 2009 milkmidi    
    All rights reserved.
    http://milkmidi.com
    http://milkmidi.blogspot.com
*/	
package milkmidi.book2013 {	

	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	import milkmidi.coverflow.view.CoverFlowView;
	import milkmidi.display.MApplication;
	import milkmidi.model.MainModel;
	import milkmidi.model.ResourceModel;
	import milkmidi.model.StageModel;
	import milkmidi.utils.DeviceUtil;
	import net.hires.debug.Stats;
	import swc.Splash_mc;
	
	
	[SWF(width = "480", height = "800", frameRate = "34", backgroundColor = "#ededed")]			
	//[SWF(width = "480", height = "800", frameRate = "34", backgroundColor = "#292b2f")]			
    public class MainEntry extends MApplication {		
	
		private var _view	:CoverFlowView;		
		private var splash	:Splash_mc;
		public function MainEntry() {		
			ResourceModel;
			
		}		
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			CONFIG::air {		
				NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;				
			}									
			
			if ( Capabilities.screenResolutionX <= 320) {
				DeviceUtil.devicesScale = .5;				
			}
			

			
			CONFIG::release {
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE , function ():void {
					NativeApplication.nativeApplication.exit();
				});
				
				splash = new Splash_mc;
				addChild( splash );
				addEventListener(Event.ENTER_FRAME , function (evt:Event):void {
					splash.x = stage.fullScreenWidth >> 1;
					splash.y = stage.fullScreenHeight >> 1;
					splash.scaleX = DeviceUtil.devicesScale;
					splash.scaleY = DeviceUtil.devicesScale;
					if (splash.currentFrame == splash.totalFrames) {
						removeEventListener(evt.type , arguments.callee );						
						init();
					}
				});
			}
			
			CONFIG::debug {
				init();
				var stats:Sprite = addChild( new Stats ) as Sprite;
				stats.scaleX = 1.5;
				stats.scaleY = 1.5;
				stats.mouseEnabled = false;
				stats.mouseChildren = false;
				stats.alpha = .9;
				stats.x = stage.fullScreenWidth - stats.width;
			}
			
			
			
		}
		protected function init():void {
			StageModel.init( stage );
			MainModel.instance.onChangeView.add( onChangeView );			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);						
			addChildAt( new MainContainer, 0 );	
			
			_view = new CoverFlowView();					
			_view.antiAlias = 2;									
			addChild( _view );
			_view.stage3DProxy.stage3D.addEventListener(Event.CONTEXT3D_CREATE , onContext3DCreateHandler);
			
			MainModel.instance.currentIndex = -1;
			stage.quality = StageQuality.LOW;
		}
		
		protected function onKeyDownHandler(e:KeyboardEvent):void {			
			
		}
		
		
		
		private function onChangeView( type:int ):void {
			if ( type == -1) {
				stage.setAspectRatio( StageAspectRatio.PORTRAIT );				
				
				addChild( _view );															
				_view.isRender = true;
			}else {
				_view.isRender = false;
				removeChild( _view );
			}
		}	
		
		private function onContext3DCreateHandler(e:Event):void {
			e.currentTarget.removeEventListener( e.type , arguments.callee );
			//_view.stage3DProxy.context3D.configureBackBuffer( 320, 240, 0);
			if (splash) {
				setTimeout( removeChild ,300, splash);
				splash = null;				
			}
		}
		
	
		
    }
}


