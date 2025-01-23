class NotesController < ApplicationController
    before_action :set_note, only[:edit, :update, :destroy]
    def index
        @notes = Note.includes(:user)
    end

    def new
        @note = Note.new
    end

    def create
        @notes = Note.new(note_params)
        if @note.save
            redirect to notes_path
        else
            render :new
        end
    end

    def edit
    end

    def update
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

    def set_note
        @note = Note.find(params[:id])
    end
end
