package coconut.flash.renderers;

import coconut.diffing.Key;
import coconut.diffing.NodeType;
import coconut.diffing.VNode;
import coconut.flash.renderers.Basic;
import flash.display.Sprite;

typedef SpriteAttr = DisplayObjectContainerAttr & {
	@:optional var buttonMode:Bool;
}

class SpriteRenderer implements NodeType<SpriteAttr, Sprite> {
	function new() {}

	static final instance:NodeType<SpriteAttr, Sprite> = new SpriteRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:Sprite->Void, ?key:Key}, attr:SpriteAttr, ?children:Children):RenderResult {
		return cast VNative(instance, hxxMeta.ref, hxxMeta.key, attr, cast children);
	}

	public function create(a:SpriteAttr):Sprite {
		var sprite = new Sprite();
		update(sprite, {}, a);
		return sprite;
	}

	public function update(w:Sprite, old:SpriteAttr, nu:SpriteAttr) {
		setDisplayObjectContainerAttrs(w, old, nu);
		w.buttonMode = opt(nu.buttonMode, false);
	}
}
