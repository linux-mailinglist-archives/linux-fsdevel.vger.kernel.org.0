Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A774245E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhJFSUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhJFSUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:20:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAEC061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 11:18:43 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r1so7456290ybo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tS0Q/doPfkgcSn/P1ry79XfUH0i7iJLfycZHaCEByaw=;
        b=TYlphAvwMJftzt6RU5u9b6mLtXkIqYWFA04tNKYd2B2kJaBNHrvFS+iWcxQyx65O49
         VEw0jFjeBxrJigtMkEwMctb8oSbx+fuz5GPExgicIXWNFArloubetA2TV3UEBOxGB59S
         4/eOuXBnAvuNH7y8YiILc6KY9YVEnat4qn2XUv33xrzz3GJLMCPCjq1bI/veMmjJStMA
         mw1RSKpfndHUtx7NSTXL90xYj4QC8EJDHuoNRRjBjJoyYzyw7iirxJ6l/qIOOS8/aEEI
         zLEZyLx56Nk0A1AScwAL4V61zvIuQvil+E41AYH4QmyoGC+u+esm8H+BU3U5aLJkJiKd
         +gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tS0Q/doPfkgcSn/P1ry79XfUH0i7iJLfycZHaCEByaw=;
        b=I26nRW9W9HudHSRdDl15HJZFo+kyZNN0URQeMrgLnVAl+HzFR5P8KKlzj6+R4mauFT
         8Zq4yijEcRVRL4nHlbKDHjzvhnH5rxfzxA2SgU+NeVp06R9N7LaL3qyHJnVMKB/j4EYL
         eEqhnaq9PUg0GSAZ8mFq2uLoUYLDuI4EQKUubnkJ1Du5hCIlsA7AeJ7YeNgjRxyeKBLX
         Ekxq2s/x+f3ed/oiuTyNImLiIlxEbxmxYfthzlMbrRb3tpsayu3ZCiaWpn0LzuoETFlN
         8ewwjoRoRT24Qq5wSYX6kGuaKe1sjBUXIFq4zvL6h6YWx4mq3Lz6pF/h2paZfkauvAMK
         BQkA==
X-Gm-Message-State: AOAM530w6fnt6x7Jsm7c0MUqEXuUo6coebdrIH4Zu/qtWCRZXDhQFZH6
        lQoZD/D4Z41fvY6A0wzmjltF859kssW9rmAtk3Kgmg==
X-Google-Smtp-Source: ABdhPJxugzCMn7sZu79C5fnZMRKkgBcjmMuKl0Fdq3TPkxzrJccYHRxTws0QUusFhxlrkQ2KrgfrvvthwxjhDBttraA=
X-Received: by 2002:a25:552:: with SMTP id 79mr29984731ybf.202.1633544322361;
 Wed, 06 Oct 2021 11:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz>
In-Reply-To: <20211006175821.GA1941@duo.ucw.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 6 Oct 2021 11:18:31 -0700
Message-ID: <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
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

On Wed, Oct 6, 2021 at 10:58 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
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
>
> I'd be careful; if you allow special characters like that, you will
> confuse some kind of parser.

That's why I think having a separate config option with default being
disabled would be useful here. It can be enabled on the systems which
handle [anon:...] correctly without affecting all other systems.

>
> > Packages are constantly evolving, new ones are developed, names can
> > change, etc. So assigning a unique id for these names is not really
> > feasible.
> > That leaves us with the central facility option, which as I described
> > in my previous email would be prohibitive from performance POV (IPC
> > every time we have a new name or want to convert id to name).
>
> That "central facility" option can be as simple as "mkdir
> /somewhere/sanitized_id", using inode numbers for example. You don't
> really need IPC.

Hmm, so the suggestion is to have some directory which contains files
representing IDs, each containing the string name of the associated
vma? Then let's say we are creating a new VMA and want to name it. We
would have to scan that directory, check all files and see if any of
them contain the name we want to reuse the same ID. This is while we
are doing mmap() call, which is often a part of time sensitive
operation (for example app is starting and allocating some memory to
operate). App startup time is one of the main metrics our users care
about and regressing that would not go well with our QA team.

>
> Plus, I don't really believe the IPC cost would be prohibitive.

This option was discussed by the Android performance team and rejected
8 years ago. The problem is that these operations are often happening
in performance-sensitive areas of the process lifecycle.

>
> Or you could simply hash the string and use the hash as id...

I don't see how this would help. You still need to register your
hash->name association somewhere for that hash to be converted back to
the name. Did I misunderstand your suggestion?

>
> Best regards,
>                                                                 Pavel
> --
> http://www.livejournal.com/~pavelmachek
