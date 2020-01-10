Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50687136474
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 01:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgAJAxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 19:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgAJAxC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:53:02 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DE420721;
        Fri, 10 Jan 2020 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578617581;
        bh=7nGEqkngAzbWAwBR0/+aW+qvbK4h5Kn6pbT/7HosLSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qBQKUuaDF4xQ7eB+o4CxNt/s4IzgwZKodsGxg4l5AagEWVRhR827JiV25c8qopM4T
         MVHz5cjw5EMmxd+yROkJTUMmhHpAmEz7QXq6fbG9ge+lVJZum9TrELdrMsdmiw9h6d
         Tq/6YtmsSzEWJtJsVnOElWjEcnBu0RFG7uQdEcB0=
Date:   Fri, 10 Jan 2020 09:52:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH v5 05/22] proc: bootconfig: Add /proc/bootconfig to show
 boot config list
Message-Id: <20200110095254.5d8b7a9def6852be3b1b6c10@kernel.org>
In-Reply-To: <20200109163722.7678998e@gandalf.local.home>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
        <157736908816.11126.18219614958177954231.stgit@devnote2>
        <20200109163722.7678998e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 9 Jan 2020 16:37:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Dec 2019 23:04:48 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add /proc/bootconfig which shows the list of key-value pairs
> > in boot config. Since after boot, all boot configs and tree
> > are removed, this interface just keep a copy of key-value
> > pairs in text.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v4:
> >   - Remove ; in the end of lines.
> >   - Rename /proc/supp_cmdline to /proc/bootconfig
> >   - Simplify code.
> > ---
> >  0 files changed
> 
> Starting with this patch, your diffstat shows no changes :-/


Oops, I'll check why this happened...

Thank you!

> 
> -- Steve
> 
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0a0acbc968d6..9dc69bb6856f 100644


-- 
Masami Hiramatsu <mhiramat@kernel.org>
