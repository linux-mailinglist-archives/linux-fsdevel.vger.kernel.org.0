Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8248E165E6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBTNNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 08:13:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBTNNr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:13:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45113206ED;
        Thu, 20 Feb 2020 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582204427;
        bh=IHgFRQu6vtgSjRH+EdzEs0RBHd01e1qO18Td6UiCAis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zhcN+w8O8nH3zuu0JNaiOHi/9YXh2rFG2X4sP3cBanfCx49cKOikccbhsyKoVDdaw
         ymKYIvDS2oPQxbvGrvR35XhpKxnZoCPM1IUIMA6tvCSK6+LNx0n4gKgl0aMzl0HXqf
         SdEoonAg7P9pbbhRflCgl5Jp9DT5E3btGkd2Ux9g=
Date:   Thu, 20 Feb 2020 22:13:40 +0900
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
Message-Id: <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
In-Reply-To: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, 20 Feb 2020 10:10:20 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> I wonder about a few details in the added text.
> 
> 
> …
> > +++ b/Documentation/admin-guide/bootconfig.rst
> …
> > +C onfig File Limitation
> 
> How do you think about to omit a space character at the beginning
> of this line?

That was my mistake. I used restructured text extension for vim
which collapsed all sections and use "space" key to expand.
Accidentally, I run into edit mode and hit "space" to expand it.
(it actually expanded but also put a space there and I missed it...)

Anyway, it has been fixed (pointed by Rundy)

> > +Currently the maximum config size size is 32KB …
> 
> Would you like to avoid a word duplication here?

Oops, still exist. Thanks!


> > +Note: this is not the number of entries but nodes, an entry must consume
> > +more than 2 nodes (a key-word and a value). …
> 
> I find the relevance of the term “nodes” unclear at the moment.

Indeed, "node" is not well defined. What about this?
---
Each key consists of words separated by dot, and value also consists of
values separated by comma. Here, each word and each value is generally
called a "node".
---

> 
> Could an other wording be nicer than the abbreviation “a doc for … config”
> in the commit subject?

OK, I'll try next time. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
