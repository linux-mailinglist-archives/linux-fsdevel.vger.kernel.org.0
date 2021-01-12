Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA52F35EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhALQkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALQkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:40:51 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5AC061786;
        Tue, 12 Jan 2021 08:40:10 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r9so1920067qtp.11;
        Tue, 12 Jan 2021 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tg+bxwxNo/Um8JRhUpe87X7gabzraArYd7H7SJ5gVEs=;
        b=vUagv3BykIc4/mpJdTZ6LxDdn7zkfQXBXBtq+SHYpPZU9UMlFFEHlTAqi6DmzrLzHB
         BWDvy27J+KBE6njMIzpUtmDZBCUFocJc/FmNvegy3hs+R1Ap5aEzvOH03bnxX5Ip6FD8
         v5alNQ/x+fy1MHsQl50vdnGzXQobnIjZ9JsxR0LMiW/jDgT8Cl+w8pLgLhzYn9mHQsjv
         dAz8nP2RP+iqhPq/u5kA/W8RdablHIft0Nz0vPffSAINRAF7k8hD27mscYxJwEjUvSZY
         RhNd33gT3SYn+IfYjWAl5q6Lzj/0tjgP/7/Ulwi6dFJSTZu18C4ZmLA53ANKMtDkdXjZ
         WoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tg+bxwxNo/Um8JRhUpe87X7gabzraArYd7H7SJ5gVEs=;
        b=T0jhZekjMElhsMXkLikfspIyx8OjN306EC4mmdM5HaHRkeyRYMQ+N+tjCL641dOgxR
         k5VOE6fCmJ/SB00XFpzgcl1YmXNw4g9fD4QNcMSfhwMYWkzqlkD86b5CxLPhAQFDT5Is
         QnowC9ef5Mq6LvqwPrllJnBrZapEAadOcAyMGRsyXeTk1LKiFXllWieCuLYfuldJnEQU
         WNRslbhKGjkBZjdnlgp5ANOISoHh0NAi+oaKiVrgwCyTnWNDKAh/XeiqBNZrofWwwT29
         ezyEMKIA1yjvZstmi6u6foD0AgF59It/QcKpcA7J3NVXDv93jFNyOZsXKWvjD4omS8ZW
         0slg==
X-Gm-Message-State: AOAM531jjeOsnhNmZxyCnnOpAdvGjJ5iu3XcV6TAq3lEpT3yrkBX4FXc
        gnnyNs4UKyRgY/ZXQSslzr3tWOuC7pa5OmH0qrQ=
X-Google-Smtp-Source: ABdhPJwLwWGUuywFhJ0gHbWDTaMcurEjOm1pAJf1jyN6tRuf4+/9XqbUPG9xPHrs6LMvXljufxfqsz7bcZ/kvAEAbYk=
X-Received: by 2002:ac8:70c1:: with SMTP id g1mr5420212qtp.108.1610469610102;
 Tue, 12 Jan 2021 08:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
 <87turmibbs.fsf@oldenburg2.str.redhat.com> <CAKgNAkgCbx8OctQ1xQ4337K=QpARbVPhwroKD6XvbQi9GkOrcw@mail.gmail.com>
In-Reply-To: <CAKgNAkgCbx8OctQ1xQ4337K=QpARbVPhwroKD6XvbQi9GkOrcw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 12 Jan 2021 11:39:33 -0500
Message-ID: <CAF=yD-JekzFqnAOiUGDLHStfBd+nTKPSN1Y5yQuUYjje9jy=oQ@mail.gmail.com>
Subject: Re: [PATCH manpages] epoll_wait.2: add epoll_pwait2
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 8:05 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Florian,
>
> On Tue, 12 Jan 2021 at 13:33, Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Willem de Bruijn:
> >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Expand the epoll_wait page with epoll_pwait2, an epoll_wait variant
> > > that takes a struct timespec to enable nanosecond resolution timeout.
> > >
> > >     int epoll_pwait2(int fd, struct epoll_event *events,
> > >                      int maxevents,
> > >                      const struct timespec *timeout,
> > >                      const sigset_t *sigset);
> >
> > Does it really use struct timespec?  With 32-bit times on most 32-bit
> > targets?
>
> The type inside the kernel seems to be:
>
> [[
> SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
>                 int, maxevents, const struct __kernel_timespec __user
> *, timeout,
>
> struct __kernel_timespec {
>         __kernel_time64_t       tv_sec;                 /* seconds */
>         long long               tv_nsec;                /* nanoseconds */
> };
> ]]
>
> So, 64 bits by the look of things.

Yes. The C library is expected to define the function as shown here,
and internally call the syscall with __kernel_timespec.

This is similar to modern time64 variants of other timespec syscall,
such as ppoll.

For 64-bit archs like x86_64, ppoll maps onto sys_ppoll with native
__kernel_timespec.
For 32-bit archs like x86, the library is expected to call new
ppoll_time64 , with the same type.

On 32-bit archs, the existing ppoll maps onto a syscall that expects
the __old_timespec32. Legacy C libraries and direct callers will
continue to call this.

For the new epoll_pwait2 syscall we do not add this non-y2038
compliant version, as there is no need for backward compatibility with
legacy users.
