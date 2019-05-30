program poj1716;
 const maxn=10000+50;
 type link=^node;
 node=record
  r,w:longint;
  next:link;
 end;
 var i,j,n,m,l,r,k:longint;
 hash:array[-1..maxn] of boolean;
 dis:array[-1..maxn] of longint;
 line:array[-1..maxn] of longint;
 map:array[-1..maxn] of link;
 p,q:link;  tot:longint;
procedure openfile;
 begin
 assign(input,'poj1716.in');
 assign(output,'poj1716.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure spfa;
 var x,i,k:longint; p:link;
 begin
 fillchar(dis,sizeof(dis),128);
 hash[-1]:=true;
 dis[-1]:=0;
 line[1]:=-1; l:=1; r:=1;
 while l<=r do
  begin
  x:=line[(l-1)mod maxn+1]; hash[x]:=false; inc(l);
  p:=map[x];
  while p<>nil do
   begin
   i:=p^.r; k:=p^.w;
   if dis[i]<k+dis[x] then
    begin
    dis[i]:=k+dis[x];
    if hash[i]=false then
     begin
     hash[i]:=true;
     inc(r);
     line[(r-1)mod maxn+1]:=i;
     end;
    end;
   p:=p^.next;
   end;
  end;
 end;
begin
// openfile;
 readln(n);
 for i:=-1 to maxn do
  map[i]:=nil;
 for i:=1 to n do
  begin
  readln(l,r);
  dec(l);
  new(p);
  p^.r:=r; p^.w:=2;
  p^.next:=map[l]; map[l]:=p;
  if r>tot then tot:=r;
  end;
 for i:=-1 to tot-1 do
  begin
  new(p); p^.r:=i+1; p^.w:=0; p^.next:=map[i]; map[i]:=p;
  new(p); p^.r:=i;  p^.w:=-1;p^.next:=map[i+1]; map[i+1]:=p;
  end;
 spfa;
 writeln(dis[tot]);
// closefile;
end.
