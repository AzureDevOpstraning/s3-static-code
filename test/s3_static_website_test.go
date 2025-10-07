package test

import (
	"testing"
	"strings"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"net/http"
	"io/ioutil"
)

func TestS3StaticWebsite(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "..",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	websiteURL := terraform.Output(t, terraformOptions, "website_url")
	resp, err := http.Get("http://" + websiteURL)
	assert.NoError(t, err)
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)
	assert.True(t, strings.Contains(string(body), "Hello World"))
}
