class monitor extends component_base;
	
	virtual port_if pif;
	packet pkt;
	function new(string name,component_base parent);
		super.new(name,parent);
	endfunction
	
	task run();
		/*pathname();*/
		forever begin
			pif.collect_packet(pkt);
			if(pkt != null) begin
				pkt.print();
			end else begin
				$display("ERROR : [Monitor] Collected Null Packet");
			end
		end
	endtask
endclass