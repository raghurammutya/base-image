$token = Read-Host -AsSecureString "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"
$plainToken = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($token))
$plainToken | docker login ghcr.io -u raghurammutya --password-stdin
