program poj1046;
 var n,m,a,b,c,l,i,j,k,aa,bb:int64;
  gg:int64;
  x,y:int64;
  d,t:int64;
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
  y:=t-(a div b)*y;
  end;
 end;
begin
 read(aa,bb,m,n,l);
 if m>n then begin d:=bb-aa; a:=m-n; end
        else begin d:=aa-bb; a:=n-m; end;
 gg:=exgcd(a,l,x,y);
 if d mod gg<>0 then writeln('Impossible')
 else
  begin
   x:=x*d div gg;
   l:=l div gg;
   x:=(x mod l+l) mod l;
   writeln(x);
  end;
end.

