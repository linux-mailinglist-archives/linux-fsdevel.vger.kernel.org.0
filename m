Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25FE2DC74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgLPTk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 14:40:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgLPTk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:40:57 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BGJd2oo030305;
        Wed, 16 Dec 2020 11:40:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wnhDmJg4uvqXlD/GQ63+vVteb0Txdl2ThI14o04p69I=;
 b=me0LQlGb1kIm4PZo1qc0+qofY4Rl7fWDpQ3YKXUIhh3+1tTUqesBd9vVfs5xskzo/s0V
 p1ul0+XLIOVrnn37oXia7dhlGO4TCbhI8B/1j9D+o5NoxeJB1q09SZv/3crd9PWIJx+6
 kEz+20/9EM8Q4u/ck7owWqiKYAYFm2efy8A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35ej69u1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Dec 2020 11:40:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 11:40:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUKCPj+bR7sEB4gRZrsWTV1pnykTQu93LPkVDKAT3HeZmQTAYUN//qDgpxAOxuBGm3TIZTyHIwFR6Io7GWNi635nW6nCs4lQ5vNvRrswYlgn1w0ZrrcKDr6j076QHYxNcL4n22/4Q+AkS11CWNBHMTYE6I0sJUEaZVaP2bPDVlNES8hwhn0+fCg7+3/WqJekDzGrg1zuLwVz671Inp5cBqoOYHLJv6TOVzR6gQaDwzAut5PxFRx4ZgXP+8PjooBQr2wGvKX5q9vmuRHa9SX9+DYA6RtlvQg25ftQmB8R8MN8efXP8QRjiec8s5hno0WH2ijRwLoQYQwUntQ3BWAy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnhDmJg4uvqXlD/GQ63+vVteb0Txdl2ThI14o04p69I=;
 b=Bq35EsgtZFgp+MXbe5jMquzPZaX20Nmo2e+HSm2wzdwJRpjJYuAkXQ40AB/QjJPaKcQJlYfU7COOf4rbJ7rlMqpPZSbhm3DetBosqLelM7SNkBv5quTnSqnnmWw2xRQXgHOUj5yaBMyyEfDEFR+HrLuXjJeLT52uAmfNMJOior69fq3TLw+yRJZt3l/rFiV8qs1CLloEscaDVXa2jY3yE/MHMDi1q6fMFLX1TRkWn+VZnyAelrobxo477W89isTivXm7lWVjIZB2kVjGH/ZRNbTJPkDFrbyo3I/IeoOg/vntJmo+BmqsrlfE2ePLexNj2iYj8rZ1R3Byt4bZOYyUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnhDmJg4uvqXlD/GQ63+vVteb0Txdl2ThI14o04p69I=;
 b=RJzyOIP4p33QoHU5vS1dwFJ4NlFSdY/d5SOCVkZlLVfWMtuZmynxAdx/YlmmZE2yunXQol45gHcg3Z4sEtO3oYtDdrtXIxrA49J7p8euHBtNj+gcdl80LsGEHgRSfwzI8scu5EC0nip6k7aubKBUWQiFLo0q2URkoYI1ZPhBMDM=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3286.namprd15.prod.outlook.com (2603:10b6:a03:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 19:39:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 19:39:58 +0000
Date:   Wed, 16 Dec 2020 11:39:53 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>, <ktkhai@virtuozzo.com>,
        <shakeelb@google.com>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201216193953.GB3178998@carbon.DHCP.thefacebook.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area>
 <20201215135348.GC379720@cmpxchg.org>
 <20201215215938.GQ3913616@dread.disaster.area>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215215938.GQ3913616@dread.disaster.area>
X-Originating-IP: [2620:10d:c090:400::5:7945]
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:7945) by BYAPR02CA0032.namprd02.prod.outlook.com (2603:10b6:a02:ee::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 19:39:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afffa391-1936-4409-ba34-08d8a1fa5f10
X-MS-TrafficTypeDiagnostic: BYAPR15MB3286:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3286D59616C1057EBA0EB944BEC50@BYAPR15MB3286.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7tPalrowpNeob6Df91vnorG+8SOVyx8dmtd0iVOWoy7TAk02PWnF57slFyOgv0xQszaMyTpO5fjN8gOjLKzooRzcpuxQqoR6EceY8ijrIE0gdp7nlqcKzGRQRfHArHS54gm9u8sV8XCmWRWlnbbLpba1XW2jbfyuUZRSHJNsbpHdoj1YDPPmbcu0iXseHA/XO3ocAIb+TIWjnK3t/NLOldmTbwIXNhuWl67Xz+Rrf5KcqdKAwE5RljIVzURrDPUFRF2kijWc13Eq2XZ9rZG+dXbBCF6ehNy6JOx+6lNq2kfMb1MwD4QR3lZp9Dx7tDeJs4bY/da4PnuuyXvMU1P8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(16526019)(66476007)(8676002)(66556008)(478600001)(1076003)(8936002)(54906003)(55016002)(2906002)(52116002)(33656002)(5660300002)(7696005)(7416002)(316002)(4326008)(83380400001)(66946007)(6506007)(6666004)(6916009)(9686003)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hjyvkgCB4aXslWUFVIgD9KyxuSUt6QBCtE56IVeDChw6YXKtfct1jKq3XfuY?=
 =?us-ascii?Q?49anZ5AeiG5hfKSljuoDjSZvf66tv5Hm2ZR68W3054xNBEHmKmx3vvL1VDOs?=
 =?us-ascii?Q?63sZgVN9bW8PhCjmZMwSfjXlxgelnRIcBPtQFQIGSi0V+ttWy77vTRNx0dMn?=
 =?us-ascii?Q?15e4PsB5BblDZWsRR4UhKjzaDSc9RJYALinRGwafl1Yi2JI/wcKN7J7ZifGJ?=
 =?us-ascii?Q?Rz4fVTQby8Ohw2Zi8Yl/f27V4oXmGvoe7BsVP/UjLHeA8XppeTeg07VNw8it?=
 =?us-ascii?Q?cXqXkLWPV+pFstRwIAGaxdu6LH7fB/LaogGh8TEWnao4GbClXK/ZoyWIPH7j?=
 =?us-ascii?Q?ZY3rXxUNIwfnFMFeSYMFtL9jiQp19Bn0552XqthNSInglIi/fEhfnue8uGhl?=
 =?us-ascii?Q?AAdNVAvRVaEBKSJm6HTmmYbDyPFAdAR7jAIeg4DH6+8RAX52ZtcN2mlpOyb9?=
 =?us-ascii?Q?cDTG/6EZKqVOMElcUTKVgF8JvyIvQQx059R1sLrBJdQu7nb615+5HPrgemUB?=
 =?us-ascii?Q?Sv5zEgc1XhaFkgZAbz7zSGDEQWDMMXZ39aFwIWkg1x2KTslQPlDJur3Pu4Ja?=
 =?us-ascii?Q?DBfsdYpkhSyB4jzODuQPHEHm023dYtBALQ9IWJPw2v/SE2uB/rirym4iFKgb?=
 =?us-ascii?Q?wEb5sIo/R5/U2bq/ylJuOY3+B199hMysfwOEJ0h+By80vEWcVIJF1bhYMu15?=
 =?us-ascii?Q?TmOgGPxrZhtcyRzHJU11PyV7TFDM5d3CyF+k+s324J8mcIfHbl8fIokcPAGi?=
 =?us-ascii?Q?btLPd/zTOmm9ZDVxQoClyoTwfXh0QwU83sPsa0cz4+eAuwX8cWnJx6nSXz9v?=
 =?us-ascii?Q?THg3us8Y88F8L28iAPhTewTiIqT6OPMfwzUXuRPBxNHstUTa9gzrpdXatfjt?=
 =?us-ascii?Q?qsjvTJNBbZQ546Jx7yfjq90N06pUGPAjtvLstiIfp5lrdzwo4AIUpTT6Qfm5?=
 =?us-ascii?Q?8oVZdcEMEnwwMqirHs9A/VlgFAB0QuBtg1BQwXyiVwR5eFOZNnEhV2nvmkFI?=
 =?us-ascii?Q?c7u99UmFowz5xEn9Oanbg14JSQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 19:39:58.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: afffa391-1936-4409-ba34-08d8a1fa5f10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb8ql/WZ8YyMwV+FSRrjTu39KuP9dLpIsGB+XtYTAZwU8XdiLraNMk3SUf7RiC9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3286
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_08:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 08:59:38AM +1100, Dave Chinner wrote:
> On Tue, Dec 15, 2020 at 02:53:48PM +0100, Johannes Weiner wrote:
> > On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> > > On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > > > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > > > exclusively, the read side can be protected by holding read lock, so it sounds
> > > > superfluous to have a dedicated mutex.
> > > 
> > > I'm not sure this is a good idea. This couples the shrinker
> > > infrastructure to internal details of how cgroups are initialised
> > > and managed. Sure, certain operations might be done in certain
> > > shrinker lock contexts, but that doesn't mean we should share global
> > > locks across otherwise independent subsystems....
> > 
> > They're not independent subsystems. Most of the memory controller is
> > an extension of core VM operations that is fairly difficult to
> > understand outside the context of those operations. Then there are a
> > limited number of entry points from the cgroup interface. We used to
> > have our own locks for core VM structures (private page lock e.g.) to
> > coordinate VM and cgroup, and that was mostly unintelligble.
> 
> Yes, but OTOH you can CONFIG_MEMCG=n and the shrinker infrastructure
> and shrinkers all still functions correctly.  Ergo, the shrinker
> infrastructure is independent of memcgs. Yes, it may have functions
> to iterate and manipulate memcgs, but it is not dependent on memcgs
> existing for correct behaviour and functionality.
> 
> Yet.
> 
> > We have since established that those two components coordinate with
> > native VM locking and lifetime management. If you need to lock the
> > page, you lock the page - instead of having all VM paths that already
> > hold the page lock acquire a nested lock to exclude one cgroup path.
> > 
> > In this case, we have auxiliary shrinker data, subject to shrinker
> > lifetime and exclusion rules. It's much easier to understand that
> > cgroup creation needs a stable shrinker list (shrinker_rwsem) to
> > manage this data, than having an aliased lock that is private to the
> > memcg callbacks and obscures this real interdependency.
> 
> Ok, so the way to do this is to move all the stuff that needs to be
> done under a "subsystem global" lock to the one file, not turn a
> static lock into a globally visible lock and spray it around random
> source files. There's already way too many static globals to manage
> separate shrinker and memcg state..
> 
> I certainly agree that shrinkers and memcg need to be more closely
> integrated.  I've only been saying that for ... well, since memcgs
> essentially duplicated the top level shrinker path so the shrinker
> map could be introduced to avoid calling shrinkers that have no work
> to do for memcgs. The shrinker map should be generic functionality
> for all shrinker invocations because even a non-memcg machine can
> have thousands of registered shrinkers that are mostly idle all the
> time.
> 
> IOWs, I think the shrinker map management is not really memcg
> specific - it's just allocation and assignment of a structure, and
> the only memcg bit is the map is being stored in a memcg structure.
> Therefore, if we are looking towards tighter integration then we
> should acutally move the map management to the shrinker code, not
> split the shrinker infrastructure management across different files.
> There's already a heap of code in vmscan.c under #ifdef
> CONFIG_MEMCG, like the prealloc_shrinker() code path:
> 
> prealloc_shrinker()				vmscan.c
>   if (MEMCG_AWARE)				vmscan.c
>     prealloc_memcg_shrinker			vmscan.c
> #ifdef CONFIG_MEMCG				vmscan.c
>       down_write(shrinker_rwsem)		vmscan.c
>       if (id > shrinker_id_max)			vmscan.c
> 	memcg_expand_shrinker_maps		memcontrol.c
> 	  for_each_memcg			memcontrol.c
> 	    reallocate shrinker map		memcontrol.c
> 	    replace shrinker map		memcontrol.c
> 	shrinker_id_max = id			vmscan.c
>       down_write(shrinker_rwsem)		vmscan.c
> #endif
> 
> And, really, there's very little code in memcg_expand_shrinker_maps()
> here - the only memcg part is the memcg iteration loop, and we
> already have them in vmscan.c (e.g. shrink_node_memcgs(),
> age_active_anon(), drop_slab_node()) so there's precedence for
> moving this memcg iteration for shrinker map management all into
> vmscan.c.
> 
> Doing so would formalise the shrinker maps as first class shrinker
> infrastructure rather than being tacked on to the side of the memcg
> infrastructure. At this point it makes total sense to serialise map
> manipulations under the shrinker_rwsem.
> 
> IOWs, I'm not disagreeing with the direction this patch takes us in,
> I'm disagreeing with the implementation as published in the patch
> because it doesn't move us closer to a clean, concise single
> shrinker infrastructure implementation.
> 
> That is, for the medium term, I think  we should be getting rid of
> the "legacy" non-memcg shrinker path and everything runs under
> memcgs.  With this patchset moving all the deferred counts to be
> memcg aware, the only reason for keeping the non-memcg path around
> goes away.  If sc->memcg is null, then after this patch set we can
> simply use the root memcg and just use it's per-node accounting
> rather than having a separate construct for non-memcg aware per-node
> accounting.
> 
> Hence if SHRINKER_MEMCG_AWARE is set, it simply means we should run
> the shrinker if sc->memcg is set.  There is no difference in setup
> of shrinkers, the duplicate non-memcg/memcg paths go away, and a
> heap of code drops out of the shrinker infrastructure. It becomes
> much simpler overall.
> 
> It also means we have a path for further integrating memcg aware
> shrinkers into the shrinker infrastructure because we can always
> rely on the shrinker infrastructure being memcg aware. And with that
> in mind, I think we should probably also be moving the shrinker code
> out of vmscan.c into it's own file as it's really completely
> separate infrastructure from the vast majority of page reclaim
> infrastructure in vmscan.c...
> 
> That's the view I'm looking at this patchset from. Not just as a
> standalone bug fix, but also from the perspective of what the
> architectural change implies and the directions for tighter
> integration it opens up for us.

I like the plan too.

Thanks!
