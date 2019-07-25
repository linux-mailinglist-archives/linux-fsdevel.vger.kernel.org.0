Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BF758C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGYUV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 16:21:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfGYUVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:21:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so23308994pfq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2019 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0Cra5QTZMEsQQCWtg/IrgmE1EkzXk2wzdHi6GNLFH4=;
        b=icwWCIiUgBV1wHTICVJ8PDBYNM56j1SL56zOuqzadtL/FTJftG29M/5i37umQn5pat
         98vgN9o4wCCUl6zlUntg1M2/HAqBcuf46VrRvHnBderCK2JzVC1N/QGeaiGfSXK9s4n5
         D6RwN5DHnLXKOq4Ny6b8fOnc2KVD7SZxUUSdcyUfbAIVnumy+pkl0n1aZfxPSnWyIL72
         hfdMtqkGubCbZVDRysKpCuE9QGl7AC7BSboaOfM49zJPp3eOwApBz0fXZ3/p4ovL/zBt
         OQN9pJSLbaG8HsrL0EiinQXd3Ip1iSW8gF7p8zWj9INScAI2FFyHb72jeSzAyZtgcUhN
         wuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0Cra5QTZMEsQQCWtg/IrgmE1EkzXk2wzdHi6GNLFH4=;
        b=V7vsIbAAMOm7r5/vB7Ns4QjlZXy/ryXsRn2FCGl4aCzUUi2gXw1gq8qJcT5GobOm/5
         QZdrDZKcIXGs1draZCDd2qStZIOUZ2m2xFe6vTbJKvTiFMV+9gjDb+lqPB3HiP6ReIWO
         Kv4wi4Xe1vLTygukRy2ptfSvcynClP2F+JrFJU3NTJnuUOMnTOXAoh/MmJhqLPLRBh5D
         iEXNnKqGeBLvuiy6eCyY+8urdkyDgf1HNFtnh5YPl6gOOf935XW87ypWMc4aAd3ULcBN
         p7nbsEn9Ybe/RxjYrRIAVaHDXuHAnShwzBMIAuDO+ljdGotaqdxl1ayYR60cZ5+Bxphp
         s9aw==
X-Gm-Message-State: APjAAAVeu05QT0fpIBnQOi0fLPI42Ex3wI+p/TSjqFYkwj8NQ6QVNHPJ
        BktAx9Uc9UfKJMW+bjwG4uZ8AkH6M47LOlXwWeC+FA==
X-Google-Smtp-Source: APXvYqxzvrolA8VKWhh/PCWTspZ6X1ImHyHFsNde4xNXJqWmdb4kpAbmdfPWVY+GfuBUC1O9mftgHi7aVHIiE4jBL10=
X-Received: by 2002:a63:b919:: with SMTP id z25mr87114130pge.201.1564086083398;
 Thu, 25 Jul 2019 13:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org> <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
In-Reply-To: <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 25 Jul 2019 13:21:12 -0700
Message-ID: <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amir Goldstein <amir73il@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@google.com>,
        David Rientjes <rientjes@google.com>,
        kunit-dev@googlegroups.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        wfg@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:31 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-07-22 15:30:49)
> > > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > >
> > > > What's the calling context of the assertions and expectations? I still
> > > > don't like the fact that string stream needs to allocate buffers and
> > > > throw them into a list somewhere because the calling context matters
> > > > there.
> > >
> > > The calling context is the same as before, which is anywhere.
> >
> > Ok. That's concerning then.
> >
> > >
> > > > I'd prefer we just wrote directly to the console/log via printk
> > > > instead. That way things are simple because we use the existing
> > > > buffering path of printk, but maybe there's some benefit to the string
> > > > stream that I don't see? Right now it looks like it builds a string and
> > > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > > just writing directly with printk.
> > >
> > > It's just buffering it so the whole string gets printed uninterrupted.
> > > If we were to print out piecemeal to printk, couldn't we have another
> > > call to printk come in causing it to garble the KUnit message we are
> > > in the middle of printing?
> >
> > Yes, printing piecemeal by calling printk many times could lead to
> > interleaving of messages if something else comes in such as an interrupt
> > printing something. Printk has some support to hold "records" but I'm
> > not sure how that would work here because KERN_CONT talks about only
> > being used early on in boot code. I haven't looked at printk in detail
> > though so maybe I'm all wrong and KERN_CONT just works?
>
> KERN_CONT does not guarantee that the message will get printed
> together. The pieces get interleaved with messages printed in
> parallel.
>
> Note that KERN_CONT was originally really meant to be used only during
> boot. It was later used more widely and ended in the best effort category.
>
> There were several attempts to make it more reliable. But it was
> always either too complicated or error prone or both.
>
> You need to use your own buffering if you rely want perfect output.
> The question is if it is really worth the complexity. Also note that
> any buffering reduces the chance that the messages will reach
> the console.

Seems like that settles it then. Thanks!

> BTW: There is a work in progress on a lockless printk ring buffer.
> It will make printk() more secure regarding deadlocks. But it might
> make transparent handling of continuous lines even more tricky.
>
> I guess that local buffering, before calling printk(), will be
> even more important then. Well, it might really force us to create
> an API for it.

Cool! Can you CC me on that discussion?

> > Can printk be called once with whatever is in the struct? Otherwise if
> > this is about making printk into a structured log then maybe printk
> > isn't the proper solution anyway. Maybe a dev interface should be used
> > instead that can handle starting and stopping tests (via ioctl) in
> > addition to reading test results, records, etc. with read() and a
> > clearing of the records. Then the seqfile API works naturally. All of
> > this is a bit premature, but it looks like you're going down the path of
> > making something akin to ftrace that stores binary formatted
> > assertion/expectation records in a lockless ring buffer that then
> > formats those records when the user asks for them.
>
> IMHO, ftrace postpones the text formatting primary because it does not
> not want to slow down the traced code more than necessary. It is yet
> another layer and there should be some strong reason for it.

Noted. Yeah, I would prefer avoiding printing out the info at a separate time.

> > I can imagine someone wanting to write unit tests that check conditions
> > from a simulated hardirq context via irq works (a driver mock
> > framework?), so this doesn't seem far off.
>
> Note that stroring the messages into the printk log is basically safe in any
> context. It uses temporary per-CPU buffers for recursive messages and
> in NMI. The only problem is panic() when some CPU gets stuck with the
> lock taken. This will get solved by the lockless ringbuffer. Also
> the temporary buffers will not be necessary any longer.

Sure, I think Stephen's concern is all the supporting code that is
involved. Not printk specifically. It just means a lot more of KUnit
has to be IRQ safe.

> Much bigger problems are with consoles. There are many of them. It
> means a lot of code and more locks involved, including scheduler
> locks. Note that console lock is a semaphore.

That shouldn't affect us though, right? As long as we continue to use
the printk interface?
