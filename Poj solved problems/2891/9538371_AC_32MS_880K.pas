program poj2891;
 var i,n:longint;
 p,q,a1,a2,m1,m2,gg:int64;
 ans:int64;
 flag:boolean;
procedure openfile;
 begin
 assign(input,'poj2891.in');
 assign(output,'poj2891.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function gcd(a,b:int64; var x,y:int64):int64;
 var t:int64;
 begin
  if b=0 then
   begin
   x:=1; y:=0;
   exit(a);
   end;
  gcd:=gcd(b,a mod b,x,y);
  t:=x;
  x:=y;
  y:=t-a div b*y;
 end;
function expand(a,b,c:int64):int64;
 var x,y:int64;
 begin
  gg:=gcd(a,b,x,y);
  if c mod gg<>0 then exit(-1);
  x:=c div gg*x;
  b:=b div gg;
  x:=(x mod b+b) mod b;
  exit(x);
 end;
begin

 while not seekeof do
  begin
 flag:=true;
 readln(n);
 if n=1 then
  begin
  readln(a2,m2);
  ans:=a2+m2;
  writeln(ans);
  halt;
  end;
 readln(m1,a1);
 readln(m2,a2);
 ans:=expand(m1,m2,a2-a1);
 if ans=-1 then
   begin writeln(-1); flag:=false; end;
 a1:=ans*m1+a1;
 m1:=m1 div gcd(m1,m2,p,q)*m2;
 for i:=3 to n do
  begin
  readln(m2,a2);
  if flag then
   begin
   ans:=expand(m1,m2,a2-a1);
   if ans=-1 then
    begin writeln(-1); flag:=false; end;
   a1:=ans*m1+a1;
   m1:=m1 div gg*m2;
   // if i<>n then ans:=ans mod m1;
   end;
  end;
 if flag then
  writeln(a1);
 end;

end.