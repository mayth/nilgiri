Nilgiri::App.controllers :base do
  get :index, :map => '/' do
    @machines = Machine.all
    # Posts
    @top_post = Post.first
    @posts = Post.offset(1).limit(5)
    @is_more_posts = Post.count > 6

    # Scores
    # @top_scores will be:
    #   { machineA: {
    #       musicA: { BASIC: scores, ... }
    #       musicB: { BASIC: scores, ... }
    #     },
    #     machineB: {
    #       musicC: {
    #         SP: { NORMAL: scores, ... }
    #         DP: { NORMAL: scores, ... }
    #       }, ...
    #     }, ...
    #   }
    if @current_season.present?
      @top_scores = Hash[
        @machines.map {|machine|
          [machine, Hash[
            machine.musics_for(@current_season).map{|music|
              [music, Hash[
                machine.playstyles.present? ?
                machine.playstyles.map {|playstyle|
                  [playstyle, Hash[
                    machine.difficulties.map {|difficulty|
                      [difficulty,
                       Score.top_scores(music, difficulty, playstyle)
                      ]
                    }
                  ]] # { playstyle: ... }
                } :
                machine.difficulties.map {|difficulty|
                  [difficulty, Score.top_scores(music, difficulty)]
                }
              ]] # { music: ... }
            }
          ]] # { machine: ... }
        }
      ]
    end

    render 'base/index'
  end
end
