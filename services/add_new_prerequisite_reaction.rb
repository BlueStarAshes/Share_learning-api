# frozen_string_literal: true
require 'date'

# Add new instance of Reaction to database
class AddNewPrerequisiteReaction
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_ids, lambda { |params|
    body_params = JSON.parse params[:request]
    course_prerequisite_id = body_params['course_prerequisite_id']
    reaction_id = body_params['reaction_id']

    if course_prerequisite_id && reaction_id
      Right(
        course_prerequisite_id: course_prerequisite_id,
        reaction_id: reaction_id
      )
    else
      Left(
        Error.new(
          :unprocessable_entity,
          'params are not correct'
        )
      )
    end
  }

  register :check_ids_exist, lambda { |params|
    prerequisite = CoursePrerequisite.find(id: params[:course_prerequisite_id])
    reaction = Reaction.find(id: params[:reaction_id])

    if prerequisite && reaction
      Right(params)
    else
      Left(
        Error.new(
          :unprocessable_entity,
          'course_prerequisite_id or reaction_id not correct'
        )
      )
    end
  }

  register :create_prerequisite_reaction, lambda { |params|
    begin
      current_time = DateTime.now.strftime('%F %T')

      CoursePrerequisiteReaction.create(
        course_prerequisite_id: params[:course_prerequisite_id],
        reaction_id: params[:reaction_id],
        time: current_time
      )

      Right('Successfully create a new instance of Reaction for prerequisite')
    rescue
      Left(Error.new(:bad_request, \
        'Failed to create reaction for prerequisite'))
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_ids
      step :check_ids_exist
      step :create_prerequisite_reaction
    end.call(params)
  end
end
