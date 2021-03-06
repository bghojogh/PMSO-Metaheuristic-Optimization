function Fitness = CostFunction(k_of_cells, do_plot_the_power)
    Im = 4.39;
    Vm = 20;
    for i = 1:size(k_of_cells,1)
        row_currents(i) = sum(k_of_cells(i,:)) * Im;
    end
    [sorted_row_currents, index_sort] = sort(row_currents);
    sorted_Va = (9:-1:1) * Vm;
    Power_sorted = sorted_row_currents .* sorted_Va;
    if do_plot_the_power == 1
        %figure
        plot([190, sorted_Va], [500, Power_sorted], '-*');
    end
    Fitness = max(Power_sorted);
end