function [decision_] = movementDeci(x_,xNeighborhood_,currentT_)
    xFunc_ = x_*[4 3 2 1]';
    xNeighborhoodFunc_ = xNeighborhood_*[4 3 2 1]';
    deltaFunc_ = xNeighborhoodFunc_ - xFunc_;
    if deltaFunc_ < 0
        decision_ = 1;
    else
       metropolisProb_ = exp( -deltaFunc_/currentT_);
       if metropolisProb_ > rand()
           decision_ = 1;
       else
           decision_ = 0;
       end
    end
end