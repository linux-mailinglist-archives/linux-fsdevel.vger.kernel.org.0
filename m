Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF55F55BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 01:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFYXC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 19:02:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYXC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:02:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id k13so165620pgq.9;
        Tue, 25 Jun 2019 16:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAVXlfOigyJbEa5HhE6BwBcpEncScOxFXJXYNv1k45k=;
        b=fkL5OZuDVWkej5ZG4VatI21hHWlzGJXK0Si9AQAW9zoGDwMiyZEPuYRirz3Q0aByJu
         9VSHMOkGBUWW+0XoBoEXFmw+r8dtWGNTMbrgcKs5Y6TE4ftvqTFwaaqA+U2WFhJQIFlw
         4KKH74x4Ywbb000a83LtPoyMHZ5lCRuW/S7lvrp3MQNb3camzLJIdH0ezPRKVp/yWlMv
         3/Q1tmNtE2UScpSpGJSN7CWBf4L/z22TrszMAenhqm81+BrbizGlhy6Mq2867Dogh+6s
         QTfxli/sBvaR+SMxqvkCI0RltTgT8RpA3KvJKAQJ31dHl2que9hlT0apwrDNqHfDlHEN
         pogA==
X-Gm-Message-State: APjAAAUEy5rjIl2ApPQlP2hKVqp/KAyOmZgVXhTaR1V8Qxen5rTjMWmm
        DtEyG+GK0eMtcjV02R/Fmj4=
X-Google-Smtp-Source: APXvYqzZBw/dqZhBTNHNMDfHye5/2eZRaAS1PSupftYRQhWIaCqeSFUapN9xTbqyZVwDxqRVbGqHHQ==
X-Received: by 2002:a17:90a:ac13:: with SMTP id o19mr354796pjq.143.1561503775428;
        Tue, 25 Jun 2019 16:02:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r1sm92074pji.15.2019.06.25.16.02.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 16:02:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 64827401EB; Tue, 25 Jun 2019 23:02:53 +0000 (UTC)
Date:   Tue, 25 Jun 2019 23:02:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625230253.GQ19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
 <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Since its a new architecture and since you seem to imply most tests
> > don't require locking or even IRQs disabled, I think its worth to
> > consider the impact of adding such extreme locking requirements for
> > an initial ramp up.
> 
> Fair enough, I can see the point of not wanting to use irq disabled
> until we get someone complaining about it, but I think making it
> thread safe is reasonable. It means there is one less thing to confuse
> a KUnit user and the only penalty paid is some very minor performance.

One reason I'm really excited about kunit is speed... so by all means I
think we're at a good point to analyze performance optimizationsm if
they do make sense.

While on the topic of parallization, what about support for running
different test cases in parallel? Or at the very least different kunit
modules in parallel.  Few questions come up based on this prospect:

  * Why not support parallelism from the start?
  * Are you opposed to eventually having this added? For instance, there is
    enough code on lib/test_kmod.c for batching tons of kthreads each
    one running its own thing for testing purposes which could be used
    as template.
  * If we eventually *did* support it:
    - Would logs be skewed?
    - Could we have a way to query: give me log for only kunit module
      named "foo"?

  Luis
