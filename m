Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB2116692
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 06:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLIFuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 00:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfLIFuR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:50:17 -0500
Received: from devnote2 (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900B7206D3;
        Mon,  9 Dec 2019 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575870616;
        bh=R0dRoRAY4AWuXuEgdxQagG5YTnurfWd7YsIc+RAjjm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJ2OFgv607/k4OkLsAE8Hq05LS5VDWUVqa5DhA5j1JUbAu4R7M0wYkGxUdcH/YpiU
         LCH2U9ImHSBbq93kGzXoDymA4vyJZ8wtlj7t5EH4d9UjyVNtgrMt7hSxcL980liOrn
         V0ltYqG+b31v/MYVS8YCkKqFr7yVOwKCwhwDHtuo=
Date:   Mon, 9 Dec 2019 14:50:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [RFC PATCH v4 01/22] bootconfig: Add Extra Boot Config support
Message-Id: <20191209145009.502ece2e58ffab5e31430a0e@kernel.org>
In-Reply-To: <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
        <157528160980.22451.2034344493364709160.stgit@devnote2>
        <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

Thank you for your review!

On Sun, 8 Dec 2019 11:34:32 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 12/2/19 2:13 AM, Masami Hiramatsu wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 67a602ee17f1..13bb3eac804c 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1235,6 +1235,17 @@ source "usr/Kconfig"
> >  
> >  endif
> >  
> > +config BOOT_CONFIG
> > +	bool "Boot config support"
> > +	select LIBXBC
> > +	default y
> 
> questionable "default y".
> That needs lots of justification.

OK, I can make it 'n' by default.

I thought that was OK because most of the memories for the
bootconfig support were released after initialization.
If user doesn't pass the bootconfig, only the code for
/proc/bootconfig remains on runtime memory.

> > +	help
> > +	 Extra boot config allows system admin to pass a config file as
> > +	 complemental extension of kernel cmdline when boot.
> 
> 	                                          when booting.

OK.

> 
> > +	 The boot config file is usually attached at the end of initramfs.
> 
> The 3 help text lines above should be indented with one tab + 2 spaces,
> like the "If" line below.

Ah, thanks for pointing it out!
I'll fix that.

Thank you,

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
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
