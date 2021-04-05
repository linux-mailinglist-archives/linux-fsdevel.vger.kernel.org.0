Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BF3546C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhDESjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 14:39:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235090AbhDESjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:39:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135IXsEt021846;
        Mon, 5 Apr 2021 11:38:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Hhk5x3xlLU+Cglcu8rUidcEp8+gmw3w94FUAZdIBiTg=;
 b=cbVFv12IWFGGlz/XUONxE99ayao15zO+Li14yU/6O/lBZ+DUqFP9YYO6d/pg6QH25oDU
 z+AHBW2hFwJHKXxgb6hyXC8rXfB6qr2k4NCf+1/fYyhl26W/mCXwQTTmKFovT4Ixcxsi
 F8FXi4jxthzwiEN39/Vq2Buzk0fkIyEe6KQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qxc7jkpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Apr 2021 11:38:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 11:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4k/sc9KxD7mh9KW5XbgTWYrgDMMiFZiXOcU/raewN0Jn7yUqdI5QvxhYSre9HVnhL39unduyPgxnwHW1ubyfpk2p0gK99yZ5V+/OTTvIPdsm0DWnF68SyHgUHKgI/4Cam1MQ93isEsjqayo2IUBVoUkq74t6T6AUbGJrbqdFNNQEWGgdGGFjNvS2ggNddcPUKrhymWcviprGGM6Ekbnzgl2mAAw7kvEhSdfYpTnqlAIionamckXEsyx0hBzmd6xmSEwNw8xMpi5dQVwLIJvefQ0hmCnzIdyQyYPSrLm0Np0VsFidWkNcoKYJnHOWEA/n6AkgHVhkQlxJfqZLHJ7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhk5x3xlLU+Cglcu8rUidcEp8+gmw3w94FUAZdIBiTg=;
 b=Uq1lw5NXvZ2y1ayCQK8fgcpWdBLPvUj+PAZTRvpBV+q8siEsuvVEAfBmw3KbL6b6tkUcExJ+VFavPKLDxGomGxzY/i3Bh9hdY9Sd2a5Y6W4ZQvAGNWGbug1qdoCJz6/nu5cGCwyeu3mgKDLdSGYBetV984qDl5pwQEJBAPZdiDs5AItwfXfsFNVjvEkpY+Voodf3EA8j4di3G3FYcnlLF0sae0/SWVldOLCnyFTmqhOYIaSrQcl3arQdTb+pPyTn0KDtPlNVmlIsHcHYMFJIcmhD06Yx6PGN+tthXCuFhrDMjFeACb69peCHKgA/bWNdg4pqwTaCpUPUisHuSsetRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3351.namprd15.prod.outlook.com (2603:10b6:a03:10c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Mon, 5 Apr
 2021 18:38:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 18:38:48 +0000
Date:   Mon, 5 Apr 2021 11:38:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <YGtZNLhXjv8RegTK@carbon.dhcp.thefacebook.com>
References: <20210405054848.GA1077931@in.ibm.com>
 <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:c526]
X-ClientProxiedBy: MWHPR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:300:13d::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c526) by MWHPR20CA0006.namprd20.prod.outlook.com (2603:10b6:300:13d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 18:38:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d90131-7835-4714-3c1a-08d8f8620cdc
X-MS-TrafficTypeDiagnostic: BYAPR15MB3351:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3351FE37021EB7F2CA333E00BE779@BYAPR15MB3351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCkk1nAnfovMlcMvn/XbbqsgGda/Uze6x7/YGnEWUkey941a6hgMtggmjgT6nysgq46i2r7fg+KdKsdJvS4YgF0TbZXN4y8Y4s3tihorXl47lDaXJiR8Hk5+pvdq4E8Fx3MyrVh2C4a2e8c+Wy56X6vLIMZQ67BB//womNCmlYpqpWLo5+irlIchMEwu1cFpKdwbQ5Pki6MOeEtoySMUm3Wd8FdUyPwPDi9CtsfgeVEzJDclhjdHqMshKG5en6qp3rV8N9yOgSSDqtm90ZB4lRCfJS016+cY+TtKUwy5x1tQlEnzoqMx6MuU06fv3wKHGMINyYAMteqJmoK+zdnYSPTke7+13TPreBfjSnEYKIMkDKe4s49WxKCytLYlxtJGPyKeDBCHB2xmk+VyTI+xY/LtsCHC3QEtClI3wJB0favZ1hsfFkqFbByVFCmiVBj9SKsh2wrrEzu3xDvX1llR9ZBIFUjOx9FY0pUq4HkDVtf0/+zYDD7Gn/9XDliKKIOWUJbylLmLR4fLjiykWtH1omNMD3wP9/PL2xiu61GVKWMZTxycbTZpYp8v97IuZwCWzbvQHnwSOYHrn1BvXTBF+Kmu170YDjgxoRYvzdDGGzR5fLIn0+pme1sjUSZmiuLbVEXMUtXqTmhFMceTl8YI+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(38100700001)(6916009)(7416002)(6666004)(52116002)(8936002)(54906003)(7696005)(478600001)(55016002)(9686003)(186003)(30864003)(4326008)(86362001)(8676002)(5660300002)(66476007)(316002)(66946007)(16526019)(66556008)(83380400001)(6506007)(2906002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NmkuXGAHArM9KhFyOFlE3f9XY0YiYllaSBcs3NnrSkFkeBq8rp0aJgCDc5EY?=
 =?us-ascii?Q?bkUdEJb4qOmBWjSY+WWOYyj5kSd/RtQ0tnRtjJ2M0SLseFiywGW/KQS0EzP/?=
 =?us-ascii?Q?wVdT1914QXEN0q+eRwZo1TtQoG2hNtKhk0Pql2L7JO4j8rwmTYwPdOEHhtb+?=
 =?us-ascii?Q?IPm0xT1Rr7YVag9DEcQcRLRC2PelA+LjBLAaxIMRa6sqcJxshBRylBZ7hABl?=
 =?us-ascii?Q?IIfkJhjxzpcuAb6px+pKrpm6iSVWK1SrqN2XomwzY0YqB2AR+gBYWh9Jt9ri?=
 =?us-ascii?Q?4d2dUktZGg2Iic9x98SHWl+TwoIZ1+04hhc8UxqxkVsDxMm+iICBtv0fgILV?=
 =?us-ascii?Q?TA95CPgfvCK/FxVsbIv0E/UqKDpO0qcLvajSWym/NLCjPmsY5wrcJ72Pg35n?=
 =?us-ascii?Q?edskRnSbLhtaCoGCT2Dl1HSdIeX5Oy62UlGxYF2OLdK5nUauVwTYKaSL0oMS?=
 =?us-ascii?Q?z9ZYDjZtQ5yVJl3TatRjWyg1nwCZQpGcew69H50Bxut+XPZBnjfdqJtF6uRi?=
 =?us-ascii?Q?lpjdsSNMRSHQWUetP+ry9ekq5iLvIUN4BEkMK1Ai3YtwHdGcb74vtHh6RKuQ?=
 =?us-ascii?Q?ehBgZmDHYVKEoQKYlrQ2LSLJAbHAhbjmdgz1R3SbktC8boHrixBCn8/++4PB?=
 =?us-ascii?Q?nw5quFm7zUUgTt2cce1FWfi1nv9YESzkH817Dk4e2Y4RI9WO+9x2peu6I/eb?=
 =?us-ascii?Q?q3ax/kl0G08RpHE1Zyr2K2blqE985HFjZi6cGTs1s0UBdieDRcH57oP6vykl?=
 =?us-ascii?Q?WalqiXOlCenEZnNpzjNIhAe/o6wiIe6GLQPL6f+taG2xZaKdY0M+ldA+Cl5B?=
 =?us-ascii?Q?WIoqLGCsEwE3PYjs/YeYEm8POtYn8q8vXKDQ2vV4Kopgyol4Lbx/WVm9yf6D?=
 =?us-ascii?Q?wZUGZ+sr2aUVtbk6xc7D1KYwqxiStmczGrQpHU/lGsjTd2n3QDjnUAolL/JT?=
 =?us-ascii?Q?gXMcfT3dFaRxQxRYVQLi7yUba7Uk/pkEr6E7wNX65XMeqXXp/xDP/ZxzUA3K?=
 =?us-ascii?Q?uM/GSiA75DbKJZ4BEDW+58QRSFRzplzz4iy8qQ+UlB0w16DqOzfMcVj9xgyE?=
 =?us-ascii?Q?avOka5qqwPJr/FqYQfJMyinghndaewUA3L25a8PVAXIqkC00hquGg6nlYuX8?=
 =?us-ascii?Q?LhKGfI9wVEPqfDj+qifGlmM4PimspymqtiGSmtu70AukDOm1NKQya5B6x1s1?=
 =?us-ascii?Q?dqpnuLl6zC1pfDbokPiKTFiNK6gUILRC2bXqdSm7KoiEM4LcwocZPz1UEavh?=
 =?us-ascii?Q?XeA6yrkzg9Ujl/UfXz3rYPBh+R5qPHHuVqhdUpivMHRebLgYDY2fYPewZsLv?=
 =?us-ascii?Q?tuDt8nnWRjZdPEhuu3Yjyf8M/puo2yREQm0ycPCF9pFGLg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d90131-7835-4714-3c1a-08d8f8620cdc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 18:38:48.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVxZuMl8XA/0wlyfBf8N2pdrLf7Rm8AKphOv13uCGK9Z8woEdYLQxMo7OtXSHk2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3351
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: K8uWcbBti7vekdhA_YruvaWJwwALtYOj
X-Proofpoint-GUID: K8uWcbBti7vekdhA_YruvaWJwwALtYOj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_14:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:08:26AM -0700, Yang Shi wrote:
> On Sun, Apr 4, 2021 at 10:49 PM Bharata B Rao <bharata@linux.ibm.com> wrote:
> >
> > Hi,
> >
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
> >
> > The major allocator of kmalloc-32 slab cache happens to be the list_head
> > allocations of list_lru_one list. These lists are created whenever a
> > FS mount happens. Specially two such lists are registered by alloc_super(),
> > one for dentry and another for inode shrinker list. And these lists
> > are created for all possible NUMA nodes and for all given memcgs
> > (memcg_nr_cache_ids to be particular)
> >
> > If,
> >
> > A = Nr allocation request per mount: 2 (one for dentry and inode list)
> > B = Nr NUMA possible nodes
> > C = memcg_nr_cache_ids
> > D = size of each kmalloc-32 object: 32 bytes,
> >
> > then for every mount, the amount of memory consumed by kmalloc-32 slab
> > cache for list_lru creation is A*B*C*D bytes.
> 
> Yes, this is exactly what the current implementation does.
> 
> >
> > Following factors contribute to the excessive allocations:
> >
> > - Lists are created for possible NUMA nodes.
> 
> Yes, because filesystem caches (dentry and inode) are NUMA aware.
> 
> > - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
> >   list_lrus are created when it grows. Thus we end up creating list_lru_one
> >   list_heads even for those memcgs which are yet to be created.
> >   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
> >   a value of 12286.
> > - When a memcg goes offline, the list elements are drained to the parent
> >   memcg, but the list_head entry remains.
> > - The lists are destroyed only when the FS is unmounted. So list_heads
> >   for non-existing memcgs remain and continue to contribute to the
> >   kmalloc-32 allocation. This is presumably done for performance
> >   reason as they get reused when new memcgs are created, but they end up
> >   consuming slab memory until then.
> 
> The current implementation has list_lrus attached with super_block. So
> the list can't be freed until the super block is unmounted.
> 
> I'm looking into consolidating list_lrus more closely with memcgs. It
> means the list_lrus will have the same life cycles as memcgs rather
> than filesystems. This may be able to improve some. But I'm supposed
> the filesystem will be unmounted once the container exits and the
> memcgs will get offlined for your usecase.
> 
> > - In case of containers, a few file systems get mounted and are specific
> >   to the container namespace and hence to a particular memcg, but we
> >   end up creating lists for all the memcgs.
> 
> Yes, because the kernel is *NOT* aware of containers.
> 
> >   As an example, if 7 FS mounts are done for every container and when
> >   10k containers are created, we end up creating 2*7*12286 list_lru_one
> >   lists for each NUMA node. It appears that no elements will get added
> >   to other than 2*7=14 of them in the case of containers.
> >
> > One straight forward way to prevent this excessive list_lru_one
> > allocations is to limit the list_lru_one creation only to the
> > relevant memcg. However I don't see an easy way to figure out
> > that relevant memcg from FS mount path (alloc_super())
> >
> > As an alternative approach, I have this below hack that does lazy
> > list_lru creation. The memcg-specific list is created and initialized
> > only when there is a request to add an element to that particular
> > list. Though I am not sure about the full impact of this change
> > on the owners of the lists and also the performance impact of this,
> > the overall savings look good.
> 
> It is fine to reduce the memory consumption for your usecase, but I'm
> not sure if this would incur any noticeable overhead for vfs
> operations since list_lru_add() should be called quite often, but it
> just needs to allocate the list for once (for each memcg +
> filesystem), so the overhead might be fine.
> 
> And I'm wondering how much memory can be saved for real life workload.
> I don't expect most containers are idle in production environments.
> 
> Added some more memcg/list_lru experts in this loop, they may have better ideas.
> 
> >
> > Used memory
> >                 Before          During          After
> > W/o patch       23G             172G            40G
> > W/  patch       23G             69G             29G
> >
> > Slab consumption
> >                 Before          During          After
> > W/o patch       1.5G            149G            22G
> > W/  patch       1.5G            45G             10G
> >
> > Number of kmalloc-32 allocations
> >                 Before          During          After
> > W/o patch       178176          3442409472      388933632
> > W/  patch       190464          468992          468992
> >
> > Any thoughts on other approaches to address this scenario and
> > any specific comments about the approach that I have taken is
> > appreciated. Meanwhile the patch looks like below:
> >
> > From 9444a0c6734c2853057b1f486f85da2c409fdc84 Mon Sep 17 00:00:00 2001
> > From: Bharata B Rao <bharata@linux.ibm.com>
> > Date: Wed, 31 Mar 2021 18:21:45 +0530
> > Subject: [PATCH 1/1] mm: list_lru: Allocate list_lru_one only when required.
> >
> > Don't pre-allocate list_lru_one list heads for all memcg_cache_ids.
> > Instead allocate and initialize it only when required.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  mm/list_lru.c | 79 +++++++++++++++++++++++++--------------------------
> >  1 file changed, 38 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 6f067b6b935f..b453fa5008cc 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -112,16 +112,32 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
> >  }
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> > +static void init_one_lru(struct list_lru_one *l)
> > +{
> > +       INIT_LIST_HEAD(&l->list);
> > +       l->nr_items = 0;
> > +}
> > +
> >  bool list_lru_add(struct list_lru *lru, struct list_head *item)
> >  {
> >         int nid = page_to_nid(virt_to_page(item));
> >         struct list_lru_node *nlru = &lru->node[nid];
> >         struct mem_cgroup *memcg;
> >         struct list_lru_one *l;
> > +       struct list_lru_memcg *memcg_lrus;
> >
> >         spin_lock(&nlru->lock);
> >         if (list_empty(item)) {
> >                 l = list_lru_from_kmem(nlru, item, &memcg);
> > +               if (!l) {
> > +                       l = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
> > +                       if (!l)
> > +                               goto out;
> > +
> > +                       init_one_lru(l);
> > +                       memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
> > +                       memcg_lrus->lru[memcg_cache_id(memcg)] = l;
> > +               }
> >                 list_add_tail(item, &l->list);
> >                 /* Set shrinker bit if the first element was added */
> >                 if (!l->nr_items++)
> > @@ -131,6 +147,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
> >                 spin_unlock(&nlru->lock);
> >                 return true;
> >         }
> > +out:
> >         spin_unlock(&nlru->lock);
> >         return false;
> >  }
> > @@ -176,11 +193,12 @@ unsigned long list_lru_count_one(struct list_lru *lru,
> >  {
> >         struct list_lru_node *nlru = &lru->node[nid];
> >         struct list_lru_one *l;
> > -       unsigned long count;
> > +       unsigned long count = 0;
> >
> >         rcu_read_lock();
> >         l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
> > -       count = READ_ONCE(l->nr_items);
> > +       if (l)
> > +               count = READ_ONCE(l->nr_items);
> >         rcu_read_unlock();
> >
> >         return count;
> > @@ -207,6 +225,9 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
> >         unsigned long isolated = 0;
> >
> >         l = list_lru_from_memcg_idx(nlru, memcg_idx);
> > +       if (!l)
> > +               goto out;
> > +
> >  restart:
> >         list_for_each_safe(item, n, &l->list) {
> >                 enum lru_status ret;
> > @@ -251,6 +272,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
> >                         BUG();
> >                 }
> >         }
> > +out:
> >         return isolated;
> >  }
> >
> > @@ -312,12 +334,6 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> >  }
> >  EXPORT_SYMBOL_GPL(list_lru_walk_node);
> >
> > -static void init_one_lru(struct list_lru_one *l)
> > -{
> > -       INIT_LIST_HEAD(&l->list);
> > -       l->nr_items = 0;
> > -}
> > -
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
> >                                           int begin, int end)
> > @@ -328,41 +344,16 @@ static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
> >                 kfree(memcg_lrus->lru[i]);
> >  }
> >
> > -static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
> > -                                     int begin, int end)
> > -{
> > -       int i;
> > -
> > -       for (i = begin; i < end; i++) {
> > -               struct list_lru_one *l;
> > -
> > -               l = kmalloc(sizeof(struct list_lru_one), GFP_KERNEL);
> > -               if (!l)
> > -                       goto fail;
> > -
> > -               init_one_lru(l);
> > -               memcg_lrus->lru[i] = l;
> > -       }
> > -       return 0;
> > -fail:
> > -       __memcg_destroy_list_lru_node(memcg_lrus, begin, i);
> > -       return -ENOMEM;
> > -}
> > -
> >  static int memcg_init_list_lru_node(struct list_lru_node *nlru)
> >  {
> >         struct list_lru_memcg *memcg_lrus;
> >         int size = memcg_nr_cache_ids;
> >
> > -       memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
> > +       memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
> >                               size * sizeof(void *), GFP_KERNEL);
> >         if (!memcg_lrus)
> >                 return -ENOMEM;
> >
> > -       if (__memcg_init_list_lru_node(memcg_lrus, 0, size)) {
> > -               kvfree(memcg_lrus);
> > -               return -ENOMEM;
> > -       }
> >         RCU_INIT_POINTER(nlru->memcg_lrus, memcg_lrus);
> >
> >         return 0;
> > @@ -389,15 +380,10 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
> >
> >         old = rcu_dereference_protected(nlru->memcg_lrus,
> >                                         lockdep_is_held(&list_lrus_mutex));
> > -       new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
> > +       new = kvzalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
> >         if (!new)
> >                 return -ENOMEM;
> >
> > -       if (__memcg_init_list_lru_node(new, old_size, new_size)) {
> > -               kvfree(new);
> > -               return -ENOMEM;
> > -       }
> > -
> >         memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
> >
> >         /*
> > @@ -526,6 +512,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >         struct list_lru_node *nlru = &lru->node[nid];
> >         int dst_idx = dst_memcg->kmemcg_id;
> >         struct list_lru_one *src, *dst;
> > +       struct list_lru_memcg *memcg_lrus;
> >
> >         /*
> >          * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> > @@ -534,7 +521,17 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >         spin_lock_irq(&nlru->lock);
> >
> >         src = list_lru_from_memcg_idx(nlru, src_idx);
> > +       if (!src)
> > +               goto out;
> > +
> >         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> > +       if (!dst) {
> > +               /* TODO: Use __GFP_NOFAIL? */
> > +               dst = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
> > +               init_one_lru(dst);
> > +               memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
> > +               memcg_lrus->lru[dst_idx] = dst;
> > +       }

Hm, can't we just reuse src as dst in this case?
We don't need src anymore and we're basically allocating dst to move all data from src.
If not, we can allocate up to the root memcg every time to avoid having
!dst case and fiddle with __GFP_NOFAIL.

Otherwise I like the idea and I think it might reduce the memory overhead
especially on (very) big machines.

Thanks!
