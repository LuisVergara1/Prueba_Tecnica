class CommentController < ApplicationController
  skip_before_action :verify_authenticity_token
 #Crear Comentario
  def create_comment
    feature = Earthquake.find(params[:feature_id])
    comment = feature.comments.build(body: params[:body])

    if comment.save
      render json: { message: "Comentario creado correctamente" }, status: :created
    else
      render json: { error: "Error al crear el comentario", details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Feature no encontrado" }, status: :not_found
  end

  # Modificar Comentario
  def update_comment
    comment = Comment.find(params[:comment_id])

    if comment.update(body: params[:body])
      render json: { message: "Comentario actualizado correctamente" }, status: :ok
    else
      render json: { error: "Error al actualizar el comentario", details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #Eliminar Comentario
  def destroy_comment
  comment = Comment.find(params[:comment_id])

  if comment.destroy
    render json: { message: "Comentario eliminado correctamente" }, status: :ok
  else
    render json: { error: "Error al eliminar el comentario" }, status: :unprocessable_entity
  end
end

#Obtener Todos Los Comentarios
def get_all
  comments = CommentService.get_all
  render json: { comments: comments }
end

#Obtener Comentarios Segun Id del Feature

def get_by_id
  feature_id = params[:id_feature]
  comments = CommentService.get_by_id(feature_id)
  render json: { comments: comments }
end
end
