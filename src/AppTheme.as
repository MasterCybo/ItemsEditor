package
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.themes.AeonDesktopTheme;
	
	import starling.text.TextFormat;
	
	public class AppTheme extends AeonDesktopTheme
	{
		private static var _labelFormat:TextFormat;
		private static var _buttonFormat:TextFormat;
		private static var _inputFormat:TextFormat;
		private static var _headerFormat:TextFormat;
		private static var _areaFormat:TextFormat;
		
		public function AppTheme()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override protected function setButtonStyles(button:Button):void
		{
			super.setButtonStyles(button);
			
			if (!_buttonFormat) {
				_buttonFormat = button.fontStyles.clone();
				_buttonFormat.font = "Calibri";
				_buttonFormat.size = 14;
			}
			
			button.fontStyles = button.disabledFontStyles = _buttonFormat;
			button.paddingLeft = button.paddingRight = 15;
			button.paddingTop = button.paddingBottom = 8;
		}
		
		override protected function setLabelStyles(label:Label):void
		{
			super.setLabelStyles(label);
			
			if (!_labelFormat) {
				_labelFormat = label.fontStyles.clone();
				_labelFormat.font = "Calibri";
				_labelFormat.size = 14;
			}
			label.fontStyles = _labelFormat;
		}
		
		override protected function setTextAreaStyles(textArea:TextArea):void
		{
			super.setTextAreaStyles(textArea);
			
			if (!_areaFormat) {
				_areaFormat = textArea.fontStyles.clone();
				_areaFormat.font = "Tahoma";
				_areaFormat.size = 13;
			}
			
			textArea.fontStyles = _inputFormat;
		}
		
		override protected function setTextInputStyles(input:TextInput):void
		{
			super.setTextInputStyles(input);
			
			if (!_inputFormat) {
				_inputFormat = input.fontStyles.clone();
				_inputFormat.font = "Tahoma";
				_inputFormat.size = 13;
			}
			
			input.fontStyles = _inputFormat;
			input.paddingTop = input.paddingBottom = 13;
		}
		
		override protected function setPanelHeaderStyles(header:Header):void
		{
			super.setPanelHeaderStyles(header);
			
			if (!_headerFormat) {
				_headerFormat = header.fontStyles.clone();
				_headerFormat.font = "Tahoma";
				_headerFormat.size = 14;
				_headerFormat.bold = true;
			}
			
			header.fontStyles = _headerFormat;
		}
	}
}
