Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF8315BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhBJBNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:13:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234429AbhBJBLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:11:21 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11A1933I005416;
        Tue, 9 Feb 2021 17:10:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I7e7mY52kXqISPQZgupl3LBprEzA5FNVYdOu3wH6MmU=;
 b=A7UhUhT+Q6PIKD2lQw7epFUL4c3Wm1zJSZGhKwNgNiQi2/lCvKEoyNo9vhYNE9aIwnaw
 kzirV+Uo25xnUdWUfAeb4DJUOh8ItbIFQyIoXhpwaSnOh6wrJyph6X8qxmvaIY12hYvQ
 F+rXn53iUCMgImR/3h4zx1fluslBzhxjS3U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36kxmeaman-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:10:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:10:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp8IefZtcZgfFKoP1J8vWiyk9fMveRvVG1Eh7sV4kKTPCr8nOULxcyw5yYLdpNwo6Zz8N7u9eiA41qvmvyiMU8RxDyMel4m3EGLIOw1AW9MZBwaBFwX6fHF5tFojtP34SqDQ4XpZ5GIt+snG2Qkt14NzQfsVl8KfVwn0Cetk5YufIcXOVZLCV82bhSt55R6PPQe2sAfzj22zg7AkLTPAcx/j/yWBMgDBoCUKqQUvTrepr9/T3goV8Dc3rHGEkna1sgqy7AA/QN34hb2iZGHpZ6cxSzuENL7bOaMtgN7O8PzQRmrgVPxFjx5RpVjvarN6nMqWTyNGt3gawdUJh6WEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7e7mY52kXqISPQZgupl3LBprEzA5FNVYdOu3wH6MmU=;
 b=Kz9+ggWgA3N127mr9mnKuL1rKAfTK66/c/24gVcJOb9Y8qfMNqmOtGNd2qUn6/fKVCl+6h5nNOSGFZTYt13ifOe8dhrqwUvYhvRfpheK9LFO0JUZskAWpsvAQH6S2uuo6OFeNobEcJJM5iosK9WFk+TH8X5jzrVS5C8dTJhogEpSEdygbkJC1oFXG19C9KVpgKDvFA+PDANCt6OmWXYTd9QmUmxmBQpnTGqkWZR7JiGbP5iPEcuZcZDBweYOH8/pt8c9SxDBl7TlSYSlH62bAR9xOZ9eVhQzEq+ggDgRN3iNNeubKp5cOYxhil7juWClG38/r5we3GM9wXMZLmJCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7e7mY52kXqISPQZgupl3LBprEzA5FNVYdOu3wH6MmU=;
 b=NfDipdUwMrkGnxlRBBq0Q8mOv/tSDknxywNP5RbIzFKwgFvPaqqJ/7ht65Wo0ImnJwOrXg1owAqOEKfMR2rwF5B6/Riwmti/HUF5ziWkhy1rS6Pc3Lkil5sAo0N2KumOLz/ilEhJUxQtwNYvUxfi8rO+8dV6RlIGP313tcWPlZo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 01:10:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:10:25 +0000
Date:   Tue, 9 Feb 2021 17:10:20 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 08/12] mm: vmscan: add per memcg shrinker nr_deferred
Message-ID: <20210210011020.GL524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-9-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-9-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4ca0]
X-ClientProxiedBy: MW4PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:303:114::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4ca0) by MW4PR03CA0381.namprd03.prod.outlook.com (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 01:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e4d792-f74c-4bb3-40bb-08d8cd60a5ae
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3141E208A60E35D2E4FB9276BE8D9@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIvQDXRo5KH3cQyE5oiWQcYK7IAsBQTATxoMDSx8/iCNqRusEph2ju0KXiXV/yU90KlMKoCWiA+ooINZXw4MVI777Bv1ftpdQtUxKlY+yFL30TdfXeXC/LaPM58hi6QXbHxnSoQkuEyGo1uA4PPGddmhaRuACsjVJggAljE/mJx0Md2/eu1PFgoDJiwQzQ9z/1oovcQfTA1NnrpiufdWgIbE47qbZliwExkOI5WiHbwew1ut/NHmHkMYzHhgg7ZGTpEIkMP9x7WhotnyDR3Ir76++aKI0u23boKENPspeom0ta2awXY1U74eDt5bNPqs2HauG+RA1XpYxk22unuwS2daEZh+mrvNNKAxpxUF+9Dw8Zn//WSG0EHgxMCdZxqtaS4a24KmgFGecy8wyHBYkrvGERfY28XbewIovcMW+dZKiqofZ3FOw/Jb+/w1uORxYwlpbpByikA4Y4OS/ZPYgA1g5F8yXOmyD7GmpjnMbNcOhOkwUZvAib7e4Ma7EcAh+iMHrl46W7sQw9uN6B1mZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(9686003)(52116002)(1076003)(55016002)(316002)(66946007)(8676002)(5660300002)(66556008)(66476007)(7696005)(33656002)(83380400001)(2906002)(6916009)(6666004)(186003)(16526019)(6506007)(8936002)(86362001)(7416002)(4326008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DgLptxAMgXGW71kDcYjQl0+RuEmmrQZO3Fg0Vi7OkGphUzqfCM20oxarYwc6?=
 =?us-ascii?Q?r/KUh3+IlFUrF/KbrGl88fEr5cwemaBu4om0JnckbFkL74tU7lGyT6wFzSoy?=
 =?us-ascii?Q?r79U9MHaWAmSwqYCoGbeiPZOp3WyhpvCJ1hZhY4JT6L5iXoY60D23ZSoP8pj?=
 =?us-ascii?Q?VK32Ngir8mijvcbfOL37YyRzVp26angMcnZlKhw9ARtPNhzJIgkS5hdliz0s?=
 =?us-ascii?Q?MeAro9oTg8U3AqkuVj+TaVf83gRobZ40PfunEccExYH02zAvaLP1wIU7t4B9?=
 =?us-ascii?Q?ujYeLo+LjNS4G5V6Lif0KYg+5K73fzCASi9Jfa1CjuukxVuk2RAvL6VODBYY?=
 =?us-ascii?Q?mtc8u4hJl6VkEaB6H8sVi6VxPBusmbaa2v1IeCPOvMKYsMrjIr8GGq5o0XUr?=
 =?us-ascii?Q?mY4lXaE0Y9Ey+eMB9AnMJZjdwpU8nlAt32A4TAsWZ2BXO+9zwc3cLF3B+4vj?=
 =?us-ascii?Q?PHn0AYLIS2krwyGnKiuvLEVfvcj0ML7Cc1+ub0za6Byo7KkW2UScA/O5Wlxk?=
 =?us-ascii?Q?QJ3//j9NWnveNjLfPMrSM8KkMHIixbGYmzr/2RYzg7Q+vT89lcubliv6oY1+?=
 =?us-ascii?Q?hlvR4eKfIdqecLYqK8clLk3b7WuA/VOQmT5Gigu/px29sCuX7jgl7zy1JhuL?=
 =?us-ascii?Q?frnRmksPHAf8O0e10LGvs+JlvNfFQLSe87+0eT8s6D7DzqzucU/w9J3rKCBQ?=
 =?us-ascii?Q?l/meVd/8tXn2iujzi53xYlNvOA418UfRypgaVQqdqYZTO0uLpe4uaQWL5KCK?=
 =?us-ascii?Q?GsrIOUghw0eifcOL5MJ6mCywNHP+kn5imsQ25abX6bMcBGDbM20L1fMOVNzA?=
 =?us-ascii?Q?lfi4ZJDTC29j+JKDoEhFtd2UlCuC4OpcIBU7KJR/vV/IJPM2o/qtzuGPP6sk?=
 =?us-ascii?Q?xjLCSPDVPI8T4DH9g36LTF/fwN9Oe4HYo7Tu/yoaDxLBsqmB0amjMcadpwdI?=
 =?us-ascii?Q?FX+gIKIv7Fzv1YkKixMsu2WhLj/NAoieo0U4rn7sEbLtTTWBLnBHlLNSptgP?=
 =?us-ascii?Q?oVnluC2bawVfXaV3zOd22cF3ODO0L8h5HniaNwPUZWC8J0dornrVSiTHu6dh?=
 =?us-ascii?Q?DnnUYrZKRgXi5C7B7/7ttBkzoUxeskFBEw4/fI1n5udwSXXYk/BublQ6JduD?=
 =?us-ascii?Q?lxMsUG2eh/o8xzCiFI2RW1wtIQ13JYjWxYxRjcAZOTlhp19R9LadkMdlYV2s?=
 =?us-ascii?Q?YkLMfyQwNw1fqpP0YEkrJeEGuL5NibSsmpMGjOPL9MS29zd+1PK2vwK2qb4K?=
 =?us-ascii?Q?yWApHGfAYBVVwi7aRKU3B2bTu+d8gs6TEW2WFcChwH+Ux8XjCiiTIxY/igt6?=
 =?us-ascii?Q?sHSBzZ2V/bp4KVi3KaJLjyiw/xFPdE8bUKU08bf20omHdmJLHuMTONz5oKwl?=
 =?us-ascii?Q?c2jvkYA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e4d792-f74c-4bb3-40bb-08d8cd60a5ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:10:25.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T7PncL5hN5g5J+GlwpKUIV9hl3pWjIQNk9nwOh+iJYfJALp3Reh+PdR8iYWlsjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:42AM -0800, Yang Shi wrote:
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
> ---
>  include/linux/memcontrol.h |  7 +++---
>  mm/vmscan.c                | 49 +++++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 19 deletions(-)
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
> index a047980536cf..d4b030a0b2a9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,9 +187,13 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
>  
> +/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>  	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>  
> +#define NR_MAX_TO_SHR_DEF_SIZE(nr_max) \
> +	(round_up(nr_max, BITS_PER_LONG) * sizeof(atomic_long_t))
> +
>  static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  						     int nid)
>  {
> @@ -203,10 +207,12 @@ static void free_shrinker_info_rcu(struct rcu_head *head)
>  }
>  
>  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> -				   int size, int old_size)
> +				    int m_size, int d_size,
> +				    int old_m_size, int old_d_size)
>  {
>  	struct shrinker_info *new, *old;
>  	int nid;
> +	int size = m_size + d_size;
>  
>  	for_each_node(nid) {
>  		old = shrinker_info_protected(memcg, nid);
> @@ -218,9 +224,15 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		if (!new)
>  			return -ENOMEM;
>  
> -		/* Set all old bits, clear all new bits */
> -		memset(new->map, (int)0xff, old_size);
> -		memset((void *)new->map + old_size, 0, size - old_size);
> +		new->nr_deferred = (atomic_long_t *)(new + 1);
> +		new->map = (void *)new->nr_deferred + d_size;
> +
> +		/* map: set all old bits, clear all new bits */
> +		memset(new->map, (int)0xff, old_m_size);
> +		memset((void *)new->map + old_m_size, 0, m_size - old_m_size);
> +		/* nr_deferred: copy old values, clear all new values */
> +		memcpy(new->nr_deferred, old->nr_deferred, old_d_size);
> +		memset((void *)new->nr_deferred + old_d_size, 0, d_size - old_d_size);
>  
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
>  		call_rcu(&old->rcu, free_shrinker_info_rcu);
> @@ -235,9 +247,6 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  	struct shrinker_info *info;
>  	int nid;
>  
> -	if (mem_cgroup_is_root(memcg))
> -		return;
> -
>  	for_each_node(nid) {
>  		pn = mem_cgroup_nodeinfo(memcg, nid);
>  		info = shrinker_info_protected(memcg, nid);
> @@ -250,12 +259,13 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  {
>  	struct shrinker_info *info;
>  	int nid, size, ret = 0;
> -
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
> +	int m_size, d_size = 0;
>  
>  	down_write(&shrinker_rwsem);
> -	size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> +	m_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> +	d_size = NR_MAX_TO_SHR_DEF_SIZE(shrinker_nr_max);
> +	size = m_size + d_size;
> +
>  	for_each_node(nid) {
>  		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>  		if (!info) {
> @@ -263,6 +273,8 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  			ret = -ENOMEM;
>  			break;
>  		}
> +		info->nr_deferred = (atomic_long_t *)(info + 1);
> +		info->map = (void *)info->nr_deferred + d_size;
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
>  	up_write(&shrinker_rwsem);
> @@ -274,10 +286,16 @@ static int expand_shrinker_info(int new_id)
>  {
>  	int size, old_size, ret = 0;
>  	int new_nr_max = new_id + 1;
> +	int m_size, d_size = 0;
> +	int old_m_size, old_d_size = 0;
>  	struct mem_cgroup *memcg;
>  
> -	size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
> -	old_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> +	m_size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
> +	d_size = NR_MAX_TO_SHR_DEF_SIZE(new_nr_max);
> +	size = m_size + d_size;
> +	old_m_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> +	old_d_size = NR_MAX_TO_SHR_DEF_SIZE(shrinker_nr_max);
> +	old_size = old_m_size + old_d_size;
>  	if (size <= old_size)
>  		goto out;

It looks correct, but a bit bulky. Can we check that the new maximum
number of elements is larger than then the old one here?

>  
> @@ -286,9 +304,8 @@ static int expand_shrinker_info(int new_id)
>  
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> -		if (mem_cgroup_is_root(memcg))
> -			continue;
> -		ret = expand_one_shrinker_info(memcg, size, old_size);
> +		ret = expand_one_shrinker_info(memcg, m_size, d_size,
> +					       old_m_size, old_d_size);

Pass the old and the new numbers to expand_one_shrinker_info() and
have all size manipulation there?

>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
>  			goto out;
> -- 
> 2.26.2
> 
