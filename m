Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345E2270FF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgISSOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISSOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 14:14:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFDAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2020 11:14:17 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x20so6962045ybs.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2020 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9ptxfdoEfwu73EnjCKZtaPVR45R7yiJGjZWUa14+0Q=;
        b=CtqaZek9ZP2Z2+ATOKYiaaPz8FaW/DMezoGqqNdpYCtZQpT30aNYA+No+MbCkulDW6
         6KZ7QSGsUIKbYPsIjGhW+6tLI2pf98R+9919LefYj+SfSuKZ/uHHWJ/lmqXGw/fIbgCQ
         cg3ImJNKdDTsqIJFWNfSf98awtSPYv4lCpHuWf735EpjboOmbwHJyEW12dxxEAjSkMZS
         nb6xqDZZxFKHjsff6mLCulQFA+j4XmXvR3mkTjD97tWFzmb5fNbkHUl1kwxWzb7WyhDB
         u47QhI41/vGWXsMOlrBw72Wp+ZciO1oEAMdgLLVrFkuOPV8DpuOI/Naaw3JIhEo27Z7d
         m+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9ptxfdoEfwu73EnjCKZtaPVR45R7yiJGjZWUa14+0Q=;
        b=lk/zPC9o7JYjvBe0oAG/EJYJZCJHelebLxFX/MAQVEqrd2tl/XM8eoBU2HlBTFPIen
         KrxDUxyeAlO1t3aGRoK6kKnfcse/JO/npY7/8uJR0l73kFqBhuaY7D5fIXqWgGZa8ukU
         oBg0r6TybWv9jmghbGJN3IlZJ8K2T4QqoSUjo45MVOKZmYZE5r03xfFrtJH+t7a9LcRr
         qygAJQaiIWs/Rrj4Qy0f2hF+2eGDM/f7v7L7aYaKAhzicXtf5x6m4vPo63e6YaADcsdU
         CL0xdGllskE9CSMRxCj+2Dbz0KheQm2c+G2IOlotlOau7E5M3xPyq8V+ZNjApWYqU6sS
         ayow==
X-Gm-Message-State: AOAM531sN6KJmyk0nzIG2LudZQyJWdM7HBum5CE8O3Xw1zNWKtI/UhNr
        DGIJjv2WyUA8KCwxPduFfMRrNNspUy1vjAepgferWA==
X-Google-Smtp-Source: ABdhPJxQgzG1sCr0K7HLhY1pGoCZ07AtiIQrQzaF6FDRFj8I9Qv6KVvvAX108TV8rENpG+uQZIJaPWy5jjrnJ+6//yg=
X-Received: by 2002:a25:5546:: with SMTP id j67mr8320422ybb.170.1600539256725;
 Sat, 19 Sep 2020 11:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195134.GK26186@redhat.com> <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
 <20200724093852-mutt-send-email-mst@kernel.org> <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
 <20200806004351-mutt-send-email-mst@kernel.org> <CA+EESO6bxhKf5123feNX1LZyyN2QL4Ti5ApPAu=xb3pHXd7cwQ@mail.gmail.com>
 <20200904033438.GI9411@redhat.com> <CA+EESO7yc9k79TxyQk+XvWbMfhMmax5GtJTYbNhDrb-0VgJunA@mail.gmail.com>
In-Reply-To: <CA+EESO7yc9k79TxyQk+XvWbMfhMmax5GtJTYbNhDrb-0VgJunA@mail.gmail.com>
From:   Nick Kralevich <nnk@google.com>
Date:   Sat, 19 Sep 2020 11:14:03 -0700
Message-ID: <CAFJ0LnEo-7YUvgOhb4pHteuiUW+wPfzqbwXUCGAA35ZMx11A-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com,
        Daniel Colascione <dancol@dancol.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 4, 2020 at 5:36 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> On Thu, Sep 3, 2020 at 8:34 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > 1) why don't you enforce the block of kernel initiated faults with
> >    seccomp-bpf instead of adding a sysctl value 2? Is the sysctl just
> >    an optimization to remove a few instructions per syscall in the bpf
> >    execution of Android unprivileged apps? You should block a lot of
> >    other syscalls by default to all unprivileged processes, including
> >    vmsplice.
> >
> >    In other words if it's just for Android, why can't Android solve it
> >    with only patch 1/2 by tweaking the seccomp filter?
>
> I would let Nick (nnk@) and Jeff (jeffv@) respond to this.
>
> The previous responses from both of them on this email thread
> (https://lore.kernel.org/lkml/CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com/
> and https://lore.kernel.org/lkml/CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com/)
> suggest that the performance overhead of seccomp-bpf is too much. Kees
> also objected to it
> (https://lore.kernel.org/lkml/202005200921.2BD5A0ADD@keescook/)
>
> I'm not familiar with how seccomp-bpf works. All that I can add here
> is that userfaultfd syscall is usually not invoked in a performance
> critical code path. So, if the performance overhead of seccomp-bpf (if
> enabled) is observed on all syscalls originating from a process, then
> I'd say patch 2/2 is essential. Otherwise, it should be ok to let
> seccomp perform the same functionality instead.
>

There are two primary reasons why seccomp isn't viable here.

1) Seccomp was never designed for whole-of-system protections, and is
impractical to deploy for anything other than "leaf" processes.
2) Attempts to enable seccomp on Android have run into performance
problems, even for trivial seccomp filters.

Let's go into each one.

Issue #1: Seccomp was never designed for whole-of-system protections,
and is impractical to deploy for anything other than "leaf" processes.

Andrea suggests deploying a seccomp filter purely focused on Android
unprivileged[1] (third party installed) apps. However, the intention
is for this security control to be used system-wide[2]. Only processes
which have a need for kernel initiated faults should be allowed to use
them; all other processes should be denied by default. And when I say
"all' processes, I mean "all" processes, even those which run with
UID=0. Andrea's proposal is akin to a denylist, where many modern
distributions (such as Android) use allowlists.

The seemingly obvious solution is to apply a global seccomp filter in
init (PID=1), but it falls down in practice. Seccomp is an incredibly
useful tool, but it wasn't designed to be applied system-wide. Seccomp
is fundamentally hierarchical in nature. A seccomp filter, once
applied, cannot be subsequently relaxed or removed in child processes.
While this restriction is great for leaf processes, it causes problems
for OS designers - a parent process must maintain an unused capability
if any process in the parent's process tree uses that capability. This
makes applying a userfaultfd seccomp filter in init impossible, since
we expect a few of init's children (but not init itself or most of
init's children) to use userfaultfd kernel faults. We end up back to a
wack-a-mole (denylist) problem of trying to modify each individual
process to block userfaultfd kernel faults, defeating the goals of
system-wide protection, and introducing significant complexity into
the system design.

Seccomp should be used in the context where it provides the most value
-- process leaf nodes. But trying to apply seccomp as a system-wide
control just isn't viable.

Lokesh's sysctl proposal doesn't have these problems. When the sysctl
is set to 2 by the OS distributor, all processes which don't have
CAP_SYS_PTRACE are denied kernel generated faults, making the system
safe-by-default. Only processes which are on the OS distributor's
CAP_SYS_PTRACE allowlist (see Android's allowlist at [3]) can generate
these faults, and capabilities can be managed without regards to
process hierarchy. This keeps the system minimally privileged and
safe.

Seccomp isn't a viable solution here.

Issue #2: Attempts to enable seccomp on Android globally have run into
performance problems, even for trivial seccomp filters.

Android has tried a few times to enable seccomp globally, but even
excluding the above-mentioned hierarchical process problems, we've
seen performance regressions across the board. Imposing a seccomp
filter merely for userfaultfd imposes a tax on every syscall, even if
the process never makes use of userfaultfd. Lokesh's sysctl proposal
avoids this tax and places the check where it's most effective, with
the rest of the userfaultfd functionality.

See also the threads that Lokesh mentioned above:

* https://lore.kernel.org/lkml/CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com/
* https://lore.kernel.org/lkml/CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com/
* https://lore.kernel.org/lkml/202005200921.2BD5A0ADD@keescook/

Thanks,
-- Nick

[1] The use of the term "unprivileged" is unfortunate. In Android,
there's no coarse-grain privileged vs unprivileged process. Each
process, including root processes, have only the privileges they need,
and not a bit more. As a concrete example, Android's init process
(PID=1) is not allowed to open TCP/UDP sockets, but is allowed to
spawn children which can do so. Having each process be differently
privileged, and ensuring that functionality is only given out on a
need-to-have basis, is an important part of modern OS design.

[2] The trend in modern exploits isn't to perform attacks directly
from untrusted code to the kernel. A lot of the attack surface needed
by an attacker isn't reachable directly from untrusted code, but only
indirectly through other processes. The attacker moves laterally
through the system, exploiting a process which has the necessary
capabilities, then escalating to the kernel. Enforcing security
controls system-wide is an important part of denying an attacker the
tools for an effective exploit and preventing this kind of lateral
movement from being useful. Denying an attacker access to kernel
initiated faults in userfaultfd system-wide (except for authorized
processes) is doubly important, as these kinds of faults are extremely
valuable to an exploit writer (see explanation at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cefdca0a86be517bc390fc4541e3674b8e7803b0
or https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit)

[3] https://android.googlesource.com/platform/system/sepolicy/+/7be9e9e372c70a5518f729a0cdcb0d39a28be377/private/domain.te#107
line 107

-- 
Nick Kralevich | nnk@google.com
