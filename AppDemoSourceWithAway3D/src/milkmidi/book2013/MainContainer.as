/**
 * @author milkmidi
 * @date created 2012/12/02/
 */
package milkmidi.book2013 {		
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.text.TextFieldAutoSize;
	import milkmidi.book2013.cast.IChild;
	import milkmidi.book2013.model.CommonModel;
	import milkmidi.display.MSprite;
	import milkmidi.model.MainModel;
	import milkmidi.model.ResourceModel;
	import milkmidi.utils.DeviceUtil;
	import milkmidi.utils.SimpleButtonProxy;
	import milkmidi.utils.SystemUtil;
	import swc.ActionBar320_mc;
	import swc.ActionBar480_mc;
	import swc.ActionBar640_mc;
	
	public class MainContainer extends MSprite {		
		
	
		
		
		private var _currentView:DisplayObject;
		private var _actionBar	:MovieClip;
		//__________________________________________________________________________________ Constructor
		public function MainContainer()  {			
			
			MainModel.instance.onChangeView.add( onChangeView );
			CommonModel.instance.onActionBarLabelChange.add( onActionBarLabelChange );
			visible = false;
			
			
			switch (true) {
				case Capabilities.screenResolutionX <= 320:
					_actionBar = new ActionBar320_mc;
					break;				
				case Capabilities.screenResolutionX <= 480:
					_actionBar = new ActionBar480_mc;
					break;
				default:
					_actionBar = new ActionBar640_mc;
					break;
			}
			
			addChild( _actionBar );
			_actionBar.cacheAsBitmap = true;
			_actionBar.cacheAsBitmapMatrix = new Matrix;
			_actionBar.label_txt.autoSize = TextFieldAutoSize.LEFT;
			new SimpleButtonProxy( _actionBar.back_mc ).addClick( onBackClickHandler);
		}		
		
		private function onActionBarLabelChange( pLabel:String ):void {
			_actionBar.label_txt.text = pLabel;
		}
		
		private function onBackClickHandler(e:Event):void {
			var child:DisplayObject = Loader( Sprite(_currentView).getChildAt( 0 )).content;
			if (child is IChild) {				
				if ( !IChild( child ).onBackKeyDown() ) {
					MainModel.instance.currentIndex = -1;
				}				
			}else {
				MainModel.instance.currentIndex = -1;							
			}
		}
		override protected function atResize():void {
			super.atResize();
			
			DeviceUtil.actionBarHeight = _actionBar.height;// + (5 * DeviceUtil.dpiScale);					
			_actionBar.bg_mc.width = stage.fullScreenWidth;
		}
		
		private function onChangeView( index:int ):void {
			
			
			if (index == -1) {						
					
				if (_currentView) {
					TweenMax.to( _currentView , .5, {
						x			:stage.stageWidth,
						ease		:Cubic.easeInOut,
						onComplete	:function ( ):void {
							removeChild( _currentView );
							_currentView = null;
							visible = false;	
						}
					} );
				}		
				TweenMax.to( _actionBar , .5, {
					y			: -_actionBar.height,
					ease		:Cubic.easeInOut
				});
				
			}else {
				_actionBar.label_txt.text = index + "";
				
				var idx:int = index % ResourceModel.LENGTH;
				
				_currentView = ResourceModel.getResource( idx );		
				
				var label:String = ResourceModel.getDescription( idx );
				_actionBar.label_txt.text = label;
				_actionBar.label_txt.y = _actionBar.height - _actionBar.label_txt.textHeight >> 1;
				
				addChildAt( _currentView, 0 );
				_actionBar.y = -_actionBar.height;				
				TweenMax.to( _actionBar , .5, {
					y			:0,
					ease		:Cubic.easeInOut
				});
				TweenMax.from( _currentView , .5, {
					x			:stage.stageWidth,
					ease		:Cubic.easeInOut
				});				
				visible = true;				
			}
			SystemUtil.clearMemory();
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package