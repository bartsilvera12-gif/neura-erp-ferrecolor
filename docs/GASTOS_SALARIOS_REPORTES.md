# Gastos: salarios, recibos y reporte de fijos/variables

Guía para soporte. Todo sale de lo que ya se carga en **Gastos**: no hay un módulo
de nómina aparte, así que ningún pago se registra dos veces.

> **Antes de usarlo:** aplicar la migración
> `supabase/migrations/20261104120000_ferrecolor_gastos_salarios.sql`
> (agrega `funcionario`, `funcionario_ci` y `periodo` a `ferrecolor.gastos`).
> Es idempotente: se puede correr más de una vez sin problema.

## Qué cuenta como salario

Un gasto aparece en el reporte de salarios si:

- tiene un **funcionario** asignado, **o**
- su **categoría** es de salarios: contiene SALARI, SUELDO, AGUINALDO, JORNAL,
  NÓMINA, PLANILLA o REMUNERACI (SALARIOS, SUELDOS, AGUINALDO, JORNALES…).

Por eso los salarios cargados antes de este cambio ya salen en el reporte, como
**"Sin funcionario asignado"** hasta que se editen.

## 1. Registrar un pago de salario

1. **Gastos → + Nuevo gasto**.
2. Categoría `SALARIOS` (o `SUELDOS`). Aparece el recuadro **Pago a funcionario**.
   - Para otra categoría (p. ej. `ANTICIPOS`), usar el enlace **"Es un pago a un funcionario"**.
3. Completar **Funcionario** (se autocompleta con los nombres ya cargados, y trae la C.I.),
   **C.I.** (opcional, sale en el recibo) y **Período que se paga**.
   - Ejemplo: el sueldo de octubre pagado el 5 de noviembre → fecha 05/11, período **octubre**.
   - Si el período queda vacío, se toma el mes de la fecha.
4. **Tipo**: normalmente **Fijo** para el sueldo, **Variable** para horas extra o bonos.
5. Marcar **Descontar de caja** solo si se pagó en efectivo desde la caja abierta.
6. **Crear gasto**. En la lista de Gastos aparece el botón **Recibo** en esa fila.

> Tip: en "Gastos previos" se puede reutilizar el pago del mes anterior: copia
> funcionario, C.I., monto y categoría; solo hay que elegir el período.

## 2. Completar los salarios que ya estaban cargados

1. **Reportes → Salarios pagados**, elegir el rango de fechas.
2. La tarjeta **Sin funcionario asignado** dice cuántos pagos faltan.
3. En cada fila, **Asignar funcionario** → completar funcionario, C.I. y período → **Guardar cambios**.

## 3. Reporte de salarios pagados

**Reportes → Salarios pagados** (o desde Gastos → **Salarios y recibos**).

- Filtro por **fecha de pago** (Desde / Hasta) y por **funcionario**.
- Tarjetas: total pagado, cantidad de pagos, funcionarios, pagos sin asignar.
- **Por funcionario y período**: cuánto se le pagó a cada uno por mes.
- **Detalle de pagos**: fecha, funcionario, período, concepto y monto.
- **Exportar Excel**: hojas *Pagos*, *Por funcionario* y *Por funcionario y período*.

## 4. Imprimir recibos

- **Uno solo:** botón **Recibo** en la fila (en Gastos o en el reporte de salarios).
- **Todos los del período:** en el reporte, **Imprimir recibos (N)**. Si hay un
  funcionario filtrado, imprime solo los suyos.

Cada recibo sale en una hoja A4 con **original (empresa)** y **duplicado
(funcionario)** y una línea de corte. Incluye monto en números y en letras,
concepto, período, funcionario y C.I. y líneas de firma. En la ventana que se abre:
**Imprimir / Guardar PDF**. Es un documento interno, no fiscal.

## 5. Reporte de gastos fijos y variables

**Reportes → Gastos fijos y variables** (o desde Gastos → **Reporte fijos / variables**).

- Tarjetas: **total del período**, **fijos** y **variables** (con % del total) y cantidad de registros.
- **Por categoría**: fijo, variable, total y % de cada categoría, con el total del período al pie.
  Las categorías se agrupan sin importar mayúsculas o espacios (`Salarios` = `SALARIOS `).
  Clic en una categoría filtra el detalle.
- **Detalle**: filtro Todos / Fijos / Variables, con subtotal.
- **Exportar Excel**: hojas *Resumen*, *Por categoría* y *Detalle*.

Para que el reporte sea fiel, cada gasto tiene que tener bien elegido el **Tipo**
(Fijo/Variable) y una **categoría** consistente; se corrige desde **Gastos → Editar**.
