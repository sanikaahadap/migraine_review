from Crypto.PublicKey import RSA
from Crypto.Cipher import AES
from Crypto.Cipher import PKCS1_OAEP
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad
import argparse
import zipfile

def encrypt_private_key(private_key_file, encryption_key_file, output_file):
    # Load the private key
    with open(private_key_file, 'rb') as f:
        private_key = f.read()

    # Load the encryption public key
    with open(encryption_key_file, 'rb') as f:
        public_key_pem = f.read()

    # Create RSA key object
    rsa_key = RSA.import_key(public_key_pem)
    rsa_cipher = PKCS1_OAEP.new(rsa_key)

    # Generate AES key
    aes_key = get_random_bytes(32)  # 256-bit AES key

    # Encrypt the AES key with RSA
    encrypted_aes_key = rsa_cipher.encrypt(aes_key)

    # Encrypt the private key with AES
    aes_cipher = AES.new(aes_key, AES.MODE_ECB)
    encrypted_private_key = aes_cipher.encrypt(pad(private_key, AES.block_size))

    # Save encrypted AES key and private key in a zip file
    with zipfile.ZipFile(output_file, 'w') as zf:
        zf.writestr('encrypted_aes_key.bin', encrypted_aes_key)
        zf.writestr('encrypted_private_key.bin', encrypted_private_key)

    print(f'Encrypted private key and AES key have been saved to {output_file}')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Encrypt and export a private key.')
    parser.add_argument('private_key_file', type=str, help='Path to the private key file.')
    parser.add_argument('encryption_key_file', type=str, help='Path to the encryption public key file.')
    parser.add_argument('output_file', type=str, help='Path to the output file to save the encrypted key.')

    args = parser.parse_args()
    encrypt_private_key(args.private_key_file, args.encryption_key_file, args.output_file)
