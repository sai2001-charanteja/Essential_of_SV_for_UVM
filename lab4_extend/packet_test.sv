

module packet_test;
	import packet_pkg::*;
	
	packet pkt_arr[0:15];
	
	int source;
	
	function void validate(packet pkt);
		string str;
		str = pkt.name;
		if(str.match("SINGLE_PKT_[0-9]+")) begin
			if(($countones(pkt.target) != 1) || ($countones(pkt.source) !=1) || ((pkt.target & pkt.source) != 0) || pkt.ptype_en != SINGLE)
				$display("Invalid Packet.");
		end else if(str.match("MULTICAST_PKT_[0-9]+")) begin
			if(($countones(pkt.target) < 1) || ($countones(pkt.source) !=1) || ((pkt.target & pkt.source) != 0)  || pkt.ptype_en != MULTICAST)
				$display("Invalid Packet.");
		end else if(str.match("BROADCAST_PKT_[0-9]+")) begin
			if(($countones(pkt.source) !=1) || (pkt.target != 4'hf) || pkt.ptype_en != BROADCAST)
				$display("Invalid Packet.");
		end else begin
			$display("Missing Proper Name.");
		end
	endfunction
	
	initial begin
	
		for(int idx=0;idx<16;idx++) begin
			source = $urandom_range(0,3);
			randcase
				5: begin
					psingle single_pkt;
					single_pkt = new($sformatf("SINGLE_PKT_%0d",idx),source);
					void'(single_pkt.randomize());
					pkt_arr[idx] = single_pkt;
				end
				3: begin
					pmulticast multicast_pkt;
					multicast_pkt = new($sformatf("MULTICAST_PKT_%0d",idx),source);
					void'(multicast_pkt.randomize());
					pkt_arr[idx] = multicast_pkt;
				end
				2: begin
					pbroadcast broadcast_pkt;
					broadcast_pkt = new($sformatf("BROADCAST_PKT_%0d",idx),source);
					void'(broadcast_pkt.randomize());
					pkt_arr[idx] = broadcast_pkt;
				end
			endcase
		end
		
		foreach(pkt_arr[i]) begin
			pkt_arr[i].print();
			validate(pkt_arr[i]);
		end
		
	end

endmodule