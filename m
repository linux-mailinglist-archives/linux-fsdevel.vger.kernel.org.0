Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462EE315B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBJAn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:43:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234000AbhBJAlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:41:01 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A0XsYX030239;
        Tue, 9 Feb 2021 16:39:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MzjPkYwOAaZHK3ou+4Tv27gQc3vzJ3S7J0p/e8g/6yA=;
 b=lKB8Q59VQwiXI/rBszcJNX86Ixgdx8cwGB1kCMtX3S6LYojXipc/OxIZww63xGseDnQf
 EgQChmvtf0FA+TCz1qIu+9VarvaQZsqjMg3Io2n5EzCimw0OqF/RVvLJicpCdNvwmSlH
 x3RQ1IUGuiUWq8ZfRO8juOG4rjUlGX9/LmY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1ces4m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 16:39:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 16:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEowq5RSlhIhpe6OoBPSl9BB/Kcw9gGnAjb44Rdv55mZEFBioZoFE9oB8LCuq6vqTfhBajeFKliNdo5iyq5FyUgxPm5H+EYBcf5qFaYJraJjQGzRnkhXovQt7F6btfGFa3O1deN6Pmzi9VQfvn7vzl+bs6muN0v+KlbZB2drjRYt6bpq8FJQDdt497SeF3E8S4wrpXtwRwn9Q5WZ1QlOQ7p0/BFnWKUED1KM13yd89pKNQSqAr0aRzqbClH5l/Wa2pzOxWAqzy52O/ifh/s/btNCPMqYgvxtQQQSpAAhbaQW+PBnaEjocV5HehHJJ948HkSkILx72ODx88oWLlvJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzjPkYwOAaZHK3ou+4Tv27gQc3vzJ3S7J0p/e8g/6yA=;
 b=WUaiVaHNL/hUrQAH/VIijv3RxRqROnu7+zjVImWEAdu4OjFTaF5ZDT9iAXdkAb9eo6ofvBYHIWTixe7rLhfa93N+J/Z0qThkqdl23q7Gp159AbsnOv5y0lphTS+UTsB3yVYY2+DulRJV9E8XtSybGqYN95bukQr6K5u5wRfUfm+kY2jr7IFFVMcMMZZ3WSOQoAyQsMK/6s9rHlgTivlsyr3RKlJXBVtyhHaSZymBV8Weg4axM2JjE5jFfdvuHLRcYc1XMKLWxnJsQVRdVGfO9bSJwdHIHdtK9x/B0xQkOnEqD31h+s6r3SekVSzVv+cPHtn1BfN6cd2n7tdZxBcfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzjPkYwOAaZHK3ou+4Tv27gQc3vzJ3S7J0p/e8g/6yA=;
 b=S2VS5Hm+cA28dbVTrWn9o9oTT0Z05KHo2LH5x7SIPMmy8BflMQDopq2r3ZupcZDy3QzxDH1Y3MzY6ucmb4osim5G/u5mC2XROuwSHSQP2hTWMtka3lxaoEG4v5I1q7TQGvrIjw4PB+nCZfJ4R1QkeSrIZ44K6VYwIhMkEvAxeI8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 00:39:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 00:39:48 +0000
Date:   Tue, 9 Feb 2021 16:39:43 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 07/12] mm: vmscan: use a new flag to indicate shrinker
 is registered
Message-ID: <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-8-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-8-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:7710]
X-ClientProxiedBy: MWHPR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:300:12a::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:7710) by MWHPR22CA0066.namprd22.prod.outlook.com (2603:10b6:300:12a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 00:39:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e0961ca-6136-46de-f75c-08d8cd5c5eb7
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4758:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4758F78BF8161DFACDDAA46EBE8D9@SJ0PR15MB4758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN60FwpMA+jwNUZBQhjzRow677SzDX4H5KXYy+/fwYg/JTmBee++fwbX3pjfw1W5fSTFv5D+YDKDtn3ufyh8BskXc10YxlY47xxYKe0U6Z1PltPV048/eW9qrr5JhMdoo7IZ1jRXjjT6svKpxXtyPpn5lMQggQXtTtr8tBHHK3nKvxqUXZU2beInm8DlZByvmQVwTsvKAkV61DWQbk/XwpPfUtLNWuBCsrQ4y2hmvUZY9dkRQ2kLHpUfuveXiF9UPMJDQdu2H3AaPWERZbmNfpKiliqK0tECxxSfnhOjJEzpmJ4WBjgYMOmRZokoJ5T8J/3G6IBJN5UYUhsx4G1MLoQlmYAe1xoE13JKFUYm7zYw6aUSnk8ggAQAHYJWTnYLZTCbS2nBYkDGl6UeoiXMbh+211qebTLSp/tKjWu1KcCO4W1qCnh5W9dk1Eu24r3cCvWURVxqucY++olU1xhzfi0oI4zNY/Ziltt9IY0EAyBqtujyK+DQ0lp7TqOPL5LyfOBVoou+M+HGyP+Dxci41A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(66476007)(86362001)(6916009)(8936002)(4326008)(6666004)(55016002)(33656002)(2906002)(1076003)(83380400001)(7696005)(8676002)(52116002)(6506007)(186003)(16526019)(478600001)(66556008)(9686003)(7416002)(5660300002)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gq6CDp6uHoeN4+8w98OiXnekAHJhOYzN/3fskXtlcH1iCwcRnznKfvJUsnmH?=
 =?us-ascii?Q?mDQogf7gZys+Jh2zLXOdE83ciD4gIexNzkhrif0RPCQiCWDCFkE/qRKHmCUN?=
 =?us-ascii?Q?gwHGP8ritHZ/fDuUajv2Rs9pLRyA1PtnhRE93sxj1WbWeKNhwDFvFB8QZcFI?=
 =?us-ascii?Q?VHjDLW4O7jiEYQ/LV/oNjM2vnaKBIeesjt5kkgnm9gGkA8rFB47DePNsASZH?=
 =?us-ascii?Q?3y2bhZRLXqMHaamsQF2CK2RIF6RIhCaYNz1RPuk9ZZTv8xpvifGpuqsUDblf?=
 =?us-ascii?Q?ClvXuxYvqnjg6iFluvQ1JaS5AHxESnqQCOaUihfTsEHpIyaFOlPSHUx3Eekw?=
 =?us-ascii?Q?gEg7NCgiZ/CGz5gxi3ydvGN3wVHRamHfYZClRHaiFwK/i3YEpTafe4pPj+77?=
 =?us-ascii?Q?aT095AogGoiWXzPi5Jbe3ewnk3k6ncEdvrFF82sNoOIoSKEe21ItBo6m2OfJ?=
 =?us-ascii?Q?gXDUPlN/fVrARVaSkLCrbbzPwwMgn6ScNe6H6E9DIqaa2Tw+LfKUoUZHVVLY?=
 =?us-ascii?Q?MQmgGVcq14+t+3B1aXXZV9jciwoQTFFbr4EY5pOmPZurUdSeb62/RQY1C2C2?=
 =?us-ascii?Q?yZNiKxO/2FHMqfPhj562HtXTvm6UtVVkYyR3Z3EqdMJm83iNuDJh5ftHWWcd?=
 =?us-ascii?Q?fHK9/fGNNbw483iNFUmAujV717MA9BiRwmAAfQFarzhztSmE4KBW8WfgMpzV?=
 =?us-ascii?Q?qXeCfVsPE/6JxeKj5nCG/QrpI4JhBFm7tfdQemwTTpvLF14C80MbnjsPI6w8?=
 =?us-ascii?Q?6k7sqN3DlilIyiriaUGQ0J1D6xRnR5O8IKXdrRjMJgC9CGkWKXWuwEwabn8F?=
 =?us-ascii?Q?vIrRBDKyZAwtuQLHTtypUfUHAE0zVDB7W7OY9b9iiJbb2X7JtxvE30ubqdkC?=
 =?us-ascii?Q?29FUMYuFZtyrBhDxQ4bOSyw2D3RTQV/BsjL6B+PhvcLSTychAp350SES/u/x?=
 =?us-ascii?Q?oyJztsYc6L20SLYQVPum88SDfXO6embdZ0nZ7XLydmoo4H5FiM+cVaQkcsGc?=
 =?us-ascii?Q?iOY+crRzIMlstsReNLwR8rgR+Re0tS/0jKjxDmG+/LpTmjqOVJtlhNafI/I3?=
 =?us-ascii?Q?W15Qs0J2Rw9F9eHigNYzN3hbc6zvZKnDxvN8cRplTZxG03nse8vda8hKzv3I?=
 =?us-ascii?Q?F+4+kyNPpmtOkH9kxMxc9iHoUj2GunfpFMteBydClXXVLf5pCfc1VKC0/WVZ?=
 =?us-ascii?Q?0T5xzc6BcW7DIhxIM5vizB1ap1hTxnPEd0cC2CNkxOQI1uykMvWDSm7KTFSv?=
 =?us-ascii?Q?DDZGA2gHzd9/usFCdBRVchpBiCTrIcLY3LxXS2lIgMWJSFnCB/I2orSnLCvC?=
 =?us-ascii?Q?aSKeVsPr0mQJn4qGoobghEqP+8eDO89pv64Bg/qhBMoQ6HjMBk5eE9M0dTMQ?=
 =?us-ascii?Q?eDkF2v4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0961ca-6136-46de-f75c-08d8cd5c5eb7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 00:39:48.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiBVaYVDxDPirK/3l6dS8I2QMjR+FzcxvCccSr02HFNJSJgYQMTMtjkF7iDSEZaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:41AM -0800, Yang Shi wrote:
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
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/shrinker.h |  7 ++++---
>  mm/vmscan.c              | 31 +++++++++----------------------
>  2 files changed, 13 insertions(+), 25 deletions(-)
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
> index 273efbf4d53c..a047980536cf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
> @@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
> -	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> +	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
>  
> @@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
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
> @@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
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
>  	up_write(&shrinker_rwsem);
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);

Because unregister_memcg_shrinker() will take and release shrinker_rwsem once again,
I wonder if it's better to move it into the locked section and change the calling
convention to require the caller to take the semaphore?

>  	kfree(shrinkrem->nr_deferred);
>  	shrinker->nr_deferred = NULL;
>  }
> @@ -693,7 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
