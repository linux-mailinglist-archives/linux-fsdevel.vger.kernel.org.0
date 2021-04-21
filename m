Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFC736699B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhDULET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDULES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:04:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B23C06138A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 04:03:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i81so42032411oif.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwvnjSj2op3l1hxnf84tZDl7adPmWlaJUCzqnfca75k=;
        b=T25LZuGfJ99uC4k4xebDbykX3ipGF/M4COVddFMHTQXl6mSwJ/VYqXX9r3znYQT+Pp
         PdSDPCL+TNIgLmAWvoEA3dmwAEc67h6RPMGovEnvczMC9JXoJxLW0GwaZP0PsXx29EmH
         7ym2FaLr3NC5RKBBRo6y8iWfbSAw1Lj38n/HVVf84B3eQLVLlaNnU9tJwgl9QDpU4njt
         8xFiIRWWeIedZu7ghOH6MbFfiRr5tWrgsn6kPyTU6kynOw3dwDCwgSM42+9mKrmpKN+a
         anQaU7HFU9MdjYGQAayHU+s8JDMpm1R0+YApXbPtU6DWZFyqZ4MzR7O1OGfQjkf/0svc
         lZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwvnjSj2op3l1hxnf84tZDl7adPmWlaJUCzqnfca75k=;
        b=qO054+3U1IYAdrWfGh5BBmNwkeEbaJxCkzB85zYsc+c1neMjdnC2VB8xwa3r79pja6
         SRhr0O686b9itqwCRoNxxG5ck88rofwzHJ8r0ZSDrkO5RXEC3rifcjHfhg68AOUXqLGI
         orzz1z4gz8HyUzvbuH7xH0Bp0xmVpAD5RwUh9Nfo0qPHBT398jrpdSDBCVTEXZBoWmV4
         55UBmgsurpPDDGY4UM5d//OD3iknd/hOmZpoxvuBMwZHFRSL5yP/Ai5z428qWtBS1Kkf
         Wi3lfLV12KqV5IuUjFbhOidTcN2E/zIFa8sW6JvlVdC9qChEFcMjjY8QkWi/G5ELQsCw
         R/7Q==
X-Gm-Message-State: AOAM533c6pG1fa8qCQWyEktmkLQmY2nvekkDplGSlx3l2K4PuHaSRq8v
        +ko9qEibyX85G5ilT3V5DZd9XJzkk8esQSQSMwDotg==
X-Google-Smtp-Source: ABdhPJwE42OPaob1XuiEppH2vDMm/8Ts+i5KcnlRbpbc7TceFAsxOoPBOwSiMSAxKrBuAthUp16aIaik3VIF6DZLUrk=
X-Received: by 2002:aca:44d6:: with SMTP id r205mr6376630oia.172.1619003024370;
 Wed, 21 Apr 2021 04:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com> <CGME20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8@eucas1p1.samsung.com>
 <20210408103605.1676875-6-elver@google.com> <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
 <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com> <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
 <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
 <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com> <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
In-Reply-To: <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 21 Apr 2021 13:03:32 +0200
Message-ID: <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com>
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

On Wed, 21 Apr 2021 at 12:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 21.04.2021 11:35, Marek Szyprowski wrote:
> > On 21.04.2021 10:11, Marco Elver wrote:
> >> On Wed, 21 Apr 2021 at 09:35, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >>> On 21.04.2021 08:21, Marek Szyprowski wrote:
> >>>> On 21.04.2021 00:42, Marco Elver wrote:
> >>>>> On Tue, 20 Apr 2021 at 23:26, Marek Szyprowski
> >>>>> <m.szyprowski@samsung.com> wrote:
> >>>>>> On 08.04.2021 12:36, Marco Elver wrote:
> >>>>>>> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> >>>>>>> si_perf. These will be used by the perf event subsystem to send
> >>>>>>> signals
> >>>>>>> (if requested) to the task where an event occurred.
> >>>>>>>
> >>>>>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> >>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
> >>>>>>> Signed-off-by: Marco Elver <elver@google.com>
> >>>>>> This patch landed in linux-next as commit fb6cc127e0b6 ("signal:
> >>>>>> Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes
> >>>>>> regression on my test systems (arm 32bit and 64bit). Most systems
> >>>>>> fails
> >>>>>> to boot in the given time frame. I've observed that there is a
> >>>>>> timeout
> >>>>>> waiting for udev to populate /dev and then also during the network
> >>>>>> interfaces configuration. Reverting this commit, together with
> >>>>>> 97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to
> >>>>>> let it
> >>>>>> compile, on top of next-20210420 fixes the issue.
> >>>>> Thanks, this is weird for sure and nothing in particular stands out.
> >>>>>
> >>>>> I have questions:
> >>>>> -- Can you please share your config?
> >>>> This happens with standard multi_v7_defconfig (arm) or just defconfig
> >>>> for arm64.
> >>>>
> >>>>> -- Also, can you share how you run this? Can it be reproduced in
> >>>>> qemu?
> >>>> Nothing special. I just boot my test systems and see that they are
> >>>> waiting lots of time during the udev populating /dev and network
> >>>> interfaces configuration. I didn't try with qemu yet.
> >>>>> -- How did you derive this patch to be at fault? Why not just
> >>>>> 97ba62b27867, given you also need to revert it?
> >>>> Well, I've just run my boot tests with automated 'git bisect' and that
> >>>> was its result. It was a bit late in the evening, so I didn't analyze
> >>>> it further, I've just posted a report about the issue I've found. It
> >>>> looks that bisecting pointed to a wrong commit somehow.
> >>>>> If you are unsure which patch exactly it is, can you try just
> >>>>> reverting 97ba62b27867 and see what happens?
> >>>> Indeed, this is a real faulty commit. Initially I've decided to revert
> >>>> it to let kernel compile (it uses some symbols introduced by this
> >>>> commit). Reverting only it on top of linux-next 20210420 also fixes
> >>>> the issue. I'm sorry for the noise in this thread. I hope we will find
> >>>> what really causes the issue.
> >>> This was a premature conclusion. It looks that during the test I've did
> >>> while writing that reply, the modules were not deployed properly and a
> >>> test board (RPi4) booted without modules. In that case the board booted
> >>> fine and there was no udev timeout. After deploying kernel modules, the
> >>> udev timeout is back.
> >> I'm confused now. Can you confirm that the problem is due to your
> >> kernel modules, or do you think it's still due to 97ba62b27867? Or
> >> fb6cc127e0b6 (this patch)?
> >
> > I don't use any custom kernel modules. I just deploy all modules that
> > are being built from the given kernel defconfig (arm
> > multi_v7_defconfig or arm64 default) and they are automatically loaded
> > during the boot by udev. I've checked again and bisect was right. The
> > kernel built from fb6cc127e0b6 suffers from the described issue, while
> > the one build from the previous commit (2e498d0a74e5) works fine.
>
> I've managed to reproduce this issue with qemu. I've compiled the kernel
> for arm 32bit with multi_v7_defconfig and used some older Debian rootfs
> image. The log and qemu parameters are here:
> https://paste.debian.net/1194526/
>
> Check the timestamp for the 'EXT4-fs (vda): re-mounted' message and
> 'done (timeout)' status for the 'Waiting for /dev to be fully populated'
> message. This happens only when kernel modules build from the
> multi_v7_defconfig are deployed on the rootfs.

Still hard to say what is going on and what is at fault. But being
able to repro this in qemu helps debug quicker -- would you also be
able to share the precise rootfs.img, i.e. upload it somewhere I can
fetch it? And just to be sure, please also share your .config, as it
might have compiler-version dependent configuration that might help
repro (unlikely, but you never know).

Thanks,
-- Marco
