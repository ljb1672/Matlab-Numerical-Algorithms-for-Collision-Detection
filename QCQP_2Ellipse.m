%% 求解两个椭圆之间的最短距离
%% 使用二次约束二次规划方法，在CVX中实现
%% 清屏清内存
clc;
clear;
%% 距离二次型矩阵
% x'* P0 * x + q0 * x + r0
%  1  0 -1  0
%  0  1  0 -1
% -1  0  1  0
%  0 -1  0  1
P0 = [ 1 , 0 , -1 , 0 ; 
       0 , 1 , 0 , -1 ; 
      -1 , 0 , 1 , 0 ; 
       0 ,-1 , 0 , 1 ];
q0 = [ 0 , 0 , 0 , 0 ]';
r0 = 0;
%% 第一个椭圆，蓝色
% x'* P1 * x + q1 * x + r1
% 0.25  0  0  0
%   0  1  0  0
%   0  0  0  0
%   0  0  0  0
P1 = [ 0.25 , 0 , 0 , 0 ; 
          0 , 1 , 0 , 0 ; 
          0 , 0 , 0 , 0 ; 
          0 , 0 , 0 , 0 ];
q1 = [ -0.5 , 0 , 0 , 0 ]';
r1 = -0.75;
%% 第二个椭圆，绿色
% x'* P1 * x + q1 * x + r1
%   0  0    0  0
%   0  0    0  0
%   0  0  5/8  3/8
%   0  0  3/8  5/8
P2 = [  0 , 0 , 0 , 0 ;  
        0 , 0 , 0 , 0 ; 
        0 , 0 , 0.625 , 0.375 ; 
        0 , 0 , 0.375 , 0.625 ];
q2 = [ 0 , 0 , -5.5 , -6.5 ]';
r2 = 17.5;
%
n = 4;
%% cvx
fprintf( 1 , '计算 QCQP 的最优值...\n');

cvx_begin 
    cvx_precision best            % 设置显示高精度数据
    cvx_solver sedumi             % 显示求解结果
    variable x( n )
    minimize ( quad_form( x , P0 ) + q0' * x + r0 );  % 目标函数
    subject to
    quad_form( x , P1 ) + q1' * x + r1 <= 0;  % 第一个二次约束
    quad_form( x , P2 ) + q2' * x + r2 <= 0;  % 第二个二次约束
cvx_end
%显示结果
format long;
display( sqrt( cvx_optval ));
display( sqrt( quad_form( x , P0 ) + q0' * x + r0 ));
display( x );

%% 画椭圆和的直线
% 第一个蓝色椭圆
h = ezplot( '0.25 * x^2 + y^2 - 0.5 * x  = 0.75 ' );
set( h , 'Color' , 'Blue' , 'LineWidth' , 2 );%, '' , 
hold on;
% 第二个绿色椭圆
h = ezplot( '0.625 * x^2 + 0.75 * x * y + 0.625 * y^2 - 5.5 * x - 6.5 * y = -17.5 ' );
set( h , 'Color' , 'Green' , 'LineWidth' , 2 );
hold on;
% 第三个红色直线
h = line([ x( 1 ) , x( 3 )],[ x( 2 ) , x( 4 )]);
set( h , 'Color' , 'Red' );
% xy坐标轴相等，范围，显示坐标网格
axis equal;
axis([ -3 5 -2 6 ]);
grid on;
%GridColor( 0.15 , 0.15 , 0.15 );


