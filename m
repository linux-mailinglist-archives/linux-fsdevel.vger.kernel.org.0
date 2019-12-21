Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04141128946
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLUNxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 08:53:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLUNxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 08:53:51 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MG90u-1iS9zd45cK-00GcBo; Sat, 21 Dec 2019 14:53:50 +0100
Received: by mail-qk1-f182.google.com with SMTP id z14so8770952qkg.9;
        Sat, 21 Dec 2019 05:53:49 -0800 (PST)
X-Gm-Message-State: APjAAAWfxpQ8Ni+qs3L+IUdUwrTRHzu3mWhdoGW7koLU/Ww4oZjx4mXp
        Pv4W022I6m7YZW8XzfEqOeJ5whABEWSq4ZbKby4=
X-Google-Smtp-Source: APXvYqzdkKB4eWJLyIMGbY84AVCwTo394eD7uI1YKdpNDtFn1NdJbNSgdawpABz0czREJyOLKl+WVti5eWx7OSdPMjA=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr18290266qke.394.1576936428655;
 Sat, 21 Dec 2019 05:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
 <20191219103525.yqb5f4pbd2dvztkb@wittgenstein> <CAMp4zn_z-CCQYMpT=GjZeGVLobjHBCSbmfha1rtWdmptOQ8JtA@mail.gmail.com>
 <20191220043510.r5h6wvsp2p5glyjv@yavin.dot.cyphar.com>
In-Reply-To: <20191220043510.r5h6wvsp2p5glyjv@yavin.dot.cyphar.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 21 Dec 2019 13:53:32 +0000
X-Gmail-Original-Message-ID: <CAK8P3a0X4UBE_q0mykor9fOqa4qFJHfAE61bgH_8_1GG6ih__g@mail.gmail.com>
Message-ID: <CAK8P3a0X4UBE_q0mykor9fOqa4qFJHfAE61bgH_8_1GG6ih__g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:X8kFLzryBpbh2nWdfRj5h+/1qG5+N7nbLw/cmfzzvQLHYnAls2Q
 d7j2+cIsRkKagtxMjLivXjhrxEVnGAoKGTQKqUFq+G50mobe0iGvLffdmhj3hkybOAPghmm
 Lh2GF1BIKZwDw/wNGEpCIeRB0yFG17cFYrb6KsIF1ApGmVsU0uah6DG3mQyZsPj7D+9/RRw
 emKlBwYnVM0VP/4+pIV4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WID3Qm7SKJs=:tBvWt3bGwwDfbxhLW4vA33
 6H3b6vNIHT2JSKV2JaTOUZVnQTXz0Sm2DNJEQXilnfpIIJLTS6DP/zoKvwT8Z+fSS5qU+oM1l
 NFW3uEFBOzMHMZxR+xsP7WHbHx2Z28CjzNb/SJd2xwedBKKPTRb9hzr0YFFm37KH9g1fr0zLQ
 aKS7hv5D5K0c7ai97gV2DFlUO67GhyPe+j1Otwol2BzzhccOrKuE2X2NFx+26n2ywYVx4BCl1
 vTazP0iloGeb8yETb+TFgmjd1g+gV7ktLsCtCoM8l8VZjxC90Ey5FOJMst/FfCPDzjyYzRugn
 L/UXiFtsmzJrRNhU1806BcPm1S6N/Rasgp5OwE0EkMlssqiDqhae/G1dxWrnZTEC6yZrCgSdz
 vPqHi7QzeBisD7v5SesyiLKl9/Koz8LPawRj5fGF/U+mLQN70UvQ4egH6Z8ADfBsmW3GC1NSw
 eIL9kg07vbhhnm36XELhbsj3dwIgZOrFPUb12Zd71pUiLorfaBThwJN5S9rplMDHMx5aZ1pGW
 RI3irOewibSRX3ppsaTaBNFptfw1BdsING7XVreaY/9A0AH/cIef6cs9Qt3I+AT7qL30bEEt0
 G2mApF7h8r9rcg0YMIjF6VxDtU/CogUP8p8DeRVtShEd1ZSTAqPNEC8y07RYz2jPlmc35/vUf
 dc+shbuMXmQvU6MDNNMPVSpAke/+uRoZPTopjR9M3hSFlaRM6bLuqqIyeP+ieguqs+XyawgZY
 TACRR32lKW2WFAr0d0jiV4eNuMZcMH5m2UNnuYcXPZb7GCLftJ3m/btRD9kDj7OsXFzOrfLyC
 YbqTl4P0yib0iKqfF0+TXP+0B2FbxasRtU9gm/O2cXY12WmjFIV9gYSMmNefmdKUFaO9+d9rV
 5hjjLXdrVkUG81St/LuQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:35 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-12-19, Sargun Dhillon <sargun@sargun.me> wrote:
> > On Thu, Dec 19, 2019 at 2:35 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > I guess this is the remaining question we should settle, i.e. what do we
> > > prefer.
> > > I still think that adding a new syscall for this seems a bit rich. On
> > > the other hand it seems that a lot more people agree that using a
> > > dedicated syscall instead of an ioctl is the correct way; especially
> > > when it touches core kernel functionality. I mean that was one of the
> > > takeaways from the pidfd API ioctl-vs-syscall discussion.
> > >
> > > A syscall is nicer especially for core-kernel code like this.
> > > So I guess the only way to find out is to try the syscall approach and
> > > either get yelled and switch to an ioctl() or have it accepted.
> > >
> > > What does everyone else think? Arnd, still in favor of a syscall I take
> > > it. Oleg, you had suggested a syscall too, right? Florian, any
> > > thoughts/worries on/about this from the glibc side?
> > >
> > > Christian
> >
> > My feelings towards this are that syscalls might pose a problem if we
> > ever want to extend this API. Of course we can have a reserved
> > "flags" field, and populate it later, but what if we turn out to need
> > a proper struct? I already know we're going to want to add one
> > around cgroup metadata (net_cls), and likely we'll want to add
> > a "steal" flag as well. As Arnd mentioned earlier, this is trivial to
> > fix in a traditional ioctl environment, as ioctls are "cheap". How
> > do we feel about potentially adding a pidfd_getfd2? Or are we
> > confident that reserved flags will save us?
>
> If we end up making this a syscall, then we can re-use the
> copy_struct_from_user() API to make it both extensible and compatible in
> both directions. I wasn't aware that this was frowned upon for ioctls
> (sorry for the extra work) but there are several syscalls which use this
> model for extendability (clone3, openat2, sched_setattr,
> perf_events_open) so there shouldn't be any such complaints for a
> syscall which is extensible.

I would still not do it for syscalls, although for other reasons:

- in an ioctl, it's better to come up with a new command code if you
  have a larger structure

- in a system call, it's best to pass all arguments as individual
  registers, the only time we use indirect data structures is when there
  are more than six arguments.

       Arnd
