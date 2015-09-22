package com.milkmidi.qnx {		
	import com.milkmidi.qnx.views.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import milkmidi.book2013.cast.IChild;
	import milkmidi.qnx.display.QnxMain;
	import milkmidi.qnx.view.IView;
	import milkmidi.qnx.view.ViewContainer;
	import milkmidi.qnx.viewnavigator.ViewNavigator;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntry extends QnxMain implements IChild {		
		
	
		
		private var _navigator		:ViewNavigator;
		private var _container		:ViewContainer;
		public function MainEntry()  {			
			super(false);			
		}	
		
		/* INTERFACE milkmidi.book2013.cast.IChild */		
		public function onBackKeyDown():Boolean {
			if (_navigator.length > 1) {				
				_navigator.popView();
				return true;
			}
			return false;
		}
		
	
		protected override function createChildren():void {
			trace( "MainEntry.createChildren" );
			
			_container = new ViewContainer;
			container.addChild( _container );
			
			_navigator = new ViewNavigator( _container );			
			_navigator.pushView( new ListAllView);
			
		
		}
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDownHandler, false, int.MAX_VALUE);			
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void {			
			if (e.keyCode == Keyboard.BACK) {
				if (_navigator.length > 1) {				
					e.preventDefault();
					e.stopPropagation();
					_navigator.popView();
				}
			}
			
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			_navigator.onChange.removeAll();
			stage.removeEventListener( KeyboardEvent.KEY_DOWN , onKeyDownHandler);
		}
		
		
		
	
	}
}