Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C742C010C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKWICl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgKWICk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:02:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B2CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 00:02:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so14196410pfu.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 00:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjW5kf1b1Fcrz9tIggA1cpzx5YJFFwp+TEs9UtQIZsw=;
        b=PsvMXAcoEQ4hU0UZyLqO+PoN3PXrPBxWC79QMPfmg/GeikUA+SP8/ijNRw21dSTXiJ
         xNPNUGCNDUPwI6ifrInTqzcWJKex5iemykaV2fHR+J5/zcJTfvCdDZCgfwNA4YMJg1k0
         pnW3LHjw4DSuK+4v91P6GJ270fMdQtRMW5csIIxjxrv0croy/8qu2J0TkgMk3qbqE4O+
         Urs14aeqs+PCcTeQPCDHwqqTnM9TUgBa+NlQongfRf9g7OD17aGWB8RxYwznDsxCxu5Z
         UJqU6o2Q7MvZRsBqPFfMaRzBB8oji3PoIckEUKR84XfDUAyhPSjqi4OR+g4Hd6uwP5B0
         Yg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjW5kf1b1Fcrz9tIggA1cpzx5YJFFwp+TEs9UtQIZsw=;
        b=tdynt0yAPzuauo0FhcmmnS36GJLbcauv9io4q/h+soQtplPpHX4MU206qI2jVuue+E
         rjI9wQUaua0tEoXdTOx3IWEQKl3SaysgIpasP62M5huBptBggwJht1Z6fsbbMxUkMM01
         +hO84YATPKFnS7fqqTlzW6w8YvOwYJWCRDDnvlQMBzI3fk1K19ABOJVaZ5YB/Q1QcA2F
         L7UV5zvhQe9HIL2rh3B8SmCHSYTz7P7TZSRe9AP3EtNhe74K4QrqkHm6ubZrdjew6PT6
         TX+RaxXU79e3mZvO2sHJQYyb29Hzb2W1NP7sI2mTvrlGhlJyeaBSrhfVtmS2yMCp+GjE
         ivbg==
X-Gm-Message-State: AOAM533YVpgSxvXUfmhPPliP6jXP/diwisrIem3HS/T0l0XN3Pljga+Y
        uxnYyItv8OxySbFZIK+5UFzuK2dksGRjxrYue8a2sg==
X-Google-Smtp-Source: ABdhPJz4q3i27WpndCtivA4jdkLBmsJFiWT7v+RK+RF8zB1bKuJ/sddH4D73BQja9ZIobFqLizBVKi+BNz073q7oDn8=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr23947117pfi.49.1606118559844; Mon, 23
 Nov 2020 00:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-14-songmuchun@bytedance.com> <20201120081638.GD3200@dhcp22.suse.cz>
 <CAMZfGtX3DUJggAzz_06Z2atHPknkCir6a49a983TsWOHt5ZQUQ@mail.gmail.com> <20201123074804.GC27488@dhcp22.suse.cz>
In-Reply-To: <20201123074804.GC27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 16:01:59 +0800
Message-ID: <CAMZfGtVvubZLuzYDC3x605jSSFO+JTk4xU0BVMwxmo26tOdHBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 13/21] mm/hugetlb: Use PG_slab to
 indicate split pmd
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 3:48 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 17:30:27, Muchun Song wrote:
> > On Fri, Nov 20, 2020 at 4:16 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-11-20 14:43:17, Muchun Song wrote:
> > > > When we allocate hugetlb page from buddy, we may need split huge pmd
> > > > to pte. When we free the hugetlb page, we can merge pte to pmd. So
> > > > we need to distinguish whether the previous pmd has been split. The
> > > > page table is not allocated from slab. So we can reuse the PG_slab
> > > > to indicate that the pmd has been split.
> > >
> > > PageSlab is used outside of the slab allocator proper and that code
> > > might get confused by this AFAICS.
> >
> > I got your concerns. Maybe we can use PG_private instead of the
> > PG_slab.
>
> Reusing a page flag arbitrarily is not that easy. Hugetlb pages have a
> lot of spare room in struct page so I would rather use something else.

This page is the PMD page table of vmemmap, not the vmemmap page
of HugeTLB. And the page table does not use PG_private. Maybe it is
enough. Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
