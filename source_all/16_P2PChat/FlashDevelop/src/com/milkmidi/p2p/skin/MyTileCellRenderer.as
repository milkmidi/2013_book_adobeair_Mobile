package com.milkmidi.p2p.skin {
	import flash.text.TextFormat;
	import qnx.ui.display.ISizeable;
	import qnx.ui.geom.EdgeMetrics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import qnx.ui.listClasses.CellRenderer;
	import qnx.ui.listClasses.ICellRenderer;
	import qnx.ui.skins.ISkin;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class MyTileCellRenderer extends CellRenderer {		
		
	
		private static var tfm:TextFormat = new TextFormat("_self", 19);
		public function MyTileCellRenderer() {
			super();
			//this.setSkin( ToolTileButtonSkin );
		}
		override public function getTextFormatForState(state:String):TextFormat {
			//return super.getTextFormatForState(state);
			return tfm;
		}
		
		
			
	}
	

}