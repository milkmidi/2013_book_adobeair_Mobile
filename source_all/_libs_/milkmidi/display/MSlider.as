package milkmidi.display {	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import milkmidi.events.SliderEvent;
	import milkmidi.utils.OrientationType;
	
	
	[Event(name = "sliderDown", type = "milkmidi.events.SliderEvent")]
	[Event(name = "sliderUpDown", type = "milkmidi.events.SliderEvent")]
	[Event(name = "sliderMove", type = "milkmidi.events.SliderEvent")]
	
	public class MSlider extends EventDispatcher	{
		
		public static const SLIDER_DOWN	:String = "sliderDown";
		public static const SLIDER_UP	:String = "sliderUp";
			
		private var _thumb		:Sprite;
		private var _track		:Sprite;
		private var _trackClick	:Boolean = false;
		private var _stage		:Stage;
		private var _value		:Number = 0;
		private var _max		:Number = 1.0;
		private var _min		:Number = 0;
		private var _tick		:Number = 1;
		private var _orientation:String;			
		private var _width		:Number;
		private var _height		:Number;			
		public var autoDestroy	:Boolean = true;
		public var enabled		:Boolean = true;
		
		public var offsetX		:int = 0;
		public var offsetY		:int = 0;

		/**
		 * 建立 Slider 類別
		 * @param	pThumb 小拉Bar
		 * @param	pTrack 背景Bar
		 * @param	pOrientaion 方向
		 */
		public function MSlider(pThumb:Sprite , pTrack:Sprite, pOrientaion:String = "vertical") {			
			_orientation = pOrientaion;		
			_thumb = pThumb;			
			_thumb.buttonMode = true;						
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDownDragHandler);
			_thumb.addEventListener(Event.REMOVED_FROM_STAGE , onRemovedFromStageHandler);
			_thumb.addEventListener(MouseEvent.MOUSE_WHEEL , onMouseWheelHandler);
			
			_track = pTrack;
			_track.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
			_track.addEventListener(MouseEvent.MOUSE_WHEEL , onMouseWheelHandler);
			
			if (_orientation ==  OrientationType.HORIZONTAL ){
				_width = _track.width;
				_height = _thumb.width;
			}else {
				_width = _thumb.height;
				_height = _track.height;
			}
			if (_thumb.stage) 
				init();
			else
				_thumb.addEventListener(Event.ADDED_TO_STAGE , init);
		}				
		
		private function init(e:Event = null):void {			
			_thumb.removeEventListener(Event.ADDED_TO_STAGE, init);	
			_stage = _thumb.stage;
			positionHandle();
		}		
		private function onRemovedFromStageHandler(e:Event):void {			
			if (autoDestroy) {				
				destroy();				
			}
		}	
		public function setSize( pThumbSize:int , pTrackSize:int):void {
			_width = pThumbSize;
			_height = pTrackSize;
			_thumb.x = 0;
			_thumb.y = 0;
			_track.x = 0 ;
			_track.y = 0 ;
		}
		
		private function onMouseWheelHandler(e:MouseEvent):void {			
			if (e.delta < 0) {				
				value += .2;
			}else
				value -= .2;	
			dispatchEvent( new SliderEvent(SliderEvent.SLIDER_MOVE , value , true));						
		}
		protected function correctValue():void {
			if(_max > _min)	{
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
			}else{
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
			}
		}	
		protected function positionHandle():void {
			var range:Number;
			if(_orientation ==  OrientationType.HORIZONTAL ){
				range = maxX;
				_thumb.x = (_value - _min) / (_max - _min) * range + _track.x;
			}else	{
				range = maxY - offsetY;				
				_thumb.y = _height - _width - (_value - _min) / (_max - _min) * range + _track.y;
			}
		}	
		public function setSliderParams(min:Number, max:Number, value:Number):void {
			minimum = min;
			maximum = max;
			value = value;
		}
		
		private function onBackClick(e:MouseEvent):void {
			if (!enabled) return;
			if(_orientation ==  OrientationType.HORIZONTAL )	{
				_thumb.x = _thumb.parent.mouseX - _height / 2;				
				_thumb.x = Math.max(_thumb.x, _track.x);
				_thumb.x = Math.min(_thumb.x, _width - _height + _track.x);				
			}else	{
				_thumb.y = _thumb.parent.mouseY - _width / 2 + _track.y;
				_thumb.y = Math.max(_thumb.y, _track.y);				
				_thumb.y = Math.min(_thumb.y, _height - _width +_track.y);					
			}
			onSlide(e);
		}	
		protected function onThumbMouseDownDragHandler(e:MouseEvent):void {
			if (!enabled) 
				return;
				
			dispatchEvent( new SliderEvent(SliderEvent.SLIDER_DOWN));			
			_stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);			
			if(_orientation == OrientationType.HORIZONTAL ){
				_thumb.startDrag(false, new Rectangle( _track.x, _track.y, maxX, 0));									
			}else{
				_thumb.startDrag(false, new Rectangle( _track.x, _track.y, 0, maxY + offsetY));									
			}			
		}
	
		protected function onDrop(e:MouseEvent):void {
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_thumb.stopDrag();
			dispatchEvent(new SliderEvent(SliderEvent.SLIDER_UP));			
		}	
		
		protected function onSlide(e:MouseEvent):void 	{
			if (!enabled) return;
			var oldValue		:Number = _value;
			var scrollRange		:int;
			if (_orientation ==  OrientationType.HORIZONTAL ) {	
				scrollRange = _width - _height;
				_value = (_thumb.x - _track.x) / scrollRange * (_max - _min) + _min;							
			}
			else {
				scrollRange = _height - _width + offsetY;
				_value = (_thumb.y) / scrollRange * (_max - _min) + _min;						
			}
			if(_value != oldValue){
				dispatchEvent(new SliderEvent(SliderEvent.SLIDER_MOVE, _value, true));				
			}
		}		
		private function get maxX():int {	return _track.width - _thumb.width;		}
		private function get maxY():int {	return _track.height - _thumb.height;	}
		
		public function get value():Number {	return _value / _tick * _tick;		}	
		public function set value(v:Number):void {
			_value = v;
			correctValue();
			positionHandle();
		}
		
		public function get maximum():Number{return _max;	}	
		public function set maximum(m:Number):void {
			_max = m;
			correctValue();
			positionHandle();
		}
		
		public function get minimum():Number {	return _min;	}
		public function set minimum(m:Number):void {
			_min = m;
			correctValue();
			positionHandle();
		}
		
		public function get tick():Number {	return _tick;	}
		public function set tick(t:Number):void {		_tick = t;		}		
		public function destroy():void {
			if (_destroyed) {
				return;
			}
			_destroyed = true;
		
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);	
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDownDragHandler);			
			_track.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);			
			_track.removeEventListener(MouseEvent.MOUSE_WHEEL , onMouseWheelHandler);
			_thumb.removeEventListener(MouseEvent.MOUSE_WHEEL , onMouseWheelHandler);			
			_thumb.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		private var _destroyed:Boolean = false;
		public function get destroyed():Boolean {	return _destroyed;		}
		
	}
}
