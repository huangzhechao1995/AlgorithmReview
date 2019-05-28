program poj1046;
 var n,m,a,b,l,i,j,k:int64;
  gg:int64;
  x,y:int64;
  aa,bb:int64;
  d,t:int64;
function gcd(a,b:int64):int64;
 begin
 if b=0 then exit(a);
 gcd:=gcd(b,a mod b);
 end;
function exgcd(a,b:int64; var x,y:int64):longint;
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
  y:=x-(a div b)*y;
  end;
 end;
begin
 read(a,b,m,n,l);
 gg:=gcd(l,n-m);
 if gg mod (a-b)<>0 then
  writeln('Impossible');
 a:=l div gg;
 b:=(n-m) div gg;
 d:=(a-b) div gg;
 exgcd(a,b,x,y);
 t:=d*x div b;
 x:=d*x-t*b;
 if x<0 then
  x:=x+b;
 writeln(x);
end.

