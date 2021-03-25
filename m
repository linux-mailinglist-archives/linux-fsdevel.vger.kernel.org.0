Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E523489C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYHCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 03:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCYHB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:01:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF393C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 00:01:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso990005oti.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Er9VTBwwaI4g9NSWPaQXCrSglwdU7EBlM0d7c0+OO70=;
        b=hbSQau/S0befhroiNXRd5O8t1oN/3OjEIMZCtSzpFl/RHERsBfwJwZVn6Nm5FDuLsn
         X3sE96eypk30BXKU2tgnMTmXLdrLEFveDKo4zr0M36qJwyT8nWlLcajgqON0Zz4xNSQ/
         qR7Ue/CQkq4CWUE6EA9jQngra/S/MAhRUej/W/rdhbXE+iGxs7vYzwRaKTIeH8lM7+t1
         KvLnUbsb4cs3XNHr3mNjZaNPjUnVAAqg/zKjDtUE3LJcrtlIva+eWdqE5sxgHi3R6Hk/
         M3ySio+sobh7dR7VNABom34tFO67Dp2oeR7GPXWNr1TW0hlyDutwoxRZ8vUjvvmRIcDk
         FQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er9VTBwwaI4g9NSWPaQXCrSglwdU7EBlM0d7c0+OO70=;
        b=sOPHvCZBNjNPdiZuX9Qx0pb88SmzxiK0ecDfkPENfOHlbJf3/9+aD2JEqfZ/DJot9d
         XP5fC8ohxNwHl+h9SRp5FpG0z+TEWzcxRMXrenyQtOMzxN+eu4OkBP2Q9KlqrnAnGNEO
         +FB8tBYo2utJwZ6tK3BxXa+mivT9/K1D/50no2Bl0UNjxoEym9S0NRMs4TnbFObuz8J8
         qfafxN+1oEq5PdY97kon2GA35qV7ya7BYnLu22PRYOXpO6Tlc/VvIvYs8X0nZs0YzNoa
         iOUo92hd7GURYTZa/WSx9tXbFTN/SExVTGEUHbBa5dDoT3l7eYo36G5OjpUvrfObG67w
         DHqQ==
X-Gm-Message-State: AOAM531WqoS822FI+SnOxRK/i2J9dreG1Ypi3dXVHgyGr/yN1vumijZ/
        r/sGWAKY/qjjqOLaEphVWreY7V8AV5dFPJu17+n9Ng==
X-Google-Smtp-Source: ABdhPJwPvrgsJnGrZMxNyLh8qM0Q/+YmupqLk+E6MqWkru1DKR/2BrqUxCJaMzwupgu4U06ClSQ0DcQAkr86B5+pQP8=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr6341695otg.17.1616655718013;
 Thu, 25 Mar 2021 00:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net> <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net> <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
 <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com> <CACT4Y+aRaNSaeWRA2H_q3k9+OpG0Lc3V7JWU8+whZ9s3gob-Kw@mail.gmail.com>
In-Reply-To: <CACT4Y+aRaNSaeWRA2H_q3k9+OpG0Lc3V7JWU8+whZ9s3gob-Kw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 25 Mar 2021 08:00:00 +0100
Message-ID: <CANpmjNOysjStB6VPDNaBnQe37VWtWq5c-7_p0kFbsbN5ohD0Lg@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Mar 2021 at 15:15, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Mar 24, 2021 at 3:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > One last try, I'll leave it alone now, I promise :-)
> > >
> > > This looks like it does what you suggested, thanks! :-)
> > >
> > > I'll still need to think about it, because of the potential problem
> > > with modify-signal-races and what the user's synchronization story
> > > would look like then.
> >
> > I agree that this looks inherently racy. The attr can't be allocated
> > on stack, user synchronization may be tricky and expensive. The API
> > may provoke bugs and some users may not even realize the race problem.
> >
> > One potential alternative is use of an opaque u64 context (if we could
> > shove it into the attr). A user can pass a pointer to the attr in
> > there (makes it equivalent to this proposal), or bit-pack size/type
> > (as we want), pass some sequence number or whatever.
>
> Just to clarify what I was thinking about, but did not really state:
> perf_event_attr_t includes u64 ctx, and we return it back to the user
> in siginfo_t. Kernel does not treat it in any way. This is a pretty
> common API pattern in general.

Ok, let's go for a new field in perf_event_attr which is copied to
si_perf. This gives user space full flexibility to decide what to
stick in it, and the kernel does not prescribe some weird encoding or
synchronization that user space would have to live with. I'll probably
call it perf_event_attr::sig_data, because all si_* things are macros.

Thanks,
-- Marco
