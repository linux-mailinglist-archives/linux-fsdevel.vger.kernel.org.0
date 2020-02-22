Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C2168C49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 05:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBVESk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 23:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgBVESk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 23:18:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049CC208C3;
        Sat, 22 Feb 2020 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582345119;
        bh=K2HDrAKj7hj+2CKvJF8xxV8d26LJI0EnDte3e8IkOao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LRiRzVbcteB3Volmi03sResRMRYDN3BmjYwifXRV+ywPsz2VCrpiWQYzhrC0TxyJE
         HWwyt8ag1ZbHA1snRpeiV2DSGzb7cyPoUDyMLBFAOWqa3n487khYqgleadwySGSWCf
         5LTvKRf9sy8RH0X0nc/BWvG4Hs4RNC89AwvKePmU=
Date:   Sat, 22 Feb 2020 13:18:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [for-next][12/26] Documentation: bootconfig: Add a doc for
 extended boot config
Message-Id: <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
In-Reply-To: <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
        <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
        <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
        <20200221191637.e9eed4268ff607a98200628c@kernel.org>
        <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Feb 2020 17:43:32 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> Is there a need to separate the number from the following unit?
> >
> > Sorry, I couldn't understand what you pointed here.
> 
> Can the specification “… size is 32 KiB …”be more appropriate
> (besides a small wording adjustment)?

OK, I'll update as so :)

> > Like "descriptions of ..." ?
> 
> I got another idea also for the provided documentation format.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/bootconfig.rst?id=bee46b309a13ca158c99c325d0408fb2f0db207f#n18
> 
> * Will a file format description become helpful in the way of
>   an extended Backus–Naur form?

Good suggestion! Let me try to write an EBNF section.
I think EBNF can logically explain the format, but not intuitive
- we need some examples.

> * How will data processing evolve around the added structures?

OK, I'll add some more API (and usage) differences from the legacy
command line.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
