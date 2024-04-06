package monitor_pkg;
  
import uvm_pkg::*;
import seq_item_pkg::*;

`include "uvm_macros.svh";

class monitor extends uvm_monitor;
  virtual sfr_if vif;
  uvm_analysis_port #(seq_item) item_collect_port;
  seq_item mon_item;
  `uvm_component_utils(monitor)
  
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
    mon_item = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual sfr_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    /*forever begin
      wait(!vif.reset);
      @(posedge vif.clk);
      mon_item.ip1 = vif.ip1;
      mon_item.ip2 = vif.ip2;
      `uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", mon_item.ip1, mon_item.ip2), UVM_HIGH);
      @(posedge vif.clk);
      mon_item.out = vif.out;
      item_collect_port.write(mon_item);
    end
    */
  endtask
endclass


endpackage : monitor_pkg