Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051142CE2B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgLCXb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:31:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgLCXb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:31:57 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3NKx7a028320;
        Thu, 3 Dec 2020 15:31:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=F1Fwe9vaHBhl+Af4fJjlSoOONlK/UQ61GGtq/Hq+Qlo=;
 b=aeXcVihxjKz2hlhfq4rfGFbqBgG+UmpzVyYzV0fPIoCJ/XM6YAdSu2320QB3yUyvaeag
 Ad9bphjHmjxKNpHQD0lk+CPiSYPqZipc9Sp7LvMPohUVA/aJh7y4kNSev1w3V8dE6quT
 ldWpAkI0IesLnkXJNcqsptwhTcPTxWr04eA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 356xfqw2pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 15:31:02 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 15:31:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL1zWgfwd3YvCcfWuK3ej12cGBNSdkhZ9YejU46p2G5+JUme6PDbnWUwHPSln98vS6dBzyeNi/xGvhryp4yYc7b/hgOVIEj18tyR0unuDnC1ZAVsmVK1R76PD9fi01M+Jhpe6P8yugwPDVa+YVGwWubm9W4WyR/vpO3JRRP0SJqI2lbYJrZil+taavnbN0kX+plv47FkBO/D+mM5vgXYG7vyoTGAjjqSri7OHyG2+vorrwbPpVxYLCjWd0NCcIOU9ud/Y1l3f+RvqOLxGOF4y7x2iebOPTT+W+Z0yHeGHiPWo0ifCDaICjF3feXozMg30zknEC1q2biIioJ+tfFkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1Fwe9vaHBhl+Af4fJjlSoOONlK/UQ61GGtq/Hq+Qlo=;
 b=j8iHSRZXrjvTLJL3MCMydpozJrWep1C3anPxB7Vvkaf8VwXppjlhLsakOLKez6b/AuQBLGU7D4iL2LWmbjQCT1C71ggw2j/FCuX2gOY7h1yBQwXOvmYDng5e5IKQNWJ6f23fozlOEIWR42M4qz/85ge21+A8f9phelbpcL2FHazbod9vKAJ9/SSJO8TS6yumr8n3g3mkgJ1zxoulTHZOf4lgVinHTVqe5WJSEl1yglJAgrqsUi/oMMo/M59ScVz80bkxGtaByutk1eLIGFY9AzcKyU6WTFe0DtDCYl3etI0KcC0dwU+y6sMsMqPeNv/HImDHdEO2X6ydRhMCigWfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1Fwe9vaHBhl+Af4fJjlSoOONlK/UQ61GGtq/Hq+Qlo=;
 b=CfjnWrhNRaMWdx9cNGCmg9KoeBj9ZDMF0BcxyjdApIa8nX8bAeNjCcbUCtxWzeQQZ73r83VfFKJbRQx69XatB3IW5Kn10RxhvvKJL/dmuSiO+7ZEJiBVp9isRPu2D1vPf+1X1wmJRSlQfnM7RWx2D+ls5owSFWCh6oQv6wui5K0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2277.namprd15.prod.outlook.com (2603:10b6:a02:92::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 23:31:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 23:31:00 +0000
Date:   Thu, 3 Dec 2020 15:30:55 -0800
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
Message-ID: <20201203233055.GA1669930@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-6-shy828301@gmail.com>
 <20201203030632.GG1375014@carbon.DHCP.thefacebook.com>
 <CAHbLzkrU0X2LRRiG_rXdOf8tP7BR=46ccJR=3AM6CkWbscBWRw@mail.gmail.com>
 <CAHbLzkpAsoOWeRuFeTM2+YbjfqxY2U3vK7EYX2Nui=YVOBXFpw@mail.gmail.com>
 <20201203200715.GB1571588@carbon.DHCP.thefacebook.com>
 <CAHbLzkoUaLehmngW7geCDj+Fzd5+tkk3tBsbcdHuSXUXKLBuyw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoUaLehmngW7geCDj+Fzd5+tkk3tBsbcdHuSXUXKLBuyw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:fcbd]
X-ClientProxiedBy: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fcbd) by MWHPR13CA0030.namprd13.prod.outlook.com (2603:10b6:300:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Thu, 3 Dec 2020 23:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83524ae6-57c0-4eeb-4ed6-08d897e37de8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2277:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2277818AA4E3B8C478F645CBBEF20@BYAPR15MB2277.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ui9C5xWdoywOF8+GNwl4kMcV3f/hgjKRoZvxnO9dOZ+dz6L8iA3wRnv5Znn1CMUfadF8w3R5aKhKvSYqU9FciVNqFdm6cnp8Pk2dZQ4FvMlyjhmhcrpLWxowft6DxieVg/1jnKDtGD1oTyxvdwb/hQZkK7NS7b2bqz2E2TqDoPMAOGxhbKE4PVo6mWDuX/phTEMVriu7uXtpeHRdNx6lpy0Yp3ZJKINoRFGGOE3Bka9q/+zp02PQU/3fO1zUloQADJtAII+AeOLZLvEXYQQ6z8SfMOYDDDBHaMCMWyIumw2OH9PPO7svJgEJKU+wTBmxGHfHBElPw9vu8Dcz9SAz6rvWhSkI6gwPSsJ3Ji4vw2Ps2kr5EIqyfW+8K65GdBELbRYvIrIjIgIcQkrSDK6sdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(4326008)(54906003)(7416002)(6666004)(33656002)(9686003)(2906002)(8936002)(966005)(6916009)(8676002)(7696005)(66946007)(52116002)(66556008)(66476007)(316002)(6506007)(53546011)(86362001)(186003)(1076003)(83380400001)(55016002)(478600001)(16526019)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ayxP1BrtqZfyzSRt6OIJSnkxmFtQ4OWnQAkkD9Q55sVQt7KMhibb3vpxyk+hgXNDXe/S0Jq++coNNAh87kzr07dxHLTJL6Cyq6zrCg6ysfzNm2IkashxleDFQaqJsGUGIApiozkIGmpBBvNskQhcw5rXgW1PkG0ESLfXs0mltb/2NS/cpRqIDNkZsl2aWGeill2u3tLBxfX/8+qE55ZyNpikLHoC5nyLrfQX65sa4vCTWEOUKgkV42YRWAhQXzhFgtkeDmx1GekJFoY/82oxfFyJb7A9DepqCm3s9w6CyMT3Smqa9NBVMoOtZyfH2pEwKDzoFylAApnvA0G1Eafc9zvd1AWH0u2gWkAnIczG4pykpNSXgIBmcUhHyNTElCfVPnNTw+sRe/fb+yMPUBkP87giZ+oYHURKJczsfH8ACHBxD8/vZbmxeyUK3ro5isscm63tfwr1eeERpp0yebKz86PytW5AFvZBjCEyrO37ZKd6ERuk1OAJIDgSiTwlYr0TYUKSTRgq0cKsiMtaG+5uD9shZBvGvuVEGDxfS3+cgsxCDlJmepP7e1ndfoWCwd/ivjtuENBwxtXnMa4qes8vXEpMtrazRFuWLpkXcT+9iw1c9k2gx0qS3KWzoP6Ns4lF0OFmiNvI2NJzn7JpSdTiAolwVxb1fzYXmERBHzD1sXoRnvoTvLXK5/+EmAZkFKfHyUchhxX8xJpXoElQnjwUwkPuC5EQTy7ITm5IxY6wAhrmS/NGtEPpyRnY5UbAPktxV59gj7+eDxiTQ+IDmPuIcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83524ae6-57c0-4eeb-4ed6-08d897e37de8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 23:31:00.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5eGKmgqb9GpGvXOLcm9niyVglsbMAaAMeDpRrDPsx9VRijJQSne0P320lVcZ9VQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2277
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_15:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:49:00PM -0800, Yang Shi wrote:
> On Thu, Dec 3, 2020 at 12:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Dec 03, 2020 at 10:03:44AM -0800, Yang Shi wrote:
> > > On Wed, Dec 2, 2020 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 2, 2020 at 7:06 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > > > > > Currently the number of deferred objects are per shrinker, but some slabs, for example,
> > > > > > vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> > > > > >
> > > > > > The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> > > > > > excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> > > > > > may suffer from over shrink, excessive reclaim latency, etc.
> > > > > >
> > > > > > For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> > > > > > heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> > > > > > might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> > > > > >
> > > > > > We observed this hit in our production environment which was running vfs heavy workload
> > > > > > shown as the below tracing log:
> > > > > >
> > > > > > <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > > > nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> > > > > > cache items 246404277 delta 31345 total_scan 123202138
> > > > > > <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > > > nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> > > > > > last shrinker return val 123186855
> > > > > >
> > > > > > The vfs cache and page cache ration was 10:1 on this machine, and half of caches were dropped.
> > > > > > This also resulted in significant amount of page caches were dropped due to inodes eviction.
> > > > > >
> > > > > > Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> > > > > > better isolation.
> > > > > >
> > > > > > When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> > > > > > would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> > > > > >
> > > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > > ---
> > > > > >  include/linux/memcontrol.h |   9 +++
> > > > > >  mm/memcontrol.c            | 112 ++++++++++++++++++++++++++++++++++++-
> > > > > >  mm/vmscan.c                |   4 ++
> > > > > >  3 files changed, 123 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > > > index 922a7f600465..1b343b268359 100644
> > > > > > --- a/include/linux/memcontrol.h
> > > > > > +++ b/include/linux/memcontrol.h
> > > > > > @@ -92,6 +92,13 @@ struct lruvec_stat {
> > > > > >       long count[NR_VM_NODE_STAT_ITEMS];
> > > > > >  };
> > > > > >
> > > > > > +
> > > > > > +/* Shrinker::id indexed nr_deferred of memcg-aware shrinkers. */
> > > > > > +struct memcg_shrinker_deferred {
> > > > > > +     struct rcu_head rcu;
> > > > > > +     atomic_long_t nr_deferred[];
> > > > > > +};
> > > > >
> > > > > The idea makes total sense to me. But I wonder if we can add nr_deferred to
> > > > > struct list_lru_one, instead of adding another per-memcg per-shrinker entity?
> > > > > I guess it can simplify the code quite a lot. What do you think?
> > > >
> > > > Aha, actually this exactly was what I did at the first place. But Dave
> > > > NAK'ed this approach. You can find the discussion at:
> > > > https://lore.kernel.org/linux-mm/20200930073152.GH12096@dread.disaster.area/.
> >
> > Yes, this makes sense for me. Thank you for the link!
> >
> > >
> > > I did prototypes for both approaches (move nr_deferred to list_lru or
> > > to memcg). I preferred the list_lru approach at the first place. But
> > > Dave's opinion does make perfect sense to me. So I dropped that
> > > list_lru one. That email elaborated why moving nr_deferred to list_lru
> > > is not appropriate.
> >
> > Hm, shouldn't we move list_lru to memcg then? It's not directly related
> > to your patchset, but maybe it's something we should consider in the future.
> 
> I haven't thought about this yet. I agree we could look into it
> further later on.
> 
> >
> > What worries me is that with your patchset we'll have 3 separate
> > per-memcg (per-node) per-shrinker entity, each with slightly different
> > approach to allocate/extend/reparent/release. So it begs for some
> > unification. I don't think it's a showstopper for your work though, it
> > can be done later.
> 
> Off the top of my head, we may be able to have shrinker_info struct,
> it should look like:
> 
> struct shrinker_info {
>     atomic_long_t nr_deferred;
>     /* Just one bit is used now */
>     u8 map:1;
> }
> 
> struct memcg_shrinker_info {
>     struct rcu_head rcu;
>     /* Indexed by shrinker ID */
>     struct shrinker_info info[];
> }
> 
> Then in struct mem_cgroup_per_node, we could have:
> 
> struct mem_cgroup_per_node {
>     ....
>     struct memcg_shrinker_info __rcu *shrinker_info;
>     ....
> }
> 
> In this way shrinker_info should be allocated to all memcgs, including
> root. But shrinker could ignore root's map bit. We may waste a little
> bit memory, but we get unification.
> 
> Would that work?

Hm, not exactly, then you'll an ability to iterate with
	for_each_set_bit(i, map->map, shrinker_nr_max)...
But you can probably do something like:

struct shrinker_info {
   atomic_long_t nr_deferred;

   struct list_lru_one[]; /* optional, depends on the shrinker implementation */
};

struct memcg_shrinker_info {
    /* Indexed by shrinker ID */
    unsigned long *map[];
    struct shrinker_info *shrinker_info[];
}

Then you'll be able to allocate individual shrinker_info structures on-demand.

But, please, take this all with a grain of salt, I didn't check if it's all really
possible or there are some obstacles.

Thanks!
