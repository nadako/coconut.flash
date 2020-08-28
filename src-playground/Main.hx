import coconut.flash.Renderer;
import coconut.flash.View;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.TextField;
import tink.core.Future;

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

class Image extends View {
	@:attribute var src:String;

	@:skipCheck
	@:state var pixels:BitmapData = null;

	function render() '
		<Bitmap bitmapData=$pixels />
	';

	function viewDidMount() {
		untilUnmounted(loadImage(src).handle(bmp -> pixels = bmp));
	}
}

class MyWindow extends View {
	@:state var showImage:Bool = true;

	function render() '
		<HBox spacing=${10}>
			<if ${showImage}>
				<Image src="windowsprite.png"/>
			</if>
			<VBox spacing=${5}>
				<Button label="Press me" onClick=${showImage = !showImage}/>
			</VBox>
		</HBox>
	';
}

function main() {
	flash.Lib.current.stage.scaleMode = NO_SCALE;
	Renderer.mount(flash.Lib.current, <MyWindow/>);
}

function loadImage(url:String):Future<BitmapData> {
	return new Future(function(trigger) {
		var loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event) {
			var bitmap = cast(loader.content, Bitmap);
			trigger(bitmap.bitmapData);
		});
		loader.load(new URLRequest(url));
		return () -> try loader.close() catch (_) {};
	});
}
