package org.haxepad.script.wrappers;

import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ui.toolkit.data.IDataSource;

class ComponentWrapper {
	private var _c:Component;
	
	public function new(c:Component) {
		_c = c;
	}
	
	public function getText():String {
		return _c.text;
	}
	
	public function setText(value:String):Void {
		_c.text = value;
	}
	
	public function removeAll():Void {
		if (Std.is(_c, ListView)) {
			cast(_c, ListView).dataSource.removeAll();
		}
	}
	
	public function add(items:Dynamic):Void {
		if (Std.is(_c, ListView)) {
			var ds:IDataSource = null;
			if (Std.is(items, Array)) { // we need to convert items into a proper data source for the list
				var arr:Array<Dynamic> = cast(items, Array<Dynamic>);
				ds = new ArrayDataSource();
				for (item in arr) {
					if (Std.is(item, String)) {
						var o:Dynamic = { };
						o.text = cast(item, String);
						ds.add(o);
					} else { // assume its an object
						ds.add(item);
					}
				}
			}			
			cast(_c, ListView).dataSource = ds;
		}
	}
}