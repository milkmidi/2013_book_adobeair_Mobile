package milkmidi.utils
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	/**
	 * 共用 BitmapData
	 */
    public class SharedColorCache {
		
		private static var _colors:Dictionary = new Dictionary();		
		
		/**
		 * 
		 * @param	pKey 色碼名稱
		 * @param	pColor 色碼
		 * @return BitmapData
		 */
		public static function setColor( pKey:String , pColor:uint ):BitmapData {
			if ( !_colors[pKey] ) {
				_colors[pKey] = new BitmapData( 1, 1, false, pColor);
			}
			return _colors[pKey]
		}
		public static function getColor( pKey:String  ):BitmapData {
			return _colors[pKey];
		}
       

    }
}
