Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E742EAF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhJOIG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236601AbhJOIGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634285036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggZGR9DaIVOeY+FRltem0wB6ymI3HDlfEdwv9GyNtfI=;
        b=VS12Lp+eR3OB29gXCpt+rsrElp11aBZLw5uBsaSFIQya7Vcfnc50VU4dX5xqYg4iRotghy
        eDjPxi3Jp0r/KoYyYeDqQ+t2km+XGLS9pdKin1pVQv6T34wYleKqenGQGztUi76F5sN/UQ
        rh6vxK5s0Y7X4QP8o734mD6/y1O5F8c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-ZOmojarzO_OoT4K6ZUr_Pg-1; Fri, 15 Oct 2021 04:03:55 -0400
X-MC-Unique: ZOmojarzO_OoT4K6ZUr_Pg-1
Received: by mail-wr1-f70.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso5670385wrg.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 01:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ggZGR9DaIVOeY+FRltem0wB6ymI3HDlfEdwv9GyNtfI=;
        b=3ulvU0l4Pr0cUrSk82v7VZCAF6/S5IoqzW1CaJFFXQVJr5BpWvqXmvl6RZh1CVdR2V
         9FmPnqZ0rhMfds8URYwUAHiVldmlb+rA2b5cb0TAa9EvlJgrdOWp6dIac2s2plN7FyAP
         SHatlQSyNZSNa86SeWP1T4wZ1WP8D2RvJgA9WkCEy2FojL9ZJUsKzR4jUqdNiNDH30s6
         sx1GCZsUskFs8HZZHQdDi+WzNbDHpq9w4+VweFC+O+CZd4g9yhJ2Epp61mod7YvTA6KO
         se3ZsCfGH6ohi4EGK9KWIjj9+vDhP7t1OCi3fOfBBgx6nOZng8cLCHbkQ+Fg1JtB8rCu
         DWLQ==
X-Gm-Message-State: AOAM532KWtYa65SSuDZQCcqsoBpqE786DcDIByzgjPcN3bBx8/1HHwIH
        oASoUDTkkuICPTkBQ0NfQUslDwHcilKtU7m1usIAH7DatynLoAOGrzms1i4phqxlu3jyeLnxzxr
        jctF5KV+7PtLgsOKVimGAw7jwHQ==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr24174303wms.44.1634285034167;
        Fri, 15 Oct 2021 01:03:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyS/mpsmRvUStNqiEiz88T6GCugC6hJP08MiJ6PoPMw9Y5ONN056muHJGQhAs7LpZbDtZMuw==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr24174227wms.44.1634285033755;
        Fri, 15 Oct 2021 01:03:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id p18sm4349286wrt.54.2021.10.15.01.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:03:53 -0700 (PDT)
Message-ID: <b46d9bfe-17a9-0de9-271d-a3e6429e3f5f@redhat.com>
Date:   Fri, 15 Oct 2021 10:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
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
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com>
 <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
 <CAJuCfpE2j91_AOwwRs_pYBs50wfLTwassRqgtqhXsh6fT+4MCg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpE2j91_AOwwRs_pYBs50wfLTwassRqgtqhXsh6fT+4MCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.10.21 22:16, Suren Baghdasaryan wrote:
> On Tue, Oct 12, 2021 at 10:01 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Tue, Oct 12, 2021 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> I'm still evaluating the proposal to use memfds but I'm not sure if
>>>> the issue that David Hildenbrand mentioned about additional memory
>>>> consumed in pagecache (which has to be addressed) is the only one we
>>>> will encounter with this approach. If anyone knows of any potential
>>>> issues with using memfds as named anonymous memory, I would really
>>>> appreciate your feedback before I go too far in that direction.
>>>
>>> [MAP_PRIVATE memfd only behave that way with 4k, not with huge pages, so
>>> I think it just has to be fixed. It doesn't make any sense to allocate a
>>> page for the pagecache ("populate the file") when accessing via a
>>> private mapping that's supposed to leave the file untouched]
>>>
>>> My gut feeling is if you really need a string as identifier, then try
>>> going with memfds. Yes, we might hit some road blocks to be sorted out,
>>> but it just logically makes sense to me: Files have names. These names
>>> exist before mapping and after mapping. They "name" the content.
>>
>> I'm investigating this direction. I don't have much background with
>> memfds, so I'll need to digest the code first.
> 
> I've done some investigation into the possibility of using memfds to
> name anonymous VMAs. Here are my findings:

Thanks for exploring the alternatives!

> 
> 1. Forking a process with anonymous vmas named using memfd is 5-15%
> slower than with prctl (depends on the number of VMAs in the process
> being forked). Profiling shows that i_mmap_lock_write() dominates
> dup_mmap(). Exit path is also slower by roughly 9% with
> free_pgtables() and fput() dominating exit_mmap(). Fork performance is
> important for Android because almost all processes are forked from
> zygote, therefore this limitation already makes this approach
> prohibitive.

Interesting, naturally I wonder if that can be optimized.

> 
> 2. mremap() usage to grow the mapping has an issue when used with memfds:
> 
> fd = memfd_create(name, MFD_ALLOW_SEALING);
> ftruncate(fd, size_bytes);
> ptr = mmap(NULL, size_bytes, prot, MAP_PRIVATE, fd, 0);
> close(fd);
> ptr = mremap(ptr, size_bytes, size_bytes * 2, MREMAP_MAYMOVE);
> touch_mem(ptr, size_bytes * 2);
> 
> This would generate a SIGBUS in touch_mem(). I believe it's because
> ftruncate() specified the size to be size_bytes and we are accessing
> more than that after remapping. prctl() does not have this limitation
> and we do have a usecase for growing a named VMA.

Can't you simply size the memfd much larger? I mean, it doesn't really
cost much, does it?

> 
> 3. Leaves an fd exposed, even briefly, which may lead to unexpected
> flaws (e.g. anything using mmap MAP_SHARED could allow exposures or
> overwrites). Even MAP_PRIVATE, if an attacker writes into the file
> after ftruncate() and before mmap(), can cause private memory to be
> initialized with unexpected data.

I don't quite follow. Can you elaborate what exactly the issue here is?
We use a temporary fd, yes, but how is that a problem?

Any attacker can just write any random memory memory in the address
space, so I don't see the issue.

> 
> 4. There is a usecase in the Android userspace where vma naming
> happens after memory was allocated. Bionic linker does in-memory
> relocations and then names some relocated sections.

Would renaming a memfd be an option or is that "too late" ?

> 
> In the light of these findings, could the current patchset be reconsidered?
> Thanks,
> Suren.
> 


-- 
Thanks,

David / dhildenb

