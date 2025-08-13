class count_trans;
rand logic load;
rand logic[15:0] data_in;
rand logic mode;
logic reset;
logic [15:0]data_out;
constraint s1{data_in inside{[10:25]};}
constraint s2{load dist{1 :=20,0:=80};}
constraint s3{mode dist{1 :=50,0:=50};}
virtual function void display(input string s);
begin
$display("----%s----",s);
$display("mode=%d",mode);
$display("load=%d",load);
$display("data_in",data_in);
end
endfunction
endclass