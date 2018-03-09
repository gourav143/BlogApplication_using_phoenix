defmodule Book.SessionController do
   use Book.Web, :controller

   def new(conn, _) do
     render conn, "new.html"
   end

   def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
   	 case Book.Auth.login_by_username_and_password(conn, user, pass, repo: Repo) do
   	 	{:ok, conn} ->
   	 	 conn
   	 	  |>put_flash(:info, "welcome #{user}")
   	 	  |>redirect(to: page_path(conn, :index))
   	 	{:error, _reason, conn} ->
   	 	 conn
   	 	 |> put_flash(:error, "Invalid username/password combination")
         |> render("new.html")

   	 end

   end

   def delete(conn, _) do
   		conn
   		|>Book.Auth.logout()
   		|>redirect(to: page_path(conn, :index))
   end 
  
end