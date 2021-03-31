Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D38350515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhCaQui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhCaQuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:50:25 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FAC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 09:50:25 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso19585858otp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdpwslgy7i3fT+uqHNLqy9H/4PdpXsKpQtKlUmrnWNs=;
        b=Ic5OrjlK2s8S56gjj/cC3LJo+Zd6eYLbKKzA9nlhzS+DGhcnENAp5/sTGyrer47MYA
         9jRyxQ86yp9rpPZ+tUn/+kXJz+U2C1UJHAiobjQr0bYNm0bDVbAvJ2SmLRgxGgtbkWax
         VfSD5oIAMK3Hx3COMA4PLq4kf3nVuHSkPCetmASTDasMGzABVpnrNEJMtT4fDSIlQ/HX
         iUsEE4faTm3L8AODBS5Ae5F6V27fU+ZyZ7iJgB08v3kNjQxxdARgvkfaCOCXGGq64upm
         +/9NqEPLZlMVahIuuJfiQ6J+ki3DNXHGCitT/FhDo0DHZ1XJTabKI51qyEAN9ZfSspXa
         3+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdpwslgy7i3fT+uqHNLqy9H/4PdpXsKpQtKlUmrnWNs=;
        b=hxODz0ZS5GtD5QxIPkLz4hyDihFv6/PL8/pT/8lSw1tcMtGH2dzIrmRbJYjeUtIg1x
         gx/jByWfBODWZ6zG6N1f2RX66prN94rgfYGWb6DOU3cASGkRWDHIlC3OoO6+V4JnrnH0
         Fx9pMtBvAy+AMnuG8RCHbyFP0U1CpSDcGe/JHcZXdeduW9qEKji/hweBc09Osul4oyl8
         hdyigPOF7KHgJJnVarqRkxVN6w1plLglGnwM4TqjJoKtk3d0bbgcY2RiItP2mJcwx+mN
         qE0ToGU7GV+0GnBKrz7RC9dQwrfZSq/uUlaO+1Z9E/CCPkmCLkyukOaNy0EGzm+2afq4
         5IRA==
X-Gm-Message-State: AOAM531q3UoqNcaAD9d+CPaRPKSyYmUttnmMM7sGykPbF/80deQv+tVW
        YeGx/oCH4YfQ70wpGwpr0AQni0iwGvq4rRocNwVG8w==
X-Google-Smtp-Source: ABdhPJwb4gtrTABbnL6uQcyrjzA0brdgMtdN+E7/WammKTa93I0urg9baMlbzu4LK+C3GslQkiMyIoYkVbC7IqUTLbQ=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3484254otq.251.1617209424896;
 Wed, 31 Mar 2021 09:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <CANpmjNOPJNhJ2L7cxrvf__tCZpy=+T1nBotKmzr2xMJypd-oJQ@mail.gmail.com> <YGSMXJvLBpQOm3WV@hirez.programming.kicks-ass.net>
In-Reply-To: <YGSMXJvLBpQOm3WV@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 31 Mar 2021 18:50:12 +0200
Message-ID: <CANpmjNPGmzzg-uv3DGZ+1M+nDNy3WiFU7g3u_CzR-GBju+1Z_Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        <linux-kselftest@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Mar 2021 at 16:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 31, 2021 at 02:32:58PM +0200, Marco Elver wrote:
> > On Mon, 29 Mar 2021 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > (and we might already have a problem on some architectures where there
> > > can be significant time between these due to not having
> > > arch_irq_work_raise(), so ideally we ought to double check current in
> > > your case)
> >
> > I missed this bit -- just to verify: here we want to check that
> > event->ctx->task == current, in case the the irq_work runs when the
> > current task has already been replaced. Correct?
>
> Yeah, just not sure what a decent failure would be, silent ignore seems
> undesired, maybe WARN and archs that can trigger it get to fix it ?

I'll go with a WARN and add a comment.

This also revealed there should be a requirement that sigtrap events
must be associated with a task (syzkaller managed to trigger the
warning for cpu events).

Thanks,
-- Marco
