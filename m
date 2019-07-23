Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7C70E28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 02:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfGWAcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 20:32:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37631 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfGWAcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:32:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so7720064pgd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2019 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuvO2vdByXr9tZ4gIUtMWHJb47SWaOs3dPS9JirOd8A=;
        b=Zl9GjnPN0xA37eJPDX7MMY5U59qIMhaH0oHaFDaQC5kc56db6tSm1k92X8vD9olKQv
         OxaZTUgiRL7QcEtCdRCTPLyfWDQhRyOXO/nSFoU6NA2mvCQcdvEZ0WClLYkrEms7tZo/
         izrTbbctUhAN1VB9J0Q7y+pRVPXmJcR9HPRnbtizx6ihsgsakAq/rgha1JCGMsgY2RiH
         PJ1yTUdO8H1C8vedwH16edJ6CisD7/Lc2QkWysnWnCsUClX9aMwTBEN+KsRdmKr24KRk
         pqLlahy+9/ouBHzutT221O182aQu5jXOaH8IgOSQxKXVRStd+1V11liNjuOCoEoDcsOL
         bt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuvO2vdByXr9tZ4gIUtMWHJb47SWaOs3dPS9JirOd8A=;
        b=it7/CeZic415UBtsGJxltx5VVS/wD1Jjjfgs0U6a+SRZzK6/5cBvXWATP/aKfry+92
         fsyuiyVtk87NxPETLi3v1sqZ3T/Nd3RclZhSjIVvF1orUPtp6wJY/5GAbB9vb7Fhtzsz
         SEkK9s+bI5xFRxsmSM0+0hH9WPPdzWLh0Nm34qeLu7DtvdHIRhUAaTUJMEIm2h6LQYQ0
         FJMP4jffPhg95lqTGbQ2xkGSZEE9bHG1kKBMWHQSR72CFHJs4X2YAGWPxKUijwCSan3N
         f548kn/uIdbMZnagPlI44riCeco/f8oIc0MvGcJSvdT5S345pN/qmM5OXfObxCX2UhPC
         X7SA==
X-Gm-Message-State: APjAAAVwqh4vovMY0xFS/EEx/fsZZHJw1hl3uUvFMvbgcpIhein64GE/
        yAhPzNrFKHebX06TVgOR3590rT35zI8kPIFXXTRZaw==
X-Google-Smtp-Source: APXvYqxh+VUvsGh5iLsrxoHbLc3jsob++DVglc3Oa483B1QKCacTy9ml6NDURiDh9l6nBgWwR+AIwjhgcbpU33mL7Pc=
X-Received: by 2002:aa7:9191:: with SMTP id x17mr2893489pfa.23.1563841951086;
 Mon, 22 Jul 2019 17:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com> <20190722235411.06C1320840@mail.kernel.org>
In-Reply-To: <20190722235411.06C1320840@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 22 Jul 2019 17:32:19 -0700
Message-ID: <CAFd5g46h9XSRfA1H4kZR7u0Eh_F-fgPjoLPzqzLgFTXxeb105g@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-22 15:30:49)
> > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > >
> > > What's the calling context of the assertions and expectations? I still
> > > don't like the fact that string stream needs to allocate buffers and
> > > throw them into a list somewhere because the calling context matters
> > > there.
> >
> > The calling context is the same as before, which is anywhere.
>
> Ok. That's concerning then.

Yeah. Luis suggested just not supporting the IRQ context until later.
See my later comment.

> > > I'd prefer we just wrote directly to the console/log via printk
> > > instead. That way things are simple because we use the existing
> > > buffering path of printk, but maybe there's some benefit to the string
> > > stream that I don't see? Right now it looks like it builds a string and
> > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > just writing directly with printk.
> >
> > It's just buffering it so the whole string gets printed uninterrupted.
> > If we were to print out piecemeal to printk, couldn't we have another
> > call to printk come in causing it to garble the KUnit message we are
> > in the middle of printing?
>
> Yes, printing piecemeal by calling printk many times could lead to
> interleaving of messages if something else comes in such as an interrupt
> printing something. Printk has some support to hold "records" but I'm
> not sure how that would work here because KERN_CONT talks about only
> being used early on in boot code. I haven't looked at printk in detail
> though so maybe I'm all wrong and KERN_CONT just works?

It says KERN_CONT is not SMP safe, and it isn't supposed to contain
newlines, so it doesn't sound like it does any buffering for you. I
looked at it a while ago and those comments agreed with my
understanding of the code, but I could be wrong.

> Can printk be called once with whatever is in the struct?

Unfortunately, no. That is part of what I was trying to illustrate
with this patch. Most of the messages are deterministic, but
hardcoding all the possible message types would lead to a massive
number of hard coded strings. However, even this would break down for
the mocking formatters. All the different ways a function can be
called are just too complex to encode into a finite set of hard coded
fmt strings.

> Otherwise if
> this is about making printk into a structured log then maybe printk
> isn't the proper solution anyway. Maybe a dev interface should be used
> instead that can handle starting and stopping tests (via ioctl) in
> addition to reading test results, records, etc. with read() and a
> clearing of the records. Then the seqfile API works naturally. All of

Ehhh...I wouldn't mind providing such an interface, but I would really
like to be able to provide the results without having to depend on a
userland doing something to get test results. That has always been a
pretty important goal for me.

> this is a bit premature, but it looks like you're going down the path of
> making something akin to ftrace that stores binary formatted
> assertion/expectation records in a lockless ring buffer that then
> formats those records when the user asks for them.

Like you said, I think it is a bit premature to go that far.

In anycase, I don't see a way to get rid of string_stream, without
significantly sacrificing usability.

> I can imagine someone wanting to write unit tests that check conditions
> from a simulated hardirq context via irq works (a driver mock
> framework?), so this doesn't seem far off.

Yep, I actually presented the first pieces of that in the RFC v1 that
I linked to you earlier in this discussion. I have a more fleshed out
example here:

https://kunit.googlesource.com/linux/+/e10484ad2f9fc7926412ec84739fe105981b4771/drivers/i2c/busses/i2c-aspeed-test.c

I actually already have some people at Google playing around with it.
So yeah, not far off at all! However, in these cases we are not
actually running in the IRQ context (despite the fact that we are
testing IRQ code) because we provide a fake IRQ chip, or some other
fake mechanism that triggers the IRQ. Still, I could see someone
wanting to do it in a non-fake-IRQ context.

Luis' suggestion was just to hold off on the IRQ safe stuff at the
outset, since that is going to require a lot more effort to review. I
know that's kind of the future coding argument again, but maybe the
answer will be to just restrict what features an IRQ user has access
to (maybe just really simple expectations, for example). I mean, we
will probably have to restrict what they are allowed to use anyway.

Luis, do you have any ideas?

Cheers
