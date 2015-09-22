/**
 * @author milkmidi
 */
package com.milkmidi.qnx.views {		
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import milkmidi.qnx.view.View;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.Spacer;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;
	
	public class ContainerLayout extends View {				 
        private var labelFormat:TextFormat = new TextFormat(null, 26);
		public function ContainerLayout()  {						
			super();
		}		
		override protected function init():void {
			super.init();
			var main:Container = new Container();			
            main.margins = Vector.<Number>([20, 20, 20, 20]);			
            main.flow = ContainerFlow.HORIZONTAL;			
            main.debugColor = 0xFFCC00;			
            addChild(main);			
			
			main.addChild(createSubLeft());	      
            main.addChild(createSubRight()); 
            main.addChild(createBottom());   
		}
		
		private function createSubLeft():Container {
			var subLeft:Container = new Container();			
            subLeft.margins = Vector.<Number>([20, 40, 20, 40]);    			
            subLeft.flow = ContainerFlow.VERTICAL;
            subLeft.debugColor = 0xFF3300;
            subLeft.padding = 10;
            subLeft.size = 50;
            subLeft.sizeUnit = SizeUnit.PERCENT;            
            subLeft.align = ContainerAlign.NEAR;          
            
            var firstLabel:Label = new Label();
            firstLabel.format = labelFormat;
            firstLabel.text = "First label";
            firstLabel.size = 35;			
            firstLabel.sizeUnit = SizeUnit.PERCENT;
            firstLabel.autoSize = TextFieldAutoSize.LEFT;           
            subLeft.addChild(firstLabel);
            
            var secondLabel:Label = new Label();
            secondLabel.format = labelFormat;
            secondLabel.text = "Second label";
            secondLabel.size = 35;			
            secondLabel.sizeUnit = SizeUnit.PERCENT;
            secondLabel.autoSize = TextFieldAutoSize.LEFT;            
            subLeft.addChild(secondLabel);
            
            var thirdLabel:Label = new Label();
            thirdLabel.format = labelFormat;
            thirdLabel.text = "Third label";
            thirdLabel.size = 35;			
            thirdLabel.sizeUnit = SizeUnit.PERCENT;
            thirdLabel.autoSize = TextFieldAutoSize.LEFT;            
            subLeft.addChild(thirdLabel);
			
			return subLeft;
		}
		private function createSubRight():Container {
			var subRight:Container = new Container();			
            subRight.margins = Vector.<Number>([10, 10, 10, 10]); 			
            subRight.debugColor = 0x0033FF;
            subRight.size = 50;            
            subRight.sizeUnit = SizeUnit.PERCENT;
            subRight.flow = ContainerFlow.VERTICAL;
            subRight.padding = 10;			
			    
            var firstInput:TextInput = new TextInput;
            firstInput.width = 200;            
            
            var fourthLabel:Label = new Label();
            fourthLabel.format = labelFormat;            
            fourthLabel.text = "Fourth label:";
            fourthLabel.width = 200;
            fourthLabel.size = 30;			
            fourthLabel.sizeUnit = SizeUnit.PIXELS;
            
			// 加入一個 Spacer 空白元件 size 為 100%
			// 這樣可以把其他的物件推到最下方
            subRight.addChild(new Spacer(100));
            subRight.addChild(fourthLabel);
            subRight.addChild(firstInput);
			return subRight;
		}
		private function createBottom():Container {
            var subBottom:Container = new Container();
            subBottom.margins = Vector.<Number>([15, 15, 15, 15]);   			
            subBottom.debugColor = 0x33FF33;
            subBottom.size = 12;
            subBottom.sizeUnit = SizeUnit.PERCENT;
            subBottom.flow = ContainerFlow.HORIZONTAL;
            subBottom.align = ContainerAlign.FAR;
			// 置下方
            subBottom.containment = Containment.DOCK_BOTTOM; 
			
            var leftButton:LabelButton = new LabelButton();
            leftButton.label = "Left";
            leftButton.size = 100;
            leftButton.sizeUnit = SizeUnit.PIXELS;
            leftButton.sizeMode = SizeMode.BOTH;            
            
            var rightButton:LabelButton = new LabelButton();
            rightButton.label = "Right";
            rightButton.size = 100;
            

            subBottom.addChild(new Spacer()); 
            subBottom.addChild(leftButton);
            subBottom.addChild(new Spacer(10, SizeUnit.PIXELS));			
            subBottom.addChild(rightButton);
			
			return subBottom;
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package