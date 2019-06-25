Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6D55A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFYVob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 17:44:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42541 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFYVob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:44:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so83720pgq.9;
        Tue, 25 Jun 2019 14:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dxyIPqcP8jDSy0GUtYumC+DRq05muFlYTTdqsbRigE=;
        b=Np3R7TUmILE29O//nVuQfb8yO1wVcahnUfTjdtvU2lq8kSBEy4G01ML0evh6hXqY3P
         JdJYiB/SOPSeyLonNoAeydK24aduweVZFxgapxiS1BvMs+R+ufmdNabKiXQ68OMlYl5R
         OiT0I+k75dkcqvFHgl3euEV/F5j4Xdr+yVOMXIfF4BAHPkwgtuyvuNjjYmr5zmfzJ+Wq
         KTfPIkrvbwNh+FOflVSPWWuqa6B/n5xZg6GgkyLRI/y5wjlFWE2NUEMER3MNI1vK4hhn
         ymJG85juyts/9Kt1otvUbLtOqZAzR/jnICFuI2BBq6jU/pHBZY8aw1LmhPwmRIBp/TL0
         rD5g==
X-Gm-Message-State: APjAAAX1NsvFzVybXC8wdG79ohNTc/zd7YpsIDRW+vpp1whgTT/IlNwj
        Q1NKZROB0q1QN6I6Tsw1un4=
X-Google-Smtp-Source: APXvYqz8MfGhRhi/dlXuLkoaF1E80HXc/ju/CwZ7//TYZw6Vnsx8tuHl88GSOvVc/go3GBogDeg5Ig==
X-Received: by 2002:a63:7d18:: with SMTP id y24mr36133502pgc.438.1561499069415;
        Tue, 25 Jun 2019 14:44:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a20sm13423142pgb.72.2019.06.25.14.44.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 14:44:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3C710401EB; Tue, 25 Jun 2019 21:44:27 +0000 (UTC)
Date:   Tue, 25 Jun 2019 21:44:27 +0000
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
Message-ID: <20190625214427.GN19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:28:25PM -0700, Brendan Higgins wrote:
> On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-06-17 01:25:56)
> > > diff --git a/kunit/test.c b/kunit/test.c
> > > new file mode 100644
> > > index 0000000000000..d05d254f1521f
> > > --- /dev/null
> > > +++ b/kunit/test.c
> > > @@ -0,0 +1,210 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Base unit test (KUnit) API.
> > > + *
> > > + * Copyright (C) 2019, Google LLC.
> > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > + */
> > > +
> > > +#include <linux/sched/debug.h>
> > > +#include <kunit/test.h>
> > > +
> > > +static bool kunit_get_success(struct kunit *test)
> > > +{
> > > +       unsigned long flags;
> > > +       bool success;
> > > +
> > > +       spin_lock_irqsave(&test->lock, flags);
> > > +       success = test->success;
> > > +       spin_unlock_irqrestore(&test->lock, flags);
> >
> > I still don't understand the locking scheme in this code. Is the
> > intention to make getter and setter APIs that are "safe" by adding in a
> > spinlock that is held around getting and setting various members in the
> > kunit structure?
> 
> Yes, your understanding is correct. It is possible for a user to write
> a test such that certain elements may be updated in different threads;
> this would most likely happen in the case where someone wants to make
> an assertion or an expectation in a thread created by a piece of code
> under test. Although this should generally be avoided, it is possible,
> and there are occasionally good reasons to do so, so it is
> functionality that we should support.
> 
> Do you think I should add a comment to this effect?
> 
> > In what situation is there more than one thread reading or writing the
> > kunit struct? Isn't it only a single process that is going to be
> 
> As I said above, it is possible that the code under test may spawn a
> new thread that may make an expectation or an assertion. It is not a
> super common use case, but it is possible.

I wonder if it is worth to have then different types of tests based on
locking requirements. One with no locking, since it seems you imply
most tests would fall under this category, then locking, and another
with IRQ context.

If no locking is done at all for all tests which do not require locking,
is there any gains at run time? I'm sure it might be minimum but
curious.

> > operating on this structure? And why do we need to disable irqs? Are we
> > expecting to be modifying the unit tests from irq contexts?
> 
> There are instances where someone may want to test a driver which has
> an interrupt handler in it. I actually have (not the greatest) example
> here. Now in these cases, I expect someone to use a mock irqchip or
> some other fake mechanism to trigger the interrupt handler and not
> actual hardware; technically speaking in this case, it is not going to
> be accessed from a "real" irq context; however, the code under test
> should think that it is in an irq context; given that, I figured it is
> best to just treat it as a real irq context. Does that make sense?

Since its a new architecture and since you seem to imply most tests
don't require locking or even IRQs disabled, I think its worth to
consider the impact of adding such extreme locking requirements for
an initial ramp up.

  Luis
