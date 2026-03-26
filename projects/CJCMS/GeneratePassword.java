import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class GeneratePassword {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // 生成 admin123 的 BCrypt 哈希
        String hashedPassword = encoder.encode("admin123");
        
        System.out.println("Original password: admin123");
        System.out.println("BCrypt hash: " + hashedPassword);
        System.out.println("");
        System.out.println("SQL Update statement:");
        System.out.println("UPDATE CJ_ADM_ADMINISTRATOR SET PASSWORD_HASH = '" + hashedPassword + "' WHERE USERNAME = 'admin';");
    }
}
