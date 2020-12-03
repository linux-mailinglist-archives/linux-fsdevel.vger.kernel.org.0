Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6852CCCE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgLCCxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:53:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgLCCxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:53:47 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B32o9AH013170;
        Wed, 2 Dec 2020 18:52:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=grEoZtx4ssjMXjDabpRCRXgfM09PoAvxPgx4B2/PwCk=;
 b=CMdljBo2NGSr8etr5uf1oTu1T3FXrOKLc0GkpLNR2fdJSKQDPved77aJOHPKzCkpXmLD
 lKy7lsf8icgg+ktZxceE1LZusL9GXXo+3msUK/9pFP01I1S/UeLA/GD1BNoHFZuRn2TT
 bxpomdje7Ba42SH8PhXBhesziLK9KGSBrg8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356fsfbpx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 18:52:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 18:52:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO8Tin3xWv9GiUz8pQcC/8neTcoCxGGs0zR+4+i/3ND1AbnsmIDYAxPQzDxKytEEPvMVA/BRTVtai3+CAHXchXN73EsMxj7yi5iEFZ6jL0lj3DZx7UyIc3Juca/tCIjbVSmRzqiI91SKwC3m66pR2ji/Ud8CA2OxPabXWjXZoEvMSJsvkpj2uMEMfoqGZ7bWzymjecdUBIh9ORU/Ns2/I7IIS+0wVMLh6fg9PS/XqkHW59u3tyippNiUQa1rZ0IfA5a/kBj3cSXC/BR8uKYVaAZCiJHkHuCztb5oNzhpsrP976FflyP7q+gDRhYAvaEZYABIYmR9uw5ngf2asHsgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grEoZtx4ssjMXjDabpRCRXgfM09PoAvxPgx4B2/PwCk=;
 b=Rq/e7iW4ziU4UX90Cp2nSbvBvOWMR+/ClmlzxCo1Yq16ToE2Wq4jW+mFu0eXBsOWP64Cn9SpiLhsp52gw/KgEfov/s1brgEvhOJqY2polt86yGZasvmcGbNBvuarzoidviItuub5L6X+MMisPasMh+CPYnEPFRpHxn18YJzhuVbuzal2uHrvYBmkNaZ462X6Kl6PlZ71zugrT4jV4+hYrGKWgct5p7J6oOyv0H+QmiHfpM3cn3APkVvx7Wo56HtJw+lN6OZkM6JTPRlbx7iXCjD0ad+VOphGf3fowlEh8NEtj/SDyRamuG4KzOCV/KaKPw3YtpH4nscmMzVOkqkwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grEoZtx4ssjMXjDabpRCRXgfM09PoAvxPgx4B2/PwCk=;
 b=FI+BMzcWCB1WaO8aOsOY5dpw+NNUIwflyrNPqdss0H47FAW/lXP9Yocv4WrYesOuOqCoIFGGycIBpGf2sj/qejd6i7BdN1CW/KAL4pCjzfyJfdpeTngEJjpA6rbB9+aseQBap2TZMHEykeA18J9FEF822VIvVJR7mxeKMX9iom8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2757.namprd15.prod.outlook.com (2603:10b6:a03:156::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 02:52:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 02:52:39 +0000
Date:   Wed, 2 Dec 2020 18:52:34 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] Make shrinker's nr_deferred memcg aware
Message-ID: <20201203025234.GD1375014@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ab8d]
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ab8d) by MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 02:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f00771-d59d-4608-0744-08d897367f8d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2757:
X-Microsoft-Antispam-PRVS: <BYAPR15MB275712E106C669921BB93DCFBEF20@BYAPR15MB2757.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiN9g9hXICXShQ8G0SXDxCyuP1aOiaslRd4H8qGXk1iBiI4GxYHEBa/5whIoX/cjggEbgu5aBca1AW/cw1sqZFz0FG4aY60AdMPEirtboHK3ev7ZGxtW7v+Gf9eDvy54bn78O/5Qy86svREzyDsb9WpqAfY+blTNWLO8COYEipZpmOvvsWLOqzYEb2r2QktPPg7PhzHgNTsLPhoOKYKOgcmtarHvJi6PNYv7udSqPg3nkNFsT4ovWapX/VM+tj7C/95TAXhTwzMRZN+zdTjBevneo6PJw0XYAcbpIPxQPr/6Y52rvVArTFujN80vbKq6QZxZ6QoXBr5iq/JWkLlsmAvbW1zlm/tN0Wv17DVfphqosYjtKlAkQs7Kplkw3AlTs3m21bPfxvTItRdwNepsWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(346002)(136003)(66476007)(8676002)(9686003)(55016002)(8936002)(6916009)(66946007)(86362001)(16526019)(4326008)(7416002)(966005)(66556008)(2906002)(83380400001)(5660300002)(186003)(316002)(52116002)(478600001)(7696005)(6666004)(33656002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E6Gz40TvRVdv34P3bttQXW1qSE4WBNgHrUnT9FUKJNnTOzhZfebViubxnmOO?=
 =?us-ascii?Q?HcW2EWJc5NP9e4zD218sXYwIdQPXGqIAtsZJM4iHoXz7ZmVRLJEnHn1/Q9oK?=
 =?us-ascii?Q?y1Qb4qUgHR7fzzVPYOcKPr/xBQSDVga6pxkU1Q/n21m7jLi1YtTX1l6hGwKa?=
 =?us-ascii?Q?hTBq/ZIhFY3SPSCYzf/8yD8PKcbQIDNpO4sXSwgmOVWv0jUJ+8Ho6DvXlTuQ?=
 =?us-ascii?Q?LbEN6IV0tMgivEIydnDDLNwBFgbapkuY6Lrld4uLgxcC8NAFjaSi0bvZwzG/?=
 =?us-ascii?Q?dyY6GkDkC6qEqXi+2wFDacA1nWUXJ/oNFMYzOPYR5fqFiMm6fyw3Lw98Fpu8?=
 =?us-ascii?Q?B6y+ANnBZrL7LugzXvQlzzffyDDq3EqNw3O7hSEHx42J6m1zdMn6J/MW6SnI?=
 =?us-ascii?Q?RpDltTJKeFs8UQG1tJGI9rBgFUPy2I06AiNNFatLeZXUTNbIVcfMTqgKttRv?=
 =?us-ascii?Q?VW4355NNBu4nwGX5hWlS2WYQzDDh7W/2iRXJXdgUYh7qh2yt2+Ekno8sQffX?=
 =?us-ascii?Q?keGIRguT3466W0Y6Y08QU4E6sOeWedHmb+0ZkCNcqmoi+2L+8csiQanfmsWE?=
 =?us-ascii?Q?AKdwl/UdYYK+0oiwcVm+SLv3qlIObjXIlrLBaMznnyu4ID9u+ZCot77eAzG8?=
 =?us-ascii?Q?KsBR2yViSa3onRGAS1vz9P+/0Sg/dpj16T2Jm9dg3phbjNwFl8GbcOui1aah?=
 =?us-ascii?Q?MuHBnJa8tRJjKkqWT2IKGauVTPvbKalM29HGSOcjgU9r7SwJxel4mBTTrnw9?=
 =?us-ascii?Q?d3gDR8svzeBnlkSAXEpnNZxDL1h4vXzE8KG9eq726MENGceJwP/2Uqfm9jjA?=
 =?us-ascii?Q?zbC/SJAisfrKnbRf49VBHQlSGYIWpR83Xli1MoU/5y3iZ3PVl3dEvzlEOKjp?=
 =?us-ascii?Q?q7dOOqPO1lt+rojRxua9EWBIG7vC7qs980/EcrE1lLOJQ7igxmMe4LEpLJDo?=
 =?us-ascii?Q?wGWLfXPIkhHBQZIv7EAPln9uVgamw9D6ErBd11H/PA4I5fnYrASViJVdMdm+?=
 =?us-ascii?Q?9wwaCL389DHbp9nL+6bmR9M/aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f00771-d59d-4608-0744-08d897367f8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 02:52:39.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDNp6xv4M30rx59LqSiI1fcu7Jyi9vzwUnjQEI5GcxEv1nx15bOoWRUcqmdxz98I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2757
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:16AM -0800, Yang Shi wrote:
> 
> Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
> it turned out there were huge amount accumulated nr_deferred objects seen by the
> shrinker.
> 
> On our production machine, I saw absurd number of nr_deferred shown as the below
> tracing result: 
> 
> <...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
> super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
> 2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
> 9300 cache items 1667 delta 11 total_scan 833
> 
> There are 2.5 trillion deferred objects on one node, assuming all of them
> are dentry (192 bytes per object), so the total size of deferred on
> one node is ~480TB. It is definitely ridiculous.
> 
> I managed to reproduce this problem with kernel build workload plus negative dentry
> generator.
> 
> First step, run the below kernel build test script:
> 
> NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> 
> cd /root/Buildarea/linux-stable
> 
> for i in `seq 1500`; do
>         cgcreate -g memory:kern_build
>         echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes
> 
>         echo 3 > /proc/sys/vm/drop_caches
>         cgexec -g memory:kern_build make clean > /dev/null 2>&1
>         cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1
> 
>         cgdelete -g memory:kern_build
> done
> 
> Then run the below negative dentry generator script:
> 
> NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> 
> mkdir /sys/fs/cgroup/memory/test
> echo $$ > /sys/fs/cgroup/memory/test/tasks
> 
> for i in `seq $NR_CPUS`; do
>         while true; do
>                 FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
>                 cat $FILE 2>/dev/null
>         done &
> done
> 
> Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
> showed:
> 
> 	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
> objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
> 	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
> scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928
> 
> There were huge number of deferred objects before the shrinker was called, the behavior
> does match the code but it might be not desirable from the user's stand of point.
> 
> The excessive amount of nr_deferred might be accumulated due to various reasons, for example:
>     * GFP_NOFS allocation
>     * Significant times of small amount scan (< scan_batch, 1024 for vfs metadata)
> 
> However the LRUs of slabs are per memcg (memcg-aware shrinkers) but the deferred objects
> is per shrinker, this may have some bad effects:
>     * Poor isolation among memcgs. Some memcgs which happen to have frequent limit
>       reclaim may get nr_deferred accumulated to a huge number, then other innocent
>       memcgs may take the fall. In our case the main workload was hit.
>     * Unbounded deferred objects. There is no cap for deferred objects, it can outgrow
>       ridiculously as the tracing result showed.
>     * Easy to get out of control. Although shrinkers take into account deferred objects,
>       but it can go out of control easily. One misconfigured memcg could incur absurd 
>       amount of deferred objects in a period of time.
>     * Sort of reclaim problems, i.e. over reclaim, long reclaim latency, etc. There may be
>       hundred GB slab caches for vfe metadata heavy workload, shrink half of them may take
>       minutes. We observed latency spike due to the prolonged reclaim.
> 
> These issues also have been discussed in https://lore.kernel.org/linux-mm/20200916185823.5347-1-shy828301@gmail.com/.
> The patchset is the outcome of that discussion.
> 
> So this patchset makes nr_deferred per-memcg to tackle the problem. It does:
>     * Have memcg_shrinker_deferred per memcg per node, just like what shrinker_map
>       does. Instead it is an atomic_long_t array, each element represent one shrinker
>       even though the shrinker is not memcg aware, this simplifies the implementation.
>       For memcg aware shrinkers, the deferred objects are just accumulated to its own
>       memcg. The shrinkers just see nr_deferred from its own memcg. Non memcg aware
>       shrinkers still use global nr_deferred from struct shrinker.
>     * Once the memcg is offlined, its nr_deferred will be reparented to its parent along
>       with LRUs.
>     * The root memcg has memcg_shrinker_deferred array too. It simplifies the handling of
>       reparenting to root memcg.
>     * Cap nr_deferred to 2x of the length of lru. The idea is borrowed from Dave Chinner's
>       series (https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/)
> 
> The downside is each memcg has to allocate extra memory to store the nr_deferred array.
> On our production environment, there are typically around 40 shrinkers, so each memcg
> needs ~320 bytes. 10K memcgs would need ~3.2MB memory. It seems fine.
> 
> We have been running the patched kernel on some hosts of our fleet (test and production) for
> months, it works very well. The monitor data shows the working set is sustained as expected.

Hello Yang!

The rationale is very well described and makes perfect sense to me.
I fully support the idea to make nr_deferred per-memcg.
Thank you for such a detailed description!

More comments in individual patches.

Thanks!

> 
> Yang Shi (9):
>       mm: vmscan: simplify nr_deferred update code
>       mm: vmscan: use nid from shrink_control for tracepoint
>       mm: memcontrol: rename memcg_shrinker_map_mutex to memcg_shrinker_mutex
>       mm: vmscan: use a new flag to indicate shrinker is registered
>       mm: memcontrol: add per memcg shrinker nr_deferred
>       mm: vmscan: use per memcg nr_deferred of shrinker
>       mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
>       mm: memcontrol: reparent nr_deferred when memcg offline
>       mm: vmscan: shrink deferred objects proportional to priority
> 
>  include/linux/memcontrol.h |   9 +++++
>  include/linux/shrinker.h   |   8 ++++
>  mm/memcontrol.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  mm/vmscan.c                | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
>  4 files changed, 274 insertions(+), 74 deletions(-)
> 
