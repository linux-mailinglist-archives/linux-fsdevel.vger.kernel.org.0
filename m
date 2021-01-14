Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918CF2F58AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhANCwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 21:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbhANCwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:52:15 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20560C061794
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 18:51:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so2765366pgj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnXni1b9tGMKZsQyD1Z1Ra0F8lPxT5GkFopMevAsTu0=;
        b=pYQzB/dtAMuKglYrXj3uUgOV5H3ciR8TqPH6rKxps2HsuY0YD/UJTUTueQ924tV67x
         /nw9HW/y7yM+IdcquuDd6rg0qCOTGAyKdU4QdA3NnmK2VgnbP1SwW/2eIJr/f2z/KGg3
         bxaEmS+PxFNRC3IjXGCYARb+tqBpoGLgDEK08LhlF/nnflVP+RHfgNAXtArQ4karKE7V
         1TIbb8WdwuwY5l8k2HsX3cL+81dk1PaDAOTWANacxhnKOAW9UFbwmkA6bUQVA5Vjdo+A
         pyr2iP7Phr7B2FPaJRCikMvev+yUXrThxLpEMR9/Xve5A6Ks/H+mR80dJk1Nma2a+mlB
         shrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnXni1b9tGMKZsQyD1Z1Ra0F8lPxT5GkFopMevAsTu0=;
        b=RLcleYxQRIkH/LSaR6DaC+hntHnOWn4P4DfbcZvQfED70gZZ3kay4v+oHZMuO6AmXY
         0bTC3fFLRF28KhuFCTVyGIs303Qo0wzYdtiSfK8ETwblSGdzOZ3aAAqSRucoG/Xw6Xx7
         qZMuPAM76Lj5KNbDweH903UMuNd4Em+7/cGEj3vVUSDx8L3ML1ofAE44I84gH44idEgv
         ZZJGep7oAao2b8UL82urf/aY80O0mfBfoaY/jDhnEp2qfvBMXZN4lkG7VxoiOvLHdJRn
         WZCm4OorhKQDhYqCvso+vyL8l6mVHYjDJ9PtiaJr7vMoG9zKD1RKGPMo+B76DGW0qBEt
         SrcA==
X-Gm-Message-State: AOAM5329pvkXVzNj+yI0LIVWJOlu29zbUZg7fhmnzqFztFbt17G3L5zy
        QNvseqpqQ4OMMC6JCMsM7936zqNp19h5dTrDS3mM2w==
X-Google-Smtp-Source: ABdhPJwLV2qDiUvnfgyZ4ayaL3nSZneYZNcN8beH+tlzxWuA16IAcL/EsRR5kgOQtXyBkHSnxPqgyqr59MPA1D9rT60=
X-Received: by 2002:a63:480f:: with SMTP id v15mr5111575pga.341.1610592688709;
 Wed, 13 Jan 2021 18:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-4-songmuchun@bytedance.com> <65b2103d-6198-3380-d36e-17dd774359bd@oracle.com>
In-Reply-To: <65b2103d-6198-3380-d36e-17dd774359bd@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 14 Jan 2021 10:50:51 +0800
Message-ID: <CAMZfGtXUx5y80f5JSgTnDdLUDouiKkWGy=b8R3OrNW8WCOr=hw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 03/13] mm: Introduce VM_WARN_ON_PAGE macro
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 6:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/6/21 6:19 AM, Muchun Song wrote:
> > Very similar to VM_WARN_ON_ONCE_PAGE and VM_BUG_ON_PAGE, add
> > VM_WARN_ON_PAGE macro.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/mmdebug.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> I was going to question the use/need for this macro in the following
> patch.  Looks like Oscar has already done that, and free_bootmem_page
> will now use VM_BUG_ON_PAGE.  So, this patch can be dropped.

In the previous version, Oscar suggested I use WARN_ON instead of
BUG_ON. But he realised we actually should use BUG_ON in this
version. So I will drop this in the next version. Thanks.

>
> --
> Mike Kravetz
