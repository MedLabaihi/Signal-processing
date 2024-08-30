# Audio Encryption and Decryption with RSA and CRT

## Overview

This project demonstrates the use of the RSA encryption algorithm, combined with the Chinese Remainder Theorem (CRT), to encrypt and decrypt audio files. The project involves the following steps:
1. **Generating RSA keys and CRT parameters.**
2. **Reading an audio file.**
3. **Encrypting the audio samples using RSA with CRT.**
4. **Decrypting the encrypted audio back to its original form.**
5. **Saving plots of the encrypted and decrypted signals.**

The project is implemented in MATLAB and demonstrates key concepts in cryptography, including key generation, modular exponentiation, and CRT-based optimization.

## Files and Directory Structure

- `key_generation.m`: MATLAB script for generating RSA keys and CRT parameters.
- `encrypt_audio.m`: MATLAB script for encrypting the audio file.
- `decrypt_audio.m`: MATLAB script for decrypting the encrypted audio file.
- `audios/audio_Original.wav`: The original audio file to be encrypted.
- `audios/audio_Enc.wav`: The encrypted audio file.
- `audios/audio_Dec.wav`: The decrypted audio file, which should resemble the original.
- `plots/audio_signals.png`: Plot of the original and encrypted audio signals.
- `plots/decrypted_signal.png`: Plot of the decrypted audio signal.
- `README.md`: This file.

## Prerequisites

- MATLAB installed on your system.
- Basic understanding of MATLAB and cryptography concepts.

## Mathematical Background

### RSA Encryption

RSA (Rivest-Shamir-Adleman) is a widely used public-key cryptosystem that relies on the mathematical difficulty of factoring large integers. The encryption and decryption process involves the following steps:

1. **Key Generation**:
   - Select two distinct large prime numbers $\( p \)$ and $\( q \)$.
   - Compute the modulus $\( n = p \times q \)$.
   - Calculate Euler's Totient function $\( \phi(n) = (p-1) \times (q-1) \)$.
   - Choose an integer $\( e \)$ such that $\( 1 < e < \phi(n) \)$ and $\( \gcd(e, \phi(n)) = 1 \)$. The pair $\( (e, n) \)$ is the public key.
   - Calculate the private key $\( d \)$ such that $\( d \times e \equiv 1 \ (\text{mod} \ \phi(n)) \)$. This can be done using the extended Euclidean algorithm.

2. **Encryption**:
   - Convert the message $\( m \)$ into an integer $\( m \)$ where $\( 0 \leq m < n \)$.
   - The ciphertext $\( c \)$ is computed using modular exponentiation:


     $$c = m^e \ (\text{mod} \ n)$$


3. **Decryption**:
   - The plaintext $\( m \)$ is recovered by:

     $$m = c^d \ (\text{mod} \ n)$$
     
### Chinese Remainder Theorem (CRT)

The Chinese Remainder Theorem is a method used to solve systems of simultaneous congruences with pairwise coprime moduli. In the context of RSA, CRT can be used to optimize the decryption process:

1. **Precompute**:
   - Compute $\( dp = d \ (\textbf{mod} \ (p-1)) \)$.
   - Compute $\( dq = d \ (\textbf{mod} \ (q-1)) \)$.
   - Compute the modular inverse $\( q_{\text{inv}} = q^{-1} \ (\text{mod} \ p) \)$.

2. **Decryption Using CRT**:
   - Calculate:

   $$m_1 = c^{dp} \ (\text{mod} \ p)$$
   
   $$m_2 = c^{dq} \ (\text{mod} \ q)$$
   
   - Combine the results:

     $$h = q_{\text{inv}} \times (m_1 - m_2) \ (\text{mod} \ p)$$

     $$m = m_2 + h \times q$$
     
   - This approach significantly speeds up decryption since it reduces the size of the numbers involved in the exponentiation.

### Complexity Analysis

#### RSA Encryption and Decryption Complexity

1. **Encryption Complexity**:
   - Modular exponentiation, which is the primary operation in RSA encryption, has a time complexity of $\( O(\log e) \)$, where $\( e \)$ is the public exponent. This is due to the exponentiation by squaring algorithm used for efficient computation.
   - For each audio sample, the complexity is $\( O(\log e) \)$, and with $\( n \)$ samples, the overall complexity is $\( O(n \log e)\)$.

2. **Decryption Complexity**:
   - Decryption using RSA without CRT involves computing $\( c^d \ (\text{mod} \ n) \)$, which has a time complexity of $\( O(\log d) \)$. 
   - With CRT optimization, the complexity is reduced to $\( O(\log dp) + O(\log dq) \)$, where $\( dp \)$ and $\( dq \)$ are the reduced exponents. This makes decryption significantly faster.
   - For each audio sample, the complexity is $\( O(\log dp + \log dq) \)$, and with $\( n \)$ samples, the overall complexity is $\( O(n (\log dp + \log dq)) \)$.

#### Modular Exponentiation Complexity

- The `modExp` function used for both encryption and decryption relies on exponentiation by squaring, which has a time complexity of $\( O(\log \text{exp}) \)$, where `exp` is the exponent.

## How to Use

### 1. RSA Key and CRT Parameter Generation

1. **Run the key generation script**:

   ```matlab
   key_generation.m
   ```

   This script:
   - Defines two large prime numbers `p` and `q`.
   - Calculates `n`, the modulus for the RSA algorithm.
   - Computes Euler's Totient function `phi_n`.
   - Selects a public exponent `e` and calculates the private exponent `d`.
   - Computes the CRT parameters `dp`, `dq`, and `qinv`.

   The generated keys and CRT parameters are used in the encryption and decryption scripts.

### 2. Encryption

1. **Run the encryption script**:

   ```matlab
   encrypt_audio.m
   ```

   This script:
   - Reads the `audios/audio_Original.wav` audio file.
   - Scales and shifts the audio data to prepare it for encryption.
   - Encrypts each sample using RSA with CRT optimization.
   - Saves the encrypted data to `audios/audio_Enc.wav`.

2. **Plot and Save the Encrypted Signal**:

   After encryption, the script generates a plot showing the original and encrypted audio signals and saves it as `plots/audio_signals.png`:

   ```matlab
   figure;
   subplot(2,1,1);
   plot(x);
   title('Original Signal');

   subplot(2,1,2);
   plot(c1);
   title('Encrypted Signal');
   saveas(gcf, 'plots/audio_signals.png');
   ```

### 3. Decryption

1. **Run the decryption script**:

   ```matlab
   decrypt_audio.m
   ```

   This script:
   - Reads the `audios/audio_Enc.wav` encrypted audio file.
   - Decrypts each sample using RSA with CRT optimization.
   - Reverses the scaling and shifting applied during encryption.
   - Saves the decrypted data to `audios/audio_Dec.wav`.

2. **Plot and Save the Decrypted Signal**:

   After decryption, the script generates a plot showing the decrypted audio signal and saves it as `plots/decrypted_signal.png`:

   ```matlab
   figure;
   plot(m20);
   title('Decrypted Signal');
   saveas(gcf, 'plots/decrypted_signal.png');
   ```

### 4. Comparison

- Compare the `audios/audio_Dec.wav` file with the original `audios/audio_Original.wav` file to evaluate the effectiveness of the encryption and decryption process.

## Code Breakdown

### RSA Key Generation (`key_generation.m`)

- **Prime Selection**: The script selects two large primes, `p` and `q`.
- **Modulus and Totient Calculation**: Computes `n = p * q` and `phi_n = (p-1) * (q-1)`.
- **Key Calculation**: The public exponent `e` is chosen, and the private exponent `d` is calculated using the modular inverse.
- **CRT Parameters**: Computes `dp`, `dq`, and `qinv` for CRT-based decryption optimization.

### Encryption (`encrypt_audio.m`)

- **Reading the Audio**: The script reads the original audio file using `audioread`.
- **Scaling and Shifting**: The audio data is scaled and shifted to prepare it for encryption.
- **Encryption**: The RSA encryption algorithm is applied using modular exponentiation.
- **Saving Encrypted Audio**: The encrypted audio is saved as `audios/audio_Enc.wav`.
- **Saving Encrypted Signal Plot**: The plot of the encrypted signal is saved as `plots/audio_signals.png`.

### Decryption (`decrypt_audio.m`)

- **Reading the Encrypted Audio**: The script reads the encrypted audio file.
- **Decryption**: The RSA decryption algorithm with CRT

 optimization is applied.
- **Reversing Scaling and Shifting**: The decrypted data is rescaled and shifted back.
- **Saving Decrypted Audio**: The decrypted audio is saved as `audios/audio_Dec.wav`.
- **Saving Decrypted Signal Plot**: The plot of the decrypted signal is saved as `plots/decrypted_signal.png`.

## Why the Decryption Does Not Return the Exact Original Signal

The encryption process involves scaling the audio signal by multiplying it with a large number (`100000`), and then truncating the fractional part using the `fix` function. This truncation causes a loss of precision since the fractional part of the original signal is discarded.

During decryption, the reverse scaling is applied, but the exact original signal cannot be recovered due to the loss of the fractional information during the truncation step. This results in an approximation of the original signal rather than a perfect reconstruction.

The precision loss during encryption and decryption is a trade-off for using integer arithmetic, which is necessary for the RSA algorithm to function properly. Therefore, while the decrypted signal closely resembles the original, it may not match exactly due to this inherent limitation.


## Acknowledgements

- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [RSA Encryption Algorithm](https://en.wikipedia.org/wiki/RSA_(cryptosystem))
- [Chinese Remainder Theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem)

## Contact

For any questions or further information, please contact.
**LABAIHI Mohammed :**
- **Email**: [m.labaihi@gmail.com](m.labaihi@gmail.com)    
- **LinkedIn**: [linkedin.com/in/labaihi](linkedin.com/in/labaihi)  
- **GitHub**: [github.com/LABAIHI_Mohammed](https://github.com/MedLabaihi)  
