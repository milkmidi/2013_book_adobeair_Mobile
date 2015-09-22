/**
 * @author milkmidi
 */
package com.milkmidi.singleton {		
	import com.milkmidi.singleton.model.Model;
	import flash.display.Sprite;
	
	public class ModelTest extends Sprite{		
		
		public function ModelTest()  {			
			
			
			var model1:Model = Model.getInstance();
			var model2:Model = Model.getInstance();
			trace("二個變數是否相等：" + (model1 == model2));
			
			
			trace( "myVar:" + Model.getInstance().myVar );	
			Model.getInstance().myVar = "我是奶綠茶";
			trace( "myVar:" + Model.getInstance().myVar );	
		}		
		
	}
}