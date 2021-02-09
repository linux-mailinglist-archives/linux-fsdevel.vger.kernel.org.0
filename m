Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6D31587D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhBIVSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:18:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233880AbhBIUvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:51:15 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KnSVg016397;
        Tue, 9 Feb 2021 12:50:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vkbFSeG12qjtqWGZ1cLrNStLF/uUfv+dv/n6YVleQb4=;
 b=MNgXNOOvxmemYLtjUKO5gwMy4G7+AwGexEUyDiLYKdwbzTbon3k+xa8uhbde87fm1aN1
 ZgQJRQ8qmMwCJL8abSc5nFVxRidmzfMdqPh6wHQUAjWIuYGd484461egymH9Ormd/ZrN
 ni7jonrx3LfcmRWVG42L41pBm+mbNiha9xU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jy96ts3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:50:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:50:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul8pE+uUc1WF/mh3wNN20fN2n7m9jT8Kv4r8rYal62xi0VXpPPAcM9AVnGs18einpeTQSVHAVIG9a+7vjbiNodYEyWFbj913NxDhvfmQk8utwRZUcbQmdm0D/uzftZylnKMz9BB7WkP/CRLxqtL1cp99B5vq5QJsWDQ7VPIpF0cfOv4ZzPuBqIJ2SK39uYTQneMfieV4AIyC6GGbDuZryuR/yw8oqOsPZC/R49HqF46fDQitbvSOUVkbVzEnfJEQ2joOMRFerUejmYzJpTij6N8geHlL/ffifoAkDTNh1Tivss1fOG11zhXHtluFBWituBcXQsjIYfoiRh7dyFjTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkbFSeG12qjtqWGZ1cLrNStLF/uUfv+dv/n6YVleQb4=;
 b=NBZeHrvllKbMxGfInjl91dR2kDNO8tz6k0tCcuDH3rhVmqaFzKPGQI/Sgbzo3xdW+MfglLtUStwTmvLBC/XF+BdBpP1oUYaUgiN1mg5ThvO8wWC+O4+W2i/rmr3p3J5pgghwpWKpyNt/rfi0KIePz1fesil6TWtD/oZKxySr/3z8hUQKhp4bBBe8zfkyrsrbhx18uvIcuS+7Lt4SqjL9fwGpmz7AIaZMj6yzA0l74lpOtXVV0VWBiDHqSO15vPeeckD4YobnDwbnXAMy7T5wpWPREpc8Ox0403pUtXgWQfBGVRhcUMu+I1nAlgC07pu6kH8zXg9E6EECYurffzuZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkbFSeG12qjtqWGZ1cLrNStLF/uUfv+dv/n6YVleQb4=;
 b=cXVPHfgXySaCaxthacsAsQhhJ42LycnqZAsvick83QyX6KWU3PAVYipEFyFYXK+eNe7l+DYJLRZPeHRflWnHe61o+kvcRAh7GB0Y4aMmlzyXppr0ThGLfXcgZbJ9/aPppn7wvL7BE66zlQItK97L92fgYIorqf/vwiqgRyeK9yY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3032.namprd15.prod.outlook.com (2603:10b6:a03:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 20:50:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:50:18 +0000
Date:   Tue, 9 Feb 2021 12:50:14 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 05/12] mm: memcontrol: rename shrinker_map to
 shrinker_info
Message-ID: <20210209205014.GH524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-6-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-6-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:dd9b]
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:dd9b) by SJ0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:a03:39c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27 via Frontend Transport; Tue, 9 Feb 2021 20:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16c39f5-a01f-477c-a006-08d8cd3c4f0d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3032ABACFAA8C225AE2992D3BE8E9@BYAPR15MB3032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdwKhFxo0sD080SVtq0z/ixtIzymYb2tY5LhpzqOKG3M00VOoKLYw65/9ZqLENkMdWwbWCNyKsASIoKUlc3u9gkpTfkmLuoeE7vWPAyjvPxWfMG6GTbRmeV6ply7U7+w6eV12s+9BKM2ALdYDrB4Xxnx6z7VVZaM9R0i2w6Wc5WvJqXRkqiP8o4yHb1PCFj0haCBWot1n+0cBSEyF7NvV0J2RMJ2EMp4Uu21jPdzfLLfxmb4AhbCiMW/+jgrkwkIdeI+uHiijqmPq6l417BUvFRq1lXWsa1jfDmtfgftlGNmOJ6vwgFS6HuYn9D/1dMH13n2I0/hK27DQLWUVU0xcawusIookUsntTENYuwOkzcIw8lg4fU7tr1jwBb3TCf/6RZ/CAw0kMJMOaxOaWCV/im6pLPgtPR2hKwm5AVemj2hz8tjEY0I0iQtpVAYaF7eXDEn2rl3jvA9f7CS0yV+ByQbBPjjy4rjhAmPO06dO6M6cADCl0FMXGHfyR0Hgxr2FP7N6yM0OXgPahZ7cvnVEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(16526019)(6666004)(4326008)(478600001)(6506007)(86362001)(186003)(83380400001)(33656002)(66476007)(8936002)(6916009)(7696005)(66556008)(1076003)(5660300002)(2906002)(8676002)(52116002)(9686003)(55016002)(316002)(66946007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zFkyQ9pDq+PdQdo0ev+4hCwynq4Su/nccdPTf4Hz26veQr7d2qso058DYCZh?=
 =?us-ascii?Q?x05am7AGVm7RQ/FfpYCQP28nFmYg1ixqtm5Sg9uPDwAgDo2cZOVwW3OuykZa?=
 =?us-ascii?Q?5+hbVF6SSGj4uqP1R3104KoSktPM0oq4pkqe+JWazlPYYdEo2IeQr+EYEi7p?=
 =?us-ascii?Q?T/6bNpxFAdT45Mn1zMhgTpPdMqsTgGOksPzRdnivKC7l0lX792VBSRTvpOdZ?=
 =?us-ascii?Q?+OjW3RRjT2mZln6jBTR3keWTaLQkxfsUItmS9O3BISUIaj0LCfSVdwyN5jwS?=
 =?us-ascii?Q?oxRyV5Zed+ZY1noS0MBXteEtUQVUMomh+rj8Ds2NB+nNnEGQI7MRcI1vMksL?=
 =?us-ascii?Q?bkN6bzv55q8I6zZnXMfQX1gIkMr9+xH/vcCiRdDL+V5hNTnOrgZm902lznOX?=
 =?us-ascii?Q?A3uLYeJ2dGaOdvD5SGwdyzDr3+jkySBkr6uE6BJEhPL3Whnh26OUpG4KY08u?=
 =?us-ascii?Q?tyyJxW+kiaSR7lQRuZqJJWfqVCPhy5zvBsFx6nXIcqeRZvdQY5L3HZQOYtLc?=
 =?us-ascii?Q?jv1t8ZiJ3npd8/AatmAlgvg7MAoJbr/DMjuZX2j7pZriKHBC4sRbtNrEzqhc?=
 =?us-ascii?Q?cu2uf2Nvjq8EY2c+SmKpaYpKbo737/Gege9dWeFGrL0CaW0Ceychc8QCo11i?=
 =?us-ascii?Q?vo4tgm66LnWHFucI0/km1e9YF4J++1JS0zsP+qYVo1jzqmmG81rixPlehNSf?=
 =?us-ascii?Q?5Z+tz70x18AdwwhFCvD8l2NSzrNms8X4QI6/5Jv4aW7zmIVviW7W0Uj5rFFG?=
 =?us-ascii?Q?7ZrNrGtCjKEhGhfvcdcsNVGWIBd3rieViEXjR/npvyjVMvPrEs9uwzEBzsdV?=
 =?us-ascii?Q?HTkhejMfi8CuLyaFMZ4Aa5H0LpBITfMWiqXu9N9I/1sE+/OIOdot6i9ONb6B?=
 =?us-ascii?Q?HMc6srYcs+LvPXajkll3vn07q/FIRjT4m81quBwpLuHpzqPe2qZLE/GhYPAo?=
 =?us-ascii?Q?35Y9OfZAOvVTkfhzkOxDBtIyoLeCursJm1AB/P8Qkmf33cC4NC6TksEUyxvH?=
 =?us-ascii?Q?tOUbQS97oxiKVGO2AqFERFXKLXKm4ncSrgtNPh/laHwFu5VbojvzKa+4FqW7?=
 =?us-ascii?Q?sGoOHTSODjPoeADEzB/JSvWGJeV2lErztg0+wAZdIkuH65L+jp0SyTrEDq04?=
 =?us-ascii?Q?38gTA+vn40GZTODs1yAdiEwKuZrENnrySm4KexQlg+pxDBNCCk4C2w5J4aRD?=
 =?us-ascii?Q?SGCWEwzsTh40c/kImgi1RtKjdH0aecikBUCP70Rt92w/tvX6pS7t/sn0ETv4?=
 =?us-ascii?Q?bUknajBIxEsTjitCf/jmO84SzocFpzpjFETxMnA5IbDwCo+PuVgVwPxqdnpU?=
 =?us-ascii?Q?Hqh6nE23AUcDxs78CQ+rED4vYvltnEAcaTC70ys+O5wmhQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a16c39f5-a01f-477c-a006-08d8cd3c4f0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:50:18.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNZ0OhGDTmDzDqMnKXvlk7ZZ2dCSvfbW2IunYz3lJfyBXbU3ivEgcXf4tn7Ke+is
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3032
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:39AM -0800, Yang Shi wrote:
> The following patch is going to add nr_deferred into shrinker_map, the change will
> make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
> And this should make the patch adding nr_deferred cleaner and readable and make
> review easier.  Also remove the "memcg_" prefix.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/memcontrol.h |  8 ++---
>  mm/memcontrol.c            |  6 ++--
>  mm/vmscan.c                | 62 +++++++++++++++++++-------------------
>  3 files changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1739f17e0939..4c9253896e25 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -96,7 +96,7 @@ struct lruvec_stat {
>   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>   * which have elements charged to this memcg.
>   */
> -struct memcg_shrinker_map {
> +struct shrinker_info {
>  	struct rcu_head rcu;
>  	unsigned long map[];
>  };
> @@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
>  
>  	struct mem_cgroup_reclaim_iter	iter;
>  
> -	struct memcg_shrinker_map __rcu	*shrinker_map;
> +	struct shrinker_info __rcu	*shrinker_info;

Nice!

I really like how it looks now in comparison to the v1. Thank you for
working on it!

>  
>  	struct rb_node		tree_node;	/* RB tree node */
>  	unsigned long		usage_in_excess;/* Set to the value by which */
> @@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -int alloc_shrinker_maps(struct mem_cgroup *memcg);
> -void free_shrinker_maps(struct mem_cgroup *memcg);
> +int alloc_shrinker_info(struct mem_cgroup *memcg);
> +void free_shrinker_info(struct mem_cgroup *memcg);
>  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
>  #else
>  #define mem_cgroup_sockets_enabled 0
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f5c9a0d2160b..f64ad0d044d9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5246,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
>  	/*
> -	 * A memcg must be visible for expand_shrinker_maps()
> +	 * A memcg must be visible for expand_shrinker_info()
>  	 * by the time the maps are allocated. So, we allocate maps
>  	 * here, when for_each_mem_cgroup() can't skip it.
>  	 */
> -	if (alloc_shrinker_maps(memcg)) {
> +	if (alloc_shrinker_info(memcg)) {
>  		mem_cgroup_id_remove(memcg);
>  		return -ENOMEM;
>  	}
> @@ -5314,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	vmpressure_cleanup(&memcg->vmpressure);
>  	cancel_work_sync(&memcg->high_work);
>  	mem_cgroup_remove_from_trees(memcg);
> -	free_shrinker_maps(memcg);
> +	free_shrinker_info(memcg);
>  	memcg_free_kmem(memcg);
>  	mem_cgroup_free(memcg);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 641077b09e5d..9436f9246d32 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -190,20 +190,20 @@ static int shrinker_nr_max;
>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>  	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>  
> -static void free_shrinker_map_rcu(struct rcu_head *head)
> +static void free_shrinker_info_rcu(struct rcu_head *head)
>  {
> -	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> +	kvfree(container_of(head, struct shrinker_info, rcu));
>  }
>  
> -static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> +static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  				   int size, int old_size)
>  {
> -	struct memcg_shrinker_map *new, *old;
> +	struct shrinker_info *new, *old;
>  	int nid;
>  
>  	for_each_node(nid) {
>  		old = rcu_dereference_protected(
> -			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> +			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> @@ -216,17 +216,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		memset(new->map, (int)0xff, old_size);
>  		memset((void *)new->map + old_size, 0, size - old_size);
>  
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -		call_rcu(&old->rcu, free_shrinker_map_rcu);
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> +		call_rcu(&old->rcu, free_shrinker_info_rcu);

Why not use kvfree_rcu() and get rid of free_shrinker_info_rcu() callback?

Aside from this minor thing, the patch looks good to me. Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
