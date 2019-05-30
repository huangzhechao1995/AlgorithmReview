program post;
var i,j,n,m,k,p,q,l,t:longint;
 f:array[0..500,0..100] of longint;
 dis:array[1..500,1..500] of longint;
 a:array[1..500] of longint;
function min(a,b:longint):longint;
 begin
  if (b<a)or(a=0) then min:=b else min:=a;
 end;
begin
// assign(input,'post.in');
// assign(output,'post.out');
//  reset(input);
 // rewrite(output);
 read(n,m);
 for i:=1 to n do
 read(a[i]);
 for i:=1 to n do
  for j:=i+1 to n do
   begin
    t:=(i+j) div 2;
    for k:=i to j do
    inc(dis[i,j],abs(a[k]-a[t]));
   end;
 for i:=1 to n do
  f[i,1]:=dis[1,i];

 for i:=1 to n do
  for j:=2 to min(i,m) do
   begin
    for k:=1 to i do
     if i-k>=j-1 then
     begin
      f[i,j]:=min(f[i,j],f[i-k,j-1]+dis[i-k+1,i]);
     end;
   end;
 writeln(f[n,m]);
// close(input);
// close(output);
end.