program poj;
 var i,j,n,m,p,q:longint;
   ans,num:longint;
 begin
 //assign(input,'poj.in');
// assign(output,'poj.out');
 //reset(input);
 //rewrite(output);
 readln(n);
 ans:=-1000000;
 for i:=1 to n do
  begin
  q:=0;
  for j:=1 to n do
    begin
    read(p);
    q:=q+p;
    end;
  if q>ans then begin ans:=q; num:=i; end;
  end;
  writeln(num);
 end.
