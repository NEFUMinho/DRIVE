#include <Servo.h>

Servo myservo;  

int val7 = 37;   // variável que escreve no servo
//int val9 = 40;   // variável que escreve no servo
//int val8 = 110;   // variável que escreve no servo
//int val12 = 97;   // variável que escreve no servo
//int val2 = 78.5;   // variável que escreve no servo
//int val4 = 5;   // variável que escreve no servo
//int valor_lido = 0;   // variável que lê o valor do servo

void setup() {
  myservo.attach(7);   // aqui é para dizer ao servo a qual pino é que nos estamos a referir (se é digital e assim)
  Serial.begin(9600);  // configura a taxa de trasnferência (configura a taxa a que os dados são enviados)
  //calibracao();        // vamos usar esta função para descobrir os valores offset -> são os valores em que o servo motor está direito e aparece um desvio
}


void loop() {
    
  myservo.write(val7);               // escrever no servo(myservo.write(val) ) o val que começa como valor 0
  //myservo.write(val9);
  //myservo.write(val8);
  //myservo.write(val12);
  //myservo.write(val4);
  //myservo.write(val2);
  //delay(5);

  //val++;                      // a seguir vais ler o angulo que o servo tem, e escreves o valor na variavel valor_lido (valor_lido = myservo.read( ))

  //valor_lido = myservo.read();
  //Serial.println(valor_lido);           

  //if (val==181){
    //val = 0;
  //}
}

// Para veres esse valor lido vais escrever fazer print dele, 
// foi para isso que inicializaste o serial no inicio. depois disto tudo o val vai incrementando e uma vez que chega a
// 180 mete-se a 0 porque o servo não dá mais do que 180. Este codigo faz com que o servo rode a até 180 e volte a 0 sucessivamente.

// pin 9 - perna esquerda (anca)
// pin 12 - perna esquerda (joelho)
// pin 5 - perna esquerda (pé)    - o pin 5 não funciona - ligamos ao 4

// pin 6 - perna direita (anca)   - o pin 6 não funciona  - ligamos ao 7
// pin 8 - perna direita (joelho) 
// pin 3 - perna direita (pé)   - o pin 3 não funciona - ligamos ao 2


// os pins 2 e 4 e 7 e 10 e 11 e 13 funcionam
