#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<time.h>
#include<string.h>
/*
 * =====================================================================================
 *
 *       Filename:  z2dis.c
 *
 *    Description:  cosmography, calculator,check by the website:
 *    				http://www.bo.astro.it/~cappi/cosmotools
 *
 *        Version:  1.0
 *        Created:  03/17/12 23:28:51
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Tang (), tangchao90908@sina.com
 *        Company:  KLA, Shanghai
 *
 * =====================================================================================
 */
#define h 0.70
#define N 100
#define c 2.99792458e+5
#define	Omiga_Lamda 0.7
#define	Omiga_k 0
#define	Omiga_m 0.3
double dis,z,Zin,E_z;
double t_Hubble,D_H,H0,D_C[N],D_c,D_cd,D_p,zrandom[N];
int main ( int argc, char *argv[] )
{
	if(argc==1)
	{
		z=1; // for interplotation
	}
	else
	{
		z=atof(argv[1]);
	}
//================================================
//	double D_p2[N];
//	double D_cd2[N];
//	double Zc,Zp;
//	double Zcd;
	double D_C;
	double comoving(double D_H,double D_C,double z);
//	double coordinate(double z,double zrandom[N],double D_C[N],double D_cd);
//	double proper(double z,double zrandom[N],double D_C[N],double D_p);
//	double lagr1(double *x,double *y,int n,double t);
//	printf("H0=%lfkms^-1Mpc^-1\n",100*h);
	H0=100*h;
	D_H=c/H0;
//================================================
	printf("%f\n",comoving(D_H,D_C,z));
	return 0;
}				/* ----------  end of function main  ---------- */

double f(double z)
{
	return 1/sqrt(Omiga_m*pow(1+z,3)+Omiga_k*pow(1+z,2)+Omiga_Lamda);
//	return 1/sqrt(0.27*pow(1+z,3)+0*pow(1+z,2)+0.73);
}
//================================================
double comoving(double D_H,double D_C,double z)
{
	double a,n0,eps,h0;
	double simps1(double a,double b,int n0,double eps,double h0,double(*f)());		//	simpson function
	double f(double z);	//	integrated  function
	srand((int)time(0));
	a=0.0;
	eps=1e-10;
	h0=1e-8;
	n0=4;
//================================================
		return D_H*simps1(a,z,n0,eps,h0,f);
}
double proper(double z,double zrandom[N],double D_C[N],double D_p)
{
	double lagr1(double *x,double *y,int n,double t);
	D_p=lagr1(zrandom,D_C,N,z)/(1+z);
	printf("%lf====Dp(z=%lf)\n",D_p,z);
	return (D_p);
}
double coordinate(double z,double zrandom[N],double D_C[N],double D_cd)
{
	double lagr1(double *x,double *y,int n,double t);
	D_c=lagr1(zrandom,D_C,N,z);
	D_cd=(1+z)*D_c;
	printf("%lf====Dc(z=%lf)\n",D_c,z);
	printf("%lf====Dcd(z=%lf)\n",D_cd,z);
	return (D_cd);
}
// 函数名：simps1
// 功能描述：变步长辛卜生求积分
// 输入参数：a 积分下限，b 积分上限,
//           n0 初始划分数
//           eps 精度要求
//           h0 最小步长
//           f 指向被积函数的指针
// 返回值：  积分近似值
//=========================================================*/
double simps1(double a,double b,int n0,double eps,double h0,double(*f)())
{
  int n,k;
  double z,z2,s,s2,h1,d,x;
  n = n0;                            /* 初始的划分数*/
  h1 = (b-a)/n;                       /* 求得初始步长*/
  z = ((*f)(a)+(*f)(b))/2.0;         /* 计算初始的积分值*/
  for(k=1; k<n; k++)
  {
    x = a+k*h1;
    z = z+(*f)(x);                   /* 累次求和*/
  }
  z = z*h1;                           /* 尽量减少乘法次数*/
  s = z;
  do
  {
    z2 = 0.0;
    for(k=0; k<n; k++)
    {
      x = a+(k+0.5)*h1;               /* 累加计算*/
      z2 = z2+(*f)(x);
    }
    z2 = (z+h1*z2)/2.0;
    s2 = (4.0*z2-z)/3.0;             /* 计算新的积分值*/
    d = fabs(s2-s);                  /* 计算两次积分值的差*/
    z = z2;
    s = s2;                          /* 更新积分值*/
    h1 = h1/2.0;                       /* 更新步长*/
    n = 2*n;                         /* 更新划分数*/
  }while((d>eps)&&(h1>h0));
  return(s);
}
/*======================================================
// 函数名：lagr1
// 功能描述：拉格朗日线性插值
// 输入参数：x 指向存放n个结点的数据的数组的指针
//           y 指向存放n个结点的函数值的数组的指针
//           n 结点个数。
//           t 指定的插值点
// 返回值：  在指定插值点的函数近似值
=========================================================*/
double lagr1(double *x,double *y,int n,double t)
{
	int i;
	double z;
	if((x==NULL)||(y==NULL))             /* 检测输入指针是否为空*/
	{
  		printf("Pointer is Null\n");
  		return(0.0);
	}
	if(n<1)                              /* 没有提供结点，返回0.0*/
		return(0.0);
	if(n==1)                             /* 只有一个结点，返回此函数值*/
		return(y[0]);
	i = 0;
	while((x[i]<t)&&(i<n))               /* 寻找合适的区间*/
  		i++;
  	i = i-1;
  	if(i < 1)
		i = 0;
	if(i > (n-2))
		i = n-2;
//	printf("lagr1: %d,%d\n",i,i+1);      /* 打印使用的区间*/
	z = (y[i]*(t-x[i+1]) - y[i+1]*(t-x[i]))/(x[i] - x[i+1]); /* 计算近似值*/
	return(z);
}
void write1(double a[],char name[],int length)
{
	int i;
	FILE *p;
	p=fopen(name,"w");
		for(i=0;i<length;i++)
			fprintf(p,"%8.8e\n",a[i]);
	fclose(p);
}
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
double read5(double d[],int length,int key)
{
	int i;
	FILE *fp;
	if(key==1)
	{
		if((fp=fopen("/Users/tang/astro/distance/zrandom1","r"))==NULL)
		{
			printf("faile\n");
			exit(0);
		}
	}
	if(key==2)
	{
		if((fp=fopen("/Users/tang/astro/tpcf/lengthp","r"))==NULL)
		{
			printf("faile\n");
			exit(0);
		}
	}
	if(key==3)
	{
		if((fp=fopen("/Users/tang/astro/tpcf/r0.dat1","r"))==NULL)
		{
			printf("faile\n");
			exit(0);
		}
	}
	if(key==4)
	{
		if((fp=fopen("/Users/tang/astro/tpcf/r0s.dat1","r"))==NULL)
		{
			printf("faile\n");
			exit(0);
		}
	}

	for(i=0;i<length;i++)
	{
			d[i]=0;
			fscanf(fp,"%lf",&d[i]);
	}
//		printf("\n");
	fclose(fp);
	return d[length];// not the name of the d[][] 
}
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
