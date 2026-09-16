% =========================================================================
% Dynamic Battery Discharge Evaluation - Publication Quality Plot
% =========================================================================

% 1. Robust Data Extraction (Auto-detects battery node in dischargeCircuit)
try
    batt = simlog.dischargeCircuit.Panasonic_UR18650ZTA;
catch
    % Fallback: grab the first block containing 'UR18650' or 'Battery'
    fields = fieldnames(simlog.dischargeCircuit);
    idx = find(contains(fields, 'UR18650') | contains(fields, 'Battery'), 1);
    assert(~isempty(idx), 'Battery node not found in simlog.dischargeCircuit.');
    batt = simlog.dischargeCircuit.(fields{idx});
end

% Extract time series and convert time to minutes for readability
t_min   = batt.i.series.time / 60; 
i_vals  = batt.i.series.values;
v_vals  = batt.v.series.values;
ocv_vals= batt.ocv.series.values;
soc_pct = batt.stateOfCharge.series.values * 100;

% 2. Figure Layout and Styling
fig = figure('Color', 'w', 'Units', 'pixels', 'Position', [100, 100, 850, 720]);
tiledlayout(3, 1, 'Padding', 'compact', 'TileSpacing', 'compact');

% Palette definitions
col_curr = [0.85, 0.33, 0.10]; % Amber / Rust
col_ocv  = [0.20, 0.20, 0.20]; % Charcoal dashed
col_vt   = [0.00, 0.45, 0.74]; % Deep Blue
col_soc  = [0.47, 0.67, 0.19]; % Emerald Green

% --- Subplot 1: Dynamic Current Profile ---
ax1 = nexttile;
plot(t_min, i_vals, 'Color', col_curr, 'LineWidth', 2.0);
ylabel('Current (A)', 'FontWeight', 'bold');
title('Dynamic Battery Discharge Evaluation (Phone Usage Profile)', 'FontSize', 13, 'FontWeight', 'bold');
grid on; set(gca, 'Box', 'on', 'FontSize', 10, 'LineWidth', 1.1);
yline(0, 'k:', 'Alpha', 0.6, 'HandleVisibility', 'off');

% --- Subplot 2: Terminal Voltage (Vt) vs. OCV ---
ax2 = nexttile;
plot(t_min, ocv_vals, '--', 'Color', col_ocv, 'LineWidth', 1.5, 'DisplayName', 'Open Circuit Voltage (OCV)');
hold on;
plot(t_min, v_vals, 'Color', col_vt, 'LineWidth', 2.0, 'DisplayName', 'Terminal Voltage (V_t)');
ylabel('Voltage (V)', 'FontWeight', 'bold');
legend('Location', 'northeast', 'Box', 'off', 'FontSize', 9.5);
grid on; set(gca, 'Box', 'on', 'FontSize', 10, 'LineWidth', 1.1);

% Annotations for IR Drop and Recovery
text(10.5, min(v_vals(t_min >= 10 & t_min <= 20)) - 0.05, '\downarrow IR Drop (Heavy Load)', ...
    'FontSize', 9, 'FontWeight', 'bold', 'Color', [0.7 0 0]);
text(20.5, max(v_vals(t_min >= 20 & t_min <= 30)) + 0.05, '\uparrow Voltage Recovery', ...
    'FontSize', 9, 'FontWeight', 'bold', 'Color', [0 0.5 0]);

% --- Subplot 3: State of Charge (SOC) ---
ax3 = nexttile;
plot(t_min, soc_pct, 'Color', col_soc, 'LineWidth', 2.0);
xlabel('Elapsed Time (minutes)', 'FontWeight', 'bold');
ylabel('SOC (%)', 'FontWeight', 'bold');
ylim([0, 105]);
grid on; set(gca, 'Box', 'on', 'FontSize', 10, 'LineWidth', 1.1);

% Link horizontal axes for synchronized zooming and panning
linkaxes([ax1, ax2, ax3], 'x');
xlim([0, max(t_min)]);