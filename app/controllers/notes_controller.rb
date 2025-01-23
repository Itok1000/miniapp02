class NotesController < ApplicationController
    def index
        @notes = Note.includes(:user)
    end

    def new
        @note = Note.new
    end

    def create
        @note = Note.find(params[:id])
        @notes = Note.new(note_params)
        if @note.save
            redirect to notes_path
        else
            render :new
        end
    end

    def edit
        @note = Note.find(params[:id])
    end

    def update
        @note = Note.find(params[:id])
        if @note.update(note_params)
            redirect to notes_path
        else
            render :edit
        end
    end

    def destroy
        @note.destroy(note_params)
        redirect to notes_path
    end

    private

    def note_params
        params.require(:post).permit(:title, :content)
    end
end
