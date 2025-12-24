typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} ptype;

typedef enum {HEX,DEC,BIN} numformat;

class packet;
	
	local string name;
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
		ptype_en == MULTICAST ->{ target not inside {1,2,4,8}; (target & source) == 0};
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
		
		case(format)
		HEX: $display("PType: %0s, Target : %0h, Source : %0h, Payload : %02h",gettype(),target,source,payload);
		DEC: $display("PType: %0s, Target : %0d, Source : %0d, Payload : %0d",gettype(),target,source,payload);
		BIN: $display("PType: %0s, Target : %04b, Source : %04b, Payload : %08b",gettype(),target,source,payload);
		endcase
	
	endfunction
	
endclass
