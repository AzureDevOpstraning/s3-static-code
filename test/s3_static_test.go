package test


import (
"io"
"net/http"
"strings"
"testing"


"github.com/gruntwork-io/terratest/modules/terraform"
"github.com/stretchr/testify/assert"
)


func TestS3StaticSite(t *testing.T) {
t.Parallel()


opts := &terraform.Options{
TerraformDir: "..",
}


// Destroy at the end of the test run
defer terraform.Destroy(t, opts)


// Init and apply
terraform.InitAndApply(t, opts)


websiteURL := terraform.Output(t, opts, "website_url")


// website_url sometimes returns host without scheme, ensure we have scheme
if !strings.HasPrefix(websiteURL, "http") {
websiteURL = "http://" + websiteURL
}


resp, err := http.Get(websiteURL)
assert.NoError(t, err)
defer resp.Body.Close()


body, err := io.ReadAll(resp.Body)
assert.NoError(t, err)
assert.Equal(t, 200, resp.StatusCode)
assert.Contains(t, string(body), "Hello World")
}