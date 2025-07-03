Mini package for saving high quality figures with a few useful functions:

- Startup - lines to add to your $USERPATH/startup.m file, encourages slightly nicer looking figures from the start, with minimal overheads, reduces extra lines of code like shading flat!
- figure_print_format - Formats plots ready for printing/pretty formatting that looks a bit more python-like
- save_figure - Wrapper script to run figure saving and formatting scripts
- dark_figure - Changes background to dark colours (and correspondingly, other things turn light at a certain darkness threshold for contrast)

# Save Figure
Use at the end of plotting to save with formatting e.g.:

save_figure([19 12], "figure_1", pwd, "../../output_files/", true, false);
save_figure([19 12], "figure_1", pwd, "../../output_files/", true, false, true, [23 23 23]);

Needs there to be two folders in the fig_path - "Raster" and "Vector" which splits the raster and vector copies of files into two folders.
True vector-printing (where all elements are vectorised, except colormaps saved as bitmaps) only occurs under isPrint = true, since this is the slowest step! 
