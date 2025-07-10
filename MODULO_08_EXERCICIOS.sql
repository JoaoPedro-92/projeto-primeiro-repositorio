
														--EXECERCICIOS MODULO 08


--1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct.

select * from DimProductSubcategory
select * from DimProduct

select 
	productkey,
	productname,
	DimProductSubcategory.ProductSubcategoryName
from
	DimProduct
inner join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

				--------------------------------------------------------------------------------------------------------------

	--2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar 
	--informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.

select * from DimProductcategory
select * from DimProductSubcategory

select 
	productsubcategoryname as 'nome do sub-produto',
	productsubcategorydescription as 'descrição do sub-produto',
	DimProductCategory.ProductCategoryName
from
	DimProductSubcategory
left join DimProductcategory
	on DimProductSubcategory.ProductCategoryKey = DimProductcategory.ProductCategoryKey

					--------------------------------------------------------------------------------------------------------------

	--3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT 
	--final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT 
	--JOIN neste exercício. 

SELECT * FROM DimStore
SELECT * FROM DimGeography

SELECT
	storekey,
	STORENAME,
	EmployeeCount,
	continentname,
	regioncountryname
from
	dimstore
left join DimGeography
	on DimGeography.GeographyKey = DimStore.GeographyKey

					--------------------------------------------------------------------------------------------------------------

	-- 4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT 
	-- apenas as 5 colunas que considerar mais relevantes. 

select top(10) * from DimProduct
select top(10) * from DimProductcategory
select top(10) * from DimProductSubcategory

select 
	productname,
	ProductCategoryDescription
from 
	DimProduct
left join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		left join DimProductCategory
			on DimProductSubcategory.ProductSubcategoryKey = DimProductCategory.ProductCategoryKey

	

					--------------------------------------------------------------------------------------------------------------

--5. A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha representa um montante destinado a uma determinada
--AccountKey.  
		--	a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.

select top(100) * from factstrategyplan
select top(100) * from DimAccount

		--	b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada 
			--AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
			--• StrategyPlanKey 
			--• DateKey 
			--• AccountName 
			--• Amount 

select 
	strategyplankey,
	datekey,
	accountname,
	amount
from 
	FactStrategyPlan
inner join DimAccount
	on FactStrategyPlan.AccountKey = DimAccount.AccountKey

					--------------------------------------------------------------------------------------------------------------

--6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra coluna
-- chamada ScenarioKey. Essa coluna possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão. 

	--Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
	--• StrategyPlanKey 
	--• DateKey 
	--• ScenarioName  
	--• Amount 
select top(100) * from factstrategyplan
select top(100) * from DimAccount
select top(100) * from DimScenario

select 
	StrategyPlanKey,
	datekey,
	scenarioname,
	amount
from
	FactStrategyPlan
inner join DimScenario
	on FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey


						--------------------------------------------------------------------------------------------------------------


--7. Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas. 

select * from DimProductSubcategory
select * from DimProduct


select
	productname,
	ProductSubcategoryName
from
	DimProductSubcategory
left join DimProduct
	on	DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
where ProductName is null

						--------------------------------------------------------------------------------------------------------------

--8. A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. Crie um código SQL para chegar 
--no mesmo resultado. 

select * from DimChannel
select * from DimProduct

select 
	distinct brandname,
	channelname
from
	dimproduct cross join DimChannel
where BrandName in('contoso','fabrican','litware')


						--------------------------------------------------------------------------------------------------------------

-- 9. Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas têm em comum
-- e utilize-a para criar esse relacionamento. Retorne uma tabela contendo as seguintes colunas: 
	--• OnlineSalesKey 
	--• DateKey 
	--• PromotionName 
	--• SalesAmount 

--A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’). Além disso, você 
--deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente. 

select top(100) * from FactOnlineSales  -- tabela em comum ( promotionkey )
select top(100) * from DimPromotion


select top(1000)
	onlinesaleskey,
	datekey,
	promotionname,
	salesamount
from
	FactOnlineSales
inner join DimPromotion
	on factonlinesales.promotionkey = DimPromotion.PromotionKey
where promotionname <> ' no discount'
order by datekey asc


						--------------------------------------------------------------------------------------------------------------


--10. A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct. Recrie esta consulta e classifique 
--em ordem decrescente de acordo com SalesAmount.


select top(1000) * from factsales 
select top(1000) * from DimStore
select top(1000) * from DimProduct 

select top(100)
	saleskey,
	channelname,
	StoreName,
	SalesAmount
from 
	factsales
inner join DimChannel
	on factsales.channelkey = DimChannel.ChannelKey
inner join DimStore
	on factsales.StoreKey = dimstore.StoreKey


