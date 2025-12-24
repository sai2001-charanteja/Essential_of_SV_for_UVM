class sequencer extends component_base;
	
	int pktno;
	
	function new(string name,component_base parent);
		super.new(name,parent);
	endfunction
	
	function void get_next_item(output packet pkt);
	
		//bit [3:0] source = $urandom_range(0,3);
		bit [3:0] source;
		source = pktno;
		randcase
			1: begin
				psingle single_pkt = new($sformatf("SINGLE_PKT_%0d",pktno),source);
				void'(single_pkt.randomize());
				pkt = single_pkt;
			end
			1: begin
				pmulticast multicast_pkt = new($sformatf("MULTICAST_PKT_%0d",pktno),source);
				void'(multicast_pkt.randomize());
				pkt = multicast_pkt;
			end
			1: begin
				pbroadcast broadcast_pkt = new($sformatf("BRAODCAST_PKT_%0d",pktno),source);
				void'(broadcast_pkt.randomize());
				pkt = broadcast_pkt;
			end
		endcase
		
		pktno++;
		
	endfunction
	
endclass
