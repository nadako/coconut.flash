package coconut.flash.renderers;

import coconut.diffing.Key;
import coconut.diffing.NodeType;
import coconut.diffing.VNode;
import flash.display.Sprite;
import flash.events.MouseEvent;

typedef SpriteAttr = {
	@:optional var buttonMode:Bool;
	@:optional var mouseChildren:Bool;
	@:optional var onClick:MouseEvent->Void;
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
		w.buttonMode = nu.buttonMode;
		w.mouseChildren = nu.mouseChildren;
		if (old.onClick != null) w.removeEventListener(MouseEvent.CLICK, old.onClick);
		if (nu.onClick != null) w.addEventListener(MouseEvent.CLICK, nu.onClick);
	}
}
