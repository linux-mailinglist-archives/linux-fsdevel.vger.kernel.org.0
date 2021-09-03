Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7140028B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349740AbhICPsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbhICPsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:48:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595FC061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 08:47:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q70so10834627ybg.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcsX+WQqGl9KNNQFgUorP3/DXavYbjwi6W8uES8Z6Yc=;
        b=fh3aCGTgSa8/XdbS5LEG5NIXkO3KXwLBGTSz3uzN6DPy42JLMT4eRa3oKUdPc1rnha
         +nrhtZj/7HLMwfltItRvqCqdA794UMNpaDTxEO50v/5edYG7PwLIRBRwhr5J+BLcS4kU
         UCeQ1dBsEccaEsfiMltxByci6qP5et9koKMQiM/1pfqTiKclOuQpqI3on8ky+c+7a/zf
         kNcP0c1uCMmrMEvKq6F/tWFNGfJeXJvQ/vBVNmYOvMCyPZJAlhMMtnGtlUrjvYmDCQQK
         AQqoGGH3yY6kgyqApN2Odyj38lK1WckbyLOE1mY8Vqrk4TxhiA9CDIHKbg0SIdJ5bhgm
         o4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcsX+WQqGl9KNNQFgUorP3/DXavYbjwi6W8uES8Z6Yc=;
        b=c7ek7p63pQ7FmTyx45zJZJTUHCmi+uD9xjuWhAZpRl8/Nm5rSnzabUesvEVuC62o6i
         gk00BZSKEBjd82n8lCQpiSQ4SHswzPNgocrHOz3gcAWXn4VUVvjvkPLDPpjPML/Qiryu
         OiS3JuX369Ybc8ZZwjckFiy0vm8H73UIjxLlB4IeD/BeTtc/U2pYQoFiIrhtbAXyOxev
         uI99DHXXCd4rrWSOuogC2kvC0SvokhT1ic98sRL+JcBy5R6IUoI0CRZZ8cODicEjFg+W
         RCm5Evm2KU11iUjFKGcLicw8kZiv8r1j3npwGU2MXF7bqy3V6Ezx0XN25c9SgTELKXU/
         3fXw==
X-Gm-Message-State: AOAM532tWmecZ3+uS4xcOdsrfog50lCKOlSw6ft1BHyy2RJKgiEffZUy
        Qp7M7U+EaScgohwgAg/EdF3yLpqRB5UPO+Hzq3Nqnw==
X-Google-Smtp-Source: ABdhPJxTLm1wDIXmjlPSCgNPzJsS++bAZ0JdreBU5JSJan5+c2yQQY68ByO+9PDYJ8gHLxXb0SfoaueztDJCOwWAt/0=
X-Received: by 2002:a25:b9c8:: with SMTP id y8mr5789752ybj.487.1630684032948;
 Fri, 03 Sep 2021 08:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-3-surenb@google.com>
 <YS81abHD8KZMrX8D@dhcp22.suse.cz> <CAJuCfpHWCtqCcuZdyfc4-virtynOMv2f_iU=OJUB_6b2Xz+k9g@mail.gmail.com>
 <YTILrVHLMBky9YjP@dhcp22.suse.cz>
In-Reply-To: <YTILrVHLMBky9YjP@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 3 Sep 2021 08:47:01 -0700
Message-ID: <CAJuCfpHCo6c8CvLG6ZN0vO3uF1U5hLh6oYoPrTnQha_=yT7bHA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
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

On Fri, Sep 3, 2021 at 4:49 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 01-09-21 08:42:29, Suren Baghdasaryan wrote:
> > On Wed, Sep 1, 2021 at 1:10 AM 'Michal Hocko' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > On Fri 27-08-21 12:18:57, Suren Baghdasaryan wrote:
> > > [...]
> > > > +static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> > > > +{
> > > > +     if (!name) {
> > > > +             free_vma_anon_name(vma);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (vma->anon_name) {
> > > > +             /* Should never happen, to dup use dup_vma_anon_name() */
> > > > +             WARN_ON(vma->anon_name == name);
> > >
> > > What is the point of this warning?
> >
> > I wanted to make sure replace_vma_anon_name() is not used from inside
> > vm_area_dup() or some similar place (does not exist today but maybe in
> > the future) where "new" vma is a copy of "orig" vma and
> > new->anon_name==orig->anon_name. If someone by mistake calls
> > replace_vma_anon_name(new, orig->anon_name) and
> > new->anon_name==orig->anon_name then they will keep pointing to the
> > same name pointer, which breaks an assumption that ->anon_name
> > pointers are not shared among vmas even if the string is the same.
> > That would eventually lead to use-after-free error. After the next
> > patch implementing refcounting, the similar situation would lead to
> > both new and orig vma pointing to the same anon_vma_name structure
> > without raising the refcount, which would also lead to use-after-free
> > error. That's why the above comment asks to use dup_vma_anon_name() if
> > this warning ever happens.
> > I can remove the warning but I thought the problem is subtle enough to
> > put some safeguards.
>
> This to me sounds very much like a debugging code that shouldn't make it
> to the final patch to be merged. I do see your point of an early
> diagnostic but we are talking about an internal MM code and that is not
> really designed to be robust against its own failures so I do not see
> why this should be any special.

Fair enough. I posted v9 yesterday but will respin another version in
a couple days. Will remove the warning then.
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
