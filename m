Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBD8227DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGUK7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGUK7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:59:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C9C061794;
        Tue, 21 Jul 2020 03:59:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h13so14742116otr.0;
        Tue, 21 Jul 2020 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/EF7Qison7+OGXQXe8tCTGM4PP/e4Mdg4NPhl6XK730=;
        b=Uk4f9jfGhs5DkBWkywVYSxv+RjvPtlBJKwNzxDQJRM4oyUlZeJHH9Ay0Dz9S3T+O86
         I1k8wcSU5qjlnQbQS1Cc5u/Di5a8oxU0TqNANIeZ+urK3ruLtTD1rFzoDtPyUq0zyw1t
         TKTa7dYj3q558MX8C2dCAhl0Kx3BnS6PKK14W3du9GA95iORa8+JZDbW/DQ6a9DT5Fmy
         8za6hMaHY5YNv55f0k+a+Ti8u5YKEfdRVS6vRWc0m6bcU1eZA57gEbg14Y3/HWJqEceg
         I6AApXJum8MPc7FIX+9Iv2OU5g/1PXoIJOC9VdOjehdpKQ5Gaotz84w3/VSWkS/6Omc3
         Mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/EF7Qison7+OGXQXe8tCTGM4PP/e4Mdg4NPhl6XK730=;
        b=U0J4n6LqDPliXbop2taAxI2/hRXvE/q8gjt4Ao78OJkxKolEdR14ZuirKHtQyMl3at
         bP/yU+GYiomDb4cmPeww1CRjhAnXky3ZwbdG8tQqvbBN3a0QWlvrwCPY6juaaSmLQjmk
         QV1RQUuxwFvH9/kldYisCOcsQ3uuaN7TX2JD/5mrz3IKZJ67hnKLLKINOUJRIekWoTcl
         BNg7y3p/h+lGtvjIHFQEM53emsLf4aAkihNZxBBsUqP1Lp4Gde5ek5aeYCDYrfPmEFV0
         REUqhb+je2R3IaOMNhS2Yvp4uGIomIKeJXZQpwaR0aaFT01Kw2aXRzWbRxGjAa57cCwe
         sXaQ==
X-Gm-Message-State: AOAM533kpAbfiB3/fRn4/mWvD67UX4m1W5FVIfmww+T/1P1ukJnhvypA
        T2XLuN9JypBewCTmF6PggNwoUvYX7fPtDPzKpeI=
X-Google-Smtp-Source: ABdhPJwDn1K9lCXh3r6H2duEArkbw7P69YNYfj8OXMApUjXADa+z15C6AlqxraRlKJPBGg9bBd1HTcPmXTNgIEWHZIw=
X-Received: by 2002:a05:6830:2081:: with SMTP id y1mr23521903otq.114.1595329173244;
 Tue, 21 Jul 2020 03:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
In-Reply-To: <20200720092435.17469-4-rppt@kernel.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 21 Jul 2020 12:59:22 +0200
Message-ID: <CAKgNAkgdOZXsVVkYveqnjODOr_cHYWiRssw2Tu1dZEBd+GnOnA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

On Mon, 20 Jul 2020 at 11:26, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call

Without wanting to start a bikeshed discussion, the more common
convention in recently added system calls is to use an underscore in
names that consist of multiple clearly distinct words. See many
examples in  https://man7.org/linux/man-pages/man2/syscalls.2.html.

Thus, I'd suggest at least secret_memfd().

Also, I wonder whether memfd_secret() might not be even better.
There's plenty of precedent for the naming style where related APIs
share a common prefix [1].

Thanks,

Michael

[1] Some examples:

       epoll_create(2)
       epoll_create1(2)
       epoll_ctl(2)
       epoll_pwait(2)
       epoll_wait(2)

       mq_getsetattr(2)
       mq_notify(2)
       mq_open(2)
       mq_timedreceive(2)
       mq_timedsend(2)
       mq_unlink(2)

       sched_get_affinity(2)
       sched_get_priority_max(2)
       sched_get_priority_min(2)
       sched_getaffinity(2)
       sched_getattr(2)
       sched_getparam(2)
       sched_getscheduler(2)
       sched_rr_get_interval(2)
       sched_set_affinity(2)
       sched_setaffinity(2)
       sched_setattr(2)
       sched_setparam(2)
       sched_setscheduler(2)
       sched_yield(2)

       timer_create(2)
       timer_delete(2)
       timer_getoverrun(2)
       timer_gettime(2)
       timer_settime(2)

       timerfd_create(2)
       timerfd_gettime(2)
       timerfd_settime(2)




-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
