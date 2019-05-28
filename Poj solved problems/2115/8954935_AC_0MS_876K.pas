program poj2115;
 var a,b,c,k:int64;
 p:int64;
 x,y,z:int64;
procedure openfile;
 begin
 assign(input,'poj2115.in');
 assign(output,'poj2115.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function exgcd(a,b:int64; var x,y:int64):int64;
 var t:int64;
 begin
  if b=0 then
   begin
   exgcd:=a;
   x:=1;
   y:=0;
   end
  else
  begin
  exgcd:=exgcd(b,a mod b,x,y);
  t:=x;
  x:=y;
  y:=t-(a div b)*y;
  end;
 end;
procedure work(a,b,c:int64);
 var gg:int64;
  x,y:int64;
 begin
  gg:=exgcd(a,b,x,y);
  if c mod gg<>0 then writeln('FOREVER')
  else
   begin
   x:=x*c div gg;
   b:=b div gg;
   x:=(x mod b+b) mod b;
   writeln(x);
   end;
 end;
begin
 //openfile;
 readln(a,b,c,k);
while not ((a=0)and(b=0)and(c=0)and(k=0)) do
 begin
 if k<=30 then
  y:=1 shl k
 else
  begin
  y:=1 shl 30;
  if k=31 then y:=y*2;
  if k=32 then y:=y*4;
  end;
 x:=c; z:=b-a;
 work(x,y,z);
 readln(a,b,c,k);
 end;
 //closefile;
end.