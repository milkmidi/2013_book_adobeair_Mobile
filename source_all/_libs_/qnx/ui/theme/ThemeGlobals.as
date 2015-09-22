package qnx.ui.theme
{
    import flash.text.*;
    import flash.utils.*;
	import milkmidi.utils.DeviceUtil;
    import qnx.ui.listClasses.*;
    import qnx.ui.skins.buttons.*;
    import qnx.ui.skins.listClasses.*;
    import qnx.ui.skins.picker.*;
    import qnx.ui.skins.progress.*;
    import qnx.ui.skins.slider.*;
    import qnx.ui.skins.text.*;

    public class ThemeGlobals {
        public static const WHITE:String = "white";
        public static const BLACK:String = "dark";
        public static var currentTheme:String = "white";
        public static const TEXT_GUTTER:int = 2;
        public static const TEXT_HEIGHT_OFFSET:int = 4;
        public static const TEXT_WIDTH_OFFSET:int = 4;
        public static const TEXT_PADDING:int = 16;
        public static const BUTTON_SKIN:String = "ButtonSkin";
        public static const CHECKBOX_SKIN:String = "CheckBoxSkin";
        public static const TOGGLE_SWITCH_SKIN:String = "ToggleSwitchSkin";
        public static const SEGMENTED_CONTROL_BACKGROUND:String = "SegmentedControlBackground";
        public static const SEGMENTED_CONTROL_SKIN:String = "SegmentedControlSkin";
        public static const DROPDOWN_BACKGROUND:String = "DropDownBackgroundSkin";
        public static const DROPDOWN_CELL_RENDERER_SKIN:String = "DropDownCellRendererSkin";
        public static const DROPDOWN_BUTTON_SKIN:String = "DropDownButtonSkin";
        public static const DROPDOWN_BACKGROUND_BAR:String = "DropDownBackgroundBar";
        public static const TOGGLE_SWITCH_THUMB:String = "toggleSwitchThumb";
        public static const TOGGLE_SWITCH_FILL:String = "toggleSwitchFill";
        public static const TOGGLE_SWITCH_TRACK:String = "toggleSwitchTrack";
        public static const SLIDER_TRACK:String = "sliderTrack";
        public static const SLIDER_FILL:String = "sliderFill";
        public static const SLIDER_THUMB:String = "sliderThumb";
        public static const VOLUME_TRACK:String = "volumeTrack";
        public static const VOLUME_TRACK_BOOSTED:String = "volumeTrackBoosted";
        public static const VOLUME_THUMB:String = "volumeThumb";
        public static const VOLUME_FILL:String = "volumeFill";
        public static const VOLUME_FILL_BOOSTED:String = "volumeFillBoosted";
        public static const VOLUME_ICON:String = "volumeIcon";
        public static const VOLUME_ICON_MUTED:String = "volumeIconMuted";
        public static const VOLUME_ICON_BOOSTED:String = "volumeIconBoosted";
        public static const PICKER_BACKGROUND:String = "pickerBackground";
        public static const PICKER_BUTTON:String = "pickerButton";
        public static const PICKER_SELECTION:String = "pickerSelection";
        public static const CELL_RENDERER_SKIN:String = "CellRendererSkin";
        public static const LIST:String = "List";
        public static const TILE_LIST:String = "TileList";
        public static const SECTION_HEADER_SKIN:String = "SectionHeaderSkin";
        public static const SECTION_HEADER:String = "SectionHeader";
        public static const PROGRESS_BAR:String = "ProgressBar";
        public static const PERCENT_BAR:String = "PercentBar";
        public static const ACTIVITY_INDICATOR:String = "ActivityIndicator";
        public static const TEXT_INPUT:String = "TextInput";
        public static const LABEL_FORMAT:String = "labelFormat";
        public static const BUTTON_FORMAT_OUT:String = "labelButtonOut";
        public static const BUTTON_FORMAT_DOWN:String = "labelButtonDown";
        public static const BUTTON_FORMAT_SELECTED:String = "labelButtonSelected";
        public static const BUTTON_FORMAT_DISABLED:String = "labelButtonDisabled";
        public static const BUTTON_FORMAT_SELECTED_DISABLED:String = "labelButtonSelectedDisabled";
        public static const TOGGLE_SWITCH_FORMAT_UP:String = "toggleSwitchFormatUp";
        public static const TOGGLE_SWITCH_FORMAT_SELECTED:String = "toggleSwitchFormatSelected";
        public static const TOGGLE_SWITCH_FORMAT_DISABLED:String = "toggleSwitchFormatDisabled";
        public static const TOGGLE_SWITCH_FORMAT_SELECTED_DISABLED:String = "toggleSwitchFormatSelectedDisabled";
        public static const CELL_FORMAT_OUT:String = "CellRendererOut";
        public static const CELL_FORMAT_DOWN:String = "CellRendererDown";
        public static const CELL_FORMAT_SELECTED:String = "CellRendererSelected";
        public static const CELL_FORMAT_DISABLED:String = "CellRendererDisabled";
        public static const CELL_FORMAT_SELECTED_DISABLED:String = "CellRendererSelectedDisabled";
        public static const TEXT_INPUT_FORMAT:String = "TextInputFormat";
        public static const TEXT_INPUT_DISABLED_FORMAT:String = "TextInputFormat";
        public static const TEXT_DIALOG_TITLE_FORMAT:String = "TextDialogTitleFormat";
        public static const TEXT_DIALOG_MESSAGE_FORMAT:String = "TextDialogMessageFormat";
        public static const DROPDOWN_FORMAT_UP:String = "DropDownFormatUp";
        public static const DROPDOWN_FORMAT_DOWN:String = "DropDownFormatDown";
        public static const DROPDOWN_FORMAT_SELECTED:String = "DropDownFormatSelected";
        public static const DROPDOWN_FORMAT_DISABLED:String = "DropDownFormatDisabled";
        public static const CHECKBOX_FORMAT_OUT:String = "CheckBoxFormatUp";
        public static const CHECKBOX_FORMAT_DISABLED:String = "CheckBoxFormatDisabled";
        public static const SEGMENTED_CONTROL_FORMAT_OUT:String = "SegmentedControlFormatOut";
        public static const SEGMENTED_CONTROL_FORMAT_DOWN:String = "SegmentedControlFormatDown";
        public static const SEGMENTED_CONTROL_FORMAT_DISABLED:String = "SegmentedControlFormatDisabled";
        public static const SEGMENTED_CONTROL_FORMAT_SELECTED:String = "SegmentedControlFormatSelected";
        public static const SEGMENTED_CONTROL_FORMAT_SELECTED_DISABLED:String = "SegmentedControlFormatSelectedDisabled";
        public static const PERCENT_BAR_FORMAT:String = "PercentBarFormat";
        public static const BACK_BUTTON_SKIN:String = "BackButtonSkin";
        public static const BACK_BUTTON_FORMAT_OUT:String = "BackButtonFormatOut";
        public static const BACK_BUTTON_FORMAT_DOWN:String = "BackButtonFormatDown";
        public static const BACK_BUTTON_FORMAT_DISABLED:String = "BackButtonFormatDisabled";
        public static const BACK_BUTTON_FORMAT_SELECTED:String = "BackButtonFormatSelected";
        public static const BACK_BUTTON_FORMAT_SELECTED_DISABLED:String = "BackButtonFormatSelectedDisabled";

        public static function getSkin (name:String, theme:String = null) : String {			
            var className:String = null;
            if (theme == null) {				
                theme = currentTheme;
            }
            switch(theme){
                case WHITE: 					
                    className = getWhiteSkin(name);
                    break;                
                case BLACK:
                    className = getBlackSkin(name);
                    break;                
            }
            if (className == null){
                throw new Error("No skin found for " + name + " : " + theme);
            }
            return className;
        }
		private static function getWhiteSkin( name:String) : String {
            var className:String = null;
            switch( name ){
                case BACK_BUTTON_SKIN:     className = getQualifiedClassName(BackButtonSkinWhite);               break;
                case BUTTON_SKIN:          className = getQualifiedClassName(RoundedButtonSkinWhite);            break;                
                case CHECKBOX_SKIN:	       className = getQualifiedClassName(CheckBoxSkinWhite);                 break;
                case SEGMENTED_CONTROL_BACKGROUND:  className = getQualifiedClassName(SegmentedControlBackgroundSkinWhite);  break;
                case SEGMENTED_CONTROL_SKIN:{
                    className = getQualifiedClassName(SegmentedControlSkinWhite);
                    break;
                }
                case CELL_RENDERER_SKIN:{
                    className = getQualifiedClassName(CellRendererSkinWhite);
                    break;
                }
                case DROPDOWN_CELL_RENDERER_SKIN:{
                    className = getQualifiedClassName(DropDownCellRendererSkin);
                    break;
                }
                case LIST:{
                    className = getQualifiedClassName(AlternatingCellRenderer);
                    break;
                }
                case TILE_LIST:{
                    className = getQualifiedClassName(CellRenderer);
                    break;
                }
                case SECTION_HEADER_SKIN:{
                    className = getQualifiedClassName(SectionListHeaderSkinWhite);
                    break;
                }
                case SECTION_HEADER:{
                    className = getQualifiedClassName(SectionHeaderRenderer);
                    break;
                }
                case PROGRESS_BAR:{
                    className = getQualifiedClassName(ProgressBarSkinWhite);
                    break;
                }
                case PERCENT_BAR:{
                    className = getQualifiedClassName(PercentageBarSkinWhite);
                    break;
                }
                case ACTIVITY_INDICATOR:{
                    className = getQualifiedClassName(ActivityIndicatorSkin);
                    break;
                }
                case TEXT_INPUT:{
                    className = getQualifiedClassName(TextInputSkinWhite);
                    break;
                }
                case DROPDOWN_BACKGROUND:{
                    className = getQualifiedClassName(DropDownBackgroundSkinWhite);
                    break;
                }
                case DROPDOWN_BUTTON_SKIN:{
                    className = getQualifiedClassName(DropDownButtonSkinWhite);
                    break;
                }
                case DROPDOWN_BACKGROUND_BAR:{
                    className = getQualifiedClassName(DropDownBackgroundBarSkinWhite);
                    break;
                }
                case PICKER_BACKGROUND:{
                    className = getQualifiedClassName(PickerListBackgroundWhite);
                    break;
                }
                case PICKER_BUTTON:{
                    className = getQualifiedClassName(PickerButtonSkinWhite);
                    break;
                }
                case PICKER_SELECTION:{
                    className = getQualifiedClassName(PickerSelectionWhite);
                    break;
                }
                case TOGGLE_SWITCH_THUMB:{
                    className = getQualifiedClassName(ToggleSwitchThumbSkinWhite);
                    break;
                }
                case TOGGLE_SWITCH_FILL:{
                    className = getQualifiedClassName(ToggleSwitchFillSkinWhite);
                    break;
                }
                case TOGGLE_SWITCH_TRACK:{
                    className = getQualifiedClassName(ToggleSwitchTrackSkinWhite);
                    break;
                }
                case SLIDER_THUMB:{
                    className = getQualifiedClassName(SliderThumbSkinWhite);
                    break;
                }
                case SLIDER_TRACK:{
                    className = getQualifiedClassName(SliderTrackSkinWhite);
                    break;
                }
                case SLIDER_FILL:{
                    className = getQualifiedClassName(SliderFillSkinWhite);
                    break;
                }
                case VOLUME_TRACK:{
                    className = getQualifiedClassName(VolumeTrackSkin);
                    break;
                }
                case VOLUME_TRACK_BOOSTED:{
                    className = getQualifiedClassName(VolumeTrackBoostedSkin);
                    break;
                }
                case VOLUME_THUMB:{
                    className = getQualifiedClassName(VolumeThumbButtonSkin);
                    break;
                }
                case VOLUME_FILL:{
                    className = getQualifiedClassName(VolumeFillSkin);
                    break;
                }
                case VOLUME_FILL_BOOSTED:{
                    className = getQualifiedClassName(VolumeFillBoostedSkin);
                    break;
                }
                case VOLUME_ICON:{
                    className = getQualifiedClassName(VolumeIconSkin);
                    break;
                }
                case VOLUME_ICON_MUTED:{
                    className = getQualifiedClassName(VolumeIconMuteSkin);
                    break;
                }
                case VOLUME_ICON_BOOSTED:{
                    className = getQualifiedClassName(VolumeIconBoostedSkin);
                    break;
                }              
            }
            return className;
        }
        public static function getTextFormat( name:String, theme:String = null) : TextFormat {
            var tf:TextFormat = null;
            if (theme == null){
                theme = currentTheme;
            }
            switch(theme){
                case WHITE:
                    tf = getWhiteTextFormat(name);
                    break;                
                case BLACK:
                    tf = getBlackTextFormat(name);
                    break;                      
            }
            if (tf == null){
                throw new Error("No text format found for " + name + " : " + theme);
            }
            return tf;
        }
        public static function getVolumeSliderFillColors( theme:String = null) : Array {
            var _loc_2:Array = null;
            if (theme == null){
                theme = currentTheme;
            }
            switch(theme){
                case WHITE:{
                    _loc_2 = [337755, 94916];
                    break;
                }
                case BLACK:{
                    _loc_2 = [2960685, 6250335];
                    break;
                }              
            }
            return _loc_2;
        }
        public static function getVolumeSliderDisabledColors( theme:String = null) : Array {
            var _loc_2:Array = null;
            if (theme == null){
                theme = currentTheme;
            }
            switch(theme){
                case WHITE:{
                    _loc_2 = [2960685, 6250335];
                    break;
                }
                case BLACK:{
                    _loc_2 = [2960685, 6250335];
                    break;
                }
                default:{
                    break;
                }
            }
            return _loc_2;
        }
        private static function getWhiteTextFormat( theme:String) : TextFormat {
            var tf:TextFormat = new TextFormat();
            tf.size = 21 * DeviceUtil.dpiScale; // 改這
            tf.font = "Myriad Pro";
            switch(theme){
                case LABEL_FORMAT:     	tf.color = 0; break;                
                case BUTTON_FORMAT_OUT: 
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    break;                
                case BUTTON_FORMAT_DOWN:
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;                
                case BUTTON_FORMAT_SELECTED:
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;                
                case BUTTON_FORMAT_DISABLED:
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 10921638;
                    break;                
                case BUTTON_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 10921638;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_UP:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 10921638;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_OUT:{
                    tf.color = 0;
                    break;
                }
                case CELL_FORMAT_DOWN:{
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_SELECTED:{
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_DISABLED:{
                    tf.color = 10921638;
                    break;
                }
                case CELL_FORMAT_SELECTED_DISABLED:{
                    tf.color = 10921638;
                    break;
                }
                case TEXT_INPUT_FORMAT:
                    tf.color = 0;
                    break;                
                case TEXT_INPUT_DISABLED_FORMAT:
                    tf.color = 10921638;
                    break;                
                case DROPDOWN_FORMAT_UP:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 0;
                    break;
                }
                case DROPDOWN_FORMAT_DOWN:
                case DROPDOWN_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case DROPDOWN_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 10921638;
                    break;
                }
                case CHECKBOX_FORMAT_OUT:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 0;
                    break;
                }
                case CHECKBOX_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 10921638;
                    break;
                }
                case BACK_BUTTON_FORMAT_OUT:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 0;
                    break;
                }
                case BACK_BUTTON_FORMAT_DOWN:
                case BACK_BUTTON_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case BACK_BUTTON_FORMAT_DISABLED:
                case BACK_BUTTON_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 10921638;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_OUT:{
                    tf.color = 0;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_DOWN:
                case SEGMENTED_CONTROL_FORMAT_SELECTED:{
                    tf.color = 16777215;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_DISABLED:{
                    tf.color = 10921638;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_SELECTED_DISABLED:{
                    tf.color = 7566195;
                    break;
                }
                case PERCENT_BAR_FORMAT:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    tf.size = 13;
                    break;
                }               
            }
            return tf;
        }
        private static function getBlackTextFormat(param1:String) : TextFormat {
            var tf:TextFormat = new TextFormat();
            tf.size = 21 * DeviceUtil.dpiScale;
            tf.font = "Myriad Pro";
            switch(param1){
                case LABEL_FORMAT:{
                    tf.color = 16777215;
                    break;
                }
                case BUTTON_FORMAT_OUT:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case BUTTON_FORMAT_DOWN:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case BUTTON_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case BUTTON_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    break;
                }
                case BUTTON_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_UP:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 0;
                    break;
                }
                case TOGGLE_SWITCH_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_OUT:{
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_DOWN:{
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_SELECTED:{
                    tf.color = 16777215;
                    break;
                }
                case CELL_FORMAT_DISABLED:{
                    tf.color = 8421504;
                    break;
                }
                case CELL_FORMAT_SELECTED_DISABLED:{
                    tf.color = 8421504;
                    break;
                }
                case TEXT_INPUT_FORMAT:{
                    tf.color = 0;
                    break;
                }
                case TEXT_INPUT_DISABLED_FORMAT:{
                    tf.color = 10066329;
                    break;
                }
                case DROPDOWN_FORMAT_UP:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case DROPDOWN_FORMAT_DOWN:
                case DROPDOWN_FORMAT_SELECTED:{
                    tf.color = 16777215;
                    break;
                }
                case DROPDOWN_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 0;
                    break;
                }
                case CHECKBOX_FORMAT_OUT:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case CHECKBOX_FORMAT_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 0;
                    break;
                }
                case BACK_BUTTON_FORMAT_OUT:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case BACK_BUTTON_FORMAT_DOWN:
                case BACK_BUTTON_FORMAT_SELECTED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 16777215;
                    break;
                }
                case BACK_BUTTON_FORMAT_DISABLED:
                case BACK_BUTTON_FORMAT_SELECTED_DISABLED:{
                    tf.align = TextFormatAlign.LEFT;
                    tf.color = 4803404;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_OUT:{
                    tf.color = 16777215;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_DOWN:
                case SEGMENTED_CONTROL_FORMAT_SELECTED:{
                    tf.color = 16777215;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_DISABLED:{
                    tf.color = 4803404;
                    break;
                }
                case SEGMENTED_CONTROL_FORMAT_SELECTED_DISABLED:{
                    tf.color = 0;
                    break;
                }
                case PERCENT_BAR_FORMAT:
                    tf.align = TextFormatAlign.CENTER;
                    tf.color = 16777215;
                    tf.size = 13;
                    break;              
            }
            return tf;
        }
       
        private static function getBlackSkin( name:String) : String {
            var className:String = null;
            switch(name){
                case BACK_BUTTON_SKIN:{
                    className = getQualifiedClassName(BackButtonSkinBlack);
                    break;
                }
                case BUTTON_SKIN:{
                    className = getQualifiedClassName(RoundedButtonSkinBlack);
                    break;
                }
                case CHECKBOX_SKIN:{
                    className = getQualifiedClassName(CheckBoxSkinBlack);
                    break;
                }
                case SEGMENTED_CONTROL_BACKGROUND:{
                    className = getQualifiedClassName(SegmentedControlBackgroundSkinBlack);
                    break;
                }
                case SEGMENTED_CONTROL_SKIN:{
                    className = getQualifiedClassName(SegmentedControlSkinBlack);
                    break;
                }
                case CELL_RENDERER_SKIN:{
                    className = getQualifiedClassName(CellRendererSkinBlack);
                    break;
                }
                case DROPDOWN_CELL_RENDERER_SKIN:{
                    className = getQualifiedClassName(DropDownCellRendererSkin);
                    break;
                }
                case LIST:{
                    className = getQualifiedClassName(AlternatingCellRenderer);
                    break;
                }
                case TILE_LIST:{
                    className = getQualifiedClassName(CellRenderer);
                    break;
                }
                case SECTION_HEADER_SKIN:{
                    className = getQualifiedClassName(SectionListHeaderSkinBlack);
                    break;
                }
                case SECTION_HEADER:{
                    className = getQualifiedClassName(SectionHeaderRenderer);
                    break;
                }
                case PROGRESS_BAR:{
                    className = getQualifiedClassName(ProgressBarSkinBlack);
                    break;
                }
                case PERCENT_BAR:{
                    className = getQualifiedClassName(PercentageBarSkinBlack);
                    break;
                }
                case ACTIVITY_INDICATOR:{
                    className = getQualifiedClassName(ActivityIndicatorSkin);
                    break;
                }
                case TEXT_INPUT:{
                    className = getQualifiedClassName(TextInputSkinBlack);
                    break;
                }
                case DROPDOWN_BUTTON_SKIN:{
                    className = getQualifiedClassName(DropDownButtonSkinBlack);
                    break;
                }
                case DROPDOWN_BACKGROUND:{
                    className = getQualifiedClassName(DropDownBackgroundSkinBlack);
                    break;
                }
                case DROPDOWN_BACKGROUND_BAR:{
                    className = getQualifiedClassName(DropDownBackgroundBarSkinBlack);
                    break;
                }
                case PICKER_BACKGROUND:{
                    className = getQualifiedClassName(PickerListBackgroundBlack);
                    break;
                }
                case PICKER_BUTTON:{
                    className = getQualifiedClassName(PickerButtonSkinBlack);
                    break;
                }
                case PICKER_SELECTION:{
                    className = getQualifiedClassName(PickerSelectionBlack);
                    break;
                }
                case TOGGLE_SWITCH_THUMB:{
                    className = getQualifiedClassName(ToggleSwitchThumbSkinBlack);
                    break;
                }
                case TOGGLE_SWITCH_FILL:{
                    className = getQualifiedClassName(ToggleSwitchFillSkinBlack);
                    break;
                }
                case TOGGLE_SWITCH_TRACK:{
                    className = getQualifiedClassName(ToggleSwitchTrackSkinBlack);
                    break;
                }
                case SLIDER_THUMB:{
                    className = getQualifiedClassName(SliderThumbSkinBlack);
                    break;
                }
                case SLIDER_TRACK:{
                    className = getQualifiedClassName(SliderTrackSkinBlack);
                    break;
                }
                case SLIDER_FILL:{
                    className = getQualifiedClassName(SliderFillSkinBlack);
                    break;
                }
                case VOLUME_TRACK:{
                    className = getQualifiedClassName(VolumeTrackSkin);
                    break;
                }
                case VOLUME_TRACK_BOOSTED:{
                    className = getQualifiedClassName(VolumeTrackBoostedSkin);
                    break;
                }
                case VOLUME_THUMB:{
                    className = getQualifiedClassName(VolumeThumbButtonSkin);
                    break;
                }
                case VOLUME_FILL:{
                    className = getQualifiedClassName(VolumeFillSkin);
                    break;
                }
                case VOLUME_FILL_BOOSTED:{
                    className = getQualifiedClassName(VolumeFillBoostedSkin);
                    break;
                }
                case VOLUME_ICON:{
                    className = getQualifiedClassName(VolumeIconSkin);
                    break;
                }
                case VOLUME_ICON_MUTED:{
                    className = getQualifiedClassName(VolumeIconMuteSkin);
                    break;
                }
                case VOLUME_ICON_BOOSTED:{
                    className = getQualifiedClassName(VolumeIconBoostedSkin);
                    break;
                }              
            }
            return className;
        }
    }
}
