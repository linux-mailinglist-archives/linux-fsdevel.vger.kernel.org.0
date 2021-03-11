Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A09337345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 14:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhCKNA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 08:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhCKNAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:00:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2688C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 05:00:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t85so9160232pfc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICClhXTxVfeDP5mVm1fYPC9myvROzb0Cj0NknzNNdKs=;
        b=FNWkqzAOnObAD9/0sUTGtXYMiNmrmS8FJP++ikoDpY2J5iqbCSDXmEDaZHkPYz3FXL
         /3sUWNHTxqVd5BmYP7/gMMHemNaYCOzzjhMY3Y3/cy5denRGwPb6GXyBN+mTXKpbPJ63
         d1QZ9NojXcrEpGmXU+F8r9B90LJtBHRBqKqjYO+CBZjGNeUj0SZv6y2XGals1rh/QGpJ
         rRnhDR8bevFcuRXA8sM/7nxYwhMkjPWFiEHD6DDlo+DIMXqP5UYYyF7RvhuntNeX0uV7
         +lbw12eHhpCMdlJ4OfITM2qsSCGj8Nia4SGTMhaUsWxOKnXitSkW05QekiAa/VwUb9zN
         zakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICClhXTxVfeDP5mVm1fYPC9myvROzb0Cj0NknzNNdKs=;
        b=VoNeCMaQJdaK+tzJFTk359JOsSlkp3NbZ1v225WzrqjZrHjpquZtGoMlw6OA9KP91d
         pgCy1lsZ3xTuiq/lJm8IJVo0NuRulIJKLfrl35+XWYu//uTYn/Mccvveei0zUo7bB+Na
         Z1Z63hENxjLydHAkxA2ZEUcOiNIbLREqO/CPAwAkBarNFf7Ow3FpevAh2jGlrFaudrB/
         UptODDk53Z5hcdkWI9jWuiFmTjVSmXKVj+4VAVR2e6NtQGqHH4zYTefy+hBa56eQOaL0
         9WwjABHkwwzN/qIQBKDVDX9ywpZi/E87O7YPxoE7KIaEtNva+zv1mt5glCL/FLDiRsSE
         z4Sg==
X-Gm-Message-State: AOAM531Mn5PG0d6VUKwLQj8eodCxSetRtv5q/Dbog62K9SsHX0HbNFSr
        zFqJi8Na/p2aMIP/ik9mB3/AZdjz8VNp3tMQDc6jrw==
X-Google-Smtp-Source: ABdhPJxyzvuPcaF1NhUhc4M3D6E0KoDRfcfVCFt8gZR+bL7CluOq6WyYxviIqRjhulE609IOhIf8Gf0BgyaPXq/cOKA=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr7614145pfq.59.1615467638784; Thu, 11
 Mar 2021 05:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com> <YEjoozshsvKeMAAu@dhcp22.suse.cz>
 <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
 <YEnbBPviwU6N2RzK@dhcp22.suse.cz> <CAMZfGtW5uHYiA_1an3W-jEmemsoN3Org7JwieeE2V271wh9X-A@mail.gmail.com>
 <YEnlRlLJD1bK/Dup@dhcp22.suse.cz> <CAMZfGtX3pUmPOY1ieVQubnBKHZoOxfp-ARsPigYZpc=-UiiNjg@mail.gmail.com>
 <YEoKJYzP8//qVebC@dhcp22.suse.cz>
In-Reply-To: <YEoKJYzP8//qVebC@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 21:00:01 +0800
Message-ID: <CAMZfGtXOT0rjcS3UUBQ2_UC7nD7yuP1eGwbiV+KjjhN4icU4fw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 9/9] mm: hugetlb: optimize the code
 with the help of the compiler
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 8:16 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 11-03-21 18:00:09, Muchun Song wrote:
> [...]
> > Sorry. I am confused why you disagree with this change.
> > It does not bring any disadvantages.
>
> Because it is adding a code which is not really necessary and which will
> have to be maintained. Think of future changes which would need to grow
> more of these. Hugetlb code paths shouldn't really think about size of
> the struct page.

Got it. I will drop this patch.

> --
> Michal Hocko
> SUSE Labs
