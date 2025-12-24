class component_base;
	
	protected string name;
	
	component_base parent;
	
	function new(string name, component_base parent);
		this.name = name;
		this.parent = parent;
	endfunction
	
	function string getname();
		return name;
	endfunction
	
	function void pathname();
		component_base temp = this.parent;
		string fullpathname = this.name;
		while(temp.parent !=null) begin
			temp = temp.parent;
			fullpathname = {temp.name,".",fullpathname};
		end
		
		$display("PATH : %0s",fullpathname);
	endfunction
	
	
	function void print();
		$display("*******************************************************");
		$display("Name : %0s",name);
		pathname();
	endfunction
endclass

