

module packet_test;
	import packet_pkg::*;
	
	packet pkt;
	
	logic [3:0]target;
	logic [7:0]data;
	string name;
	int source;
	
	initial begin
	
		for(int idx=0;idx<10;idx++) begin
			pkt = new($sformatf("Packet_Data %0d",idx),1);
			pkt.source = 1 << $urandom_range(0,3);
			pkt.tagmode = $random %2 ? TAGGED: UNTAGGED;
		
			void'(pkt.randomize());
			
			//pkt.getcount();
			
			pkt.print();
			
			packet::deconstruct(pkt);
		end
	end

endmodule