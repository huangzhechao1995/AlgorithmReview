program poj1144;
 const maxn=100+10;
 var i,j,n,m,p,q,l,r,k:longint;
  map:array[1..maxn,1..maxn] of longint;
  dep,low,tot:array[1..maxn] of longint;
  hash:array[1..maxn] of boolean;
  ans,sign:longint;
procedure openfile;
 begin
 assign(input,'poj1144.in');
 assign(output,'poj1144.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure init;
 var c:char;
 i,j,l,r,p:longint;
 begin
 fillchar(hash,sizeof(hash),false);
 fillchar(map,sizeof(map),0);
 fillchar(tot,sizeof(tot),0);
 fillchar(dep,sizeof(dep),0);
 fillchar(low,sizeof(low),0);
 readln(n);
 if n=0 then
  halt;
 read(l);
 read(c);
// p:=0;
 while l<>0 do
  begin
  while (ord(c)<>10)and(ord(c)<>13) do
   begin
   read(j);
   map[j,l]:=1;
   map[l,j]:=1;
//   if (j=1)or(l=1) then inc(p);
   read(c);
   end;
  read(l);
  read(c);
  end;
// if p>=2 then inc(ans);
 end;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a) else exit(b);
 end;
procedure dfs(x:longint);
 var i,j:longint;
 begin
 inc(sign); dep[x]:=sign;
 low[x]:=sign;
 for i:=1 to n do
  if map[x,i]=1 then
  begin
  if dep[i]<>0 then
   low[x]:=min(low[x],dep[i]);
  if dep[i]=0 then
   begin
   inc(tot[x]);
   dfs(i);
   low[x]:=min(low[x],low[i]);
   if (x<>1)and(low[i]>=dep[x]) then hash[x]:=true;
   if (x=1)and(tot[x]>1) then hash[x]:=true;
   end;
  end;
 end;
begin
// openfile;
 repeat
 ans:=0;
 init;
 sign:=0;
 dfs(1);
 for i:=1 to n do
  if hash[i] then inc(ans);
 writeln(ans);
 until 0=1;
 //closefile;
end.