Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93B4169C89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 04:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBXDNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 22:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBXDNK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:13:10 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06B220675;
        Mon, 24 Feb 2020 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582513989;
        bh=59NNPTLjABW0a7GgDsLekm7FZuCIANRbnVKzUyAHJeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DveasmG/vht0a4p5AHAEODbQpn47aZOj4WqEHF9QAo9078YF1ESg2sT/BSYFXJ8iV
         02o/wXisJ/b4eGgsFXfZhJ9F7HFGDDUOCdK2XnnJT9yeXZu7OyZjZQPqmvSWEc7blM
         ttuDrb+4YXHxTKWM0Wucq4NTvG+CEaNDntGd3p6w=
Date:   Mon, 24 Feb 2020 12:13:02 +0900
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
Message-Id: <20200224121302.5b730b519d550eb34da720a5@kernel.org>
In-Reply-To: <8cc7e621-c5e3-28fa-c789-0bb7c55d77d6@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
        <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
        <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
        <20200221191637.e9eed4268ff607a98200628c@kernel.org>
        <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
        <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
        <370e675a-598e-71db-8213-f5494b852a71@web.de>
        <20200223005615.79f308e2ca0717132bb2887b@kernel.org>
        <8cc7e621-c5e3-28fa-c789-0bb7c55d77d6@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Markus,

On Sat, 22 Feb 2020 17:15:57 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> Is there a need to provide two format descriptions as separate files
> >> (so that they can help more for different software users)?
> >>
> >> * RST
> >> * EBNF
> >
> > Hmm, since RST is enough flexible, we can write it as a section.
> 
> I guess that there are further design options to consider.
> 
> 
> > Then user can copy & paste if they need it.
> 
> I imagine that it can be more convenient to refer to an EBNF file directly
> if an other software developer would like to generate customised parsers
> based on available information.

OK, I'll try to make a split EBNF file and include it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
