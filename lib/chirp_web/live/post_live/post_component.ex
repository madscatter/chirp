defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="max-w-4xl mx-auto border rounded p-6">
      <div class="flex">
        <div class="w-2/12">
          <div class="w-20 h-20 bg-gray-300"></div>
        </div>
        <div class="w-10/12 post-body">
          <b>@<%= @post.username %></b>
          <br/>
          <%= @post.body %>
        </div>
      </div>

      <div class="flex justify-between mx-24">
        <div class="column">
          <a href="#" phx-click="like" phx-target="<%= @myself %>" >
            <i class="far fa-heart"></i> <%= @post.likes_count %>
          </a>
        </div>
        <div class="column">
          <a href="#" phx-click="repost" phx-target="<%= @myself %>" >
            <i class="fas fa-retweet"></i> <%= @post.reposts_count %>
          </a>
        </div>
        <div class="column">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="far fa-edit"></i>
          <% end %>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
            <i class="far fa-trash-alt"></i>
          <% end %>
        </div>

      </div>
    </div>
"""
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end