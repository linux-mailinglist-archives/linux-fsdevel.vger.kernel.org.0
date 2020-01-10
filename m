Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0355A13714B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAJPbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 10:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgAJPbH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:31:07 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F61020673;
        Fri, 10 Jan 2020 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578670267;
        bh=PmlZ0floUXtGGa7TOfgYeBKFANJKRe+aQitOtud+P8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X36GmWlHGvdXfYh5YuOf44/kmbaIMvVOj2MbahzvrCVQ+8puv/3KqDuhFCWJTuaRF
         CtJbxKd7AtMrp6ePDdBWol5fdg87tr/PHW18OCfLJ+Cb3x0fxOC8Y4vAiROVldLZLz
         deogJUz0nIuBkh+hPJgohYk79pa7bq7pvppTZc+M=
Date:   Sat, 11 Jan 2020 00:30:59 +0900
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
Subject: Re: [PATCH v5 00/22] tracing: bootconfig: Boot-time tracing and
 Extra boot config
Message-Id: <20200111003059.5c24c0ee4a85df10ec9f17e6@kernel.org>
In-Reply-To: <20200109181055.1999b344@gandalf.local.home>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
        <20200109181055.1999b344@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

On Thu, 9 Jan 2020 18:10:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Dec 2019 23:03:48 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hello,
> > 
> > This is the 5th version of the series for the boot-time tracing.
> > 
> > Previous version is here.
> > 
> > https://lkml.kernel.org/r/157528159833.22451.14878731055438721716.stgit@devnote2
> 
> Hi Masami,
> 
> I applied all your patches to a test branch and was playing with it a
> little. This seems fine to me and works well (and very easy to use).
> Probably could use some more examples, but that's just a nit.

OK, I'll add some examples to Documentation/trace/boottime-trace.rst
next time.

> 
> If nobody has any issues with this code, I'll wait for v6 with the
> fixes to issues found in this series, and I'll happily apply them for
> linux-next.

Thanks! I'll send v6 soon, which is including fixes and testcases. :)

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
