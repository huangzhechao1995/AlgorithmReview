program post;
 const maxn=300+10; maxm=30+10;
 var x,sum:array[0..maxn] of longint;
 cost:array[1..maxn,1..maxn] of longint;
 f,p:array[0..maxn,0..maxm] of longint;
 i,j,n,k,m,l,r,mid,q:longint;
procedure openfile;
 begin
 assign(input,'post.in');
 assign(output,'post.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;

begin
 //openfile;
 readln(n,m);
 for i:=1 to n do
  read(x[i]);
{ for i:=1 to n do
  sum[i]:=sum[i-1]+x[i];
 for i:=1 to n do
  begin
  mid:=i;
  for j:=i to n do
   begin
  // q:=(x[i]+x[j]) div 2;
  // if (abs(x[mid]-q)>abs(x[mid+1]-q))and(mid<j) then inc(mid);
   cost[i,j]:=x[mid]*(mid-i+1)-(sum[mid]-sum[i-1]);
   cost[i,j]:=cost[i,j]+sum[j]-sum[mid]-x[mid]*(j-mid);
   end;
  end; }
 for i:=1 to n do
  begin
  cost[i,i]:=0;
  for j:=i+1 to n do
   cost[i,j]:=cost[i,j-1]+x[j]-x[(i+j)shr 1];
  end;
 for i:=1 to n do
  begin
  f[i,1]:=cost[1,i];
  p[i,1]:=1;
  end;
 for j:=2 to m do
  begin
  p[n+1,j]:=n;
  for i:=n downto j+1 do
   begin
   f[i,j]:=maxlongint;
   for k:=p[i,j-1] to p[i+1,j] do
    begin
    q:=f[k,j-1]+cost[k+1,i];
    if q<f[i,j] then
     begin
     f[i,j]:=q;
     p[i,j]:=k;
     end;
    end;
   end;
  end;
 writeln(f[n,m]);
 //closefile;
end.