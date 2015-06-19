library mandrill_api;

import 'dart:async' as async;
import 'dart:convert' as convert;

class MandrillError implements Exception {
  final String msg;
  const MandrillError([this.msg]);
  String toString() => (msg != null) ? msg : 'MandrillError';
}

class ValidationError extends MandrillError {
  const ValidationError(msg) : super(msg);
}
class InvalidKeyError extends MandrillError {
  const InvalidKeyError(msg) : super(msg);
}
class PaymentRequiredError extends MandrillError {
  const PaymentRequiredError(msg) : super(msg);
}
class UnknownSubaccountError extends MandrillError {
  const UnknownSubaccountError(msg) : super(msg);
}
class UnknownTemplateError extends MandrillError {
  const UnknownTemplateError(msg) : super(msg);
}
class ServiceUnavailableError extends MandrillError {
  const ServiceUnavailableError(msg) : super(msg);
}
class UnknownMessageError extends MandrillError {
  const UnknownMessageError(msg) : super(msg);
}
class InvalidTagNameError extends MandrillError {
  const InvalidTagNameError(msg) : super(msg);
}
class InvalidRejectError extends MandrillError {
  const InvalidRejectError(msg) : super(msg);
}
class UnknownSenderError extends MandrillError {
  const UnknownSenderError(msg) : super(msg);
}
class UnknownUrlError extends MandrillError {
  const UnknownUrlError(msg) : super(msg);
}
class UnknownTrackingDomainError extends MandrillError {
  const UnknownTrackingDomainError(msg) : super(msg);
}
class InvalidTemplateError extends MandrillError {
  const InvalidTemplateError(msg) : super(msg);
}
class UnknownWebhookError extends MandrillError {
  const UnknownWebhookError(msg) : super(msg);
}
class UnknownInboundDomainError extends MandrillError {
  const UnknownInboundDomainError(msg) : super(msg);
}
class UnknownInboundRouteError extends MandrillError {
  const UnknownInboundRouteError(msg) : super(msg);
}
class UnknownExportError extends MandrillError {
  const UnknownExportError(msg) : super(msg);
}
class IPProvisionLimitError extends MandrillError {
  const IPProvisionLimitError(msg) : super(msg);
}
class UnknownPoolError extends MandrillError {
  const UnknownPoolError(msg) : super(msg);
}
class NoSendingHistoryError extends MandrillError {
  const NoSendingHistoryError(msg) : super(msg);
}
class PoorReputationError extends MandrillError {
  const PoorReputationError(msg) : super(msg);
}
class UnknownIPError extends MandrillError {
  const UnknownIPError(msg) : super(msg);
}
class InvalidEmptyDefaultPoolError extends MandrillError {
  const InvalidEmptyDefaultPoolError(msg) : super(msg);
}
class InvalidDeleteDefaultPoolError extends MandrillError {
  const InvalidDeleteDefaultPoolError(msg) : super(msg);
}
class InvalidDeleteNonEmptyPoolError extends MandrillError {
  const InvalidDeleteNonEmptyPoolError(msg) : super(msg);
}
class InvalidCustomDNSError extends MandrillError {
  const InvalidCustomDNSError(msg) : super(msg);
}
class InvalidCustomDNSPendingError extends MandrillError {
  const InvalidCustomDNSPendingError(msg) : super(msg);
}
class MetadataFieldLimitError extends MandrillError {
  const MetadataFieldLimitError(msg) : super(msg);
}
class UnknownMetadataFieldError extends MandrillError {
  const UnknownMetadataFieldError(msg) : super(msg);
}

var MANDRILL_OPTS = {
  'host': 'mandrillapp.com',
  'port': 443,
  'prefix': '/api/1.0/',
  'headers': {
    'Content-Type': 'application/json',
    'User-Agent': 'Mandrill-Dart/1.0.4'
  }
};

abstract class APIBase {
  String apikey;
  bool debug;
  var templates;
  var exports;
  var users;
  var rejects;
  var inbound;
  var tags;
  var messages;
  var whitelists;
  var ips;
  var internal;
  var subaccounts;
  var urls;
  var webhooks;
  var senders;
  var metadata;

  ///Initialize the API client, using [apikey] as the API key
  APIBase(this.apikey, [this.debug = false]) {
    templates = new Templates(this);
    exports = new Exports(this);
    users = new Users(this);
    rejects = new Rejects(this);
    inbound = new Inbound(this);
    tags = new Tags(this);
    messages = new Messages(this);
    whitelists = new Whitelists(this);
    ips = new Ips(this);
    internal = new Internal(this);
    subaccounts = new Subaccounts(this);
    urls = new Urls(this);
    webhooks = new Webhooks(this);
    senders = new Senders(this);
    metadata = new Metadata(this);
  }

  ///Build the API call and delegate to the appropriate implementation for making the call
  async.Future call(String uri, Map params) {
    params['key'] = apikey;
    var params_str = convert.JSON.encode(params);
    uri = [
      'https://',
      MANDRILL_OPTS['host'],
      MANDRILL_OPTS['prefix'],
      uri,
      '.json'
    ].join();
    return request(Uri.parse(uri), MANDRILL_OPTS['headers'], params_str);
  }

  ///Method to be overridden by server and browser specific implementations to make an HTTP request
  async.Future request(Uri uri, Map headers, String body);

  ///Read the error type out of the error body and cast it to the appropriate exception type
  MandrillError castMandrillError(Map errorBody) {
    switch (errorBody['name']) {
      case 'ValidationError':
        return new ValidationError(errorBody['message']);
      case 'Invalid_Key':
        return new InvalidKeyError(errorBody['message']);
      case 'PaymentRequired':
        return new PaymentRequiredError(errorBody['message']);
      case 'Unknown_Subaccount':
        return new UnknownSubaccountError(errorBody['message']);
      case 'Unknown_Template':
        return new UnknownTemplateError(errorBody['message']);
      case 'ServiceUnavailable':
        return new ServiceUnavailableError(errorBody['message']);
      case 'Unknown_Message':
        return new UnknownMessageError(errorBody['message']);
      case 'Invalid_Tag_Name':
        return new InvalidTagNameError(errorBody['message']);
      case 'Invalid_Reject':
        return new InvalidRejectError(errorBody['message']);
      case 'Unknown_Sender':
        return new UnknownSenderError(errorBody['message']);
      case 'Unknown_Url':
        return new UnknownUrlError(errorBody['message']);
      case 'Unknown_TrackingDomain':
        return new UnknownTrackingDomainError(errorBody['message']);
      case 'Invalid_Template':
        return new InvalidTemplateError(errorBody['message']);
      case 'Unknown_Webhook':
        return new UnknownWebhookError(errorBody['message']);
      case 'Unknown_InboundDomain':
        return new UnknownInboundDomainError(errorBody['message']);
      case 'Unknown_InboundRoute':
        return new UnknownInboundRouteError(errorBody['message']);
      case 'Unknown_Export':
        return new UnknownExportError(errorBody['message']);
      case 'IP_ProvisionLimit':
        return new IPProvisionLimitError(errorBody['message']);
      case 'Unknown_Pool':
        return new UnknownPoolError(errorBody['message']);
      case 'NoSendingHistory':
        return new NoSendingHistoryError(errorBody['message']);
      case 'PoorReputation':
        return new PoorReputationError(errorBody['message']);
      case 'Unknown_IP':
        return new UnknownIPError(errorBody['message']);
      case 'Invalid_EmptyDefaultPool':
        return new InvalidEmptyDefaultPoolError(errorBody['message']);
      case 'Invalid_DeleteDefaultPool':
        return new InvalidDeleteDefaultPoolError(errorBody['message']);
      case 'Invalid_DeleteNonEmptyPool':
        return new InvalidDeleteNonEmptyPoolError(errorBody['message']);
      case 'Invalid_CustomDNS':
        return new InvalidCustomDNSError(errorBody['message']);
      case 'Invalid_CustomDNSPending':
        return new InvalidCustomDNSPendingError(errorBody['message']);
      case 'Metadata_FieldLimit':
        return new MetadataFieldLimitError(errorBody['message']);
      case 'Unknown_MetadataField':
        return new UnknownMetadataFieldError(errorBody['message']);
      default:
        //The type might be newer than the client, so use a generic type where necessary
        return new MandrillError(
            errorBody['name'] + ': ' + errorBody['message']);
    }
  }

  ///Check if the response is an error and cast it to an exception or return the successful value
  handleResponse(int statusCode, String body) {
    if (statusCode != 200) {
      var error;
      try {
        error = castMandrillError(convert.JSON.decode(body));
      } catch (e) {
        error = new MandrillError('We received an unexpected error: $body');
      }
      throw error;
    } else {
      return convert.JSON.decode(body);
    }
  }
}

///Namespace to document and complete templates calls
class Templates {
  APIBase master;

  Templates(this.master);

  /**Add a new template
   */
  async.Future add(String name, [String from_Email = null,
      String from_Name = null, String subject = null, String code = null,
      String text = null, bool publish = true, List labels = null]) {
    var _params = {
      'name': name,
      'from_email': from_Email,
      'from_name': from_Name,
      'subject': subject,
      'code': code,
      'text': text,
      'publish': publish,
      'labels': labels
    };
    return master.call('templates/add', _params);
  }
  /**Get the information for an existing template
   */
  async.Future info(String name) {
    var _params = {'name': name};
    return master.call('templates/info', _params);
  }
  /**Update the code for an existing template. If null is provided for any fields, the values will remain unchanged.
   */
  async.Future update(String name, [String from_Email = null,
      String from_Name = null, String subject = null, String code = null,
      String text = null, bool publish = true, List labels = null]) {
    var _params = {
      'name': name,
      'from_email': from_Email,
      'from_name': from_Name,
      'subject': subject,
      'code': code,
      'text': text,
      'publish': publish,
      'labels': labels
    };
    return master.call('templates/update', _params);
  }
  /**Publish the content for the template. Any new messages sent using this template will start using the content that was previously in draft.
   */
  async.Future publish(String name) {
    var _params = {'name': name};
    return master.call('templates/publish', _params);
  }
  /**Delete a template
   */
  async.Future delete(String name) {
    var _params = {'name': name};
    return master.call('templates/delete', _params);
  }
  /**Return a list of all the templates available to this user
   */
  async.Future list([String label = null]) {
    var _params = {'label': label};
    return master.call('templates/list', _params);
  }
  /**Return the recent history (hourly stats for the last 30 days) for a template
   */
  async.Future timeSeries(String name) {
    var _params = {'name': name};
    return master.call('templates/time-series', _params);
  }
  /**Inject content and optionally merge fields into a template, returning the HTML that results
   */
  async.Future render(String template_Name, List template_Content,
      [List merge_Vars = null]) {
    var _params = {
      'template_name': template_Name,
      'template_content': template_Content,
      'merge_vars': merge_Vars
    };
    return master.call('templates/render', _params);
  }
}
///Namespace to document and complete exports calls
class Exports {
  APIBase master;

  Exports(this.master);

  /**Returns information about an export job. If the export job's state is 'complete',
the returned data will include a URL you can use to fetch the results. Every export
job produces a zip archive, but the format of the archive is distinct for each job
type. The api calls that initiate exports include more details about the output format
for that job type.
   */
  async.Future info(String id) {
    var _params = {'id': id};
    return master.call('exports/info', _params);
  }
  /**Returns a list of your exports.
   */
  async.Future list() {
    var _params = {};
    return master.call('exports/list', _params);
  }
  /**Begins an export of your rejection blacklist. The blacklist will be exported to a zip archive
containing a single file named rejects.csv that includes the following fields: email,
reason, detail, created_at, expires_at, last_event_at, expires_at.
   */
  async.Future rejects([String notify_Email = null]) {
    var _params = {'notify_email': notify_Email};
    return master.call('exports/rejects', _params);
  }
  /**Begins an export of your rejection whitelist. The whitelist will be exported to a zip archive
containing a single file named whitelist.csv that includes the following fields:
email, detail, created_at.
   */
  async.Future whitelist([String notify_Email = null]) {
    var _params = {'notify_email': notify_Email};
    return master.call('exports/whitelist', _params);
  }
  /**Begins an export of your activity history. The activity will be exported to a zip archive
containing a single file named activity.csv in the same format as you would be able to export
from your account's activity view. It includes the following fields: Date, Email Address,
Sender, Subject, Status, Tags, Opens, Clicks, Bounce Detail. If you have configured any custom
metadata fields, they will be included in the exported data.
   */
  async.Future activity([String notify_Email = null, String date_From = null,
      String date_To = null, List tags = null, List senders = null,
      List states = null, List api_Keys = null]) {
    var _params = {
      'notify_email': notify_Email,
      'date_from': date_From,
      'date_to': date_To,
      'tags': tags,
      'senders': senders,
      'states': states,
      'api_keys': api_Keys
    };
    return master.call('exports/activity', _params);
  }
}
///Namespace to document and complete users calls
class Users {
  APIBase master;

  Users(this.master);

  /**Return the information about the API-connected user
   */
  async.Future info() {
    var _params = {};
    return master.call('users/info', _params);
  }
  /**Validate an API key and respond to a ping
   */
  async.Future ping() {
    var _params = {};
    return master.call('users/ping', _params);
  }
  /**Validate an API key and respond to a ping (anal JSON parser version)
   */
  async.Future ping2() {
    var _params = {};
    return master.call('users/ping2', _params);
  }
  /**Return the senders that have tried to use this account, both verified and unverified
   */
  async.Future senders() {
    var _params = {};
    return master.call('users/senders', _params);
  }
}
///Namespace to document and complete rejects calls
class Rejects {
  APIBase master;

  Rejects(this.master);

  /**Adds an email to your email rejection blacklist. Addresses that you
add manually will never expire and there is no reputation penalty
for removing them from your blacklist. Attempting to blacklist an
address that has been whitelisted will have no effect.
   */
  async.Future add(String email,
      [String comment = null, String subaccount = null]) {
    var _params = {
      'email': email,
      'comment': comment,
      'subaccount': subaccount
    };
    return master.call('rejects/add', _params);
  }
  /**Retrieves your email rejection blacklist. You can provide an email
address to limit the results. Returns up to 1000 results. By default,
entries that have expired are excluded from the results; set
include_expired to true to include them.
   */
  async.Future list([String email = null, bool include_Expired = false,
      String subaccount = null]) {
    var _params = {
      'email': email,
      'include_expired': include_Expired,
      'subaccount': subaccount
    };
    return master.call('rejects/list', _params);
  }
  /**Deletes an email rejection. There is no limit to how many rejections
you can remove from your blacklist, but keep in mind that each deletion
has an affect on your reputation.
   */
  async.Future delete(String email, [String subaccount = null]) {
    var _params = {'email': email, 'subaccount': subaccount};
    return master.call('rejects/delete', _params);
  }
}
///Namespace to document and complete inbound calls
class Inbound {
  APIBase master;

  Inbound(this.master);

  /**List the domains that have been configured for inbound delivery
   */
  async.Future domains() {
    var _params = {};
    return master.call('inbound/domains', _params);
  }
  /**Add an inbound domain to your account
   */
  async.Future addDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('inbound/add-domain', _params);
  }
  /**Check the MX settings for an inbound domain. The domain must have already been added with the add-domain call
   */
  async.Future checkDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('inbound/check-domain', _params);
  }
  /**Delete an inbound domain from the account. All mail will stop routing for this domain immediately.
   */
  async.Future deleteDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('inbound/delete-domain', _params);
  }
  /**List the mailbox routes defined for an inbound domain
   */
  async.Future routes(String domain) {
    var _params = {'domain': domain};
    return master.call('inbound/routes', _params);
  }
  /**Add a new mailbox route to an inbound domain
   */
  async.Future addRoute(String domain, String pattern, String url) {
    var _params = {'domain': domain, 'pattern': pattern, 'url': url};
    return master.call('inbound/add-route', _params);
  }
  /**Update the pattern or webhook of an existing inbound mailbox route. If null is provided for any fields, the values will remain unchanged.
   */
  async.Future updateRoute(String id,
      [String pattern = null, String url = null]) {
    var _params = {'id': id, 'pattern': pattern, 'url': url};
    return master.call('inbound/update-route', _params);
  }
  /**Delete an existing inbound mailbox route
   */
  async.Future deleteRoute(String id) {
    var _params = {'id': id};
    return master.call('inbound/delete-route', _params);
  }
  /**Take a raw MIME document destined for a domain with inbound domains set up, and send it to the inbound hook exactly as if it had been sent over SMTP
   */
  async.Future sendRaw(String raw_Message, [List to = null,
      String mail_From = null, String helo = null,
      String client_Address = null]) {
    var _params = {
      'raw_message': raw_Message,
      'to': to,
      'mail_from': mail_From,
      'helo': helo,
      'client_address': client_Address
    };
    return master.call('inbound/send-raw', _params);
  }
}
///Namespace to document and complete tags calls
class Tags {
  APIBase master;

  Tags(this.master);

  /**Return all of the user-defined tag information
   */
  async.Future list() {
    var _params = {};
    return master.call('tags/list', _params);
  }
  /**Deletes a tag permanently. Deleting a tag removes the tag from any messages
that have been sent, and also deletes the tag's stats. There is no way to
undo this operation, so use it carefully.
   */
  async.Future delete(String tag) {
    var _params = {'tag': tag};
    return master.call('tags/delete', _params);
  }
  /**Return more detailed information about a single tag, including aggregates of recent stats
   */
  async.Future info(String tag) {
    var _params = {'tag': tag};
    return master.call('tags/info', _params);
  }
  /**Return the recent history (hourly stats for the last 30 days) for a tag
   */
  async.Future timeSeries(String tag) {
    var _params = {'tag': tag};
    return master.call('tags/time-series', _params);
  }
  /**Return the recent history (hourly stats for the last 30 days) for all tags
   */
  async.Future allTimeSeries() {
    var _params = {};
    return master.call('tags/all-time-series', _params);
  }
}
///Namespace to document and complete messages calls
class Messages {
  APIBase master;

  Messages(this.master);

  /**Send a new transactional message through Mandrill
   */
  async.Future send(Map message,
      [bool async = false, String ip_Pool = null, String send_At = null]) {
    var _params = {
      'message': message,
      'async': async,
      'ip_pool': ip_Pool,
      'send_at': send_At
    };
    return master.call('messages/send', _params);
  }
  /**Send a new transactional message through Mandrill using a template
   */
  async.Future sendTemplate(
      String template_Name, List template_Content, Map message,
      [bool async = false, String ip_Pool = null, String send_At = null]) {
    var _params = {
      'template_name': template_Name,
      'template_content': template_Content,
      'message': message,
      'async': async,
      'ip_pool': ip_Pool,
      'send_at': send_At
    };
    return master.call('messages/send-template', _params);
  }
  /**Search recently sent messages and optionally narrow by date range, tags, senders, and API keys. If no date range is specified, results within the last 7 days are returned. This method may be called up to 20 times per minute. If you need the data more often, you can use <a href="/api/docs/messages.html#method=info">/messages/info.json</a> to get the information for a single message, or <a href="http://help.mandrill.com/entries/21738186-Introduction-to-Webhooks">webhooks</a> to push activity to your own application for querying.
   */
  async.Future search([String query = "*", String date_From = null,
      String date_To = null, List tags = null, List senders = null,
      List api_Keys = null, int limit = 100]) {
    var _params = {
      'query': query,
      'date_from': date_From,
      'date_to': date_To,
      'tags': tags,
      'senders': senders,
      'api_keys': api_Keys,
      'limit': limit
    };
    return master.call('messages/search', _params);
  }
  /**Search the content of recently sent messages and return the aggregated hourly stats for matching messages
   */
  async.Future searchTimeSeries([String query = "*", String date_From = null,
      String date_To = null, List tags = null, List senders = null]) {
    var _params = {
      'query': query,
      'date_from': date_From,
      'date_to': date_To,
      'tags': tags,
      'senders': senders
    };
    return master.call('messages/search-time-series', _params);
  }
  /**Get the information for a single recently sent message
   */
  async.Future info(String id) {
    var _params = {'id': id};
    return master.call('messages/info', _params);
  }
  /**Get the full content of a recently sent message
   */
  async.Future content(String id) {
    var _params = {'id': id};
    return master.call('messages/content', _params);
  }
  /**Parse the full MIME document for an email message, returning the content of the message broken into its constituent pieces
   */
  async.Future parse(String raw_Message) {
    var _params = {'raw_message': raw_Message};
    return master.call('messages/parse', _params);
  }
  /**Take a raw MIME document for a message, and send it exactly as if it were sent through Mandrill's SMTP servers
   */
  async.Future sendRaw(String raw_Message, [String from_Email = null,
      String from_Name = null, List to = null, bool async = false,
      String ip_Pool = null, String send_At = null,
      String return_Path_Domain = null]) {
    var _params = {
      'raw_message': raw_Message,
      'from_email': from_Email,
      'from_name': from_Name,
      'to': to,
      'async': async,
      'ip_pool': ip_Pool,
      'send_at': send_At,
      'return_path_domain': return_Path_Domain
    };
    return master.call('messages/send-raw', _params);
  }
  /**Queries your scheduled emails by sender or recipient, or both.
   */
  async.Future listScheduled([String to = null]) {
    var _params = {'to': to};
    return master.call('messages/list-scheduled', _params);
  }
  /**Cancels a scheduled email.
   */
  async.Future cancelScheduled(String id) {
    var _params = {'id': id};
    return master.call('messages/cancel-scheduled', _params);
  }
  /**Reschedules a scheduled email.
   */
  async.Future reschedule(String id, String send_At) {
    var _params = {'id': id, 'send_at': send_At};
    return master.call('messages/reschedule', _params);
  }
}
///Namespace to document and complete whitelists calls
class Whitelists {
  APIBase master;

  Whitelists(this.master);

  /**Adds an email to your email rejection whitelist. If the address is
currently on your blacklist, that blacklist entry will be removed
automatically.
   */
  async.Future add(String email, [String comment = null]) {
    var _params = {'email': email, 'comment': comment};
    return master.call('whitelists/add', _params);
  }
  /**Retrieves your email rejection whitelist. You can provide an email
address or search prefix to limit the results. Returns up to 1000 results.
   */
  async.Future list([String email = null]) {
    var _params = {'email': email};
    return master.call('whitelists/list', _params);
  }
  /**Removes an email address from the whitelist.
   */
  async.Future delete(String email) {
    var _params = {'email': email};
    return master.call('whitelists/delete', _params);
  }
}
///Namespace to document and complete ips calls
class Ips {
  APIBase master;

  Ips(this.master);

  /**Lists your dedicated IPs.
   */
  async.Future list() {
    var _params = {};
    return master.call('ips/list', _params);
  }
  /**Retrieves information about a single dedicated ip.
   */
  async.Future info(String ip) {
    var _params = {'ip': ip};
    return master.call('ips/info', _params);
  }
  /**Requests an additional dedicated IP for your account. Accounts may
have one outstanding request at any time, and provisioning requests
are processed within 24 hours.
   */
  async.Future provision([bool warmup = false, String pool = null]) {
    var _params = {'warmup': warmup, 'pool': pool};
    return master.call('ips/provision', _params);
  }
  /**Begins the warmup process for a dedicated IP. During the warmup process,
Mandrill will gradually increase the percentage of your mail that is sent over
the warming-up IP, over a period of roughly 30 days. The rest of your mail
will be sent over shared IPs or other dedicated IPs in the same pool.
   */
  async.Future startWarmup(String ip) {
    var _params = {'ip': ip};
    return master.call('ips/start-warmup', _params);
  }
  /**Cancels the warmup process for a dedicated IP.
   */
  async.Future cancelWarmup(String ip) {
    var _params = {'ip': ip};
    return master.call('ips/cancel-warmup', _params);
  }
  /**Moves a dedicated IP to a different pool.
   */
  async.Future setPool(String ip, String pool, [bool create_Pool = false]) {
    var _params = {'ip': ip, 'pool': pool, 'create_pool': create_Pool};
    return master.call('ips/set-pool', _params);
  }
  /**Deletes a dedicated IP. This is permanent and cannot be undone.
   */
  async.Future delete(String ip) {
    var _params = {'ip': ip};
    return master.call('ips/delete', _params);
  }
  /**Lists your dedicated IP pools.
   */
  async.Future listPools() {
    var _params = {};
    return master.call('ips/list-pools', _params);
  }
  /**Describes a single dedicated IP pool.
   */
  async.Future poolInfo(String pool) {
    var _params = {'pool': pool};
    return master.call('ips/pool-info', _params);
  }
  /**Creates a pool and returns it. If a pool already exists with this
name, no action will be performed.
   */
  async.Future createPool(String pool) {
    var _params = {'pool': pool};
    return master.call('ips/create-pool', _params);
  }
  /**Deletes a pool. A pool must be empty before you can delete it, and you cannot delete your default pool.
   */
  async.Future deletePool(String pool) {
    var _params = {'pool': pool};
    return master.call('ips/delete-pool', _params);
  }
  /**Tests whether a domain name is valid for use as the custom reverse
DNS for a dedicated IP.
   */
  async.Future checkCustomDns(String ip, String domain) {
    var _params = {'ip': ip, 'domain': domain};
    return master.call('ips/check-custom-dns', _params);
  }
  /**Configures the custom DNS name for a dedicated IP.
   */
  async.Future setCustomDns(String ip, String domain) {
    var _params = {'ip': ip, 'domain': domain};
    return master.call('ips/set-custom-dns', _params);
  }
}
///Namespace to document and complete internal calls
class Internal {
  APIBase master;

  Internal(this.master);
}
///Namespace to document and complete subaccounts calls
class Subaccounts {
  APIBase master;

  Subaccounts(this.master);

  /**Get the list of subaccounts defined for the account, optionally filtered by a prefix
   */
  async.Future list([String q = null]) {
    var _params = {'q': q};
    return master.call('subaccounts/list', _params);
  }
  /**Add a new subaccount
   */
  async.Future add(String id,
      [String name = null, String notes = null, int custom_Quota = null]) {
    var _params = {
      'id': id,
      'name': name,
      'notes': notes,
      'custom_quota': custom_Quota
    };
    return master.call('subaccounts/add', _params);
  }
  /**Given the ID of an existing subaccount, return the data about it
   */
  async.Future info(String id) {
    var _params = {'id': id};
    return master.call('subaccounts/info', _params);
  }
  /**Update an existing subaccount
   */
  async.Future update(String id,
      [String name = null, String notes = null, int custom_Quota = null]) {
    var _params = {
      'id': id,
      'name': name,
      'notes': notes,
      'custom_quota': custom_Quota
    };
    return master.call('subaccounts/update', _params);
  }
  /**Delete an existing subaccount. Any email related to the subaccount will be saved, but stats will be removed and any future sending calls to this subaccount will fail.
   */
  async.Future delete(String id) {
    var _params = {'id': id};
    return master.call('subaccounts/delete', _params);
  }
  /**Pause a subaccount's sending. Any future emails delivered to this subaccount will be queued for a maximum of 3 days until the subaccount is resumed.
   */
  async.Future pause(String id) {
    var _params = {'id': id};
    return master.call('subaccounts/pause', _params);
  }
  /**Resume a paused subaccount's sending
   */
  async.Future resume(String id) {
    var _params = {'id': id};
    return master.call('subaccounts/resume', _params);
  }
}
///Namespace to document and complete urls calls
class Urls {
  APIBase master;

  Urls(this.master);

  /**Get the 100 most clicked URLs
   */
  async.Future list() {
    var _params = {};
    return master.call('urls/list', _params);
  }
  /**Return the 100 most clicked URLs that match the search query given
   */
  async.Future search(String q) {
    var _params = {'q': q};
    return master.call('urls/search', _params);
  }
  /**Return the recent history (hourly stats for the last 30 days) for a url
   */
  async.Future timeSeries(String url) {
    var _params = {'url': url};
    return master.call('urls/time-series', _params);
  }
  /**Get the list of tracking domains set up for this account
   */
  async.Future trackingDomains() {
    var _params = {};
    return master.call('urls/tracking-domains', _params);
  }
  /**Add a tracking domain to your account
   */
  async.Future addTrackingDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('urls/add-tracking-domain', _params);
  }
  /**Checks the CNAME settings for a tracking domain. The domain must have been added already with the add-tracking-domain call
   */
  async.Future checkTrackingDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('urls/check-tracking-domain', _params);
  }
}
///Namespace to document and complete webhooks calls
class Webhooks {
  APIBase master;

  Webhooks(this.master);

  /**Get the list of all webhooks defined on the account
   */
  async.Future list() {
    var _params = {};
    return master.call('webhooks/list', _params);
  }
  /**Add a new webhook
   */
  async.Future add(String url,
      [String description = null, List events = null]) {
    var _params = {'url': url, 'description': description, 'events': events};
    return master.call('webhooks/add', _params);
  }
  /**Given the ID of an existing webhook, return the data about it
   */
  async.Future info(int id) {
    var _params = {'id': id};
    return master.call('webhooks/info', _params);
  }
  /**Update an existing webhook
   */
  async.Future update(int id, String url,
      [String description = null, List events = null]) {
    var _params = {
      'id': id,
      'url': url,
      'description': description,
      'events': events
    };
    return master.call('webhooks/update', _params);
  }
  /**Delete an existing webhook
   */
  async.Future delete(int id) {
    var _params = {'id': id};
    return master.call('webhooks/delete', _params);
  }
}
///Namespace to document and complete senders calls
class Senders {
  APIBase master;

  Senders(this.master);

  /**Return the senders that have tried to use this account.
   */
  async.Future list() {
    var _params = {};
    return master.call('senders/list', _params);
  }
  /**Returns the sender domains that have been added to this account.
   */
  async.Future domains() {
    var _params = {};
    return master.call('senders/domains', _params);
  }
  /**Adds a sender domain to your account. Sender domains are added automatically as you
send, but you can use this call to add them ahead of time.
   */
  async.Future addDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('senders/add-domain', _params);
  }
  /**Checks the SPF and DKIM settings for a domain. If you haven't already added this domain to your
account, it will be added automatically.
   */
  async.Future checkDomain(String domain) {
    var _params = {'domain': domain};
    return master.call('senders/check-domain', _params);
  }
  /**Sends a verification email in order to verify ownership of a domain.
Domain verification is an optional step to confirm ownership of a domain. Once a
domain has been verified in a Mandrill account, other accounts may not have their
messages signed by that domain unless they also verify the domain. This prevents
other Mandrill accounts from sending mail signed by your domain.
   */
  async.Future verifyDomain(String domain, String mailbox) {
    var _params = {'domain': domain, 'mailbox': mailbox};
    return master.call('senders/verify-domain', _params);
  }
  /**Return more detailed information about a single sender, including aggregates of recent stats
   */
  async.Future info(String address) {
    var _params = {'address': address};
    return master.call('senders/info', _params);
  }
  /**Return the recent history (hourly stats for the last 30 days) for a sender
   */
  async.Future timeSeries(String address) {
    var _params = {'address': address};
    return master.call('senders/time-series', _params);
  }
}
///Namespace to document and complete metadata calls
class Metadata {
  APIBase master;

  Metadata(this.master);

  /**Get the list of custom metadata fields indexed for the account.
   */
  async.Future list() {
    var _params = {};
    return master.call('metadata/list', _params);
  }
  /**Add a new custom metadata field to be indexed for the account.
   */
  async.Future add(String name, [String view_Template = null]) {
    var _params = {'name': name, 'view_template': view_Template};
    return master.call('metadata/add', _params);
  }
  /**Update an existing custom metadata field.
   */
  async.Future update(String name, String view_Template) {
    var _params = {'name': name, 'view_template': view_Template};
    return master.call('metadata/update', _params);
  }
  /**Delete an existing custom metadata field. Deletion isn't instataneous, and /metadata/list will continue to return the field until the asynchronous deletion process is complete.
   */
  async.Future delete(String name) {
    var _params = {'name': name};
    return master.call('metadata/delete', _params);
  }
}
