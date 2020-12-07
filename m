Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD22D1A01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLGTrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 14:47:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgLGTrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:47:53 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7JhLYG007270;
        Mon, 7 Dec 2020 11:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EoIPii2JPcSda4CrSMHg5vdPlmf3UYzHcRGdqcTmxOM=;
 b=C+9P/aFHxG0QhbPY4mn9GiEFRYI5bR8ZWnxvYmVngxkZrG6tk/f1umOdjNQjd4YrSkf1
 YIREXoRmwu96WGuJjy0MqxqcpdVatayXSTv56RDNtZ+Kk9ZiX9UzIZuYjb6I7nQn3WqP
 xzygF4rUlA6bjz0e9hbMzx7xsGWz3dpW6Eo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 358u4d8sae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 11:46:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 11:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og6cCv9nETAuf+1ZGb+Bcy58SGnd/9KVtQ+YmJnxZJ18v4XtZavdseBJHC/bAvTqVB9zx2Ob8bu2wosYE247HtvTE2WZpS13F7R7e+Ta7LWQRhgFVLaSbx/kI9GDTJP4kS7ULvxzspZsaimV7NxJHW+RscuvkOFVwtXFQ31HuCTLPyCouaaKQ/cAleXy+cVwZwCiWi7MjI2RJ7fz3K+HUjlMfxFGrEfuGvWSLflr2i67ABBtaalnZUkdagdqvyRWcj4mjssc19qXCF8vOtWKBwW/L5+x7z2vEZCyxCkLBOTxeOTZlmCZokJVNdKmnet8tP0tVN1ceLBCrSDsZjZ9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoIPii2JPcSda4CrSMHg5vdPlmf3UYzHcRGdqcTmxOM=;
 b=dQ+rR2h5Rhl6O1KvcZnmF75Q/F8tClmyhRLzuFCTMKYm1Sk5W34GS3qqwIx2zdZImu/nnho7OTCPQVn2id14MululgJUtQRuTenquxJns5h0X5W+1MLodYcMDB327jLdHJRCobOPauncGKjp9P++U4EBxXnCvuPgL6GkoaNzCNDg0s+Ym0NMoRsOmrZORgWlP5zDCAiEVIZaelfzyjvf5rGhm/oFEQmZFMto5AVz9EDGopEpDvAO9aFp17EfgcKeD3ljQxpENwz0nffpYdXlielq2kNCVwlPgkgOaf0M746o8BgFg9PytFkAPgn4Oc9E4wjiCsEAp4X9KbIeCcxcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoIPii2JPcSda4CrSMHg5vdPlmf3UYzHcRGdqcTmxOM=;
 b=ZNtjfBhHrp4vT0ra0eICIq7gGT6Z0NKTlELRxBkMNhOiwaV99PXTKp1+UGPzVDrxZ26El6WT4PGKg7/j+mnQDDWpzUyLPVataPhbVB8VHYWoxQfjsUH3gCwOnNnx0/VxZ1N5v2PnjaLxNAouy4y62Q04Ti5iIgw3Y3CiVk6+bjo=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2437.namprd15.prod.outlook.com (2603:10b6:a02:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 19:46:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:46:28 +0000
Date:   Mon, 7 Dec 2020 11:46:22 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <hughd@google.com>, <will@kernel.org>,
        <rppt@kernel.org>, <tglx@linutronix.de>, <esyr@redhat.com>,
        <peterx@redhat.com>, <krisman@collabora.com>, <surenb@google.com>,
        <avagin@openvz.org>, <elver@google.com>, <rdunlap@infradead.org>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 09/12] mm: memcontrol: convert vmstat slab
 counters to bytes
Message-ID: <20201207194622.GA2238414@carbon.dhcp.thefacebook.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-10-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-10-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ef79]
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ef79) by MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 19:46:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 390f05e7-9640-4e94-f7d5-08d89ae8c9bc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2437:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2437369FE3BFBCC09B4BF9A6BECE0@BYAPR15MB2437.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXsNr9ldo/W5Z6BUv5iGmZut6aGpibCHOG/3grHpxCE06wsM434d0kiOriJUXBQHBXlZj4Ifn/SIA32xRHBYHgI/t6PlVjBXm4ahkSGNwQvm8vbvi7irke+QQtYtvXDULfXNIikp6MnR+hqX123M9PSYgr9jUp/7erg7paau32xTF96EIFI5ZSd5km98waBghoTI74YZ7kZL3/6OTFAYkvExxnDvYlqrQfiDu2HB/AETPhU8lh1Q4MkNavN0KLn6l4kczzXSXsW8lTaIAwmQ0KCz7YbsLbFiNv7aTHkPpDKLNGHYwV7hl19FJQrjnKjh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(66946007)(2906002)(4326008)(6916009)(9686003)(66556008)(5660300002)(478600001)(8676002)(52116002)(8936002)(7416002)(186003)(66476007)(6666004)(6506007)(83380400001)(55016002)(7696005)(33656002)(86362001)(1076003)(16526019)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GPTCyJ2l4O3dQ8d1SPkHgPo9iIYXDYbu5Ubo2ZRKFzhuzv5XIdrtvyO2Nqdz?=
 =?us-ascii?Q?2VTDrXfKD23Dzl+iXI5m2Btk5ycjleNf3QZng+HXln0bxlXogWqw5NfPKQfj?=
 =?us-ascii?Q?B06Ev7YKpklC+Yuo+WGk5j2JfhFWBbPnoPCAIb3EiAOkMfZYyvaNyxRJ0CCo?=
 =?us-ascii?Q?Vw6S0CvVEAn9ebPDuB5BIqt8kzlft1eovP/gic7TKodkvy8cX5MQhrN0czbD?=
 =?us-ascii?Q?4QVxg5AP9XM7IXAmMyFbW6AWE2Ag9C6QVLLBqft9Uu3/9E/rGhPvX2eYmWmP?=
 =?us-ascii?Q?9Y5zPSWNzTAM9/luSJpPlilGFfWc2P+3UKBZXxOFx7kTCEvA6dW7hwy6g8QL?=
 =?us-ascii?Q?ZAp69lWLqJm7/Ix8l9MltLXiOO0u3Oh7UEnQlq5+S4d96hSL4vrDvCiJioao?=
 =?us-ascii?Q?wgTpgagvKtFAqQ5H6DdpfOws4l46XEBlwjKDyO30xGP0785D7IYYLLcNJ3kA?=
 =?us-ascii?Q?C69+aYtTpckecxWtwte6xRrlaE5c9keumdRcTo3SeSIDEkHHuU9257EXlGUF?=
 =?us-ascii?Q?LOr+JUeLM+5rvI7M0GbwIjNSUkgqdguxv5jr534+wrQq0L8rAtDrQ/r7AqVY?=
 =?us-ascii?Q?1NCThSVBATConnUgirDX30vdR3X3C7JckCGt3Dey31e0PXUqwD0I2Z+LL5ob?=
 =?us-ascii?Q?1S1pGY8U1TbINEpB4OPipsWM5fPAZ45MJN3xdxsc1fB1CtAX8RpI4gR7eeHZ?=
 =?us-ascii?Q?Pln+x0yya2z14GSluL6mCdbeQmp9pzLmblR7/noLFirclXUujbr20OdT7I33?=
 =?us-ascii?Q?nC0Lxn8wDrCLIoTFOcYO3r0ztCzOnoGbv91q9slVMIf6zouxq351AOK2H0xn?=
 =?us-ascii?Q?bZxEEkwK/Q1h/LS0FmtwBhIlf9zOwJnALLmZui44SRSgG5Trovf9UibFM4iu?=
 =?us-ascii?Q?kZMKoLyJOccdwZmSBJybcjmqv1hnrTTEKBu05RyiZXcE0X8XQus3eAC45mDM?=
 =?us-ascii?Q?11W11lKB5dybbynqzerGzhnl/fx6UR6lf9Klmg/B6ywzDXW2DsMrFcpt/YZE?=
 =?us-ascii?Q?oMrXvVGZMqn7KQzsoYp7if8I9Q=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 19:46:27.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 390f05e7-9640-4e94-f7d5-08d89ae8c9bc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT0zrKe47fzYLk76GdeEN1fbdFuH6m8dP/XMtdTWfY0DjTWs6zZOiacvo49sapzW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=1 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:14:48PM +0800, Muchun Song wrote:
> the global and per-node counters are stored in pages, however memcg
> and lruvec counters are stored in bytes. This scheme looks weird.
> So convert all vmstat slab counters to bytes.

There is a reason for this weird scheme:
percpu caches (see struct per_cpu_nodestat) are s8, so counting in bytes
will lead to overfills. Switching to s32 can lead to an increase in
the cache thrashing, especially on small machines.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/vmstat.h | 17 ++++++++++-------
>  mm/vmstat.c            | 21 ++++++++++-----------
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 322dcbfcc933..fd1a3d5d4926 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -197,18 +197,26 @@ static inline
>  unsigned long global_node_page_state_pages(enum node_stat_item item)
>  {
>  	long x = atomic_long_read(&vm_node_stat[item]);
> +
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
>  #endif
> +	if (vmstat_item_in_bytes(item))
> +		x >>= PAGE_SHIFT;
>  	return x;
>  }
>  
>  static inline unsigned long global_node_page_state(enum node_stat_item item)
>  {
> -	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +	long x = atomic_long_read(&vm_node_stat[item]);
>  
> -	return global_node_page_state_pages(item);
> +	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +#ifdef CONFIG_SMP
> +	if (x < 0)
> +		x = 0;
> +#endif
> +	return x;
>  }
>  
>  static inline unsigned long zone_page_state(struct zone *zone,
> @@ -312,11 +320,6 @@ static inline void __mod_zone_page_state(struct zone *zone,
>  static inline void __mod_node_page_state(struct pglist_data *pgdat,
>  			enum node_stat_item item, int delta)
>  {
> -	if (vmstat_item_in_bytes(item)) {
> -		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> -		delta >>= PAGE_SHIFT;
> -	}
> -
>  	node_page_state_add(delta, pgdat, item);
>  }
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8d77ee426e22..7fb0c7cb9516 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -345,11 +345,6 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  	long x;
>  	long t;
>  
> -	if (vmstat_item_in_bytes(item)) {
> -		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> -		delta >>= PAGE_SHIFT;
> -	}
> -
>  	x = delta + __this_cpu_read(*p);
>  
>  	t = __this_cpu_read(pcp->stat_threshold);
> @@ -554,11 +549,6 @@ static inline void mod_node_state(struct pglist_data *pgdat,
>  	s8 __percpu *p = pcp->vm_node_stat_diff + item;
>  	long o, n, t, z;
>  
> -	if (vmstat_item_in_bytes(item)) {
> -		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> -		delta >>= PAGE_SHIFT;
> -	}
> -
>  	do {
>  		z = 0;  /* overflow to node counters */
>  
> @@ -1012,19 +1002,28 @@ unsigned long node_page_state_pages(struct pglist_data *pgdat,
>  				    enum node_stat_item item)
>  {
>  	long x = atomic_long_read(&pgdat->vm_stat[item]);
> +
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
>  #endif
> +	if (vmstat_item_in_bytes(item))
> +		x >>= PAGE_SHIFT;
>  	return x;
>  }
>  
>  unsigned long node_page_state(struct pglist_data *pgdat,
>  			      enum node_stat_item item)
>  {
> +	long x = atomic_long_read(&pgdat->vm_stat[item]);
> +
>  	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
>  
> -	return node_page_state_pages(pgdat, item);
> +#ifdef CONFIG_SMP
> +	if (x < 0)
> +		x = 0;
> +#endif
> +	return x;
>  }
>  #endif
>  
> -- 
> 2.11.0
> 
