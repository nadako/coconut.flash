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

	@:state var hovered:Bool = false;

	var textField:TextField;
	var bitmap:Bitmap;

	function render() '
		<Sprite mouseChildren=${false} buttonMode=${true} onClick=${onClick()} onRollOver=${hovered = true} onRollOut=${hovered = false}>
			<Bitmap ref=${v -> bitmap = v} bitmapData=${new BitmapData(1, 1, false, if (hovered) 0xFF0000 else 0xAAAAAA)}/>
			<TextField ref=${v -> textField = v} text=${label} autoSize=${LEFT} x=${5} y=${5} />
		</Sprite>
	';

	override function viewDidRender() {
		bitmap.width = textField.width + 10;
		bitmap.height = textField.height + 10;
	}
}

function main() {
	Renderer.mount(flash.Lib.current,
		<Button label="Press me" onClick=${trace("YO")}/>
	);
}
