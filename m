Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC425E4BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 02:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIEAgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgIEAgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 20:36:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFCEC061246
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 17:36:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so8881378ioe.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2020 17:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MIVXqzuKXJr11dfoTHnTlrj+2SwhBNnLLWr83/0KD3w=;
        b=E1y2EOsETk3pbdJ6/iRUlu7O0cJxQvNJIexWcxc141uC4ftHh2EdX/3IBHJl/mgpox
         +evW4Te59Tfu4p7IYZm9RL9vW1U2LXnqbpRr10oMGX1NGMRhKF09mvOZvd8EC56mjJCa
         KiFXsjTz4muznj2ugtZnS0NGZyEzOMK8Zv29Iw+ThzgRjM/c5VQWdrrhIh+wlJbrQeeW
         1Lf9+/fvyMhxTPBF+qtwn6TgwCt1RE7sfl+FmP2vaFVSP0++cw0m1cOIpSOmka4nYI8F
         aHjaRZkBmzzhrmiCSGbWvbOwG5dQeKDyRKTsOLaFVNbXY6S1I/JjEc6CULIjK9WCJOgO
         Facg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MIVXqzuKXJr11dfoTHnTlrj+2SwhBNnLLWr83/0KD3w=;
        b=aznUlqkbdkE6v0w7ngS9a5/puexfsk9Cc6s5y1RPQCd+EFW33O1iEBc11int1vjai7
         70LQQkorkj7IwpCTCQnAsL8fF3FVKjU6Q14zUjzxHlPK5PU5pu0hfJkPyn7kcWJNbL7l
         KpvLXLSAglMiUdTkS6n8x6eAfFFSOnz+NFWCMbd2vS2+gdIVdwbOFeaxKf8fl2FJFL6d
         75IfeQyKojiFnhljqWtbGI2mBzP4uolOzK00USahD5rys0C39IbOxnz5lkdiCNuUVdiW
         WTnPzZlCBKrko8AWAZTAr6agczfccY9wTGtzlf7MHvy2l06yW4F/ET2liGRF21Xeu67L
         VfVQ==
X-Gm-Message-State: AOAM530r9KmYYjP0UwYw7rg9UIxJR7dyoJqI8aQOVfbRvGHvyfjb9DKb
        6dQUUlv0sYZK43ilWt2noNyAqz6gJZE3Mwty7XMf9A==
X-Google-Smtp-Source: ABdhPJwg4P/h/dvV1e5l1S3VhBd+msHGjLCJ0u/x18+jLCreCfOviqUykA7CF5eTj0VlHEXl8SiXP4yNS4usvSInq8s=
X-Received: by 2002:a02:780e:: with SMTP id p14mr2360306jac.144.1599266173913;
 Fri, 04 Sep 2020 17:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195134.GK26186@redhat.com> <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
 <20200724093852-mutt-send-email-mst@kernel.org> <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
 <20200806004351-mutt-send-email-mst@kernel.org> <CA+EESO6bxhKf5123feNX1LZyyN2QL4Ti5ApPAu=xb3pHXd7cwQ@mail.gmail.com>
 <20200904033438.GI9411@redhat.com>
In-Reply-To: <20200904033438.GI9411@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 4 Sep 2020 17:36:02 -0700
Message-ID: <CA+EESO7yc9k79TxyQk+XvWbMfhMmax5GtJTYbNhDrb-0VgJunA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nick Kralevich <nnk@google.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 3, 2020 at 8:34 PM Andrea Arcangeli <aarcange@redhat.com> wrote=
:
>
> Hello,
>
> On Mon, Aug 17, 2020 at 03:11:16PM -0700, Lokesh Gidra wrote:
> > There has been an emphasis that Android is probably the only user for
> > the restriction of userfaults from kernel-space and that it wouldn=E2=
=80=99t
> > be useful anywhere else. I humbly disagree! There are various areas
> > where the PROT_NONE+SIGSEGV trick is (and can be) used in a purely
> > user-space setting. Basically, any lazy, on-demand,
>
> For the record what I said is quoted below
> https://lkml.kernel.org/r/20200520194804.GJ26186@redhat.com :
>
> """It all boils down of how peculiar it is to be able to leverage only
> the acceleration [..] Right now there's a single user that can cope
> with that limitation [..] If there will be more users [..]  it'd be
> fine to add a value "2" later."""
>
> Specifically I never said "that it wouldn=E2=80=99t be useful anywhere el=
se.".
>
Thanks a lot for clarifying.

> Also I'm only arguing about the sysctl visible kABI change in patch
> 2/2: the flag passed as parameter to the syscall in patch 1/2 is all
> great, because seccomp needs it in the scalar parameter of the syscall
> to implement a filter equivalent to your sysctl "2" policy with only
> patch 1/2 applied.
>
> I've two more questions now:
>
> 1) why don't you enforce the block of kernel initiated faults with
>    seccomp-bpf instead of adding a sysctl value 2? Is the sysctl just
>    an optimization to remove a few instructions per syscall in the bpf
>    execution of Android unprivileged apps? You should block a lot of
>    other syscalls by default to all unprivileged processes, including
>    vmsplice.
>
>    In other words if it's just for Android, why can't Android solve it
>    with only patch 1/2 by tweaking the seccomp filter?

I would let Nick (nnk@) and Jeff (jeffv@) respond to this.

The previous responses from both of them on this email thread
(https://lore.kernel.org/lkml/CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2Ofq=
Vsy=3DSQ@mail.gmail.com/
and https://lore.kernel.org/lkml/CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV=
+=3DRrFntyQ@mail.gmail.com/)
suggest that the performance overhead of seccomp-bpf is too much. Kees
also objected to it
(https://lore.kernel.org/lkml/202005200921.2BD5A0ADD@keescook/)

I'm not familiar with how seccomp-bpf works. All that I can add here
is that userfaultfd syscall is usually not invoked in a performance
critical code path. So, if the performance overhead of seccomp-bpf (if
enabled) is observed on all syscalls originating from a process, then
I'd say patch 2/2 is essential. Otherwise, it should be ok to let
seccomp perform the same functionality instead.

>
> 2) given that Android is secure enough with the sysctl at value 2, why
>    should we even retain the current sysctl 0 semantics? Why can't
>    more secure systems just use seccomp and block userfaultfd, as it
>    is already happens by default in the podman default seccomp
>    whitelist (for those containers that don't define a new json
>    whitelist in the OCI schema)? Shouldn't we focus our energy in
>    making containers more secure by preventing the OCI schema of a
>    random container to re-enable userfaultfd in the container seccomp
>    filter instead of trying to solve this with a global sysctl?
>
>    What's missing in my view is a kubernetes hard allowlist/denylist
>    that cannot be overridden with the OCI schema in case people has
>    the bad idea of running containers downloaded from a not fully
>    trusted source, without adding virt isolation and that's an
>    userland problem to be solved in the container runtime, not a
>    kernel issue. Then you'd just add userfaultfd to the json of the
>    k8s hard seccomp denylist instead of going around tweaking sysctl.
>
> What's your take in changing your 2/2 patch to just replace value "0"
> and avoid introducing a new value "2"?

SGTM. Disabling uffd completely for unprivileged processes can be
achieved either using seccomp-bpf, or via SELinux, once the following
patch series is upstreamed
https://lore.kernel.org/lkml/20200827063522.2563293-1-lokeshgidra@google.co=
m/

>
> The value "0" was motivated by the concern that uffd can enlarge the
> race window for use after free by providing one more additional way to
> block kernel faults, but value "2" is already enough to solve that
> concern completely and it'll be the default on all Android.
>
> In other words by adding "2" you're effectively doing a more
> finegrined and more optimal implementation of "0" that remains useful
> and available to unprivileged apps and it already resolves all
> "robustness against side effects other kernel bugs" concerns. Clearly
> "0" is even more secure statistically but that would apply to every
> other syscall including vmsplice, and there's no
> /proc/sys/vm/unprivileged_vmsplice sysctl out there.
>
> The next issue we have now is with the pipe mutex (which is not a
> major concern but we need to solve it somehow for correctness). So I
> wonder if should make the default value to be "0" (or "2" if think we
> should not replace "0") and to allow only user initiated faults by
> default.
>
> Changing the sysctl default to be 0, will make live migration fail to
> switch to postcopy which will be (unnoticeable to the guest), instead
> of risking the VM to be killed because of network latency
> outlier. Then we wouldn't need to change the pipe code at all.
>
SGTM. I can change the default value to '0' (or '2') in the next
revision of patch 2/2, unless somebody objects to this.

> Alternatively we could still fix the pipe code so it runs better (but
> it'll be more complex) or to disable uffd faults only in the pipe
> code.
>
> One thing to keep in mind is that if we change the default, then
> hypervisor hosts running QEMU would need to set:
>
> vm.userfaultfd =3D 1
>
> in /etc/sysctl.conf if postcopy live migration is required, that's not
> particularly concerning constraint for qemu (there are likely other
> tweaks required and it looks less risky than an arbitrary timeout
> which could kill the VM: if the above is forgotten the postcopy live
> migration won't even start and it'll be unnoticeable to the guest).
>
> The main concern really are future apps that may want to use uffd for
> kernel initiated faults won't be allowed to do so by default anymore,
> those apps will be heavily incentivated to use bounce buffers before
> passing data to syscalls, similarly to the current use case of patch 2/2.
>
> Comments welcome,
> Andrea
>
> PS. Another usage of uffd that remains possible without privilege with
> the 2/2 patch sysctl "2" behavior (besides the strict SIGSEGV
> acceleration) is the UFFD_FEATURE_SIGBUS. That's good so a malloc lib
> will remain possible without requiring extra privileges, by adding a
> UFFDIO_POPULATE to use in combination with UFFD_FEATURE_SIGBUS
> (UFFDIO_POPULATE just needs to zero out a page and map it, it'll be
> indistinguishable to UFFDIO_ZEROPAGE but it will solve the last
> performance bottleneck by avoiding a wrprotect fault after the
> allocation and it will be THP capable too). Memory will be freed with
> MADV_DONTNEED, without ever having to call mmap/mumap. It could move
> memory around with UFFDIO_COPY+MADV_DONTNEED or by adding UFFDIO_REMAP
> which already exists.
>
UFFDIO_POPULATE sounds like a really useful feature. I don't see it in
the kernel yet. Is there a patch under work on this? If so, kindly
share.
