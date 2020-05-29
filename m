Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE91E8BCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgE2XM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:12:27 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:38824 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgE2XM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:12:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 05684181D337B;
        Fri, 29 May 2020 23:12:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2693:2828:2892:3138:3139:3140:3141:3142:3653:3865:3866:3867:3868:3870:3871:3874:4321:4605:5007:6119:7903:8603:9010:9121:9592:10004:10848:11026:11232:11233:11658:11914:12043:12297:12438:12555:12679:12760:12895:12986:13095:13439:14181:14394:14659:14721:14819:21080:21433:21627:21795:30034:30054:30060:30062:30070:30075:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: work88_5b00ecc26d67
X-Filterd-Recvd-Size: 5588
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 May 2020 23:12:23 +0000 (UTC)
Message-ID: <9c360bfa43580ce7726dd3d9d247f1216a690ef0.camel@perches.com>
Subject: [PATCH] checkpatch/coding-style: Allow 100 column lines
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Date:   Fri, 29 May 2020 16:12:21 -0700
In-Reply-To: <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
         <20200528054043.621510-1-hch@lst.de>
         <22778.1590697055@warthog.procyon.org.uk>
         <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
         <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
         <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the maximum allowed line length to 100 from 80.

Miscellanea:

o to avoid unnecessary whitespace changes in files,
  checkpatch will no longer emit a warning about line length
  when scanning files unless --strict is also used
o Add a bit to coding-style about alignment to open parenthesis

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/coding-style.rst | 25 ++++++++++++++++---------
 scripts/checkpatch.pl                  | 14 +++++++++-----
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index acb2f1b36350..55b148e9c6b8 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -84,15 +84,22 @@ Get a decent editor and don't leave whitespace at the end of lines.
 Coding style is all about readability and maintainability using commonly
 available tools.
 
-The limit on the length of lines is 80 columns and this is a strongly
-preferred limit.
-
-Statements longer than 80 columns will be broken into sensible chunks, unless
-exceeding 80 columns significantly increases readability and does not hide
-information. Descendants are always substantially shorter than the parent and
-are placed substantially to the right. The same applies to function headers
-with a long argument list. However, never break user-visible strings such as
-printk messages, because that breaks the ability to grep for them.
+The preferred limit on the length of a single line is 80 columns.
+
+Statements longer than 80 columns should be broken into sensible chunks,
+unless exceeding 80 columns significantly increases readability and does
+not hide information.
+
+Statements may be up to 100 columns when appropriate.
+
+Descendants are always substantially shorter than the parent and are
+are placed substantially to the right.  A very commonly used style
+is to align descendants to a function open parenthesis.
+
+These same rules are applied to function headers with a long argument list.
+
+However, never break user-visible strings such as printk messages because
+that breaks the ability to grep for them.
 
 
 3) Placing Braces and Spaces
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dd750241958b..5f00df2c3f59 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -53,7 +53,7 @@ my %ignore_type = ();
 my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
-my $max_line_length = 80;
+my $max_line_length = 100;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
@@ -99,9 +99,11 @@ Options:
   --types TYPE(,TYPE2...)    show only these comma separated message types
   --ignore TYPE(,TYPE2...)   ignore various comma separated message types
   --show-types               show the specific message type in the output
-  --max-line-length=n        set the maximum line length, if exceeded, warn
+  --max-line-length=n        set the maximum line length, (default $max_line_length)
+                             if exceeded, warn on patches
+                             requires --strict for use with --file
   --min-conf-desc-length=n   set the min description length, if shorter, warn
-  --tab-size=n               set the number of spaces for tab (default 8)
+  --tab-size=n               set the number of spaces for tab (default $tabsize)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
   --mailback                 only produce a report in case of warnings/errors
@@ -3282,8 +3284,10 @@ sub process {
 
 			if ($msg_type ne "" &&
 			    (show_type("LONG_LINE") || show_type($msg_type))) {
-				WARN($msg_type,
-				     "line over $max_line_length characters\n" . $herecurr);
+				my $msg_level = \&WARN;
+				$msg_level = \&CHK if ($file);
+				&{$msg_level}($msg_type,
+					      "line length of $length exceeds $max_line_length columns\n" . $herecurr);
 			}
 		}
 

