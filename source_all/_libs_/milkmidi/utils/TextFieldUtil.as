/**
 * @author milkmidi
 */
package milkmidi.utils {		
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFieldUtil {		
		
		public static function create( pParent:Sprite, pText:String, pX:int = 0 , pY:int = 0, pSize:int = 24 , pAutSizeLeft:Boolean = true ):TextField {									
			var tfm:TextFormat = new TextFormat();
			tfm.size = pSize;
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = tfm;
			tf.text = pText;
			tf.mouseEnabled = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = pX;
			tf.y = pY;
			pParent.addChild( tf );
			return tf;
		}	
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package