program poj2524;
 var i,j,n,m,p,q,l,r,time:longint;
 ans:longint;
 f:array[0..50050] of longint;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function get(x:longint):longint;
 begin
 if x=f[x] then exit(x);
 exit(get(f[x]));
 end;

begin
 //openfile;
 readln(n,m);
while n<>0 do
 begin
 inc(time);
 for i:=1 to n do
  f[i]:=i;
 ans:=n;
 for i:=1 to m do
  begin
  readln(l,r);
  p:=get(l); q:=get(r);
  if p<>q then
   begin
   f[p]:=q;
   dec(ans);
   end;
  end;
 write('Case ',time,': ');
 writeln(ans);
 readln(n,m);
 end;
 //closefile;
end.
