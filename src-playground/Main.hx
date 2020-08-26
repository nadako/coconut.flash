import coconut.flash.Children;
import coconut.flash.Renderer;
import coconut.flash.View;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;

class Button extends View {
	@:attribute var label:String;
	@:attribute function onClick():Void;

	var textField:TextField;
	var bitmap:Bitmap;

	function render() '
		<Sprite mouseChildren=${false} buttonMode=${true} onClick=${onClick()}>
			<Bitmap ref=${v -> bitmap = v} bitmapData=${new BitmapData(1, 1, false, 0xFF0000)}/>
			<TextField ref=${v -> textField = v} text=${label} autoSize=${LEFT} />
		</Sprite>
	';

	override function viewDidRender() {
		bitmap.width = textField.width;
		bitmap.height = textField.height;
	}
}


function main() {
	Renderer.mount(flash.Lib.current,
		<Button label="Press me" onClick=${trace("YO")}/>
	);
}
