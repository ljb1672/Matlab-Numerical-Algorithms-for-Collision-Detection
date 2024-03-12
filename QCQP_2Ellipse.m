%% ���������Բ֮�����̾���
%% ʹ�ö���Լ�����ι滮��������CVX��ʵ��
%% �������ڴ�
clc;
clear;
%% ��������;���
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
%% ��һ����Բ����ɫ
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
%% �ڶ�����Բ����ɫ
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
fprintf( 1 , '���� QCQP ������ֵ...\n');

cvx_begin 
    cvx_precision best            % ������ʾ�߾�������
    cvx_solver sedumi             % ��ʾ�����
    variable x( n )
    minimize ( quad_form( x , P0 ) + q0' * x + r0 );  % Ŀ�꺯��
    subject to
    quad_form( x , P1 ) + q1' * x + r1 <= 0;  % ��һ������Լ��
    quad_form( x , P2 ) + q2' * x + r2 <= 0;  % �ڶ�������Լ��
cvx_end
%��ʾ���
format long;
display( sqrt( cvx_optval ));
display( sqrt( quad_form( x , P0 ) + q0' * x + r0 ));
display( x );

%% ����Բ�͵�ֱ��
% ��һ����ɫ��Բ
h = ezplot( '0.25 * x^2 + y^2 - 0.5 * x  = 0.75 ' );
set( h , 'Color' , 'Blue' , 'LineWidth' , 2 );%, '' , 
hold on;
% �ڶ�����ɫ��Բ
h = ezplot( '0.625 * x^2 + 0.75 * x * y + 0.625 * y^2 - 5.5 * x - 6.5 * y = -17.5 ' );
set( h , 'Color' , 'Green' , 'LineWidth' , 2 );
hold on;
% ��������ɫֱ��
h = line([ x( 1 ) , x( 3 )],[ x( 2 ) , x( 4 )]);
set( h , 'Color' , 'Red' );
% xy��������ȣ���Χ����ʾ��������
axis equal;
axis([ -3 5 -2 6 ]);
grid on;
%GridColor( 0.15 , 0.15 , 0.15 );


