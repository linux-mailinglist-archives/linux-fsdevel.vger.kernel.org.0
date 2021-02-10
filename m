Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BA315B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhBJAdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:33:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhBJASB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:18:01 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A0DFBU017992;
        Tue, 9 Feb 2021 16:17:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ac/X6sx6YpO2flbD5bHigjnmtiFMvzKNzutGYuUdnrc=;
 b=qKDdbZmST9lI8AL1QmigoCFdhL4pPGAHMcZmX+ebF7RacVEFeAafgrwURPDZhtRt2QQ6
 TPkZwRT3pvSHKEoLROXXOqZdCwwgZ+f8jkbK+npNWOOoS+3pafrSr8GN0V1kLYxpidF9
 VXP4VeoJwl3QRldUw6OAiZzn9346dwi2HUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstph621-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 16:17:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 16:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6QlmrK9P6wvaYdEr+QoiGV60N4fEYrGZIfWcrb+KBExzNit8TAACBaLYzmflB0ky7F+B8DZfUrAtxIr1vPayjo7JvVjDVi0bQCanOxO+5qGomC5rjnvxK+LJ7/A1IR36cipvjjVMnn/djIutYOX2gAXZJPneiAmSZn4dpZNQOQiYdbSBJQfQamgJBW0bS/kSIPZR8DBZhgqtnnOrdz3iESp74f1x+6vg4V9Q/kIQaXWGhaGEDcgDp8Gdow/f2/Mxpc0vvJLHmS4/pf7kQCGGEg/JXBtYEm6z98HXgaosgJ1JsOfaE45k9wf0PA42tYt25+YaIen9syM3ZVqok4S0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac/X6sx6YpO2flbD5bHigjnmtiFMvzKNzutGYuUdnrc=;
 b=W7VxcrxuTqOSQPmy1pUtL68CmXM+J4ZTVX8xflKv21xE6t0ELY4R0W+Pb0+e8bjybwb3lVXReLuZ2ooO1oTuR4Xxz8BxPp32S4oQZTGrLCxKqPzFWTuostik7ihW/DPaDDFZaezXc/b+N6eLOlmQsY91TVH+/LbwbSQSLUh03x98pPUhpaGc6ydnvjbKqOSMYhnSALaYFRCtavO2IDzuFTFBOlyfmwyt5OibdXHSU0lMW+/wdA3K6uF8JGIbghZcgqYdiAmfDTo4DlJxMrlmd9dDCnAuGLydr1m0KQWDC22iwkQcP6it79iVOpNWnivwzE+dGJgkR+Ewrioqtnn7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac/X6sx6YpO2flbD5bHigjnmtiFMvzKNzutGYuUdnrc=;
 b=EpFcjFIUyCfA3HoQwuFDoE0BMh/ERGaEQywGqAt3zYi8oug0c04B0Dg4OSw+mkwYIoiQD+hwYB8xk+mjOaCryzEaLRhLxiGy+N4QYldCvpe83plhX+CQwMLkt+BIivkMsqyQoq3YXbi/9eND09qj8FFvvteSu9AlHNx5J+QsgVQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 00:16:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 00:16:52 +0000
Date:   Tue, 9 Feb 2021 16:16:26 -0800
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
Subject: Re: [v7 PATCH 05/12] mm: memcontrol: rename shrinker_map to
 shrinker_info
Message-ID: <20210210001626.GI524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-6-shy828301@gmail.com>
 <20210209205014.GH524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkr+5t5wTVRDih53ty-TcsMrmKxZ5iiPw1dwnDsz_URz=Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr+5t5wTVRDih53ty-TcsMrmKxZ5iiPw1dwnDsz_URz=Q@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:262e]
X-ClientProxiedBy: MWHPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:300:117::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:262e) by MWHPR03CA0007.namprd03.prod.outlook.com (2603:10b6:300:117::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 00:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc64995-b478-4619-c96b-08d8cd592a62
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3285444FC6E26F04E6738DE1BE8D9@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPJrESatMrj0JsybiwNLltMAKGjlYWA/cV8sOIOlENQelSYv1KwwaWoQWw3gTUIVuMvc8RrBFMLeNlWVWIMV/Om56Vi8jvZhxC0O+GZ7HcGUqZzXJZoNJJku3Bhj01t3HR1QOOr4nM6RPf8Vb2fqPm2hWs0zRziYtXvY4q0Msc5LGW056pIFCwNjHKBhNj9kxPD2UAk7AtnOU86OZHkkYclyLEq6e7Kvzl/DJvEvu6xwkRvP3jH48qWg9v+NfWIcaM9qpgGGuf8XuEs0uoUWTbicQ9vvGGBaLNxkIoInlvu39Cp96vtH9zwnkuWpA6O7ObWqXmPKQqXrwibnQknno8xGkN5m6dgwpLJaY2PYlBeFxWyarSfKzpqnn0Zrs+Fl5bJe2M4ySkBEC2/GihL+uud6Rfb4KXbp5D2XeFt8nMy1e+Hbx0tObeURBVGoePhb4McciOMVx8tpyMdvEofqs6KANFG9pi6b58cAHGsQudsxS2rz0P6XRDpmSgwMvtYNv5YLH/mGdsIMhsytbs95kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(16526019)(53546011)(4326008)(8676002)(52116002)(7696005)(33656002)(9686003)(8936002)(83380400001)(86362001)(6916009)(66946007)(55016002)(66476007)(66556008)(5660300002)(6666004)(7416002)(54906003)(2906002)(478600001)(6506007)(186003)(316002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eQrpDUr+fFFbNiloCHinsDdAFfaqenDcLDmqBwyjNRpPpisVCcrFnO7j3XzN?=
 =?us-ascii?Q?GDzjuKPe4g+Z0tI6if+zRfzJc+DlX0eajJxbvEoCFEK1ZW7M5l6K9fWVtrUc?=
 =?us-ascii?Q?lPqiQPFeoulXQg+yrQE3jxnnjiIw4TKqsRKFNoQzfdAvHe8XY+zeNZpubQh7?=
 =?us-ascii?Q?fKoIcm92aHzEyiTNlWt71Lmf1eymSvJiOMAq3HkGrrIHmmsB+J3LzLn9YQ7t?=
 =?us-ascii?Q?RdETChozeIi+I6zvkwaY/ZP1ezIIm98txZ954H6FVRTQc2bNeDY/Iqwi0hnO?=
 =?us-ascii?Q?nDvwQB9ul+s7Le8cFNGR5Co9ySz7D3X8vOnzJXDT4Quwip68gn0g6DBY2RYM?=
 =?us-ascii?Q?cFkdIANLvdW0Tl4fX0ESyFtmftLUSEDnLkH39yOrOrXq0KD5kIZqgwy2msgi?=
 =?us-ascii?Q?J1Fr5Ua9H4w9N1keDGgO5xkSqkRdZRW8psKCCB/TkKA4na3UnD6k4vW1NNjG?=
 =?us-ascii?Q?SBDVsThP6JwPr0EOfe6YxktIfNoEiuai4c43PGAMTwAOiQgwqmoGUlPxdkJ2?=
 =?us-ascii?Q?OC/iBCzdq6bUB/uFDh6fVcbXLurCDCp1hwz3YuqoTNER7i0z8zVol+HMZFUt?=
 =?us-ascii?Q?bojIH1Ect0g6AxMuYGulE9K/Gg4ulpk2iHh9bHZL7ErwY1v4CROCEem+zU6V?=
 =?us-ascii?Q?J2FrQ+fXpy01m2V22DxwsWJROdSD7cUofN16YtU1vHUIzHjBINofMKQhhzKF?=
 =?us-ascii?Q?SsmC+mDsu44D03ObCOyI1rvN5xRJXa53yVMloSEayLXuRxDY/S7pJeiJxrEy?=
 =?us-ascii?Q?sQpqH3WzBFuR9Fg9G5wkgQ+juHAlW6/20V1G1AC4gjRpBUglTULtMivPRIiF?=
 =?us-ascii?Q?tIphF0wcxmvde+skgNPCda73wVpV8R5J/SA6XveZftn0VDgVk7VaXZFQvC8h?=
 =?us-ascii?Q?GbU1Qd9VpGw+s6+GXBxyaljK/iiZZjDDBvRczoRR+NRFd9qXNehDr/2ZEm/6?=
 =?us-ascii?Q?rPZVd0JTdtbBxoVoP9arN3nEVHP4QSSchqB9jR631cCVFkImDiQOdhoSz7Dx?=
 =?us-ascii?Q?JuyV+JmWbk3zplvH0M2hEN2ArObNEPcZyO7pDutgamkZjsqfMaioRN1AC8lw?=
 =?us-ascii?Q?voPUv3vUyh0TqJfF1Pj2iUcM50DkEFKLiOaxjbOV8ondnUukXqShRU9D+Hyz?=
 =?us-ascii?Q?jqGFbAVKp9yfEAyAq5ElBsRHP01tbxebyznpoUkhT2oZaR8BElZTl4OyuAbW?=
 =?us-ascii?Q?NWFyGeaUjZQU7GnzwmYE/bUs03taw2gdv/ZfrC6p3MZesIAtLtsiDvOMTCDE?=
 =?us-ascii?Q?06fYwDaY8PFTCsvSgvMnJzfV2907Lv2bWWB/bPxeiSXhsH09jV0Vry1c9fBX?=
 =?us-ascii?Q?UlwHi+EXj8tnOCd0SHhhh1NNACfISVZKGE0ikHqQfB5HauupttV6RBR1kv6z?=
 =?us-ascii?Q?LHsFUz8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc64995-b478-4619-c96b-08d8cd592a62
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 00:16:52.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjZfUS71Z+sK4hmuJybGzhwn+JqC1Jm5N+JO4faIcz9VMzKSiSp+Xgi+ONVpOE2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 03:33:56PM -0800, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 12:50 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Feb 09, 2021 at 09:46:39AM -0800, Yang Shi wrote:
> > > The following patch is going to add nr_deferred into shrinker_map, the change will
> > > make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
> > > And this should make the patch adding nr_deferred cleaner and readable and make
> > > review easier.  Also remove the "memcg_" prefix.
> > >
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h |  8 ++---
> > >  mm/memcontrol.c            |  6 ++--
> > >  mm/vmscan.c                | 62 +++++++++++++++++++-------------------
> > >  3 files changed, 38 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 1739f17e0939..4c9253896e25 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -96,7 +96,7 @@ struct lruvec_stat {
> > >   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> > >   * which have elements charged to this memcg.
> > >   */
> > > -struct memcg_shrinker_map {
> > > +struct shrinker_info {
> > >       struct rcu_head rcu;
> > >       unsigned long map[];
> > >  };
> > > @@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
> > >
> > >       struct mem_cgroup_reclaim_iter  iter;
> > >
> > > -     struct memcg_shrinker_map __rcu *shrinker_map;
> > > +     struct shrinker_info __rcu      *shrinker_info;
> >
> > Nice!
> >
> > I really like how it looks now in comparison to the v1. Thank you for
> > working on it!
> 
> Thanks a lot for all the great comments from all of you.
> 
> >
> > >
> > >       struct rb_node          tree_node;      /* RB tree node */
> > >       unsigned long           usage_in_excess;/* Set to the value by which */
> > > @@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> > >       return false;
> > >  }
> > >
> > > -int alloc_shrinker_maps(struct mem_cgroup *memcg);
> > > -void free_shrinker_maps(struct mem_cgroup *memcg);
> > > +int alloc_shrinker_info(struct mem_cgroup *memcg);
> > > +void free_shrinker_info(struct mem_cgroup *memcg);
> > >  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
> > >  #else
> > >  #define mem_cgroup_sockets_enabled 0
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index f5c9a0d2160b..f64ad0d044d9 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5246,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
> > >       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> > >
> > >       /*
> > > -      * A memcg must be visible for expand_shrinker_maps()
> > > +      * A memcg must be visible for expand_shrinker_info()
> > >        * by the time the maps are allocated. So, we allocate maps
> > >        * here, when for_each_mem_cgroup() can't skip it.
> > >        */
> > > -     if (alloc_shrinker_maps(memcg)) {
> > > +     if (alloc_shrinker_info(memcg)) {
> > >               mem_cgroup_id_remove(memcg);
> > >               return -ENOMEM;
> > >       }
> > > @@ -5314,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
> > >       vmpressure_cleanup(&memcg->vmpressure);
> > >       cancel_work_sync(&memcg->high_work);
> > >       mem_cgroup_remove_from_trees(memcg);
> > > -     free_shrinker_maps(memcg);
> > > +     free_shrinker_info(memcg);
> > >       memcg_free_kmem(memcg);
> > >       mem_cgroup_free(memcg);
> > >  }
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 641077b09e5d..9436f9246d32 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -190,20 +190,20 @@ static int shrinker_nr_max;
> > >  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> > >       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> > >
> > > -static void free_shrinker_map_rcu(struct rcu_head *head)
> > > +static void free_shrinker_info_rcu(struct rcu_head *head)
> > >  {
> > > -     kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > > +     kvfree(container_of(head, struct shrinker_info, rcu));
> > >  }
> > >
> > > -static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > > +static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > >                                  int size, int old_size)
> > >  {
> > > -     struct memcg_shrinker_map *new, *old;
> > > +     struct shrinker_info *new, *old;
> > >       int nid;
> > >
> > >       for_each_node(nid) {
> > >               old = rcu_dereference_protected(
> > > -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > > +                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> > >               /* Not yet online memcg */
> > >               if (!old)
> > >                       return 0;
> > > @@ -216,17 +216,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > >               memset(new->map, (int)0xff, old_size);
> > >               memset((void *)new->map + old_size, 0, size - old_size);
> > >
> > > -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > > -             call_rcu(&old->rcu, free_shrinker_map_rcu);
> > > +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> > > +             call_rcu(&old->rcu, free_shrinker_info_rcu);
> >
> > Why not use kvfree_rcu() and get rid of free_shrinker_info_rcu() callback?
> 
> Just because this patch is aimed to rename the structure. I think it
> may be more preferred to have the cleanup in a separate patch?

Completely up to you, I'm fine with either option.

Thanks!
