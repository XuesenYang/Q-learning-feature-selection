load('sonar.mat')
epsilon=0.5;
alpha=0.2;
epsilon_decay_rate=0.995;
alpha_decay_rate=0.995;
K=100000;
all_rewards=[];
num_episodes=100;
num_agents=size(data,2)-1;
actions = 0*zeros(1,num_agents);
for i=1:num_agents
    Q_values(i,:) =[-1,-1];
end
for episode=1:num_episodes
    for agent=1:num_agents
        rand_number1=rand(1,1);
        rand_number2=rand(1,1);
        if rand_number1>epsilon
            [~,y_value]=max(Q_values(agent,:));
            actions(1,agent)=y_value-1;
        else
            if rand_number2>epsilon
                actions(1,agent)=1;
            else
                actions(1,agent)=0;
            end
        end
    end
    features=[];
    features=find(actions==1);
    fit=get_reward(data,features,K);
    if length(features)<K 
        fprintf('iter: %d  fitness: %0.4f seletet features: %s\n',episode,fit,num2str(features));
    else
        fprintf('iter: %d  fitness: %0.4f size of seletet features: %d\n',episode,fit,length(features));
    end
    for agent=1:num_agents
        actions(1,agent)=1-actions(1,agent);
        features = [];
        features=find(actions==1);
        C_agent = get_reward(data,features,K) - fit;
        Q_values(agent,actions(1,agent)+1)=Q_values(agent,actions(1,agent)+1) + alpha*(C_agent - Q_values(agent,actions(1,agent)+1));
    end
    alpha = alpha * alpha_decay_rate;
    epsilon = epsilon * epsilon_decay_rate;
end
        
