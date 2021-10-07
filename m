Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB104256EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhJGPr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 11:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbhJGPr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:47:27 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E01C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 08:45:33 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n65so14358252ybb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Om7LGE3gSjcZBFq77mdFp8GnO5RkVNXV9ISnriMjmM=;
        b=Hb3t2wEM1YWKXwISWKF/3EFu46fQs/nDkeJx6X/Fyj/cFzdPKNkig51Yo0x6KJCYqj
         ErfpBxfWzUR3xyAsPp/qPPWXRAB8Mu3oVRrkEj/d9j53xXqBnDfzuWllwmXuDMu9/E5A
         8bjL4tnm4XgwJ2uyh+9hgmME+6VKeRYsr8+6Rou2xI4GPXRk5/NvJm8fiSGkqzKav/MG
         /Gl4Qvjn0e0r/s0SzHf8lqN+EwkSQYZPWo0nVOzRH5QznfTGTXQYYxMQQx6GvYXgvhW/
         spEDlpHT1LfJaFrkYPOZ1oOFdxFdUiP+Hiv3l78GkFj40SwAv9HtNjmpXU6Jo0DI6WRk
         7Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Om7LGE3gSjcZBFq77mdFp8GnO5RkVNXV9ISnriMjmM=;
        b=uLey91LgNCWrqwOGCGsDSV+TWTsHUecgDTVTkYb1KSY0oGOeXGcMXxHruRUDsV0wrE
         u6wsBWwKmg+mVee1Ze8srV/rNrjO3O6NGS/p/+UsDHIZ1GHV/jcNUCkBSKZNZHlVyRNm
         RcT37iP571Y8P0+lJx9Xq+3kT7G5Qp18+xzp0+VHqkYh04vLTMMS4bbQxzpCjI7rkpSp
         wWPzcmVkp7ili3Fhz+ppXRKaSLiYtZmd0OGXSem/jj3qaahNI2wu5lDHW9Q7s1wAUgEJ
         Pw0LzqqsTXU9arSYYXxNbPDtZYnHh9fN8NHY1XuPQ5V+VYhibCVYmG/rLKFmhgiobSRz
         1GHg==
X-Gm-Message-State: AOAM530gKOXJAzxNeQ+r6YwGKfYDg6g4DpLNJKfN37n+/lv5lnbsmTyx
        HiY5e2kBR4oG/ibK+FXVGjJZlZzCoWeSlOQr9th6bw==
X-Google-Smtp-Source: ABdhPJyo+e9PBZc5VFvov456HUHahKkqzXwSnZsVdpk+F6b0N7psDwC6DpujRY04QM5ceyFAdIHfc7qPFdOjW60mNDw=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr6352655ybu.161.1633621532428;
 Thu, 07 Oct 2021 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <YV6o3Bsb4f87FaAy@dhcp22.suse.cz>
In-Reply-To: <YV6o3Bsb4f87FaAy@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 08:45:21 -0700
Message-ID: <CAJuCfpGZAWewsEzqA5=+z_CaBLcPQX+sYF-FM0o_58UMCZoJfw@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 12:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-10-21 08:01:56, Suren Baghdasaryan wrote:
> > On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 06.10.21 10:27, Michal Hocko wrote:
> > > > On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > > > [...]
> > > >> 1) Yes, just leave the strings in the kernel, that's simple and
> > > >> it works, and the alternatives don't really help your case nearly
> > > >> enough.
> > > >
> > > > I do not have a strong opinion. Strings are easier to use but they
> > > > are more involved and the necessity of kref approach just underlines
> > > > that. There are going to be new allocations and that always can lead
> > > > to surprising side effects.  These are small (80B at maximum) so the
> > > > overall footpring shouldn't all that large by default but it can grow
> > > > quite large with a very high max_map_count. There are workloads which
> > > > really require the default to be set high (e.g. heavy mremap users). So
> > > > if anything all those should be __GFP_ACCOUNT and memcg accounted.
> > > >
> > > > I do agree that numbers are just much more simpler from accounting,
> > > > performance and implementation POV.
> > >
> > > +1
> > >
> > > I can understand that having a string can be quite beneficial e.g., when
> > > dumping mmaps. If only user space knows the id <-> string mapping, that
> > > can be quite tricky.
> > >
> > > However, I also do wonder if there would be a way to standardize/reserve
> > > ids, such that a given id always corresponds to a specific user. If we
> > > use an uint64_t for an id, there would be plenty room to reserve ids ...
> > >
> > > I'd really prefer if we can avoid using strings and instead using ids.
> >
> > I wish it was that simple and for some names like [anon:.bss] or
> > [anon:dalvik-zygote space] reserving a unique id would work, however
> > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > are generated dynamically at runtime and include package name.
> > Packages are constantly evolving, new ones are developed, names can
> > change, etc. So assigning a unique id for these names is not really
> > feasible.
>
> I still do not follow. If you need a globaly consistent naming then
> you need clear rules for that, no matter whether that is number or a
> file. How do you handle this with strings currently?

Some names represent standard categories, some are unique. A simple
tool could calculate and report the total for each name, a more
advanced tool might recognize some standard names and process them
differently. From kernel's POV, it's just a name used by the userspace
to categorize anonymous memory areas.

>
> --
> Michal Hocko
> SUSE Labs
