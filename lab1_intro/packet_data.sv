typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} ptype;

typedef enum {HEX,DEC,BIN} numformat;

class packet;
	
	local string name;
	bit [3:0]target;
	bit [3:0]source;
	bit [7:0]payload;
	ptype ptype_en; 
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
		HEX: $display("PType: %0s, Target : %0h, Soruce : %0h, Payload : %0h",gettype(),target,source,payload);
		DEC: $display("PType: %0s, Target : %0d, Soruce : %0d, Payload : %0d",gettype(),target,source,payload);
		BIN: $display("PType: %0s, Target : %0b, Soruce : %0b, Payload : %0b",gettype(),target,source,payload);
		endcase
	
	endfunction
	
endclass