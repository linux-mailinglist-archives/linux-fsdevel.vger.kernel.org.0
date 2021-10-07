Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD8425984
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbhJGRdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 13:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbhJGRc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:32:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDAC061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 10:31:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r1so15045516ybo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFMiH5k6bTZykMDXuEggSN9IEsmXGxbcwFTl7AqjDQA=;
        b=LXyUtPBgoQ0wuEV8jWO3qbh1aq19+NB+Lj3QNc8iavlMTVCNb3Lk/5pepq+lRv3WYF
         94s526BQ8dmH0rW/nFdrbOb89wLb+OWnuC+dtYRmV+1sbJrOJhY9zSecE06C9uTm4xlH
         fdYjDMcpjNGy+xyqXbncZwjLyqXnUpnfnO7i3TsvElWM0IrdlUitVY2kmAUTtXWeO7jx
         lw+0RiP24lrJgk6TVwzr0YwO+kywWFJCBHnCq2t6zYMHIhiqydOujR+iLK080jPLYONs
         UVeo+0K7lnbrpeGaHWAnIRPbDndeAKwkb3Drmwgirj/J55VfQL74Zpd29efvaZAJy4Wn
         HtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFMiH5k6bTZykMDXuEggSN9IEsmXGxbcwFTl7AqjDQA=;
        b=hI/Zg7nt6/I0oyyuO1prV73Z9FtOa1xTFn0f5+JWgJqvQEWFBNXAkXeqcnSXIis1fl
         7ryvtCGATBNNAcwbhSX9iYxnbwxl/E3IWlu68+xhEC7N/xDoVSf89jN7K41EwlhVs4nl
         QmqUCMzav371VL6RaqB4pgJeNk4YC39h63HnTQJKBjxQOYcP71K76yFmqB4hUjPubOeO
         LbU0qt4SR5bR1J3NrZgqXuqSjaALSzm96KbmgTZ4gtvv7zbeS5ijh8HrsVj0O0Jq60b+
         wMKYxuZeB2r3mARcq4jUVPmLqIOVfyQ3jE3uKEKIVPOLdPI//9TvBUh6SNJxjqlN2eAW
         sHCw==
X-Gm-Message-State: AOAM530pY2c28eNFc7QR4rU3GXJDLQYvcP+jRCwl6F+zQPtbFMMSOv5Z
        a0b+zk4dih2dYmEHk708Cz4DTNqlEzZGy/79BLRt5Q==
X-Google-Smtp-Source: ABdhPJwpjKoLoBI5gOCik6Ve1waW1iJ2N/hIfjVfZ1uubfoQdCVIbn77Huwx2Za7fOFEIH/xXPzNZFvP9AfPUdJ//Pg=
X-Received: by 2002:a25:552:: with SMTP id 79mr6071995ybf.202.1633627863712;
 Thu, 07 Oct 2021 10:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <YV6o3Bsb4f87FaAy@dhcp22.suse.cz> <CAJuCfpGZAWewsEzqA5=+z_CaBLcPQX+sYF-FM0o_58UMCZoJfw@mail.gmail.com>
 <YV8iXQ9npVOLEeuc@dhcp22.suse.cz> <CAJuCfpHWeK71Eh1dcKr1+_ijUJ-6LFBe0Rjk4hP7NCrnWpXFcw@mail.gmail.com>
 <YV8tlUTdsiVuACx+@dhcp22.suse.cz>
In-Reply-To: <YV8tlUTdsiVuACx+@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 10:30:52 -0700
Message-ID: <CAJuCfpHM-W3iAANgudmgivz+aFMWxdVpPnZgQvibxwVE=L098g@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 10:25 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Thu 07-10-21 09:43:14, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > OK, so there is no real authority or any real naming convention. You
> > > just hope that applications will behave so that the consumer of those
> > > names can make proper calls. Correct?
> > >
> > > In that case the same applies to numbers and I do not see any strong
> > > argument for strings other than it is more pleasing to a human eye when
> > > reading the file. And that doesn't sound like a strong argument to make
> > > the kernel more complicated. Functionally both approaches are equal from
> > > a practical POV.
> >
> > I don't think that's correct. Names like [anon:.bss],
> > [anon:dalvik-zygote space] and
> > [anon:dalvik-/system/framework/boot-core-icu4j.art] provide user with
> > actionable information about the use of that memory or the allocator
> > using it.
>
> No, none of the above is really actionable without a common
> understanding. Both dalvik* are a complete gibberish to me.

Ok, maybe I was unclear. Some names, as the first two in the above
example are quite standard for Android and tools do use them to
identify specific specialized areas. Some names are not standardized
and can contain package names, like
anon:dalvik-/system/framework/boot-core-icu4j.art. In this case while
tools do not process them in any special way, they still convey enough
information for a user to identify the corresponding component.

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
