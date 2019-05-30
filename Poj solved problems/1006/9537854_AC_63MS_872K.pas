program poj1006;
 const m:array[1..3] of longint=(23,28,33);
 var i,j,n,k,p,q,l,r:longint;
 a:array[1..3] of longint;
 d,time,ans:longint;
procedure openfile;
 begin
 assign(input,'poj1006.txt');
 assign(output,'poj1006.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function gcd(a,b:longint; var x,y:longint):longint;
 var t:longint;
 begin
 if b=0 then gcd:=a
  else
   gcd:=gcd(b,a mod b,x,y);
 if b=0 then
   begin
   x:=1;
   y:=0;
   end
  else
   begin
   t:=x;
   x:=y;
   y:=t-y*(a div b);
   end;
 end;
function expand(a,b,c:longint):longint;
 var gg,x,y:longint;
 begin
 gg:=gcd(a,b,x,y);
 if c mod gg<>0 then exit(-1)
  else
  begin
   x:=x* c div gg;
   b:=b div gg;
   x:=(x mod b+b) mod b;
   exit(x);
  end;

 end;
procedure work(var p:longint);
 var i,x,a1,m1,a2,m2:longint;
 begin
  a1:=a[1] mod m[1];
  a2:=a[2] mod m[2];
  m1:=m[1]; m2:=m[2];
  x:=expand(m1,m2,a2-a1)*m1+a1;
  for i:=3 to 3 do
   begin
    a1:=x;
    m1:=m1*m2;
    a2:=a[i];
    m2:=m[i];
    x:=expand(m1,m2,a2-a1);
   end;
  p:=x*m1+a1;
 end;
begin

 readln(a[1],a[2],a[3],d);
 time:=0;
 while a[1]>=0 do
  begin
  inc(time);
  work(ans);
  ans:=ans-d;
  while ans<=0 do ans:=ans+23*28*33;
  writeln('Case ',time,': the next triple peak occurs in ',ans,' days.');
  readln(a[1],a[2],a[3],d);
  end;

end.
