

module packet_test;
	import packet_pkg::*;
	
	packet pkt;
	
	logic [3:0]target;
	logic [7:0]data;
	string name;
	int source;
	
	initial begin
		name = "Packet1";
		source = 1;
		target = 4'h1;
		data = 8'hff;
		
		pkt = new(name,source);
		pkt.target = target;
		pkt.payload = data;
		
		pkt.print();
		pkt.print(DEC);
		pkt.print(BIN);
		
	end

endmodule