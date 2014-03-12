package org.haxepad.util;
import org.haxepad.script.Popups;
import org.haxepad.script.ObjectCache;
import org.haxepad.script.wrappers.ComponentWrapper;
import org.haxepad.script.wrappers.DocumentManagerWrapper;
import org.haxepad.script.wrappers.SystemManagerWrapper;

class ScriptUtil {
	public static function exec(script:String, id:String, objects:Map<String, Dynamic> = null):Dynamic {
		if (script == null || id == null || id.length == 0) {
			return null;
		}
		
		var parser = new hscript.Parser();
		var program = parser.parseString(script);
		var interp = new hscript.Interp();

		var cache:ObjectCache = new ObjectCache(id);
		interp.variables.set("Cache", cache);

		var documentsWrapper:DocumentManagerWrapper = new DocumentManagerWrapper();
		interp.variables.set("Documents", documentsWrapper);

		var systemWrapper:SystemManagerWrapper = new SystemManagerWrapper();
		interp.variables.set("System", systemWrapper);
		
		var popupsWrapper:Popups = new Popups();
		interp.variables.set("Popups", popupsWrapper);

		if (objects != null) {
			for (key in objects.keys()) {
				var o = objects.get(key);
				interp.variables.set(key, o);
			}
		}
		
		return interp.execute(program);
	}
}