program poj3256;
 type link=^node;
      node=record
      r:longint;
      next:link;
      end;
 const maxn=100+5; maxm=1000+10;
 var i,j,n,m,l,r,k,ans:longint;
     count:array[1..maxn] of longint;
     e:array[1..maxn] of link;
     a:array[1..maxn] of longint;
     hash:array[1..maxn] of boolean;
     p,q:link;
procedure openfile;
 begin
 assign(input,'poj3256.in');
 assign(output,'poj3256.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure dfs(x:longint);
 var p:link;
 begin
  hash[x]:=true; inc(count[x]);
  p:=e[x];
  while p<>nil do
   begin
   if not hash[p^.r] then dfs(p^.r);
   p:=p^.next;
   end;
 end;
begin

 readln(k,n,m);
 for i:=1 to k do
  read(a[i]);
 for i:=1 to n do
  e[i]:=nil;
 for i:=1 to m do
  begin
  readln(l,r);
  new(p); p^.r:=r; p^.next:=e[l]; e[l]:=p;
  end;
 for i:=1 to k do
  begin
   fillchar(hash,sizeof(hash),false);
   dfs(a[i]);
  end;
 for i:=1 to n do
  if count[i]=k then
  inc(ans);
 writeln(ans);

end.