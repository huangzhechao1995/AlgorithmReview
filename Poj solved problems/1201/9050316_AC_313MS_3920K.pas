program poj1201;
 const maxn=50000+100;
 type link=^node;
  node=record
  r,w:longint;
  next:link;
  end;
 var i,j,k,m,l,r:longint;
 p,q:link;
 map:array[-1..maxn] of link;
 dis,line:array[-1..maxn] of longint;
 hash:array[-1..maxn] of boolean;
 tot:longint;
procedure openfile;
 begin
 assign(input,'poj1201.in');
 assign(output,'poj1201.out');
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
 l:=1; r:=1; line[1]:=-1;
 hash[-1]:=true; dis[-1]:=0;
 while l<=r do
  begin
  x:=line[(l-1)mod maxn+1]; hash[x]:=false; inc(l);
  p:=map[x];
  while p<>nil do
   begin
   i:=p^.r; k:=p^.w;
   if dis[i]<dis[x]+k then
    begin
    dis[i]:=dis[x]+k;
    if not hash[i] then
     begin
     hash[i]:=true;
     inc(r); line[(r-1)mod maxn+1]:=i;
     end;
    end;
   p:=p^.next;
   end;
  end;
 end;
begin
// openfile;
 readln(m);
 for i:=-1 to maxn do
  map[i]:=nil;
 for i:=1 to m do
  begin
  readln(l,r,k); if r>tot then tot:=r;
  dec(l);
  new(p); p^.r:=r; p^.w:=k; p^.next:=map[l]; map[l]:=p;
  end;
 for i:=-1 to tot-1 do
  begin
  new(p); p^.r:=i+1; p^.w:=0; p^.next:=map[i]; map[i]:=p;
  new(p); p^.r:=i; p^.w:=-1; p^.next:=map[i+1]; map[i+1]:=p;
  end;
 spfa;
 writeln(dis[tot]);
// closefile;
end.