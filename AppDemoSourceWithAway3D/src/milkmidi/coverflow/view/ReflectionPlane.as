/**
 * @author milkmidi
 */
package milkmidi.coverflow.view {		
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.utils.Cast;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ReflectionPlane extends Mesh {		
		private var mat:TextureMaterial;
		
	
		
		//__________________________________________________________________________________ Constructor
		public function ReflectionPlane(  pBitmapData:BitmapData )  {			
			
			//var originBmd		:BitmapData =  pTexture.bitmapData;
			
			var bmpTexture:BitmapTexture = Cast.bitmapTexture( pBitmapData );
			
			//var bmd:BitmapData = new BitmapData( 256, 256, false);
			//bmd.copyPixels( originBmd , new Rectangle(0, 0, 256, 256), new Point);			
			mat = new TextureMaterial( bmpTexture) ;			
			//mat = new TextureMaterial( new BitmapTexture( originBmd)) ;			
			mat.diffuseMethod.alphaThreshold = 1;
		
			//Cast.
			
			var geo	:PlaneGeometry = new PlaneGeometry(270, 270, 1, 1, false);			
			geo.doubleSided = true;
			
			super( geo, mat );									
			//plane.addEventListener(MouseEvent3D.CLICK , dispatchEvent);
			//addChild( plane );		
			
			
			
		}		
		
		
		public function get alpha():Number {	return 	mat.alpha;			}		
		public function set alpha(value:Number):void {
			mat.alpha = value;
		}

	
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package