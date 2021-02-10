Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9A315C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhBJBng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:43:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234214AbhBJBlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:41:18 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11A1bkc5006919;
        Tue, 9 Feb 2021 17:40:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=VUMeztw5J9CuPup2ykWx1nabUzD+gTWSydvbf3chdDM=;
 b=BPHM71jAUjD9JGWpXbC0uQCyL9RAEkXxr7k9BtPqZ+woEgg757wEQOkX39AV7gEy8oAb
 vmBhqCVOI9zltbMiJqvivhvSO2F1HrXg43QX2yEWzRiK5zSPyfyqYcve2FwYhLojL20r
 NB2UgCb0WQGct5d9Q5coaxxANbseyIoNA/4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36hqnthvtr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:40:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:40:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApJoHXpNUPWLl+ivm4h6JlL+JIvy24jeJ3k95Z1n6Oa36JBxTiX169NZF2il0s0d6Sw2wI5uCVkIwLPlZVh7vhlgru/lPnE1jyv7p8+oA6Q/NloZTG68Wpm0ICNtHOl/jH0B3cgvTPOhvTQweRk2zEYG+I9LlhD6oWrRIaicVredtiHU41ANeYFZ1iOU5W05vPynwLn3k0+HuoGcaUYmOOt6ielHXyzqOkjtJT3Hl4XCFuMQCEfCOBgRuALplrdCUufVq+AQGVTQlvsyKKjLOVY0XH1BBxPZPT/CB2iMh2pu3ysTSEOyBmyjA7Ubt2Wao1jbKRkkn/0Lrc/itUQmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUMeztw5J9CuPup2ykWx1nabUzD+gTWSydvbf3chdDM=;
 b=cppsOcnqgk5GvPPy+S7ltiOmJVyBEmw/msmU1zNVg/Ur3eryChR8uwXnby7dHjAYG8vac7Sb8ReiZzIBrj68shultUL7q6za9J2alO7Ss31tORa4X/JrgeJ/ky+tIEp53h4GXCsoWo97bnIdftOq3Aaq/aIJMSORz/RBUCTCcmg8YVPwpneiRhZqq9hdc671FaRYQfYh+OgVe/zO5jWRHMzKQv3ua64lqMr42uRom6Cw6KMbFsfuyasULW+cYtdlPO5EpNJbbRZwbCa8hDjtitn8f9/5dl9eJ/nwkludIJ/pjhE5fjnKkVRvtSX5ot3+SgRZ5fx+khid2p02O9Lw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUMeztw5J9CuPup2ykWx1nabUzD+gTWSydvbf3chdDM=;
 b=GQ/Dm3HN3luexQG8Kx7iIvwBr53xJSMDk59ZMPEqHof+ovjeJ7HeN2lm265ct/cP26VL2IBOOh1R1GIVSaas/hTiH9QeUPFnfVKclrbvKId9+0GxmO0IcCcTqaUuF9Ukxc20r8ZyB2Yyv2nQ5sNhZGvXX/YNg/h7gYLQLFWexHI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 01:40:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:40:23 +0000
Date:   Tue, 9 Feb 2021 17:40:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 08/12] mm: vmscan: add per memcg shrinker nr_deferred
Message-ID: <20210210014018.GR524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-9-shy828301@gmail.com>
 <20210210011020.GL524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkpHRO1-iamUvwrg41MyzAonCPcUiObo7LFKLTbCuZptvQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpHRO1-iamUvwrg41MyzAonCPcUiObo7LFKLTbCuZptvQ@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:affa]
X-ClientProxiedBy: MWHPR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:300:6c::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:affa) by MWHPR04CA0064.namprd04.prod.outlook.com (2603:10b6:300:6c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 01:40:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00149dac-ae81-499b-cfab-08d8cd64d59d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4758:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB47586F935D56F6A54412FCFFBE8D9@SJ0PR15MB4758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYlSaInDxXvTybOr7z2/kCpS0WvBd+CdP0wYLu1yd1rqrMIwm6oQGk6d/ZmVJUHX8QDzor0jnme5vwuNKSBawRd+pmP7W5wskwIhELHXgxqhbQRhZ9h0Kd0D62PJ4J03AwQC7186ugy1uVmOzglRAwQCm2DvSO41GfbHCklymJ0LTzD41wmcWPXDZes4P6DDq35xC1rtp4IbRBb3DxwWvU+fwvOnpPlPI4QcmiENFhxoAqvcxzt+a58CZ5F62hqkPKzHGTyKpjgGZ4UK1rtNtecxeWouB+Ic5TtzbDMWrd4v1VcKue6pfF2gEeBnv+4BZ9St4pETw/N4AObMosJ1FMD75QJ6hBQ68sQyPVrGMpP7eb8KTf15G804/3EO4kPyAcDENbTP7GSNsztJMwjcz22NpumeNRS8j/Vn45BJawwfk3LMbrnHSH5f7ARZMHvXCJjsV70XX+korgTwLCFoPSyBU2uAg0qRQuCuA2gcSbxaHuQ/C5oansyAF97LmsK344G0DEcVYUw2d20JAd1ZcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(66476007)(86362001)(6916009)(8936002)(4326008)(2906002)(6666004)(55016002)(33656002)(1076003)(5660300002)(83380400001)(52116002)(6506007)(54906003)(7696005)(8676002)(53546011)(186003)(16526019)(478600001)(66556008)(9686003)(316002)(7416002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GuvvZBhqgAe8w7F95f1oBkATVYg3rPr5SxS3y5iwLvE60beQzLy/gHmzB1gk?=
 =?us-ascii?Q?ixFqGCdLcpheUz6Ow5/9/caXBS3w0mV64UafiVoDmP5xpHt/oGP/rDL9Cddi?=
 =?us-ascii?Q?Xtsn4TYOZYaPNSyMsn1AOl6hCqRNABgA2EtPEPkubIV1rtOATTooEARZRADo?=
 =?us-ascii?Q?vVCg9VJ6P55N0ASbJ2r2yimzk9alBV6/Vl8zyPUJPrpyK1vlbElnq9ZlfBzO?=
 =?us-ascii?Q?pjfc6q0uMPGG1FYO9ndoHNGZthxD83FEcgKljmMvTxqg9EKGl3Q7BKap/FN5?=
 =?us-ascii?Q?kph4Chpt2dndnFEnFGwgROO6f+H2+aD1q8Fn17+h7ZEOwIQePgEVqmE0U2hF?=
 =?us-ascii?Q?VGJw7UWdSczD0M5rArgv48MbCtrXmOWIpEzenOJHckM8+aTRc87eWHOmrEi1?=
 =?us-ascii?Q?rm+V3R+Qb6MU/VnllzwSBzKTDgKrZWQ+qCRBOOVsxCJtf9jxrrTEFCLlzpBP?=
 =?us-ascii?Q?RHcgwsYN3M9v1m4nPdHn/RXiEozGeB6LGEZtaEH80H2tJDK6NjSzsRuyVBvj?=
 =?us-ascii?Q?Sx8kuZGMB/PKUfeXUoPx7HmoJMOMjjRY7A8YXnJDj0YZWVwadrG3DfgXpDI5?=
 =?us-ascii?Q?JzcCv6nxyOJlHP/pRPGh01dbBT3UyOOGuARq/w0g+KmluIIskdjmG95Ryb7V?=
 =?us-ascii?Q?v46dy0M9ao1VQcJ7MWDCz8q3Ms0UIxnwcZg+uYbrTWXbbxf5lJ8GsDYyH2hu?=
 =?us-ascii?Q?Gmo0O7AX+ZpuBKOKcn6sWFITzdZ9OYR3co5gOXdqigUaqTvhIMikbmGjCsxe?=
 =?us-ascii?Q?+QOBFnEVxUkk0R5BeGfkfyM+YkgaD58he/OSz2rOGqQXKbbujm0UJcqBWcXE?=
 =?us-ascii?Q?V8ZXAWMMl+LwF/f6XDTqcnzjtNtlxy40PNXmWokdfbYsBqZHz4Pj/zqKeLyy?=
 =?us-ascii?Q?9g87rT0eWbJBNlDbQ+5MPjHa35MC8xfROrlLCCZv+MB5G2Zhux8WM27lQqVW?=
 =?us-ascii?Q?mwFUdLwKpaXWANIAmufaMr7lc/+omNos0V5bZ3lB3vRJlI7VvLdauWMQ3BuQ?=
 =?us-ascii?Q?Kgpk8dCSLa1hsuKx9tHYGuN3IaZQC7BsjQgsiHY/30khEAxGynExgnGQUu8Q?=
 =?us-ascii?Q?3ZTmxWbSzgDzXfJtZZ1B0YsWUnim2cbPCjeJK+vtZpjTLrRpOmBUSxRSmCi1?=
 =?us-ascii?Q?7ekhXDbHUTTjJkP4RvpwPW3eB7pfGHp/mviMd/lcIvvQHNQXoQ+gYwwzik0R?=
 =?us-ascii?Q?/7uTMYocijfe42440rT7KnWj+kZRH3i7bwpwyV1IoSuN+wVrzT/Djcvik/Rh?=
 =?us-ascii?Q?kMdGjaqz7P890xXennwGUzUI8Sy0vA03UAEzrZiFbNJr21/rZMF54ILwz+5n?=
 =?us-ascii?Q?1qKI+zHNrB9WEHkg+5KZM9fJQHD8+e33KYRAC9qYFI/CYmiEFlinm/Xtq5Ts?=
 =?us-ascii?Q?im9Li5I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00149dac-ae81-499b-cfab-08d8cd64d59d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:40:23.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mprVa7cirgEEMI4JnhHMx616TTRYp3P1bUrwArFvW1njpevAuy0wxh0w7dyPUzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:25:16PM -0800, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 5:10 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Feb 09, 2021 at 09:46:42AM -0800, Yang Shi wrote:
> > > Currently the number of deferred objects are per shrinker, but some slabs, for example,
> > > vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> > >
> > > The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> > > excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> > > may suffer from over shrink, excessive reclaim latency, etc.
> > >
> > > For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> > > heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> > > might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> > >
> > > We observed this hit in our production environment which was running vfs heavy workload
> > > shown as the below tracing log:
> > >
> > > <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> > > cache items 246404277 delta 31345 total_scan 123202138
> > > <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> > > last shrinker return val 123186855
> > >
> > > The vfs cache and page cache ratio was 10:1 on this machine, and half of caches were dropped.
> > > This also resulted in significant amount of page caches were dropped due to inodes eviction.
> > >
> > > Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> > > better isolation.
> > >
> > > When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> > > would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h |  7 +++---
> > >  mm/vmscan.c                | 49 +++++++++++++++++++++++++-------------
> > >  2 files changed, 37 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 4c9253896e25..c457fc7bc631 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -93,12 +93,13 @@ struct lruvec_stat {
> > >  };
> > >
> > >  /*
> > > - * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> > > - * which have elements charged to this memcg.
> > > + * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
> > > + * shrinkers, which have elements charged to this memcg.
> > >   */
> > >  struct shrinker_info {
> > >       struct rcu_head rcu;
> > > -     unsigned long map[];
> > > +     atomic_long_t *nr_deferred;
> > > +     unsigned long *map;
> > >  };
> > >
> > >  /*
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index a047980536cf..d4b030a0b2a9 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -187,9 +187,13 @@ static DECLARE_RWSEM(shrinker_rwsem);
> > >  #ifdef CONFIG_MEMCG
> > >  static int shrinker_nr_max;
> > >
> > > +/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
> > >  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> > >       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> > >
> > > +#define NR_MAX_TO_SHR_DEF_SIZE(nr_max) \
> > > +     (round_up(nr_max, BITS_PER_LONG) * sizeof(atomic_long_t))
> > > +
> > >  static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> > >                                                    int nid)
> > >  {
> > > @@ -203,10 +207,12 @@ static void free_shrinker_info_rcu(struct rcu_head *head)
> > >  }
> > >
> > >  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > > -                                int size, int old_size)
> > > +                                 int m_size, int d_size,
> > > +                                 int old_m_size, int old_d_size)
> > >  {
> > >       struct shrinker_info *new, *old;
> > >       int nid;
> > > +     int size = m_size + d_size;
> > >
> > >       for_each_node(nid) {
> > >               old = shrinker_info_protected(memcg, nid);
> > > @@ -218,9 +224,15 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > >               if (!new)
> > >                       return -ENOMEM;
> > >
> > > -             /* Set all old bits, clear all new bits */
> > > -             memset(new->map, (int)0xff, old_size);
> > > -             memset((void *)new->map + old_size, 0, size - old_size);
> > > +             new->nr_deferred = (atomic_long_t *)(new + 1);
> > > +             new->map = (void *)new->nr_deferred + d_size;
> > > +
> > > +             /* map: set all old bits, clear all new bits */
> > > +             memset(new->map, (int)0xff, old_m_size);
> > > +             memset((void *)new->map + old_m_size, 0, m_size - old_m_size);
> > > +             /* nr_deferred: copy old values, clear all new values */
> > > +             memcpy(new->nr_deferred, old->nr_deferred, old_d_size);
> > > +             memset((void *)new->nr_deferred + old_d_size, 0, d_size - old_d_size);
> > >
> > >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> > >               call_rcu(&old->rcu, free_shrinker_info_rcu);
> > > @@ -235,9 +247,6 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> > >       struct shrinker_info *info;
> > >       int nid;
> > >
> > > -     if (mem_cgroup_is_root(memcg))
> > > -             return;
> > > -
> > >       for_each_node(nid) {
> > >               pn = mem_cgroup_nodeinfo(memcg, nid);
> > >               info = shrinker_info_protected(memcg, nid);
> > > @@ -250,12 +259,13 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> > >  {
> > >       struct shrinker_info *info;
> > >       int nid, size, ret = 0;
> > > -
> > > -     if (mem_cgroup_is_root(memcg))
> > > -             return 0;
> > > +     int m_size, d_size = 0;
> > >
> > >       down_write(&shrinker_rwsem);
> > > -     size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> > > +     m_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> > > +     d_size = NR_MAX_TO_SHR_DEF_SIZE(shrinker_nr_max);
> > > +     size = m_size + d_size;
> > > +
> > >       for_each_node(nid) {
> > >               info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
> > >               if (!info) {
> > > @@ -263,6 +273,8 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> > >                       ret = -ENOMEM;
> > >                       break;
> > >               }
> > > +             info->nr_deferred = (atomic_long_t *)(info + 1);
> > > +             info->map = (void *)info->nr_deferred + d_size;
> > >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> > >       }
> > >       up_write(&shrinker_rwsem);
> > > @@ -274,10 +286,16 @@ static int expand_shrinker_info(int new_id)
> > >  {
> > >       int size, old_size, ret = 0;
> > >       int new_nr_max = new_id + 1;
> > > +     int m_size, d_size = 0;
> > > +     int old_m_size, old_d_size = 0;
> > >       struct mem_cgroup *memcg;
> > >
> > > -     size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
> > > -     old_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> > > +     m_size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
> > > +     d_size = NR_MAX_TO_SHR_DEF_SIZE(new_nr_max);
> > > +     size = m_size + d_size;
> > > +     old_m_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
> > > +     old_d_size = NR_MAX_TO_SHR_DEF_SIZE(shrinker_nr_max);
> > > +     old_size = old_m_size + old_d_size;
> > >       if (size <= old_size)
> > >               goto out;
> >
> > It looks correct, but a bit bulky. Can we check that the new maximum
> > number of elements is larger than then the old one here?
> 
> Seems not to me. For example, we have shrinker_nr_max as 1, then a new
> shrinker is registered and the new_nr_max is 2, but actually the new
> size is equal to the old size.

I see.

> 
> We should be able to do:
> if (round_up(new_nr_max, BITS_PER_LONG) <= round_up(shrinker_nr_mx,
> BITS_PER_LONG))
> 
> Does it seem better?

Yes, I think so.

> 
> >
> > >
> > > @@ -286,9 +304,8 @@ static int expand_shrinker_info(int new_id)
> > >
> > >       memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > >       do {
> > > -             if (mem_cgroup_is_root(memcg))
> > > -                     continue;
> > > -             ret = expand_one_shrinker_info(memcg, size, old_size);
> > > +             ret = expand_one_shrinker_info(memcg, m_size, d_size,
> > > +                                            old_m_size, old_d_size);
> >
> > Pass the old and the new numbers to expand_one_shrinker_info() and
> > have all size manipulation there?
> 
> With the above proposal we could move the size manipulation right
> before the memcg iter, we could save some cycles if we don't have to
> expand it.

I mostly dislike passing 4 arguments to expand_one_shrinker_info():
old_m_size, old_d_size, etc. But you're right, there is no good reason
to calculate them for each cgroup, if we can do it once. Can you, please,
rename arguments to map_size and defer_size (or something more obvious than
m and d on your taste)?

Thanks!
