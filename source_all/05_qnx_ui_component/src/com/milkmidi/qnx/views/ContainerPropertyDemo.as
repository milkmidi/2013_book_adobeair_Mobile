package com.milkmidi.qnx.views {
	import flash.events.MouseEvent;
	import milkmidi.qnx.utils.QNXFactory;
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.text.Label;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class ContainerPropertyDemo extends View{
		private var label:Label;
		
		public function ContainerPropertyDemo() {
			
		}
		override protected function init():void {
			super.init();
			// 物件的邊緣, 預指定四邊
			// 可以使用 new <Number>[15,15,15,15]
			 //或是 Vector.<Number>([15, 15, 15, 15])
			this.margins = new <Number>[15,15,15,15];						
			
			// debug 用的色碼
			this.debugColor = 0xff0000;				
			
			// flow 預設是 ContainerFlow.VERTICAL
			//this.flow = ContainerFlow.HORIZONTAL;
			
			label = QNXFactory.label( this , this.flow + "" );
			//label.width = 100;
			//label.size = 100;
			
			// 垂直排列模式下
			// ContainerAlign.NEAR 子物件置左
			// ContainerAlign.MID 子物件置中
			// ContainerAlign.FAR 子物件置右
			QNXFactory.labelButton( this, "flow", onFlowClick );				
			QNXFactory.labelButton( this, ContainerAlign.NEAR, onButtonClick );				
			QNXFactory.labelButton( this, ContainerAlign.MID, onButtonClick );				
			QNXFactory.labelButton( this, ContainerAlign.FAR, onButtonClick );				
			

			// 子物件二者之間的距離
			// 垂直排列, padding 指的是 y 軸距離
			// 水平排列, padding 指的是 x 軸距離
			this.padding = 5;		
		}
		
		private function onFlowClick(e:MouseEvent):void {
			if (this.flow == ContainerFlow.VERTICAL) {
				this.flow = ContainerFlow.HORIZONTAL;
			}else if ( this.flow == ContainerFlow.HORIZONTAL ) {
				this.flow = ContainerFlow.VERTICAL;
			}
			label.text = this.flow + "," + this.align;	
			this.layout();			
		}
		
		
		private function onButtonClick(e:MouseEvent):void {
			// align 預設是 ContainerAlign.MID
			this.align = e.currentTarget.label;
			label.text = this.flow + "," + this.align;	
			// 重新排版
			this.layout();			
		}
		
	}

}