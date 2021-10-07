Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF89425839
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhJGQpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbhJGQpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:45:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77FC061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 09:43:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w10so14780989ybt.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMUFD3KuFSgPveAs2xgT5F7+weHss6O3rW280Ex8iiE=;
        b=lSQNJhkP1akawNeEgKpbf1BUyWr8N8n+Trr+s3eMnruRatkQr6Q06I8yMRKTPvr8X+
         +i4AxqTgEfV/AzU5lGikKA468GOEAorD5DFxunVlJqCX/UvZv5zhuULnxKdsnxnS0SxN
         QnteEHOQRCGYbGP4DBHUlS2Di88ECvyjaoe3J39oCwGJ3T1641DVsLKL0e3Xdn/JZvdT
         QW8KYgfLJfCquy5oaNivhPTCHKVnF7UTeoh3qqdwRxVDhHE9jzYWjgteVrnsAJCab9QP
         VqCuBcMfyEnxRQ7JoJ0VlLNNDs1E1PNw43km2LYLuUdvGBMWkNdS9YmCGx8k8D6Q2m+T
         qVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMUFD3KuFSgPveAs2xgT5F7+weHss6O3rW280Ex8iiE=;
        b=1GzuQWayOb8IIBeRWl+KmvHRNIdJvWyvFrHvM0QeL04aeVImUCgMG347HQpfdegGeJ
         TgnjOpj7BacXc3xd44YuHc5i/jmY1u5MOxRuboFb+qPG/UM8/roDQ486HZsyMy/SzV0i
         lt5LZdBrbFGSJp0hVGfeBkEeuUGyVIrKIp3GA8wWyF2ZzW8t6iJxMmBSnmEaKDCr7qI4
         o3VLU7dlAWDF2zWZ1IZOs9/coCP6Ea7tdMRHSs4w9Sj1m+CILDEv/cy/0TxY4DKq6ZEy
         2AGma/Hi9zWhbvu3WWgU5i4kz47fruKeihaH5oE2ogPJf39eXkNg24bX+S3el+u+Qa5q
         zYtQ==
X-Gm-Message-State: AOAM532Nt0F0RIw+b+r+mFWhlGPMAA5R0TmAoQSD3jn62zfZTlpxZao+
        0utv0sdzjirqmsQuBjN7J7ePxDm9UhsaDUWDvAS2Ag==
X-Google-Smtp-Source: ABdhPJx2Hl6g/cZpIzwNX4cGshqHlY1IlMWsD0hSL7XbGg/JjUBjXh8IjPlQ+3QwPgdKW+4jVMtczDqOv9eU5AiWJCA=
X-Received: by 2002:a25:552:: with SMTP id 79mr5793280ybf.202.1633625005752;
 Thu, 07 Oct 2021 09:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <YV6o3Bsb4f87FaAy@dhcp22.suse.cz> <CAJuCfpGZAWewsEzqA5=+z_CaBLcPQX+sYF-FM0o_58UMCZoJfw@mail.gmail.com>
 <YV8iXQ9npVOLEeuc@dhcp22.suse.cz>
In-Reply-To: <YV8iXQ9npVOLEeuc@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 09:43:14 -0700
Message-ID: <CAJuCfpHWeK71Eh1dcKr1+_ijUJ-6LFBe0Rjk4hP7NCrnWpXFcw@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
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

On Thu, Oct 7, 2021 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-10-21 08:45:21, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 12:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 06-10-21 08:01:56, Suren Baghdasaryan wrote:
> > > > On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> > > > >
> > > > > On 06.10.21 10:27, Michal Hocko wrote:
> > > > > > On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > > > > > [...]
> > > > > >> 1) Yes, just leave the strings in the kernel, that's simple and
> > > > > >> it works, and the alternatives don't really help your case nearly
> > > > > >> enough.
> > > > > >
> > > > > > I do not have a strong opinion. Strings are easier to use but they
> > > > > > are more involved and the necessity of kref approach just underlines
> > > > > > that. There are going to be new allocations and that always can lead
> > > > > > to surprising side effects.  These are small (80B at maximum) so the
> > > > > > overall footpring shouldn't all that large by default but it can grow
> > > > > > quite large with a very high max_map_count. There are workloads which
> > > > > > really require the default to be set high (e.g. heavy mremap users). So
> > > > > > if anything all those should be __GFP_ACCOUNT and memcg accounted.
> > > > > >
> > > > > > I do agree that numbers are just much more simpler from accounting,
> > > > > > performance and implementation POV.
> > > > >
> > > > > +1
> > > > >
> > > > > I can understand that having a string can be quite beneficial e.g., when
> > > > > dumping mmaps. If only user space knows the id <-> string mapping, that
> > > > > can be quite tricky.
> > > > >
> > > > > However, I also do wonder if there would be a way to standardize/reserve
> > > > > ids, such that a given id always corresponds to a specific user. If we
> > > > > use an uint64_t for an id, there would be plenty room to reserve ids ...
> > > > >
> > > > > I'd really prefer if we can avoid using strings and instead using ids.
> > > >
> > > > I wish it was that simple and for some names like [anon:.bss] or
> > > > [anon:dalvik-zygote space] reserving a unique id would work, however
> > > > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > > > are generated dynamically at runtime and include package name.
> > > > Packages are constantly evolving, new ones are developed, names can
> > > > change, etc. So assigning a unique id for these names is not really
> > > > feasible.
> > >
> > > I still do not follow. If you need a globaly consistent naming then
> > > you need clear rules for that, no matter whether that is number or a
> > > file. How do you handle this with strings currently?
> >
> > Some names represent standard categories, some are unique. A simple
> > tool could calculate and report the total for each name, a more
> > advanced tool might recognize some standard names and process them
> > differently. From kernel's POV, it's just a name used by the userspace
> > to categorize anonymous memory areas.
>
> OK, so there is no real authority or any real naming convention. You
> just hope that applications will behave so that the consumer of those
> names can make proper calls. Correct?
>
> In that case the same applies to numbers and I do not see any strong
> argument for strings other than it is more pleasing to a human eye when
> reading the file. And that doesn't sound like a strong argument to make
> the kernel more complicated. Functionally both approaches are equal from
> a practical POV.

I don't think that's correct. Names like [anon:.bss],
[anon:dalvik-zygote space] and
[anon:dalvik-/system/framework/boot-core-icu4j.art] provide user with
actionable information about the use of that memory or the allocator
using it. Names like [anon:1], [anon:2] and [anon:3] do not convey any
valuable information for the user until they are converted into
descriptive names.

> --
> Michal Hocko
> SUSE Labs
