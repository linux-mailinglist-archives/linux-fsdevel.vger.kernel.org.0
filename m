Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79429FBEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 04:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJ3C7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgJ3C7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07DC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so3984484pgk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PacvAjHwgz1W/0KZrRopBKHXPnOrWBvk3OdH8B4Ar6U=;
        b=Fw4m2smg/K/alu/8ExRJ3g4CTjiomNaZ4C8ynioPCJc+br9KXpGqY+GKjYbAah8E52
         erQS1Tae/ldrTjhlKTBJZmsZndAUYE2E0n5K4B8tKYf1MUrhAX7r7NwCdH4IKioXV56Y
         O4iHIIq1iGaWl3WBnmK6K1AYWSmsZEky22+vDhbjun63JOCwgR2LBsN/RaY9rgoZVZg8
         xL5tsKE+/dBOVWPTThOwSotcFMPcRKrPh4XZNxIZrCooREKYdTr8A8/H3TQKK++i8QTR
         zZ5h2mMmwD7vmyJLwiSJJcmqpAjoNYpn8aINi+o2rw6547qX7kmULFPjPOX/2TWYk3Ra
         oG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PacvAjHwgz1W/0KZrRopBKHXPnOrWBvk3OdH8B4Ar6U=;
        b=BuQOWz4NK3sk47KT7sAl3dGLWBGH/TvIfYu1iBFNTtSfBBDr97tOHQdcJP4AYbT+ZM
         BceK2MeflRFHGD8btV5vAQtDqu79+MH5I4CWt1u04t6ZEhXsAFywSPz1dV1MgPE4vn47
         6+hNHqkAR5WlTH+ayckwdjAPXYM3JTIfUl0wEL157cK0X026U77sPjE8sPoUM6TQaPZK
         LYkzfocCMfRQe8bwUX5+b+Qe3FI7VA5K5DV9Uw/ZgsOPOKzC4hbfncaOn962acTYdkri
         vcBM5u+YqaZPFG1f6pIwr2u/WawJi2L/y7rzYFifgUWXIHTI8m3fIzrkzC8qUZuXYdII
         Om2g==
X-Gm-Message-State: AOAM533HDXNg9fI5in6lVy2EXB+wV0/lCYoprzZNm7fsOeSixhMtW604
        2ToEp6JLeZODohdJ79KiNeS57KYktbgCpX6vsn67VA==
X-Google-Smtp-Source: ABdhPJxei/552yatkJNpugavx1a8LhPgVhlouDAUvQRrA7YwMCj73kV355oTLvUbOYPCrAsiA+OaoL7mkx2lvCx/5JM=
X-Received: by 2002:aa7:9095:0:b029:164:75c4:5d15 with SMTP id
 i21-20020aa790950000b029016475c45d15mr7331085pfa.49.1604026776404; Thu, 29
 Oct 2020 19:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-8-songmuchun@bytedance.com> <8658f431-56c4-9774-861a-9c3b54d1910a@oracle.com>
 <CAMZfGtUUkkkeENXOOLPacverqyudxntTenMKrtpfHnLOBJaX5Q@mail.gmail.com> <21ea37f2-38ca-ce5f-6039-0ee388092f1d@oracle.com>
In-Reply-To: <21ea37f2-38ca-ce5f-6039-0ee388092f1d@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Oct 2020 10:58:59 +0800
Message-ID: <CAMZfGtUcknh5Atms=JGWnM-mNodW6n3PV=8TgA865zMZZK-ZpQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 6:00 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/28/20 11:13 PM, Muchun Song wrote:
> > On Thu, Oct 29, 2020 at 7:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 10/26/20 7:51 AM, Muchun Song wrote:
> >>> +
> >>> +static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
> >>> +{
> >>> +     static DEFINE_SPINLOCK(pgtable_lock);
> >>> +
> >>> +     return &pgtable_lock;
> >>> +}
> >>
> >> This is just a global lock.  Correct?  And hugetlb specific?
> >
> > Yes, it is a global lock. Originally, I wanted to use the pmd lock(e.g.
> > pmd_lockptr()). But we need to allocate memory for the spinlock and
> > initialize it when ALLOC_SPLIT_PTLOCKS. It may increase the
> > complexity.
> >
> > And I think that here alloc/free hugetlb pages is not a frequent operation.
> > So I finally use a global lock. Maybe it is enough.
> >
> >>
> >> It should be OK as the page table entries for huegtlb pages will not
> >> overlap with other entries.
> >
> > Does "hugetlb specific" mean the pmd lock? or per hugetlb lock?
> > If it is pmd lock, this is fine to me. If not, it may not be enough.
> > Because the lock also guards the splitting of pmd pgtable.
>
> By "hugetlb specific", I was trying to say that only hugetlb code would
> use this lock.  It is not a concern now.  However, there has been talk
> about other code doing something similar to remove struct pages.  If that
> ever happens then we will need a different locking scheme.

Agreed, It is not a concern now :)

>
> Disregard my statement about there being no overlap.  I was confusing
> page tables for huge pages with page tables for mappings mmap entries
> of huge pages.
> --
> Mike Kravetz



-- 
Yours,
Muchun
