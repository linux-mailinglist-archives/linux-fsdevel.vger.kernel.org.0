Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698541421F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 04:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgATDXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 22:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDXa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:23:30 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCE92077C;
        Mon, 20 Jan 2020 03:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579490609;
        bh=bFXtcmrmYQ5EaV0kOE8JiB2aYQ31SgC7NfzQHg2UPxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9mJ5Agwkp77r+U0PAZA20yEaLWLW1G83oaMKpAcUmGMJbknhrDgbWn2+FCXaERMG
         wWrIV2dbKH5ue/OgJqIQZOTU7MZ7zSMCogcHleY7kBaA9T6/eq4irSk/krw20a0q7v
         VHzfzYyM/lt4m0h0P/S/fZp7f/W3LskHFv40ENS0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: tracing: Fix typos in boot-time tracing documentation
Date:   Mon, 20 Jan 2020 12:23:23 +0900
Message-Id: <157949060335.25888.13153184562531693684.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157949056842.25888.12912764773767908046.stgit@devnote2>
References: <157949056842.25888.12912764773767908046.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix typos in boottime-trace.rst according to Randy's suggestions.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 1d10fdebf1b2..dcb390075ca1 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -13,7 +13,7 @@ Boot-time tracing allows users to trace boot-time process including
 device initialization with full features of ftrace including per-event
 filter and actions, histograms, kprobe-events and synthetic-events,
 and trace instances.
-Since kernel cmdline is not enough to control these complex features,
+Since kernel command line is not enough to control these complex features,
 this uses bootconfig file to describe tracing feature programming.
 
 Options in the Boot Config
@@ -21,7 +21,7 @@ Options in the Boot Config
 
 Here is the list of available options list for boot time tracing in
 boot config file [1]_. All options are under "ftrace." or "kernel."
-refix. See kernel parameters for the options which starts
+prefix. See kernel parameters for the options which starts
 with "kernel." prefix [2]_.
 
 .. [1] See :ref:`Documentation/admin-guide/bootconfig.rst <bootconfig>`
@@ -50,7 +50,7 @@ kernel.fgraph_filters = FILTER[, FILTER2...]
    Add fgraph tracing function filters.
 
 kernel.fgraph_notraces = FILTER[, FILTER2...]
-   Add fgraph non tracing function filters.
+   Add fgraph non-tracing function filters.
 
 
 Ftrace Per-instance Options
@@ -81,10 +81,10 @@ ftrace.[instance.INSTANCE.]tracer = TRACER
    Set TRACER to current tracer on boot. (e.g. function)
 
 ftrace.[instance.INSTANCE.]ftrace.filters
-   This will take an array of tracing function filter rules
+   This will take an array of tracing function filter rules.
 
 ftrace.[instance.INSTANCE.]ftrace.notraces
-   This will take an array of NON-tracing function filter rules
+   This will take an array of NON-tracing function filter rules.
 
 
 Ftrace Per-Event Options
@@ -93,7 +93,7 @@ Ftrace Per-Event Options
 These options are setting per-event options.
 
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
-   Enables GROUP:EVENT tracing.
+   Enable GROUP:EVENT tracing.
 
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
    Set FILTER rule to the GROUP:EVENT.
@@ -145,10 +145,10 @@ below::
         }
   }
 
-Also, boottime tracing supports "instance" node, which allows us to run
+Also, boot-time tracing supports "instance" node, which allows us to run
 several tracers for different purpose at once. For example, one tracer
-is for tracing functions start with "user\_", and others tracing "kernel\_"
-functions, you can write boot config as below::
+is for tracing functions starting with "user\_", and others tracing
+"kernel\_" functions, you can write boot config as below::
 
   ftrace.instance {
         foo {

