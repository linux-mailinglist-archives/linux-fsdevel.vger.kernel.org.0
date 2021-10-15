Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09E42FB0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhJOSgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbhJOSfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:35:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F77C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 11:33:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n65so24835580ybb.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Te9f2SCg6g7ZLqzS5jQBTUtq73YsWWcz5wpKa5oJkKU=;
        b=L88l/ewTW7/hyA58QlhQiGpG0PpswGaSNEs9o63QcWE94uA741P2X4ymDTKOeuNfIb
         iCDTwyIR3RBwLo2XTniMIe7bsVraWqopcn7H10rNgTxKMLSd6Olgc0gD5qnxTJ/f6O1p
         Twfo0WeeL6+tdVn1PJjDDV+pQSyMFctUIDe7lj0bhaqzrR9GE+OXQs3eS3CoZx4hLY89
         BfjA9j4Kh6tKvBmpiWziY3Q41Tx5rk0BbbmrwES8KWPnRMashsyU/CChh/EWVbI/IvD8
         TA5ckE+apAM6C/B5biqIIrVnILGJ+kS4Qt0E/qBYslhp5Br6IdGtRh092e9cVY0/gfbY
         4YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Te9f2SCg6g7ZLqzS5jQBTUtq73YsWWcz5wpKa5oJkKU=;
        b=WuG4KledWeHInU5O1okibo1CqYVreUauykZLvjMRou/3PmhgbUkVlUh/+mNMnGyxni
         FK5zUPycpvKoNxQjpVRszbqlWxESntUvYVZ7fB5cSrY+LpEybLJ+pX5bInhxpLmJrRSq
         xr+d3buo/pbapCyjdPvImkezMwIMez3+3zK7RVUF3+lMYxC5iuNnXkUGbEEit4UCWtxx
         h86sEsQHwoArishWRVwB0B1K+zltg7yNZulBfTY5OqoMoYA7jLuWCrRh2WpyrjEefbhN
         4yG5oy32PIZHjNPK63Bglp3YYBArfWXuH3j/gwMm2zaeHOtNLXeAqFMbG2X8Ag83lM+I
         IqAA==
X-Gm-Message-State: AOAM532vWVpYpcl0NAJ3jpHFCw6Rt1WycnkvEMpBDHpSo1RmPHg9DLh/
        4VoKn3z6a7JyUpHtdOZD73v46VLNmrtzw67lhSxZJg==
X-Google-Smtp-Source: ABdhPJyxBFWbSkfrU5ks5rSh2Jm/DM5lei4c6HB9bi0EhzY6DB8hXPXtRMmfNb/TaOZCIf5FbSO8rKZXnEP/tJQFETg=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr17200240ybu.161.1634322814158;
 Fri, 15 Oct 2021 11:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com> <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
 <CAJuCfpE2j91_AOwwRs_pYBs50wfLTwassRqgtqhXsh6fT+4MCg@mail.gmail.com>
 <b46d9bfe-17a9-0de9-271d-a3e6429e3f5f@redhat.com> <CAJuCfpG=fNMDuYUo8UwjB-kDzR2gxmRmTJCqgojfPe6RULwc4A@mail.gmail.com>
 <3563a3e8-b971-b604-7388-766ecfce4634@redhat.com>
In-Reply-To: <3563a3e8-b971-b604-7388-766ecfce4634@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 15 Oct 2021 11:33:22 -0700
Message-ID: <CAJuCfpEemQv+9nfx48cPGQMOYBWrmKcBt-SdSq460Udh8ZsKfA@mail.gmail.com>
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

On Fri, Oct 15, 2021 at 9:39 AM David Hildenbrand <david@redhat.com> wrote:
>
>
> >>>
> >>> 1. Forking a process with anonymous vmas named using memfd is 5-15%
> >>> slower than with prctl (depends on the number of VMAs in the process
> >>> being forked). Profiling shows that i_mmap_lock_write() dominates
> >>> dup_mmap(). Exit path is also slower by roughly 9% with
> >>> free_pgtables() and fput() dominating exit_mmap(). Fork performance is
> >>> important for Android because almost all processes are forked from
> >>> zygote, therefore this limitation already makes this approach
> >>> prohibitive.
> >>
> >> Interesting, naturally I wonder if that can be optimized.
> >
> > Maybe but it looks like we simply do additional things for file-backed
> > memory, which seems natural. The call to i_mmap_lock_write() is from
> > here: https://elixir.bootlin.com/linux/latest/source/kernel/fork.c#L565
> >
> >>
> >>>
> >>> 2. mremap() usage to grow the mapping has an issue when used with memfds:
> >>>
> >>> fd = memfd_create(name, MFD_ALLOW_SEALING);
> >>> ftruncate(fd, size_bytes);
> >>> ptr = mmap(NULL, size_bytes, prot, MAP_PRIVATE, fd, 0);
> >>> close(fd);
> >>> ptr = mremap(ptr, size_bytes, size_bytes * 2, MREMAP_MAYMOVE);
> >>> touch_mem(ptr, size_bytes * 2);
> >>>
> >>> This would generate a SIGBUS in touch_mem(). I believe it's because
> >>> ftruncate() specified the size to be size_bytes and we are accessing
> >>> more than that after remapping. prctl() does not have this limitation
> >>> and we do have a usecase for growing a named VMA.
> >>
> >> Can't you simply size the memfd much larger? I mean, it doesn't really
> >> cost much, does it?
> >
> > If we know beforehand what the max size it can reach then that would
> > be possible. I would really hate to miscalculate here and cause a
> > simple memory access to generate signals. Tracking such corner cases
> > in the field is not an easy task and I would rather avoid the
> > possibility of it.
>
> The question would be if you cannot simply add some extremely large
> number, because the file size itself doesn't really matter for memfd IIRC.
>
> Having that said, without trying it out, I wouldn't know from the top of
> my head if memremap would work that way on an already closed fd that ahs
> a sufficient size :/ If you have the example still somewhere, I would be
> interested if that would work in general.

Yes, I tried a simple test like this and it works:

fd = memfd_create(name, MFD_ALLOW_SEALING);
ftruncate(fd, size_bytes * 2);
ptr = mmap(NULL, size_bytes, prot, MAP_PRIVATE, fd, 0);
close(fd);
ptr = mremap(ptr, size_bytes, size_bytes * 2, MREMAP_MAYMOVE);
touch_mem(ptr, size_bytes * 2);

I understand your suggestion but it's just another hoop we have to
jump to make this work and feels unnatural from userspace POV. Also
virtual address space exhaustion might be an issue for 32bit userspace
with this approach.

>
> [...]
>
> >>
> >>>
> >>> 4. There is a usecase in the Android userspace where vma naming
> >>> happens after memory was allocated. Bionic linker does in-memory
> >>> relocations and then names some relocated sections.
> >>
> >> Would renaming a memfd be an option or is that "too late" ?
> >
> > My understanding is that linker allocates space to load and relocate
> > the code, performs the relocations in that space and then names some
> > of the regions after that. Whether it can be redesigned to allocate
> > multiple named regions and perform the relocation between them I did
> > not really try since it would be a project by itself.
> >
> > TBH, at some point I just look at the amount of required changes (both
> > kernel and userspace) and new limitations that userspace has to adhere
> > to for fitting memfds to my usecase, and I feel that it's just not
> > worth it. In the end we end up using the same refcounted strings with
> > vma->vm_file->f_count as the refcount and name stored in
> > vma->vm_file->f_path->dentry but with more overhead.
>
> Yes, but it's glued to files which naturally have names :)

Yeah, I understand your motivations and that's why I'm exploring these
possibilities but it proves to be just too costly for a feature as
simple as naming a vma :)

>
> Again, I appreciate that you looked into alternatives! I can see the
> late renaming could be the biggest blocker if user space cannot be
> adjusted easily to be compatible with that using memfds.

Yeah, it would definitely be hard for Android to adopt this.

If there are no objections to the current approach I would like to
respin another version with the CONFIG option added sometime early
next week. If anyone has objections, please let me know.
Thanks,
Suren.

>
> --
> Thanks,
>
> David / dhildenb
>
