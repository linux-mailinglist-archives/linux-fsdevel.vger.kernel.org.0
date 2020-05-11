Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE231CDC55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgEKN6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:58:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730153AbgEKN6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:58:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDZnJP187294;
        Mon, 11 May 2020 09:57:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvye4ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:57:40 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04BDZvDJ188154;
        Mon, 11 May 2020 09:57:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvye4dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:57:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BDQIJl026532;
        Mon, 11 May 2020 13:57:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55cgv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 13:57:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04BDvXGV47579358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 13:57:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CD8A4055;
        Mon, 11 May 2020 13:57:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA810A4053;
        Mon, 11 May 2020 13:57:29 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.187])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 May 2020 13:57:29 +0000 (GMT)
Date:   Mon, 11 May 2020 16:57:27 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com,
        masahiroy@kernel.org, ardb@kernel.org, ndesaulniers@google.com,
        dima@golovin.in, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        rafael.j.wysocki@intel.com, dan.j.williams@intel.com,
        zhenzhong.duan@oracle.com, jroedel@suse.de, bhe@redhat.com,
        guro@fb.com, Thomas.Lendacky@amd.com,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        hannes@cmpxchg.org, minchan@kernel.org, mhocko@kernel.org,
        ying.huang@intel.com, yang.shi@linux.alibaba.com,
        gustavo@embeddedor.com, ziqian.lzq@antfin.com,
        vdavydov.dev@gmail.com, jason.zeng@intel.com, kevin.tian@intel.com,
        zhiyuan.lv@intel.com, lei.l.li@intel.com, paul.c.lai@intel.com,
        ashok.raj@intel.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC 14/43] mm: memblock: PKRAM: prevent memblock resize from
 clobbering preserved pages
Message-ID: <20200511135727.GA983798@linux.ibm.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-15-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588812129-8596-15-git-send-email-anthony.yznaga@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_06:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=5
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 05:41:40PM -0700, Anthony Yznaga wrote:
> The size of the memblock reserved array may be increased while preserved
> pages are being reserved. When this happens, preserved pages that have
> not yet been reserved are at risk for being clobbered when space for a
> larger array is allocated.
> When called from memblock_double_array(), a wrapper around
> memblock_find_in_range() walks the preserved pages pagetable to find
> sufficiently sized ranges without preserved pages and passes them to
> memblock_find_in_range().

I'd suggest to create an array of memblock_region's that will contain
the PKRAM ranges before kexec and pass this array to the new kernel.
Then, somewhere in start_kerenel() replace replace
memblock.reserved->regions with that array. 

> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/pkram.h |  3 +++
>  mm/memblock.c         | 15 +++++++++++++--
>  mm/pkram.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pkram.h b/include/linux/pkram.h
> index edc5d8bef9d3..409022e1472f 100644
> --- a/include/linux/pkram.h
> +++ b/include/linux/pkram.h
> @@ -62,6 +62,9 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
>  ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
>  size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
>  
> +phys_addr_t pkram_memblock_find_in_range(phys_addr_t start, phys_addr_t end,
> +					 phys_addr_t size, phys_addr_t align);
> +
>  #ifdef CONFIG_PKRAM
>  extern unsigned long pkram_reserved_pages;
>  void pkram_reserve(void);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c79ba6f9920c..69ae883b8d21 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -16,6 +16,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> +#include <linux/pkram.h>
>  
>  #include <asm/sections.h>
>  #include <linux/io.h>
> @@ -349,6 +350,16 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
>  	return ret;
>  }
>  
> +phys_addr_t __init_memblock __memblock_find_in_range(phys_addr_t start,
> +					phys_addr_t end, phys_addr_t size,
> +					phys_addr_t align)
> +{
> +	if (IS_ENABLED(CONFIG_PKRAM))
> +		return pkram_memblock_find_in_range(start, end, size, align);
> +	else
> +		return memblock_find_in_range(start, end, size, align);
> +}
> +
>  static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
>  {
>  	type->total_size -= type->regions[r].size;
> @@ -447,11 +458,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  		if (type != &memblock.reserved)
>  			new_area_start = new_area_size = 0;
>  
> -		addr = memblock_find_in_range(new_area_start + new_area_size,
> +		addr = __memblock_find_in_range(new_area_start + new_area_size,
>  						memblock.current_limit,
>  						new_alloc_size, PAGE_SIZE);
>  		if (!addr && new_area_size)
> -			addr = memblock_find_in_range(0,
> +			addr = __memblock_find_in_range(0,
>  				min(new_area_start, memblock.current_limit),
>  				new_alloc_size, PAGE_SIZE);
>  
> diff --git a/mm/pkram.c b/mm/pkram.c
> index dd3c89614010..e49c9bcd3854 100644
> --- a/mm/pkram.c
> +++ b/mm/pkram.c
> @@ -1238,3 +1238,54 @@ void pkram_free_pgt(void)
>  	__free_pages_core(virt_to_page(pkram_pgd), 0);
>  	pkram_pgd = NULL;
>  }
> +
> +static int __init_memblock pkram_memblock_find_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
> +{
> +	unsigned long end = base + size;
> +	unsigned long addr;
> +
> +	if (size < st->min_size)
> +		return 0;
> +
> +	addr =  memblock_find_in_range(base, end, st->min_size, PAGE_SIZE);
> +	if (!addr)
> +		return 0;
> +
> +	st->retval = addr;
> +	return 1;
> +}
> +
> +/*
> + * It may be necessary to allocate a larger reserved memblock array
> + * while populating it with ranges of preserved pages.  To avoid
> + * trampling preserved pages that have not yet been added to the
> + * memblock reserved list this function implements a wrapper around
> + * memblock_find_in_range() that restricts searches to subranges
> + * that do not contain preserved pages.
> + */
> +phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
> +					phys_addr_t end, phys_addr_t size,
> +					phys_addr_t align)
> +{
> +	struct pkram_pg_state st = {
> +		.range_cb = pkram_memblock_find_cb,
> +		.min_addr = start,
> +		.max_addr = end,
> +		.min_size = PAGE_ALIGN(size),
> +		.find_holes = true,
> +	};
> +
> +	if (!pkram_reservation_in_progress)
> +		return memblock_find_in_range(start, end, size, align);
> +
> +	if (!pkram_pgd) {
> +		WARN_ONCE(1, "No preserved pages pagetable\n");
> +		return memblock_find_in_range(start, end, size, align);
> +	}
> +
> +	WARN_ONCE(memblock_bottom_up(), "PKRAM: bottom up memblock allocation not yet supported\n");
> +
> +	pkram_walk_pgt_rev(&st, pkram_pgd);
> +
> +	return st.retval;
> +}
> -- 
> 2.13.3
> 

-- 
Sincerely yours,
Mike.
