function [output] = ParLoad(filename)
    load(filename);
    output = BaseEval;
end
