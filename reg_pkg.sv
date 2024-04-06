package reg_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh";

class ral_control_reg extends uvm_reg ;

`uvm_object_utils(ral_control_reg);

rand uvm_reg_field rsvd ;
rand uvm_reg_field parity_en;
rand uvm_reg_field dbg_en;
rand uvm_reg_field mod_en;


function new(string name = "ral_control_reg");
	super.new(name,32,build_coverage(UVM_NO_COVERAGE));  // NO COVERAGE PREVENT COLLECTING COV INFO FOR FIELD TO INCREASE THE SIMULATOR PERFORMANCE
endfunction


virtual function void build();
rsvd      = uvm_reg_field :: type_id :: create("rsvd")     ;
parity_en = uvm_reg_field :: type_id :: create("parity_en");
dbg_en    = uvm_reg_field :: type_id :: create("dbg_en")   ;
mod_en    = uvm_reg_field :: type_id :: create("mod_en")   ;


rsvd.configure     (this , 29 , 3 , "RO" , 0 , 1'b0 , 1 , 1 , 0);
parity_en.configure(this , 1  , 2 , "RW" , 0 , 1'b1 , 1 , 1 , 0);
dbg_en.configure   (this , 1  , 1 , "RW" , 0 , 1'b0 , 1 , 1 , 0);
mod_en.configure   (this , 1  , 0 , "RW" , 0 , 1'b1 , 1 , 1 , 0);

// this -> the parent which is ral_control_reg 
// 29 -> WIDTH
// 3 -> Start of the field
// "RO" -> ACCESS Policy for the field
//  0 -> make the field non volatile (not affected by reset)
// 1 -> enable read lock for the field
// 1 -> enable write lock for the field
// 0 -> disaple separate accessability for this field 

endfunction
endclass

	
//-------------------------------------------------------------------

class ral_intr_sts_reg extends uvm_reg ;   // interrupt status

`uvm_object_utils(ral_intr_sts_reg);

rand uvm_reg_field rsvd      ;
rand uvm_reg_field r_axi_err ;
rand uvm_reg_field w_axi_err ;


function new(string name = "ral_intr_sts_reg");
  super.new(name,32,build_coverage(UVM_NO_COVERAGE));
endfunction


virtual function void build();
rsvd      = uvm_reg_field :: type_id :: create("rsvd")     ;
r_axi_err = uvm_reg_field :: type_id :: create("r_axi_err");
w_axi_err = uvm_reg_field :: type_id :: create("w_axi_err");


rsvd.configure     (this , 30 , 2 ,"RO" , 0 , 1'b0 , 1 , 1 , 0 );
r_axi_err.configure(this , 1  , 1 ,"W1C", 0 , 1'b0 , 1 , 1 , 0 );	// W1C  means 1 to clear review the documentation
w_axi_err.configure(this , 1  , 0 ,"W1C", 0 , 1'b0 , 1 , 1 , 0 ); 

endfunction
endclass


//-------------------------------------------------------------------


class ral_intr_msk_reg extends uvm_reg ;     // interrupt mask
	
`uvm_object_utils(ral_intr_msk_reg);

rand uvm_reg_field rsvd          ;
rand uvm_reg_field r_axi_err_msk ;
rand uvm_reg_field w_axi_err_msk ;


function new(string name = "ral_intr_msk_reg");
  super.new(name,32,build_coverage(UVM_NO_COVERAGE));
endfunction


virtual function void build();
rsvd          = uvm_reg_field :: type_id :: create("rsvd")         ;
r_axi_err_msk = uvm_reg_field :: type_id :: create("r_axi_err_msk");
w_axi_err_msk = uvm_reg_field :: type_id :: create("w_axi_err_msk");


rsvd.configure         (this , 30 , 2 ,"RO" , 0 , 1'b0 , 1 , 1 , 0 );
r_axi_err_msk.configure(this , 1  , 1 ,"RW" , 0 , 1'b0 , 1 , 1 , 0 );
w_axi_err_msk.configure(this , 1  , 0 ,"RW" , 0 , 1'b0 , 1 , 1 , 0 ); 

endfunction
endclass


//-------------------------------------------------------------------

class ral_debug_reg extends uvm_reg ;     // interrupt mask
	
`uvm_object_utils(ral_debug_reg);

rand uvm_reg_field rsvd          ;
rand uvm_reg_field r_axi_resp ;
rand uvm_reg_field w_axi_resp ;


function new(string name = "ral_debug_reg");
  super.new(name,32,build_coverage(UVM_NO_COVERAGE));  
endfunction


virtual function void build();
rsvd          = uvm_reg_field :: type_id :: create("rsvd")      ;
r_axi_resp    = uvm_reg_field :: type_id :: create("r_axi_resp");
w_axi_resp    = uvm_reg_field :: type_id :: create("w_axi_resp");


rsvd.configure         (this , 30 , 2 ,"RO" , 0 , 1'b0 , 1 , 1 , 0 );
r_axi_resp.configure   (this , 1  , 1 ,"RO" , 0 , 1'b0 , 1 , 1 , 0 );
w_axi_resp.configure   (this , 1  , 0 ,"RO" , 0 , 1'b0 , 1 , 1 , 0 ); 

endfunction
endclass


//-------------------------------------------------------------------


class module_reg extends uvm_reg_block ;

  `uvm_object_utils(module_reg);

  rand ral_control_reg   control_reg ;
  rand ral_intr_sts_reg  intr_sts_reg;
  rand ral_intr_msk_reg  intr_msk_reg;
  rand ral_debug_reg     debug_reg   ;

function new(string name = "module_reg");
  	super.new(name);
endfunction


virtual function void build();
  control_reg = ral_control_reg :: type_id :: create("control_reg");
  control_reg.configure(this,null);
  control_reg.build();    //BUILD ITS INTERNAL STRUCTURE


  intr_sts_reg = ral_intr_sts_reg :: type_id :: create("intr_sts_reg");
  intr_sts_reg.configure(this,null);
  intr_sts_reg.build();  //BUILD ITS INTERNAL STRUCTURE


  intr_msk_reg = ral_intr_msk_reg :: type_id :: create("intr_msk_reg");
  intr_msk_reg.configure(this,null);
  intr_msk_reg.build();   //BUILD ITS INTERNAL STRUCTURE

  
  debug_reg = ral_debug_reg :: type_id :: create("debug_reg");
  debug_reg.configure(this,null);
  debug_reg.build();
  

  default_map = create_map("" , `UVM_REG_ADDR_WIDTH'h0 , 4 , UVM_LITTLE_ENDIAN , 1);
  
  this.default_map.add_reg(control_reg    , `UVM_REG_ADDR_WIDTH'h0 , "RW");
  this.default_map.add_reg(intr_sts_reg   , `UVM_REG_ADDR_WIDTH'h4 , "RW");
  this.default_map.add_reg(intr_msk_reg   , `UVM_REG_ADDR_WIDTH'h8 , "RW");
  this.default_map.add_reg(debug_reg      , `UVM_REG_ADDR_WIDTH'hC , "RW");

endfunction

endclass


//-------------------------------------------------------------------

class RegModel_SFR extends uvm_reg_block ;

  `uvm_object_utils(RegModel_SFR);

rand module_reg mod_reg ;
uvm_reg_map axi_map     ;

function new(string name = "RegModel_SFR");
	super.new(name);
endfunction


virtual function void build();

mod_reg = module_reg :: type_id :: create("mod_reg");
mod_reg.configure(this);
mod_reg.build();    //BUILD ITS INTERNAL STRUCTURE

default_map = create_map("axi_map" , 'h0 , 4 , UVM_LITTLE_ENDIAN , 0); 
                                        // Here Accessability didn't set explicity whch means likely controlled by submap

default_map.add_submap(this.mod_reg.default_map , 0);
       									// Here I can later add other submaps also
	
endfunction
endclass	

endpackage



/*

This code snippet deals with creating and populating a register map within the module_reg class. Let's break it down:
1. Creating the Register Map:
default_map = create_map("",UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);`:
This line creates a register map named default_map using the create_map() function likely provided by the UVM library.
Arguments passed to create_map():
"" (empty string): Base name for the map (not used in this case).
``UVM_REG_ADDR_WIDTH'h0`: Base address of the map, set to 0.
4: Number of registers within the map.
UVM_LITTLE_ENDIAN: Endianness, indicating little-endian byte ordering.
1: Accessibility, meaning all registers are accessible (read-write).

2. Adding Registers to the Map:
this.default_map.add_reg(...): These lines add the previously declared register instances (control_reg, intr_sts_reg, etc.) to the default_map.

control_reg: First argument specifies the register object to add.
``UVM_REG_ADDR_WIDTH'h0` (repeated for other registers): This sets the individual address for each register within the map:

control_reg: Base address (0) as defined in the map creation.

intr_sts_reg: Offset of 4 from the base (address 4).

intr_msk_reg: Offset of 8 from the base (address 8).

debug_reg: Offset of 12 from the base (address 12).

"RW" (repeated for other registers): Access type for each register. Here, all are read-write.

Overall Purpose:
This code establishes a register map that defines an organized layout for the four registers within the module_reg block.
The map specifies the base address, number of registers, endianness, and accessibility.
Individual registers are added to the map with their specific offsets and access permissions.
Benefits of Register Maps:
Provides a clear structure for managing multiple registers within a block.
Simplifies access by associating registers with logical addresses.
Enforces access permissions for better verification control.

*/


////////////////////////////////////////////////////////////////////////////////////////////////



/*

Here's a breakdown of the code and its functionality:
1. Class Definition:
class RegModel_SFR extends uvm_reg_block;: Defines a class named RegModel_SFR that inherits from uvm_reg_block, creating a higher-level register block for UVM verification.

2. Macro for Object Utilities:
``uvm_object_utils(RegModel_SFR);`: Registers the class with UVM's object management framework.

3. Register Block Declaration:
rand module_reg mod_reg;: Declares a random instance of the previously defined module_reg class, indicating it contains a collection of registers.

4. Register Map Declaration:
uvm_reg_map axi_map;: Declares a register map named axi_map to organize registers within this block.

5. Constructor:
function new(string name = "RegModel_SFR");: Defines a constructor to create new instances with a default name.

6. build() Function:
virtual function void build();: This function constructs the register block's internal structure:
Creates an instance of the module_reg block using module_reg::type_id::create().
Configures it using configure() and calls its build() function to set up internal registers and fields.
Creates a register map named "axi_map" using create_map(), specifying:
Base address: 0
Size: 4 registers (likely accommodating the submap)
Endianness: Little-endian
Accessibility: Not explicitly set (likely controlled by submap)
Adds the mod_reg block's register map as a submap to this block's axi_map using add_submap(), effectively incorporating those registers into this hierarchical structure.

Overall Purpose:
This code defines a UVM register block named RegModel_SFR that hierarchically encapsulates the registers defined within the module_reg block.
It creates a register map named axi_map to organize those registers and potentially others that might be added directly to this block.
This modular structure allows for more complex register layouts and potentially aligns with specific hardware interfaces or verification requirements.


*/