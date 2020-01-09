Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009F11363A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgAIXLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgAIXLA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:11:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C447320656;
        Thu,  9 Jan 2020 23:10:57 +0000 (UTC)
Date:   Thu, 9 Jan 2020 18:10:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Subject: Re: [PATCH v5 00/22] tracing: bootconfig: Boot-time tracing and
 Extra boot config
Message-ID: <20200109181055.1999b344@gandalf.local.home>
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Dec 2019 23:03:48 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This is the 5th version of the series for the boot-time tracing.
> 
> Previous version is here.
> 
> https://lkml.kernel.org/r/157528159833.22451.14878731055438721716.stgit@devnote2

Hi Masami,

I applied all your patches to a test branch and was playing with it a
little. This seems fine to me and works well (and very easy to use).
Probably could use some more examples, but that's just a nit.

If nobody has any issues with this code, I'll wait for v6 with the
fixes to issues found in this series, and I'll happily apply them for
linux-next.

-- Steve


> 
> In this version, I removed RFC tag from the series.
> Changes from the v4 are here, updating bootconfig things.
> 
>  - [1/22] Fix help comment and indent of Kconfig.
>           Restrict available characters in values(*)
>           Drop backslash escape from quoted value(**)
>  - [3/22] Fix Makefile to compile tool correctly
>           Remove unused pattern from Makefile
>  - [4/22] Show test target bootconfig
>           Add printable value testcases
>           Add bad array testcase
>  - [9/22] Fix TOC list
>           Add notes about available characters.
>           Fix to use correct quotes (``) for .rst.
> 
> (*) this is for preventing admin from shoot himself.
> (**) this rule is from legacy command line.
> 
> Boot-time tracing features are not modified. I know Tom is working
> on exporting synthetic event (and dynamic events) APIs for module.
> If that APIs are merged first, I will update my series on top
> of that.
> 
> This series can be applied on v5.5-rc3 or directly available at;
> 
> https://github.com/mhiramat/linux.git ftrace-boottrace-v5
> 
> 
