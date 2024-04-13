class CommentController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Crear Comentario
 def create_comment
  feature = Earthquake.find_by(id: params[:feature_id])
  if feature.nil?
    render json: { error: "El feature con el ID #{params[:feature_id]} no existe" }, status: :not_found
  else
    comment = feature.comments.build(body: params[:body])
    if comment.save
      render json: { message: "Comentario creado correctamente" }, status: :created
    else
      render json: { error: "Error al crear el comentario", details: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end


  # Modificar Comentario
  def update_comment
    comment = Comment.find_by(id: params[:comment_id])
    if comment.nil?
      render json: { error: "El comentario con el ID #{params[:comment_id]} no existe" }, status: :not_found
    elsif params[:body].present?
      if comment.update(body: params[:body])
        render json: { message: "Comentario actualizado correctamente" }, status: :ok
      else
        render json: { error: "Error al actualizar el comentario", details: comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "El campo 'body' no puede estar vacío" }, status: :unprocessable_entity
    end
  end


  #Eliminar Comentario
  def destroy_comment
    comment = Comment.find_by(id: params[:comment_id])
    if comment.nil?
      render json: { error: "El comentario con el ID #{params[:comment_id]} no existe" }, status: :not_found
    elsif comment.destroy
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
  feature = Earthquake.find_by(id: feature_id)
  if feature.nil?
    render json: { error: "El feature con el ID #{feature_id} no existe" }, status: :not_found
  else
    comments = CommentService.get_by_id(feature_id)
    render json: { comments: comments }
  end
end
end
