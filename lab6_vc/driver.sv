class driver extends component_base;
	
	virtual port_if pif;
	sequencer seq;
	
	packet pkt;
	
	function new(string name,component_base parent);
		super.new(name,parent);
		seq = new("seq",this);
	endfunction
	
	task run(input int runs);
		/*
		$write("Driver ");
		pathname();
		$write("Driver.SEQUENCER ");
		seq.pathname();
		*/
		
		for(int idx = 0;idx<runs;idx++) begin
			seq.get_next_item(pkt);
			
			if(pkt != null) begin
				pkt.print();
				pif.drive_packet(pkt);
			end else begin seq.pathname();
				$display("ERROR: [Driver]Resulted in null packet");
			end
			
			
		end
	endtask
	
	
endclass