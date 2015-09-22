package milkmidi.qnx.viewnavigator {
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import milkmidi.qnx.view.IView;
	import milkmidi.qnx.view.ViewContainer;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import qnx.ui.core.UIComponent;
	/**
	 * ...
	 * @author milkmidi
	 */
		
	public class ViewNavigator implements IViewNavigator {
        protected var container					:ViewContainer;
        protected var views						:Vector.<IView>;
        protected var _poppedViewReturnedObject	:Object;
		
		public var ease				:Object = Cubic.easeInOut;
        public var transitionTime	:Number = 0.5;

		public var autoResize:Boolean = false;
		
		private var _onChange:ISignal;
		public function get onChange():ISignal {
			return this._onChange;
		}
		
        public function ViewNavigator( pContainer:ViewContainer ) {
            this.views = new Vector.<IView>;
            this.container = pContainer;
			_onChange = new Signal(int);
			if (container.stage) {
				parent_addedToStageHandler( null );
			}else {
				container.addEventListener(Event.ADDED_TO_STAGE, this.parent_addedToStageHandler);				
			}
        }
        protected function parent_addedToStageHandler(event:Event) : void {
            this.container.removeEventListener(Event.ADDED_TO_STAGE, this.parent_addedToStageHandler);
            this.container.stage.addEventListener(Event.RESIZE, this.stage_resizeHandler);
        }
        protected function stage_resizeHandler(event:Event) : void {
            var child:IView = null;
            for each (child in this.views) {                
				child.setSize( width , height );                
            }
        }
		
		private function get width():int {
			if (container is Stage) {
				return Stage( container ).stageWidth;
			}
			return container.width;
		}
		private function get height():int {
				if (container is Stage) {
				return Stage( container ).stageHeight;
			}
			return container.height;
		}
		
		
        public function pushView( view:IView ) : void {
            view.navigator = this;
			var viewChild:DisplayObject = view.toDisplayObject();
			
			
            this.container.addChild(  viewChild );			
			view.setSize( width , height );
			
			viewChild.x = width;
			viewChild.y = 0;	
			
            
            var currentView:IView;
            if (this.views.length > 0) {				
                currentView = this.views[(this.views.length - 1)];				
				tween( currentView , {	x: -width, autoAlpha:0	} );								
            }			
			
            tween(view, {
				x:0,
				autoAlpha:1,
				onComplete:function () : void {
					if (currentView){
						container.removeChild( currentView.toDisplayObject() );
					}
                } 
			});			
            this.views.push(view);
			_onChange.dispatch( length );
        }
		private function tween( target:Object ,  prop:Object):void {
			if (!prop.ease) {
				prop.ease = this.ease;
			}
			TweenMax.to( target , transitionTime, prop );
		}
        public function popView() : void {
            var currentView:IView;
            var belowView:IView;
            var stageWidth:int = width;	
            if (this.views.length > 0){
                currentView = this.views[(this.views.length - 1)];				
                if (this.views.length > 1){
                    belowView = this.views[this.views.length - 2];
                }
                tween(currentView, {
					x:stageWidth, 
					onComplete:function () : void {				
						views.pop();
						container.removeChild(currentView.toDisplayObject());								
						_onChange.dispatch( length );
						_poppedViewReturnedObject = currentView.viewReturnObject;						
					}
				});
				if (belowView){
					this.container.addChild(belowView.toDisplayObject());
					tween(belowView, { x:0 , autoAlpha:1 } );					             
				}
			}
        }
        public function popToFirstView() : void {
            if (this.views.length > 1){
                if (this.views.length > 2){
                    this.views.splice(1, this.views.length - 2);
                }
                this.popView();
            }
        }
        public function popAll() : void {
            this.views.splice(0, (this.views.length - 1));
            this.popView();
        }
     /*   public function replaceView( view:UIComponent) : void {
            this.pushView(view);
            if (this.views.length > 1){
                this.views.splice(this.views.length - 2, 1);
            }            
        }*/
        public function get poppedViewReturnedObject() : Object {
            return this._poppedViewReturnedObject;
        }
        public function get length() : int {
            return this.views.length;
        }   
		
	}

}