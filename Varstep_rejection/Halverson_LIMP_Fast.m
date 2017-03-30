float w[3][4];
int k; int i; int j; float t; float d; float h2;

h2=h*0.5;
//E-h2*J
w[0][0] = 1+h2*b[0];
w[0][1] = h2*(4+2*x[1]);
w[0][2] = 4*h2;

w[1][0] = 4*h2;
w[1][1] = 1+h2*b[0];
w[1][2] = h2*(4+2*x[2]);

w[2][0] = h2*(4+2*x[0]);
w[2][1] = 4*h2;
w[2][2] = 1+h2*b[0];

//original func* step
w[0][3] = h*(-b[0]*x[0]-4*(x[1]+x[2])-x[1]*x[1]);
w[1][3] = h*(-b[0]*x[1]-4*(x[0]+x[2])-x[2]*x[2]);
w[2][3] = h*(-b[0]*x[2]-4*(x[1]+x[0])-x[0]*x[0]);


int HEIGHT = 3;
int  WIDTH = 4;
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

    
    x[0] =x[0]+ w[0][WIDTH - 1];
    x[1] = x[1]+w[1][WIDTH - 1];
    x[2] = x[2]+w[2][WIDTH - 1];
