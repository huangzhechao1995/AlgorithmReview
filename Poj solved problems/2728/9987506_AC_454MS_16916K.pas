Const
MaxN = 1010 ;
Limit = 10e-5 ;
Type
Point = Record
         x , y , h : Longint ;
       End ;
Side = Record
        Cost , Dist : Double ;
       End ;
Var
P : Array[ 0..MaxN ] of Point ;
S : Array[ 0..MaxN , 0..MaxN ] of Side ;
Pre : Array[ 0..MaxN ] of Longint ;
F : Array[ 0..MaxN ] of Double ;
V : Array[ 0..MaxN ] of Boolean ;
N : Longint ;
Ans , Delta : Double ;

Procedure Gf_Init;
Var  i , j : Longint ;
Begin
Readln( N ) ; If ( N = 0 ) Then Halt ;
For i := 1 To N Do
  With P[ i ] Do
   Readln( x , y , h ) ;
Fillchar( S , Sizeof(S) , 0 ) ;
For i := 1 To N Do
  For j := i+1 To N Do
   Begin
    S[ i,j ].Dist := Sqrt( Sqr( P[i].x - P[j].x ) + Sqr( P[i].y - P[j].y ) ) ;
    S[ i,j ].Cost := Abs( P[i].h - P[j].h ) ;
    S[ j,i ] := S[ i,j ] ;
    //Writeln( 'i ' , i , ' j ' , j , ' dist ' , S[i,j].dist:0:3 , ' cost ' , s[i,j].cost:0:3 ) ;
   End;
End;

Function Gf_Prim( Ans : Double ) : Double ;
Var  Time , i , Minn : Longint ;
     Min , Tot_Dist , Tot_Cost , Tmp : Double ;
Begin
For i := 2 To N Do F[ i ] := MaxLongint ; F[ 1 ] := 0 ;
Fillchar( Pre , Sizeof(Pre) , 0 ) ; Fillchar( V , Sizeof(V) , False ) ;
Tot_Dist := 0 ; Tot_Cost := 0 ; Tmp := 0 ;
For Time := 1 To N Do
  Begin
   Min := MaxLongint ;
   For i := 1 To N Do
    If ( Not V[ i ] ) And ( F[ i ] < Min ) Then
     Begin
      Min := F[ i ] ; Minn := i ;
     End;
   V[ Minn ] := True ; Tmp := Tmp + Min ;
   Tot_Dist := Tot_Dist + S[ Pre[Minn],Minn ].Dist ; Tot_Cost := Tot_Cost + S[ Pre[Minn],Minn ].Cost ;
   For i := 1 To N Do
    If ( Not V[ i ] ) And ( S[ Minn,i ].Cost - S[ Minn,i ].Dist * Ans < F[ i ] ) Then
     Begin
      F[ i ] := S[ Minn,i ].Cost - S[ Minn,i ].Dist * Ans ; Pre[ i ] := Minn ;
     End;
  End;
Delta := Tmp ; Exit( Tot_Cost / Tot_Dist ) ;
End;

Procedure Gf_Work;
Begin
Ans := 0 ;
Repeat
  Ans := Gf_Prim( Ans ) ;
Until ( Abs( Delta ) <= Limit ) ;
End;

Procedure Gf_Print;
Begin
Writeln(  Ans : 0 : 3  ) ;
End;

Begin
While ( True ) Do
  Begin
   Gf_Init;
   Gf_Work;
   Gf_Print;
  End;
End.