Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2C22BAD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGXANu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgGXANt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:13:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83DC0619D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 17:13:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so6761889wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6x/hJOAHY4ipAqr2hJOXVMYMMf3KgJBBZ1yOdjcCvI=;
        b=l8gmwJumnfBAOwcf7hDnzKOckke+7FJJ1NS9zYl0CO+6Pru0aHNLw4HL2QDUsBgdhH
         axu8m6MrxU5VdYN4oAGIZdtsMVu8j6flA574tZoNh4po7WcTh6q1rieHBqKlRltKdbCD
         mRmuZwZL83CaZlupM/YSFfxgvx1txVJARFTLHaQrldSKkiDAJ/spYh49b9M+3RwKvWub
         /2DNZhf6sGQMubLVZWjTR5dSCHcOiP8VDJL948DebpH1wfKg/YflimMDf8rSPcikR7M9
         4/pQ1OEAAbhLbUCW9li1IIdxp2v+wVu52E/H3p9jXWs7jm42G4MKPbBYCWb276JbC5f9
         XzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6x/hJOAHY4ipAqr2hJOXVMYMMf3KgJBBZ1yOdjcCvI=;
        b=G9CD6HcjEPjjSNCSPtc9N7Uyyv8btrnHwMHrWVKNKnmdQt7ZG9R6t9RFxeovmjztsj
         Ua/KmhpeXSL0DOVkmFCHo42SvypYISGXM+wxxMvSqtLgd49/pslqh6eIc7bi9tOMzWQr
         08+rFaKn8eW43tCNFYA6a8rSZIbK/ODOMU3up4ARBSYDLazJIAighKnKlbcp6/9DcH/l
         sKmQxGksv6NB0hbHsvXIHByprGwKsLL9+4ruiQyvlYpd25jMQP52rfkzkja6CNjCfiGd
         xOV57YsF6zNqCYbDyBRQvO3zjYFzHPhRF9zO4AazYahW6Z0oqGtXdxD05SrQXkfCrtAg
         McPw==
X-Gm-Message-State: AOAM530dyPhXc04FjF0gcOjvFWz/aNSQJ3vOuxeLOQi2Ij/zwqFVXLUz
        6TsfS5i6LJq3rR3QNCRHX0E3WRsuHDLP0F+NYbzU1A==
X-Google-Smtp-Source: ABdhPJxL5Y1BrfDtq2upmNHI5yCi1q/zfAI4WwmzzlYEyc+rDsh6CrhBn6+3cgw1FRPldkigKYwPi5ct9CVXTswVgMc=
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr6637550wrw.213.1595549625931;
 Thu, 23 Jul 2020 17:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org> <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com> <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com> <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com> <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
In-Reply-To: <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
From:   Nick Kralevich <nnk@google.com>
Date:   Thu, 23 Jul 2020 17:13:28 -0700
Message-ID: <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Colascione <dancol@google.com>,
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

On Thu, Jul 23, 2020 at 10:30 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> From the discussion so far it seems that there is a consensus that
> patch 1/2 in this series should be upstreamed in any case. Is there
> anything that is pending on that patch?

That's my reading of this thread too.

> > > Unless I'm mistaken that you can already enforce bit 1 of the second
> > > parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> > > would be more a question to the Android userland team.
> > >
> > > The question would be: does it ever happen that a seccomp filter isn't
> > > already applied to unprivileged software running without
> > > SYS_CAP_PTRACE capability?
> >
> > Yes.
> >
> > Android uses selinux as our primary sandboxing mechanism. We do use
> > seccomp on a few processes, but we have found that it has a
> > surprisingly high performance cost [1] on arm64 devices so turning it
> > on system wide is not a good option.
> >
> > [1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad

As Jeff mentioned, seccomp is used strategically on Android, but is
not applied to all processes. It's too expensive and impractical when
simpler implementations (such as this sysctl) can exist. It's also
significantly simpler to test a sysctl value for correctness as
opposed to a seccomp filter.

> > >
> > >
> > > If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> > > subject) should be enforceable with minor changes to the BPF
> > > assembly. Otherwise it'd require more changes.

It would be good to understand what these changes are.

> > > Why exactly is it preferable to enlarge the surface of attack of the
> > > kernel and take the risk there is a real bug in userfaultfd code (not
> > > just a facilitation of exploiting some other kernel bug) that leads to
> > > a privilege escalation, when you still break 99% of userfaultfd users,
> > > if you set with option "2"?

I can see your point if you think about the feature as a whole.
However, distributions (such as Android) have specialized knowledge of
their security environments, and may not want to support the typical
usages of userfaultfd. For such distributions, providing a mechanism
to prevent userfaultfd from being useful as an exploit primitive,
while still allowing the very limited use of userfaultfd for userspace
faults only, is desirable. Distributions shouldn't be forced into
supporting 100% of the use cases envisioned by userfaultfd when their
needs may be more specialized, and this sysctl knob empowers
distributions to make this choice for themselves.

> > > Is the system owner really going to purely run on his systems CRIU
> > > postcopy live migration (which already runs with CAP_SYS_PTRACE) and
> > > nothing else that could break?

This is a great example of a capability which a distribution may not
want to support, due to distribution specific security policies.

> > >
> > > Option "2" to me looks with a single possible user, and incidentally
> > > this single user can already enforce model "2" by only tweaking its
> > > seccomp-bpf filters without applying 2/2. It'd be a bug if android
> > > apps runs unprotected by seccomp regardless of 2/2.

Can you elaborate on what bug is present by processes being
unprotected by seccomp?

Seccomp cannot be universally applied on Android due to previously
mentioned performance concerns. Seccomp is used in Android primarily
as a tool to enforce the list of allowed syscalls, so that such
syscalls can be audited before being included as part of the Android
API.

-- Nick

-- 
Nick Kralevich | nnk@google.com
