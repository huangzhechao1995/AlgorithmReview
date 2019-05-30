program poj2301;
 var i,j,n,m:longint;
    p,q,high,low:int64;
begin
 readln(n);
 for i:=1 to n do
  begin
  readln(p,q);
  high:=(p+q) div 2;
  low:=(p-q) div 2;
  if (high<0)or(low<0) then writeln('impossible')
  else writeln(high,' ',low);
  end;

end.