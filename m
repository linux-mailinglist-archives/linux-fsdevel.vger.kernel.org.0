Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25831247A2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgHQWLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgHQWL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:29 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB1C061342
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 15:11:28 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s189so19266694iod.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2tREdSh21Iyn6r0BayW1rlUc24M2xAB6JGj1Q/yEJOs=;
        b=Jmac+Jdu6CNOqZau1ltTM5nvHI5mWcU9B7UeZu+aPGa0aBCL3YLZDKsu8sh07S1Sun
         J0N8UQ0QMfghLdToAbmo8jUiCiqEtbyYUcO9BrZEF7bjRqiP7AgjKz1Z7sf7Tor/aoJv
         k96jBhA38Yqnu1gYkzso3NW7/mj9yvMN460rtw+LEHwJzVwqd9k5/jl6giWJYsN1iVQ8
         Hv92+xZY7oVEhqG7F24kTrWbkXwaTMOHU2SkK5JPuYzcQQ6kITngfyGIvelpXRYDJCFb
         4B42k5lL6RTW8M6Wj3Lsw/3LfM5wLBWgj15JhgdKbTx+vP9RqvBsNC8oOXRWunqi4aYP
         tTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2tREdSh21Iyn6r0BayW1rlUc24M2xAB6JGj1Q/yEJOs=;
        b=OlHPQQhcjAEw8re6pehJ2D6actzucKhgOFisYUk6r/8PpnTUH0y+XIh306zkYMo6K5
         vcTusWFdFrbR+iI8gS4s8EOKr9IjnoKsuMx0MJWKtyGcduIBV424d3JSiTErRZ0WthEL
         gWFehJkc8QOBINUPGUpAIxTmhszvbBhzof5gT0IOnySACY8bPoKeaX1+1i9K3RS9cNQI
         LuVeRDYu8RVzWJPkajPnMcXdDlU+PgxWHhsg3poKurrrpa3tskshoSQYUnl7MBmNWa8j
         Rb8q4knv7pk6xu+qPsRNv628veNEEKVxFFHw3a6jbmt+8D/Kld83TZGwB79lKqyippwP
         OHUw==
X-Gm-Message-State: AOAM533QTRfD4yhPJ35t66601wmUT6/Z0VCwl7uH5Zp7eIWH87t/4Eec
        1dVxSlwTnW5dEBAEQn4h0ep9UE+yrXpKmAKcc/B0+Q==
X-Google-Smtp-Source: ABdhPJxxEB9f4oAmKzMSwxRPufbX+0IanIwmFvsSFwrSlG6HlL/0w5iEJiRcWqY/gZQB4lr4mlwmqLo6Pq53OL0I2fE=
X-Received: by 2002:a05:6638:138a:: with SMTP id w10mr16083796jad.36.1597702287823;
 Mon, 17 Aug 2020 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <202005200921.2BD5A0ADD@keescook> <20200520194804.GJ26186@redhat.com>
 <20200520195134.GK26186@redhat.com> <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
 <20200724093852-mutt-send-email-mst@kernel.org> <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
 <20200806004351-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200806004351-mutt-send-email-mst@kernel.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 17 Aug 2020 15:11:16 -0700
Message-ID: <CA+EESO6bxhKf5123feNX1LZyyN2QL4Ti5ApPAu=xb3pHXd7cwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 05, 2020 at 05:43:02PM -0700, Nick Kralevich wrote:
> > On Fri, Jul 24, 2020 at 6:40 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Thu, Jul 23, 2020 at 05:13:28PM -0700, Nick Kralevich wrote:
> > > > On Thu, Jul 23, 2020 at 10:30 AM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
> > > > > From the discussion so far it seems that there is a consensus tha=
t
> > > > > patch 1/2 in this series should be upstreamed in any case. Is the=
re
> > > > > anything that is pending on that patch?
> > > >
> > > > That's my reading of this thread too.
> > > >
> > > > > > > Unless I'm mistaken that you can already enforce bit 1 of the=
 second
> > > > > > > parameter of the userfaultfd syscall to be set with seccomp-b=
pf, this
> > > > > > > would be more a question to the Android userland team.
> > > > > > >
> > > > > > > The question would be: does it ever happen that a seccomp fil=
ter isn't
> > > > > > > already applied to unprivileged software running without
> > > > > > > SYS_CAP_PTRACE capability?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > Android uses selinux as our primary sandboxing mechanism. We do=
 use
> > > > > > seccomp on a few processes, but we have found that it has a
> > > > > > surprisingly high performance cost [1] on arm64 devices so turn=
ing it
> > > > > > on system wide is not a good option.
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-security-module/202006011116.=
3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
> > > >
> > > > As Jeff mentioned, seccomp is used strategically on Android, but is
> > > > not applied to all processes. It's too expensive and impractical wh=
en
> > > > simpler implementations (such as this sysctl) can exist. It's also
> > > > significantly simpler to test a sysctl value for correctness as
> > > > opposed to a seccomp filter.
> > >
> > > Given that selinux is already used system-wide on Android, what is wr=
ong
> > > with using selinux to control userfaultfd as opposed to seccomp?
> >
> > Userfaultfd file descriptors will be generally controlled by SELinux.
> > You can see the patchset at
> > https://lore.kernel.org/lkml/20200401213903.182112-3-dancol@google.com/
> > (which is also referenced in the original commit message for this
> > patchset). However, the SELinux patchset doesn't include the ability
> > to control FAULT_FLAG_USER / UFFD_USER_MODE_ONLY directly.
> >
> > SELinux already has the ability to control who gets CAP_SYS_PTRACE,
> > which combined with this patch, is largely equivalent to direct
> > UFFD_USER_MODE_ONLY checks. Additionally, with the SELinux patch
> > above, movement of userfaultfd file descriptors can be mediated by
> > SELinux, preventing one process from acquiring userfaultfd descriptors
> > of other processes unless allowed by security policy.
> >
> > It's an interesting question whether finer-grain SELinux support for
> > controlling UFFD_USER_MODE_ONLY should be added. I can see some
> > advantages to implementing this. However, we don't need to decide that
> > now.
> >
> > Kernel security checks generally break down into DAC (discretionary
> > access control) and MAC (mandatory access control) controls. Most
> > kernel security features check via both of these mechanisms. Security
> > attributes of the system should be settable without necessarily
> > relying on an LSM such as SELinux. This patch follows the same basic
> > model -- system wide control of a hardening feature is provided by the
> > unprivileged_userfaultfd_user_mode_only sysctl (DAC), and if needed,
> > SELinux support for this can also be implemented on top of the DAC
> > controls.
> >
> > This DAC/MAC split has been successful in several other security
> > features. For example, the ability to map at page zero is controlled
> > in DAC via the mmap_min_addr sysctl [1], and via SELinux via the
> > mmap_zero access vector [2]. Similarly, access to the kernel ring
> > buffer is controlled both via DAC as the dmesg_restrict sysctl [3], as
> > well as the SELinux syslog_read [2] check. Indeed, the dmesg_restrict
> > sysctl is very similar to this patch -- it introduces a capability
> > (CAP_SYSLOG, CAP_SYS_PTRACE) check on access to a sensitive resource.
> >
> > If we want to ensure that a security feature will be well tested and
> > vetted, it's important to not limit its use to LSMs only. This ensures
> > that kernel and application developers will always be able to test the
> > effects of a security feature, without relying on LSMs like SELinux.
> > It also ensures that all distributions can enable this security
> > mitigation should it be necessary for their unique environments,
> > without introducing an SELinux dependency. And this patch does not
> > preclude an SELinux implementation should it be necessary.
> >
> > Even if we decide to implement fine-grain SELinux controls on
> > UFFD_USER_MODE_ONLY, we still need this patch. We shouldn't make this
> > an either/or choice between SELinux and this patch. Both are
> > necessary.
> >
> > -- Nick
> >
> > [1] https://wiki.debian.org/mmap_min_addr
> > [2] https://selinuxproject.org/page/NB_ObjectClassesPermissions
> > [3] https://www.kernel.org/doc/Documentation/sysctl/kernel.txt
>
> I am not sure I agree this is similar to dmesg access.
>
> The reason I say it is this: it is pretty easy for admins to know
> whether they run something that needs to access the kernel ring buffer.
> Or if it's a tool developer poking at dmesg, they can tell admins "we
> need these permissions".  But it seems impossible for either an admin to
> know that a userfaultfd page e.g. used with shared memory is accessed
> from the kernel.
>
> So I guess the question is: how does anyone not running Android
> know to set this flag?
>
> I got the feeling it's not really possible, and so for a single-user
> feature like this a single API seems enough.  Given a choice between a
> knob an admin is supposed to set and selinux policy written by
> presumably knowledgeable OS vendors, I'd opt for a second option.
>
> Hope this helps.
>
There has been an emphasis that Android is probably the only user for
the restriction of userfaults from kernel-space and that it wouldn=E2=80=99=
t
be useful anywhere else. I humbly disagree! There are various areas
where the PROT_NONE+SIGSEGV trick is (and can be) used in a purely
user-space setting. Basically, any lazy, on-demand,
initialization/decompression/loading could be a good candidate for
this trick. My project happens to be one of them. In fact, in Android
we are also thinking of using it in some other places, all in
user-space. And given that userfaultfd is an efficient replacement for
this trick [1], there are various scenarios which would benefit from
the restriction of userfaults from kernel-space, provided the admins
care about security on such devices. IIUC, a security admin would
never trust an unprivileged process with userfaults from kernel space.
Therefore, a sysctl knob restriction with CAP_SYS_PTRACE for
privileged processes seems like the right choice to me.

Coming to sysctl vs. SELinux debate, I think wherever the role of OS
vendor and admin is played by different people, I doubt a generic
SELinux policy set by the former will be blindly acceptable to the
latter. Furthermore, I=E2=80=99m not sure if an admin is expected to even k=
now
which packages running on their system are using userfaultfd. So they
anyway have to rely on developers reaching out to get the required
permission. With the new sysctl knob enabled, the number of such
requests is only going to decrease.

[1] https://www.kernel.org/doc/Documentation/vm/userfaultfd.txt

> > >
> > >
> > > > > > >
> > > > > > >
> > > > > > > If answer is "no" the behavior of the new sysctl in patch 2/2=
 (in
> > > > > > > subject) should be enforceable with minor changes to the BPF
> > > > > > > assembly. Otherwise it'd require more changes.
> > > >
> > > > It would be good to understand what these changes are.
> > > >
> > > > > > > Why exactly is it preferable to enlarge the surface of attack=
 of the
> > > > > > > kernel and take the risk there is a real bug in userfaultfd c=
ode (not
> > > > > > > just a facilitation of exploiting some other kernel bug) that=
 leads to
> > > > > > > a privilege escalation, when you still break 99% of userfault=
fd users,
> > > > > > > if you set with option "2"?
> > > >
> > > > I can see your point if you think about the feature as a whole.
> > > > However, distributions (such as Android) have specialized knowledge=
 of
> > > > their security environments, and may not want to support the typica=
l
> > > > usages of userfaultfd. For such distributions, providing a mechanis=
m
> > > > to prevent userfaultfd from being useful as an exploit primitive,
> > > > while still allowing the very limited use of userfaultfd for usersp=
ace
> > > > faults only, is desirable. Distributions shouldn't be forced into
> > > > supporting 100% of the use cases envisioned by userfaultfd when the=
ir
> > > > needs may be more specialized, and this sysctl knob empowers
> > > > distributions to make this choice for themselves.
> > > >
> > > > > > > Is the system owner really going to purely run on his systems=
 CRIU
> > > > > > > postcopy live migration (which already runs with CAP_SYS_PTRA=
CE) and
> > > > > > > nothing else that could break?
> > > >
> > > > This is a great example of a capability which a distribution may no=
t
> > > > want to support, due to distribution specific security policies.
> > > >
> > > > > > >
> > > > > > > Option "2" to me looks with a single possible user, and incid=
entally
> > > > > > > this single user can already enforce model "2" by only tweaki=
ng its
> > > > > > > seccomp-bpf filters without applying 2/2. It'd be a bug if an=
droid
> > > > > > > apps runs unprotected by seccomp regardless of 2/2.
> > > >
> > > > Can you elaborate on what bug is present by processes being
> > > > unprotected by seccomp?
> > > >
> > > > Seccomp cannot be universally applied on Android due to previously
> > > > mentioned performance concerns. Seccomp is used in Android primaril=
y
> > > > as a tool to enforce the list of allowed syscalls, so that such
> > > > syscalls can be audited before being included as part of the Androi=
d
> > > > API.
> > > >
> > > > -- Nick
> > > >
> > > > --
> > > > Nick Kralevich | nnk@google.com
> > >
> >
> >
> > --
> > Nick Kralevich | nnk@google.com
>
