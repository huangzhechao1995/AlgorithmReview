program poj3252;
 const maxl=35;
 var i,j,n,m,p,q,l,r,k:longint;
 c:array[0..maxl,0..maxl] of int64;
 a,b,s:array[0..maxl] of longint;
 bot,top:longint;
 ans1,ans2:longint;
procedure openfile;
 begin
 assign(input,'poj3252.in');
 assign(output,'poj3252.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;

procedure work(p:longint; var ans:longint);
 var i,j,k,r,t:longint;

 procedure search(x:longint; flag:boolean);
  var i,j,down:longint;
  begin
  if x>l then exit;
  if flag then
   begin
   if b[x]=1 then
    begin
    down:=(1+l)div 2-(x-s[x-1]);
   // if down>=0 then
    for i:=down to (l-x) do
    if i>=0 then
     ans:=ans+c[l-x,i];
    end;
   search(x+1,flag);
   end;
  end;

 begin
 if p=-1 then begin ans:=-1; exit; end;
 k:=p;
 l:=0;
 while k<>0 do
  begin
  inc(l);
  b[l]:=k and 1;
  k:=k shr 1;
  end;
 for i:=1 to l div 2 do
  begin
  t:=b[i]; b[i]:=b[l-i+1]; b[l-i+1]:=t;
  end;
 for i:=1 to l do
  s[i]:=s[i-1]+b[i];
 if (p<>0){and(b[l]=0)} then
 if l>=s[l]*2 then inc(ans);
 for i:=1 to l-1 do
  begin
  for j:=(i+1)div 2 to i-1 do
   ans:=ans+c[i-1,j];
  end;
 search(2,true);
 end;

begin
// openfile;
//---------------------
 c[0,0]:=1;
 c[1,0]:=1; c[1,1]:=1;
 for i:=2 to 35 do
  begin
  c[i,0]:=1;
  for j:=1 to i do
   c[i,j]:=c[i-1,j]+c[i-1,j-1];
  end;
//---------------------
 readln(bot,top);
 work(bot-1,ans1);
 work(top,ans2);
//---------------------
 writeln(ans2-ans1);
// closefile;
end.
