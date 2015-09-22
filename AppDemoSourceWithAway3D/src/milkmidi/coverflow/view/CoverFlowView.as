package milkmidi.coverflow.view {	
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Object3D;
	import away3d.events.MouseEvent3D;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import milkmidi.away3d.view.BasicView;
	import milkmidi.coverflow.utils.MethodUtil;
	import milkmidi.model.MainModel;
	import milkmidi.model.ResourceModel;
	import milkmidi.utils.DeviceUtil;
	
	
	public class CoverFlowView extends BasicView {			
		public var currentPlaneIndex:Number = 0.0;
		
		// 會超過
		private var _currentSelectIndex		:Number = -1;
		public function set currentSelectIndex( val:Number ):void {
			this._currentSelectIndex = val;
			shiftToItem( this._currentSelectIndex );
		}
		public function get currentSelectIndex():Number {		return _currentSelectIndex;		}		
	
		
		private static var INDEX_LENGTH:int = 16;
		
		private var _planes			:Vector.<Object3D>;
		private var _container3D	:ObjectContainer3D;
		private var _tweenMax		:TweenMax;
		
		private var _mouseDownPosition		:int;
		private var _tmpIndex		:int;
		private var _isVertical			:Boolean = true;
	
		// 是否目前為使用者按下狀態
		private var _isTouchMove	:Boolean = false;
	
		//private var _bgPlane		:Mesh;
		
		//[Embed(source = "../../../assets/bg1.png")]
		//private static const BG_TEXTURE:Class;
		private static var USER_FINGER_RANGE:int;
		
		
		private var _refObj:Object = { };
		public function CoverFlowView()  {				
			super();
			_container3D = new ObjectContainer3D();
			scene.addChild( _container3D );			
		
			_planes = new Vector.<Object3D>();		
			
			this.backgroundColor = 0xededed;	
			//this.backgroundColor = 0x292b2f;	
			
			USER_FINGER_RANGE = DeviceUtil.dpiScale * 30;
			
			trace( "USER_FINGER_RANGE : " + USER_FINGER_RANGE );
			
			
		}	
		override protected function init():void {
			super.init();	
							
		
			for (var i:int = 0; i < INDEX_LENGTH; i++) {
				var _radian	:Number = (2 * Math.PI) / 10 * (10 - i);						
				var _plane:ReflectionPlane = new ReflectionPlane( ResourceModel.getBitmapData( i ));								
				_plane.name = i + "";				
				_plane.mouseEnabled = true;
				_plane.addEventListener( MouseEvent3D.MOUSE_UP , onPlaneMouse3DDownHandler);
				_container3D.addChild(_plane );				
				_planes.push( _plane );
			}
			//currentPlaneIndex = 16 / 2;
			
			this.currentSelectIndex = 5;
			
			
			
			setTimeout( function ():void {
				currentSelectIndex = 0;	
			},1600);
		
			var length:int = _planes.length;
			/*for (var i:int = 0; i < length; i++) {
				//var _plane:ReflectionPlane = _planes[i];
			}*/
			TweenMax.from( this.camera , 1.5, {
				z			:2000,
				ease		:Cubic.easeInOut
			} );
			
			//var mat:BitmapTexture = Cast.bitmapTexture(BG_TEXTURE);
			//var p:PlaneGeometry = new PlaneGeometry(1024, 1024);
			//p.yUp =  false;
			/*_bgPlane = new Mesh( p, new TextureMaterial(mat));			
			_bgPlane.scaleX = 2;
			_bgPlane.scaleY = 2;*/
			//_bgPlane.z = -2000;
			//_container3D.addChild(_bgPlane);
			
			MainModel.instance.onChangeView.add( onChangeView );
		}
		
		private function onResizeHandler(e:Event):void {
			//trace( "CoverFlowView.updateViewSize" );
			//trace( stage.deviceOrientation,e );
			width = stage.fullScreenWidth;
			height = stage.fullScreenHeight;
			render();
			//trace( width , height, scene.numChildren );
		}
		
		private function onChangeView( index:int ):void {
			if (index == -1) {
				//camera.x = 0;
				TweenMax.to( camera , .5, {
					x			:0,
					ease		:Cubic.easeInOut					
				} );				
			}else {
				
			}
		}
		
		public function validate():void {
			trace( "CoverFlowView.validate" );			
			this.currentSelectIndex = Math.round( currentSelectIndex);		
		
		}
		
		
		
		private static function getShortestDifferent( pCurrent:Number, pTarget:Number, pTotal:int):int {
			var dif:int = pCurrent - pTarget;				
			dif %= pTotal;
			if (dif != dif % (pTotal / 2)) {				
				dif = (dif < 0) ? dif + pTotal : dif - pTotal;
			}
			return dif;		
		}	
	
		
		private function onPlaneMouse3DDownHandler(e:MouseEvent3D):void {
			if (_isTouchMove) {
				return;
			}
			var planeIndex:int = e.currentTarget.name / 1;
		
			var dif:int = getShortestDifferent(_currentSelectIndex, planeIndex, INDEX_LENGTH);
			var shortestValue:int = currentSelectIndex - dif;			
			
			//trace( _currentSelectIndex, dif );			
			if ( shortestValue == currentSelectIndex) {
				TweenMax.to( camera , .5, {
					x			:500,
					ease		:Cubic.easeInOut,
					onComplete	:function ():void {
						MainModel.instance.currentIndex = planeIndex;
					}
				} );	
			}else {
				currentSelectIndex = shortestValue;
			}
			
		}
		private function shiftToItem( pIndex:Number):void {					
			//trace( "CoverFlowView.shiftToItem > pIndex : " + pIndex );		
			if (_tweenMax != null) {				
				_tweenMax.kill();					
			}			
			_tweenMax = TweenMax.to(this, .8, 
			{ 
				overwrite			:true,
				currentPlaneIndex	:pIndex, 					
				ease				:Cubic.easeOut,
				onUpdate			:redraw 				
			} );			
		}
	
		
		private function redraw():void {			
			//var newObj:Object;	
			var length:int = _planes.length;
			
			
			var _selectedIcon:Number = currentPlaneIndex;	
			while (_selectedIcon < 0) {							
				_selectedIcon += length;
			}
			_selectedIcon = _selectedIcon % length;	
			var a	:String;
			var mc	:Object3D;
			var i	:int;
		
			for (i = 0; i < length; i++) {		
				mc = _planes[i];	
				_refObj = MethodUtil.coverFlowStyleVectical( i , _selectedIcon, length, _refObj);					
				for (a in _refObj) {
					mc[a] = _refObj[a];
				}					
			}				
		}
		
		override public function get isRender():Boolean {
			return super.isRender;
		}
		
		override public function set isRender(value:Boolean):void {
			super.isRender = value;
			if (value) {
				stage.addEventListener(MouseEvent.MOUSE_DOWN , onStageEventHandler);
				stage.addEventListener( Event.RESIZE , onResizeHandler);						
			}else {
				stage.removeEventListener(MouseEvent.MOUSE_DOWN , onStageEventHandler);
				stage.removeEventListener( Event.RESIZE , onResizeHandler);		
			}
			this.stage3DProxy.visible = value;
		}
		
		
		private function onStageEventHandler(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					_tmpIndex = _currentSelectIndex;
					_isTouchMove = false;
					
					_mouseDownPosition = _isVertical ? stage.mouseY :stage.mouseX;					
					stage.addEventListener(MouseEvent.MOUSE_MOVE , onStageEventHandler );
					stage.addEventListener(MouseEvent.MOUSE_UP , onStageEventHandler );
					break;
				case MouseEvent.MOUSE_MOVE:
					var mousePosition	:Number =  _isVertical ? stage.mouseY :stage.mouseX;	
					var distance		:Number = (_mouseDownPosition - mousePosition) / 150;					
					if (_isVertical) {
						distance *= -1;
					}					
					
					
					if ( Math.abs( mousePosition - _mouseDownPosition )> USER_FINGER_RANGE) {
						_isTouchMove = true;
					}
					
					currentSelectIndex = _tmpIndex + distance;
					break;
				case MouseEvent.MOUSE_UP:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE , onStageEventHandler );
					stage.removeEventListener(MouseEvent.MOUSE_UP , onStageEventHandler );
					validate();
					break;
			}
		}
		
		
	}	
}
