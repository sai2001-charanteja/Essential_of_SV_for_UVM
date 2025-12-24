typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} ptype;

typedef enum {HEX,DEC,BIN} numformat;

class packet;
	
	string name;
	rand bit [3:0]target;
	bit [3:0]source;
	rand bit [7:0]payload;
	rand ptype ptype_en; 
	
	
	constraint target_not_zero{target != 0; solve ptype_en before target;};
	
	
	
	constraint type_of_comm{
		ptype_en == SINGLE -> {
			//target inside {1,2,4,8};
			$onehot(target);
			target != source;
		}
		ptype_en == MULTICAST ->{ !(target inside {1,2,4,8}); (target & source) == 0;}
		ptype_en == BROADCAST -> target == 4'hf;
		ptype_en == ANY -> { 
			target != 0; (target & source) == 0;
		}
		
	};
	
	//constructor 
	function new(string name, int source);
		this.name = name;
		this.source = 1<<source;
		this.ptype_en = ANY;
	endfunction
	
	function string gettype();
		
		return ptype_en.name();
	
	endfunction
	
	function void print(numformat format = HEX);
		
		$display("------------Name : %0s-----------------------------",name);
		$display("Type : %0s",gettype());
		case(format)
		HEX: $display("Target : %0h, Source : %0h, Payload : %02h",target,source,payload);
		DEC: $display("Target : %0d, Source : %0d, Payload : %0d",target,source,payload);
		BIN: $display("Target : %04b, Source : %04b, Payload : %08b",target,source,payload);
		endcase
	
	endfunction
	
endclass


class psingle extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype_en = SINGLE;
	endfunction
	
	constraint type_of_comm{};
	constraint single_constraint{
		target inside {1,2,4,8};
		(target & source) == 0;
	};
	
	function void post_randomize();
		super.ptype_en = SINGLE;
	endfunction
	
endclass


class pmulticast extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype_en = MULTICAST;
	endfunction

	constraint type_of_comm{};
	constraint multicast_constraint{
		target inside {3,[5:7],[9:14]};
		(target & source) == 0;
	};
	
	function void post_randomize();
		super.ptype_en = MULTICAST;
	endfunction
	
endclass


class pbroadcast extends packet;

	function new(string name,int source);
		super.new(name,source);
		super.ptype_en = BROADCAST;
	endfunction
	
	constraint type_of_comm{};
	constraint multicast_constraint{
		target == 4'hf;
	};
	
	function void post_randomize();
		super.ptype_en = BROADCAST;
	endfunction
	
endclass




