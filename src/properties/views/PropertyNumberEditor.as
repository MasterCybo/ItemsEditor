package properties.views
{
	import base.views.AppTextInput;
	import base.views.ITextEditor;
	
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	
	public class PropertyNumberEditor extends PropertyEditorAbstract
	{
		public function PropertyNumberEditor(name:String, value:Number = 0)
		{
			super(name, value);
		}
		
		override protected function titleFactory():Label
		{
			return new Label();
		}
		
		override protected function textInputFactory():ITextEditor
		{
			var input:AppTextInput = new AppTextInput();
			input.restrict = "0123456789.,";
			return input;
		}
	}
}
