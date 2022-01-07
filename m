Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05E486E4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiAGAGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 19:06:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245707AbiAGAGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:06:03 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 206M47ow001443;
        Thu, 6 Jan 2022 16:05:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=odcCMMjGlxz9y06KZBAeyksRHl21KPeCVZ9ybGuVvw0=;
 b=HP6kPjMjQWzc4EHddEfkOf6Fy4yfioCZ6JnGTTNdr6iP/AdQR9W5/jNQRiZb20onpqaU
 kfu6g/LBBUlXn+Xd8GEd2jbbY4pig3vrcGKWol9py9NjzKzQjoZLCOT82Vz9irodKsvT
 e1Y+/XgX+tcqW86k6yQq4S2E92cXLnBqvm0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4wg2aus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 16:05:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:05:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS3uACJHe75zo5WB9eH+OJAwr1g1c+jga8WPPYB2+7zoRfxozAeFh3nIQc6ZusZwF0m81kbLEuUShMG9BV0EJnDg656wh5TVJcIPFK2e4XZ8NnyxczsPZh0BfP99OCNThXrJV/jWQQ2neHj1n6Id/4jQ5vZRySql2onG//MKQnRYWOq83X0UC0Zwpy4Pa2uMtz3SGDMr2OB3Rq9KnvT2yht2xLaZzdY/ISIJCl7s0+iEkoUJMafR2YNVILtHFElF6qjC0FvBazuUksiUzx5EGXQ2uBh7yTIlqjFKswCh/sUHeOERRQIPNJ9YBCz7tTiBQNT2jiubGnkOAmcflD4cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odcCMMjGlxz9y06KZBAeyksRHl21KPeCVZ9ybGuVvw0=;
 b=SvMzwXVk8bbP3etFhA1vw3NTHu/CEwo+2bNfTUJkmJtQVsONgafou4zP6xwky2ziYVicDgAsffP9K9qbrQEFZ5VavLQ7BPyisO4Rnsm4rrFO/Y85yTaMerVNxhybbO47uQKyzLGry27LpEpIx13AZG+JVxu3KZH8h+oW7FIymUcMbJ5tdzCuKA6Ia+efaVOfL+I5Cxn3gJsPJRhK6jht2V1aFvWJxARgg3rtMmiM4o1EHRD/75XUQksqw4e3mELxRsCG7b0TQlnK1ARJa4zuAcMgX/Dx9o4/AjW5oKtR2rl4Ve4fvw4i1LyXuZ95X5VVm7jNBP3Ei+TvRmrmrfiO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3521.namprd15.prod.outlook.com (2603:10b6:a03:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 00:05:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 00:05:35 +0000
Date:   Thu, 6 Jan 2022 16:05:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <shakeelb@google.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <david@fromorbit.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        <kari.argillander@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-nfs@vger.kernel.org>, <zhengqi.arch@bytedance.com>,
        <duanxiongchun@bytedance.com>, <fam.zheng@bytedance.com>,
        <smuchun@gmail.com>
Subject: Re: [PATCH v5 01/16] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
Message-ID: <YdeDym9IUghnagrK@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-2-songmuchun@bytedance.com>
X-ClientProxiedBy: CO2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:100::29)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379f3078-4249-4def-648d-08d9d1716dae
X-MS-TrafficTypeDiagnostic: BY5PR15MB3521:EE_
X-Microsoft-Antispam-PRVS: <BY5PR15MB352127D78927BBB931E60A6FBE4D9@BY5PR15MB3521.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nK8ouzNW9YEvMHgWlmL5zyC6oUdf0SmjoryaQcAe+RJr4VlrjecBSNgLEm8U0A6dzTBWBU31Qu+ze2GwGi/+Pz9ZAYQfNSoZxGaIbIlUWTKSzSsblOwpWLzekeEgYyAejoIVurlz9iySC4WRUVG5oM+zBHb3E1oUsXTK3w7Ns4vNxGdZa6glXAh3P2nUt444LKTZbv+lcMfEIg4MVTSUb6iOU8QDfPDV88kZB7jOgKoqvCt/pOFZ1gDqt/ERqaaBBMKC01NCO8iCicSYakNJGbsXith8fasqfgKh6XYySza4bf5Jy0FFO8dTnViTEMPOJIRYLveqQmtjUxG+YDyUSplfd4OtB/0Y2lEcV8rcEaDeAfHUKyObbuxsrCXvYz+efjyoVwMm3TdCV1hwxi7vuz39sqk1Q7ae65WgvZaFkaeZ4q1bRL3qcxxjRRtfJkVMFVypNPzA9yzeZNSSJPzJB1u/a981XmmmHAteclrhmdNqAdj1rmKPWB6CbBljvCmzBTcdLT4ks4N2Nrp7cn3j3WaGJg9e1bL6PinDeEIcm88rf6y0YBLiU6OOgl/oCTczP9oHcTDM6aENVIQZzj/dWZN47biS8DDRuRsInT6hoW+POCHs1e02WGfnwZ2Se2oGeNXc2GdfMmXNyYR8WWDQEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(9686003)(38100700002)(6512007)(508600001)(6486002)(8676002)(86362001)(6666004)(7416002)(316002)(8936002)(4326008)(66476007)(66556008)(5660300002)(83380400001)(186003)(2906002)(52116002)(66946007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yE/3I50AXpE1qbdbkprCueyHNF1LqrL4/658c1OIlfJWAuXkP1cIWNRXUgv4?=
 =?us-ascii?Q?/8EqlSMV4bu5azh62qJWoh0dl46D5WsXAsjd1FisDtyCvtVyKX0jAOJycN0c?=
 =?us-ascii?Q?1qvDPPIu9oHwpyXBGmMXnMhAFNBssshPYnAu6H676al1C+elJZMD4gmX9+92?=
 =?us-ascii?Q?T7vIfaWub142fJv1uHpPdq0DIbKZFHDqUdy3l68VRb0CwDCLk+RgoTgCmsh7?=
 =?us-ascii?Q?i6aIxAVNQFZHSPpAMS9rPuBnYSxGVQzkQrzsbpuhQ1bkMhemFAtyRX+n3vp8?=
 =?us-ascii?Q?k+9TRBqxJKPsJfZV1nZjNyIgnam7cAm+6VTI5AqDQEAVTRcoHJJ/dfrLNK5c?=
 =?us-ascii?Q?WFCzOGycjZUTHVpSLAxX2tizeMCdSadk+bo0DUvhWc2JBp3rYs1gJmd1WjbA?=
 =?us-ascii?Q?oXJzqMJEqklu3tQ4dGaMy0aoJQABI0fH7xjgCWVDmcHe5JGJouTjN0pgMt2F?=
 =?us-ascii?Q?0J2QnpPeD9/FkJTxR9lDB0Z6mEjSHcEe6VMr74dGhLGz/OQpDfowi4CyREir?=
 =?us-ascii?Q?b8xv5asqL6MuG53IATYZOx770j75c7VmBn8yKXhPH0PRjTEusOVPbDCNXbf1?=
 =?us-ascii?Q?pzuUtM5bPL/1qweTxa1MmpgmuH8KkHT0bGheuKHHZdgy95qYzNGZx8yJPD3p?=
 =?us-ascii?Q?L/MDQ3PgJW43XbGf1lmCd+HPTFA0OI/lh+tT+jo8ZDvybi9YThpQplPHUwKc?=
 =?us-ascii?Q?7EQvJDJtIwPnZxIzfApQNd+DECKYTbgAbD9aBoRcuHBwEnjW7n47/SNWK6mr?=
 =?us-ascii?Q?+BRh0plmxJC+4T6Rk096Brro68KIV2CfavsHczNK5VtuZyOpaswMlWln2mna?=
 =?us-ascii?Q?aMCYsigPjgnNyPET4nInsdt2sw29BWLXH/0uL9Cxe9n7rIHaIKZp3LgEwBrw?=
 =?us-ascii?Q?8XN+jyYgtP/uJHxL4whGfQ4QGDzFdunXJTSpQaO6AYvBOqQItMnLimqP2SMZ?=
 =?us-ascii?Q?kfdOn66BQYG0rwyXeSpGCtexY6r0xbLALJ+ETy0/nk5GPdpTARpApnCIUWws?=
 =?us-ascii?Q?e+7p4Mxuw3b7KjHi3zSwL9HegLB5bteGxYKF8NZeuhkp+mNQmDAqGBvmID9n?=
 =?us-ascii?Q?r9HKgmEhKozsGNGBow/9wPDNx39avU4HFmPMfJgGUsIhoLHSdQopRu8Qis0a?=
 =?us-ascii?Q?wdynpM04VBDHS9mylEfaDFsMaqsha5aj1s26tRTrrCKO1PLezY0fuyHBmkTf?=
 =?us-ascii?Q?ghcU4CkTCGdOBhunmrKhLhKq/FQ39rw7/9/8NdI2rLBr44OeE9RV90Ep/sd2?=
 =?us-ascii?Q?jVxNmHytsHk1uLVhEfZI26s5LxH9Wo27iCqPAJwILW4epwH4kIShP+KzrqPN?=
 =?us-ascii?Q?Epjz0N7Bjum1AoFrw/ApBN9J+kT9kCaW3C3CaL16suQ1R0CllgUY9dHvQ3fq?=
 =?us-ascii?Q?dzBwv7QH+Ie/ZfQRLJaQumkzWAecNr2MGSy8z46G1gMcyy8h3gQtqEJfPAU7?=
 =?us-ascii?Q?AaLSO/WXNuqNDaQVgi2VPdUhhXy6tknOiqnOfL/pOJc8YlyQx2l0gLFPjbf0?=
 =?us-ascii?Q?4R2wZ0URUMmqEX0tKXXeVSKqh5Wu+FgNaiTDekK4fp87Ny/gx1Gb94ujNJ0y?=
 =?us-ascii?Q?fKOKxE/kYcbvL7V+yC7IuyBraLbyYdYD+T+SvIqq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f3078-4249-4def-648d-08d9d1716dae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:05:35.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVmZwJeDDcqFFQBtWQnq0msMi4MM7gm8ZkzEmIYXb+6M1T2aHq5QnpRsGwKBcZbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kATk6L6Vgraw8S2e947YFprAVEKvkTyj
X-Proofpoint-ORIG-GUID: kATk6L6Vgraw8S2e947YFprAVEKvkTyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=623 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:34PM +0800, Muchun Song wrote:
> The list_lru uses an array (list_lru_memcg->lru) to store pointers
> which point to the list_lru_one. And the array is per memcg per node.
> Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> a pointer size on 64 bits system) when we run 10k containers in the
> system. The memory consumption of the arrays becomes significant. The
> more numa node, the more memory it consumes.
> 
> I have done a simple test, which creates 10K memcg and mount point
> each in a two-node system. The memory consumption of the list_lru
> will be 24464MB. After converting the array from per memcg per node
> to per memcg, the memory consumption is going to be 21957MB. It is
> reduces by 2.5GB. In our AMD servers with 8 numa nodes in those
> sysuem, the memory consumption could be more significant. The savings
> come from the list_lru_one heads, that it also simplifies the
> alloc/dealloc path.
> 
> The new scheme looks like the following.
> 
>   +----------+   mlrus   +----------------+   mlru   +----------------------+
>   | list_lru +---------->| list_lru_memcg +--------->|  list_lru_per_memcg  |
>   +----------+           +----------------+          +----------------------+
>                                                      |  list_lru_per_memcg  |
>                                                      +----------------------+
>                                                      |          ...         |
>                           +--------------+   node    +----------------------+
>                           | list_lru_one |<----------+  list_lru_per_memcg  |
>                           +--------------+           +----------------------+
>                           | list_lru_one |
>                           +--------------+
>                           |      ...     |
>                           +--------------+
>                           | list_lru_one |
>                           +--------------+
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

As much as I like the code changes (there is indeed a significant simplification!),
I don't like the commit message and title, because I wasn't able to understand
what the patch is doing and some parts look simply questionable. Overall it
sounds like you reduce the number of list_lru_one structures, which is not true.

How about something like this?

--
mm: list_lru: transpose the array of per-node per-memcg lru lists

The current scheme of maintaining per-node per-memcg lru lists looks like:
  struct list_lru {
    struct list_lru_node *node;           (for each node)
      struct list_lru_memcg *memcg_lrus;
        struct list_lru_one *lru[];       (for each memcg)
  }

By effectively transposing the two-dimension array of list_lru_one's structures
(per-node per-memcg => per-memcg per-node) it's possible to save some memory
and simplify alloc/dealloc paths. The new scheme looks like:
  struct list_lru {
    struct list_lru_memcg *mlrus;
      struct list_lru_per_memcg *mlru[];  (for each memcg)
        struct list_lru_one node[0];      (for each node)
  }

Memory savings are coming from having fewer list_lru_memcg structures, which
contain an extra struct rcu_head to handle the destruction process.
--

But what worries me is that memory savings numbers you posted don't do up.
In theory we can save
16 (size of struct rcu_head) * 10000 (number of cgroups) * 2 (number of numa nodes) = 320k
per slab cache. Did you have a ton of mount points? Otherwise I don't understand
where these 2.5Gb are coming from.

Thanks!
