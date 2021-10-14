Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE042E28C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhJNUTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhJNUTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:19:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF78C061753
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 13:16:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g6so17497139ybb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0cmuWRsBM8lyTJIMBQh8bNKy5hHUkW2gy7WXb11ikU=;
        b=f0qLDOKzIPAztbLgdkQY2YKlIIwOO4CPZpbMpiSv8Ew9Oil/ath9n07/ohZFTfCchC
         tUfFpgpxKWGSiuPuGQXa1lAJMzvJ2v2jEgfNJIChSA6p3F/PA65vL35nhyaFPtFPTu49
         1247Evth3zZtmiV9KJGFY1VnR8L91bL9rPwjPym6PmsUCAowdylHSWXNeLXHESeggihA
         Vt1lQtjprzK6LMxeZPiVT/NtzOrDnx2xOOG8OJMrpdLwEzixkPIbxPqs1oZmLmYb8uvN
         owoPUF3VgkSF9BJUFMguFjxt/z84NGzPG34QC62MSK7yEjYhoPlVKw2QYEROpDMnIVFl
         tCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0cmuWRsBM8lyTJIMBQh8bNKy5hHUkW2gy7WXb11ikU=;
        b=p55edIL/upwtZUNBi4zKlViOHGNRM3GyHysRNAlBJuVxQIWQhvO+f9JmB3LYmP+yV7
         hJEEBBt55+EMRFkfcjtdpCLPf/xYVCH9Op2kNhqakVQRt31F0eSWfyhWDttZLWP2JMbD
         a0juwG0r6Di+giJmHy7JKsOHEf4PoeJylnaxMZtrk+bYdg7QPBUFfKR5vDOLedhXf76H
         A49eOsVj6YXC+kNJstamXyHmDIFz3e7XaLvfPqQ0Ea2oLtICF2MGMvTaaRfWoEwqLtL+
         NdH0pwszitP7yyg7mjJJXArE3FV2tuTncMojkRXlLmND74cweCdTT9cA5681tt8UQKIs
         6Uaw==
X-Gm-Message-State: AOAM532borpDr/+goPoe3akwptPSo+PE3bP5LJJDKvuR3DpJs26hpKnQ
        sSz+DlEDaU/GaxZSzDAEPHV/0u9O3cIcUOTy7bBfKQ==
X-Google-Smtp-Source: ABdhPJyxDeRMapi8KKC0nonneI/eCQ7+kw+lLAqFaMCn23DedEM+4BAtFbvseb+djFd5f1c00tNd4JPLKH7QEDYHlig=
X-Received: by 2002:a25:5b04:: with SMTP id p4mr8493469ybb.34.1634242618619;
 Thu, 14 Oct 2021 13:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com> <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
In-Reply-To: <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Oct 2021 13:16:47 -0700
Message-ID: <CAJuCfpE2j91_AOwwRs_pYBs50wfLTwassRqgtqhXsh6fT+4MCg@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 10:01 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > > I'm still evaluating the proposal to use memfds but I'm not sure if
> > > the issue that David Hildenbrand mentioned about additional memory
> > > consumed in pagecache (which has to be addressed) is the only one we
> > > will encounter with this approach. If anyone knows of any potential
> > > issues with using memfds as named anonymous memory, I would really
> > > appreciate your feedback before I go too far in that direction.
> >
> > [MAP_PRIVATE memfd only behave that way with 4k, not with huge pages, so
> > I think it just has to be fixed. It doesn't make any sense to allocate a
> > page for the pagecache ("populate the file") when accessing via a
> > private mapping that's supposed to leave the file untouched]
> >
> > My gut feeling is if you really need a string as identifier, then try
> > going with memfds. Yes, we might hit some road blocks to be sorted out,
> > but it just logically makes sense to me: Files have names. These names
> > exist before mapping and after mapping. They "name" the content.
>
> I'm investigating this direction. I don't have much background with
> memfds, so I'll need to digest the code first.

I've done some investigation into the possibility of using memfds to
name anonymous VMAs. Here are my findings:

1. Forking a process with anonymous vmas named using memfd is 5-15%
slower than with prctl (depends on the number of VMAs in the process
being forked). Profiling shows that i_mmap_lock_write() dominates
dup_mmap(). Exit path is also slower by roughly 9% with
free_pgtables() and fput() dominating exit_mmap(). Fork performance is
important for Android because almost all processes are forked from
zygote, therefore this limitation already makes this approach
prohibitive.

2. mremap() usage to grow the mapping has an issue when used with memfds:

fd = memfd_create(name, MFD_ALLOW_SEALING);
ftruncate(fd, size_bytes);
ptr = mmap(NULL, size_bytes, prot, MAP_PRIVATE, fd, 0);
close(fd);
ptr = mremap(ptr, size_bytes, size_bytes * 2, MREMAP_MAYMOVE);
touch_mem(ptr, size_bytes * 2);

This would generate a SIGBUS in touch_mem(). I believe it's because
ftruncate() specified the size to be size_bytes and we are accessing
more than that after remapping. prctl() does not have this limitation
and we do have a usecase for growing a named VMA.

3. Leaves an fd exposed, even briefly, which may lead to unexpected
flaws (e.g. anything using mmap MAP_SHARED could allow exposures or
overwrites). Even MAP_PRIVATE, if an attacker writes into the file
after ftruncate() and before mmap(), can cause private memory to be
initialized with unexpected data.

4. There is a usecase in the Android userspace where vma naming
happens after memory was allocated. Bionic linker does in-memory
relocations and then names some relocated sections.

In the light of these findings, could the current patchset be reconsidered?
Thanks,
Suren.


>
> >
> > Maybe it's just me, but the whole interface, setting the name via a
> > prctl after the mapping was already instantiated doesn't really spark
> > joy at my end. That's not a strong pushback, but if we can avoid it
> > using something that's already there, that would be very much preferred.
>
> Actually that's one of my worries about using memfds. There might be
> cases when we need to name a vma after it was mapped. memfd_create()
> would not allow us to do that AFAIKT. But I need to check all usages
> to say if that's really an issue.
> Thanks!
>
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
