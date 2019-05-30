program poj2227;
 const maxn=305; maxm=305;
       dx:array[1..4] of longint=(1,0,-1,0);
       dy:array[1..4] of longint=(0,1,0,-1);
 type arr=record
  x,y,h:longint;
  end;

 var i,j,n,m,l,r,k:longint;
 a:array[0..maxn,0..maxn] of longint;
 hash:array[0..maxn,0..maxm] of boolean;
 heap:array[1..maxn*maxn+1000] of arr;
 tot,ans:longint;
 p:arr;
procedure openfile;
 begin
 assign(input,'poj2227.in');
 assign(output,'poj2227.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure init;
 begin
 readln(m,n);
 for i:=1 to n do
  for j:=1 to m do
  read(a[i][j]);
 end;
procedure swap(i,j:longint);
 var t:Arr;
 begin
 t:=heap[i]; heap[i]:=heap[j]; heap[j]:=t;
 end;
procedure add(x,y:longint);
 var i,p:longint;
 begin
 inc(tot);
 heap[tot].x:=x; heap[tot].y:=y; heap[tot].h:=a[x,y];
 hash[x,y]:=true;
 i:=tot; p:=i div 2;
 while p>=1 do
  begin
  if heap[i].h<heap[p].h then
   swap(i,p)
  else break;
  i:=p;
  p:=i div 2;
  end;
 end;
procedure del;
 var p,q,i,r:longint;
 begin
  swap(1,tot);
  dec(tot);
  i:=1;
  while true do
   begin
   p:=i*2; q:=i*2+1;
   if p>tot then break;
   r:=i;
   if heap[p].h>heap[r].h then r:=p;
   if (q<=tot)and(heap[q].h<heap[r].h) then r:=q;
   if r=i then break;
   swap(i,r);
   i:=r;
   end;
 end;
procedure dfs(x,y:longint);
 var i,j,nx,ny:longint;
 begin
 for i:=1 to 4 do
  begin
   nx:=x+dx[i]; ny:=y+dy[i];
   if (nx>n)or(nx<=0)or(ny>m)or(ny<=0) then continue;
   if not hash[nx,ny] then
    begin
    hash[nx,ny]:=true;
    if a[nx,ny]<=k then
     begin ans:=ans+k-a[nx,ny]; dfs(nx,ny); end
     else add(nx,ny);
    end;
  end;
 end;
begin
// openfile;
 init;
 fillchar(hash,sizeof(hash),false);
 tot:=0;
 for i:=1 to n do add(i,1);
 for i:=1 to n do add(i,m);
 for j:=2 to m-1 do add(1,j);
 for j:=2 to m-1 do add(n,j);
//--------------------------
 while tot>0 do
  begin
  p:=heap[1];
  del;
  k:=p.h;
  dfs(p.x,p.y);
  end;
 writeln(ans);
 //closefile;
end.