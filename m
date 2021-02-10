Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE3315C2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhBJB0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:26:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234439AbhBJBYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:24:35 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A1NeJC020320;
        Tue, 9 Feb 2021 17:23:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=plU8fx3XQafRj/d8DXMdnwnkCZJtpbQvNy9TKIva//U=;
 b=ml6fx+Y9+Opgh8rY6NeCJ7pWEiPHvnmuANLk4fDtc5yqOqRPT+mn/d0SkadNd7091Pog
 urlRs7yriSsDIThkjMSCmErGvzzOcUBWX8yVPPDWMk4YG4xxI/tADSUnI5Gc1BUZl5mY
 gP1KRjV0g6NVvcs62PzKwUj3D3gAOFIYAB8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1cexwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:23:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaVHZdQGUhMGCGOlKdJLYENX7gRzWFkQpHp7E0V3Ww0UtNssMzfhNn476yHgxEX/2EIoc6c1oiwHOESNVCmpuQYAHd/W/FdOXQIWABOGNgxK3bnP+PH+PI+d2tsc6ahGzPu2sgapdPoWb5ioiHix+YDfd6IYDI4C1+JLl9z7E7yM513yfIrpORirknjqx7APjPaXxSuQYd2OieziwXdpCgV/KDQMyPNB3YCEbujn4FuSjWAMmv4feWV584eoZ6nMVgcIjWSipfpsKJdkzpG9oKm9ZFhF9fUkJamQfMHYSVSSyK1TvUwkCu9sYJkifjkkQEG9zlepFTtNyNjIuEi/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plU8fx3XQafRj/d8DXMdnwnkCZJtpbQvNy9TKIva//U=;
 b=E8tIoJtUgcDGMmDVWl50sNE+DM2ptjm+ZNvn4YUKz4fLErgGO8JJMQCT0ZbbRTfQj92bNsw0IUYkHrEAETXcJ/o3MTD/gopC4dXctsIvGkA2bWX08Jo40GU462ggD06xCqQMhZlxyrvin6jHaArWvhl8sn1RX5k66DcDW7QjEUrcCwMhCcp+qGHTdxDKzBdu0F3BKKSu+gihBvF0DeF2l8R2YykBdJ6lAISGP+zqAPoY4hedsIf1DwszywEqHX7XYROuglXQyOouEQ1YRfhu9wrAP1e9Efc9Zdl7SRo+4hPcEUclj9bIcAfPoZG+yg77AOhXYRwtfsOz+9V22VYNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plU8fx3XQafRj/d8DXMdnwnkCZJtpbQvNy9TKIva//U=;
 b=LWeBwo0FKj9mTgme17O9fMJ94E+QiK6mCVCleISPSiMsuG0kYHljpJQVhInr+RPQHNW4wu5NNUVeGf8gvIDFbIWd590v4brmDRFmWVsmifvHcY+FXzH/H/uJGUlp5ppdcvoC4f9z0VFjIGOCqLkNZE+FwpS23D5uzPG70A9VyTg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3350.namprd15.prod.outlook.com (2603:10b6:a03:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 01:23:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:23:36 +0000
Date:   Tue, 9 Feb 2021 17:23:31 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 10/12] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
Message-ID: <20210210012331.GN524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-11-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-11-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:390d]
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:390d) by MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 01:23:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a0aa32-b25f-4f90-a0f0-08d8cd627d40
X-MS-TrafficTypeDiagnostic: BYAPR15MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR15MB335064D527D9DDB25711725FBE8D9@BYAPR15MB3350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtkCLQhEKdcSOh4ZY9rGWZHvXP50DbHNXN3k51YZ4mOauNTcCYELto6gJ1rQs1KnxWRmKjpoj7xCkZMIH/M7aSZlLQwdE27QumUAc9x2YaXyBrhJnhVMegL5Y2r7YoSP9lub1aTfZByo4YUp6y3CXqHSPisL+ITxg3G0C7Xb7GrCowLnSpslaLhuP+GMvdJ2m68MUqL7I0JFw1gJfBeT/kIe4lo3vXDHw4WdsqE799I1k22tfBxu8IOH6di3y9eaqsGra/dXPv5jYHSxg2cTQn99ZeUqUu1jKUB9kfrPlPJds5dKqtEAe/KqO7L2veQoosG2Udwsi93JMVA8c62zbAo75TKx14QWBwxj7oay0vTSFtuSGoWft4evI6YXCEK0BeW2gNhCyTEZMseyTiQ7Ozi0Uqn8As5yk0iSb2zEj8KN3pcwNxkp9bP/sk046iFZNXXU3PO7q0GpaV0g+35tE7bqoJncU20jrxls3Z0xF8uObNk6bH47lbcDqze0S6fpQlotB38tiW9gbB5qhiae5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(66556008)(8936002)(4326008)(86362001)(9686003)(66946007)(66476007)(16526019)(186003)(55016002)(478600001)(7696005)(52116002)(6506007)(8676002)(2906002)(7416002)(1076003)(316002)(6666004)(5660300002)(6916009)(83380400001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zqlj/ca3iu1gm8+RgfjBBdGG0cXxcXq6cLD4nclqr/1/fRKyyLuMDn+TTmSC?=
 =?us-ascii?Q?MV2vEOrcADOthtD4ArG3khrkbyyB+L0cvW/qvM2yapwmj1SsJdR9JeM5NLW6?=
 =?us-ascii?Q?JLrYR+D7WdZOgaEsovV0QMzflLe/1kWA5Dej/vfPjkffG1980OJDzXeE4xJj?=
 =?us-ascii?Q?72qypVuHpch5jixsCEjWdEB4AOiBwL87nF8L1miLgyYKa0HiGTq4pjFctgW7?=
 =?us-ascii?Q?Ux6ODFj6BMaLwUSWdyRfMjTkhbcinfNDgv4tjht1HKPBrQd+CqxmTu1suHXX?=
 =?us-ascii?Q?rixBBqGTISZHcNQoqQIc5sPoaibG/Vut/tcjg7wt0PTlvs1ldiA8LwGXNi7x?=
 =?us-ascii?Q?XbWVC/tXUGqVxHY/IIxAzUZg1wYipsESK9FXzP3bMlarVxzejn1xzXhye0Ke?=
 =?us-ascii?Q?ZlPC5hg3an6Cm6TGiV8iiOpyDDQyD4QHDkQenXXTCrKza7wk6vT8X7rrgzBj?=
 =?us-ascii?Q?rBLyS0TeAl+QiW/tmv/nkgXQP1fPskTQp93IuegqJDrzCPyHWmXXDEZNOyR9?=
 =?us-ascii?Q?ildRKqLIAD6i5HOMoOzzc+ItrF2nyX6QzSR2rDRec90MlJ18cVBgedQDVw8+?=
 =?us-ascii?Q?X/z2B18dWh320sURAsduVWas7DXaiu1Mg9XmiYdQzUfaCnVp3xS7eORezhHU?=
 =?us-ascii?Q?S5cS4wx7hgvuqNdpelVr2NW2kGz9N8n8uaRue8CGBGJkKkcFra9nqXyLVBly?=
 =?us-ascii?Q?SBS07IKoxv+AriYbS1ju1RQABCBdoA7517qdSvw+Tp9NkHaXgqnsbYeYSGLL?=
 =?us-ascii?Q?qy1QfaMm+wqxT7PtQgq8hmUd1RLU7jMjUXG16K4nUNraJLVjSB70pH1ecHY9?=
 =?us-ascii?Q?lnII7C0WMCWjAHG5yHfZwdIaIUHvW5SKT/BzI1Jh9vt/3GPnukFFYf2nnunl?=
 =?us-ascii?Q?ZShN9F1J2F2o+nCbRKhZ4O8LVoZja0wRvV/U5qU7+11NU1sqY5aaL8yt4uWj?=
 =?us-ascii?Q?B8/GGl3D1qbnNf735E473sf7zIPz/p+aJvafZQnM4rcCa+7kSX8nswdZs8fX?=
 =?us-ascii?Q?Cw0QLGYREdQA94xaJKIhddYSps4q/M1kh7t5+sf5284Ut7UHcSx1Z2wAO0xf?=
 =?us-ascii?Q?mOcKcL2V/Te5zGa40hpgbVe/nc0eAJ/Ma2GDJ3OmisWmc2e4hjiG9ebfphWP?=
 =?us-ascii?Q?vqhW09+cvj/fx7lNzOOMfdfyVC9FkhfM+xzRmVMcKuQ7KBBhvFcHiWSH3Ru4?=
 =?us-ascii?Q?1WwD3hbNIt0RTxv+yW6HlMw2/o4DNnSmnLCulQidI23WRFUZFL5wcx2uwjc6?=
 =?us-ascii?Q?Q7qrPwTiIxauAMY8VVk1hxjfAJKGQJ0YgxzRkRGpPVcPIGdVHfxFn/1/cNT8?=
 =?us-ascii?Q?AxfmhooH7/hkLy9FD+lDVpGOTlumkttyhaNZ3xrUQbMNQ0EHdkD/p8SBN8vi?=
 =?us-ascii?Q?yXi8Dzc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a0aa32-b25f-4f90-a0f0-08d8cd627d40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:23:36.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN9qCcMkctq3TVLWYU+Ml1x2CCtT9EwH3oPq5qWVZN2zBYkgPE7DxfYXC/azgJVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3350
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:44AM -0800, Yang Shi wrote:
> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> allocate shrinker->nr_deferred for such shrinkers anymore.
> 
> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> This makes the implementation of this patch simpler.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/vmscan.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 748aa6e90f83..dfde6e7fd7f5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -338,6 +338,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
>  
> +	if (mem_cgroup_disabled())
> +		return -ENOSYS;
> +
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> @@ -417,7 +420,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #else
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static void unregister_memcg_shrinker(struct shrinker *shrinker)
> @@ -528,8 +531,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>   */
>  int prealloc_shrinker(struct shrinker *shrinker)
>  {
> -	unsigned int size = sizeof(*shrinker->nr_deferred);
> +	unsigned int size;
> +	int err;
>  
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		err = prealloc_memcg_shrinker(shrinker);
> +		if (err != -ENOSYS)
> +			return err;
> +
> +		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> +	}
> +
> +	size = sizeof(*shrinker->nr_deferred);
>  	if (shrinker->flags & SHRINKER_NUMA_AWARE)
>  		size *= nr_node_ids;
>  
> @@ -537,26 +550,16 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -		if (prealloc_memcg_shrinker(shrinker))
> -			goto free_deferred;
> -	}
>  
>  	return 0;
> -
> -free_deferred:
> -	kfree(shrinker->nr_deferred);
> -	shrinker->nr_deferred = NULL;
> -	return -ENOMEM;
>  }
>  
>  void free_prealloced_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> -		return;
> -
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>  		unregister_memcg_shrinker(shrinker);
> +		return;
> +	}
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> -- 
> 2.26.2
> 
