program poj;
 var i,j,n,m,p,q:longint;
   ans,num:longint;
 begin
 readln(n);
 ans:=-1000000;
 for i:=1 to n do
  begin
  q:=0;
  for j:=1 to n do
    begin
    read(p);
    if p=3 then p:=1 else p:=0;
    q:=q+p;
    end;
  if q>ans then begin ans:=q; num:=i; end;
  end;
  writeln(num);
 end.
