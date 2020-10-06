Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D828440D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 04:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJFCVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 22:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJFCVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:21:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409AC0613A7
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2020 19:21:19 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so10957227oif.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7YQCtriFYyuSJeB+Rgpa2EtsmRfHWlWKqL/m20tV3g=;
        b=agICYGi+Zn+O2nR9/R+3zPUtITCJKzAHXYSO0EXnIJALzDNMqz7ZwtmSW0xl5lK7QN
         SQnBKpakW1T5Af48cSGdx2s93g35gI5bdf2Dv/NyBDEjXfBq4wzQLuOWNUSh0Tb/mfeE
         lFyTYtsedupVZkPBrNnTtFKw76wgcKIs5rOj7EB2c9/36vYfFH3dfVTD94ZfitCQlUHi
         lOH2bT6zyjUD61tAZ92i8qHQeZPbtr5zjQ/BVpbrVY1YXh11wsLY/PChT1cwOQPabyGO
         JhdyoDKB6+00x8KFWur0gJHvcxBj/JmQWGvMifEAO7/nT/Ug79gIahNH+xdOKxjvgvNO
         0Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7YQCtriFYyuSJeB+Rgpa2EtsmRfHWlWKqL/m20tV3g=;
        b=pRFeltuTRSoNWvft7t8QxRTI3gaIJrW7x2Gr9C32ZihtkD4frNGkmodePaDhwW1KUm
         ZPSmX4bWlq6AyCZ6ZYf23tr7m+0lXuzTKThf1tQ+B4eEu0G2OMryUxKnZKhbaORyLojH
         1u3CMMPUKQ9DDyem8uRLw+7SgzB1NThzKMdiy+FFqVSwqw71IY+Iy24L1LpczBTHcnCz
         6Ds6CqBb54ERIJpxbjodKk70+lPxEC+hBij34joVJzSDcrrhX7Hdr1vaXIRQYT4UM8sM
         tSlbgyWhkChXBtA6WK+S0HuwauL+SItCxr43Epdv+DVVjlU5Pcfd6UdIoCWN0UIS0tS4
         PB5w==
X-Gm-Message-State: AOAM531VPscG5rEHohydPQrMdKzgb6er/uBEbrPq5svSrqwt9TAqch/P
        Oz8iV+/E1yAV7gEuPMp+QaLRsEnUi9pY8Yge416ZqA==
X-Google-Smtp-Source: ABdhPJyaigADMxJVRHsJXTDpn7xQepDIyEsrSKDqr2gON8I7pqtt4ytgpvEH4UI3M9PIXZzqObSCbLTZmVNH33TZ/pw=
X-Received: by 2002:aca:4911:: with SMTP id w17mr1388997oia.80.1601950878466;
 Mon, 05 Oct 2020 19:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com>
 <20200306084039.GC12561@hirez.programming.kicks-ass.net> <CAOBoifiWWcodi9HddxVsKUahTSdAS5OiQOcapDJ-4p+HufRzeQ@mail.gmail.com>
 <20201005111920.GO2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201005111920.GO2611@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Mon, 5 Oct 2020 19:21:18 -0700
Message-ID: <CAOBoifgYxJsrVxjdJL_QmAUwRDq8uwfbUKS4089U08N1+F1XTQ@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 5, 2020 at 4:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 06, 2020 at 02:34:20PM -0800, Xi Wang wrote:
> > On Fri, Mar 6, 2020 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Mar 05, 2020 at 02:11:49PM -0800, Paul Turner wrote:
> > > > The goal is to improve jitter since we're constantly periodically
> > > > preempting other classes to run the watchdog.   Even on a single CPU
> > > > this is measurable as jitter in the us range.  But, what increases the
> > > > motivation is this disruption has been recently magnified by CPU
> > > > "gifts" which require evicting the whole core when one of the siblings
> > > > schedules one of these watchdog threads.
> > > >
> > > > The majority outcome being asserted here is that we could actually
> > > > exercise pick_next_task if required -- there are other potential
> > > > things this will catch, but they are much more braindead generally
> > > > speaking (e.g. a bug in pick_next_task itself).
> > >
> > > I still utterly hate what the patch does though; there is no way I'll
> > > have watchdog code hook in the scheduler like this. That's just asking
> > > for trouble.
> > >
> > > Why isn't it sufficient to sample the existing context switch counters
> > > from the watchdog? And why can't we fix that?
> >
> > We could go to pick next and repick the same task. There won't be a
> > context switch but we still want to hold the watchdog. I assume such a
> > counter also needs to be per cpu and inside the rq lock. There doesn't
> > seem to be an existing one that fits this purpose.
>
> Sorry, your reply got lost, but I just ran into something that reminded
> me of this.
>
> There's sched_count. That's currently schedstat, but if you can find a
> spot in a hot cacheline (from schedule()'s perspective) then it
> should be cheap to incremenent unconditionally.
>
> If only someone were to write a useful cacheline perf tool (and no that
> c2c trainwreck doesn't count).
>

Thanks, I'll try the alternative implementation.

-Xi
