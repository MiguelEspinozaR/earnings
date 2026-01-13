package com.miky.model;

public class Split {
    public static void split(int monto, int tasaAhorro, int tasaObjetivo){
		int [] resultado = new int[3];
		resultado[0] = monto * tasaAhorro / 100;
		resultado[1] = monto * tasaObjetivo / 100;
		resultado[2] = monto - resultado[0] - resultado[1];
		System.out.println("Ahorro: " + resultado[0]);
		System.out.println("Objetivo: " + resultado[1]);
		System.out.println("Gasto libre: " + resultado[2]);
    }

	public static void split2(int monto, int... tasas){
		int [] splits = new int[tasas.length];
		for(int i = 0; i<tasas.length; i++){
			splits[i] = tasas[i] * monto / 100;
			System.out.println("Split " + (i+1) + ": " + splits[i]);
		}
	}
}