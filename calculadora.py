import flet as ft

def main(page: ft.Page):
    # Definir o visor da calculadora
    expression = ft.TextField(value="", width=300, text_size=30, text_align=ft.TextAlign.RIGHT)

    # Função para adicionar valores ao visor
    def add_to_expression(e):
        expression.value += e.control.text
        expression.update()

    # Função para calcular o resultado
    def calculate(e):
        try:
            expression.value = str(eval(expression.value))
        except Exception as ex:
            expression.value = "Erro"
        expression.update()

    # Função para limpar o visor
    def clear_expression(e):
        expression.value = ""
        expression.update()

    # Layout da calculadora
    page.add(
        expression,
        ft.Row(
            controls=[
                ft.ElevatedButton("7", on_click=add_to_expression),
                ft.ElevatedButton("8", on_click=add_to_expression),
                ft.ElevatedButton("9", on_click=add_to_expression),
                ft.ElevatedButton("/", on_click=add_to_expression),
            ]
        ),
        ft.Row(
            controls=[
                ft.ElevatedButton("4", on_click=add_to_expression),
                ft.ElevatedButton("5", on_click=add_to_expression),
                ft.ElevatedButton("6", on_click=add_to_expression),
                ft.ElevatedButton("*", on_click=add_to_expression),
            ]
        ),
        ft.Row(
            controls=[
                ft.ElevatedButton("1", on_click=add_to_expression),
                ft.ElevatedButton("2", on_click=add_to_expression),
                ft.ElevatedButton("3", on_click=add_to_expression),
                ft.ElevatedButton("-", on_click=add_to_expression),
            ]
        ),
        ft.Row(
            controls=[
                ft.ElevatedButton("0", on_click=add_to_expression),
                ft.ElevatedButton(".", on_click=add_to_expression),
                ft.ElevatedButton("C", on_click=clear_expression),
                ft.ElevatedButton("+", on_click=add_to_expression),
            ]
        ),
        ft.Row(
            controls=[
                ft.ElevatedButton("=", on_click=calculate, expand=4),
            ]
        )
    )

# Executar a aplicação
ft.app(target=main)

