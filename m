Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4C2C2352
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbgKXKyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 05:54:02 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2503 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbgKXKyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:54:01 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CgLVC6nDmzQjFt;
        Tue, 24 Nov 2020 18:53:39 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 24 Nov 2020 18:53:56 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 24 Nov 2020 18:53:56 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 24 Nov 2020 18:53:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v6 14/16] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Thread-Topic: [PATCH v6 14/16] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Thread-Index: AQHWwkh5Ms2jMqVne0ipo7HFEJnHCanXGbPg
Date:   Tue, 24 Nov 2020 10:53:56 +0000
Message-ID: <5f6443f10292405d813ffb444ef315fc@hisilicon.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-15-songmuchun@bytedance.com>
In-Reply-To: <20201124095259.58755-15-songmuchun@bytedance.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Muchun Song [mailto:songmuchun@bytedance.com]
> Sent: Tuesday, November 24, 2020 10:53 PM
> To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> willy@infradead.org; osalvador@suse.de; mhocko@suse.com; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org; Muchun Song <songmuchun@bytedance.com>
> Subject: [PATCH v6 14/16] mm/hugetlb: Add a kernel parameter
> hugetlb_free_vmemmap
> 
> Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  mm/hugetlb_vmemmap.c                            | 19
> ++++++++++++++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 5debfe238027..d28c3acde965 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1551,6 +1551,15 @@
>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>  			Format: size[KMG]
> 
> +	hugetlb_free_vmemmap=
> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> +			this controls freeing unused vmemmap pages associated
> +			with each HugeTLB page.
> +			Format: { on | off (default) }
> +
> +			on:  enable the feature
> +			off: disable the feature
> +

We've a parameter here. but wouldn't it be applied to "x86/mm/64/:disable
Pmd page mapping of vmemmap" as well?
If (hugetlb_free_vmemmap_enabled)
	Do Basepage mapping?

>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: 0 | 1
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst
> b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..6a8b57f6d3b7 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -145,6 +145,9 @@ default_hugepagesz
> 
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
> +hugetlb_free_vmemmap
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables
> freeing
> +	unused vmemmap pages associated each HugeTLB page.
> 
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 509ca451e232..b2222f8d1245 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -131,6 +131,22 @@ typedef void (*vmemmap_pte_remap_func_t)(struct
> page *reuse, pte_t *ptep,
>  					 unsigned long start, unsigned long end,
>  					 void *priv);
> 
> +static bool hugetlb_free_vmemmap_enabled __initdata;
> +
> +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!strcmp(buf, "on"))
> +		hugetlb_free_vmemmap_enabled = true;
> +	else if (strcmp(buf, "off"))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("hugetlb_free_vmemmap",
> early_hugetlb_free_vmemmap_param);
> +
>  static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
>  {
>  	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
> @@ -322,7 +338,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int order = huge_page_order(h);
>  	unsigned int vmemmap_pages;
> 
> -	if (!is_power_of_2(sizeof(struct page))) {
> +	if (!is_power_of_2(sizeof(struct page)) ||
> +	    !hugetlb_free_vmemmap_enabled) {
>  		pr_info("disable freeing vmemmap pages for %s\n", h->name);
>  		return;
>  	}
> --
> 2.11.0

Thanks
Barry

