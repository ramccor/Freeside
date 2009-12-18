#
# WARNING: NEVER EDIT RT_Config.pm. Instead, copy any sections you want to change to RT_SiteConfig.pm
# and edit them there.
#

package RT;

=head1 NAME

RT::Config

=for testing

use RT::Config;

=cut

# {{{ Base Configuration

# $rtname is the string that RT will look for in mail messages to
# figure out what ticket a new piece of mail belongs to

# Your domain name is recommended, so as not to pollute the namespace.
# once you start using a given tag, you should probably never change it.
# (otherwise, mail for existing tickets won't get put in the right place

Set($rtname , "example.com");


# This regexp controls what subject tags RT recognizes as its own.
# If you're not dealing with historical $rtname values, you'll likely
# never have to enable this feature.
#
# Be VERY CAREFUL with it. Note that it overrides $rtname for subject
# token matching and that you should use only "non-capturing" parenthesis
# grouping. For example:
#
# 	Set($EmailSubjectTagRegex, qr/(?:example.com|example.org)/i );
#
# and NOT
# 
# 	Set($EmailSubjectTagRegex, qr/(example.com|example.org)/i );
#
# This setting would make RT behave exactly as it does without the 
# setting enabled.
#
# Set($EmailSubjectTagRegex, qr/\Q$rtname\E/i );



# You should set this to your organization's DNS domain. For example,
# fsck.com or asylum.arkham.ma.us. It's used by the linking interface to
# guarantee that ticket URIs are unique and easy to construct.

Set($Organization , "example.com");

# $user_passwd_min defines the minimum length for user passwords. Setting
# it to 0 disables this check
Set($MinimumPasswordLength , "5");

# $Timezone is used to convert times entered by users into GMT and back again
# It should be set to a timezone recognized by your local unix box.
Set($Timezone , 'US/Eastern');

# }}}

# {{{ Database Configuration

# Database driver beeing used. Case matters
# Valid types are "mysql", "Oracle" and "Pg"

Set($DatabaseType , 'SQLite');

# The domain name of your database server
# If you're running mysql and it's on localhost,
# leave it blank for enhanced performance
Set($DatabaseHost   , 'localhost');
Set($DatabaseRTHost , 'localhost');

# The port that your database server is running on.  Ignored unless it's
# a positive integer. It's usually safe to leave this blank
Set($DatabasePort , '');

#The name of the database user (inside the database)
Set($DatabaseUser , 'rt_user');

# Password the DatabaseUser should use to access the database
Set($DatabasePassword , 'rt_pass');

# The name of the RT's database on your database server
Set($DatabaseName , 'rt3');

# If you're using Postgres and have compiled in SSL support,
# set DatabaseRequireSSL to 1 to turn on SSL communication
Set($DatabaseRequireSSL , undef);

# }}}

# {{{ Incoming mail gateway configuration

# OwnerEmail is the address of a human who manages RT. RT will send
# errors generated by the mail gateway to this address.  This address
# should _not_ be an address that's managed by your RT instance.

Set($OwnerEmail , 'root');

# If $LoopsToRTOwner is defined, RT will send mail that it believes
# might be a loop to $RT::OwnerEmail

Set($LoopsToRTOwner , 1);

# If $StoreLoops is defined, RT will record messages that it believes
# to be part of mail loops.
# As it does this, it will try to be careful not to send mail to the
# sender of these messages

Set($StoreLoops , undef);

# $MaxAttachmentSize sets the maximum size (in bytes) of attachments stored
# in the database.

# For mysql and oracle, we set this size at 10 megabytes.
# If you're running a postgres version earlier than 7.1, you will need
# to drop this to 8192. (8k)

Set($MaxAttachmentSize , 10000000);

# $TruncateLongAttachments: if this is set to a non-undef value,
# RT will truncate attachments longer than MaxAttachmentSize.

Set($TruncateLongAttachments , undef);

# $DropLongAttachments: if this is set to a non-undef value,
# RT will silently drop attachments longer than MaxAttachmentSize.

Set($DropLongAttachments , undef);

# If $ParseNewMessageForTicketCcs is true, RT will attempt to divine
# Ticket 'Cc' watchers from the To and Cc lines of incoming messages
# Be forewarned that if you have _any_ addresses which forward mail to
# RT automatically and you enable this option without modifying
# "RTAddressRegexp" below, you will get yourself into a heap of trouble.

Set($ParseNewMessageForTicketCcs , undef);

# RTAddressRegexp is used to make sure RT doesn't add itself as a ticket CC if
# the setting above is enabled.

Set($RTAddressRegexp , '^rt\@example.com$');

# RT provides functionality which allows the system to rewrite
# incoming email addresses.  In its simplest form,
# you can substitute the value in CanonicalizeEmailAddressReplace
# for the value in CanonicalizeEmailAddressMatch
# (These values are passed to the CanonicalizeEmailAddress subroutine in RT/User.pm)
# By default, that routine performs a s/$Match/$Replace/gi on any address passed to it

#Set($CanonicalizeEmailAddressMatch , '@subdomain\.example\.com$');
#Set($CanonicalizeEmailAddressReplace , '@example.com');

# set this to true and the create new user page will use the values that you
# enter in the form but use the function CanonicalizeUserInfo in User_Local.pm
Set($CanonicalizeOnCreate , 0);

# If $SenderMustExistInExternalDatabase is true, RT will refuse to
# create non-privileged accounts for unknown users if you are using
# the "LookupSenderInExternalDatabase" option.
# Instead, an error message will be mailed and RT will forward the
# message to $RTOwner.
#
# If you are not using $LookupSenderInExternalDatabase, this option
# has no effect.
#
# If you define an AutoRejectRequest template, RT will use this
# template for the rejection message.

Set($SenderMustExistInExternalDatabase , undef);

# }}}

# {{{ Outgoing mail configuration

# RT is designed such that any mail which already has a ticket-id associated
# with it will get to the right place automatically.

# $CorrespondAddress and $CommentAddress are the default addresses
# that will be listed in From: and Reply-To: headers of correspondence
# and comment mail tracked by RT, unless overridden by a queue-specific
# address.

Set($CorrespondAddress , 'RT_CorrespondAddressNotSet');

Set($CommentAddress , 'RT_CommentAddressNotSet');

#Sendmail Configuration

# $MailCommand defines which method RT will use to try to send mail
# We know that 'sendmailpipe' works fairly well.
# If 'sendmailpipe' doesn't work well for you, try 'sendmail'
#
# Note that you should remove the '-t' from $SendmailArguments
# if you use 'sendmail' rather than 'sendmailpipe'

Set($MailCommand , 'sendmailpipe');

# $SendmailArguments defines what flags to pass to $Sendmail
# assuming you picked 'sendmail' or 'sendmailpipe' as the $MailCommand above.
# If you picked 'sendmailpipe', you MUST add a -t flag to $SendmailArguments

# These options are good for most sendmail wrappers and workalikes
Set($SendmailArguments , "-oi -t");

# $SendmailBounceArguments defines what flags to pass to $Sendmail
# assuming RT needs to send an error (ie. bounce).

Set($SendmailBounceArguments , '-f "<>"');

# These arguments are good for sendmail brand sendmail 8 and newer
#Set($SendmailArguments,"-oi -t -ODeliveryMode=b -OErrorMode=m");

# If you selected 'sendmailpipe' above, you MUST specify the path
# to your sendmail binary in $SendmailPath.
# !! If you did not # select 'sendmailpipe' above, this has no effect!!
Set($SendmailPath , "/usr/sbin/sendmail");

# By default, RT sets the outgoing mail's "From:" header to
# "SenderName via RT".  Setting this option to 0 disables it.

Set($UseFriendlyFromLine , 1);

# sprintf() format of the friendly 'From:' header; its arguments
# are SenderName and SenderEmailAddress.
Set($FriendlyFromLineFormat , "\"%s via RT\" <%s>");

# RT can optionally set a "Friendly" 'To:' header when sending messages to
# Ccs or AdminCcs (rather than having a blank 'To:' header.

# This feature DOES NOT WORK WITH SENDMAIL[tm] BRAND SENDMAIL
# If you are using sendmail, rather than postfix, qmail, exim or some other MTA,
# you _must_ disable this option.

Set($UseFriendlyToLine , 0);

# sprintf() format of the friendly 'From:' header; its arguments
# are WatcherType and TicketId.
Set($FriendlyToLineFormat, "\"%s of $RT::rtname Ticket #%s\":;");

# By default, RT doesn't notify the person who performs an update, as they
# already know what they've done. If you'd like to change this behaviour,
# Set $NotifyActor to 1

Set($NotifyActor, 0);

# By default, RT records each message it sends out to its own internal database.# To change this behaviour, set $RecordOutgoingEmail to 0 

Set($RecordOutgoingEmail, 1);

# VERP support (http://cr.yp.to/proto/verp.txt)
# uncomment the following two directives to generate envelope senders
# of the form ${VERPPrefix}${originaladdress}@${VERPDomain}
# (i.e. rt-jesse=fsck.com@rt.example.com ) This currently only works
# with sendmail and sendmailppie.
# Set($VERPPrefix, 'rt-');
# Set($VERPDomain, $RT::Organization);

# }}}

# {{{ Logging

# Logging.  The default is to log anything except debugging
# information to syslog.  Check the Log::Dispatch POD for
# information about how to get things by syslog, mail or anything
# else, get debugging info in the log, etc.

#  It might generally make
# sense to send error and higher by email to some administrator.
# If you do this, be careful that this email isn't sent to this RT instance.

# the minimum level error that will be logged to the specific device.
# levels from lowest to highest:
#  debug info notice warning error critical alert emergency

#  Mail loops will generate a critical log message.
Set($LogToSyslog    , 'debug');
Set($LogToScreen    , 'error');
Set($LogToFile      , undef);
Set($LogDir, '/opt/rt3/var/log');
Set($LogToFileNamed , "rt.log");    #log to rt.log

# If true generates stack traces to file log or screen
# never generates traces to syslog

Set($LogStackTraces , 0);

# On Solaris or UnixWare, set to ( socket => 'inet' ).  Options here
# override any other options RT passes to Log::Dispatch::Syslog.
# Other interesting flags include facility and logopt.  (See the
# Log::Dispatch::Syslog documentation for more information.)  (Maybe
# ident too, if you have multiple RT installations.)

@LogToSyslogConf = () unless (@LogToSyslogConf);

# RT has rudimentary SQL statement logging support if you have
# DBIx-SearchBuilder 1.31_1 or higher; simply set $StatementLog to be
# the level that you wish SQL statements to be logged at.
Set($StatementLog, undef);

# }}}

# {{{ Web interface configuration

# This determines the default stylesheet the RT web interface will use.
# RT ships with two valid values by default:
#
#   3.5-default     The totally new, default layout for RT 3.5
#   3.4-compat      A 3.4 compatibility stylesheet to make RT 3.5 look
#                   (mostly) like 3.4
#
# This value actually specifies a directory in share/html/NoAuth/css/
# from which RT will try to load the file main.css (which should
# @import any other files the stylesheet needs).  This allows you to
# easily and cleanly create your own stylesheets to apply to RT.

Set($WebDefaultStylesheet, '3.5-default');

# Define the directory name to be used for images in rt web
# documents.

# If you're putting the web ui somewhere other than at the root of
# your server, you should set $WebPath to the path you'll be 
# serving RT at.
# $WebPath requires a leading / but no trailing /.
#
# In most cases, you should leave $WebPath set to '' (an empty value).

Set($WebPath , "");

# If we're running as a superuser, run on port 80
# Otherwise, pick a high port for this user.

Set($WebPort , 80);# + ($< * 7274) % 32766 + ($< && 1024));

# This is the Scheme, server and port for constructing urls to webrt
# $WebBaseURL doesn't need a trailing /

Set($WebBaseURL , "http://localhost:$WebPort");

Set($WebURL , $WebBaseURL . $WebPath . "/");

# $WebImagesURL points to the base URL where RT can find its images.

Set($WebImagesURL , $WebPath . "/NoAuth/images/");

# $LogoURL points to the URL of the RT logo displayed in the web UI

Set($LogoURL , $WebImagesURL . "bplogo.gif");

# WebNoAuthRegex - What portion of RT's URLspace should not require
# authentication.
Set($WebNoAuthRegex, qr!^(?:/+NoAuth/|
                            /+REST/\d+\.\d+/NoAuth/)!x );

# SelfServiceRegex - What portion of RT's URLspace should
# be accessible to Unprivileged users
# This does not override the redirect from /Ticket/Display.html
# to /SelfService/Display.html when Unprivileged
# users attempt to access ticked displays
Set($SelfServiceRegex, qr!^(?:/+SelfService/)!x );

# For message boxes, set the entry box width and what type of wrapping
# to use.
#
# Default width: 72
Set($MessageBoxWidth , 72);

# Default wrapping: "HARD"  (choices "SOFT", "HARD")
Set($MessageBoxWrap, "HARD");

# Support implicit links in WikiText custom fields?  A true value
# causes InterCapped or ALLCAPS words in WikiText fields to
# automatically become links to searches for those words.  If used on
# RTFM articles, it links to the RTFM article with that name.
Set($WikiImplicitLinks, 0);

# if TrustHTMLAttachments is not defined, we will display them
# as text. This prevents malicious HTML and javascript from being
# sent in a request (although there is probably more to it than that)
Set($TrustHTMLAttachments , undef);

# Should RT redistribute correspondence that it identifies as
# machine generated? A true value will do so; setting this to '0'
# will cause no such messages to be redistributed.
# You can also use 'privileged' (the default), which will redistribute
# only to privileged users. This helps to protect against malformed
# bounces and loops caused by autocreated requestors with bogus addresses.
Set($RedistributeAutoGeneratedMessages, 'privileged');

# If PreferRichText is set to a true value, RT will show HTML/Rich text
# messages in preference to their plaintext alternatives. RT "scrubs" the 
# html to show only a minimal subset of HTML to avoid possible contamination
# by cross-site-scripting attacks.
Set($PreferRichText, undef);

# If $WebExternalAuth is defined, RT will defer to the environment's
# REMOTE_USER variable.

Set($WebExternalAuth , undef);

# If $WebFallbackToInternalAuth is undefined, the user is allowed a chance
# of fallback to the login screen, even if REMOTE_USER failed.

Set($WebFallbackToInternalAuth , undef);

# $WebExternalGecos means to match 'gecos' field as the user identity);
# useful with mod_auth_pwcheck and IIS Integrated Windows logon.

Set($WebExternalGecos , undef);

# $WebExternalAuto will create users under the same name as REMOTE_USER
# upon login, if it's missing in the Users table.

Set($WebExternalAuto , undef);

# If $WebExternalAuto is true, this will be passed to User's
# Create method.  Use it to set defaults, such as creating 
# Unprivileged users with { Privileged => 0 }
# Must be a hashref of arguments

Set($AutoCreate, undef);

# $WebSessionClass is the class you wish to use for managing Sessions.
# It defaults to use your SQL database, but if you are using MySQL 3.x and
# plans to use non-ascii Queue names, uncomment and add this line to
# RT_SiteConfig.pm will prevent session corruption.

# Set($WebSessionClass , 'Apache::Session::File');


# By default, RT's session cookie isn't marked as "secure" Some web browsers 
# will treat secure cookies more carefully than non-secure ones, being careful
# not to write them to disk, only send them over an SSL secured connection 
# and so on. To enable this behaviour, set # $WebSecureCookies to a true value. 
# NOTE: You probably don't want to turn this on _unless_ users are only connecting
# via SSL encrypted HTTP connections.

Set($WebSecureCookies, 0);


# By default, RT clears its database cache after every page view.
# This ensures that you've always got the most current information 
# when working in a multi-process (mod_perl or FastCGI) Environment
# Setting $WebFlushDbCacheEveryRequest to '0' will turn this off,
# which will speed RT up a bit, at the expense of a tiny bit of data 
# accuracy.

Set($WebFlushDbCacheEveryRequest, '1');


# $MaxInlineBody is the maximum attachment size that we want to see
# inline when viewing a transaction. 13456 is a random sane-sounding
# default.

Set($MaxInlineBody, 13456);

# $DefaultSummaryRows is default number of rows displayed in for search
# results on the frontpage.

Set($DefaultSummaryRows, 10);

# By default, RT shows newest transactions at the bottom of the ticket
# history page, if you want see them at the top set this to '0'.

Set($OldestTransactionsFirst, '1');

# By default, RT shows images attached to incoming (and outgoing) ticket updates
# inline. Set this variable to 0 if you'd like to disable that behaviour

Set($ShowTransactionImages, 1);


# $HomepageComponents is an arrayref of allowed components on a user's
# customized homepage ("RT at a glance").

Set($HomepageComponents, [qw(QuickCreate Quicksearch MyAdminQueues MySupportQueues MyReminders  RefreshHomepage)]);

# @MasonParameters is the list of parameters for the constructor of
# HTML::Mason's Apache or CGI Handler.  This is normally only useful
# for debugging, eg. profiling individual components with:
#     use MasonX::Profiler; # available on CPAN
#     @MasonParameters = (preamble => 'my $p = MasonX::Profiler->new($m, $r);');

@MasonParameters = () unless (@MasonParameters);

# $DefaultSearchResultFormat is the default format for RT search results
Set ($DefaultSearchResultFormat, qq{
   '<B><A HREF="$RT::WebPath/Ticket/Display.html?id=__id__">__id__</a></B>/TITLE:#',
   '<B><A HREF="$RT::WebPath/Ticket/Display.html?id=__id__">__Subject__</a></B>/TITLE:Subject',
   Status,
   QueueName, 
   OwnerName, 
   Priority, 
   '__NEWLINE__',
   '', 
   '<small>__Requestors__</small>',
   '<small>__CreatedRelative__</small>',
   '<small>__ToldRelative__</small>',
   '<small>__LastUpdatedRelative__</small>',
   '<small>__TimeLeft__</small>'});

# If $SuppressInlineTextFiles is set to a true value, then uploaded
# text files (text-type attachments with file names) are prevented
# from being displayed in-line when viewing a ticket's history.

Set($SuppressInlineTextFiles, undef);

# If $DontSearchFileAttachments is set to a true value, then uploaded
# files (attachments with file names) are not searched during full-content
# ticket searches.

Set($DontSearchFileAttachments, undef);

# The GD module (which RT uses for graphs) uses a builtin font that doesn't
# have full Unicode support. You can use a particular TrueType font by setting
# $ChartFont to the absolute path of that font. Your GD library must have
# support for TrueType fonts to use this option.

Set($ChartFont, undef);


# }}}

# {{{ RT UTF-8 Settings

# An array that contains languages supported by RT's internationalization
# interface.  Defaults to all *.po lexicons; setting it to qw(en ja) will make
# RT bilingual instead of multilingual, but will save some memory.

@LexiconLanguages = qw(*) unless (@LexiconLanguages);

# An array that contains default encodings used to guess which charset
# an attachment uses if not specified.  Must be recognized by
# Encode::Guess.

@EmailInputEncodings = qw(utf-8 iso-8859-1 us-ascii) unless (@EmailInputEncodings);

# The charset for localized email.  Must be recognized by Encode.

Set($EmailOutputEncoding , 'utf-8');

# }}}

# {{{ RT Date Handling Options (for Time::ParseDate)

# Set this to 1 if your local date convention looks like "dd/mm/yy"
# instead of "mm/dd/yy".

Set($DateDayBeforeMonth , 1);

# Should an unspecified day or year in a date refer to a future or a
# past value? For example, should a date of "Tuesday" default to mean
# the date for next Tuesday or last Tuesday? Should the date "March 1"
# default to the date for next March or last March?
# Set to 0 for the next date or 1 for the last date.

Set($AmbiguousDayInPast , 1);

# }}}

# {{{ Miscellaneous RT Settings

# You can define new statuses and even reorder existing statuses here.
# WARNING. DO NOT DELETE ANY OF THE DEFAULT STATUSES. If you do, RT
# will break horribly. The statuses you add must be no longer than
# 10 characters.

@ActiveStatus = qw(new open stalled) unless @ActiveStatus;
@InactiveStatus = qw(resolved rejected deleted) unless @InactiveStatus;

# Backward compatability setting. Add/Delete Link used to record one
# transaction and run one scrip. Set this value to 1 if you want
# only one of the link transactions to have scrips run.
Set($LinkTransactionsRun1Scrip , 0);

# When this feature is enabled an user need ModifyTicket right on both
# tickets to link them together, otherwise he can have right on any of
# two.
Set($StrictLinkACL, 1);

# }}}


# {{{ Development Mode
#
# RT comes with a "Development mode" setting. 
# This setting, as a convenience for developers, turns on 
# all sorts of development options that you most likely don't want in 
# production:
#
# * Turns off Mason's 'static_source' directive. By default, you can't 
#   edit RT's web ui components on the fly and have RT magically pick up
#   your changes. (It's a big performance hit)
#
#  * More to come
#

Set($DevelMode, '0');

# }}}


1;
