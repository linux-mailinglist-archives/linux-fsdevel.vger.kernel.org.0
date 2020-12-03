Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECCF2CCCF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 04:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgLCDCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 22:02:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55576 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgLCDCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:02:01 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B330CQh022783;
        Wed, 2 Dec 2020 19:01:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KeepL3Jg8adxcpRkOPN/NUKQHEXslogVJDa9TE6qEgQ=;
 b=f3YKcY5QjzElBPawnph61D1HBjcHz7ZHBd2SJjjGWQGC08pN//h6MEbyGlrINw/6Q38F
 WXITC47CMRLywY6L0Tc1gkVQAjqBcZ/stKWivMBrUezmFeqwHYuQdYkq12oVIRIhmauG
 dFUSfjitQ4M7UsxTTJsZPDFDOSGpe1wW6zc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfkaasx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 19:01:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 19:01:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6BIwntwwGrTkLDQ7XVSFoPx5m332L45PPSk/LwjvzwdZWUn2k2qmxB6zk+EMRdzNFR21KYgWJ6UV9GPwxMwK6yfBh7QV9uKGNmuUjxgfohTYIzBOEWrRK9S0lL33oB9THu1gvSJVJwyRJ20NNDMDBJsH+1aC5ueppubuvbiLymyB1PxnwaZ9zsIxMMYg4aNu+u3NhFWpgG094IWeBUeiKRkEvLytlc77GGgn084Qyd8rFEECWjuw/8I1SevB1tblnXdoELeQeB4LwWOXrdJ3UCBpzlRCDht/0VyBVtKSnw/QDE89OIT8d0Xo0bSOPj4qHUh9wBITw8w4PH40Li70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeepL3Jg8adxcpRkOPN/NUKQHEXslogVJDa9TE6qEgQ=;
 b=VC2a1GYDb+AMtsMPFS5AROEVlIcbjKHoawm8RCr1aPkxEpp+PnJnFs1U9qjg58W9YkXRyvY6wFnV17rCUy4FK/PVPlZ70Q/qO2wAjs1wqF9tT2DFOCVzRfWIQUxSDg3dR1QKAz8UQcViacINiXq7Fw3dO3RQMYAQ64JRro14mUsQbM3Yom3JxWvmi5hzDnsfG/MS5ttr306bctI0IHSL9zwihO47UNGu/by6S6h+6ibbftxaK0oDRy01A7OmOLUZUQ2uQrP9fGHWacFnO0FOCz4ce7AK5yTNYi3wcetUqlB+uLZhf8zGp5C/o+xjbcY8pfbOVED4VXJHhACEh+I21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeepL3Jg8adxcpRkOPN/NUKQHEXslogVJDa9TE6qEgQ=;
 b=fsvrRLcqPp2BB3TtxattfQWWZJ4NvcwZEQC2S4kNvsy3+od6V1l+n3XjU0SScpvS+VZ8XSuTiqWuVrMcW8g4GFH7rhiJOm9YYZ0stFu/UVHZa488wBDcTrYj5q+RB8CMGZKtK1iNMkjsBQBC73qZmsmyQ+C6wLC4RxG0SrNAbE0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 03:01:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 03:01:08 +0000
Date:   Wed, 2 Dec 2020 19:01:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is
 registered
Message-ID: <20201203030104.GF1375014@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-5-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-5-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4a99]
X-ClientProxiedBy: MWHPR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:301:4c::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4a99) by MWHPR15CA0058.namprd15.prod.outlook.com (2603:10b6:301:4c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:01:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd270963-df12-454f-1cac-08d89737aeec
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR15MB308043DC9591986AD5411250BEF20@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miv4FXzDy+ezVOzfnVXYjSxfcmqoxEEhh1JrnWmE5baMcUinzPHyTAwBDebbdq3uyVMvKR9ws1D/dEJFdTwgrUGp+2YfRqu0CXpFz0lZCJ8j/V5/jp2tqUFBnfYI21wcGGSGdqqjW+m2doEMKk54RUimCWMKNlPFFy7RWG3KHJaytYjV0DaNgdm+9CpCeLmzg2/sCX3Pi8KrrF2HwfEeGbRJbpKPK/bP/xvL2mpT1kK9WbZvC7EPjBYqAUoySnmnIrMzQYLX4hA0PX3U3KIhPinQpeeZUhExEgsjbmSb81zcfGtQkdXSOSlxVDxqbSlpLFKhEbWF0ysy/pA48ngOfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(1076003)(7416002)(6506007)(2906002)(86362001)(55016002)(8936002)(33656002)(9686003)(83380400001)(5660300002)(6666004)(8676002)(186003)(6916009)(66946007)(66476007)(16526019)(66556008)(478600001)(52116002)(7696005)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x7YyvQpNAe7YuBVEzzeZ0sdsJduvPfywKggzhz+OYI5FeX4OqTM1Kz3AkzbY?=
 =?us-ascii?Q?ZvmMBEyZIRwJYKnWHD4gyCi/J+HHCjjvSJ6GRuIK9tHjr9cuuJ2KosKFXedq?=
 =?us-ascii?Q?pWEvRB2eA0CooMb0dFolL5KWu9DjPyHZg39mK2i+9UXz5RS5QETF1WCaoch4?=
 =?us-ascii?Q?aosVuYuAlMGxfpd15b5pI4h2a22cMnXUUtFjY4ZGC+3WhTfmbCHFzT+BXO74?=
 =?us-ascii?Q?3XRmh7Gs7dpLmG727kNmE5k3ostgfgWnsv3wFYAC0MCjlbWn1jA3ShFM1GBe?=
 =?us-ascii?Q?cHosJIeZ4b+A7FJ9XJRVmjiXzHjitsd+Q4fv+mfCUFFlmfAYovST3E/Vt39h?=
 =?us-ascii?Q?HQtQFgYG6NazvS+Jd+xTCmvx2n4IfQnZgYXGgb6Q3BXA2cfAQlZpyD6MiWUH?=
 =?us-ascii?Q?iJMzZMoMAX/9O+hBJzjQaThGW0VdIwRcURSTfRFN1H0KL0aXTrU+8fsm69GX?=
 =?us-ascii?Q?V11wC/iqSx3Gzi9XrZp+W4s3riSCBtiwg6kCd2frMODnSMqerXL4p4X8i3F1?=
 =?us-ascii?Q?UcekxZwe6Ng/yu7LzpvPYUTP09x0GGhCRnLhS9X4+AtnzMGOZPX3/484auyZ?=
 =?us-ascii?Q?8KdTWw4wU0D7kHy9NE/i4/Zt2S55gKq7aqdz3asZvRtP0oCDPS5qpRzXT3DF?=
 =?us-ascii?Q?4/+9uD6DZiDAdw6mQvxO+LxQ/H4CO8KxafFXmMrnlXuSmO++li5YGCWGnMEC?=
 =?us-ascii?Q?wRGpkHIXUDKXJM/A2XtKj3iTIXe0fnLPXdF0m59xKh5hgxUSQPXZuMTaJ+3S?=
 =?us-ascii?Q?P6ezP6B8XWOQx+9+qmvuOPgL3bMOYGyxoEttcTCAdGibfugw1udkv8wyA7BO?=
 =?us-ascii?Q?zFloSnTSk+LSx10kA+oKbNlscuqLbP5CXdWbYN2lcSmprdp1Bimj8owp4CJx?=
 =?us-ascii?Q?B8+gOQbYDVd1zYLVsesfNKhz60/IHD0ciLBBEBbS2iK3UaIYNoyPEgpNQaHZ?=
 =?us-ascii?Q?caNbCFNhLeWcE/rzc50lQiqZEG76g/ZMIl7lYJUcOy1opYulpFrB5mfKau4X?=
 =?us-ascii?Q?0picLk3LmnZJEOoLYnjgm2zxvw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd270963-df12-454f-1cac-08d89737aeec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:01:08.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk6V4obzCuZxmPugrh5SmFfjk25Z/GBZOTWHjKb4ghPx5wGwvAgJzQ8OnBbEzS/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=5 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> This approach is fine with nr_deferred atthe shrinker level, but the following
> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> from unregistering correctly.
> 
> Introduce a new "state" field to indicate if shrinker is registered or not.
> We could use the highest bit of flags, but it may be a little bit complicated to
> extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> is called).  So add a new field in "struct shrinker", we may waster a little bit
> memory, but it should be very few since there should be not too many registered
> shrinkers on a normal system.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/shrinker.h |  4 ++++
>  mm/vmscan.c              | 13 +++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..0bb5be88e41d 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -35,6 +35,9 @@ struct shrink_control {
>  
>  #define SHRINK_STOP (~0UL)
>  #define SHRINK_EMPTY (~0UL - 1)
> +
> +#define SHRINKER_REGISTERED	0x1
> +
>  /*
>   * A callback you can register to apply pressure to ageable caches.
>   *
> @@ -66,6 +69,7 @@ struct shrinker {
>  	long batch;	/* reclaim batch size, 0 = default */
>  	int seeks;	/* seeks to recreate an obj */
>  	unsigned flags;
> +	unsigned state;

Hm, can't it be another flag? It seems like we have a plenty of free bits.

>  
>  	/* These are for internal use */
>  	struct list_head list;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 457ce04eebf2..0d628299e55c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -378,6 +378,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
>  #endif
> +	shrinker->state |= SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
>  }
>  
> @@ -397,13 +398,17 @@ EXPORT_SYMBOL(register_shrinker);
>   */
>  void unregister_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> -		return;
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
>  	down_write(&shrinker_rwsem);
> +	if (!shrinker->state) {
> +		up_write(&shrinker_rwsem);
> +		return;
> +	}
>  	list_del(&shrinker->list);
> +	shrinker->state &= ~SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
>  }
> -- 
> 2.26.2
> 
