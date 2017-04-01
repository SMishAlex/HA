float w[3][4];
//E-h2*J
w[0][0] = 1+h*b[0];
w[0][2] = 4*h;

w[1][0] = 4*h;
w[1][1] = 1+h*b[0];

w[2][1] = 4*h;
w[2][2] = 1+h*b[0];

//original func* step
w[0][3] = h*(-b[0]*x[0]-4*(x[1]+x[2])-x[1]*x[1]);
w[1][3] = h*(-b[0]*x[1]-4*(x[0]+x[2])-x[2]*x[2]);
w[2][3] = h*(-b[0]*x[2]-4*(x[1]+x[0])-x[0]*x[0]);

float tol = 1e-12;
float dx = 2*tol;

int nmax = 10;
int n = 0;
//öèêë ïî Íüþòîíàì
while ((dx > tol)&&(n < nmax)){

	w[0][1] = h*(4+2*x[1]);
	w[1][2] = h*(4+2*x[2]);
	w[2][0] = h*(4+2*x[0]);

	w[0][3] = x0[0] - x1[0] + h*(-b[0]*x[0]-4*(x[1]+x[2])-x[1]*x[1]);
	w[1][3] = x0[1] - x1[1] + h*(-b[0]*x[1]-4*(x[0]+x[2])-x[2]*x[2]);
	w[2][3] = x0[2] - x1[2] + h*(-b[0]*x[2]-4*(x[1]+x[0])-x[0]*x[0]);

	int HEIGHT = 3;
	int  WIDTH = 4;
	int k; int i; int j; float t; float d;

	for(k = 0; k <= HEIGHT-2; k++){
		int	l = k;
		for( i = k+1;  i<= HEIGHT-1; i++){
					if( abs(w[i][k]) > abs(w[l][k]) ){
						l = i;
			}
	   }
			if (l != k){
				for( j = 0; j <= WIDTH-1; j++){
					if ((j == 0) || (j >= k)){
						t = w[k][j];
						w[k][j] = w[l][j];
						w[l][j] = t;
					}
				}
			}
			
			d = 1.0 / w[k][k];
			for( i=(k+1); i <=(HEIGHT-1); i++){
				if (w[i][k] == 0){
					continue;
				}
				t = w[i][k] * d;
				for ( j = k; j <= (WIDTH-1); j++) {
					if (w[k][j] != 0){
						w[i][j] = w[i][j] - t * w[k][j];
					}
				}
			}
		}

		for( i=(HEIGHT); i >= 2; i--){ 
			for( j=1; j <= i-1; j++){
				t = w[i - j - 1][i - 1]/w[ i -1][i - 1];
				w[i-j - 1][ WIDTH- 1] = w[i-j -1][ WIDTH -1] - t*w[i - 1][ WIDTH -1];
			}
			w[i-1][ WIDTH-1] = w[i - 1][ WIDTH - 1]/w[ i -1][i - 1];
		}
		w[0][ WIDTH - 1] = w[0][ WIDTH -1]/w[0][0];

		
		x1[0] =x[0]+ w[0][WIDTH - 1];
		x1[1] = x[1]+w[1][WIDTH - 1];
		x1[2] = x[2]+w[2][WIDTH - 1];

	dx = sqrt((x1[0] - x[0])**2 + (x1[1] - x[1])**2 + (x1[2] - x[2])**2);
	n++;

	x[0] = x1[0]; x[1] = x1[1]; x[2] = x1[2];

}
