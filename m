Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFC167A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgBUKQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 05:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgBUKQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:16:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA8520722;
        Fri, 21 Feb 2020 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582280204;
        bh=ii1y1YjqosHxxt4ATYrhgawzseb5pMwWOhVXA3CV6yA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fFhtobFbUN6Q/eAsQjW/YIdITh7NFpLSu50CqJ2f/4jKlQ/YQsRLxUX729qW3/p/d
         oNoq21X0hggp3NP1bRA+5ED1VArkYxT4WH4oelD6IVzaUYsKwh0kFoSxIMJ/jDZp75
         gfrxAjlJL3JhkWCa2gznXWWvnYe4UXUQUcN6gZy0=
Date:   Fri, 21 Feb 2020 19:16:37 +0900
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
Subject: Re: [for-next][PATCH 12/26] Documentation: bootconfig: Add a doc
 for extended boot config
Message-Id: <20200221191637.e9eed4268ff607a98200628c@kernel.org>
In-Reply-To: <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
        <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
        <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Feb 2020 16:00:23 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >>> +Currently the maximum config size size is 32KB …
> >>
> >> Would you like to avoid a word duplication here?
> >
> > Oops, still exist.
> 
> Is there a need to separate the number from the following unit?

Sorry, I couldn't understand what you pointed here. Would you mean the
number of file size and nodes?

> > Indeed, "node" is not well defined. What about this?
> > ---
> > Each key consists of words separated by dot, and value also consists of
> > values separated by comma. Here, each word and each value is generally
> > called a "node".
> 
> I have got still understanding difficulties with such an interpretation.
> 
> * Do other contributors find an other word also more appropriate for this use case?

No.

> * How will the influence evolve for naming these items?

Node is used in its API, but from the user's point of view, I think it
is OK to use "key-word" and "value".
Also, since it is hard to count those numbers by manual, I think user
can depend on tools/bootconfig which shows the number of node in the
configuration file now.

> * Is each element just a string (according to specific rules)?

Yes.

> >> Could an other wording be nicer than the abbreviation “a doc for … config”
> >> in the commit subject?
> >
> > OK, I'll try next time.
> 
> Will words like “descriptions”and “configuration”be helpful?

Like "descriptions of ..." ?

Thank you,

> 
> Regards,
> Markus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
