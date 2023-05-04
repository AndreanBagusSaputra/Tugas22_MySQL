-- Input Pesanan
Delimiter$$
CREATE PROCEDURE inputPelanggan(
    IN p_nama VARCHAR(255),
    IN p_alamat VARCHAR(255),
    IN p_telepon VARCHAR(20),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO pelanggan(nama, alamat, telepon, email)
    VALUES(p_nama, p_alamat, p_telepon, p_email);
END$$

Delimiter ;
call inputPelanggan("John Doe", "Jl. Sudirman No. 123", "08123456789", "johndoe@example.com")

-- Show Pelanggan
Delimiter$$
CREATE PROCEDURE showPelanggan()
BEGIN
    SELECT * FROM inputPelanggan;
END$$

-- Input Pesanan
Delimiter$$
CREATE PROCEDURE simpan_pesanan(
    IN p_id_pelanggan INT,
    IN p_tgl_pesan DATE,
    IN p_tgl_kirim DATE,
    in p_total_pesanan int;
    IN p_total_harga INT
)
BEGIN
    INSERT INTO pesanan(id_pelanggan, tgl_pesan, tgl_kirim, total_pesanan, total_harga)
    VALUES(p_id_pelanggan, p_tgl_pesan, p_tgl_kirim, p_total_pesanan, p_total_harga);
END$$

Delimiter ;
call inputPesanan (1, "2023-05-04", "2023-05-10", 2, 100000)

-- Show Pesanan
Delimiter$$
CREATE PROCEDURE showPesanan()
BEGIN
    SELECT * FROM inputPesanan;
END$$

-- Total Pesanan
Delimiter $$
CREATE PROCEDURE hitung_total_pesanan(
    IN p_id_pelanggan INT,
    OUT p_total INT
)
BEGIN
    SELECT SUM(total_harga) INTO p_total
    FROM pesanan
    WHERE id_pelanggan = p_id_pelanggan;
END$$

call inputPesanan (1)

-- View
CREATE VIEW pesanan_produk_vw AS
SELECT 
    p.id_pesanan,
    pl.nama_pelanggan,
    pd.nama_produk,
    pd.harga,
    p.jumlah,
    (pd.harga * p.jumlah) AS total_harga
FROM pesanan p
JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan
JOIN produk pd ON p.id_produk = pd.id_produk;

SELECT * FROM pesanan_produk_vw;
