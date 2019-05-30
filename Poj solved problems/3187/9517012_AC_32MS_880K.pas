program poj3187;
 const maxn=12;
 var i,j,n,m,p,q,l,r,k:longint;
 f:array[0..maxn] of longint;
 a:array[1..maxn] of longint;
 hash:array[1..maxn] of boolean;
 goal,ans:longint;
procedure openfile;
 begin
 assign(input,'poj3187.in');
 assign(output,'poj3187.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure search(x,sum:longint);
 var i,j,p,q:longint;
 begin
 if x>n then
  begin
  if sum=goal then
   begin
    for i:=1 to n do
     write(a[i],' ');
    halt;
   end;
  exit;
  end;
 j:=x; p:=0;
 for i:=n downto 1 do
  if not hash[i] then j:=i;
 for i:=x to n do
  p:=p+j*f[i];
 j:=x; q:=0;
 for i:=1 to n do
  if not hash[i] then j:=i;
 for i:=x to n do
  p:=p+j*f[i];
 if sum+p<goal then exit;
 if sum+q>goal then exit;
 //--------------------
 for i:=1 to n do
  if not hash[i] then
  begin
  a[x]:=i; hash[i]:=true;
  search(x+1,sum+f[x]*i);
  hash[i]:=false;
  end;
 end;
begin
 //openfile;
 readln(n,goal);
 f[1]:=1;
 for i:=2 to n do
  for j:=i downto 1 do
  f[j]:=f[j-1]+f[j];
 search(1,0);
 //closefile;
end.