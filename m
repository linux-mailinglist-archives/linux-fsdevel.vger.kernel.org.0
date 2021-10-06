Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8627E4240AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhJFPEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbhJFPEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:04:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB74C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 08:02:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w10so6121748ybt.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzEyLfp/eaHfYFCvoWfOxrcj4KYXSDgQLbhw8YX+9RQ=;
        b=ta783nvpkwKOOuucrK44IRRZ9hsio5xXDjvuB9yPa0HD0qE19p3Q4KAilwYpao2Q1n
         /nNINPBvLQE6n0Mjih3w+sAS+eNMP0JqJynoUtkoX3L8FnPZ6D909MtUhWc0x1lqIwKr
         I75rTIamcY3eF7Zn2h7FYdOKahWN6t0lE2WxcbNT3KPeSXoG9FnXjf4zkYEVH8bdehPD
         AES4Z8OtqtuO0iGM7ej/L8A3TQn3beFpQ+dLiQlBnMalAJDGX0ac669Mqpjv94Xxb8oX
         ldmGzRMon9eDT7CoGa6HBE1/ZEcLnn8xoWaZW6Jx3Ln4YtFCGcJ4lJfPw8yndXkoqCt5
         UGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzEyLfp/eaHfYFCvoWfOxrcj4KYXSDgQLbhw8YX+9RQ=;
        b=RWm+MSjkcv244XHo6fXKHT6+MhKs1A+xP3e6O51YPWX9ARWvYL3Se3OZuSjRBCf1Qt
         qNwM/kDz3cmFk/wlo5OzvdERzEUAxKZTyS+nGSro0GsZjuQy8ba6u2cvJSYajfC+Eq1p
         idefZWxK4xqtRbW1rkiNBR8hQt9/OWPJX8zd7QV+SAhrf0RvN01aaaMWOYs8jePei6/B
         SDt5mWaLgwxvSod5n8OidAaJ9ZSMJcAxzP/D3MJvqKjGe9ES+SHSZjm+0ZkC4hWl7IbD
         zVnGq1WapaFQdTpSl6sI1Cq5jZsQ7ar2MlX4u+5q747PxrM7xKdQPGZRNnVNqJmsr+Uj
         jxmw==
X-Gm-Message-State: AOAM533XBT4zThUbouzBjvxLVGvUPFVyENJI5r5uRHKPhq5pIFipUXUr
        UAi+LIhIg1Xf6y62/ROAUKRWPU136X3biKSbMBLHrQ==
X-Google-Smtp-Source: ABdhPJzHHjr+U17m6GiWu/VvrpzHwzmwnyEEuH0irvtCoZwtYfAaRRTS4+nFij482usItX590WL/sqUymh0V1yrnZeU=
X-Received: by 2002:a25:3:: with SMTP id 3mr29737607yba.418.1633532527401;
 Wed, 06 Oct 2021 08:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
In-Reply-To: <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 6 Oct 2021 08:01:56 -0700
Message-ID: <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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

On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.10.21 10:27, Michal Hocko wrote:
> > On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > [...]
> >> 1) Yes, just leave the strings in the kernel, that's simple and
> >> it works, and the alternatives don't really help your case nearly
> >> enough.
> >
> > I do not have a strong opinion. Strings are easier to use but they
> > are more involved and the necessity of kref approach just underlines
> > that. There are going to be new allocations and that always can lead
> > to surprising side effects.  These are small (80B at maximum) so the
> > overall footpring shouldn't all that large by default but it can grow
> > quite large with a very high max_map_count. There are workloads which
> > really require the default to be set high (e.g. heavy mremap users). So
> > if anything all those should be __GFP_ACCOUNT and memcg accounted.
> >
> > I do agree that numbers are just much more simpler from accounting,
> > performance and implementation POV.
>
> +1
>
> I can understand that having a string can be quite beneficial e.g., when
> dumping mmaps. If only user space knows the id <-> string mapping, that
> can be quite tricky.
>
> However, I also do wonder if there would be a way to standardize/reserve
> ids, such that a given id always corresponds to a specific user. If we
> use an uint64_t for an id, there would be plenty room to reserve ids ...
>
> I'd really prefer if we can avoid using strings and instead using ids.

I wish it was that simple and for some names like [anon:.bss] or
[anon:dalvik-zygote space] reserving a unique id would work, however
some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
are generated dynamically at runtime and include package name.
Packages are constantly evolving, new ones are developed, names can
change, etc. So assigning a unique id for these names is not really
feasible.
That leaves us with the central facility option, which as I described
in my previous email would be prohibitive from performance POV (IPC
every time we have a new name or want to convert id to name).

I'm all for simplicity but the simple approach of using ids instead of
names unfortunately would not work for our usecases.

>
> --
> Thanks,
>
> David / dhildenb
>
