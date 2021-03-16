package coconut.flash.renderers;

import coconut.diffing.Factory;
import coconut.diffing.Key;
import coconut.diffing.TypeId;
import coconut.flash.renderers.Basic;
import coconut.ui.Ref;
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

typedef TextFieldAttr = InteractiveObjectAttr & {
	@:optional var type:TextFieldType;
	@:optional var text:String;
	@:optional var autoSize:TextFieldAutoSize;
	@:optional var multiline:Bool;
	@:optional var wordWrap:Bool;
	@:optional var selectable:Bool;
}

class TextFieldRenderer implements Factory<TextFieldAttr, DisplayObject, TextField> {
	public final type = new TypeId();

	function new() {}

	static final instance = new TextFieldRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:Ref<TextField>, ?key:Key}, attr:TextFieldAttr):RenderResult {
		return instance.vnode(attr, hxxMeta.key, hxxMeta.ref);
	}

	public function create(a:TextFieldAttr):TextField {
		trace('Creating text', a);
		var textField = new TextField();
		update(textField, {}, a);
		return textField;
	}

	public function update(w:TextField, old:TextFieldAttr, nu:TextFieldAttr) {
		setInteractiveObjectAttrs(w, old, nu);
		w.type = opt(nu.type, DYNAMIC);
		w.text = opt(nu.text, "");
		w.autoSize = opt(nu.autoSize, NONE);
		w.multiline = opt(nu.multiline, false);
		w.wordWrap = opt(nu.wordWrap, false);
		w.selectable = opt(nu.selectable, true);
	}
}
