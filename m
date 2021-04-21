Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA373666C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhDUIMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhDUIMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:12:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F3C06138D
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 01:11:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k18so36719208oik.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msdAKUkaozlyVVqcOzRUhmh/jucXO4phsOtdu8kld0Q=;
        b=pmcZpnXrP/hJMVCWPTO21s5w2C6jBAae3cwns8jXbIAlH8wJ0ociggMr54Xu8ecPyu
         Ts3vAfnbXRjGjjaOpdE3khaNxMfkIVFLJs/VPTchrldH57VyWiKm8/PkO/l23yKf4/B3
         PXP7y7a4IoRg94BZn74bFwwZuTsbMP2+7LlFMn6D4/NCGWLNAD/L1eTKPx8wPv62+K5u
         Q63UbNpzHT2Bhe2SyiaDu8W01foSt9YJIpvEZ+mbLLePdV1OVgc1nHGpkdTQIyVNOYz5
         7nu42E7mOjFlfnXKGUZk9PnyUQSPNEG+OC0vaYfSAZ+E4f+Cce2o4a7yASOZ0U6u4TA8
         eCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msdAKUkaozlyVVqcOzRUhmh/jucXO4phsOtdu8kld0Q=;
        b=Sgl9kmB24sm8/Rjp1HgIMxNAvcjQd4jDYQGhfI8u0o20+eEsnoi1B1k6i8pyfjfyK8
         p4KTOqKrFWMTn7b/kSm+s8CppwEZIthM/S52NniNST/cBK8S18KBZ5vpKZ9+tb9ku0au
         vvws2Z/p+bxhEuCnUdrXXHjWhcMJ+aQ1JsN7gRK9Zzt0IHrlM/U1RduZDfAFevlJvxU7
         XBhNvo6IHtifz9KqO1EAruqhLCuzBMk0mscaEq8n7IK5Smbn4er9EqKRT9I2HDdsNtyB
         yQXLIPZXycCaHwB8B/GV578yeAneoWQgGdwbM647oejiqNlNpql4WREFBYYaw74Tllcc
         u1aQ==
X-Gm-Message-State: AOAM533U6hLexUPSIKZdqxFpO15EwBFTLM1eCZFLyU3cArS29O9vq3gv
        uZtaJMmxq14TjZmlw0JjyEB1jNyDYjzV4nZEt3HpWQ==
X-Google-Smtp-Source: ABdhPJy1tfc8MMLbLxb17dL/Fz+emF7KQc0Sq2AZPCRIAITdiREKq62E+vLNNTXjO6JYEXGn4JOR0UYxdckLCtorADI=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr6066042oif.121.1618992705356;
 Wed, 21 Apr 2021 01:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com> <CGME20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8@eucas1p1.samsung.com>
 <20210408103605.1676875-6-elver@google.com> <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
 <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com> <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
In-Reply-To: <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 21 Apr 2021 10:11:33 +0200
Message-ID: <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Apr 2021 at 09:35, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 21.04.2021 08:21, Marek Szyprowski wrote:
> > On 21.04.2021 00:42, Marco Elver wrote:
> >> On Tue, 20 Apr 2021 at 23:26, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >>> On 08.04.2021 12:36, Marco Elver wrote:
> >>>> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> >>>> si_perf. These will be used by the perf event subsystem to send
> >>>> signals
> >>>> (if requested) to the task where an event occurred.
> >>>>
> >>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> >>>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
> >>>> Signed-off-by: Marco Elver <elver@google.com>
> >>> This patch landed in linux-next as commit fb6cc127e0b6 ("signal:
> >>> Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes
> >>> regression on my test systems (arm 32bit and 64bit). Most systems fails
> >>> to boot in the given time frame. I've observed that there is a timeout
> >>> waiting for udev to populate /dev and then also during the network
> >>> interfaces configuration. Reverting this commit, together with
> >>> 97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to let it
> >>> compile, on top of next-20210420 fixes the issue.
> >> Thanks, this is weird for sure and nothing in particular stands out.
> >>
> >> I have questions:
> >> -- Can you please share your config?
> >
> > This happens with standard multi_v7_defconfig (arm) or just defconfig
> > for arm64.
> >
> >> -- Also, can you share how you run this? Can it be reproduced in qemu?
> > Nothing special. I just boot my test systems and see that they are
> > waiting lots of time during the udev populating /dev and network
> > interfaces configuration. I didn't try with qemu yet.
> >> -- How did you derive this patch to be at fault? Why not just
> >> 97ba62b27867, given you also need to revert it?
> > Well, I've just run my boot tests with automated 'git bisect' and that
> > was its result. It was a bit late in the evening, so I didn't analyze
> > it further, I've just posted a report about the issue I've found. It
> > looks that bisecting pointed to a wrong commit somehow.
> >> If you are unsure which patch exactly it is, can you try just
> >> reverting 97ba62b27867 and see what happens?
> >
> > Indeed, this is a real faulty commit. Initially I've decided to revert
> > it to let kernel compile (it uses some symbols introduced by this
> > commit). Reverting only it on top of linux-next 20210420 also fixes
> > the issue. I'm sorry for the noise in this thread. I hope we will find
> > what really causes the issue.
>
> This was a premature conclusion. It looks that during the test I've did
> while writing that reply, the modules were not deployed properly and a
> test board (RPi4) booted without modules. In that case the board booted
> fine and there was no udev timeout. After deploying kernel modules, the
> udev timeout is back.

I'm confused now. Can you confirm that the problem is due to your
kernel modules, or do you think it's still due to 97ba62b27867? Or
fb6cc127e0b6 (this patch)?

Thanks,
-- Marco
