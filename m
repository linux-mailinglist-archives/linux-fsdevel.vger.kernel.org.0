Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA42CCD05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 04:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgLCDHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 22:07:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgLCDHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:07:41 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B336nDV031409;
        Wed, 2 Dec 2020 19:06:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KSNbZueJ6unVxbUmpexAxejS8io6WON5PBxAzSWkhmg=;
 b=eKB+p/HfuE9Ekld9ElVUyJWgowM/hrzuv1qVJO5ILYJopY3MK+3eDNQlzN3pAs2w3yqC
 KthybIsPEVjeA0qz4+ZTQgK5IjqDDopsPcuwf+CRYRSlRpI+azBGWJ4BAPlbuDo/CmZ2
 IFUKneY8rkZJ4QrGbav9Zpj+l17snXBi1p8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3560xg0d2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 19:06:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 19:06:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFJRGhCMD7rDFU7bf9dsXMhqE19Bqphj5iR6qU/4d814Tm9Fq0Tjs4TYVxPgD/uYgcLSOxl6FdR0UoMQO2U23CG3qMhMiG/bVO6RdNul90rIRqdZ7R9xgLi/XAqnESx249OnFzed05lHAkWzR6aFsQpliVkWop/KWmUqp1zEw2xu2JzSBC3wlAPsCufxksl5k7zcJV7wW1nwqE1vZzrpEfll/9uQzoHhtA6YX95XtWG+Uzc76pPyb5F1RN5ZwjtrTtfjPuFxR24Zep2IBjMDV7K2I0HzzDUOlNOqNpkvoHHoYiJHnn/v1l8JvDxqTHDjzXj5v8goRyQ8IQPDajo9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSNbZueJ6unVxbUmpexAxejS8io6WON5PBxAzSWkhmg=;
 b=QlzGbNXTp4Tj4hfddMU2LWASiLvQyZczrXeDxszPYI9sfl13+lfJeuEOoKugDV+VrbwE16eTPnZXuXmDuicwOYft4UP/vhlJy8qACvj+FkBiX2mXFfvLUxDMvt8MD/Kz+QKFcGhPFkmJjJAMPcDI0rjNeRiNXgK+Aa3rpurZ66KjowwZdLBGf/6tw6KMTQ5hlyY4IkSlqD5Y+7N3TtDePAzBEwQjUft1EuxfXsLeNJbGssBEFbrhYR6ugJL1MFHBjMLXfLwy7Pb8j+fLdQtIa8XfWzY1rkIJLbRI6mMv+ukRUV9lfsI5UYJQBkNyO28cp+UK28Bi8vyBKBJVN2CukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSNbZueJ6unVxbUmpexAxejS8io6WON5PBxAzSWkhmg=;
 b=A/D6NkyElphwEoR0MW9hvzyctFFXtOsYOcOUU1H0/jMWCudoXpAydgwoFGnOkNEOUDRcByJY8wSQ8vSXSvOViTUgLcdaL3KUHQ+8ky4p98PmZ903caI3/GUGzCdLwdjpigPB17FcUgs5fbtwV0HXIAsUJA0WZqEZNcx+tNKs8CA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 03:06:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 03:06:37 +0000
Date:   Wed, 2 Dec 2020 19:06:32 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
Message-ID: <20201203030632.GG1375014@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-6-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-6-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ee30]
X-ClientProxiedBy: MWHPR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:300:ef::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ee30) by MWHPR22CA0010.namprd22.prod.outlook.com (2603:10b6:300:ef::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 413f9783-ac55-4a40-adac-08d8973872cd
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30800EF69BA76F7C9DE62503BEF20@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnSpUPPQ86hYRU5LnGfRhjlXC/eFeuD3AsZPn3ipewufrOe8QrilwNHBqQGNULUY4ua+xl6Asqyo79tUllf7+rei7OXzwBi01Bds4WUNVD+g7zQnoHk2o6dDpNKYohWpqzTKSl3lrgddI7ORjnuHJQ9FuVcZnqZLZOKPJ1WPknPX9ohkH13sJN+gxJzCBo6MpZ8KntLtwJ721g7ViEcjyIqIZbNAWFwwq8RO9zi38VvuntTrhZyaEEPODkV+GFkidQQ/FyW6wbopQ/AFApizB1Rzq9JbBnF74ndKkwHL0uZxQyUuI9fvYi16HSQPhWkAfRinnCs2NJpod5O6aszEuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(1076003)(7416002)(6506007)(2906002)(86362001)(55016002)(8936002)(33656002)(9686003)(83380400001)(5660300002)(6666004)(8676002)(186003)(6916009)(66946007)(66476007)(16526019)(66556008)(478600001)(52116002)(7696005)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7YGSayxOFLv0D1yXBM/7sdvAEbZCVsGsBVQ7AL2WFBFJ4AoeckqaoB6wKL0S?=
 =?us-ascii?Q?snS6lcwGQ8G8EYOkM41rkfZWMt8F1eKnuIJY090OV/VtmfzMXciBhwVMRj14?=
 =?us-ascii?Q?7JU8n0UduWubSMb60ye6CTT8AC1w9kbllNBHxlRIjPLg1jcNO6kFxB1ZL52y?=
 =?us-ascii?Q?yk9Ivdr3wiqKPeZs9w838pkoQuYk03z0boU4p8SYBuDRZXCKjNJFUuamkwPv?=
 =?us-ascii?Q?ZzuNLwQ/HNIN2wl7U1LQuHdMkUuKsVeAuaZJflkQU9H0c8nZlTOdzuyO46V0?=
 =?us-ascii?Q?Lp//67+GVrWOjCNFt7iif7A/p4B4U7Vfv+rt+h413KkQsbDialxdGPRSUdYG?=
 =?us-ascii?Q?J8b46Mm7TKiC+JfPEwLL1RBdY71qQtSQ3trK91rUHHtwqKhyhOxJB5HwG9TS?=
 =?us-ascii?Q?9MfDLsO15uRdD0ERWQ8kHBgnLmbYhFHzYWy3aZwyqrQyhwehKAqkloAG5opO?=
 =?us-ascii?Q?0BAgeU2zULwzRFX4mL4jwDaCVIcRCg/2gp4RH6R1aaXvHxYaCx0LA8J66ugW?=
 =?us-ascii?Q?aVq1B1BMKGJDyQ+Yf+EBsakEY4QQFwqvcclX/0ifbabg21v9uk2ZIeD4HFM+?=
 =?us-ascii?Q?Tl0hK6ocBG4ybeh8Dzuzeu/jQADzZbiSpQ233nnZ81PWmo7GKwVq6XbOc57k?=
 =?us-ascii?Q?o32UiauqKI6A5UMuWaqel7YaVPjHIRUMqkuSVi02CC/DZpi/LXG1lehNF+3c?=
 =?us-ascii?Q?AgA9YACOVW2vy3x2yVBG6F3MkI/yurAHKAJ+g0pnSRpTzS8xYN03rsqy4s/K?=
 =?us-ascii?Q?UgTSJ1/QBEQP/CWY8v7+l772+KabhmJBr6bq3FfJb9M16oYOE3q6+gcWwnNx?=
 =?us-ascii?Q?CXtApKPYog7De2CjMO/hkSO/UYnZV9YatR+qQSN7Pg98OuWajySLhX6qOCJG?=
 =?us-ascii?Q?HVzD5+Lbsr+NBpS6j+AQY07WFKPPH5O5eXK7wKisSfTGs8K+x1vNspzqCA8M?=
 =?us-ascii?Q?BIv+zxYACcTsFNYCumKkpN7pa3VZHcFaRZnVqgT5Tyt/f4kwmLOHad9LtC1K?=
 =?us-ascii?Q?zrjuJU7NvDAPS9fk2l8og0oBLw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 413f9783-ac55-4a40-adac-08d8973872cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:06:37.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMlag2vXTFnC3Wq4f9gbY8J4hjeV3rzqiIt7KleX+Sxwup5phPu01B++bHLJ1faU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=1 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
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
> The vfs cache and page cache ration was 10:1 on this machine, and half of caches were dropped.
> This also resulted in significant amount of page caches were dropped due to inodes eviction.
> 
> Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> better isolation.
> 
> When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/memcontrol.h |   9 +++
>  mm/memcontrol.c            | 112 ++++++++++++++++++++++++++++++++++++-
>  mm/vmscan.c                |   4 ++
>  3 files changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 922a7f600465..1b343b268359 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -92,6 +92,13 @@ struct lruvec_stat {
>  	long count[NR_VM_NODE_STAT_ITEMS];
>  };
>  
> +
> +/* Shrinker::id indexed nr_deferred of memcg-aware shrinkers. */
> +struct memcg_shrinker_deferred {
> +	struct rcu_head rcu;
> +	atomic_long_t nr_deferred[];
> +};

The idea makes total sense to me. But I wonder if we can add nr_deferred to
struct list_lru_one, instead of adding another per-memcg per-shrinker entity?
I guess it can simplify the code quite a lot. What do you think?
