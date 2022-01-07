Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78244870F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 04:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbiAGDFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 22:05:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55722 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344999AbiAGDFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:05:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2070v6Of026701;
        Thu, 6 Jan 2022 19:05:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2Azth62V+X6la4hYZLAtdfsa0dkbf9DAJeOopjfvYCA=;
 b=NIq4h5kK59S6B3oql+VCHC0dGj+YRDyGg7JAzXVFqhevyaxz56S5eh54E8WCi+c1YgRC
 lK4rejw099mpLkBA3fci7h4BeZhauHZw84ANFbXVdc2R/duv5WFl9bni3gUduEHklTlR
 QwxnnPjUvTiJ1ssRidFvn1YVw1+YWVrvrr0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4wj32g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 19:05:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 19:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHQYWRyVOsso5ZcJpVCaZeysC/Tsv5PkYZth/FhH93KYrqFa3wv9Av7Fz6SXe3/cjxrZjG/bRujYLmyl2gnXa/CFLFMgftnHqVX2ZFJAYouW+0d4a42ePbJ3D5GFqvne6Vn6inPb6akQPQ77Vp1F+FKAPELy2jMN3ErXGQaWKwtBQqbAtWq+nF4AgXCYgEJjgMTx+NUHsnAdwDr21eZZ8vX4vrEK7R+BXZTMMjt43a2Pr/qJ9/SfwY3oqBhKzxSUgShDG6wgqtfeXHg4ID8NTpCZ7Frc3vjVfj3n8SVcbj8ZJBvUZtEM5XowI13g+hTRqxw0bcZSdXnK2vShScnVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Azth62V+X6la4hYZLAtdfsa0dkbf9DAJeOopjfvYCA=;
 b=HMp8fFIrN1Pixb0AqCmaEhAtLrntBlhelkBJRRJ20ChPCVrHECJZXhdxWnj1od4Ammp8R1PDNfSbpuoVL8S6Ua3bP8zI95maaUG538KKH9VZy0c/Eb11DZ4/NHcg0nvXdSuzqYxbec8cY20yG2OdXsKuNoM9eYxhOv9lO8iz92EPLEJUJAWgIGsLg2jsWoBNxKQdjkHry2YXGZf9wsEhEADlVoeNKoeO65Xh21QkP5xl0jUVDzyDgbn63n3kOrCftrovzs76XoHK1190dgGXcLWKkj1ITDp6VH5QIAqjuguZ/IXg6NkdEAoWreRLWRi2wEzPBco0AndoQJWL5Sl+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4469.namprd15.prod.outlook.com (2603:10b6:a03:372::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 03:04:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 03:04:59 +0000
Date:   Thu, 6 Jan 2022 19:04:53 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <shakeelb@google.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <david@fromorbit.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        <kari.argillander@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-nfs@vger.kernel.org>, <zhengqi.arch@bytedance.com>,
        <duanxiongchun@bytedance.com>, <fam.zheng@bytedance.com>,
        <smuchun@gmail.com>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <vbabka@suse.cz>
Subject: Re: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
Message-ID: <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-3-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR15CA0069.namprd15.prod.outlook.com
 (2603:10b6:301:4c::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c7cb35-e51a-479a-39f9-08d9d18a7d82
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4469:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4469376B732F1826135DACAFBE4D9@SJ0PR15MB4469.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtHU+WeOflcZftaTbWAfz7R8e5d7gFaBTDoJAUwr3ePg6juR0bVE28xzb+/6shZWFAnEHkyWvqNUj/xAak4Vs93Pov2PZ93Q5rN/XVgRIvnRQlT8AD5PyJCq4Sfm/RETGxt21BxpNCo1X2tbfeTJx0grvknYACDjdQpFYlcq9tk3ZWh+2Jg5mvqNDbNwDgIYgcLCe5empsatCjO40izGmVCEOBifeiZy2j5RF/Nw+AkZgsyOH/O4p26U4xteqT49TzyxxdlBTVNBfo7lpBjA7qDmhkcpGBVdp2dXkX0qETRHBmmqhBV8dBMLuob/zizUUvLglzMaDGM5GNQfgRzr+7fmCWreIGg9zacYy+gq7aFGi6XQx5b7UCfAT+o9xl3Ri7A9zQlz4b7+dEgS/CR4bka9la2drsE1r0Hp7LxfKk7qaAujW3OE9PncShoDhyWNw3Y5HxA+Rl2AuktqDAJfU7KYZ1or2nsz3vL8fayVQ/a1HA7JYLb1b0hLNE3jaO4uZe+CuzX+2r+csMc5AZrgOXXKtAO4d8scpZQyoC+fASFbe2QRWG0A1fenR0HhX/zjofWZa1sFjgUMenQrXhISLUMSNo/cASPifqTk9sD3kqQSNOba5SAr66xjPWCQhlaY7Xzxm5hx2f6DT3u4NcGgaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(83380400001)(8936002)(186003)(4326008)(6916009)(52116002)(6486002)(38100700002)(316002)(86362001)(7416002)(6666004)(66476007)(8676002)(66946007)(6512007)(66556008)(2906002)(5660300002)(9686003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1+xSw5Y+QGs2vOm8ijgLSm36y1/k4XdZPbZPxgbFJCbHcCctXuweP8/LB3n?=
 =?us-ascii?Q?Z+y68Sg9gmQRGj+U0sQUCRzyeYUalSR1ONA+VGIuk2+XcO+fxUjkFLDeWt1i?=
 =?us-ascii?Q?kKXTVeT66Cwb3RAE/TG9wG2QevjwBpHrm1PvC9Y5V2l0sLHWopel/waJxyAF?=
 =?us-ascii?Q?nbe6ueQwd23xqTxSQqsd40mdifm5soNrOb8GiS6mBspJFDOCd0WWAfhbuztk?=
 =?us-ascii?Q?ACUtDSsW626seC7sj5l3IvkWd5QVFvQcVElwmy9zgpVcwrDYrwOABKMk0UU5?=
 =?us-ascii?Q?fy5Vx0r93VCCDlz8Sjo1r65/DrztiwRfPeNq7/4/nf6AYfm//0kJ/+Ebv/9D?=
 =?us-ascii?Q?qWdwZyoePBLFavcyBo437uVDduTAkXppC/YSCore/AfYK2HFTuMLeeyez6IQ?=
 =?us-ascii?Q?4A89KdeGRZqC9gHNuBmeOxACCHt0iaGsssD4JmiKPnGS/LZj9ho6Qww1hgNU?=
 =?us-ascii?Q?qbZ+VGn74VK5+BUTqca54ESQqVMrwbl+xtssG5dEM3O5ArvWPIVDXjozd1+C?=
 =?us-ascii?Q?dOLPsVG8hg+HhkE57AzAxtz/+q3NSzqYoHC5Vp+vO0zFW+wN1p0Sgs544C2E?=
 =?us-ascii?Q?9Qgq9dLC6UI6IQ6PyQE8eKHzGbnzV+x3FlKvh3OkcCSd7c7BxGuayLXvroYb?=
 =?us-ascii?Q?USyfjno+jmW8nNf3nu0wAQyUOl7c1lKUFwV/wasUV4dZ8jdqjSKKJQiaRYex?=
 =?us-ascii?Q?yz4yE9Zm8mnyAyKA8a2t1U/DsqmviE0D8aoxwU7PRjR/SpZ9z0UinELRW6qZ?=
 =?us-ascii?Q?cUI4vdB4/sh9+LMuGoD2nwKclxmFc88le86VyOv9kjIRbf2W9cre3HwS+F/B?=
 =?us-ascii?Q?FxTHL8pMmW9olzk75jKS0YwLiFVhtR9jXYpPnaDsSVN7J0l8giEprJC7nt3s?=
 =?us-ascii?Q?pQLmKEyO3vC4wbB9Hu/qJemYBE6Eblj0qtO7tKTZA79cCuXl2UqsdkDKH6Ah?=
 =?us-ascii?Q?Blx2Es2z79oQjrVkv542AIA4oDMPGMbDNB6RcZIlvnbzb1DLN9ccfweBykR8?=
 =?us-ascii?Q?ZZFp0iHQw0fQnuVR3HhWIqIT3mHuXIQNMkSKtF30+7slYOcnN+IyM9H1Uqb1?=
 =?us-ascii?Q?y1Pq+an12i6N6ChxXnSCfMGm8m+us7m9jAGYoZyB2su/BmIBB4oEd4jPVJIA?=
 =?us-ascii?Q?ZZU9cW4WpQYe9o4cAP5iLxLOnVzjHYW6BmRRPEFrGjEAL5VplLBjPHwVxOu9?=
 =?us-ascii?Q?pFk+K7Qa7d5ZXbEQ5uKrSoZeZwbWPPLlVSGXbqUCmezVwvLZU5rv0s9xs5vF?=
 =?us-ascii?Q?AXoWhVIcnZZB5kXVc4Zg9KddbhD7LVbddAcSlxTJ38y66SZzTGdyeZMTEqgm?=
 =?us-ascii?Q?jpohbi9BdN2uDAbnBLLTYCPJdoy+MMijlPGY1JGszlPdWZA+oOD9foZd85CB?=
 =?us-ascii?Q?MLHVbk9xuSYulEOOJvZbjV6ZtguoDI4JD0eI704QL3ye6tjJ/yvaildnQmHc?=
 =?us-ascii?Q?qr1KaoArPlOxBI4MWhAGo/f1/fZ1iolSlILcbMWE94/DcB6Tbq6nddgDtXnJ?=
 =?us-ascii?Q?dZ6pHIrZNZ9TXWKGTDIieYsl4ONY1Ovusl8e9cz7jdNtJW61MT+UxlTdvcHi?=
 =?us-ascii?Q?zpk19sDEZxG72KMVl9wJgVUe894NUduEDc57Ki5c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c7cb35-e51a-479a-39f9-08d9d18a7d82
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 03:04:59.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c60AEB9qMtg7gtRE1+oGkLHKKl2e6kAOt/xS5GhI1VZtk11KkLCjpwM4gDvNJxk2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4469
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8t5keRZ9vHk-f5OZhwfmsbwjCRTaQ5LO
X-Proofpoint-GUID: 8t5keRZ9vHk-f5OZhwfmsbwjCRTaQ5LO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_01,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201070019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:35PM +0800, Muchun Song wrote:
> We currently allocate scope for every memcg to be able to tracked on
> every superblock instantiated in the system, regardless of whether
> that superblock is even accessible to that memcg.
> 
> These huge memcg counts come from container hosts where memcgs are
> confined to just a small subset of the total number of superblocks
> that instantiated at any given point in time.
> 
> For these systems with huge container counts, list_lru does not need
> the capability of tracking every memcg on every superblock. What it
> comes down to is that adding the memcg to the list_lru at the first
> insert. So introduce kmem_cache_alloc_lru to allocate objects and its
> list_lru. In the later patch, we will convert all inode and dentry
> allocation from kmem_cache_alloc to kmem_cache_alloc_lru.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/list_lru.h   |   4 ++
>  include/linux/memcontrol.h |  14 ++++++
>  include/linux/slab.h       |   3 ++
>  mm/list_lru.c              | 104 +++++++++++++++++++++++++++++++++++++++++----
>  mm/memcontrol.c            |  14 ------
>  mm/slab.c                  |  39 +++++++++++------
>  mm/slab.h                  |  25 +++++++++--
>  mm/slob.c                  |   6 +++
>  mm/slub.c                  |  42 ++++++++++++------
>  9 files changed, 198 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index 729a27b6ff53..ab912c49334f 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -56,6 +56,8 @@ struct list_lru {
>  	struct list_head	list;
>  	int			shrinker_id;
>  	bool			memcg_aware;
> +	/* protects ->mlrus->mlru[i] */
> +	spinlock_t		lock;
>  	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
>  	struct list_lru_memcg	__rcu *mlrus;
>  #endif
> @@ -72,6 +74,8 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
>  #define list_lru_init_memcg(lru, shrinker)		\
>  	__list_lru_init((lru), true, NULL, shrinker)
>  
> +int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> +			 gfp_t gfp);
>  int memcg_update_all_list_lrus(int num_memcgs);
>  void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c5c403f4be6..561ba47760db 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -520,6 +520,20 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
> +static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	rcu_read_lock();
> +retry:
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;
> +	rcu_read_unlock();
> +
> +	return memcg;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  /*
>   * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 181045148b06..eccbd21d3753 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -135,6 +135,7 @@
>  
>  #include <linux/kasan.h>
>  
> +struct list_lru;
>  struct mem_cgroup;
>  /*
>   * struct kmem_cache related prototypes
> @@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  
>  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> +void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> +			   gfp_t gfpflags) __assume_slab_alignment __malloc;

I'm not a big fan of this patch: I don't see why preparing the lru
infrastructure has to be integrated that deep into the slab code.

Why can't kmem_cache_alloc_lru() be a simple wrapper like (pseudo-code):
  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
			   gfp_t gfpflags) {
	if (necessarily)
	   prepare_lru_infra();
	return kmem_cache_alloc();
  }

In the current form the patch breaks the API layering. Maybe it's strictly
necessarily, but we should have a __very__ strong reason for this.

Thanks!

cc Slab maintainers
