package coconut.flash.renderers;

import coconut.diffing.Factory;
import coconut.diffing.Key;
import coconut.diffing.TypeId;
import coconut.flash.renderers.Basic;
import coconut.ui.Ref;
import flash.display.DisplayObject;
import flash.display.Sprite;

typedef SpriteAttr = DisplayObjectContainerAttr & {
	@:optional var buttonMode:Bool;
}

class SpriteRenderer implements Factory<SpriteAttr, DisplayObject, Sprite> {
	public final type = new TypeId();

	function new() {}

	static final instance = new SpriteRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:Ref<Sprite>, ?key:Key}, attr:SpriteAttr, ?children:Children):RenderResult {
		return instance.vnode(attr, hxxMeta.key, hxxMeta.ref, children);
	}

	public function create(a:SpriteAttr):Sprite {
		trace('Creating sprite', a);
		var sprite = new Sprite();
		update(sprite, {}, a);
		return sprite;
	}

	public function update(w:Sprite, old:SpriteAttr, nu:SpriteAttr) {
		setDisplayObjectContainerAttrs(w, old, nu);
		w.buttonMode = opt(nu.buttonMode, false);
	}
}
