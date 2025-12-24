class driver extends component_base;
	
	sequencer seq;
	
	function new(string name,component_base parent);
		super.new(name,parent);
		seq = new("seq",this);
	endfunction
	
	task run();
		$write("Driver ");
		pathname();
		$write("Driver.SEQUENCER ");
		seq.pathname();
	endtask
	
endclass