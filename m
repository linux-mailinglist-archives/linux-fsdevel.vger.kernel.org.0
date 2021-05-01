Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD2370516
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 05:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEADME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 23:12:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40324 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhEADMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 23:12:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14138CAd025085;
        Fri, 30 Apr 2021 20:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/Im0rkO2QQk1KkqyUhklEi4lRjiaR2ckdgT9q1dPDNU=;
 b=LzA0QLiSL0KP3lSFkgybVJ+Hg8JNyrMZa/oN9wEU7V3hXr/CqMeuH5oYOhUKI32D3qcg
 s4aJ0rxioPz4Ur9PGB442qNjNh9UPuCQeVENcAo+ifIGvbsTodDDytJkIfn6l8emKLFd
 +375VMMExnrMqRlQryXjGtrKZI2nXEn5774= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3883fr04bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 20:10:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 20:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt3J8ynZ6RnuprU6q34bUX1buJ2H7w5D3LGCjSQByXLs32zzPZbPvie8UcdWNqWC8O75D6VnG+iLsTF+iUbdAeoYJagX8SenNx35kYgUNn4Uq6X1dESI2CkKXiK22jQiylRD6YDuKqizYZyai0LwZm+80QBFJsuEZ6Cq0TG2W9i3QDXao5S6Lbvr0uZaPXzItaekrIHYUohiT3O/rkTsbpsghvA3HJe1I2+G63GyteYYTsAbLut9k1wKej3El/deU80tc2ogw5pdmNaWOKqptghOH5lKdtGlQH8izmzIRPpV15qGE4CH/O/dJXo+nomnRVEnjdBeIAJ2zbR67/Ux8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Im0rkO2QQk1KkqyUhklEi4lRjiaR2ckdgT9q1dPDNU=;
 b=bExYJmRUhQ6ZI7zrDPK+hu/JqQuOG5/nHtuC/Se8VIqR+IECKiw/hxKZMRvye9fwjYuV8YajJpRSnRCuib2ocMDci6fshafTIOehh2P4bISTQp84k3dqSe1c3ZML6Tta7QjWbVjWIHgDKwT5ouH7TjfLIODKMkFkjDUpkTEqtuIegAmEWFPgqGsZCf1zJTOZ222mIAspGFYXdwhTo2A7W7BLNjf6Phw3nW1PlO6mHyo6VKjy8aZKJJtk2umECnWKyuSBAnl0TdfAbNDecpZ3lgF9Aqs2dSdNSTnW8y2zVLDhXqv3zDoglRaDOx/1nxt0r2f6HiSJbsMCUPORTBW6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4932.namprd15.prod.outlook.com (2603:10b6:a03:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Sat, 1 May
 2021 03:10:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 03:10:51 +0000
Date:   Fri, 30 Apr 2021 20:10:46 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, <alexs@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
Message-ID: <YIzGtpAwO+2YOPA6@carbon.dhcp.thefacebook.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
 <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area>
 <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ffce]
X-ClientProxiedBy: MWHPR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:300:115::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ffce) by MWHPR11CA0027.namprd11.prod.outlook.com (2603:10b6:300:115::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Sat, 1 May 2021 03:10:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9f9c1c-25f1-4459-7c5d-08d90c4eb9ce
X-MS-TrafficTypeDiagnostic: BY3PR15MB4932:
X-Microsoft-Antispam-PRVS: <BY3PR15MB49324D4082571AAAD2A1F3A7BE5D9@BY3PR15MB4932.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z28L7RiOE3jec/p/rIdrMmgWO/Xm4odpqNcMBb0HbDbrMS40XNvbzYlJVTHPck9iR4jgPaYc9t4Y/3o44WE8mgPrW6XHZ8yIEWbQQs/wtR4YDC3fKZi45LjR4SsyD2h8ooKQR73TZ3VamMIl5YLzdUTt1E+uLR22Nk3RgOq4hFfYnkoQdjArv/pGolJYh/FEDR4PM9l9xgAiKBFF0vHdACA/va7rDCCRY6NPArlJcJYbfLNzM/K+CM9PuULPECyy/7yPnELm6l/cPRytN7JAxel6V7Lp8CagwxQi/Wci0pHj2V3FHcwvzBZi33TzkK7Uy5uoawvQ9yqonTcD9bJ8pQiUg7Wi1kQlI2MBuj33b0x325+PzDT000biiuTUmAkNmygu9YzWGCjD99IzY1q3qJYRHFkC5q94GclzgR6fjlG2u3Lt64RpfGjrJyfuOIhcSFPwr89lrVS7kSGMbojZz6mPxlwpLX6E/yHv5y8kwFuj6YiVgojlFO3QiWYPVoiIgT/BzLWuW38Y7BKlgwalsLkXudRFI1tvVJUOogyMI9WvhpXGGJ84qwoNOBcUu2VialZn3jgMFxPQsX9RFXevuitvQV3k1FMpTz99zG+uytXPhyr6tNrCW0Rlq1cs3j5q3YTR6xSuBuRbdqMcXa6oWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6916009)(7416002)(478600001)(66476007)(66556008)(7696005)(6506007)(52116002)(6666004)(83380400001)(66946007)(53546011)(2906002)(8676002)(5660300002)(8936002)(54906003)(316002)(86362001)(9686003)(186003)(16526019)(55016002)(4326008)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CQO2xzxVFpsXjSXBHh8xWhbeIUKXSbqeEeoFDxuC45p0InEsOFYrOfVuHY0L?=
 =?us-ascii?Q?B7ImZxs57lZj/igCT1Og2H3j+os0cPYrJE1INBanfoUU3fWN14YVTaCMgxoL?=
 =?us-ascii?Q?WL/bWlXv5b0d0X6Iy+bCH5vQQvBY25wPdA3BE3r+zuX50eoTpaVKCBp92AEP?=
 =?us-ascii?Q?7wYrNcbgYOFaAIbDWYMVCGt/uiXa4Hz8fH4ZO3/lxTzMh+N8fsTt31ESdhHu?=
 =?us-ascii?Q?ULNSAPqlrnkxiIli/jzoL3qrTd81iNJ423aoTifJTAbrnzkuoJHKAvBwxMXI?=
 =?us-ascii?Q?eu2HwpPp1iuZNSsIT71jhd6sOyTjLwFdoiuL5rRFyxaqz7Hmz9Un9btTpG9O?=
 =?us-ascii?Q?YkM0upoNHeNnig56hB8KEr+3NjmObFWUxNz0hS4nZjlGUIyGdFfo+dtRmMup?=
 =?us-ascii?Q?4osCge4JtYmNcw3Xxcyaf+DXQYY7+et5Waavfq79vtzzzYIb4Rdnq9QqmITf?=
 =?us-ascii?Q?SBcnzBYtmhQ/K+1WnjVFSTZzt1ja+lqTqA2Crsc6NZ7VuX966OGFla/Q0HJW?=
 =?us-ascii?Q?TiryuVettKnqO4ekTVPQYxJgE6xq+aLGvj9jU0D9212eI+tcwdq++Pr9S0v0?=
 =?us-ascii?Q?oXQcovUMDJMmvN+wywDig9OwVJYAkvEEi8IrYk12kgZeB7BXEInnn6N/8lmP?=
 =?us-ascii?Q?C/bPS8uzc88khk6sY7CsEepueqkdspddCoLTXsD1zgeYZjyeA/gfU0XEw2FT?=
 =?us-ascii?Q?WX1F0VrQG9eKe89eGQFva3FYw96yujbMRr0l43Fox4vlJJ8a1gufwD3++vIL?=
 =?us-ascii?Q?yW1fD+bJJiAhE+sBjHDMbA8Sff1YggLwRikiGzftrZpfLNJdESFxEemOo4j0?=
 =?us-ascii?Q?LEMIw8pn7QxArzUR9HnxRkMIkYLhq6pBP+j20Zw9DEoJ3MED7YWjuFvaQXvS?=
 =?us-ascii?Q?3LYi0hXzo6ABQdjagEs2cYp6VFOaHB7jUT0ZS8A++Uar018FlaAgPWl5pbpq?=
 =?us-ascii?Q?p09Iscq0LkRVo2DRriIkYs3pchrmmtFDHie+zXx+qrbA+a2UqrVi31VjAo2N?=
 =?us-ascii?Q?1SVEO3q+W/HMnDzGr9PG58wglp9uEhh1ZUeFjzBlt7GswAqJKKQMAmLTLbe1?=
 =?us-ascii?Q?W0Kmj9NpMAvAYr9Uzw+GWAt7aM7qxwLP6XKgv9sO86w06eZMVUFkv1ee++dQ?=
 =?us-ascii?Q?o6K4QQtwS9a8y8SfNU0YLdfn1QtHnXEbveAGxRRAkbgLewwPixkviaNzOGdC?=
 =?us-ascii?Q?CsJEd0PP4I19wc55iIeKJejMJ6GHQbhukJoIdfgq5B4KxE+lif1H5GuDzN2Q?=
 =?us-ascii?Q?Iiu4OOXHDr+iUf1lzOTw/eEHr/vCcDBljaLm0Syf+fuwZahQ1dvjIGMYlhFQ?=
 =?us-ascii?Q?xS7QV8X3dy5raTIYt4HTpY11T9GohfIwZqOSlQat+OvyLw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f9c1c-25f1-4459-7c5d-08d90c4eb9ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 03:10:51.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLvsThBIkzRJCOsw0UB2rEzvIDjLPMstVj/kDNExkLHvaEtg74HAV9fo6h1KrxzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4932
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1Gkfvc8uk3n4KMAYLLDjXTeJ0kbexSg0
X-Proofpoint-GUID: 1Gkfvc8uk3n4KMAYLLDjXTeJ0kbexSg0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_02:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:32:39PM +0800, Muchun Song wrote:
> On Fri, Apr 30, 2021 at 11:27 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 06:39:40PM -0700, Roman Gushchin wrote:
> > > On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> > > > On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > > > > In our server, we found a suspected memory leak problem. The kmalloc-32
> > > > > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > > > > memory.
> > > > >
> > > > > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > > > > cache is the cause of list_lru_one allocation.
> > > > >
> > > > >   crash> p memcg_nr_cache_ids
> > > > >   memcg_nr_cache_ids = $2 = 24574
> > > > >
> > > > > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > > > > can be calculated with the following formula.
> > > > >
> > > > >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > > > >
> > > > > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > > > >
> > > > >   crash> list super_blocks | wc -l
> > > > >   952
> > > >
> > > > The more I see people trying to work around this, the more I think
> > > > that the way memcgs have been grafted into the list_lru is back to
> > > > front.
> > > >
> > > > We currently allocate scope for every memcg to be able to tracked on
> > > > every not on every superblock instantiated in the system, regardless
> > > > of whether that superblock is even accessible to that memcg.
> > > >
> > > > These huge memcg counts come from container hosts where memcgs are
> > > > confined to just a small subset of the total number of superblocks
> > > > that instantiated at any given point in time.
> > > >
> > > > IOWs, for these systems with huge container counts, list_lru does
> > > > not need the capability of tracking every memcg on every superblock.
> > > >
> > > > What it comes down to is that the list_lru is only needed for a
> > > > given memcg if that memcg is instatiating and freeing objects on a
> > > > given list_lru.
> > > >
> > > > Which makes me think we should be moving more towards "add the memcg
> > > > to the list_lru at the first insert" model rather than "instantiate
> > > > all at memcg init time just in case". The model we originally came
> > > > up with for supprting memcgs is really starting to show it's limits,
> > > > and we should address those limitations rahter than hack more
> > > > complexity into the system that does nothing to remove the
> > > > limitations that are causing the problems in the first place.
> > >
> > > I totally agree.
> > >
> > > It looks like the initial implementation of the whole kernel memory accounting
> > > and memcg-aware shrinkers was based on the idea that the number of memory
> > > cgroups is relatively small and stable.
> >
> > Yes, that was one of the original assumptions - tens to maybe low
> > hundreds of memcgs at most. The other was that memcgs weren't NUMA
> > aware, and so would only need a single LRU list per memcg. Hence the
> > total overhead even with "lots" of memcgsi and superblocks the
> > overhead wasn't that great.
> >
> > Then came "memcgs need to be NUMA aware" because of the size of the
> > machines they were being use for resrouce management in, and that
> > greatly increased the per-memcg, per LRU overhead. Now we're talking
> > about needing to support a couple of orders of magnitude more memcgs
> > and superblocks than were originally designed for.
> >
> > So, really, we're way beyond the original design scope of this
> > subsystem now.
> 
> Got it. So it is better to allocate the structure of the list_lru_node
> dynamically. We should only allocate it when it is really demanded.
> But allocating memory by using GFP_ATOMIC in list_lru_add() is
> not a good idea. So we should allocate the memory out of
> list_lru_add(). I can propose an approach that may work.
> 
> Before start, we should know about the following rules of list lrus.
> 
> - Only objects allocated with __GFP_ACCOUNT need to allocate
>   the struct list_lru_node.
> - The caller of allocating memory must know which list_lru the
>   object will insert.
> 
> So we can allocate struct list_lru_node when allocating the
> object instead of allocating it when list_lru_add().  It is easy, because
> we already know the list_lru and memcg which the object belongs
> to. So we can introduce a new helper to allocate the object and
> list_lru_node. Like below.
> 
> void *list_lru_kmem_cache_alloc(struct list_lru *lru, struct kmem_cache *s,
>                                 gfp_t gfpflags)
> {
>         void *ret = kmem_cache_alloc(s, gfpflags);
> 
>         if (ret && (gfpflags & __GFP_ACCOUNT)) {
>                 struct mem_cgroup *memcg = mem_cgroup_from_obj(ret);
> 
>                 if (mem_cgroup_is_root(memcg))
>                         return ret;
> 
>                 /* Allocate per-memcg list_lru_node, if it already
> allocated, do nothing. */
>                 memcg_list_lru_node_alloc(lru, memcg,
> page_to_nid(virt_to_page(ret)), gfpflags);
>         }
> 
>         return ret;
> }
> 
> If the user wants to insert the allocated object to its lru list in
> the feature. The
> user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
> I have looked at the code closely. There are 3 different kmem_caches that
> need to use this new API to allocate memory. They are inode_cachep,
> dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.
> 
> Hi Roman and Dave,
> 
> What do you think about this approach? If there is no problem, I can provide
> a preliminary patchset within a week.

At a very first glance it looks similar to what Bharata proposed, but with some
additional tricks. It would be nice to find a common ground here. In general,
I think it's a right direction.

In general I believe we might need some more fundamental changes, but I don't
have a specific recipe yet. I need to think more of it.

Thanks!
