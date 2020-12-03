Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4A2CDF5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgLCUIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 15:08:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725885AbgLCUIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:08:17 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B3JxrZl027625;
        Thu, 3 Dec 2020 12:07:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cCyUHIO6PLp/xbHwiowbpqLIGk68OjGHGALTlVunrxo=;
 b=Ru8K7/7LmV0RCOB+g9EtcLuEo4qyIHw+g9jrLMtITOIzarbQ+3hG/X96KKDyODBK45Eq
 Yn6PJj3v+6N6c+kaUVUov0kvGttMP2bgTENBl+3ofEpPpn2VRfkT+sh0U+3cEXIHii2R
 S/zI8eLYkamWgcU7nSaMzrKtdMdEr1tWVUQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3576828905-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 12:07:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 12:07:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVsrkMMNEXwTDwqRIC2F5+2RRLqEZIfnBbPufAZ3YOy2eF5JU+PiBYt1rdHeMvBMFHq8v2TDMnUEGBFNVobRDIvEKliI9q5zYq5AH2RWRNWAyEcDgxYIZZQVD1Gix2ajwnyPyFr+wFSjAOPRMGcgk5jJ6zN0WhYmb48aZ9DEhsLFs6R8tAlFq0M4kO+2wkcQ9tNh5qjY/2o7fdJMVsoOT5AxbPyLbKSKYVjj33xXUtcmUzXSejmCRwJUH/3UcprbWvrwNlqOgPXBrz2UOk5dXh/bnaX4g17NaQsbj06mSa2Mtt46aqIONtq5ALp5K/OFSoA8ggByq9GeEiHxxS6Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCyUHIO6PLp/xbHwiowbpqLIGk68OjGHGALTlVunrxo=;
 b=R8pDzWMKiA2++yd1sPfyJrUT8aOfT4bdf8KrBM5djbpd1y4DVO0k3jzN6E477X8PxhdVpZnQodZPlTPhzOkf6+GldckIG9j8gJ815S+TNzwwmmzcvZRSJr3V1O6rNg6uT7iDXDmusjnA4rBgyq/g6hRdavw7l+w1W+p0nP1UWGOhpQ5n193+/E8hIa0jXnXILrZBaIGKQo7kptz8lsBVTgoCr2edMfbdoJTnJF78w0sKxFsZhYM1yMrPohILhPmI09FrLJa72NKuSZ4V3Gyuw6fcAIplq+RB104l3BHzfDAuOEu/2dowPbZl8vVnZGd4q8sUkdfyaJrGXC7XgRarsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCyUHIO6PLp/xbHwiowbpqLIGk68OjGHGALTlVunrxo=;
 b=W4c2sOERbLQioqxTiOfyrz+Ux9iQmtRjK0GAlYGSkCV/OJyBTWV4wkLzCMfJDHXZL4uWHhR86n+krefUV8cJ8MTJg6fN91Upioww4ZeZh1/s12HQWSS2g4fVDihC1S7H9S7tqwTkSe0M5jthHile7QnNlSKNOzqXWAVDya/Uuyw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 3 Dec
 2020 20:07:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 20:07:21 +0000
Date:   Thu, 3 Dec 2020 12:07:15 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
Message-ID: <20201203200715.GB1571588@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-6-shy828301@gmail.com>
 <20201203030632.GG1375014@carbon.DHCP.thefacebook.com>
 <CAHbLzkrU0X2LRRiG_rXdOf8tP7BR=46ccJR=3AM6CkWbscBWRw@mail.gmail.com>
 <CAHbLzkpAsoOWeRuFeTM2+YbjfqxY2U3vK7EYX2Nui=YVOBXFpw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpAsoOWeRuFeTM2+YbjfqxY2U3vK7EYX2Nui=YVOBXFpw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ae64]
X-ClientProxiedBy: MWHPR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:300:12b::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ae64) by MWHPR14CA0031.namprd14.prod.outlook.com (2603:10b6:300:12b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 20:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41e2a56-300e-487b-9500-08d897c70ab2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26301D53C45A25E7CF286AC2BEF20@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WXtis7Wu/MxPGg/vtBtSj4XN40GRN/gRsInQ7GJo64k3R82oz8SyZ/WR4KCQWgAp/Bn+7Q3seNBZOIOwSRtpvE8yvlW+GmpFJ79JTyswA3Oi/uKZUFD3kp6rgq8xLK1HPd2ifIRz22tw2X3bOPhp1DjcnRHB3sD0rDGZLLybgNRD4kyISOLU3wI4HpwZcEy5g/lh4t5WDeUkDPVEdrlARvrcOMX8jiP+Z3SxjgM8hFatxx+giCQE4ElwUC32rO+ikhtK04aYuH0HGTrdi2VlIh9x4BBjLnDoiJXCKse9oj2pa+ZIrFjmvvGKNNdkRNhqdV1rlu6qfu+nqUQhirWhgTzlvWRxS8XOVn+2rscUM6Xv+oejmEhx+2oUY43Ny8vwys5XDXPYY25d0hDYoQQEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(6506007)(53546011)(7696005)(52116002)(54906003)(16526019)(6916009)(1076003)(2906002)(4326008)(478600001)(5660300002)(6666004)(966005)(9686003)(55016002)(316002)(86362001)(66556008)(66476007)(66946007)(7416002)(83380400001)(186003)(8936002)(33656002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a2Y4WGB2zmLuV8PnCjfPXZ6ZNTPf9Z5LP3UI6FElTN39THx84dnbtL9Ig+Ac?=
 =?us-ascii?Q?/5ODkq20j6hwQz2hmPQN4BJBuPZIDRe/UCEMzMQ9iSAWkhFqDkUB4x25YZ6t?=
 =?us-ascii?Q?k6zZudzvnzUuWRELRVPvkZz+AR7DpqcmmU/M2+hoVmcLMb2GMNmrOwyWqz4m?=
 =?us-ascii?Q?rGIfs5Kjf01G+WeLXyFsq/JUqs50GJ2Olr5HDer2w9tOFqvo8sjJT4OEQVNV?=
 =?us-ascii?Q?4MmAGQsoU3JF7lY+UlBnN6500c1nah6B7CS8uNM+GcvNtDwRhLQmSik6/v3o?=
 =?us-ascii?Q?5tgSlt+Xv3MkFaI5NpJvnjVNVSTq4HoCwp2riys03w4teOoxPNdmxiyHZNEY?=
 =?us-ascii?Q?aJ9toP7XiL8aIjYn4F9S/RZ/WSvr3N0snD8JOx7sDZAVYPae218qs+0udISY?=
 =?us-ascii?Q?apvxqPnmttRkcVkdw++RpSweNCA/KsCwmoF+D1s5lX4Fx+6PfX24Wza74n6K?=
 =?us-ascii?Q?IjxyFFO+i3qwdD09bIpcOBrZoWnM2o6XeXPGeYvA4d55Z8dzUZ/krNycjpqf?=
 =?us-ascii?Q?7t95QU2nrfwl2rosoXL0Gf2k50Hwnl+gszFRlm8GnyA4hdvaJb4Sy0cAe+sD?=
 =?us-ascii?Q?Fg2bXGw1OhpwglmL7E8Xe86D+AvuoPCmb6kJlQxTPO6HO2yC1Rcd4q07iHH/?=
 =?us-ascii?Q?XXPrTDZUAfYXylPCP9Z6ICTnfUM1tezOXtyNc7uLxut0qwIZqWLq1Kz9YrhG?=
 =?us-ascii?Q?5fJdh2uZ4Kcg+Bh6gDNH75/EpgIaXez0nsjfksWP+1T42qe0bAjOeu3uRvZz?=
 =?us-ascii?Q?NuwMOK6unLW5iYOkWBDm0qCMMJMZ3iWG5x9QTZq6NCkeohBNSQBgm99M4St9?=
 =?us-ascii?Q?35SRbHR/Y32N3ITK0XrH0moRgRrGt4Li4v6HLFFD4J5Asz+ASuTggBig4pOx?=
 =?us-ascii?Q?S4KZajweGr0w/ktwHKd+z3L3OtdHSJGzZuEJwnbeLI+nI6ZcP+faX6Xx4c7P?=
 =?us-ascii?Q?4g6gV4xtZ7XLuuLXynDFi4ghsQFgpRy4ylHOZ0FdEN6H0oKIhHj2ZKNqg2EW?=
 =?us-ascii?Q?aHuTvOxrv8z5JS3JsF+K4z8f8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a41e2a56-300e-487b-9500-08d897c70ab2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 20:07:21.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mQOTDay9KuVa94AF5m/0P5LWvZbb5TyXY6Bfq8EuBKjjmtNnMNSmW6fP2ToP3do
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_11:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 10:03:44AM -0800, Yang Shi wrote:
> On Wed, Dec 2, 2020 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Dec 2, 2020 at 7:06 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > > > Currently the number of deferred objects are per shrinker, but some slabs, for example,
> > > > vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> > > >
> > > > The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> > > > excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> > > > may suffer from over shrink, excessive reclaim latency, etc.
> > > >
> > > > For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> > > > heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> > > > might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> > > >
> > > > We observed this hit in our production environment which was running vfs heavy workload
> > > > shown as the below tracing log:
> > > >
> > > > <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> > > > cache items 246404277 delta 31345 total_scan 123202138
> > > > <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> > > > last shrinker return val 123186855
> > > >
> > > > The vfs cache and page cache ration was 10:1 on this machine, and half of caches were dropped.
> > > > This also resulted in significant amount of page caches were dropped due to inodes eviction.
> > > >
> > > > Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> > > > better isolation.
> > > >
> > > > When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> > > > would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/memcontrol.h |   9 +++
> > > >  mm/memcontrol.c            | 112 ++++++++++++++++++++++++++++++++++++-
> > > >  mm/vmscan.c                |   4 ++
> > > >  3 files changed, 123 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > index 922a7f600465..1b343b268359 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -92,6 +92,13 @@ struct lruvec_stat {
> > > >       long count[NR_VM_NODE_STAT_ITEMS];
> > > >  };
> > > >
> > > > +
> > > > +/* Shrinker::id indexed nr_deferred of memcg-aware shrinkers. */
> > > > +struct memcg_shrinker_deferred {
> > > > +     struct rcu_head rcu;
> > > > +     atomic_long_t nr_deferred[];
> > > > +};
> > >
> > > The idea makes total sense to me. But I wonder if we can add nr_deferred to
> > > struct list_lru_one, instead of adding another per-memcg per-shrinker entity?
> > > I guess it can simplify the code quite a lot. What do you think?
> >
> > Aha, actually this exactly was what I did at the first place. But Dave
> > NAK'ed this approach. You can find the discussion at:
> > https://lore.kernel.org/linux-mm/20200930073152.GH12096@dread.disaster.area/.

Yes, this makes sense for me. Thank you for the link!

> 
> I did prototypes for both approaches (move nr_deferred to list_lru or
> to memcg). I preferred the list_lru approach at the first place. But
> Dave's opinion does make perfect sense to me. So I dropped that
> list_lru one. That email elaborated why moving nr_deferred to list_lru
> is not appropriate.

Hm, shouldn't we move list_lru to memcg then? It's not directly related
to your patchset, but maybe it's something we should consider in the future.

What worries me is that with your patchset we'll have 3 separate
per-memcg (per-node) per-shrinker entity, each with slightly different
approach to allocate/extend/reparent/release. So it begs for some
unification. I don't think it's a showstopper for your work though, it
can be done later.
