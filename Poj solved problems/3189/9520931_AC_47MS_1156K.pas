program poj3189;
 const maxn=1000+50; maxb=25;
var
 a,rank:array[1..maxn,1..maxb] of longint;
// len:array[1..maxn] of longint;
 visit:array[1..maxb] of boolean;
 match:array[1..maxb,0..maxn] of longint;
 limit:array[1..maxb] of longint;
 i,j,n,m,p,q,l,r,k:longint;
 b,ans:longint;
procedure openfile;
 begin
 assign(input,'poj3189.in');
 assign(output,'poj3189.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function dfs(x:longint):boolean;
 var i,j:longint;
 begin
  for i:=1 to b do
   begin
   if (not visit[i])and(rank[x][i]>=l)and(rank[x][i]<=r) then
    begin
    visit[i]:=true;
    if match[i][0]<limit[i] then
     begin
     inc(match[i][0]);
     match[i][match[i][0]]:=x;
     exit(true);
     end
    else
     begin
     for j:=1 to match[i][0] do
      begin
      if dfs(match[i][j]) then
       begin
       match[i][j]:=x;
       exit(true);
       end;
      end;
     end;
    end;
   end;
  exit(false);
 end;
function judge:boolean;
 var i,j:longint;
 begin
 for i:=1 to b do
  match[i][0]:=0;
 for i:=1 to n do
  begin
  fillchar(visit,sizeof(visit),false);
  if not dfs(i) then exit(false);
  end;
 exit(true);
 end;
begin

 readln(n,b);
 for i:=1 to n do
  for j:=1 to b do
  begin
  read(a[i,j]);
  rank[i,a[i,j]]:=j;
  end;
 for i:=1 to b do
  read(limit[i]);
 l:=1; r:=1; ans:=1000;
 while r<=b do
  begin
  if judge then
   begin
   if r-l+1<ans then ans:=r-l+1;
   inc(l);
   end
  else inc(r);
 end;
 writeln(ans);

end.
