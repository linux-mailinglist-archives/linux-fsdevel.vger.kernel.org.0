Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DB141DC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 13:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgASMXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 07:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgASMXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:23:49 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F061206D7;
        Sun, 19 Jan 2020 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579436628;
        bh=kdmApmJQmpli9KwevmEbEeDmbmVPTBdEeyrrc2zP5B0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i/Ow8+dZLlGqOoabUzVmR75Uu96fq1i2vsV+P6NLh/P6yYnvUm8kv3HAL4gGr2iwt
         VzU8QPoeXMDyFPJwkhpv+eTSePVE9U9JBsdiJUgzuObcBqEhMN4+vMhbscs9yOA5d6
         Ce+Ul+sqDBTE8kNC4QTKRU7JOi7JaItt5i4uvyjo=
Date:   Sun, 19 Jan 2020 21:23:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v6 01/22] bootconfig: Add Extra Boot Config support
Message-Id: <20200119212340.05f4fb15a66147edcdc77373@kernel.org>
In-Reply-To: <a61b3af0-e61c-f135-d7d4-3ff51b8117dc@infradead.org>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
        <157867221257.17873.1775090991929862549.stgit@devnote2>
        <a61b3af0-e61c-f135-d7d4-3ff51b8117dc@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 18 Jan 2020 10:33:01 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 1/10/20 8:03 AM, Masami Hiramatsu wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index a34064a031a5..63450d3bbf12 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> >  
> >  endif
> >  
> > +config BOOT_CONFIG
> > +	bool "Boot config support"
> > +	select LIBXBC
> > +	default y
> > +	help
> > +	  Extra boot config allows system admin to pass a config file as
> > +	  complemental extension of kernel cmdline when booting.
> > +	  The boot config file is usually attached at the end of initramfs.
> 
> Is there some other location where it might be attached?
> Please explain.

Oops, good catch!
No, it supports only initramfs.

I missed to leave the comment written in planning phase.
I need to update it.

Thank you!

> 
> > +
> > +	  If unsure, say Y.
> > +
> >  choice
> >  	prompt "Compiler optimization level"
> >  	default CC_OPTIMIZE_FOR_PERFORMANCE
> 
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu <mhiramat@kernel.org>
