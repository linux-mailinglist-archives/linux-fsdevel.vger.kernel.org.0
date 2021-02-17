Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900FD31D3E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBQCBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:01:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBQCBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:01:37 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H1xhkR031111;
        Tue, 16 Feb 2021 18:00:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Y5psxNieaEBjSwe5Bn43MI/BltHa9/VgK/FqzwqESzs=;
 b=WAyMIO5VVKDWDK+MPvwhFFiCPGyG2nbYPDP54miJEKt7KXa1EB+J7Hg1m4eshr3j3fA5
 DSemCAvyc6NZGlnjOqcGqJ4rxCcxEw0+ENOeODP8psfabBkr9i9fNe6OXdiogD2gEANU
 Abtuvlp5PhqhYB3Du+ub8LFbF4WYBJZk00o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36qvx30q07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Feb 2021 18:00:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 18:00:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC7YxDoPvUFhoj/aPkJeNOgydohiRlap3Le4iUZ3xQ9HffEd25SmlNeRuIMn5olfoXWIs+c7d9zyhv8I1BH8742y+fMmbap5jodjONav9r+betKXpHcNIicNRMRt/LOrKqomYHfz7VPs9ujurbGzwiulMAGAGkOto4LE00rg1lmPP/yn8vc1jICfLGkK6uCmFPYU9OGBfgYrv9TYDT8eFjNsXm4YaIQq45X58AiaGPBqs3f93xIN4wMUse6CG/8qIeAhjrocy9GKRXRyVEEExmjSKCfaKNdOmu81i0tKpZgxoOIhC/xNAD6NKLSdwX07xTyCNiJHN5keOejCXS8Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5psxNieaEBjSwe5Bn43MI/BltHa9/VgK/FqzwqESzs=;
 b=k/k1ULhA5XumqkQ0V9DbB42O2ha1LrWL6m6BgUgmO4xRCwK+WOCWX8mUXJ3ziT1ZdgetH1f1445UaRwvzJGoPg9QV/3JAvtJwiVPf7uS0AW0Krisyf7eDIBM2Z5nfFn12wUG0KoEFqZh6+KhYpRIfQ8F5YENBzJgTRJpgzLCbOM4G5Fs8wIsZpEJ5R5hV08tmRjw+zS4o1oqrbEnA9Qpaqmr0FiMxl3RW7kh0PZL5JNQ8GqchEbNJ2qERhKMoNG0IGoCWVhBfx8iaSLMulTiPNWBjGDaaSbbE8+gZidKcwpYAmZdt5edN8WLmDPHjoeoq5inyRafF67AnLzbTmEkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 02:00:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3846.043; Wed, 17 Feb 2021
 02:00:38 +0000
Date:   Tue, 16 Feb 2021 18:00:33 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 08/13] mm: vmscan: use a new flag to indicate shrinker
 is registered
Message-ID: <YCx4wQRgAF5o0GW0@carbon.dhcp.thefacebook.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-9-shy828301@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210217001322.2226796-9-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ed2c]
X-ClientProxiedBy: MWHPR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:300:94::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ed2c) by MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 17 Feb 2021 02:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d1eec9-6f0d-421b-816b-08d8d2e7d2a5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3143:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31437F3A3453AE88F5503143BE869@BYAPR15MB3143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAYILna70AexxnqV8l9/lPXM5KyLdl54ImKLNSxl/S194Vlt1CbkgyL0FqvoQmJ+qQZ7rTiSVkO7LCD86VhVnqwOTYkXgR/qfrzs8zlajIlVlMqsXwNx80VGALlL3pWOiNariq2J33OaKjHR4MkVPzqW6u2sMYWKxp3I5E7efMLfGKVtlQ6AE23+zhQVGRitchRWd+8S3GFcPxLFxYKjgY6JCPPyA98Rs/hbPpCkmh+QeKdWnPLGVJllCLE51Qn4x8/TimSBB0bigtalIMTWWropAezH922Y2TnQiuQPvzN4VfL4ols1OtwbOB9lkZCoBqAy0nSxTXmNMsrEr8+6jElXqC2PaU5BTd4novMIboSAiybuo/xRI3NKVA6MKpIBawldpt6YE7EoHVAyVtDhVF5xdFQlsNm5hmXlVmXoo4pfJfwq2IZDVjU+7YQKeO13T5Qzqb80e/7bIk4/mldLP7zeOK5zQE7CpLqCJW79C2MgUgexTR4ElmnNvQfebcjCvN/T7erpberWmOX9Va+Ulw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(8676002)(8936002)(86362001)(7416002)(66556008)(7696005)(66476007)(83380400001)(5660300002)(66946007)(52116002)(478600001)(6506007)(316002)(4326008)(2906002)(186003)(16526019)(55016002)(6916009)(9686003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cGX4R70x8voCGdC8oXx0c/PZ1IRZliEtMo8BxIecXlCGXmntyad3Dvm5WtoX?=
 =?us-ascii?Q?QxreMgUxJr4/SAH03RXrJyaY2Fh+5KIbVG6UkM5aUc4HGuaEVVN+0ZnoacUx?=
 =?us-ascii?Q?8TV1IQCWCc3cwwjJxYlrzjjH2A+Bbb1I4ZL82W5f7jAwr9zyk5pPRTev2ic5?=
 =?us-ascii?Q?6r6vLLZ12+srOUtaFp2C13loHJ3uh5Ds9xQnoGo2daj0iBKxS6Ss2bxX+ZUx?=
 =?us-ascii?Q?nuNpSnMI/xPjLKKXjlgRbyBlWO0Bo5Ci58IuVWipF5GV2zz0BeGxHGoUJt9P?=
 =?us-ascii?Q?pw417Dhdmk8DAfp9BEvefM8Hq1mhP5sn/sDGViCJ+uQRsVv+ApYPl0UbYJnx?=
 =?us-ascii?Q?lfJcD1R/poHSPwOmiJc6EGhKV1YAvCBpl0VgX/9Hup8fYG1+Zc3JHoVQuFaU?=
 =?us-ascii?Q?80/iTu+av7Y5sFN/Cd6dYh16XxSQq12tIPB/UzH8ymHHcOfAj7kGLrrYNeIX?=
 =?us-ascii?Q?5z7zjALANX5EGzqTtqd3CgboJ25YSkpijhzZ5XL1G7a2qpQYEbgFShUTiv26?=
 =?us-ascii?Q?RJkF72M1hwm2zsAVZFwwpJga89BGpz+c11d/yeWnP+JT2aWvogaNNoOHnhx+?=
 =?us-ascii?Q?8FNUn5eHVOEWUZkj3tIMTIUAZvq3ir+7XzEOzXppqt9h7Lwdvbtx/kjuz/LO?=
 =?us-ascii?Q?K8+FSCZ/nOAF6alMtBE3uGa8j0BOU9bb/0leUgemFoDCd3RzY9nZkq2nluRs?=
 =?us-ascii?Q?2LPZ1MR+wNkRJQT+3VPN6SP+D+w9w7Lb8rZ6ICkObOXvDAO9mAc4LdP3yzuT?=
 =?us-ascii?Q?z7udRzh9axrhZMuqsptennXv1oErRoQcAHVcjCxZ4Gbo8aSFLykFI7HTmo5y?=
 =?us-ascii?Q?mhT8n8Rx/W+cbibYEgpzuzuj8SQstsbY4RfzD1OXrppHdELjmDAnt3a674Pn?=
 =?us-ascii?Q?j8WhJWo+nRkzfzI8PSwgkhVgb/F7TYO2BwM++2NySXc/rnq+jPCez2biHVY1?=
 =?us-ascii?Q?UKux4TMKUO4Mh7lT00BhTF6Mq4CmE5M0vNVCylFCsKnErhDyzVvVHuPGIMqP?=
 =?us-ascii?Q?k80MmUqvAOBZ3FyLATJfQmDLc1HlgllYd8VGp3GgENKq7ASmSOCzn0d8FFyq?=
 =?us-ascii?Q?BQ9W2XEWI1Lzqb3qGAR0gjBSPBx18U42C/CJR3Gx/JV5MDdsVkZ2z8Cf4f92?=
 =?us-ascii?Q?uAnRX+B/yNnHjpFsVAINhUKE6vNofiG/cocTDUbj8NiFmWbuNGsUk8h6SDPG?=
 =?us-ascii?Q?PkzKuPcPESbuBMgKa0cQ49fEMgS+aHU0HqCnsa+kzl80Fzo5b5L1LDqIfIPi?=
 =?us-ascii?Q?MZlsAC48067na2YGT/7s2oBalTluUO9gXPIBHqxxKO9oKiD5iLmQw5JFLpyL?=
 =?us-ascii?Q?nIAm48CkzhG0MjEMTcPm3N+OSjlBimSR8z2rAYYzL7dGXQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d1eec9-6f0d-421b-816b-08d8d2e7d2a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 02:00:38.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dd7ckkd4pqOhEHHvb2jCyk5xQbClvTikKnjCceOnzdhq9sqS/IF33ai6BwPzpSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_15:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:13:17PM -0800, Yang Shi wrote:
> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> This approach is fine with nr_deferred at the shrinker level, but the following
> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> from unregistering correctly.
> 
> Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> successfully by the new flag.
> 
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  include/linux/shrinker.h |  7 ++++---
>  mm/vmscan.c              | 40 +++++++++++++++-------------------------
>  2 files changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..1eac79ce57d4 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -79,13 +79,14 @@ struct shrinker {
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>  
>  /* Flags */
> -#define SHRINKER_NUMA_AWARE	(1 << 0)
> -#define SHRINKER_MEMCG_AWARE	(1 << 1)
> +#define SHRINKER_REGISTERED	(1 << 0)
> +#define SHRINKER_NUMA_AWARE	(1 << 1)
> +#define SHRINKER_MEMCG_AWARE	(1 << 2)
>  /*
>   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
>   * non-MEMCG_AWARE shrinker should not have this flag set.
>   */
> -#define SHRINKER_NONSLAB	(1 << 2)
> +#define SHRINKER_NONSLAB	(1 << 3)
>  
>  extern int prealloc_shrinker(struct shrinker *shrinker);
>  extern void register_shrinker_prepared(struct shrinker *shrinker);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fe6e25f46b55..a1047ea60ecf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -314,19 +314,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  	}
>  }
>  
> -/*
> - * We allow subsystems to populate their shrinker-related
> - * LRU lists before register_shrinker_prepared() is called
> - * for the shrinker, since we don't want to impose
> - * restrictions on their internal registration order.
> - * In this case shrink_slab_memcg() may find corresponding
> - * bit is set in the shrinkers map.
> - *
> - * This value is used by the function to detect registering
> - * shrinkers and to skip do_shrink_slab() calls for them.
> - */
> -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> -
>  static DEFINE_IDR(shrinker_idr);
>  
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> @@ -335,7 +322,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
> -	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> +	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
>  
> @@ -358,9 +345,9 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  
>  	BUG_ON(id < 0);
>  
> -	down_write(&shrinker_rwsem);
> +	lockdep_assert_held(&shrinker_rwsem);
> +
>  	idr_remove(&shrinker_idr, id);
> -	up_write(&shrinker_rwsem);
>  }
>  
>  static bool cgroup_reclaim(struct scan_control *sc)
> @@ -487,8 +474,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return;
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		down_write(&shrinker_rwsem);
>  		unregister_memcg_shrinker(shrinker);
> +		up_write(&shrinker_rwsem);
> +	}
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> @@ -498,10 +488,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>  	down_write(&shrinker_rwsem);
>  	list_add_tail(&shrinker->list, &shrinker_list);
> -#ifdef CONFIG_MEMCG
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		idr_replace(&shrinker_idr, shrinker, shrinker->id);
> -#endif
> +	shrinker->flags |= SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
>  }
>  
> @@ -521,13 +508,16 @@ EXPORT_SYMBOL(register_shrinker);
>   */
>  void unregister_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> +	if (!(shrinker->flags & SHRINKER_REGISTERED))
>  		return;
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
> +
>  	down_write(&shrinker_rwsem);
>  	list_del(&shrinker->list);
> +	shrinker->flags &= ~SHRINKER_REGISTERED;
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
>  	up_write(&shrinker_rwsem);
> +
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
>  }
> @@ -692,7 +682,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		struct shrinker *shrinker;
>  
>  		shrinker = idr_find(&shrinker_idr, i);
> -		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> +		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
>  			if (!shrinker)
>  				clear_bit(i, info->map);
>  			continue;
> -- 
> 2.26.2
> 
