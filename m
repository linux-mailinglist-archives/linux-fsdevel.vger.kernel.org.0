Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C979C315C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhBJBVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:21:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60428 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234777AbhBJBTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:19:25 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A1D7H9001682;
        Tue, 9 Feb 2021 17:18:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LYp+zOGwUKSKkvODPzqOwJyBcuiaw5C4j6FNhosdmQM=;
 b=NVhligKcRK5KKjESn+kz2Sd3sfvxxO5CidOUCIY/qQaL45scc2sSzc3xZ1Dn1aJ+P3/x
 /2wJ4xMUpYp/Zhp18HoGX5FnWWJq9xvE6t72rLZQI+y9IdaHyjmfvybqdbYQwFEg0JMT
 wpOwcZu8HGIAWFMnFTqOcOPp0ZsghRzfKXU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstphe9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:18:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:18:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iETeVGZGX3x+xPp2HwogGP5JPzG63MMDCFCVofUFGiG9SFpifVU2AmkAy0GJiFXLVKgOX+NKcEr8DDBmH6Kf/wFNm/9PMbHFn3YiDiDW+3vlK1+2BKXZ+hliBjuFAthGbixoEo7IQOPvc1QUQhR/jjxD/zi1gU6bNuKwMlrRri34hyJD0bhT4gSb5l6eg2CKkNB0huvf3u+kXZQ3A3GLLVMk2V96Vlud+eYtQPFouHoLMG50uYS2cJiI0M3vQ0DmZv8Wr1FVosGbJt5BjymsIj5Uh3dgD8OJfykKBLqHzVrgenl6h7CRutgdGcaNkrC9NGaFBuQNKlNrB+lIGlBBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYp+zOGwUKSKkvODPzqOwJyBcuiaw5C4j6FNhosdmQM=;
 b=RaTtAD0F5+tS1Yx1ndMW0bt4x5gPLVAzwATKjLrUrPw5gxgks+KHJFWVogmBb/Rzeo3A6sBFPkY+s7HWLZfocNH6vPPv442BJL//48lck0QN0dCRCB9o9dH9R09qamMmlErmMTahMExiAVR8JUlgzAX6MiYPq7a5XFak6IwjD6R9RTqkWo1XE9x5pMgGsSIrIb2v+Pm9py4oetpmTOziII467MXY94/7Z+CIT1kUxdMiHvd8FcOyZtgpb7zk0BwLCD7tCEtDAm5MrYwkneY/WhBKe9tJmSo1oaXyjJeC1kT2HhCn0A0TEzrS5IDqnPWE9NhiWzwoK3ZOUqYPZFqzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYp+zOGwUKSKkvODPzqOwJyBcuiaw5C4j6FNhosdmQM=;
 b=fcdO4HxptkT/tTzJmaWTiHKCPr5kwlUECmPaVZteve8e1D25kM+M3ugJFvb23XHKS2wQPIggO/LIA/RbsfQCYatcLBbF8Wv+izU8R7K6DvoptiMSkcFmHksimaUyRX//+J2grxFZMv4Myj7irX8R6NlAHL02KjP7J7cXD9bnsMM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2519.namprd15.prod.outlook.com (2603:10b6:a03:14f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 10 Feb
 2021 01:18:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:18:28 +0000
Date:   Tue, 9 Feb 2021 17:18:22 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 11/12] mm: memcontrol: reparent nr_deferred when memcg
 offline
Message-ID: <20210210011822.GM524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-12-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-12-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:d662]
X-ClientProxiedBy: CO2PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:104:1::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:d662) by CO2PR05CA0097.namprd05.prod.outlook.com (2603:10b6:104:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.10 via Frontend Transport; Wed, 10 Feb 2021 01:18:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99aa6ff3-9ea1-4f1b-e26a-08d8cd61c5aa
X-MS-TrafficTypeDiagnostic: BYAPR15MB2519:
X-Microsoft-Antispam-PRVS: <BYAPR15MB251940AC4BA0C96AB9DDB4ECBE8D9@BYAPR15MB2519.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaBFdEoPooWjwzKGfCmAfg2g84uxSc0RA6zWaqWWlG0o9aRiecHbuMItgAI4o/CydjRfFjP5BjgVOar6pWOGzix8XkNbSEo1PSgnKr54I1BNYJPooiT4V40jnmYU1UHL0VXURCr3HRj8SEN0Ltoi38Vn8vu3e5uNMtAcss0O/f6tBRXstzr8x3Npv35KwUH+4/Rmk2eWBkQ+i2S8RqZhtZli9ElcK9q2r2AN623JFxs9ENIRcoATljTk5mIqi6WjIXqs3lSUtW73o6Yb1sXwBUSG7SUJObWKPnARqmOYFiyaEo7qgCoXlJG0C+XJsG251T2Bgwk69opyUZF5q5eqambdtsvk1mGP4QJ4tf3oOjAN16VI4qbwatJ+4+siaZsvJQ2quTQFidgKXoOFo67EYQrlMU6Oj1vxOOFZFP8z6bBax42ufqTXOaT3Xkx9LQHBvyON/9NFMb71wB6bvJWypeLHTEtDzxkVCoJCq7V+YEOg42wQE6ycIVbRsNFCae+KD0OqXSJnUM9pXhxCy+LLTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(478600001)(33656002)(4326008)(9686003)(55016002)(66946007)(66556008)(66476007)(5660300002)(6666004)(1076003)(7696005)(7416002)(2906002)(52116002)(6506007)(8676002)(86362001)(8936002)(186003)(16526019)(6916009)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o921SHWueGhPrqozZKZjH0d7w154qc0uHS+wfBgm/OPFRzGkzN1tSlhRD+2C?=
 =?us-ascii?Q?AFi3r40taKOFzyVmNkcU3Jewtkh2739mrdJ/2T5mNS16JzF8tAI+uIg5Td60?=
 =?us-ascii?Q?SeDFH+3R9v97RFz4MBABWj751Xq0YfepgDC89OS+4OBLC6bZ3WS3T6AZN7cH?=
 =?us-ascii?Q?0w/WHbnDwQqhC4gUFN8bs827AQEr8Ac3MT9iT6QKXEe+mqRDcfylH0v6sliN?=
 =?us-ascii?Q?Dxioy5S+F2B8liGPmYl5ZHJOxs+4CsMnU7I1LOC4FKFOaS5l4DdDO+Bwn44R?=
 =?us-ascii?Q?E9RuNNEXfT53xCGROjqwpw32gSkrrkQZ0tDhf0klkNt325KLg3zpn+THhSDa?=
 =?us-ascii?Q?YSUFrpJCcG0PkuWQn1TZS/Gr0wTXCPrflN/ublL8tfcxrQSGodogLU/4CTt2?=
 =?us-ascii?Q?YOYijYfl4io0fQokrbSjhfrCQmSDQ2z1UkTfXKQYR44Kf4GxNDorS/seKMk/?=
 =?us-ascii?Q?MOIYfnZsnjOuTB40RNAzAm9IoqdonnwvrPnBH1IykFlrZuMSnUBO+MgjzaF9?=
 =?us-ascii?Q?zlUCwOJ9Lk+YzeoMdwdol0vtbuXEXntjGi0H+fXl6JBRQUo0XIO3pRcYksi3?=
 =?us-ascii?Q?M16k2lXIUbyLUHltghrpphyGASxEtHgsLYZfLEZ9cEgPmFSyKMNsdXqga0n/?=
 =?us-ascii?Q?B9XGxDdTGiAUO1wWeRVuvhU0SvMUVfFsbFuibu5diTyoXQ59fjU1Vf6afTCb?=
 =?us-ascii?Q?f3XViKpYhZWxQ7EwLg/Fup4nz7fZ2ez+6YLWlCeqAL7n/04/D16O0kS1EpbO?=
 =?us-ascii?Q?8B6h/w5o5k5hSxQsPvX+3UEaMBOfL8H7O85TmfMCre3q+kxGz53c8yF5JDxT?=
 =?us-ascii?Q?WW86BbfnfndfhlB+25L0ZS45im/wUdjjOgfOMPHZvVXKcZRMMKCsUH0ef76i?=
 =?us-ascii?Q?glhtTPltyhm/UfX3dN5mkb5RouYnEoJy1H2B6D7dHQ0gm27piECI9TR7P8WQ?=
 =?us-ascii?Q?+Y2LRzKsKRGQVKwh5f7F0AHbCDBdORAKk+546rjeEABIlSp28vYSQOpUBwIa?=
 =?us-ascii?Q?A5BTNUsm/hwM2OEgDOcMURPBdm4ymRhxixGOVaKyPbRe66x+oMbfbSz++X61?=
 =?us-ascii?Q?0guRq9r9l5WfMRO5/ieOMUBqf3ZHub9o76AjG9P7XpiXVVMLzEAa+zkbDspR?=
 =?us-ascii?Q?6snNEAz6b/A5PUufO9/WydSr7EsZjvw6gZEuBiACqb/lFqvq2eGJPNIVtHm1?=
 =?us-ascii?Q?IripGFUR7Unfkrv1cD/XHPpAv5GHv+nWiIJdd1i/WArgTOwRaq4K73Ba/3wo?=
 =?us-ascii?Q?c8xcpA+tmL869NFWcTAf9DRhgIlRWqpxx1AiVIs49VKGW6KBESMpzATv3H5u?=
 =?us-ascii?Q?znxXpd60XhsD7xQXD60oXvIAu2mJeOHMAhHoAimOW3ClrCFeQNMRg6lDa6lm?=
 =?us-ascii?Q?Z6UYWLE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aa6ff3-9ea1-4f1b-e26a-08d8cd61c5aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:18:28.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPSqcu0l9knAMp9y//BGhbQOSNKt2ehVYDs2o6yIVXIB62bwc3CC9WdDx1qykyMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102100010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:45AM -0800, Yang Shi wrote:
> Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> corresponding nr_deferred when memcg offline.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  include/linux/memcontrol.h |  1 +
>  mm/memcontrol.c            |  1 +
>  mm/vmscan.c                | 24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c457fc7bc631..e1c4b93889ad 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1585,6 +1585,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  int alloc_shrinker_info(struct mem_cgroup *memcg);
>  void free_shrinker_info(struct mem_cgroup *memcg);
>  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
> +void reparent_shrinker_deferred(struct mem_cgroup *memcg);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f64ad0d044d9..21f36b73f36a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5282,6 +5282,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  
>  	memcg_offline_kmem(memcg);
> +	reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  
>  	drain_all_stock(memcg);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dfde6e7fd7f5..66163082cc6f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -389,6 +389,30 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
> +void reparent_shrinker_deferred(struct mem_cgroup *memcg)
> +{
> +	int i, nid;
> +	long nr;
> +	struct mem_cgroup *parent;
> +	struct shrinker_info *child_info, *parent_info;
> +
> +	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		parent = root_mem_cgroup;
> +
> +	/* Prevent from concurrent shrinker_info expand */
> +	down_read(&shrinker_rwsem);
> +	for_each_node(nid) {
> +		child_info = shrinker_info_protected(memcg, nid);
> +		parent_info = shrinker_info_protected(parent, nid);
> +		for (i = 0; i < shrinker_nr_max; i++) {
> +			nr = atomic_long_read(&child_info->nr_deferred[i]);
> +			atomic_long_add(nr, &parent_info->nr_deferred[i]);
> +		}
> +	}
> +	up_read(&shrinker_rwsem);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> -- 
> 2.26.2
> 
