package SHA256test;

import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

import SHA256test.SHA256;

public class SHA256Test {
    public static void main(String[] args) throws NoSuchAlgorithmException {
        String pwd = "1234";
        String crypwd = SHA256.encrypt(pwd);
        System.out.println("입력된 비밀번호 : " + pwd);
        System.out.println("암호화된 비밀번호 : "+crypwd);
        System.out.println("암호화된 비밀번호 글자수 : "+crypwd.length());

        Scanner sc = new Scanner(System.in);
        System.out.print("암호입력 : ");
        String pwd2 = sc.nextLine();
        String crypwd2 = SHA256.encrypt(pwd2);
        if(crypwd2.equals(crypwd)) {
            System.out.println("비밀번호 일치");
        } else {
            System.out.println("비밀번호 불일치");
        }
    }
}