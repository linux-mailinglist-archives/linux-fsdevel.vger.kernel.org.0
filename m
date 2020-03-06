Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5029317C869
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 23:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCFWeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 17:34:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45238 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFWeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:34:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so4160962oic.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olqcvdNDEsEEHVidSmBf224StzdHlYaDh6Q/H8VQ18U=;
        b=ncOXjfUXXjzZmhUyLfXPdhqFTnTUDE3cbPGJmmH+5gyunAAbQJNixohNMdpUXu3weq
         u3g72vmPpNK9Za0wb96gzEnLKkQi3kMENHQwul4TJ30lrAe2jS2MEW3Xl0xFFrw59JSM
         eTyr5+ovLGL2FfnWz74Rx5rsr6KwTa8cidtSiIXAFcLR2R1INwjLAb6IGNthq5njhTfi
         MzT7L7ALNJd4lfU33h9yxtr7Ci4zuxUG3bmFKoniFNh11yAm7+QaNR10Z/WEzL57NITe
         j59SHdXYLUzyz4cU0LnyC39/HzF2OIcKZL2mCVBMx9a3ioPiZ4OrnfMGaHhUiXqy8s8r
         Ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olqcvdNDEsEEHVidSmBf224StzdHlYaDh6Q/H8VQ18U=;
        b=npgAcozWAYgVSbMMphP4W9TPG0G14u2ag9iq7udwvkxZc0qJAymEX/UyipkP+DWfCO
         2AIylMzWfWYTwIxNGlS3Hp4Ez04eaTU7uN3YUpJYWKhTnKSbrKCuqCpGJh6aVlg1PEiE
         E9MV0cLTe1fwfoYTlsT0VtAlzyeYmi/JAaFZPAKfbUBgBG7oKlrRpuIKl1c0UQq4EYFn
         80OYJivCdPrdZdmnWXTabFaFWtclOWHQqYDmJ+v1ZRihFD3Lhj2c3va/KpTeH/7aVMpK
         nuIFYGQKs1OiO7WjwIgsnRhTHfronYcpwPMapTO2z43CIv/5ixvlMiuYsHhRKCtcR8W9
         qXYw==
X-Gm-Message-State: ANhLgQ0NogPcI0NTspErZ3kc01h+B7xg3IR/DN/Kapgp0exFbMKQ25DQ
        iwq757xFvnXkYpdUBk7JcvyxhXF1KM62/gZWz4kKRw==
X-Google-Smtp-Source: ADFU+vtTQSCYfIkPWGQBtgesUsSbSZpEfanm2wnfHb9jO/zQFzUpzK3PpcOTydL+5qHVyJMO0k3v0fOAvG43iDXTH0c=
X-Received: by 2002:aca:75c1:: with SMTP id q184mr4264436oic.35.1583534054174;
 Fri, 06 Mar 2020 14:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com> <20200306084039.GC12561@hirez.programming.kicks-ass.net>
In-Reply-To: <20200306084039.GC12561@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Fri, 6 Mar 2020 14:34:20 -0800
Message-ID: <CAOBoifiWWcodi9HddxVsKUahTSdAS5OiQOcapDJ-4p+HufRzeQ@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 05, 2020 at 02:11:49PM -0800, Paul Turner wrote:
> > The goal is to improve jitter since we're constantly periodically
> > preempting other classes to run the watchdog.   Even on a single CPU
> > this is measurable as jitter in the us range.  But, what increases the
> > motivation is this disruption has been recently magnified by CPU
> > "gifts" which require evicting the whole core when one of the siblings
> > schedules one of these watchdog threads.
> >
> > The majority outcome being asserted here is that we could actually
> > exercise pick_next_task if required -- there are other potential
> > things this will catch, but they are much more braindead generally
> > speaking (e.g. a bug in pick_next_task itself).
>
> I still utterly hate what the patch does though; there is no way I'll
> have watchdog code hook in the scheduler like this. That's just asking
> for trouble.
>
> Why isn't it sufficient to sample the existing context switch counters
> from the watchdog? And why can't we fix that?

We could go to pick next and repick the same task. There won't be a
context switch but we still want to hold the watchdog. I assume such a
counter also needs to be per cpu and inside the rq lock. There doesn't
seem to be an existing one that fits this purpose.
