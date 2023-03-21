public class lab1 {

   public static void main (String [] argv) {
      System.out.println("12: x & (x-1) == 0 iff x is a power of 2");
      int x= 32;
      if ( (x & (x-1)) == 0) System.out.println(x+" is power of 2");
      else System.out.println(x+ " is not a power of 2");
      x=34;
      if ( (x & (x-1)) == 0) System.out.println(x+" is power of 2");
      else System.out.println(x+ " is not a power of 2");
   
      //13
      long expmask = 0b11111111111L << 52;
      long shiftedExp = Double.doubleToLongBits(-30.0) & expmask;
      long biasedExp = shiftedExp >>> 52;
      long exp = biasedExp - 1023;
      System.out.println(" Q13 The exponent for -30 is "+exp);
   
      //14
   
      for (float f: new float[] {+20.0f, -30.0f, -9.6e-26f}) {
         char plus = '+';
         int myPlus = ((int) plus) << 23;
         int myMask = ~( 0b11111111 << 23);
         int ibits = Float.floatToIntBits(f);
         int new_ibits = (ibits & myMask) | myPlus;
         float newF = Float.intBitsToFloat(new_ibits);
         System.out.println("Q14 before "+ f + " after " + newF);
      }
   
      // Q15
      for (float f: new float[] {-125f, +234.12f}) {             
         int signbitMask = 0x80000000;
         int fBits = Float.floatToIntBits(f);
         fBits ^= signbitMask; // flip sign
         biasedExp = (fBits & ( 0b11111111 << 23)) >>> 23;
         biasedExp -= 3;
         int myMask = ~( 0b11111111 << 23);
         fBits &= myMask; // kill old exponent field
         fBits |= (biasedExp << 23); // insert new biased exponent
         float newF = Float.intBitsToFloat(fBits);
         System.out.println("Q15 "+ f + " ==> "+ newF + "and f/(-8) = "+ (f/-8));
      }
   
      //Q 16
      for (double dd: new double[] {+125, +234.12}) {
         double d = dd;
         long minus3_in_11bits = 0b11111111101L; 
         long C =  minus3_in_11bits << 52 ;
         d = Double.longBitsToDouble(Double.doubleToLongBits(d)+C);
         System.out.println("Q16 "+ dd + " ==> "+ d);
      }
   }
   /**
java lab1
12: x & (x-1) == 0 iff x is a power of 2
32 is power of 2
34 is not a power of 2
The exponent for -30 is 4
Q14 before 20.0 after 6.4623485E-26
Q14 before -30.0 after -9.693523E-26
Q14 before -9.6E-26 after -9.6E-26
Q15 -125.0 ==> 15.625and f/(-8) = 15.625
Q15 234.12 ==> -29.265and f/(-8) = -29.265
Q16 125.0 ==> -15.625
Q16 234.12 ==> -29.265
    **/


}
