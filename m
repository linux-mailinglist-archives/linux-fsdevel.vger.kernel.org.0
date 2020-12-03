Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1E2CCD0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 04:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgLCDJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 22:09:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgLCDJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:09:44 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B337TPV004568;
        Wed, 2 Dec 2020 19:08:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ty5WV41tV3n8WRwpWpaq719mxsl911TQssdZH2Z8zTo=;
 b=POZewgpUlrrjls8xzs/NzI1NRzrBqFv4mrlBkZySwSlKYNeIPWc1P6u2rrLN9AZhwIRs
 Cfi3PCjsRlsa1uAo175s8O7jEH4l1qgokiQFYY+VyhC7UCSrLn2mFIbdLdH7JevMkTV4
 q+XRdKQyVO7joSEUH0qnBhJJ6By9ok8BU+Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3562ma02p0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 19:08:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 19:08:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoEWcGbDv171U1bLRZoieNyL7t7p9/kSjSf25iGmbF6A4ZvwHuQnJ83ySBY6Peupif63DOwOYAnj63KOtxZwOE+qXEdg9wzYvevw2A4ZXqcVK9CHi8mL4nfjgKa2QyQc7GN4ClBb8XvI+sYSBHg0hJzIh5Yyx+BGw56YfxAX+RwfII3SZ+t4TOr8m3d2O8xBIr9UbdldAnSqeFDBeLPwtAivyyATMuiX5KcDKImay668RLKzEHA1dNhwUGGD0Gp+WYqgDJ/XK+H1PrqZ6J+SRdkqoAiOkzj3OA+2kWPaMxeLrDsH+AV7ok0b1geKd5VgV5MfYyO3aCwiyH/wmz0lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty5WV41tV3n8WRwpWpaq719mxsl911TQssdZH2Z8zTo=;
 b=QybiU7TFwj2sceQ+4pT/lGPIjITm4O3y3GyyMPhoyi9zVbqzaluJkIj3fjk+oJCK5ZQTaHOqAFV+DYwHT5C9GSp9aUFT8F4wqAfjLVdIvLy4BUmiNfONsF1w1Li4rHbl3MUYSWR7j7t7bOYF/elTQ0ypDktaB/wSOAtZWQroHrzDQCWQLc+PadAO01B9xgLHbcoEmkks6XfOHr+OG+byOV2YNXk9C7qQpMo46dygTbow1MHWnC5pP5lNrnfNhwJxeq0FmMmS7/p7yByNtG6oEh0MgdY9DePE6WIO+46QXXkpdl9gUjPETPnFjsqihpkeLTwAXy31ns+5aJNhJ9KoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty5WV41tV3n8WRwpWpaq719mxsl911TQssdZH2Z8zTo=;
 b=E+54TbzXIkzZeHx5E6uaR0hjgsVQlSS10qH5ARPNGCApnSZ+iptHEM2HPituSuD9V36dyF+CbSzuKht0ZprYrk1sXW9+nMwNbMvuF1d17btW4qtg46HwkYGDTZ1l6L+lznxYWOnIpkwuggj8lop2TYdl91W+9bGRvjsMVLAcXCU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 03:08:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 03:08:51 +0000
Date:   Wed, 2 Dec 2020 19:08:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Message-ID: <20201203030841.GH1375014@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-7-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:399e]
X-ClientProxiedBy: MWHPR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:300:94::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:399e) by MWHPR19CA0066.namprd19.prod.outlook.com (2603:10b6:300:94::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a75675a7-9e59-4066-f4a5-08d89738c2de
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR15MB308046E15803D87DE233744BBEF20@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpDGwU//n6URIEcu18hhEngNNlSv0XVsyL+UaxRRSD0tHfirYSTVAaF3/fiL93wMhaC1PxISEjl/rWjeQC7F9sB9y0HQagEYx96GTnHwIZPvwzS7ly6kbEEdH0THsiSm7oEa5lSP2M+xyP8cJBOVnjC4m6tF2OaCZI9AJbvbuXGlM71ZmF6XsWB3xsvNnAB+5iBcx/CnoveGrjiMU0H9uL5pAn9JIE3rCbIqNetzJ8tcKSgsbOAPHD6+fJ010V0jiNLsZr38A2iO0mhgpOOXNTGZI4Y63d2I7rJALw1x21qA8JJC34Otxf6zn2hsp5pxaFFkRKkXUr0JFseLoEP5bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(1076003)(7416002)(6506007)(2906002)(86362001)(55016002)(8936002)(33656002)(9686003)(83380400001)(5660300002)(6666004)(8676002)(186003)(6916009)(66946007)(66476007)(16526019)(66556008)(478600001)(52116002)(7696005)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vquSHHnDLAX5bUiocLCQUEh/iejS/GCVYLesG4MAMbrDu4jEKK1t5fgbr+er?=
 =?us-ascii?Q?6ibuN+BZDNzLB0yT8BrzHThoogkNRn4h1BBWbZKSdHQ3lg5kJ7gUhpk04Rql?=
 =?us-ascii?Q?h9FHdU9ibgz8oLaP6D00x8CBjlS3xi7WkoOjzkfx2EXjMPvAQxZ9IxQiBueX?=
 =?us-ascii?Q?xQ/QsO2QXMPgqjUtH+6n0r7e2EdpTOZrNzV2IBOIWVdlEd0K/pWTjOqczxuQ?=
 =?us-ascii?Q?7F3ZrYUxBQZyGPXOpttZLroDiY4D6IhblWQomYQ4ldF3NxnPno9bqQFARSiz?=
 =?us-ascii?Q?MeFq9DJFlAKVjDEOX3oF5MqqrPmZJZnXK9ICfKJ88n/hbJndk8TB8G2MaydP?=
 =?us-ascii?Q?G27pp3K8+530eCL+iMSlWdqCyjBaw2N82wl2lOSBPKLJvllwQcFgwa76Lx0E?=
 =?us-ascii?Q?m+HkW6f2vxp+TtWX+B+LF9GyhPxxEpDjf9/LniiExxuWARPPFNpIXYENjZf3?=
 =?us-ascii?Q?q99NjIM9SwynYQVkfip5Z7aknAwvk8VK5jDhFpl/2iDlYpdNjulvOVr82tqn?=
 =?us-ascii?Q?/nUaEwSbXiiohZcfSCrhTL5Cqo1r/ZbU5QDfFb1f+LavzYTSGXgCICxaunYS?=
 =?us-ascii?Q?rW8y2zcYQE7jlnANVByHJv0PnYjg0Zr7dvwZ+U2BA2wwZkD65Vm6mVCXFh7h?=
 =?us-ascii?Q?bLTCj0tyIyG0IEOiLXOhdG7WXYNLzTC+RPCIqmsMlcqTgXCD32C43gTr0jVM?=
 =?us-ascii?Q?8c1ASkSMgB4Aj5GtvUw4du8kgBn3bCPauCukHz39v0wHZcGYPtSk/pFkLnzQ?=
 =?us-ascii?Q?idK6UtxtZ1uIgUzrbuyMb8ulcIcIqEjunbdqnym3w7Q+c3pB0E8yuSb7nyNR?=
 =?us-ascii?Q?a5+nH73hNU5FjqBYXzTJ3dc1fqd8Gx1fmnMxe1U36yUnzRMcTw8ZG+wRkq2r?=
 =?us-ascii?Q?fCtomk38atgXm83aRNz7t7Q5OOZ82TykeP+0OoUWHn/QCK157QaV5QdZ45Mz?=
 =?us-ascii?Q?gWGi84YSDt62w1Yh94VcaDe4Ld8xgtg8dtdDpE5lck9V9bHVDJJf+j/nl0m/?=
 =?us-ascii?Q?rWE0B7OAJ0zWUt3rO8zx9AEH7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a75675a7-9e59-4066-f4a5-08d89738c2de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:08:51.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ffPkIzuawfDtX4csoMxcjiGetc54SXntXogbB5suQUl4yZxQ7jiTMHsvpwYOUA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:22AM -0800, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cba0bc8d4661..d569fdcaba79 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  static DEFINE_IDR(shrinker_idr);
>  static int shrinker_nr_max;
>  
> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> +{
> +	return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> +		!mem_cgroup_disabled();
> +}
> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #endif
>  	return false;
>  }
> +
> +static inline long count_nr_deferred(struct shrinker *shrinker,
> +				     struct shrink_control *sc)
> +{
> +	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> +	struct memcg_shrinker_deferred *deferred;
> +	struct mem_cgroup *memcg = sc->memcg;
> +	int nid = sc->nid;
> +	int id = shrinker->id;
> +	long nr;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (per_memcg_deferred) {
> +		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> +						     true);
> +		nr = atomic_long_xchg(&deferred->nr_deferred[id], 0);
> +	} else
> +		nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +
> +	return nr;
> +}
> +
> +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> +				   struct shrink_control *sc)
> +{
> +	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> +	struct memcg_shrinker_deferred *deferred;
> +	struct mem_cgroup *memcg = sc->memcg;
> +	int nid = sc->nid;
> +	int id = shrinker->id;
> +	long new_nr;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	if (per_memcg_deferred) {
> +		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> +						     true);
> +		new_nr = atomic_long_add_return(nr, &deferred->nr_deferred[id]);
> +	} else
> +		new_nr = atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> +
> +	return new_nr;
> +}
>  #else
> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> +{
> +	return false;
> +}
> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	return 0;
> @@ -290,6 +347,29 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  {
>  	return true;
>  }
> +
> +static inline long count_nr_deferred(struct shrinker *shrinker,
> +				     struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +}
> +
> +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> +				   struct shrink_control *sc)
> +{
> +	int nid = sc->nid;
> +
> +	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +		nid = 0;
> +
> +	return atomic_long_add_return(nr,
> +				      &shrinker->nr_deferred[nid]);
> +}
>  #endif
>  
>  /*
> @@ -429,13 +509,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
>  
>  	freeable = shrinker->count_objects(shrinker, shrinkctl);
>  	if (freeable == 0 || freeable == SHRINK_EMPTY)
> @@ -446,7 +523,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * and zero it so that other concurrent shrinker invocations
>  	 * don't also do this scanning work.
>  	 */
> -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +	nr = count_nr_deferred(shrinker, shrinkctl);
>  
>  	total_scan = nr;
>  	if (shrinker->seeks) {
> @@ -539,8 +616,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * move the unused scan count back into the shrinker in a
>  	 * manner that handles concurrent updates.
>  	 */
> -	new_nr = atomic_long_add_return(next_deferred,
> -					&shrinker->nr_deferred[nid]);
> +	new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);

Ok, I think patch (1) can be just merged into this and then it would make total sense.
