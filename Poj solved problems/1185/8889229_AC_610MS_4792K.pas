program poj1185;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[1..100] of longint;
 f:array[1..100,1..100,1..100] of longint;
 stage,count:array[1..100] of longint;
 tot,ans:longint;
procedure openfile;
 begin
 assign(input,'poj1185.in');
 assign(output,'poj1185.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function calculate(x:longint):longint;
 begin
 calculate:=0;
 while x<>0 do
  begin
   calculate:=calculate+x and 1;
   x:=x shr 1;
  end;
 end;
function max(a,b:longint):longint;
 begin
 if a>b then exit(a) else exit(b);
 end;
procedure init;
 var i,j:integer;
   ch:char;
 begin
  readln(n,m);
  tot:=0;
  for i:=0 to 1 shl m-1 do
   begin
    if i and (i shl 1)<>0 then continue;
    if i and (i shl 2)<>0 then continue;
    inc(tot);
    stage[tot]:=i;
    count[tot]:=calculate(i);
   end;
  for i:=1 to n do
   begin
   for j:=1 to m do
    begin
    read(ch);
    if ch='H' then
     a[i]:=a[i]+ 1 shl (m-j);
    end;
   readln;
   end;
 end;
procedure DP;
 var i,j,k,p:longint;
 begin
 fillchar(f,sizeof(f),255);
 for i:=1 to tot do
  if a[1] and stage[i]=0 then f[1,i,1]:=count[i];
 for p:=2 to n do
  for i:=1 to tot do
   if stage[i] and a[p]=0 then
   for j:=1 to tot do
    if stage[i] and stage[j]=0 then
    for k:=1 to tot do
     if (stage[k] and stage[i]=0)and(stage[k] and stage[j]=0) then
      if f[p-1,j,k]<>-1 then
      f[p,i,j]:=max(f[p,i,j],f[p-1,j,k]+count[i]);
 end;
begin
// openfile;
 init;
 DP;
 ans:=-1;
 for i:=1 to tot do
  for j:=1 to tot do
   if stage[i]and stage[j]=0 then
   ans:=max(f[n,i,j],ans);
 writeln(ans);
 //closefile;
end.