Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1857F3106EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBEIki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 03:40:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12468 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBEIkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:40:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DX82K3nNlzjKnQ;
        Fri,  5 Feb 2021 16:38:17 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 16:39:27 +0800
Subject: Re: [PATCH v14 6/8] mm: hugetlb: introduce nr_free_vmemmap_pages in
 the struct hstate
To:     Oscar Salvador <osalvador@suse.de>
CC:     Muchun Song <songmuchun@bytedance.com>,
        <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-7-songmuchun@bytedance.com>
 <42c8272a-f170-b27e-af5e-a7cb7777a728@huawei.com>
 <20210205082211.GA13848@linux>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <435f3c32-0694-7af4-9032-0653a28a6a99@huawei.com>
Date:   Fri, 5 Feb 2021 16:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205082211.GA13848@linux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/2/5 16:22, Oscar Salvador wrote:
> On Fri, Feb 05, 2021 at 03:29:43PM +0800, Miaohe Lin wrote:
>>> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
>>> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
>>
>> Not a problem. Should we set h->nr_free_vmemmap_pages to 0 in 'else' case explicitly ?
> 
> No, hstate fields are already zeroed.

I know hstate fields are already zeroed. What I mean is should we set nr_free_vmemmap_pages
to 0 _explicitly_ like nr_huge_pages and free_huge_pages in hugetlb_add_hstate() ?
But this is really trival.

Many thanks for reply.

> 
> 

