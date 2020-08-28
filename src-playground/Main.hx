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

	@:ref var textField:TextField;
	@:ref var bitmap:Bitmap;

	function render() '
		<Sprite mouseChildren=${false} buttonMode=${true} onClick=${onClick()} onRollOver=${hovered = true} onRollOut=${hovered = false}>
			<Bitmap ref=${bitmap} bitmapData=${new BitmapData(1, 1, false, if (hovered) 0xFF0000 else 0xAAAAAA)}/>
			<TextField ref=${textField} text=${label} autoSize=${LEFT} x=${5} y=${5} />
		</Sprite>
	';

	override function viewDidRender() {
		bitmap.width = textField.width + 10;
		bitmap.height = textField.height + 10;
	}
}

function main() {
	Renderer.mount(flash.Lib.current,
		<HBox spacing=${10}>
			<VBox spacing=${5}>
				<Button label="Press me" onClick=${trace("YO")}/>
				<Button label="Touch me" onClick=${trace("Ah")}/>
			</VBox>
			<Button label="Press me" onClick=${trace("YO")}/>
		</HBox>
	);
}
