package coconut.flash.renderers;

import coconut.diffing.Key;
import coconut.diffing.NodeType;
import coconut.diffing.VNode;
import flash.display.Bitmap;
import flash.display.BitmapData;

typedef BitmapAttr = {
	@:optional var bitmapData:BitmapData;
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
		w.bitmapData = nu.bitmapData;
	}
}
