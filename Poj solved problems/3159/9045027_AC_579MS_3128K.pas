program poj3159;
 type link=^node;
 node=record
  r,w:longint;
  next:link;
  end;
 const maxn=30000+500; maxm=150000+1000;
 maxv=1000000000;
 var i,j,n,m,l,r,k:longint;
 map:array[1..maxn] of link;
 hash:array[1..maxn] of boolean;
 stack,dis:array[1..maxn] of longint;
 p,q:link;
procedure openfile;
 begin
 assign(input,'poj3159.in');
 assign(output,'poj3159.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure spfa;
 var x,i,k,top:longint; p:link;
 begin
 fillchar(dis,sizeof(dis),127);
 dis[1]:=0;
 top:=1;
 stack[top]:=1; hash[1]:=true;
 while top>0 do
  begin
  x:=stack[top]; hash[x]:=false;
  dec(top);
  p:=map[x];
  while p<>nil do
   begin
   i:=p^.r; k:=p^.w;
   if dis[x]+k<dis[i] then
    begin
    dis[i]:=dis[x]+k;
    if not hash[i] then
     begin
     inc(top); stack[top]:=i;
     hash[i]:=true;
     end;
    end;
   p:=p^.next;
   end;
  end;
 end;

begin
 read(n,m);
 for i:=1 to n do
  map[i]:=nil;
 for i:=1 to m do
  begin
  read(l,r,k);
  new(p);
  p^.r:=r; p^.w:=k;
  p^.next:=map[l];
  map[l]:=p;
  end;
 spfa;
 writeln(dis[n]);
end.
