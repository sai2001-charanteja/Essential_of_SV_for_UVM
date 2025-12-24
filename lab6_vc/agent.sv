class agent extends component_base;
	
	sequencer seq;
	driver drvr;
	monitor mon;
	
	function new(string name,component_base parent);
		super.new(name,parent);
		seq = new("seq",this);
		drvr = new("drvr",this);
		mon = new("mon",this);
	endfunction
	
endclass