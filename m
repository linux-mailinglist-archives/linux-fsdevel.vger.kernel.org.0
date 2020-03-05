Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB87017B133
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 23:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEWIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 17:08:16 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44378 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgCEWIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:08:16 -0500
Received: by mail-io1-f66.google.com with SMTP id u17so88067iog.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGS8rnXzHLbpXsJJAH3jh30eyIA7p3nGgcBVwa0A2w8=;
        b=fzqeEciFPF22o5uyQb5nHvkhVF8jr5xf2Wo5iKCh1x0QlRNspF7nqIhsmjI6R0JPN3
         tEi8EvQg+inlv/MZY/54d5x7ow47ExRcP9TN/GAsrIS1QseaOW3dXjAgAuotTHd1SuqV
         ap65h9Hkwnl1INBV+i9n2vvRw9p/S2xfuN7/ilfX8B2CIGzQ1/2M+qxLydAVK46c2LRS
         WDYy39RorrBeZYlr+8liVxg6aCqJj6o6vxBtEgPtYT8GgiTuN0cG7NYJPqe+vjD5yxW+
         5udG5txKOInbYOZbpMrrUpx2jq6Vcgl4vcCnIXy7A1eK5Npk0zFKcuDVPHxzAQlYoeox
         ZAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGS8rnXzHLbpXsJJAH3jh30eyIA7p3nGgcBVwa0A2w8=;
        b=UPtR2Z/psLo0Vw4Lkka+7udkcAqS3AlZ7xZrQhOaJRsOQJjf0pWkzQaw9PHahOZqdb
         ot8/qFixJqPpvlpTybTaokWLE9waVYggfC/D/nU7rdaUApzdAb5ARBe9Pb1dgGHGk5vG
         f89g3hPkNhUDtNJOFAtvpXnjiikqlwawaSAbnadIVTvqLop7PgB/hrcdnYNo8FjElN6p
         AIbBJAzt8mVZBLnFrwd/nBlxGvf6R7ElRkasM5tbi7+H6RDK7For4MzH8iMp7hjqEOiS
         A0dXPZH0/Y1iX1Ode4x/LA+X5BzftFC1yjSEN50c7Y79LfM1wASHdNZVWsOJUoMFik8P
         ZCMA==
X-Gm-Message-State: ANhLgQ2jTLBt22wXZbnIWaW9VnBXZHMQcNOr2x+iYIB2H3G/kr7nZrNw
        fq4onmHaKXYEFtrHLK9acfPSrY4wD0h36ZTo13ZX6g==
X-Google-Smtp-Source: ADFU+vveEQCvuJ7btQNldSOgXGFAeDpBOkfuEX1g8TVAtm4CcqZ0jqP7fo30nSwwhYYivnaHCnk+9qqz5ORdkzcvwIk=
X-Received: by 2002:a02:3093:: with SMTP id q141mr650220jaq.121.1583446094877;
 Thu, 05 Mar 2020 14:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <87blpad6b2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blpad6b2.fsf@nanos.tec.linutronix.de>
From:   Paul Turner <pjt@google.com>
Date:   Thu, 5 Mar 2020 14:07:37 -0800
Message-ID: <CAPM31RKR4w75Y8oNxS-cZ77AauvCFFXRzH=hhWXfr6LLQt2Myw@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Xi Wang <xii@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, Mar 5, 2020 at 10:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
> >> The main purpose of kernel watchdog is to test whether scheduler can
> >> still schedule tasks on a cpu. In order to reduce latency from
> >> periodically invoking watchdog reset in thread context, we can simply
> >> touch watchdog from pick_next_task in scheduler. Compared to actually
> >> resetting watchdog from cpu stop / migration threads, we lose coverage
> >> on: a migration thread actually get picked and we actually context
> >> switch to the migration thread. Both steps are heavily protected by
> >> kernel locks and unlikely to silently fail. Thus the change would
> >> provide the same level of protection with less overhead.
> >>
> >> The new way vs the old way to touch the watchdogs is configurable
> >> from:
> >>
> >> /proc/sys/kernel/watchdog_touch_in_thread_interval
> >>
> >> The value means:
> >> 0: Always touch watchdog from pick_next_task
> >> 1: Always touch watchdog from migration thread
> >> N (N>0): Touch watchdog from migration thread once in every N
> >>          invocations, and touch watchdog from pick_next_task for
> >>          other invocations.
> >>
> >
> > This is configurable madness. What are we really trying to do here?
>
> Create yet another knob which will be advertised in random web blogs to
> solve all problems of the world and some more. Like the one which got
> silently turned into a NOOP ~10 years ago :)
>

The knob can obviously be removed, it's vestigial and reflects caution
from when we were implementing / rolling things over to it.  We have
default values that we know work at scale. I don't think this actually
needs or wants to be tunable beyond on or off (and even that could be
strictly compile or boot time only).
