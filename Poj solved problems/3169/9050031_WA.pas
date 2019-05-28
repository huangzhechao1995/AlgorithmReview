program poj3169;
 type link=^node;
  node=record
  r,w:longint;
  next:link;
  end;
 const maxn=1000+50; maxm=10000+100;
 var i,j,n,l,r,k:longint;
 ml,md:longint;
 map:array[1..maxn] of link;
 v,dis,line:array[1..maxn] of longint;
 hash:array[1..maxn] of boolean;
 p,q:link;
procedure openfile;
 begin
 assign(input,'poj3169.in');
 assign(output,'poj3169.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function spfa:boolean;
 var x,i,k:longint; p:link;
 begin
 fillchar(dis,sizeof(dis),128);
 line[1]:=1; l:=1; r:=1;  v[1]:=1;
 hash[1]:=true; dis[1]:=0;
 while l<=r do
  begin
   x:=line[(l-1)mod maxn+1]; hash[x]:=false; inc(l);
   p:=map[x];
   while p<>nil do
    begin
    i:=p^.r; k:=p^.w;
    if dis[x]+k>dis[i] then
     begin
     dis[i]:=dis[x]+k;
     if not hash[i] then
      begin
      inc(v[i]);
      if v[i]>n then exit(false);
      inc(r); line[(r-1)mod maxn+1]:=i;
      hash[i]:=true;
      end;
     end;
    p:=p^.next;
    end;
  end;
 exit(true);
 end;
begin
 //openfile;
 readln(n,ml,md);
 for i:=1 to n do
  map[i]:=nil;
 for i:=1 to n-1 do
  begin
  new(p); p^.r:=i+1; p^.w:=0; p^.next:=map[i]; map[i]:=p;
  end;
 for i:=1 to ml do
  begin
  readln(l,r,k);
  new(p); p^.r:=r; p^.w:=k; p^.next:=map[l]; map[l]:=p;
  end;
 for i:=1 to md do
  begin
  readln(l,r,k);
  new(p); p^.r:=l; p^.w:=-k; p^.next:=map[r]; map[r]:=p;
  end;
 if not spfa then writeln(-1)
  else if dis[n]=-2139062144   then writeln(-2)
 else writeln(dis[n]);
// closefile;
end.

