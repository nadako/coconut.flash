package coconut.flash.renderers;

import coconut.diffing.Key;
import coconut.diffing.NodeType;
import coconut.diffing.VNode;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

typedef TextFieldAttr = {
	@:optional var text:String;
	@:optional var autoSize:TextFieldAutoSize;
}

class TextFieldRenderer implements NodeType<TextFieldAttr, TextField> {
	function new() {}

	static final instance:NodeType<TextFieldAttr, TextField> = new TextFieldRenderer();

	public static inline function fromHxx(hxxMeta:{?ref:TextField->Void, ?key:Key}, attr:TextFieldAttr, ?children:Children):RenderResult {
		return cast VNative(instance, hxxMeta.ref, hxxMeta.key, attr, cast children);
	}

	public function create(a:TextFieldAttr):TextField {
		var textField = new TextField();
		update(textField, {}, a);
		return textField;
	}

	public function update(w:TextField, old:TextFieldAttr, nu:TextFieldAttr) {
		w.text = if (nu.text == null) "" else nu.text;
		w.autoSize = if (nu.autoSize == null) NONE else nu.autoSize;
	}
}
