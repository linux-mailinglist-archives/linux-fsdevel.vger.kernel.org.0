Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA30A2F307F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhALNG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 08:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbhALNGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:06:25 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07462C061575;
        Tue, 12 Jan 2021 05:05:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id x13so2243567oic.5;
        Tue, 12 Jan 2021 05:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jG7yC7dRyy6dt72lUFM/3t9zBGIIKAjh3jwa8hEtR3E=;
        b=GPdyYrrVW+PrgmgwgfR158+Bgk8DZP5VSqv/XJ8rrzZ75iShU5Or2o9NOyxTaopod/
         dl2OjLdvPbOSN0EDdL5ISCDv7y8hcU5TOkKzYprpXpkFQFaaraLqxPkef5IvNoYU/2Rj
         HN3lG9JJEe8tNOi4reu2juJcfpFU7+vH9I3wEFLbMt84X+T6lINlP9uelUZd6Hnlxbiw
         aTBBIgvnawJyzgx5dnV7qyGVU3IL7o92PRsiY8oaQC/u9CYP5LKk/BjISRFRnE0oksSl
         daB5tfDYAMzb+HQmpLwQEtR3FC7QZDgtDY15LIcKGKd9TTiMizS4wOkE4+uso0gV6hEU
         RAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jG7yC7dRyy6dt72lUFM/3t9zBGIIKAjh3jwa8hEtR3E=;
        b=mG3Q+xp/aeYfQYoMVPL4nFFLPfjF/pDW55tEkUo4Asd8KKLFfRSwm8Meqwi0CLbTN6
         Dy8H7BpKESL2byP/++2oRhF9hcIPYlhpfghcHYZilnVefHga3K2b07xmnYc4Yh5m0Swm
         HhcRLAHWOAyKVG3hzkIpKdHIv0k5Xk45MMD68beu7X3Z4VG1ymG5smEvpZtw3fGEWr4G
         uUIUIzevvA866+9KRK3Moi7gdWwKiU4/7YPlbWGaYn+klOO+eUzL7JJNZZq1gUJ6ewYQ
         DPTz4jrWZy5rDrlkXcmMLI5AZVMPpwY9zZgdvc7+baaG7JDqM85RUDlsbI4/TCr/Ft27
         HYzw==
X-Gm-Message-State: AOAM531OSlS7ON1pepQzWmc/aQGqnj5FVV3bdMkfqFCobhUVmdRBqrk0
        zXFEoXhHFL52NlqTQTRNqeq4K9YI0alS3SiDKra2a4VOl1o=
X-Google-Smtp-Source: ABdhPJytDeAF7tlHnNqgLlew0bBzronuC2rEP0oAL4QlbNewPwYZhLHTEi4EpK9zVDm/sGBrD38ULz92BbaXPDiCE/c=
X-Received: by 2002:aca:ded4:: with SMTP id v203mr2225247oig.148.1610456744446;
 Tue, 12 Jan 2021 05:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com> <87turmibbs.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87turmibbs.fsf@oldenburg2.str.redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 12 Jan 2021 14:05:33 +0100
Message-ID: <CAKgNAkgCbx8OctQ1xQ4337K=QpARbVPhwroKD6XvbQi9GkOrcw@mail.gmail.com>
Subject: Re: [PATCH manpages] epoll_wait.2: add epoll_pwait2
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Florian,

On Tue, 12 Jan 2021 at 13:33, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Willem de Bruijn:
>
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Expand the epoll_wait page with epoll_pwait2, an epoll_wait variant
> > that takes a struct timespec to enable nanosecond resolution timeout.
> >
> >     int epoll_pwait2(int fd, struct epoll_event *events,
> >                      int maxevents,
> >                      const struct timespec *timeout,
> >                      const sigset_t *sigset);
>
> Does it really use struct timespec?  With 32-bit times on most 32-bit
> targets?

The type inside the kernel seems to be:

[[
SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
                int, maxevents, const struct __kernel_timespec __user
*, timeout,

struct __kernel_timespec {
        __kernel_time64_t       tv_sec;                 /* seconds */
        long long               tv_nsec;                /* nanoseconds */
};
]]

So, 64 bits by the look of things.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
