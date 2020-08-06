Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6576323D4C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHFAnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 20:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHFAnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:43:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E2C061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2020 17:43:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so42369326wrw.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqxrCBcebzwTBSlBbZQuXod3klRM9Vw/uQ+yD1TuH7k=;
        b=pOlNC5FY3C1j9IhvS3DZJb3ce7tSIc2UV2rOiD19AqeDsDU6X2ZtoTUxi0h30RYqEK
         gYmhMR6IVLr2uD47iFLfmwma8Ek3R5C3GGzB976sl8id8ELyIIW3wAyBWhhLyNLO+Wd+
         6SwPLjCD9e35MNeMm/FsFQ+2lesscQoPVJdGgjT+3sjNQGE/gmTFjE0nW5hwe4BASOeV
         L+DVV3e4ZyL0aJjl7Rc8/0BhWFHXQEu4ZyOIItROM2xfIt7uJ+EimpiVziSllgi8FQKX
         5wgoTsrhWUMIqK7EQND6bJdn1LIIWxZ8MPML/bzXGk8/lDZMI89Q3rrI5P/v7BPKKR+k
         DuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqxrCBcebzwTBSlBbZQuXod3klRM9Vw/uQ+yD1TuH7k=;
        b=XbiW+FaonCdNjqujDy5IRH5VqNAuHbdN0zToAWK4/zo2GznY/S2+gR12ZpRKW4bWYR
         ej8KGV5Utnyvoqhkh7sFQI0xSpEX3uCWWQmrtcFGrTHMqVaSbI6a9fszGyYnmpvNQnaq
         mTAH9vhs5gPObbqVD85Wvhq37c3wgZn57vc5CCG6dMLCOQ+TJYjODc5TVMhF9upgsTYm
         kR6rj6RKYnA4+L53QNb0piwgWm75F5wavK/WfMvmbfL75P0TUpTNmOPyxJAyjPJmKaMM
         gVGW7B7kJawo5Nc/0tdANiHobdZ3drHEXIOeUPBBBCCPz77S6RG6qA/qoc+XAMZc0rJL
         pEkQ==
X-Gm-Message-State: AOAM530HYc8/l+oHsPBueB5yNyC5ZXbUtf4Vr4mcXYhX90DXEVzBVktM
        WPVwj7Wr+p6tpDuBu0EDCmPAN0wPjjxLNrq9o6911w==
X-Google-Smtp-Source: ABdhPJzHi47nTFBCo846dKdF9YxlwujEkFvFwbOkqOtw0t5sK+Tcjgm9k2TxUTaYkaFADpMa0GvVP2txhNLBZIpAKuo=
X-Received: by 2002:a5d:5704:: with SMTP id a4mr4760122wrv.318.1596674594491;
 Wed, 05 Aug 2020 17:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com> <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com> <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com> <20200724093852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200724093852-mutt-send-email-mst@kernel.org>
From:   Nick Kralevich <nnk@google.com>
Date:   Wed, 5 Aug 2020 17:43:02 -0700
Message-ID: <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 6:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 23, 2020 at 05:13:28PM -0700, Nick Kralevich wrote:
> > On Thu, Jul 23, 2020 at 10:30 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > From the discussion so far it seems that there is a consensus that
> > > patch 1/2 in this series should be upstreamed in any case. Is there
> > > anything that is pending on that patch?
> >
> > That's my reading of this thread too.
> >
> > > > > Unless I'm mistaken that you can already enforce bit 1 of the second
> > > > > parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> > > > > would be more a question to the Android userland team.
> > > > >
> > > > > The question would be: does it ever happen that a seccomp filter isn't
> > > > > already applied to unprivileged software running without
> > > > > SYS_CAP_PTRACE capability?
> > > >
> > > > Yes.
> > > >
> > > > Android uses selinux as our primary sandboxing mechanism. We do use
> > > > seccomp on a few processes, but we have found that it has a
> > > > surprisingly high performance cost [1] on arm64 devices so turning it
> > > > on system wide is not a good option.
> > > >
> > > > [1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
> >
> > As Jeff mentioned, seccomp is used strategically on Android, but is
> > not applied to all processes. It's too expensive and impractical when
> > simpler implementations (such as this sysctl) can exist. It's also
> > significantly simpler to test a sysctl value for correctness as
> > opposed to a seccomp filter.
>
> Given that selinux is already used system-wide on Android, what is wrong
> with using selinux to control userfaultfd as opposed to seccomp?

Userfaultfd file descriptors will be generally controlled by SELinux.
You can see the patchset at
https://lore.kernel.org/lkml/20200401213903.182112-3-dancol@google.com/
(which is also referenced in the original commit message for this
patchset). However, the SELinux patchset doesn't include the ability
to control FAULT_FLAG_USER / UFFD_USER_MODE_ONLY directly.

SELinux already has the ability to control who gets CAP_SYS_PTRACE,
which combined with this patch, is largely equivalent to direct
UFFD_USER_MODE_ONLY checks. Additionally, with the SELinux patch
above, movement of userfaultfd file descriptors can be mediated by
SELinux, preventing one process from acquiring userfaultfd descriptors
of other processes unless allowed by security policy.

It's an interesting question whether finer-grain SELinux support for
controlling UFFD_USER_MODE_ONLY should be added. I can see some
advantages to implementing this. However, we don't need to decide that
now.

Kernel security checks generally break down into DAC (discretionary
access control) and MAC (mandatory access control) controls. Most
kernel security features check via both of these mechanisms. Security
attributes of the system should be settable without necessarily
relying on an LSM such as SELinux. This patch follows the same basic
model -- system wide control of a hardening feature is provided by the
unprivileged_userfaultfd_user_mode_only sysctl (DAC), and if needed,
SELinux support for this can also be implemented on top of the DAC
controls.

This DAC/MAC split has been successful in several other security
features. For example, the ability to map at page zero is controlled
in DAC via the mmap_min_addr sysctl [1], and via SELinux via the
mmap_zero access vector [2]. Similarly, access to the kernel ring
buffer is controlled both via DAC as the dmesg_restrict sysctl [3], as
well as the SELinux syslog_read [2] check. Indeed, the dmesg_restrict
sysctl is very similar to this patch -- it introduces a capability
(CAP_SYSLOG, CAP_SYS_PTRACE) check on access to a sensitive resource.

If we want to ensure that a security feature will be well tested and
vetted, it's important to not limit its use to LSMs only. This ensures
that kernel and application developers will always be able to test the
effects of a security feature, without relying on LSMs like SELinux.
It also ensures that all distributions can enable this security
mitigation should it be necessary for their unique environments,
without introducing an SELinux dependency. And this patch does not
preclude an SELinux implementation should it be necessary.

Even if we decide to implement fine-grain SELinux controls on
UFFD_USER_MODE_ONLY, we still need this patch. We shouldn't make this
an either/or choice between SELinux and this patch. Both are
necessary.

-- Nick

[1] https://wiki.debian.org/mmap_min_addr
[2] https://selinuxproject.org/page/NB_ObjectClassesPermissions
[3] https://www.kernel.org/doc/Documentation/sysctl/kernel.txt

>
>
> > > > >
> > > > >
> > > > > If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> > > > > subject) should be enforceable with minor changes to the BPF
> > > > > assembly. Otherwise it'd require more changes.
> >
> > It would be good to understand what these changes are.
> >
> > > > > Why exactly is it preferable to enlarge the surface of attack of the
> > > > > kernel and take the risk there is a real bug in userfaultfd code (not
> > > > > just a facilitation of exploiting some other kernel bug) that leads to
> > > > > a privilege escalation, when you still break 99% of userfaultfd users,
> > > > > if you set with option "2"?
> >
> > I can see your point if you think about the feature as a whole.
> > However, distributions (such as Android) have specialized knowledge of
> > their security environments, and may not want to support the typical
> > usages of userfaultfd. For such distributions, providing a mechanism
> > to prevent userfaultfd from being useful as an exploit primitive,
> > while still allowing the very limited use of userfaultfd for userspace
> > faults only, is desirable. Distributions shouldn't be forced into
> > supporting 100% of the use cases envisioned by userfaultfd when their
> > needs may be more specialized, and this sysctl knob empowers
> > distributions to make this choice for themselves.
> >
> > > > > Is the system owner really going to purely run on his systems CRIU
> > > > > postcopy live migration (which already runs with CAP_SYS_PTRACE) and
> > > > > nothing else that could break?
> >
> > This is a great example of a capability which a distribution may not
> > want to support, due to distribution specific security policies.
> >
> > > > >
> > > > > Option "2" to me looks with a single possible user, and incidentally
> > > > > this single user can already enforce model "2" by only tweaking its
> > > > > seccomp-bpf filters without applying 2/2. It'd be a bug if android
> > > > > apps runs unprotected by seccomp regardless of 2/2.
> >
> > Can you elaborate on what bug is present by processes being
> > unprotected by seccomp?
> >
> > Seccomp cannot be universally applied on Android due to previously
> > mentioned performance concerns. Seccomp is used in Android primarily
> > as a tool to enforce the list of allowed syscalls, so that such
> > syscalls can be audited before being included as part of the Android
> > API.
> >
> > -- Nick
> >
> > --
> > Nick Kralevich | nnk@google.com
>


-- 
Nick Kralevich | nnk@google.com
