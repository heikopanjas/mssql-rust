use sqlx::mssql::MssqlPoolOptions;

#[tokio::main]
async fn main() -> Result<(), sqlx::Error> {
    let pool = MssqlPoolOptions::new()
        .max_connections(5)
        .connect("mssql://dbcaps:Ultra!schall0@localhost/dbcaps?trust_server_certificate=true")
        .await?;

    let row: (i64,) = sqlx::query_as("SELECT @P1")
        .bind(150_i64)
        .fetch_one(&pool)
        .await?;
    // let row: (i32,) = sqlx::query_as("SELECT COUNT(id) FROM dbcaps")
    //     .fetch_one(&pool)
    //     .await?;

    println!("{}", row.0);

    Ok(())
}
