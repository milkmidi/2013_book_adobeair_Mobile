package milkmidi.managers {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import milkmidi.utils.SharedColorCache;
	
	
	
	public class DialogManager  {
		private static var root			:DisplayObjectContainer;
		
		private static var _overlay		:DisplayObject;
		static public function get overlay():DisplayObject {	return _overlay;		}		
		static public function set overlay(value:DisplayObject):void {			
			_overlay = value;
			_overlay.addEventListener( MouseEvent.CLICK , onUnderlayClicked , false , 0 , true );
		}
		
		private static var _viewWidth	:int;
		private static var _viewHeight	:int;
		private static var _stage		:Stage;
		
		private static var _dialog		:Sprite;
		public static function get currentDialog():Sprite {	return _dialog;		}
		
		public static var lockModal		:Boolean;
		public static var closeCallback	:Function;
		
		
		public function DialogManager() {
		}
		
		public static function init( pRoot:DisplayObjectContainer ):void {
			root = pRoot;
			if ( root && ( root is Stage || root.stage ) ) {
				_stage = root is Stage ? ( root as Stage ) : ( root.stage );
				_viewWidth = _stage.stageWidth;
				_viewHeight = _stage.stageHeight;
				_stage.addEventListener( Event.RESIZE , onStageResized , false , 0 , true );
				
			}
			
			SharedColorCache.setColor( "black", 0);
			
			var defaultOverlay:Bitmap = new Bitmap( SharedColorCache.getColor("black" ));
			defaultOverlay.alpha = 0.6;			
			overlay = defaultOverlay;
			
			onStageResized( null );
		}
		
		private static function onUnderlayClicked( e:MouseEvent ):void {
			if ( !lockModal ) {
				removeDialogs();
			}
		}
		
		private static function onMouseDown( e:MouseEvent ):void {
			e.stopImmediatePropagation();
		}
		
		private static function onStageResized( e:Event ):void {			
			setSize( _stage.stageWidth , _stage.stageHeight );
		}
		
		
		
		
		public static function removeDialogs():void {
			if ( _dialog && root.contains( _dialog ) ) {
				_dialog.removeEventListener( Event.CLOSE , onDialogCancel );
				root.removeChild( _dialog );
				_dialog = null;
				if ( closeCallback != null ) {
					closeCallback();
					closeCallback = null;
				}
			}
			if ( root.contains( overlay ) ) {
				root.removeChild( overlay );
			}
			root.removeEventListener( MouseEvent.MOUSE_DOWN , onMouseDown );
		}
		
		public static function showDialog( obj:Object , pLickModal:Boolean = false , pAddOverlay:Boolean = true ):Sprite {
			if ( !root ) {
				return null;
			}
			removeDialogs();
			if ( pAddOverlay ) {
				root.addChild( overlay );
			}
			root.addEventListener( MouseEvent.MOUSE_DOWN , onMouseDown , false , 1 , true );
			DialogManager.lockModal = pLickModal;
			if ( obj is Sprite ) {
				_dialog = obj as Sprite;
			} else if ( obj is Class ) {
				_dialog = new obj;
			} else if ( obj is String ) {
				var cls:Class = getDefinitionByName( String(obj) ) as Class;
				_dialog = new cls;
			}
			if ( !_dialog ) {
				return null;
			}
			root.addChild( _dialog );
			if ( _viewWidth <= 0 ) {
				setSize( root.width , root.height );
			} else {
				setSize( _viewWidth , _viewHeight );
			}
			_dialog.addEventListener( Event.CLOSE , onDialogCancel , false , 0 , true );
			return _dialog;
		}
		
		private static function onDialogCancel( event:Event ):void {
			removeDialogs();
		}
		
		public static function setSize( w:int = 0 , h:int = 0 ):void {
			_viewWidth = w;
			_viewHeight = h;
			overlay.width = w;
			overlay.height = h;			
		}
		
	
	}
}
