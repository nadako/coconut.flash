package coconut.flash.renderers;

import coconut.diffing.Factory;
import coconut.diffing.Key;
import coconut.diffing.TypeId;
import coconut.flash.renderers.Basic;
import coconut.ui.Ref;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.PixelSnapping;

typedef BitmapAttr = DisplayObjectAttr & {
	@:optional var bitmapData:BitmapData;
	@:optional var pixelSnapping:PixelSnapping;
	@:optional var smoothing:Bool;
}

class BitmapRenderer implements Factory<BitmapAttr, DisplayObject, Bitmap> {
	public final type = new TypeId();

	function new() {}

	static final instance = new BitmapRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:Ref<Bitmap>, ?key:Key}, attr:BitmapAttr):RenderResult {
		return instance.vnode(attr, hxxMeta.key, hxxMeta.ref);
	}

	public function create(a:BitmapAttr):Bitmap {
		trace('Creating bitmap', a);
		var bitmap = new Bitmap();
		update(bitmap, {}, a);
		return bitmap;
	}

	public function update(w:Bitmap, old:BitmapAttr, nu:BitmapAttr) {
		setDisplayObjectAttrs(w, old, nu);
		w.bitmapData = nu.bitmapData;
		w.pixelSnapping = opt(nu.pixelSnapping, AUTO);
		w.smoothing = opt(nu.smoothing, false);
	}
}
