/**
 * @author milkmidi
 */
package com.milkmidi {		
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	CONFIG::air{
		import flash.filesystem.File; // AIR 限定類別
	}
	
	public class ConditionalCompilationDemo extends Sprite {	
		
		// 顯示用的文字
		private var _tf:TextField;
		public function ConditionalCompilationDemo()  {						
			
			// 建立文字
			addChild( _tf = new TextField);
			_tf.width = 400;
			// 更改文字大小為 20
			_tf.defaultTextFormat = new TextFormat(null, 20);						
			
			
			// 依定義的表籤顯示不同的結果
			CONFIG::debug {
				_tf.text = "Debug Mode";
			}			
			CONFIG::release {
				_tf.text = "Release Mode";
			}
			
		
		}		
		
		CONFIG::debug // 如果表籤是 debug 時
		private function onStaegClickHandler(e:MouseEvent):void {
			_tf.appendText( "\nDebug Click");
		}
		
		CONFIG::release // 如果表籤是 release 時
		private function onStaegClickHandler(e:MouseEvent):void {
			_tf.appendText( "\nRelease Click");
		}
		
	}
}