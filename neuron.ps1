class Neuron {
    [double[]] $weights;
    [int] $bias = 0;
    [int] $funcType = 0;
    
    Neuron([int] $numInputs) {
        $this.weights = [int[]]::new($numInputs);

        # Initialize the individual elements.
        for($ii = 0; $ii -lt $numInputs; $ii++) {
            $this.weights[$ii] = Get-Random -Minimum -1.0 -Maximum 1.0;
        }
    }

    static [double]Hardlim([double] $x) {
        if($x -lt 0) { return 0.0 } else { return 1.0 };
    }

    [double]Compute([double[]] $p) {
        $computation = $this.bias;
        $output = 0;

        for($ii = 0; $ii -lt $this.weights.length; $ii++) {
            $computation = $computation + $this.weights[$ii] * $p[$ii];
        }

        $output = switch($this.funcType) {
            0       { [Neuron]::Hardlim($computation) }
            default { [Neuron]::Hardlim($computation) }
        }

        return $output;
    }

    # p = test input
    # t = expected ouput
    # return $true if expected output = actual output
    [bool]Train([double[]] $p, [double] $t) {
        $err = $t - $this.Compute($p);

        if($err -ne 0) {
            # Update weights and bias
            $this.bias = $this.bias + $err;

            for($ii = 0; $ii -lt $this.weights.Length; $ii++) {
                $this.weights[$ii] = $this.weights[$ii] + $err * $p[$ii];
            }
            return $false;
        }

        return $true;
    }
}
