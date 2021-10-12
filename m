Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADD42AA32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhJLRDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJLRDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:03:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E2C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 10:01:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s4so48117746ybs.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Tzhl0MVFy9A0j1rnPsvy8YVR9B6G5UsH8EyCGPBclE=;
        b=ZcOenQ6fVRLLsv/XeQFPg7fnM5YEM500n89LF22NH+zpMwjIeByGZnUmUhodoBeu4+
         uwRWuao0Tu++R3OlxtP+LKtt7vSGIzR7JzZAOoRYt2nrsggm63sKqt5bHG4YydOI6rbz
         EWfFpyddnUNjAcDMQdF8LgCWLuUDazezQTw7gQy9qtJAntsZUsYobnzegylDiaOMGwOI
         MDxq8+Dre7QZRyI4jvrs5HJwdVG78mh5+2eIvdkY04GLC9IKL1K9rD+9U39CrRpRZfZ+
         85bzsQZhzLNXmWkU4iZojVd4u4SE2SIV3Kygv4OxuhiD5x9Uo9VVm0sv7jo2p7b5oW5u
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Tzhl0MVFy9A0j1rnPsvy8YVR9B6G5UsH8EyCGPBclE=;
        b=m4GavRBGIWY0wjiFRGa8/vwITbe/o3vMQMxuHsdlifyPigsCgX0vKGbdFmu9UgfF60
         nn6zqLhB9Oxgdogz9opwl9YoVSzwaLo0wAtr/+vyLGcBaVuVNtZxJcEz8ipmKGuZIdhx
         8HvA0RLYY7SdAeD4NQ06pA78+7aYjiLjwdM4ZE6Tj2qxCZUMWy9mOcMPY7aGzn9hd2op
         W3vUBAZDEc25YCCSquCuo9/FRYJLydPDwN+OqJwGsS7J5lXxl47z2etKgdKFOP+1LcBm
         tMn0qMuvBOG91H6M2zd5em9DVHm9Wm9OJ89zDzh8af2tMJcXxKwdS1IbtA9VebzG8DyC
         rHWA==
X-Gm-Message-State: AOAM531KhLe8ce36yveeRLI8Kaguz6LOXpAXijYbXGMj1AOUqJc4MGdB
        fU0WlXDva+uxTOzv5rScUCfjAvJdSp0XXgog8hvdhQ==
X-Google-Smtp-Source: ABdhPJwOPTX5trcDK3fnE5j1KylJQjqxL9bNX71uZKloGBWhRHQA8xA+zeQh1Ynbd9I628/FnTZxa/rbysY+VRcBD8Y=
X-Received: by 2002:a25:552:: with SMTP id 79mr28537708ybf.202.1634058076286;
 Tue, 12 Oct 2021 10:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com> <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com>
In-Reply-To: <26f9db1e-69e9-1a54-6d49-45c0c180067c@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Oct 2021 10:01:05 -0700
Message-ID: <CAJuCfpGTCM_Rf3GEyzpR5UOTfgGKTY0_rvAbGdtjbyabFhrRAw@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> > I'm still evaluating the proposal to use memfds but I'm not sure if
> > the issue that David Hildenbrand mentioned about additional memory
> > consumed in pagecache (which has to be addressed) is the only one we
> > will encounter with this approach. If anyone knows of any potential
> > issues with using memfds as named anonymous memory, I would really
> > appreciate your feedback before I go too far in that direction.
>
> [MAP_PRIVATE memfd only behave that way with 4k, not with huge pages, so
> I think it just has to be fixed. It doesn't make any sense to allocate a
> page for the pagecache ("populate the file") when accessing via a
> private mapping that's supposed to leave the file untouched]
>
> My gut feeling is if you really need a string as identifier, then try
> going with memfds. Yes, we might hit some road blocks to be sorted out,
> but it just logically makes sense to me: Files have names. These names
> exist before mapping and after mapping. They "name" the content.

I'm investigating this direction. I don't have much background with
memfds, so I'll need to digest the code first.

>
> Maybe it's just me, but the whole interface, setting the name via a
> prctl after the mapping was already instantiated doesn't really spark
> joy at my end. That's not a strong pushback, but if we can avoid it
> using something that's already there, that would be very much preferred.

Actually that's one of my worries about using memfds. There might be
cases when we need to name a vma after it was mapped. memfd_create()
would not allow us to do that AFAIKT. But I need to check all usages
to say if that's really an issue.
Thanks!

>
> --
> Thanks,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
