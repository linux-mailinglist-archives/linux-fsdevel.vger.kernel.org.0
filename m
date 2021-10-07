Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F61424BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhJGCwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhJGCwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:52:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80305C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 19:50:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id w10so9986469ybt.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F/VUUoX5d9pLuj9va8DmcDC9EaYJA0ZhNF6WOHt3n8=;
        b=W4z+Ot2/rwfvUtqGOA0HqHFoPN/g2j2f12GEa+aPzxsQqWMDUSbzhdbl4QKDrE5ZEH
         uCF7VIMSREr8EXiPVqrejCQbJSVyY2YfWGFwWBoIrfj/BB6LCd9F9DVskFMoD9Ak5lyQ
         7OGOEDa1y4GOfsuzJV8OjddHLK7I2zWWrZ6LX9yavhM0d79aOGcrKB69ETdcrtkCp+vL
         eTLjv/V9P4VkKOZxo4oydFSm52hqgupfnZYFj3X3H0XUZw+yNpoBAiqlCXntoBX7AveU
         1ea1Tcel5OGxJeCtTyf8suXBuuZ9WvU7NB51pCaeC8wreksJH3D5S8qvwFjnytkmgNbt
         zkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F/VUUoX5d9pLuj9va8DmcDC9EaYJA0ZhNF6WOHt3n8=;
        b=0pOTA9NoCubu5X0RVR7yZEF6TxXUV46zkEAyXNJ5PozRxAL+ExHeAt9kD0qEAa5OXN
         Ea7unrmIYnu5+lEs+beo7ALeIZBEC5oMSFrY+Xo9hVt/3wzle4OjIdaVkOSeYbuJiWVd
         TXboKdKOtctrTjevVkCm63ZLylU9DgGzD5YO6lrLrIr+9Zu3iCkKiMQpyvD8LalYySkh
         aDYmhhtAKI6pdV36s+B7ADBHpyCCk9qAK6Bvcq9goCWAVMERk9Ps5HndykSzinUY7bMX
         2oQUvgaG/LH6HM4NCkMLkGIzEgvDf3jW7rsI7zm5w5xbJHoEUWS+hWOlAOQK7H4NRz+M
         8FEg==
X-Gm-Message-State: AOAM533kYmWBVN9MLCadr+cB8W2xhuvGLWF+vvopCrQAMFyO9Up4UwWt
        O+1oFJVHLeJbT03H9wKZ9jXVFB7r0w9srctxVHYiJg==
X-Google-Smtp-Source: ABdhPJwURhBGwIa2Mo2zsN2z5+HcTIt/J+M1PIauJMogSr896kv94sWKf2q7mONzOcq02flzV/NuzQLkoCDX8/08/9U=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr2185756ybu.161.1633575049472;
 Wed, 06 Oct 2021 19:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-2-surenb@google.com>
 <20211001160830.700c36b32b736478000b3420@linux-foundation.org>
 <CAJuCfpGpMru4z=ZMezRQW56tHNjrWHU3jWhG3qzuXvuUytq-3w@mail.gmail.com>
 <CAJuCfpFWUXQ445VcqTcV1kNY3AWX=wB5iaeDAX_=+xZefjTUjg@mail.gmail.com> <20211006193940.c261f21fcd14b4b52aae1fbc@linux-foundation.org>
In-Reply-To: <20211006193940.c261f21fcd14b4b52aae1fbc@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 6 Oct 2021 19:50:38 -0700
Message-ID: <CAJuCfpGMKPmVx8ADwFOyRPYfYKCuOHCUzr2o-vq0GZGSVj20Dw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] mm: add a field to store names for private
 anonymous memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 7:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 4 Oct 2021 09:21:42 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > > The name pointers are not shared between vmas even if they contain the
> > > > > same name. The name pointer is stored in a union with fields that are
> > > > > only used on file-backed mappings, so it does not increase memory usage.
> > > > >
> > > > > The patch is based on the original patch developed by Colin Cross, more
> > > > > specifically on its latest version [1] posted upstream by Sumit Semwal.
> > > > > It used a userspace pointer to store vma names. In that design, name
> > > > > pointers could be shared between vmas. However during the last upstreaming
> > > > > attempt, Kees Cook raised concerns [2] about this approach and suggested
> > > > > to copy the name into kernel memory space, perform validity checks [3]
> > > > > and store as a string referenced from vm_area_struct.
> > > > > One big concern is about fork() performance which would need to strdup
> > > > > anonymous vma names. Dave Hansen suggested experimenting with worst-case
> > > > > scenario of forking a process with 64k vmas having longest possible names
> > > > > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > > > > worst-case regression of almost 40% when forking such a process. This
> > > > > regression is addressed in the followup patch which replaces the pointer
> > > > > to a name with a refcounted structure that allows sharing the name pointer
> > > > > between vmas of the same name. Instead of duplicating the string during
> > > > > fork() or when splitting a vma it increments the refcount.
> > > >
> > > > Generally, the patch adds a bunch of code which a lot of users won't
> > > > want.  Did we bust a gut to reduce this impact?  Was a standalone
> > > > config setting considered?
> > >
> > > I didn't consider a standalone config for this feature because when
> > > not used it has no memory impact at runtime. As for the image size, I
> > > built Linus' ToT with and without this patchset with allmodconfig and
>
> allnoconfig would be more interesting.  People who want small kernels
> won't be using allmodconfig!

Sure, I will check that and report back.

>
> > > the sizes are:
> > > Without the patchset:
> > > $ size vmlinux
> > >    text    data     bss     dec     hex filename
> > > 40763556 58424519 29016228 128204303 7a43e0f vmlinux
> > >
> > > With the patchset:
> > > $ size vmlinux
> > >    text    data     bss     dec     hex filename
> > > 40765068 58424671 29016228 128205967 7a4448f vmlinux
> > >
> > > The increase seems quite small, so I'm not sure if it warrants a
> > > separate config option.
> >
> > Andrew, do you still think we need a separate CONFIG option? I fixed
> > the build issue when CONFIG_ADVISE_SYSCALLS=n and would like to post
> > the update but if you want to have a separate config then I can post
> > that together with the fix. Please let me know.
>
> I don't see much downside to the standalone option.  More complexity
> for developers/testers, I guess.  But such is life?

Sounds good to me. I will post a new version with a separate config if
we get over the objections of using numbers instead of strings.
Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
