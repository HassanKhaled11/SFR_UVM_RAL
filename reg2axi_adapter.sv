package reg2axi_adapter_pkg;
	

import uvm_pkg::*;
import seq_item_pkg::*;

`include "uvm_macros.svh";


class reg_axi_adapter extends uvm_reg_adapter ;

  `uvm_object_utils(reg_axi_adapter);

 function new(string name = "reg_axi_adapter");
 	super.new(name);
 endfunction


 virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);   //Converts bus transaction to reg transaction
 	seq_item bus_item = seq_item :: type_id :: create("bus_item");
 	bus_item.addr     = rw.addr    ;
 	bus_item.data     = rw.data    ;
 	bus_item.rd_or_wr = (rw.kind == UVM_READ)? 1'b1 : 1'b0; 

   
    `uvm_info(get_type_name ,
        $sformatf("reg2bus : addr = %0h , data = %0h , rd_or_wr = %0h",bus_item.addr , bus_item.data , bus_item.rd_or_wr),UVM_LOW);

 	return bus_item;
 endfunction

 
 virtual function void bus2reg(uvm_sequence_item bus_item , ref uvm_reg_bus_op rw); //Converts bus transaction to reg transaction
 	seq_item bus_pkt ;

 	if(!$cast(bus_pkt,bus_item))
 		`uvm_fatal(get_type_name() , "FAILED TO CAST BUS ITEM TRANSACTION");

 	rw.addr = bus_pkt.addr;
 	rw.data = bus_pkt.data;
 	rw.kind = (bus_pkt.rd_or_wr)? UVM_READ : UVM_WRITE;
 endfunction
endclass


endpackage : reg2axi_adapter_pkg