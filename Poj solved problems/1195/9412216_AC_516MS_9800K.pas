program poj1195;
 const maxn=1111;
 var x1,y1,x2,y2,v,n,com,ans:longint;
 sum:array[0..maxn,0..maxn] of int64;
procedure openfile;
 begin
 assign(input,'poj1195.in');
 assign(output,'poj1195.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function lowbit(x:longint):longint;
 begin
 lowbit:=x and (x xor (x-1));
 end;
procedure add(x,y,v:longint);
 var yy:longint;
 begin
 yy:=y;
 while x<=n do
  begin
  y:=yy;
  while y<=n do
   begin
   sum[x,y]:=sum[x,y]+v;
   y:=y+lowbit(y);
   end;
  x:=x+lowbit(x);
  end;
 end;
function query(x,y:longint):int64;
 var yy:longint;
 begin
 query:=0;
 yy:=y;
 while x>0 do
  begin
  y:=yy;
  while y>0 do
   begin
   query:=query+sum[x,y];
   y:=y-lowbit(y);
   end;
  x:=x-lowbit(x);
  end;
 end;
begin

 readln(n,n);
 read(com);
 while com<>3 do
  begin
  case com of
   1:begin
     readln(x1,y1,v);
     add(x1+1,y1+1,v);
     end;
   2:begin
     readln(x1,y1,x2,y2);
     x1:=x1+1; x2:=x2+1; y1:=y1+1; y2:=y2+1;
     ans:=0;
     ans:=ans+query(x2,y2)-query(x1-1,y2)-query(x2,y1-1)+query(x1-1,y1-1);
     writeln(ans);
     end;
   end;
  read(com);
  end;


end.