Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D7322F71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhBWRRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhBWRRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:17:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E48C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 09:16:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s107so16313441otb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/7lyBIawgXVibPEQjRnIJxZC4/J4mTsACbEERnxYDg=;
        b=mRjlqnBTeAG3y2s8FAauHnaH1SamsOPskLA8yoP4qMATNnDLnjombF0ueoOHemI4v+
         ON6jLAZhOorVDCKlKeVaclVW9ax1Wykz+j252M1N70rI88dT8+/ddGZqMupFk8ePUsvK
         lR4xLAbwYMFT1IC4bvpofpMVF0Gyw4e25Mcw1bCWYrZ7TrIvqotBPjioRqMac5HIgLYa
         XYfi7UxAvEjWctj8pwgTeUIb+FgkAKDx3VBwjigk5C2ZNvZd5+QhbZQoHnNks7gY3H+l
         VwJXfx7Fo2e8npir946O3k87wAW02SzO5wtDlyBr5gc6B5JV4UqSIR3Y9/ZCsk3rsY7Q
         MPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/7lyBIawgXVibPEQjRnIJxZC4/J4mTsACbEERnxYDg=;
        b=JtcNAEKzb1d5pmL3iNjtEPHtSKZ/eQPrveOOQmYIn80PLLFk2wGNvk/j3QSgTaOC0u
         TXPyD6jYbyKgjLc85KIuin89louQYjDF1Ui0XnS0RkPC1V4t42fubgJQbQvTlRSewC0b
         SlfSgmcvYyo3ER6p1QStqN3JOlexCmFfo4rfjS/E7UF7zaYDUC7dHjvdIV7aUB+Inxot
         lVD1H6MMoummyal5kkCHi0C3WAyQSTGTYkWTPq0gR7YGqV507AnnMEFApwliE6OEBjtU
         9BJ2i2QU2ZYPlYQi+y3gw4+GKRopGdxt5nsXyT9jYsplMnYzRq2Ybtri+8NGhVQvB02I
         Hpyg==
X-Gm-Message-State: AOAM533fkC1wIIW1eQhIGkCQdL06BAgT/gFKZg+nZYuCehXrdiF5AXYR
        glgXpxIxgqEQFZJQbwZr2JKU6ev3AVey8kBbzmridA==
X-Google-Smtp-Source: ABdhPJw2zJQHH6G+SOVfrrWuVDvoFs3AyTMegDYPDbhen+c9h8Rqfm/XJ8UoE2cbXebtHnL9Z/5RERNNXFBoFBXyXaU=
X-Received: by 2002:a05:6830:1552:: with SMTP id l18mr21502367otp.233.1614100592568;
 Tue, 23 Feb 2021 09:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-5-elver@google.com>
 <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com>
 <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com> <CACT4Y+ar7=q0p=LFxkbKbKhz-U3rwdf=PJ3Gg3=ZLP6w_sgTeA@mail.gmail.com>
In-Reply-To: <CACT4Y+ar7=q0p=LFxkbKbKhz-U3rwdf=PJ3Gg3=ZLP6w_sgTeA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Feb 2021 18:16:20 +0100
Message-ID: <CANpmjNO-xj8jnakVoWBbjPjn2gjHaugEVJTOebfdpvSwZhG5LQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Feb 2021 at 16:16, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Feb 23, 2021 at 4:10 PM 'Marco Elver' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > > > Encode information from breakpoint attributes into siginfo_t, which
> > > > helps disambiguate which breakpoint fired.
> > > >
> > > > Note, providing the event fd may be unreliable, since the event may have
> > > > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > > > triggering and the signal being delivered to user space.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  kernel/events/core.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 8718763045fd..d7908322d796 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
> > > >         info.si_signo = SIGTRAP;
> > > >         info.si_code = TRAP_PERF;
> > > >         info.si_errno = event->attr.type;
> > > > +
> > > > +       switch (event->attr.type) {
> > > > +       case PERF_TYPE_BREAKPOINT:
> > > > +               info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > > > +               info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > > > +               break;
> > > > +       default:
> > > > +               /* No additional info set. */
> > >
> > > Should we prohibit using attr.sigtrap for !PERF_TYPE_BREAKPOINT if we
> > > don't know what info to pass yet?
> >
> > I don't think it's necessary. This way, by default we get support for
> > other perf events. If user space observes si_perf==0, then there's no
> > information available. That would require that any event type that
> > sets si_perf in future, must ensure that it sets si_perf!=0.
> >
> > I can add a comment to document the requirement here (and user space
> > facing documentation should get a copy of how the info is encoded,
> > too).
> >
> > Alternatively, we could set si_errno to 0 if no info is available, at
> > the cost of losing the type information for events not explicitly
> > listed here.

Note that PERF_TYPE_HARDWARE == 0, so setting si_errno to 0 does not
work. Which leaves us with:

1. Ensure si_perf==0 (or some other magic value) if no info is
available and !=0 otherwise.

2. Return error for events where we do not officially support
requesting sigtrap.

I'm currently leaning towards (1).

> > What do you prefer?
>
> Ah, I see.
> Let's wait for the opinions of other people. There are a number of
> options for how to approach this.
