Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FCC42F81F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhJOQcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbhJOQc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:32:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4001C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 09:30:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t127so3420564ybf.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kz5lMVwvOCVrmogtVEWpwErQFfGGKuUYVGz/2nToq3M=;
        b=j2u09yM5l/323Ka448VaPv1LG7LqAaEYz0PZdr1r/KNJ1g2xJcBMLqZlsDpDMzRb5h
         9Vy7xuf0SdACs1IMILrxi2L2UVJpAsywRRr1wlr5kvTFterFPXO+6ywJpiSQ4e/m+cM8
         HkgnzQJrFHocBgUiBBO64Kr/Y8YCS+F/TYQTUnYmIgNybQ/pb8n1BVRhTgQnTVh8uh7A
         84xYZ7CxxEBn2+EMqvpOKBHpTNCtrX+jqsTafZriRQS7NIZ/Z7URojLuuB00AHf2noJ2
         v7mme9NkiL8tUyYNnljRWXFEhhl2qhFvqKMCOwGjGThZIS6buys8ohJ7+5kkZuBoV1dT
         7fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kz5lMVwvOCVrmogtVEWpwErQFfGGKuUYVGz/2nToq3M=;
        b=OEYPY9FMgoCeSpctrnxhO4POIGKZaPFb2BaaM0ygwDogm2zugUsOW5lLxXTDEVQyMf
         B/BaFpVoj9c+fFxnbGhZPxPe5hGeTrgvIjLzxQ0cESZR9A2fwCz16V5ZHvxLCSmSIWIy
         wOyEClBe0sMDrRU9qThS6PyNc8xPWO2SHVPrCqAiBGUv2LIzjFMK6uAqN4ukAysUwSaW
         1nQiKKv33ie1d60i5yLsTiuByu4NwF9vNwmfql22SgnwQ9av+17O/OyF6k3SDLHnbL2c
         /QiwsM9d/fl+0LZwnhLm3WkqNvlABIelQfEfY5ifkaIQvJ1gpgupdmNJVaM3RBgJ8Dx4
         KX4w==
X-Gm-Message-State: AOAM532KM4tN4tg/Y0umTp1RoU+AcFnc2yyrqInNj3GOTO0u/L90jb3m
        gBPoQKBJ0hcVH9hrCF3zQsOtuA9zNmVqnkxPHo+zSQ==
X-Google-Smtp-Source: ABdhPJyQziOQe5F3EOcgL5uw4MWVkI519Ki6NKatykqIbO5nuXsaj+RptOUZLkH+K74gIqKrcOujKI9DJiSsZkQ5uC0=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr13232331ybk.412.1634315420493;
 Fri, 15 Oct 2021 09:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com> <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
 <CAJuCfpE2j91_AOwwRs_pYBs50wfLTwassRqgtqhXsh6fT+4MCg@mail.gmail.com> <b46d9bfe-17a9-0de9-271d-a3e6429e3f5f@redhat.com>
In-Reply-To: <b46d9bfe-17a9-0de9-271d-a3e6429e3f5f@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 15 Oct 2021 09:30:09 -0700
Message-ID: <CAJuCfpG=fNMDuYUo8UwjB-kDzR2gxmRmTJCqgojfPe6RULwc4A@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
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
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 14.10.21 22:16, Suren Baghdasaryan wrote:
> > On Tue, Oct 12, 2021 at 10:01 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >>
> >> On Tue, Oct 12, 2021 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>> I'm still evaluating the proposal to use memfds but I'm not sure if
> >>>> the issue that David Hildenbrand mentioned about additional memory
> >>>> consumed in pagecache (which has to be addressed) is the only one we
> >>>> will encounter with this approach. If anyone knows of any potential
> >>>> issues with using memfds as named anonymous memory, I would really
> >>>> appreciate your feedback before I go too far in that direction.
> >>>
> >>> [MAP_PRIVATE memfd only behave that way with 4k, not with huge pages, so
> >>> I think it just has to be fixed. It doesn't make any sense to allocate a
> >>> page for the pagecache ("populate the file") when accessing via a
> >>> private mapping that's supposed to leave the file untouched]
> >>>
> >>> My gut feeling is if you really need a string as identifier, then try
> >>> going with memfds. Yes, we might hit some road blocks to be sorted out,
> >>> but it just logically makes sense to me: Files have names. These names
> >>> exist before mapping and after mapping. They "name" the content.
> >>
> >> I'm investigating this direction. I don't have much background with
> >> memfds, so I'll need to digest the code first.
> >
> > I've done some investigation into the possibility of using memfds to
> > name anonymous VMAs. Here are my findings:
>
> Thanks for exploring the alternatives!

Thanks for pointing to them!

>
> >
> > 1. Forking a process with anonymous vmas named using memfd is 5-15%
> > slower than with prctl (depends on the number of VMAs in the process
> > being forked). Profiling shows that i_mmap_lock_write() dominates
> > dup_mmap(). Exit path is also slower by roughly 9% with
> > free_pgtables() and fput() dominating exit_mmap(). Fork performance is
> > important for Android because almost all processes are forked from
> > zygote, therefore this limitation already makes this approach
> > prohibitive.
>
> Interesting, naturally I wonder if that can be optimized.

Maybe but it looks like we simply do additional things for file-backed
memory, which seems natural. The call to i_mmap_lock_write() is from
here: https://elixir.bootlin.com/linux/latest/source/kernel/fork.c#L565

>
> >
> > 2. mremap() usage to grow the mapping has an issue when used with memfds:
> >
> > fd = memfd_create(name, MFD_ALLOW_SEALING);
> > ftruncate(fd, size_bytes);
> > ptr = mmap(NULL, size_bytes, prot, MAP_PRIVATE, fd, 0);
> > close(fd);
> > ptr = mremap(ptr, size_bytes, size_bytes * 2, MREMAP_MAYMOVE);
> > touch_mem(ptr, size_bytes * 2);
> >
> > This would generate a SIGBUS in touch_mem(). I believe it's because
> > ftruncate() specified the size to be size_bytes and we are accessing
> > more than that after remapping. prctl() does not have this limitation
> > and we do have a usecase for growing a named VMA.
>
> Can't you simply size the memfd much larger? I mean, it doesn't really
> cost much, does it?

If we know beforehand what the max size it can reach then that would
be possible. I would really hate to miscalculate here and cause a
simple memory access to generate signals. Tracking such corner cases
in the field is not an easy task and I would rather avoid the
possibility of it.

>
> >
> > 3. Leaves an fd exposed, even briefly, which may lead to unexpected
> > flaws (e.g. anything using mmap MAP_SHARED could allow exposures or
> > overwrites). Even MAP_PRIVATE, if an attacker writes into the file
> > after ftruncate() and before mmap(), can cause private memory to be
> > initialized with unexpected data.
>
> I don't quite follow. Can you elaborate what exactly the issue here is?
> We use a temporary fd, yes, but how is that a problem?
>
> Any attacker can just write any random memory memory in the address
> space, so I don't see the issue.

It feels to me that introducing another handle to the memory region is
a potential attack vector but I'm not a security expert. Maybe Kees
can assess this better?

>
> >
> > 4. There is a usecase in the Android userspace where vma naming
> > happens after memory was allocated. Bionic linker does in-memory
> > relocations and then names some relocated sections.
>
> Would renaming a memfd be an option or is that "too late" ?

My understanding is that linker allocates space to load and relocate
the code, performs the relocations in that space and then names some
of the regions after that. Whether it can be redesigned to allocate
multiple named regions and perform the relocation between them I did
not really try since it would be a project by itself.

TBH, at some point I just look at the amount of required changes (both
kernel and userspace) and new limitations that userspace has to adhere
to for fitting memfds to my usecase, and I feel that it's just not
worth it. In the end we end up using the same refcounted strings with
vma->vm_file->f_count as the refcount and name stored in
vma->vm_file->f_path->dentry but with more overhead.
Thanks,
Suren.

>
> >
> > In the light of these findings, could the current patchset be reconsidered?
> > Thanks,
> > Suren.
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
