Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA42CE387
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbgLDAC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 3 Dec 2020 19:02:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2391 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbgLDAC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:02:26 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CnCXf671Nz50N9;
        Fri,  4 Dec 2020 08:01:06 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 08:01:41 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 4 Dec 2020 08:01:41 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 4 Dec 2020 08:01:41 +0800
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
Subject: RE: [PATCH v7 13/15] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Thread-Topic: [PATCH v7 13/15] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Thread-Index: AQHWxyyEW8/tZjAAjUGQxE1fk3rBGKnmEXCA
Date:   Fri, 4 Dec 2020 00:01:41 +0000
Message-ID: <a6cd4183b9bf4e72b649a271b4843f89@hisilicon.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-14-songmuchun@bytedance.com>
In-Reply-To: <20201130151838.11208-14-songmuchun@bytedance.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Muchun Song [mailto:songmuchun@bytedance.com]
> Sent: Tuesday, December 1, 2020 4:19 AM
> To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> willy@infradead.org; osalvador@suse.de; mhocko@suse.com; Song Bao Hua (Barry
> Song) <song.bao.hua@hisilicon.com>
> Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org; Muchun Song <songmuchun@bytedance.com>
> Subject: [PATCH v7 13/15] mm/hugetlb: Add a kernel parameter
> hugetlb_free_vmemmap
> 
> Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>


Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  arch/x86/mm/init_64.c                           |  5 +++--
>  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
>  mm/hugetlb_vmemmap.c                            | 18 +++++++++++++++++-
>  5 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 3ae25630a223..9e6854f21d55 100644
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
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
> +	unused vmemmap pages associated each HugeTLB page.
> 
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 155cb06a6961..fcdc020904a8 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -34,6 +34,7 @@
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/hugetlb.h>
> 
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -1557,7 +1558,7 @@ int __meminit vmemmap_populate(unsigned long start,
> unsigned long end, int node,
>  {
>  	int err;
> 
> -	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP))
> +	if (is_hugetlb_free_vmemmap_enabled())
>  		err = vmemmap_populate_basepages(start, end, node, NULL);
>  	else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>  		err = vmemmap_populate_basepages(start, end, node, NULL);
> @@ -1613,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long
> section_nr,
>  		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
> 
>  		if (!boot_cpu_has(X86_FEATURE_PSE) ||
> -		    IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)) {
> +		    is_hugetlb_free_vmemmap_enabled()) {
>  			next = (addr + PAGE_SIZE) & PAGE_MASK;
>  			pmd = pmd_offset(pud, addr);
>  			if (pmd_none(*pmd))
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 4efeccb7192c..66d82ae7b712 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -773,6 +773,20 @@ static inline void huge_ptep_modify_prot_commit(struct
> vm_area_struct *vma,
>  }
>  #endif
> 
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +extern bool hugetlb_free_vmemmap_enabled;
> +
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return hugetlb_free_vmemmap_enabled;
> +}
> +#else
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
> 
> @@ -926,6 +940,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct
> *mm, unsigned long addr
>  					pte_t *ptep, pte_t pte, unsigned long sz)
>  {
>  }
> +
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
> 
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a3714db7f400..ebc710d148e4 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -131,6 +131,21 @@ typedef void (*vmemmap_remap_pte_func_t)(struct page
> *reuse, pte_t *pte,
>  					 unsigned long start, unsigned long end,
>  					 void *priv);
> 
> +bool hugetlb_free_vmemmap_enabled;
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
> +early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> 
>  static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
>  {
> @@ -325,7 +340,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int nr_pages = pages_per_huge_page(h);
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

