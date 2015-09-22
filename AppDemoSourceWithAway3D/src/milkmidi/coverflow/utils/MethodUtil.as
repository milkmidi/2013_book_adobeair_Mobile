package milkmidi.coverflow.utils {			
	import flash.filters.ColorMatrixFilter;
	public class MethodUtil {		
	
		private static const WIDTH	:int = 960;
		private static const HEIGHT	:int = 960;
		private static const EXTRA_SCALE	:Number = 1;
		private static const FOCAL_LENGTH	:Number = 250;
		
		private static var radius	:int = 450;
		private static const SPACE	:int = 120;
		
		public static const RADIAN_2_DEGREE:Number = 57.29577951308232;		
		public static const DEGREE_2_RADIAN:Number = 0.017453292519943295;	
		
	
		private static function getBaseObject():Object{
			return { 
				x:0,
				y:0,
				z:0,
				rotationX:0,
				rotationY:0,
				rotationZ:0,
				scaleX:1,
				scaleY:1,
				alpha	:1,
				visible:true
			};
		}

		

		
	/*	public static function coverFlowStyle2(i:Number, selected:Number, tot:Number):Object {									
			var obj			:Object = getBaseObject();				
			var distance	:Number = getDistance(i , selected, tot);
			var absDistance	:Number = Math.abs( distance );
			var f			:Number = getFraction( i , selected, tot);
			var angleUtil	:Number = Math.PI * 2 / tot;				
			
			var f2			:Number = distance * angleUtil + ( 180 * DEGREE_2_RADIAN);
			
			//var fPI			:Number = f * Math.PI;
			var x:Number = Math.sin( f2 ) * radius;						
			var y:Number = 0;			
			var z:Number = Math.cos( f2 ) * radius;
			obj.rotationY = f2 * RADIAN_2_DEGREE + 90;			
			obj.x = x;
			obj.y = y;
			obj.z = z;
			obj.alpha = 1 - Math.abs(f);			
			if ( absDistance > 3) {
				//obj.visible = false;				
			}else {
				//obj.visible = true;
			}
			if ( absDistance < 1) {
				obj.rotationY += ((1 - Math.abs(distance)) * 90);								
				obj.z += (1 - absDistance) * -200;								
			}
		
			
			return obj;
		
		
		
		}*/
		public static function coverFlowStyleVectical(i:Number, selected:Number, tot:Number , obj:Object):Object {			
			//var obj			:Object = getBaseObject();
			var distance	:Number = getDistance(i , selected, tot);
			var absDistance	:Number = Math.abs( distance );
			var f			:Number = getFraction( i , selected, tot);
			var angleUtil	:Number = Math.PI * 2 / tot;				
			
			
			
			var f2			:Number = distance * angleUtil + ( -90 * DEGREE_2_RADIAN);
			//var f2			:Number = f+ ( -90 * DEGREE_2_RADIAN);
			
			var y:Number = Math.cos( f2 ) * radius;						
			var x:Number = 0;			
			var z:Number = Math.sin( f2 ) * radius;
			
			
			
			obj.rotationX = f2 * RADIAN_2_DEGREE;
			obj.x = x;
			obj.y = y;
			obj.z = z;
			obj.alpha =1
				
			
			
			
			if ( absDistance >= 3) {
				//obj.alpha -= 1 - absDistance;
				obj.visible = false;				
			}else {
				obj.visible = true;
			}
			if ( absDistance < 1) {
				obj.rotationX += ((1 - absDistance) * 90);								
				obj.z += (1 - absDistance) * -20;								
			}
		
			
			return obj;
		}
		
		private static function getFraction(i:Number, selected:Number, tot:Number):Number {
			// Based on the current position, returns the F (-1 to 1) of the current item (i) which is its distance to the selected item
			var f:Number;
			f = i - selected;
			f /= tot / 2;
			while (f < -1) f += 2;			
			while (f > 1)  f -= 2;			
			return f;
		}
		private static function getDistance(i:Number, selected:Number, tot:Number):Number {
			// Normalized distance from the current item (i) to the selected item
			var _distance:Number = i - selected;
			if (_distance > tot / 2) 	_distance -= tot;			
			if (_distance < -tot / 2) 	_distance += tot;			
			return _distance;
		}	
	}	
}