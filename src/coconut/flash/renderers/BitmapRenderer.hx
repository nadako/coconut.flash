package coconut.flash.renderers;

import coconut.diffing.Key;
import coconut.diffing.NodeType;
import coconut.diffing.VNode;
import coconut.flash.renderers.Basic;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;

typedef BitmapAttr = DisplayObjectAttr & {
	@:optional var bitmapData:BitmapData;
	@:optional var pixelSnapping:PixelSnapping;
	@:optional var smoothing:Bool;
}

class BitmapRenderer implements NodeType<BitmapAttr, Bitmap> {
	function new() {}

	static final instance:NodeType<BitmapAttr, Bitmap> = new BitmapRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:Bitmap->Void, ?key:Key}, attr:BitmapAttr, ?children:Children):RenderResult {
		return cast VNative(instance, hxxMeta.ref, hxxMeta.key, attr, cast children);
	}

	public function create(a:BitmapAttr):Bitmap {
		var sprite = new Bitmap();
		update(sprite, {}, a);
		return sprite;
	}

	public function update(w:Bitmap, old:BitmapAttr, nu:BitmapAttr) {
		setDisplayObjectAttrs(w, old, nu);
		w.bitmapData = nu.bitmapData;
		w.pixelSnapping = opt(nu.pixelSnapping, AUTO);
		w.smoothing = opt(nu.smoothing, false);
	}
}
