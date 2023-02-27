-- Veritabanı Sorguları

-- Posta kodu 1010 olan tüm müşterileri bulun

    SELECT CustomerName
    FROM Customers
    WHERE PostalCode = 1010 ;
---------
    db.select('CustomerName').from('Customers').where('PostalCode',('1010'));
---------
    -Cactus Comidas para llevar
    -Océano Atlántico Ltda.
    -Rancho grande
---------

-- id'si 11 olan tedarikçinin telefon numarasını bulun

    SELECT Phone
    FROM Suppliers
    WHERE SupplierID = 11 ;
---------
    db.select('Phone').from('Suppliers').where('SupplierID','11');
---------
    (010) 9984510    
---------

-- Verilen ilk 10 siparişi, sipariş tarihine göre azalan şekilde listeleyin
    SELECT *
    FROM Orders
    ORDER BY OrderDate DESC
    LIMIT 10;
---------
    db.select('*').from('Orders').orderBy('OrderDate', 'DESC').limit(10);
---------
    10443	66	8	1997-02-12	1
    10442	20	3	1997-02-11	2
    10440	71	4	1997-02-10	2
    10441	55	3	1997-02-10	2
    10439	51	6	1997-02-07	3
    10438	79	3	1997-02-06	2
    10436	7	3	1997-02-05	2
    10437	87	8	1997-02-05	1
    10435	16	8	1997-02-04	2
    10433	60	3	1997-02-03	3
---------

-- Londra, Madrid veya Brezilya'da yaşayan tüm müşterileri bulun
    SELECT * 
    FROM Customers
    WHERE City = 'London' OR  City = 'Madrid' OR Country = 'Brazil';
---------
    db.select('*').from('Customers').where({City:'London'} or {City: 'Madrid'} or {Country : 'Brazil'});
---------
    CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
    4	Around the Horn	Thomas Hardy	120 Hanover Sq.	London	WA1 1DP	UK
    8	Bólido Comidas preparadas	Martín Sommer	C/ Araquil, 67	Madrid	28023	Spain
    11	B's Beverages	Victoria Ashworth	Fauntleroy Circus	London	EC2 5NT	UK
    15	Comércio Mineiro	Pedro Afonso	Av. dos Lusíadas, 23	São Paulo	05432-043	Brazil
    16	Consolidated Holdings	Elizabeth Brown	Berkeley Gardens 12 Brewery	London	WX1 6LT	UK
    19	Eastern Connection	Ann Devon	35 King George	London	WX3 6FW	UK
    21	Familia Arquibaldo	Aria Cruz	Rua Orós, 92	São Paulo	05442-030	Brazil
    22	FISSA Fabrica Inter. Salchichas S.A.	Diego Roel	C/ Moralzarzal, 86	Madrid	28034	Spain
    31	Gourmet Lanchonetes	André Fonseca	Av. Brasil, 442	Campinas	04876-786	Brazil
    34	Hanari Carnes	Mario Pontes	Rua do Paço, 67	Rio de Janeiro	05454-876	Brazil
    53	North/South	Simon Crowther	South House 300 Queensbridge	London	SW7 1RZ	UK
    61	Que Delícia	Bernardo Batista	Rua da Panificadora, 12	Rio de Janeiro	02389-673	Brazil
    62	Queen Cozinha	Lúcia Carvalho	Alameda dos Canàrios, 891	São Paulo	05487-020	Brazil
    67	Ricardo Adocicados	Janete Limeira	Av. Copacabana, 267	Rio de Janeiro	02389-890	Brazil
    69	Romero y tomillo	Alejandra Camino	Gran Vía, 1	Madrid	28001	Spain
    72	Seven Seas Imports	Hari Kumar	90 Wadhurst Rd.	London	OX15 4NB	UK
    81	Tradição Hipermercados	Anabela Domingues	Av. Inês de Castro, 414	São Paulo	05634-030	Brazil
    88	Wellington Importadora	Paula Parente	Rua do Mercado, 12	Resende	08737-363	Brazil
---------

-- "The Shire" için bir müşteri kaydı ekleyin, ilgili kişi adı "Bilbo Baggins", adres - "Bag End" içinde "1 Hobbit-Hole", posta kodu "111" ve ülke "Middle Earth"
    INSERT INTO Customers
    VALUES (92,'The Shire','Bilbo Baggins','Bag End', '1 Hobbit Hole', 111,'Middle Earth');
---------
    db.insert('Customers').values(92,'The Shire',''.........)
    db('Customers').insert({CustomerName: 'The Shire'}, {ContactName: 'Bilbo Baggins'}, ........ )
---------
    92	The Shire	Bilbo Baggins	Bag End	1 Hobbit Hole	111	Middle Earth
---------

-- Posta kodu "11122" olarak değişecek şekilde Bilbo Baggins kaydını güncelleyin
    UPDATE Customers
    SET PostalCode = '11122'
    WHERE ContactName = 'Bilbo Baggins';
---------
    db.update('Customers').set({ContactName: 'Bilbo Baggins'}).where({PostalCode:'11122'});
---------
    92	The Shire	Bilbo Baggins	Bag End	1 Hobbit Hole	11122	Middle Earth
---------

-- (Zorlayıcı Görev) Müşteriler tablosunda kaç farklı şehrin saklandığını keşfetmek için bir sorgu bulun. Tekrarlar çift sayılmamalıdır
    
-- (Zorlayıcı Görev) 20 karakterden uzun adları olan tüm tedarikçileri bulun. Adın uzunluğunu almak için "length(SupplierName)" kullanabilirsiniz.