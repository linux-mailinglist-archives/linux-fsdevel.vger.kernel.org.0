Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAF366EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhDUPMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbhDUPMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:12:44 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4FC06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 08:12:09 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so9270079oop.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEXEAgUao8/U1XoW751IUwiCrSmDVaqLIc6z62zqqMg=;
        b=Vo5glLC6k7D+/dE1nb/qouPscezMFfLgYz7H9PDhiS+225DnfgsTkqbIQ3YKQxcbKH
         N9WNrIISNRSCIXZ0Xa2geQUHPwPnz1H0/r2shySWTDVl9W9/1wWxlwISt92QkyHI1/D5
         is4kUk+NU/HEU91rjPdqiJG5y3zN7p9qXt+Hmpoxbd5ZzCUXzUI+sZiJlvFysiAqPOzk
         2JWPjDS8PDVfeR7oLmiyTUp1U5Sj+Recg00TFzL2m2g9M6d82OTR14ZDv16kvT/l4M2D
         BpDuIcq7ihOTMmVUiwcrQGjhGXbhQPyPPMY7gQ1x2zK9oJETG0hcADBQKWBqljmgmIpW
         xnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEXEAgUao8/U1XoW751IUwiCrSmDVaqLIc6z62zqqMg=;
        b=EzpbBuwnkn5JRf4o+Znajyuv0l5kyS9z5roSvXv0dxO1zaLzZAQHGms+t+8nNnBrQy
         7hFrHuIoEhCCx4ofwm1cIFZk0hv0Y7YmJ5niggDbd6MsfMwXPOI5WfqZbK6rnYuxiJhV
         yZ64mg4J6pncDwhh3/MEet6j5c3qUVbDwLZPDFqeNnB92oVSqRdqxoZTBixK3jUxToU9
         ihtlRRcKxU9nF6CGv7RsYI5l+bGdQQIUUwNAwIvbPA0HZG2PpjqoeRYQQIxyrs0JZ+Ze
         gdIRTPmBeZiO+bvaUmjjpiS2+LN2lhTbd47g5630dvrsqvSisoZwM+KqAShVDhEeqhLd
         vSWw==
X-Gm-Message-State: AOAM533wsXYK/wN24t41T2BPfGrbJTgDPhd8VhKE1HAX8J4hb6S0SQPW
        4q5O1VSsAc6iPhXp9Bpq3u91fn0OdJwqTd5h0mgy6Q==
X-Google-Smtp-Source: ABdhPJyng+pvseRT0sVGDwFEJZ8TI5HsU+LGWY1XrOff8CcFEH9YHvKH2/GavzRvVwXXrQ+JymLm5bTa/K1m4eP+ih4=
X-Received: by 2002:a4a:d80e:: with SMTP id f14mr18296328oov.54.1619017928732;
 Wed, 21 Apr 2021 08:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com> <CGME20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8@eucas1p1.samsung.com>
 <20210408103605.1676875-6-elver@google.com> <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
 <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com> <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
 <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
 <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com> <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
 <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com> <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
In-Reply-To: <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 21 Apr 2021 17:11:57 +0200
Message-ID: <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc linux-arm-kernel

On Wed, 21 Apr 2021 at 15:19, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Marco,
>
> On 21.04.2021 13:03, Marco Elver wrote:
> > On Wed, 21 Apr 2021 at 12:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> On 21.04.2021 11:35, Marek Szyprowski wrote:
> >>> On 21.04.2021 10:11, Marco Elver wrote:
> >>>> On Wed, 21 Apr 2021 at 09:35, Marek Szyprowski
> >>>> <m.szyprowski@samsung.com> wrote:
> >>>>> On 21.04.2021 08:21, Marek Szyprowski wrote:
> >>>>>> On 21.04.2021 00:42, Marco Elver wrote:
> >>>>>>> On Tue, 20 Apr 2021 at 23:26, Marek Szyprowski
> >>>>>>> <m.szyprowski@samsung.com> wrote:
> >>>>>>>> On 08.04.2021 12:36, Marco Elver wrote:
> >>>>>>>>> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> >>>>>>>>> si_perf. These will be used by the perf event subsystem to send
> >>>>>>>>> signals
> >>>>>>>>> (if requested) to the task where an event occurred.
> >>>>>>>>>
> >>>>>>>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> >>>>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
> >>>>>>>>> Signed-off-by: Marco Elver <elver@google.com>
> >>>>>>>> This patch landed in linux-next as commit fb6cc127e0b6 ("signal:
> >>>>>>>> Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes
> >>>>>>>> regression on my test systems (arm 32bit and 64bit). Most systems
> >>>>>>>> fails
> >>>>>>>> to boot in the given time frame. I've observed that there is a
> >>>>>>>> timeout
> >>>>>>>> waiting for udev to populate /dev and then also during the network
> >>>>>>>> interfaces configuration. Reverting this commit, together with
> >>>>>>>> 97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to
> >>>>>>>> let it
> >>>>>>>> compile, on top of next-20210420 fixes the issue.
> >>>>>>> Thanks, this is weird for sure and nothing in particular stands out.
> >>>>>>>
> >>>>>>> I have questions:
> >>>>>>> -- Can you please share your config?
> >>>>>> This happens with standard multi_v7_defconfig (arm) or just defconfig
> >>>>>> for arm64.
> >>>>>>
> >>>>>>> -- Also, can you share how you run this? Can it be reproduced in
> >>>>>>> qemu?
> >>>>>> Nothing special. I just boot my test systems and see that they are
> >>>>>> waiting lots of time during the udev populating /dev and network
> >>>>>> interfaces configuration. I didn't try with qemu yet.
> >>>>>>> -- How did you derive this patch to be at fault? Why not just
> >>>>>>> 97ba62b27867, given you also need to revert it?
> >>>>>> Well, I've just run my boot tests with automated 'git bisect' and that
> >>>>>> was its result. It was a bit late in the evening, so I didn't analyze
> >>>>>> it further, I've just posted a report about the issue I've found. It
> >>>>>> looks that bisecting pointed to a wrong commit somehow.
> >>>>>>> If you are unsure which patch exactly it is, can you try just
> >>>>>>> reverting 97ba62b27867 and see what happens?
> >>>>>> Indeed, this is a real faulty commit. Initially I've decided to revert
> >>>>>> it to let kernel compile (it uses some symbols introduced by this
> >>>>>> commit). Reverting only it on top of linux-next 20210420 also fixes
> >>>>>> the issue. I'm sorry for the noise in this thread. I hope we will find
> >>>>>> what really causes the issue.
> >>>>> This was a premature conclusion. It looks that during the test I've did
> >>>>> while writing that reply, the modules were not deployed properly and a
> >>>>> test board (RPi4) booted without modules. In that case the board booted
> >>>>> fine and there was no udev timeout. After deploying kernel modules, the
> >>>>> udev timeout is back.
> >>>> I'm confused now. Can you confirm that the problem is due to your
> >>>> kernel modules, or do you think it's still due to 97ba62b27867? Or
> >>>> fb6cc127e0b6 (this patch)?
> >>> I don't use any custom kernel modules. I just deploy all modules that
> >>> are being built from the given kernel defconfig (arm
> >>> multi_v7_defconfig or arm64 default) and they are automatically loaded
> >>> during the boot by udev. I've checked again and bisect was right. The
> >>> kernel built from fb6cc127e0b6 suffers from the described issue, while
> >>> the one build from the previous commit (2e498d0a74e5) works fine.
> >> I've managed to reproduce this issue with qemu. I've compiled the kernel
> >> for arm 32bit with multi_v7_defconfig and used some older Debian rootfs
> >> image. The log and qemu parameters are here:
> >> https://protect2.fireeye.com/v1/url?k=7cfc23a2-23671aa9-7cfda8ed-002590f5b904-dab7e2ec39dae1f9&q=1&e=36a5ed13-6ad5-430c-8f44-e95c4f0af5c3&u=https%3A%2F%2Fpaste.debian.net%2F1194526%2F
> >>
> >> Check the timestamp for the 'EXT4-fs (vda): re-mounted' message and
> >> 'done (timeout)' status for the 'Waiting for /dev to be fully populated'
> >> message. This happens only when kernel modules build from the
> >> multi_v7_defconfig are deployed on the rootfs.
> > Still hard to say what is going on and what is at fault. But being
> > able to repro this in qemu helps debug quicker -- would you also be
> > able to share the precise rootfs.img, i.e. upload it somewhere I can
> > fetch it? And just to be sure, please also share your .config, as it
> > might have compiler-version dependent configuration that might help
> > repro (unlikely, but you never know).
>
> I've managed to reproduce this issue with a public Raspberry Pi OS Lite
> rootfs image, even without deploying kernel modules:
>
> https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip
>
> # qemu-system-arm -M virt -smp 2 -m 512 -kernel zImage -append "earlycon
> console=ttyAMA0 root=/dev/vda2 rw rootwait" -serial stdio -display none
> -monitor null -device virtio-blk-device,drive=virtio-blk -drive
> file=/tmp/2021-03-04-raspios-buster-armhf-lite.img,id=virtio-blk,if=none,format=raw
> -netdev user,id=user -device virtio-net-device,netdev=user
>
> The above one doesn't boot if zImage z compiled from commit fb6cc127e0b6
> and boots if compiled from 2e498d0a74e5. In both cases I've used default
> arm/multi_v7_defconfig and
> gcc-linaro-6.4.1-2017.11-x86_64_arm-linux-gnueabi toolchain.

Yup, I've narrowed it down to the addition of "__u64 _perf" to
siginfo_t. My guess is the __u64 causes a different alignment for a
bunch of adjacent fields. It seems that x86 and m68k are the only ones
that have compile-time tests for the offsets. Arm should probably add
those -- I have added a bucket of static_assert() in
arch/arm/kernel/signal.c and see that something's off.

I'll hopefully have a fix in a day or so.

Thanks,
-- Marco
