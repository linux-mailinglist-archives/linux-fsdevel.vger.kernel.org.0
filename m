Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B831D3E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBQCKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:10:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229480AbhBQCKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:10:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11H22sx4016233;
        Tue, 16 Feb 2021 18:09:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=j6chBHbmHhDOByFIJ3W1bb9jhHrzE7guhH7fFlhHzCI=;
 b=DR32Bn0D2aOOAXbJ/oDskFCWGW/D+t/S6iatVO6V5QB5T6E/7GoTg6a/ajqUliGd5xAg
 JO9zN302YaxqYEzcQyUtGwDjzfbXpxWX7qgP/WCnFwwJVlkCxuIv5p6JiLXDUuGibAxx
 XUaoIuk8HmI8dAZG9qDRl9slRX0MrOPswRA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36qvcn0s3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Feb 2021 18:09:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 18:09:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnJrOaVwfKSHPxBsRtLHwHt/ztsOya602kKmcKQOGq5AntUizD53Y2UtOhT93qMXEYhNilVmpiNFE8wZV0xN+tShhg/xBh+uEVmZ6rC1wSzISNqn8/I8ISgZSlBzAd1d+DRvvhTZheygBPk+8SKBWbZZEddMeXvAnUDpk5Jbn8Pmo2EHEQwR0NIywO3Jdnv3LT5vigDPUNISEDDk16i8g7HaxFYxhA6KNKSIFOE9E8zsNFbJodkeOwlWnNycr5TxSZQw/3Jy/881ph8gU99QEBNJHOOBMDeTvBlLBvye+A3uOeOL2AmjBbHNuJTQPSAylc6+5OarAPeH0lnkh1hq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6chBHbmHhDOByFIJ3W1bb9jhHrzE7guhH7fFlhHzCI=;
 b=QWihToStmySpa5gvouS8M9bKybDowB+EdiY8tmsqTnvqoS4TrbpZoMN3qKrxL3QDVv4/nhVq9oYPft00/PH1rE+Kab4xu/p2+xwxCY6885oW0IH1miaGam+z1iHYf3S9qeBxTQugrBMW1ZVKolyQsWs9dSNPgJVp3kfJ+pxbcQEkYm1bHMZWZnOD63sHUrs8MqX3hSgOAQLLaXj2dCEa2YKxwFPZ2/T3oeA2i4OWSmf/tcWncy1lviPTjEUrplsdXw6PfYmUyUwAjUHK4VpLfLLJSxCyQxz3BxQBVPuYQpZNW+vq48o7imLdwbWS4tBYnZXvUszRnCz1Q38juHvynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3521.namprd15.prod.outlook.com (2603:10b6:a03:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 02:09:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3846.043; Wed, 17 Feb 2021
 02:09:54 +0000
Date:   Tue, 16 Feb 2021 18:09:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 09/13] mm: vmscan: add per memcg shrinker nr_deferred
Message-ID: <YCx67dOseeEi7yyb@carbon.dhcp.thefacebook.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-10-shy828301@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210217001322.2226796-10-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ed2c]
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ed2c) by MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 02:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb9c9c5-0914-4bc5-3242-08d8d2e91d95
X-MS-TrafficTypeDiagnostic: BY5PR15MB3521:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3521312BA507CA4C31951E97BE869@BY5PR15MB3521.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se97evjd2C5CAV1Xxp3w8i9vtH6SZcSjCyiMpjZrk4ngUEj6AhLoLhBZH/TZVAo/m//fdvJh6BrgrndYewlTcuQf3tDqeKQ8blW1GJvdi1Ygrn3lrZa57PFiAKWDckJ8HlupBlhd2U+xI7Slw/0A1v1iJzjC/KrJOxdxson/R8K26lS8Dob+n3pYJIrmv3gq2KNjgTgvnNECapvsTWKxZyPDfYRLKPq1DCtvqssUpw/TqZDdWxPUlU3yQpdKMReA0VV2AMasm7bmBOmdOT6KJZDT3AcUrvhnHJH9vj+CVR8i24LRCzE7HpnIE8H0i+ep4Ov73dArM3/3+fKvkwqblc4unQT1tm8AVtXNQ/dGYy7OZ3OzCBt/eb26JLRiKH5Zs82/pA0Qp6iJmwPG5Bh/ua1C1L8uPoiHXaCsdEA++XsnNBR0BYGG7DQTeATtTA2ttj4qzctO8y7nXgjxedADHBdm+iCfq/Kcvos5w53Y0nId5LqKxHb9iyLnXk64AmEy5JUrnJn4jAciDNp3GRBvLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(6506007)(316002)(478600001)(6666004)(4326008)(55016002)(16526019)(9686003)(6916009)(5660300002)(2906002)(186003)(86362001)(7416002)(8936002)(8676002)(66556008)(66476007)(66946007)(52116002)(83380400001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b6PBHHgwg0hjvIBsAeffkVSSwhgd2gcSX+l/1zAmSSXwX2jIv0DcEtCPDPHS?=
 =?us-ascii?Q?4abNvHo79IzMMk1sN04kLumOQFV8XGwVGtjV40ANpnKjnz3GQB9FtwA8lk4D?=
 =?us-ascii?Q?gyVxXjd6Lq6pIrd+dXQFrvkvaqPb3gjJ9pFAeJkpdxxvn86jbk8aUi1K11Ym?=
 =?us-ascii?Q?PbLhDiRtgQFU4oYqGHmm47kz01+XsUrizy4iTC4sAco5Dp6JdRU5eLqVylU4?=
 =?us-ascii?Q?gF3tjVkw7ItQBYWSXnxA2W1Gecl5Fmt+hs0a0DCYcW178/CL6K9qQ5aDqq9R?=
 =?us-ascii?Q?wzoL9RRqY4D/u4S9HfsFgVXDJj45TwX81fjHJXQ8uxg2p6CJZ+lqzY/RbwGQ?=
 =?us-ascii?Q?gS/AIp0xuf/Q2+m+jkOKvLeAxRwn2EdeI+PxvjShO09IRiCg/J7BsFtdJIiZ?=
 =?us-ascii?Q?JuxkM9M6pJgdg8u6pJ+3lMbDRnJ3Umax78yqQC2jE1b0wQr7chWNpLp+SkyL?=
 =?us-ascii?Q?qyf3KbHiPBcuPVKaflPTORuUBwoqgtHvv0faEWQYcD3mqnPmKWkc4AzE/MgW?=
 =?us-ascii?Q?w1fQe17KcjCh5o0IcFX1FrZabVZerwZTaaFWVgdl9OxsrGtyLvnD+h8qUeqj?=
 =?us-ascii?Q?TDecHhgQ+DENMvubvM43QCPZiGHh74zdJ0HAqEQkVShCb5M2sSGKIYWOw0Jo?=
 =?us-ascii?Q?VKl1x8NfrspbO+5Mm+tTWDxhvdx4mBsl99ZxIldRBAivdnit65BD5Mlcsl6I?=
 =?us-ascii?Q?lqDSf09u70vmMnjGJm4faEgZXlx0gcpegE8b3slS7MCDNR+ocJ94v5E6ChNT?=
 =?us-ascii?Q?dj+E95yBVbKRMT9XRcAc/s8S+DEB+aMIbP++6cbx1sTuxdyzNG/54Um6bwNo?=
 =?us-ascii?Q?hFH7m1iphetWDaPbsI8yDgVG1uxbWEcB9WbPv0iGqlueizAcZL34m3qgE7Yd?=
 =?us-ascii?Q?KiA4o8LTEMfpXXJdglk8oAOJsyWcAW7QknLPy4cLyWstJK1y/sOiOqfhtNHw?=
 =?us-ascii?Q?onBlKV03q0jXOf8Xlrr4qMQUw7VDXyfnIS8xfSUSdOrR668NM7xlqjYNyB0v?=
 =?us-ascii?Q?TSPEZufZ4pBm/R/S+F+4+WBbRGZm/qYAfVDWPWi68Gl1vEUgcc50Ei9579Rn?=
 =?us-ascii?Q?rEBCumyOUphPgQvbxgPlam0p6nHuk2Fh4/uc5fUuxS9mx7FS17SSYWLYNFGj?=
 =?us-ascii?Q?fLYntwIT/qSExv402X/hQhMjNowumUjCzhVl+J58A02EbWtIu/WT6LWIqMa6?=
 =?us-ascii?Q?HxV+gb6T4xVAa58Gzs2def6XUzOBX/i1c3urNHxo55GiBas0aK4gKWWDQedL?=
 =?us-ascii?Q?IngnXZrAsGw5HawVnuIRNp6qR0cWblH807Z6WAX9V91ZJC3Zo7Xm3nqoDIjT?=
 =?us-ascii?Q?ga8l7RxrfiKH7BKwX6iByJMA0PU5qGHBGzIJ5Xbc7f947w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb9c9c5-0914-4bc5-3242-08d8d2e91d95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 02:09:54.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/a0vud3V//yS6CeJrrCPf/0eMhIIRG2tc3zNFCq03W2bOosgBEFGweMK0TehdFU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_15:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=775 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:13:18PM -0800, Yang Shi wrote:
> Currently the number of deferred objects are per shrinker, but some slabs, for example,
> vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> 
> The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> may suffer from over shrink, excessive reclaim latency, etc.
> 
> For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> 
> We observed this hit in our production environment which was running vfs heavy workload
> shown as the below tracing log:
> 
> <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> cache items 246404277 delta 31345 total_scan 123202138
> <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> last shrinker return val 123186855
> 
> The vfs cache and page cache ratio was 10:1 on this machine, and half of caches were dropped.
> This also resulted in significant amount of page caches were dropped due to inodes eviction.
> 
> Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> better isolation.
> 
> When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  include/linux/memcontrol.h |  7 +++--
>  mm/vmscan.c                | 60 ++++++++++++++++++++++++++------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4c9253896e25..c457fc7bc631 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -93,12 +93,13 @@ struct lruvec_stat {
>  };
>  
>  /*
> - * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> - * which have elements charged to this memcg.
> + * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
> + * shrinkers, which have elements charged to this memcg.
>   */
>  struct shrinker_info {
>  	struct rcu_head rcu;
> -	unsigned long map[];
> +	atomic_long_t *nr_deferred;
> +	unsigned long *map;
>  };
>  
>  /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a1047ea60ecf..fcb399e18fc3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,11 +187,17 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
>  
> +/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
>  static inline int shrinker_map_size(int nr_items)
>  {
>  	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
>  }
>  
> +static inline int shrinker_defer_size(int nr_items)
> +{
> +	return (round_up(nr_items, BITS_PER_LONG) * sizeof(atomic_long_t));
> +}
> +
>  static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  						     int nid)
>  {
> @@ -200,10 +206,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  }
>  
>  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> -				    int size, int old_size)
> +				    int map_size, int defer_size,
> +				    int old_map_size, int old_defer_size)
>  {
>  	struct shrinker_info *new, *old;
>  	int nid;
> +	int size = map_size + defer_size;
>  
>  	for_each_node(nid) {
>  		old = shrinker_info_protected(memcg, nid);
> @@ -215,9 +223,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		if (!new)
>  			return -ENOMEM;
>  
> -		/* Set all old bits, clear all new bits */
> -		memset(new->map, (int)0xff, old_size);
> -		memset((void *)new->map + old_size, 0, size - old_size);
> +		new->nr_deferred = (atomic_long_t *)(new + 1);
> +		new->map = (void *)new->nr_deferred + defer_size;
> +
> +		/* map: set all old bits, clear all new bits */
> +		memset(new->map, (int)0xff, old_map_size);
> +		memset((void *)new->map + old_map_size, 0, map_size - old_map_size);
> +		/* nr_deferred: copy old values, clear all new values */
> +		memcpy(new->nr_deferred, old->nr_deferred, old_defer_size);
> +		memset((void *)new->nr_deferred + old_defer_size, 0,
> +		       defer_size - old_defer_size);
>  
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
>  		kvfree_rcu(old);
> @@ -232,9 +247,6 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  	struct shrinker_info *info;
>  	int nid;
>  
> -	if (mem_cgroup_is_root(memcg))
> -		return;
> -
>  	for_each_node(nid) {
>  		pn = mem_cgroup_nodeinfo(memcg, nid);
>  		info = shrinker_info_protected(memcg, nid);
> @@ -247,12 +259,12 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  {
>  	struct shrinker_info *info;
>  	int nid, size, ret = 0;
> -
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
> +	int map_size, defer_size = 0;
>  
>  	down_write(&shrinker_rwsem);
> -	size = shrinker_map_size(shrinker_nr_max);
> +	map_size = shrinker_map_size(shrinker_nr_max);
> +	defer_size = shrinker_defer_size(shrinker_nr_max);
> +	size = map_size + defer_size;
>  	for_each_node(nid) {
>  		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>  		if (!info) {
> @@ -260,6 +272,8 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  			ret = -ENOMEM;
>  			break;
>  		}
> +		info->nr_deferred = (atomic_long_t *)(info + 1);
> +		info->map = (void *)info->nr_deferred + defer_size;
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
>  	up_write(&shrinker_rwsem);
> @@ -267,15 +281,21 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  	return ret;
>  }
>  
> +static inline bool need_expand(int nr_max)
> +{
> +	return round_up(nr_max, BITS_PER_LONG) >
> +	       round_up(shrinker_nr_max, BITS_PER_LONG);
> +}
> +
>  static int expand_shrinker_info(int new_id)
>  {
> -	int size, old_size, ret = 0;
> +	int ret = 0;
>  	int new_nr_max = new_id + 1;
> +	int map_size, defer_size = 0;
> +	int old_map_size, old_defer_size = 0;
>  	struct mem_cgroup *memcg;
>  
> -	size = shrinker_map_size(new_nr_max);
> -	old_size = shrinker_map_size(shrinker_nr_max);
> -	if (size <= old_size)
> +	if (!need_expand(new_nr_max))
>  		goto out;
>  
>  	if (!root_mem_cgroup)
> @@ -283,11 +303,15 @@ static int expand_shrinker_info(int new_id)
>  
>  	lockdep_assert_held(&shrinker_rwsem);
>  
> +	map_size = shrinker_map_size(new_nr_max);
> +	defer_size = shrinker_defer_size(new_nr_max);
> +	old_map_size = shrinker_map_size(shrinker_nr_max);
> +	old_defer_size = shrinker_defer_size(shrinker_nr_max);
> +
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> -		if (mem_cgroup_is_root(memcg))
> -			continue;
> -		ret = expand_one_shrinker_info(memcg, size, old_size);
> +		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
> +					       old_map_size, old_defer_size);
>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
>  			goto out;
> -- 
> 2.26.2
> 
