with customers as (

    select
        customer_id as customer_id,
        first_name,
        last_name

    from customer

),

invoices as (

    select
        invoice_id as invoice_id,
        customer_id as customer_id,
        date(invoice_date) as invoice_date,
        total

    from invoice

),

customer_invoices as (

    select
        customer_id,

        min(invoice_date) as first_invoice_date,
        max(invoice_date) as most_recent_invoice_date,
        count(invoice_id) as number_of_invoices

    from invoices

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_invoices.first_invoice_date,
        customer_invoices.most_recent_invoice_date,
        coalesce(customer_invoices.number_of_invoices, 0) as number_of_invoices

    from customers

    left join customer_invoices using (customer_id)

)

select * from final