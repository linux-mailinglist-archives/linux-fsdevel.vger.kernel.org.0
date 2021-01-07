Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2434D2EC742
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAGAS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 19:18:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbhAGAS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:18:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1070BKW5020611;
        Wed, 6 Jan 2021 16:17:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NFjZLbLYl7qfkJSpWyHdFgARQB/hBO60AGY2/KhSUbU=;
 b=ll89rQj8oPLhA+YjsAbfGNtfqZcsi30P7DWDDDac0MDHZxzkdsUTzLugbPVh73PBkyUR
 rru1Onos7s0/Ai/GwQe/uad5FG20mgUZMXpTXaYBfVuDQWE2CLtl7mVZNKvIf8/rPetd
 sDJkDH0lp1KoJ75Y4bcYaeXfhYrTcGWbGu0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35wpuw86mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 16:17:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 16:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laPCkoGrym9spftnccVO2IPTrbTEZQfeT3v6gALxxmsQH7xCF0n58NXqy2X5WQgXEKKcU3g7sEBasxXAWvQLD9yAZQLS4VUfPTUX+UTQnUFqrXMCA4REI9B2ADxcTRJgFjrLuqNvX5qJ3HzGdHAMKjNClaKpKhgn7stH3Y+Wn8zUDI093ddjQZ5ZMTmCrogmGQqfpojXCC2u0ey3pkEpYdcvthhB2UJ0keQkkBENGN8DJmNNw4Gdpb8tWEYC90o/nUahErhqBjy+lhgHE4Ri37Ep0aNwgDmzsU2sgVuQlmwuOfR3KnZfrfiNF5g9JIKXlC30MHDNVcYEZMuPNObz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFjZLbLYl7qfkJSpWyHdFgARQB/hBO60AGY2/KhSUbU=;
 b=mMhS9N5ZpbiXZnZSg1GQzXxaDCmexwVrocTGGvFRw6PJ27KzJG30mKGvV3qufBs6ItkcQz9h/q+aGzxedGShzndtefTsUDMgsdKkSwwJs0yb1996qxV5+GhuTpv8TYL8rhFzCqwZfpS1Ula+UwOf0cdNBQom4LghE7H/kiy8rArCuGceBFK75sdBSOFEdEt2WupruvPA3mlG8eNxyx7fuz8Qxp/veyTmUBiu0h6UPsTcgbxa1gAfNHSBczmffyjeqJ2xfzSDf9LBHg4LDqvAa862xPDYayrZTfwIkT05xBfBMzndBW6yEr1EtXthzk/mkDina7J5R5HpSktvgMGcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFjZLbLYl7qfkJSpWyHdFgARQB/hBO60AGY2/KhSUbU=;
 b=MskaAXaKS/vHecge6vX0aTZUltGF0L15pp4YXt69zyngsE0UaSwnIz/obmT6bNWara+9g5vdYy0hFL/SdQiWowPq6rGEWFRXVCcoZ7Pj8Yx4qOeyZQx8N+EU1tkKVEAz8iUtSuuheLedsWqfoLr8QRAvOfodx/NrGcN0ZnlWplw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Thu, 7 Jan
 2021 00:17:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 00:17:33 +0000
Date:   Wed, 6 Jan 2021 16:17:28 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of
 shrinker
Message-ID: <20210107001728.GE1110904@carbon.dhcp.thefacebook.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-9-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105225817.1036378-9-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:86f2]
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:86f2) by MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 00:17:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a1bdd4-3580-481e-87a8-08d8b2a1a126
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32851F297A439921CDBD5121BEAF0@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaZ3npCQljs1aC1HG6QkB9xPLUrNDObOGHjlb59rloG88yqfincNnJl9DUCa/ALpQGjXC7wfFVFBmmvPi3QVdE9uH6aXQ+9QOnmbDpgBsUpbDH3zQpvmW05kHCJp0TXAXbnCF3sQ+r/kN0XndUVEnYWLfn7oSRVah0viQzLVnnDuOZxbd1NYryd8Kowt5sADvIscAU/sDU2DsFEh1xmjprHGwD7LxvGEVhsTbhvEjj5j9SJHvh7jL3xKuyIGkfKgiy0JhsYLcO8zGnDBEQnQ5bWnhdvbw2Igz7ereiWKuxD2Wg6hVDCkNqjvpldqVjywbu2mHAID5QJ9vmNWyhNfI4FDVPc/a5GW88X9i5LEALydyDoFFjEdfJEXWjwVLA46++imAIiWedst02FE1RdJpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(66476007)(66946007)(186003)(66556008)(8676002)(6916009)(16526019)(9686003)(6666004)(1076003)(55016002)(478600001)(4326008)(2906002)(316002)(5660300002)(8936002)(52116002)(33656002)(7416002)(86362001)(83380400001)(6506007)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wc01nmzbINe7rsibYaNYkvxVpLC8p9pm3uxJWyb7gIFDKmr2pINXGx2Cg1+e?=
 =?us-ascii?Q?kBkJ3DnE+VuDG5Fm4YzwJ9Hrp8E8xc3FQHzJjJCIsiWfYXmCTBfpEtzczcQ9?=
 =?us-ascii?Q?vYVMK70+FRtLd73QfVZ+ubRCtvxb/D4Py4OctxaptbfNgAHMdN7sDawa15Og?=
 =?us-ascii?Q?d0pou84DvK5LmiFwJ8uSS2keL1d+plef2wzLASIwh6JAl+IWVQwMgmwNqXH/?=
 =?us-ascii?Q?9vqs9huGGo3rFqQjkBZ+Fr+BuIYUNpJ6+NFdhLuRMfqK1lElJQKlirU3yOrj?=
 =?us-ascii?Q?8h02eX+yZK9XqEkENY5oNwom+u08QYXwuYx+1K6A1/232cdO9fHCCpr6kN0l?=
 =?us-ascii?Q?WlPHrktNIarU6/CTy/VTtM5wNBUbaSNKlvgNmObyXP81LH3LWeE0EwqxR/Ur?=
 =?us-ascii?Q?MQ6EQxQmvHxzvY0EEQjKTKFciM9DoSexMkJjSFMKl8figKV4a9//RhpMy7kM?=
 =?us-ascii?Q?zgT3pkwxRrP7aXDmx9YP5I1XLJF4Hf8ckWYN5I65fFKDPTcxMGwG9duemIUy?=
 =?us-ascii?Q?hMO/gDLehtUqQNTMGYYEWaCPNZ2tvMYhiaB7hgT/4KKisMVqzcDn9QWjc7ZZ?=
 =?us-ascii?Q?oDifgR5/dYlSkx/Z7ghqTfP4Q9hBj5Gmkji2BdEtURyGHiaqnLHpAJZxyXD6?=
 =?us-ascii?Q?s0YTcFgaoM4tG5JDZAk4idu35+gOwVKdLk441TcsITv1T7MB3Xunyrh1OIjr?=
 =?us-ascii?Q?iCipQRhXTE4MVgv9qaEDtrjbzz9EHdbRZs7aZN6W9Y/xMJ18OpJ6nxVnKSNc?=
 =?us-ascii?Q?JffBIevH/6OhJt7IMrkWvUlYJrANHdiqddHm6N5yg0uKQvAGIXpTpv3k0HWa?=
 =?us-ascii?Q?mSno3wYsAqqhP7LVnqzNGlwLtEq9B1QiZygDcop2dZTtZ8U207Mk1m86VSqU?=
 =?us-ascii?Q?flAXkGTJw7qfeHkRmEqvSXbo5oPlPMXa7MznmYnhxtbXpOnWsiaIzCyDx0sq?=
 =?us-ascii?Q?2Pi2AJUO2yknCS96jv5sQ+wOO02p+waIeklW3pUjBKNFNo45kx3F7U0VKRPH?=
 =?us-ascii?Q?SABrwAvxI1fWbOi6m4qYsdAKJA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 00:17:33.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a1bdd4-3580-481e-87a8-08d8b2a1a126
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAeJLm1YMWwN8z3yGmlgB0NHt5XljqxhcFDHJzel/xqUSMEW1jWT0MPxdvkLtzeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_12:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:58:14PM -0800, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG

It's better to depend on CONFIG_MEMCG_KMEM rather than CONFIG_MEMCG.
Without CONFIG_MEMCG_KMEM the kernel memory accounting is off, so
per-memcg shrinkers do not make any sense. The same applies for many
places in the patchset.

PS I like this version of the patchset much more than the previous one,
so it looks like it's going in the right direction.

Thanks!


>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 72259253e414..f20ed8e928c2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -372,6 +372,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  	up_write(&shrinker_rwsem);
>  }
>  
> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				    struct mem_cgroup *memcg)
> +{
> +	struct memcg_shrinker_info *info;
> +
> +	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 true);
> +	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> +}
> +
> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	struct memcg_shrinker_info *info;
> +
> +	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 true);
> +
> +	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> @@ -410,6 +431,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  {
>  }
>  
> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				    struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> +				  struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return false;
> @@ -421,6 +454,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  }
>  #endif
>  
> +static long count_nr_deferred(struct shrinker *shrinker,
> +			      struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return count_nr_deferred_memcg(nid, shrinker,
> +					       sc->memcg);
> +
> +	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +}
> +
> +
> +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> +			    struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (sc->memcg &&
> +	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return set_nr_deferred_memcg(nr, nid, shrinker,
> +					     sc->memcg);
> +
> +	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> +}
> +
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -558,14 +624,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	long freeable;
>  	long nr;
>  	long new_nr;
> -	int nid = shrinkctl->nid;
>  	long batch_size = shrinker->batch ? shrinker->batch
>  					  : SHRINK_BATCH;
>  	long scanned = 0, next_deferred;
>  
> -	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> -		nid = 0;
> -
>  	freeable = shrinker->count_objects(shrinker, shrinkctl);
>  	if (freeable == 0 || freeable == SHRINK_EMPTY)
>  		return freeable;
> @@ -575,7 +637,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * and zero it so that other concurrent shrinker invocations
>  	 * don't also do this scanning work.
>  	 */
> -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +	nr = count_nr_deferred(shrinker, shrinkctl);
>  
>  	total_scan = nr;
>  	if (shrinker->seeks) {
> @@ -666,14 +728,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		next_deferred = 0;
>  	/*
>  	 * move the unused scan count back into the shrinker in a
> -	 * manner that handles concurrent updates. If we exhausted the
> -	 * scan, there is no need to do an update.
> +	 * manner that handles concurrent updates.
>  	 */
> -	if (next_deferred > 0)
> -		new_nr = atomic_long_add_return(next_deferred,
> -						&shrinker->nr_deferred[nid]);
> -	else
> -		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> +	new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
>  
>  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;
> -- 
> 2.26.2
> 
