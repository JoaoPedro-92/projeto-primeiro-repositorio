select top (1000) * from FactSales
select top (1000) * from DimChannel

select
	channelname,
	sum(salesquantity) As 'QTD total vendida',
	sum(returnquantity) as 'qtd total devolvida'
from 
	DimChannel
inner join FactSales
	on FactSales.channelKey = DimChannel.ChannelKey
group by ChannelName



--------------------------------------------------------------------------------------------------------------------------------------------------




select top (10) * from DimProductSubcategory
select * from DimProduct
select top (1000) * from FactSales

select
	productname,
	colorname,
	sum(salesamount) as 'venda total do produto'
from 
	DimProduct
inner join factsales
	on dimproduct.ProductKey = factsales.ProductKey
	group by productname

select 
	colorname,
	sum(salesquantity) as 'quantidade de cor vendida'
from
	DimProduct
inner join FactSales
	on dimproduct.ProductKey = factsales.ProductKey
group by ColorName
having sum(salesquantity) >= 3000000


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação 
--entre FactSales e DimProductCategory não é direta.

select top (2) * from FactSales
select top (2) * from DimProduct
select top (2) * from DimProductSubcategory
select top (2) * from DimProductcategory

select 
	productcategoryname as 'Categoria',
	sum(salesquantity) as 'quantidade vendida'
from
	factsales																	-- ONDE VC QUER ANALISAR, OU SEJA, DAONDE VOCE QUER PUXAR OS DADOS
inner join DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
	inner join DimProductSubcategory
		on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
			inner join DimProductCategory
				on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
group by ProductCategoryName



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																		--FACTONLINESALES-- 

--4. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).



select top (1000) * from DimCustomer
select top (100) * from dimproduct
Select top (1000) * from FactOnlineSales
select top (2) * from FactSales

select 
	DimCustomer.CustomerKey,
	FirstName,
	LastName,
	sum(salesquantity) as 'soma total das compras'
from 
	factonlinesales
inner join dimcustomer
	on factonlinesales.customerkey = dimcustomer.customerkey
where firstname is not null and lastname is not null
group by firstname, lastname, DimCustomer.CustomerKey
order by sum(salesquantity) desc

-- b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto. 

select top(10)
	productname as 'produto',
	sum(salesquantity) as 'quantidade total vendida'
from
	FactOnlineSales
inner join DimProduct
	on FactOnlineSales.ProductKey = DimProduct.ProductKey
where CustomerKey = 7665
group by ProductName
order by sum(salesquantity) desc


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes. 


select top (2) * from FactOnlineSales
select top (1000) * from DimCustomer
	

select 
	gender as 'sexo do cliente',
	sum(salesquantity) as 'quantidade de produtos comprado'
from
	FactOnlineSales
inner join DimCustomer
	on FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
group by Gender


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																			--	FACTEXCHANGERATE --

-- 6. Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada  CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100. 


select top (100) * from DimCurrency
select top (100) * from FactExchangeRate

	select
		currencydescription,
		avg(averagerate) as 'média'
	from
		FactExchangeRate
	inner join DimCurrency
		on FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
	group by CurrencyDescription
	having AVG(averagerate) between 10 and 100


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				-- FACTSTRATEGYPLAN -- 


-- 7. Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos cenários: Actual e Budget. 
		--Dica: A tabela DimScenario será importante para esse exercício. 

select top (100) * from FactStrategyPlan
select top (100) * from DimScenario

select 
	scenariodescription,
	sum(amount) as 'soma total'
from
	FactStrategyPlan
inner join DimScenario
	on FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
where ScenarioDescription in ('Actual','Budget')
group by ScenarioDescription

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano. 

select top(100) * from FactStrategyPlan
select top(100) * from DimDate

select 
	calendaryear as 'ano',
	sum(amount) as 'total'
from
	FactStrategyPlan
inner join dimdate
	on FactStrategyPlan.datekey = dimdate.datekey
group by CalendarYear