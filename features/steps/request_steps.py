from behave import given, when, then
import requests
import json
from jsonschema import validate

from features.steps.utils import get_json_data

api_url = "https://localhost:8080/"
token = ""
headers = {'Authorization': "Bearer {}".format(token)}
params = {}


@given(u'the endpoint {endpoint}')
def step_impl(context, endpoint):
    context.url = api_url + endpoint + '/'
    # asserts can be added as required

@given(u'Balance is {value}')
def step_impl(context, parameter, value):
    params["Balance"] = value
    context.data = params
    # asserts can be added as required

@given(u'Account name is {value}')
def step_impl(context, parameter, value):
    params["AccountName"] = value
    context.data = params
    # asserts can be added as required

@given(u'Address is {value}')
def step_impl(context, parameter, value):
    params["Address"] = value
    context.data = params
    # asserts can be added as required

@given(u'id {resource_id}')
def step_impl(context, resource_id):
    context.url = context.url + resource_id
    # asserts can be added as required

@given(u'param {parameter} {value}')
def step_impl(context, parameter, value):
    params[parameter] = value
    context.data = params
    # asserts can be added as required

@when(u'method get')
def step_impl(context):
    context.response = requests.get(context.url, headers=headers)
    # asserts can be added as required

@when(u'method post with params')
def step_impl(context):
    context.response = requests.post(context.url, params=context.data, headers=headers)
    # asserts can be added as required

@then(u'the response status is {response_status}')
def step_impl(context, response_status):
    assert int(context.response.status_code) == int(response_status)
    # asserts can be added as required

@then(u'the response matches {response_schema} schema')
def step_impl(context, response_schema):
    expected_response = get_json_data("../schemas/", response_schema)
    response_content = json.loads(context.response.content)
    validate(response_content, expected_response)
    # asserts can be added as required

@then(u'the response equals {response_json} json')
def step_impl(context, response_json):
    expected_response = get_json_data("../json_responses/", response_json)
    response_content = json.loads(context.response.content)
    print(response_content)
    assert expected_response == response_content
    # asserts can be added as required