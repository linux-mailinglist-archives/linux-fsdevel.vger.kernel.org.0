Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8031073A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBEI5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 03:57:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:53656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBEI5R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:57:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52615AD37;
        Fri,  5 Feb 2021 08:56:36 +0000 (UTC)
Date:   Fri, 5 Feb 2021 09:56:33 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com
Subject: Re: [PATCH v14 6/8] mm: hugetlb: introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20210205085632.GC13848@linux>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-7-songmuchun@bytedance.com>
 <42c8272a-f170-b27e-af5e-a7cb7777a728@huawei.com>
 <20210205082211.GA13848@linux>
 <435f3c32-0694-7af4-9032-0653a28a6a99@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435f3c32-0694-7af4-9032-0653a28a6a99@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:39:26PM +0800, Miaohe Lin wrote:
> Hi:
> On 2021/2/5 16:22, Oscar Salvador wrote:
> > On Fri, Feb 05, 2021 at 03:29:43PM +0800, Miaohe Lin wrote:
> >>> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
> >>> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> >>
> >> Not a problem. Should we set h->nr_free_vmemmap_pages to 0 in 'else' case explicitly ?
> > 
> > No, hstate fields are already zeroed.
> 
> I know hstate fields are already zeroed. What I mean is should we set nr_free_vmemmap_pages
> to 0 _explicitly_ like nr_huge_pages and free_huge_pages in hugetlb_add_hstate() ?
> But this is really trival.

We do not anny more [1]

[1] https://patchwork.kernel.org/project/linux-mm/patch/20201119112141.6452-1-osalvador@suse.de/


-- 
Oscar Salvador
SUSE L3
