package milkmidi.qnx.dialogs
{
  
    import flash.display.*;
    import flash.text.*;
	import milkmidi.utils.SharedColorCache;
	import qnx.ui.core.Containment;
	import qnx.ui.core.InvalidationType;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.Spacer;
	import qnx.ui.data.DataProvider;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.text.Label;

    public class ListDialog extends BaseDialog
    {
		private var topDivider:Spacer;
        protected var titleText		:Label;
        protected var _title		:String;
        protected var _dataProvider	:Array;
        protected var optionsMenu	:List;

        public function ListDialog(pWidth:int = 400, pHeight:int = 250, pTitle:String = "", pDatas:Array = null, pSelectIndex:int = -1)
        {			
            this._dataProvider = pDatas || [];
            super(pWidth, pHeight);
            this.title = pTitle;			
        }


		override protected function init():void {			
			
			
			
			
            addChild(titleText = new Label);
			
			//topDivider = new Spacer( 50 , SizeUnit.PIXELS );
			//topDivider.addChild(  new Bitmap(SharedColorCache.getColor('backgroundLight')) );
			//addChild( topDivider );
			
			titleText.textField.defaultTextFormat = new TextFormat( null, null, 0xffffff);
			titleText.x = 0;
			
			
            optionsMenu = new List;
			optionsMenu.sizeUnit = SizeUnit.PERCENT;
			optionsMenu.size =  100;			
			
			var d:DataProvider = new DataProvider();
			for (var i:int = 0; i < _dataProvider.length; ++i){
				d.addItem( { label:_dataProvider[i] } );				
			}			
			optionsMenu.dataProvider = d;	
			optionsMenu.selectionMode = ListSelectionMode.SINGLE;
            //this.optionsMenu.addEventListener(ChangeEvent.CHANGED, this.onMenuChanged, false, 0, true);
            addChild(this.optionsMenu);
			
			
            //this.topDivider = new Bitmap(SharedColorCache.setColor('accentColor',0xff0000));
            //addChild(this.topDivider);
			addButtons( "OK", "CANCEL" );	
            super.init();
        }

        //protected function onMenuChanged(event:ChangeEvent) : void        {
            //dispatchEvent(new ButtonEvent(ButtonEvent.CLICKED, event.newValue as String));
        //}
		override protected function draw():void {
			if (isInvalid( InvalidationType.SIZE)) {
				//topDivider.setSize(width , 1 );
				/*this.titleText.y = this.paddingTop;
				this.titleText.x = this.paddingTop;
				this.titleText.width = width - this.titleText.x * 2;
				this.topDivider.width = width - 2;*/
				//this.topDivider.x = 1;
				//this.topDivider.y = this.titleText.y + this.titleText.height + this.paddingTop;
				//if (this.optionsMenu)            {
					//this.optionsMenu.x = 1;
					//this.optionsMenu.y = this.topDivider.y;
					//this.optionsMenu.setSize(width - 2, height - this.topDivider.y - buttonHeight);
					//trace
				//}
			}
			super.draw();
		}


        public function set title(ptitle:String) : void        {
            this.titleText.text = ptitle;
            this._title = ptitle;
        }

        public function set dataProvider(pData:Array) : void        {
            this._dataProvider = pData;
        }

    }
}
