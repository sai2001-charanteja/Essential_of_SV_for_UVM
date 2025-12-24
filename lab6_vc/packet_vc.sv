class packet_vc extends component_base;
	
	virtual port_if pif;
	
	agent agn;
	
	function new(string name,component_base parent);
		super.new(name,parent);
		agn = new("agn",this);	
	endfunction

	function void configuration();
		agn.seq.pktno = 1;
		agn.drvr.pif = pif;
		agn.mon.pif = pif;
		
	endfunction
	
	task run(input int runs);
		fork
			agn.drvr.run(runs);
			agn.mon.run();
		join_any
	endtask
endclass