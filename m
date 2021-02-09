Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7B3157CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhBIUh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 15:37:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233310AbhBIUeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:34:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KTcDS029299;
        Tue, 9 Feb 2021 12:33:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Pgb80QGTUhh5EEQddD6TZ3WN8GA3qytdkGpEycHdmDI=;
 b=mdslVwSIm5/04lXvb9Y7yuJdjiHjD+SjsAk8pMl2pMHXZGEqzsWrlsZxmTfmRtRNOBu9
 OmJRxwLJiuOLvpmX9pmW2sdtnfYljJHD8+fSdtoAC7LTYYjUDMcU0YEj2CB3/Q+0Cnj6
 1YsZ+OWX8YL9dY0b4sti1x08mknKo+211ds= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1unj84-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:33:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:33:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D37H0LUB9ZTrT1nSfWBDLTHy32IXnfvbU4v+wp+pbImEWFSvHUV4e+WYbJu8VUi/69J40kNp+edbue3ZdjCW6ec43MjSUc821OqGCkAVg7hXZUDMHyZLSOzew6hoPWloBZ0VBHz3gVO2LQ9KMF+w0ZjyeLZNz1VL1VaXqCisAC8VNXC2S5iBbbnQyOe10JZgH+3hPeQ06CxVTJxMZk5vK6ZPn04Ek0yEA4euL9esNNwDvSFHbUVCU4IfStUth+ePCm03lxa5j1GkI6TC/cdiO9B1pADVwJDVpARbXKnRMwRlj87OP/yq3t1tdkMJbaLWYY1lQ7VONytJGTgE4PJ7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgb80QGTUhh5EEQddD6TZ3WN8GA3qytdkGpEycHdmDI=;
 b=nO1DCsNxxUp38b+k3DVtDaxf0htkhCDk5MKMv3Awoh17WH8rqiJgBlFaFXPCUyedPSodVSwyGyqO5A/ZSe7q7EL0vR6i16o5uOeD9RaWRo3FD85LS68LvniwH23xHwjqPQeloERvJnmYUMJ38G1dj0Xoeon6X0omslH0Yx0M8wbC2+2QbYGiPYRdIdq8bAyM0hO4EINAP/rh00rtUBSYmpiJvxuwWUN00OPvxprFbFHeDnhrCdVnfe9S92DaCpZMwo7G6h8gYWT1DpA/Acu0Ns04dzzGyU04gVOYhUkRLBk4WCitjiyHhIsRL4ZRrRP7NRwdNI700tT+LRsDbzRGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgb80QGTUhh5EEQddD6TZ3WN8GA3qytdkGpEycHdmDI=;
 b=KpaUAOJ3PzoFaHClo1gyjcI5JVtK28DziG+znA77hdJOd0rrdUrDz+4PPlMA846u6hgAdoTliOqri7PQDzpotgRf029FRDskVxTChjUrY0aVvki9H7/qKoVLJbDaiz8UgrxlgDWVbhXX5BQ4uJJ4jXvCVQUs6dKKmI1Jd5xI574=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2758.namprd15.prod.outlook.com (2603:10b6:a03:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 20:33:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:33:11 +0000
Date:   Tue, 9 Feb 2021 12:33:07 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 03/12] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20210209203307.GF524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-4-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-4-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4dc3]
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4dc3) by BYAPR06CA0061.namprd06.prod.outlook.com (2603:10b6:a03:14b::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 20:33:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933e9539-4bd3-4c90-d20b-08d8cd39eb18
X-MS-TrafficTypeDiagnostic: BYAPR15MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2758FA24C7700980BE921203BE8E9@BYAPR15MB2758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3KeTBLxHijPx3avf8puMgn+4jIj8MSDnDC4H+EXx50o+E7SM1rtVdZF/jCD62F84fQjbJjllV4TSNqVpt07hFd2B5M5ilUI724KhrL6FtfUAcMsISm5AjCJFR0d0UQe/ePGM7GmpVub71HU2QZ55p1lmzWAREF4P5PATrP2zLhwcRlfkwlhgYtogC71pNRX07d1BE1369awRRbpg323f8AfydpfN4ZEx0XBa2nBe+O4DHFHDTwoBqIFmovQLmeiy1SYziCdg3S/j/Jl8JN6eo6w90ZA4EbiIhDEWtxIcO59uygqZ6NYRaB/fONJF3YFh1mZf9dUd1D/WwWQHt/Kei3DaIQ6Pb1bf+pvPHhxdFZOOhEmu5rxnuvTZ+QasoExYWbyu31vZNhK7r0Joh7tzK36KZ5iWJGTcI/nhmeruJ7UcJoyrEBKfe57wQq1EW/B02vfGEDoQ3sbGiQSv634OOIYddG6WDdf6oJbhJWQIRDBJqI0umf0IQ+4nNFUX79CwdzwWFsBbOrzbMR9R1s+6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39860400002)(8676002)(8936002)(52116002)(7696005)(478600001)(6506007)(9686003)(316002)(6916009)(16526019)(6666004)(86362001)(186003)(7416002)(83380400001)(55016002)(66476007)(2906002)(4326008)(66556008)(66946007)(33656002)(1076003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?phzpHnS19aORsRsvzNobakz5N9i4IB3QYX6h/wW073QvzzxLPvleFPIpYY5Y?=
 =?us-ascii?Q?RHCLIE+ma4QaWKGu6t5N0BrQq7cmuwUktFtW4UoVk5MG/oZoSs7L8vx5oHxM?=
 =?us-ascii?Q?BdbQeUWvrMguor/oS1/cbKfth6hjcZOZsLI3YvMDWIXVYiNC1hwd3oGMedF/?=
 =?us-ascii?Q?6ItvQInCI+dR5wXy14Q2B05GZaSNmk9UVUl5gIO8raZp1bm0qAI2hyGy/Bpw?=
 =?us-ascii?Q?OotFQtHcU1NsEuwsdKduihJ85t2k1xncaD7qN8NdP+N4JSbL89aAaCFm8UX9?=
 =?us-ascii?Q?iB5+NTNXiAlp/c/JRxxHFRwcNb3E2z9RaLBwwFCcbtYoS4UKrTuj7FUwDOT0?=
 =?us-ascii?Q?sDrJcEqspC/8+sIhNz54bMo0rBmZV6h1mhdtpx7oVagFTEI5FrEaPWhFuej8?=
 =?us-ascii?Q?y8rQTkeqf3V4fy4rXVdZw22pHDu1aSZxq3C8xjaoHwn7lepulkwMHTk/882m?=
 =?us-ascii?Q?KdV51ThKYFJ+h9Y5Kg7F7Sta/QIFsiblcNyqUaPbUjbPj8tF7hDa3lybQbfk?=
 =?us-ascii?Q?dpfNsUV/Dzlnavb7NGeGTVjV/W44VrkVyLSZFGlg8X6gpHjRh6nTNRdxFi9t?=
 =?us-ascii?Q?qFuBMwFS5YVyAjRTkB0F6Tkt68gBBcVySMGv5cCoJrj22D+bAF9QewokTBGB?=
 =?us-ascii?Q?0GfrsTxzUL+750I225U5kxn8M0zFWN46c+H7aGUofQ1oXS0qCA/Mc4G5hxW+?=
 =?us-ascii?Q?4Mjfpn0FQbirVPya9/vp8w18kSQBZ8szAInDm25XFNagxwqruxs1SjXT/7BC?=
 =?us-ascii?Q?u4Sj6RCQdzoVJYIkv917Ylx+Su7Nge0zTeBX7ZCzAu1lBYoP1Kp+av99m+Dn?=
 =?us-ascii?Q?3lMGaI0Nw/acHs1LTVzlN3hKePm33WTWDST3E1WFlJUaYLHIm3T/4XKMnZic?=
 =?us-ascii?Q?OL3wAogX7ivm/VKM82GKkmDGacOyvJA9De/ZrllUzAlhNNf706pAMBPp6f97?=
 =?us-ascii?Q?YUXdrOEUvkL6i6ou6yPBWgT024y4lFhiw0Ouf1HveQd3l78NRCEMO3u5lPGX?=
 =?us-ascii?Q?ZieEqcD+XG4DVQ/SrmXZpzvw4bvBYWZDWgS3MYIDvPb68gRRJXmHkbq42fG4?=
 =?us-ascii?Q?1uzQzfRvF16fvn6DxKwxQzkNdxZpVJGtpfyi517jtOe01QaR3DuNSigJLEAF?=
 =?us-ascii?Q?lzKFbFsj8521JwD+L9DkXwY7Zb/XtpxDb2BKIdr75TPZwppy7ZxXJSG2Nv3N?=
 =?us-ascii?Q?pqvuw5GdguPM3OtpBjc1EIV+dus7C9/dRi0qsjWrOOM/4+dbnujEsun4GWdD?=
 =?us-ascii?Q?2M6C6XPf1/a01K2UC5xaFfPWs1Wjr8jgg+4WasnRx9vCCJKKzwOr4OkcN9/l?=
 =?us-ascii?Q?FHBqA0mnyYWNimDSVhlafKspsPUZPDPHtOEzvgdp5GyD2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e9539-4bd3-4c90-d20b-08d8cd39eb18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:33:11.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbbU7sdH3Jx8ylS5lt2e0IzDL2vPvPhXJSo2eKdwKpL8QrDPA2JXR+RFR/I5Sp9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:37AM -0800, Yang Shi wrote:
> Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.
> 
> Kirill Tkhai suggested use write lock since:
> 
>   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
>   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
>     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
>     is not actually protected.
>   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
>     alloc_shrinker_info()->free_shrinker_info() may free memory right after
>     shrink_slab_memcg() dereferenced it. You may say
>     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
>     but this is not the thing we want to remember in the future, since this
>     spreads modularity.
> 
> And a test with heavy paging workload didn't show write lock makes things worse.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

with a small nit (below):

> ---
>  mm/vmscan.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 96b08c79f18d..e4ddaaaeffe2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  
>  static int memcg_shrinker_map_size;
> -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
>  
>  static void free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -200,8 +199,6 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  	struct memcg_shrinker_map *new, *old;
>  	int nid;
>  
> -	lockdep_assert_held(&memcg_shrinker_map_mutex);
> -

Why not check that shrinker_rwsem is down here?

>  	for_each_node(nid) {
>  		old = rcu_dereference_protected(
>  			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> @@ -249,7 +246,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
>  
> -	mutex_lock(&memcg_shrinker_map_mutex);
> +	down_write(&shrinker_rwsem);
>  	size = memcg_shrinker_map_size;
>  	for_each_node(nid) {
>  		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> @@ -260,7 +257,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		}
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
>  	}
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> +	up_write(&shrinker_rwsem);
>  
>  	return ret;
>  }
> @@ -275,9 +272,8 @@ static int expand_shrinker_maps(int new_id)
>  	if (size <= old_size)
>  		return 0;
>  
> -	mutex_lock(&memcg_shrinker_map_mutex);

And here as well. It will make the locking model more obvious and will help
to avoid errors in the future.

>  	if (!root_mem_cgroup)
> -		goto unlock;
> +		goto out;
>  
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> @@ -286,13 +282,13 @@ static int expand_shrinker_maps(int new_id)
>  		ret = expand_one_shrinker_map(memcg, size, old_size);
>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
> -			goto unlock;
> +			goto out;
>  		}
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> -unlock:
> +out:
>  	if (!ret)
>  		memcg_shrinker_map_size = size;
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> +
>  	return ret;
>  }
>  
> -- 
> 2.26.2
> 
