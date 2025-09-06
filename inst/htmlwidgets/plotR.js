HTMLWidgets.widget({

  name: 'plotR',

  type: 'output',

  factory: function(el, width, height) {

    // Store the plot instance
    var plot = null;
    
    return {

      renderValue: function(x) {
        
        console.log("plotR renderValue called with:", x);
        
        // Store for resize
        this.lastValue = x;
        
        // Clear any existing content
        el.innerHTML = '';
        
        // Get data - htmlwidgets automatically converts R data frames to JavaScript arrays
        var data = x.data || null;
        console.log("Data received:", data);
        
        // Build the plot specification
        var spec = x.spec || {};
        
        // Process marks - convert R mark specifications to Plot marks
        if (spec.marks) {
          spec.marks = spec.marks.map(function(markSpec) {
            // Handle R-generated mark specifications
            if (markSpec.type) {
              var markData = markSpec.data;
              var markOptions = markSpec.options || {};
              
              // If mark references data placeholder, use the provided data
              if (markData === "@@data@@" && data) {
                markData = data;
              }
              
              // Call the appropriate Plot mark function
              switch(markSpec.type) {
                case 'dot':
                  return markData ? Plot.dot(markData, markOptions) : Plot.dot(markOptions);
                case 'line':
                  return markData ? Plot.line(markData, markOptions) : Plot.line(markOptions);
                case 'barY':
                  return markData ? Plot.barY(markData, markOptions) : Plot.barY(markOptions);
                case 'barX':
                  return markData ? Plot.barX(markData, markOptions) : Plot.barX(markOptions);
                case 'area':
                  return markData ? Plot.area(markData, markOptions) : Plot.area(markOptions);
                case 'rect':
                  return markData ? Plot.rect(markData, markOptions) : Plot.rect(markOptions);
                case 'text':
                  return markData ? Plot.text(markData, markOptions) : Plot.text(markOptions);
                case 'cell':
                  return markData ? Plot.cell(markData, markOptions) : Plot.cell(markOptions);
                case 'ruleX':
                  return markData ? Plot.ruleX(markData, markOptions) : Plot.ruleX(markOptions);
                case 'ruleY':
                  return markData ? Plot.ruleY(markData, markOptions) : Plot.ruleY(markOptions);
                case 'link':
                  return markData ? Plot.link(markData, markOptions) : Plot.link(markOptions);
                case 'frame':
                  return Plot.frame(markOptions);
                case 'axisX':
                  return Plot.axisX(markOptions);
                case 'axisY':
                  return Plot.axisY(markOptions);
                case 'gridX':
                  return Plot.gridX(markOptions);
                case 'gridY':
                  return Plot.gridY(markOptions);
                default:
                  console.warn('Unknown mark type:', markSpec.type);
                  return null;
              }
            }
            // Return as-is if it's already a processed mark
            return markSpec;
          }).filter(function(mark) { return mark !== null; });
        }
        
        // Add width and height to spec if not already specified
        if (!spec.width && width) {
          spec.width = width;
        }
        if (!spec.height && height) {
          spec.height = height;
        }
        
        // Default options if not specified
        if (!spec.marks) {
          spec.marks = [];
        }
        
        // Debug logging
        console.log("Creating plot with spec:", spec);
        
        try {
          // Check if Plot is available
          if (typeof Plot === 'undefined') {
            throw new Error('Plot library not loaded. Please check that plot.min.js is included.');
          }
          
          // Create the plot
          plot = Plot.plot(spec);
          
          // Append to the element
          el.appendChild(plot);
          console.log("Plot created successfully");
        } catch(e) {
          console.error("Error creating plot:", e);
          console.error("Spec was:", spec);
          el.innerHTML = '<div style="color: red;">Error creating plot: ' + e.message + '</div>';
        }
      },

      resize: function(width, height) {
        // Re-render with new dimensions if plot exists
        if (this.lastValue) {
          this.lastValue.spec.width = width;
          this.lastValue.spec.height = height;
          this.renderValue(this.lastValue);
        }
      }

    };
  }
});