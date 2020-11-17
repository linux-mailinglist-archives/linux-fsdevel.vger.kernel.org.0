Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0F2B6ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 20:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgKQTiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 14:38:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46616 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbgKQTiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:38:09 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHJXeBY024599;
        Tue, 17 Nov 2020 11:34:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uatSQMSi5cWdaUPa4qWJsPwJT50JMEV62M/bUPP1wEI=;
 b=JRY0ZN05WZf7mPMAdeYXCjPTTcOTl8tzvwFFkLmY+mEcuUIohSNEKrmZTyZkuWt3XI0C
 HP8oqTmFi9fOBHcHZ0QZk0/L60UK1I72vJ9dgh4xqEV7wDn58suQCAFpac16sRO7Ah0W
 knASkwHELitiook6Px+LN9HOVH/duyNqtXs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34uwyg762e-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Nov 2020 11:34:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 17 Nov 2020 11:34:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSz5h9ONphWKXIm+CNVcATKGcFegHyvoXYOI6mSNJ8OzBFvCVHOp2hEtfBWr0CuGcnrlUxXxICw+wucuipaQvNyeI/C0fR4prpwWkMH+4YN5F9oIY1m5GrZmWxLTzgVeJkaG5W7INlZvlGV1TFiiz+i+K0WplBUny/oYFVUHd4gi4WLAgxEJNkxgGs434/3JW+lePnWooSAraGdIm31wcrwKKIxGmVh97MJ2insX4E1vD9blrbfT5ir/d2yOYZYqDPC3elyPN4k/wpGE992vMnGLWGpLmtC8gX+tk4x9+SHSK7o+xbc87xiYGjtKgVENLbEd7NQQwYb53yImmeG8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uatSQMSi5cWdaUPa4qWJsPwJT50JMEV62M/bUPP1wEI=;
 b=cy/QBWnYIWJfw/p/1Ypq8LHzWQstqYVpnOblz5TpoOPAmr6gKxeU7sK/yxgXVzPX3wXa14AXpgOE9F3XRqtZ2bxCtIhGufZh67yzdejt9nmt0C6M+nS6WtakHVBeq4vsfgAdsKk3tzckYNTZEQnj4pIqEc5imfAj2Hv3MWCtBzx4TmVOSPTGL882CImQ69PvQJJUpMhKsIYRh0GGKFen5u8p7DLW5r0WHHZolvxi2a8y0KO8xqQ91aEC+i9+QCJfMriiAbYWxm40LtHgEGCWC4VeIZgXHlVsMpqaZlu/mfLP8cHQdpyx2fviUSi/iFAvDbxZWry1/mkCarG5m+q2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uatSQMSi5cWdaUPa4qWJsPwJT50JMEV62M/bUPP1wEI=;
 b=bkPZrEqDH9pvV0Urx/h9aKjdbBXG7iTHNShqjEM8kOobrYc61Vw8Akp9ie/bzOWqcnRzxZBco7VQcYHtNoNRKFg4LvCGW13bFuQLnBx78db1FBttZnWtYZM9PVw9QYtpEdJUyWAJ4eloPGHk8XDBl1jeeUrOF04fOyhfMY90ADM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2213.namprd15.prod.outlook.com (2603:10b6:a02:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Tue, 17 Nov
 2020 19:34:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.031; Tue, 17 Nov 2020
 19:34:05 +0000
Date:   Tue, 17 Nov 2020 11:33:58 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-riscv@lists.infradead.org>,
        <x86@kernel.org>
Subject: Re: [PATCH v9 6/9] secretmem: add memcg accounting
Message-ID: <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
References: <20201117162932.13649-1-rppt@kernel.org>
 <20201117162932.13649-7-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117162932.13649-7-rppt@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:4f92]
X-ClientProxiedBy: CO2PR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:104:3::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4f92) by CO2PR06CA0066.namprd06.prod.outlook.com (2603:10b6:104:3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 17 Nov 2020 19:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a313af32-277e-40f9-8483-08d88b2fbeb5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2213:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2213B05A94882FB7EF6EB694BEE20@BYAPR15MB2213.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzeG4mE9RNRRLfeOVH5Wnhj3Ffgt12GeAyAxOgUN4tgPX6YvLI1o9+XVQx18jmaOXpcP+N9PfdekP1et6rQB64rCWbBvkzF6lSB7L5GhjD7ZgnW8cBZB1X866bM3mYvr64RXBAccwymQ4hke6QYValF3yyKvNlbD7iEzdo21BSR8FVznZYNebtKURhk7b/Syoz4evuMcJR9fruuUoLV2WzrkkBjNl9Q1QO4pJnTEFmGWMuMwSnHqrWjnxuqw2/vAT/T/xJ9dj++RuaLmCyjWchh3trU5qFr8MB3wM6z2nbNf/QRioMt/ALgODTYANEDerz/voegKibR5/nbpV0nM1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(9686003)(4326008)(52116002)(2906002)(66476007)(6506007)(478600001)(16526019)(66556008)(8936002)(1076003)(6916009)(33656002)(66946007)(55016002)(5660300002)(186003)(7696005)(83380400001)(15650500001)(316002)(86362001)(7416002)(6666004)(7406005)(54906003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: w300MdiX2CI1saMYk2y1yHiHExycD1PAAW4IiMn4+M3ks9jfGhqdtnTPETfVBJmZ8Wn1kPx2GnWE7D3eHtHGNEy2SMsEzoFzU2JVl538Rl474+gV3dS/h1m6LCSNkx87x/ucMTHq6rc9YUbTNUiI4y+WavPVSESCBfUFOf6gY61bYpUrzR9FRAV5X0rHiLqcji4UCAgbXMpIRd1kntd5sIrCIJCUnV0gNHxTKmBiRUEAeYTtGeu1y8laHgkIUeyGjLE9SRYKmYeEoft2mL1J/TWGUlFeHkNMnyCOsx+Lv3tuekpYOA74leN9cC79TR9v98bWHmyto8JFAE5Laf9vrpC48i5aCVzhHTIIrxnyXWLpzZ16qlUY+hO4X40T7p6TnJNCQevMB+HVxaf7WfzmWJcLBS9sMPZ4+Wx8LVKwrl2xoYXLZB60Y+FKSYADh7cuusb3s6altzTOs1zg5VLAz6iNnx9K1Q8LoKMkkd6bvbfXYCAJ41wGpBZLUr76/UNR22UEhg56i3aS7nB3nU5qEjzpLZIBxGSUv/TT8M/8hpDSSODjeMHH/sZCu36EWHXN+I8jgOWLKnT5iY/iVLoYgYnJ7VEQ8BijoZOKAU1RW+2wU4LDC1uoKuXzc0Mz1YFDTYzNs49df3+rcvEV2IaVVhrSIj+BqF2rfqJlN2u4I3Y=
X-MS-Exchange-CrossTenant-Network-Message-Id: a313af32-277e-40f9-8483-08d88b2fbeb5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 19:34:05.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y16jFNs0M57UPhcL7ZDqDQP9trzkVNPtdJOT+i1ZcssbS7BH8+uTKfSl4Loktiok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2213
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_07:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:29:29PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Hi Mike!

I like this version so much more, thank you for fixing it.
Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com> .

Thanks!

> ---
>  mm/filemap.c   |  3 ++-
>  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 249cf489f5df..cf7f1dc9f4b8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -42,6 +42,7 @@
>  #include <linux/psi.h>
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
> +#include <linux/secretmem.h>
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
>  	page->mapping = mapping;
>  	page->index = offset;
>  
> -	if (!huge) {
> +	if (!huge && !page_is_secretmem(page)) {
>  		error = mem_cgroup_charge(page, current->mm, gfp);
>  		if (error)
>  			goto error;
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index d4c44fc568a4..abf6ecdf70cb 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -18,6 +18,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/secretmem.h>
> +#include <linux/memcontrol.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
>  
> @@ -50,6 +51,32 @@ struct secretmem_ctx {
>  
>  static struct cma *secretmem_cma;
>  
> +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> +{
> +	int err;
> +
> +	err = memcg_kmem_charge_page(page, gfp, order);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * seceremem caches are unreclaimable kernel allocations, so treat
           ^^^^^^^^^
	   secretmem?

> +	 * them as unreclaimable slab memory for VM statistics purposes
> +	 */
> +	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> +			    PAGE_SIZE << order);
> +
> +	return 0;
> +}
> +
> +static void secretmem_unaccount_pages(struct page *page, int order)
> +{
> +
> +	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> +			    -PAGE_SIZE << order);
> +	memcg_kmem_uncharge_page(page, order);
> +}
> +
>  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
>  	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> @@ -62,10 +89,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  	if (!page)
>  		return -ENOMEM;
>  
> -	err = set_direct_map_invalid_noflush(page, nr_pages);
> +	err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
>  	if (err)
>  		goto err_cma_release;
>  
> +	err = set_direct_map_invalid_noflush(page, nr_pages);
> +	if (err)
> +		goto err_memcg_uncharge;
> +
>  	addr = (unsigned long)page_address(page);
>  	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
>  	if (err)
> @@ -82,6 +113,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  	 * won't fail
>  	 */
>  	set_direct_map_default_noflush(page, nr_pages);
> +err_memcg_uncharge:
> +	secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>  err_cma_release:
>  	cma_release(secretmem_cma, page, nr_pages);
>  	return err;
> @@ -312,6 +345,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
>  	int i;
>  
>  	set_direct_map_default_noflush(page, nr_pages);
> +	secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>  
>  	for (i = 0; i < nr_pages; i++)
>  		clear_highpage(page + i);
> -- 
> 2.28.0
> 
