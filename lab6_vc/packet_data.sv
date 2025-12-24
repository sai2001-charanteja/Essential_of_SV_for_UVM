typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} packet_type_t;

typedef enum {HEX,DEC,BIN} numformat;

class packet;
	
	string name;
	rand bit [3:0]target;
	bit [3:0]source;
	rand bit [7:0]data;
	rand packet_type_t ptype; 
	
	
	constraint target_not_zero{target != 0; solve ptype before target;};
	
	
	
	constraint type_of_comm{
		ptype == SINGLE -> {
			//target inside {1,2,4,8};
			$onehot(target);
			target != source;
		}
		ptype == MULTICAST ->{ !(target inside {1,2,4,8}); (target & source) == 0;}
		ptype == BROADCAST -> target == 4'hf;
		ptype == ANY -> { 
			target != 0; (target & source) == 0;
		}
		
	};
	
	//constructor 
	function new(string name, int source);
		this.name = name;
		this.source = 1<<source;
		this.ptype = ANY;
	endfunction
	
	function string getname();
		getname = this.name;
	endfunction
	
	function string gettype();
		
		return ptype.name();
	
	endfunction
	
	function void print(numformat format = HEX);
		
		$display("------------Name : %0s-----------------------------",name);
		$display("Type : %0s",gettype());
		case(format)
		HEX: $display("Target : %0h, Source : %0h, Payload : %02h",target,source,data);
		DEC: $display("Target : %0d, Source : %0d, Payload : %0d",target,source,data);
		BIN: $display("Target : %04b, Source : %04b, Payload : %08b",target,source,data);
		endcase
	
	endfunction
	
endclass


class psingle extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype = SINGLE;
	endfunction
	
	constraint type_of_comm{};
	constraint single_constraint{
		target inside {1,2,4,8};
		(target & source) == 0;
	};
	
	function void post_randomize();
		super.ptype = SINGLE;
	endfunction
	
	function void copy(input packet pkt);
		this.name = pkt.name;
		this.target = pkt.target;
		this.source = pkt.source;
		this.data = pkt.data;
		this.ptype = pkt.ptype;
	endfunction
	
endclass


class pmulticast extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype = MULTICAST;
	endfunction

	constraint type_of_comm{};
	constraint multicast_constraint{
		target inside {3,[5:7],[9:14]};
		(target & source) == 0;
	};
	
	function void post_randomize();
		super.ptype = MULTICAST;
	endfunction
	
endclass


class pbroadcast extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype = BROADCAST;
	endfunction
	
	constraint type_of_comm{};
	constraint multicast_constraint{
		target == 4'hf;
	};
	
	function void post_randomize();
		super.ptype = BROADCAST;
	endfunction
	
endclass




