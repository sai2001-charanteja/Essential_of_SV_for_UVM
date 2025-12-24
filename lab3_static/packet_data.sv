typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} ptype_en;

typedef enum {HEX,DEC,BIN} numformat;

typedef enum {TAGGED,UNTAGGED} tagmode_en;
class packet;
	
	local string name;
	rand bit [3:0]target;
	bit [3:0]source;
	rand bit [7:0]payload;
	rand ptype_en ptype; 
	
	static int pktcnt;
	int tag;
	
	tagmode_en tagmode = UNTAGGED;
	
	constraint target_not_zero{target != 0; solve ptype before target;};
	
	constraint type_of_comm{
		ptype == SINGLE -> {
			//target inside {1,2,4,8};
			$onehot(target);
			target != source;
		}
		ptype == MULTICAST ->{ 
			//!(target inside {4'd1,4'd2,4'd4,4'd8});
			$countones(target) >1;
			(target & source) == 0;
		}
		ptype == BROADCAST -> target == 4'hf;
		ptype == ANY -> { 
			target != 0; (target & source) == 0;
		}
		
	};
	
	
	function void post_randomize();
		if(tagmode == TAGGED) payload = tag;
	endfunction
	
	 static function int getcount();
		return pktcnt;
	 endfunction
	 
	 static function void deconstruct(inout packet pktd);
	 
		pktcnt--;
		pktd = null;
		
	 endfunction
	
	//constructor 
	function new(string name, int source);
		this.name = name;
		this.source = 1<<source;
		this.ptype = ANY;
		
		pktcnt++;
		tag = pktcnt;
		
	endfunction
	
	function string gettype();
		
		return ptype.name();
	
	endfunction
	
	function void print(numformat format = HEX);
		$display("------------Name : %0s-----------------------------",name);
		$display("Type : %0s, Tag: %0d, TagMode : %0s, PacketCount = %0d",gettype(),tag,tagmode.name(),getcount());
		case(format)
		HEX: $display("Target : %0h, Source : %0h, Payload : %02h",target,source,payload);
		DEC: $display("Target : %0d, Source : %0d, Payload : %0d",target,source,payload);
		BIN: $display("Target : %04b, Source : %04b, Payload : %08b",target,source,payload);
		endcase
	
	endfunction
	
endclass