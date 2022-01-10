Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBEC489F63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiAJSm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:42:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34042 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240337AbiAJSm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:42:59 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AIVGgX013759;
        Mon, 10 Jan 2022 10:42:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=y+sGDboMArBIpcKVPDI2WjY9w91fGnYhEY7+QrOw5dI=;
 b=ZuslliphvT3inoVz+rKHHwCT1PVP7WrJlniKBLfpkK/qgVkgF/PJ60Qq8qoUEsr5Btyy
 XptZV4eQwhj262DAB5tr22LM2aff5PxRc9AgOpztuT1N7uTi3WecOUZ06SOc3RVrz1JM
 th3bXDZzkm3fEG/NjV7M36J+0IFauv9xVr8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgnuw203w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jan 2022 10:42:34 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 10:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drWN0g3h4s4aCFyeYYDLw/Z/M6MfOyWwSc/Qn7cAvZOf5fnDB4L9RUOHalq3+S2M+gF6KbZYUa/HN+P/wKOWmGtQeWfvco17Q58OHUWN1SADo8TA90bHk5iIscDQ9kh2zx46UnwiE2yYQGlTYSBmWcjiehjeReFA6fYs+86XpPSruPA3dsV+iMWIOeXEzbVFuUrA+ctZGfroIWQg98MhGdlAvhQGaQKmYf6+DpCA4PewbGg0656AqmZZdpUqnXDp+hMgoC8eFxr/XU5h+AHGlhiQb901q0uoAP1QnSD/MgfRJQUT9J4tbeYHeCw9KDrZp1kWhoeu7qqCXFEdE6Nlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+sGDboMArBIpcKVPDI2WjY9w91fGnYhEY7+QrOw5dI=;
 b=mm6rmHXKg36XvPxaJcPNM3ZouqQoC0qodW+m0XJyAcuLtW/PUTZjKmffniiMmsWz40N1WV4o4kuqDZqAfYQW8pmdPE6zU6Kr2rpVUTVSTn0l5Kw/dZaCLI4Blx2QK9ndVdRz2qkyeT/QXgC15tjO6e0Klr7CoWS5DDszl9mA1WBxNA1MD9ok9/aOt4/3wwVNwb+xDAwh6hwr58TEEUphVg/o3fpFQUnDPuFam6l/iK0FDuXDdEH8hZ27xoAL0plPdho6hFiMoobuUIafageaDpJ1L30+gUL/1Oa1dpeyKnUno82wIlv2aFtpSRoLny20WbwqQtTdb3hMrFvXP5nFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4503.namprd15.prod.outlook.com (2603:10b6:a03:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 18:42:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 18:42:31 +0000
Date:   Mon, 10 Jan 2022 10:42:13 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-nfs@vger.kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v5 01/16] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
Message-ID: <Ydx+BWQp18hjdO32@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-2-songmuchun@bytedance.com>
 <YdeDym9IUghnagrK@carbon.dhcp.thefacebook.com>
 <CAMZfGtV2G=R9nTuSYGAeqv+RkJsCVVACc3h47OeWA7n3mWbqsA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtV2G=R9nTuSYGAeqv+RkJsCVVACc3h47OeWA7n3mWbqsA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 251a40fd-e162-4e8e-ac21-08d9d468f549
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4503:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB450377CB76DCC7F3D458872BBE509@SJ0PR15MB4503.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMQs55uQPbhbC/50ffST8rS5T3v34Xfo/wVsOXwmjcQrmM4DHqoMCBchJEFHZyACeD7Kd3l2is0j7TJhktkWTPMGxBg9HXapfhkj7N3gArxENSzDz2CKTOm2VEX16VXM1uwZPYofNPv9Q8jKJ4zp6pGB9Y4XPSppr2xfuYHPAtxXRHORRY4lGNwcCZ8dSdf/NA25sd6sjtw1ctEHPSRc1BfpMJUI+OETNDBxxO6+tVG54Iz0L8XMYs308D7V7MlwB+jWYrLve+8niP8TVsDCtblLwUhDBO+Cx/T5UkLQW2lbIejWJbAR5yRp56VQmySzGIaR95E4HV5P+I3SGGIJuOfs0DezVBgJtfK2+xJMQzVl5aVJIifNqZ9ij1Tk2eKe/Zp6lNYfwgQ21AylECUxczXLtC/vUryZ1TSKHe+0lV1x6EuGgxY9puDGj+StvZnb3/5WwsEvXQ7sxC2OlDDdQlepKyTnLbPF+7d3hfCnVZ/PR0QszgrmmXKDcioRJNaK0Jn6e349fcnpjJXOujPFZoaVsiGkQe6xxNpRekO8a9Uc1Z6Rj0xKkWTysAW5dVJ/mU411w7mdBEaK77wYe/sl4dP8CwTqA0C8SXvwWUQYJXKGcP+pfPEfJKTZ2zxJ2rA7wrmzMRng0AxGLWhXDXq75h4Ctl2Hm94sTF47eGY6gRtCs4AhQ2qys9CTotui6nv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(8936002)(7416002)(52116002)(316002)(9686003)(6916009)(53546011)(6512007)(6506007)(66946007)(38100700002)(6486002)(4326008)(508600001)(2906002)(54906003)(66556008)(66476007)(186003)(86362001)(83380400001)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2nHI+B6Rr9/bc5SO5tJzVfhMlGc9lhpX3R19BqXmVi6IAaTFWuNGIjFCkdf?=
 =?us-ascii?Q?NISZmclMzoGY7bDW01BLCJMxXLP+rHyvy1wrne4ARt24iRup30fdCVVQKwTh?=
 =?us-ascii?Q?sukoSqcBx+u2YPmsk6POfgZPhH/6bUE++z6T86/j07nS6VTlpCOcZoyDTxMj?=
 =?us-ascii?Q?zrT0XAhFPPx9aGTA1R3IA9ATU3mMGXPqQhiJysl2JsGqzLFfIFeYWrclAgCu?=
 =?us-ascii?Q?FtTeDNLjESbL6j/OKj4Pvxo8bFxOIQLHb8kY1Dc1AKnGO5BgtUhZLFsEDnZk?=
 =?us-ascii?Q?zvCTqFRN6P3gYK01cLs6JkXEEyBbzSwW1+FDm1Df6uXBWhfj9oaf7Ba1fskH?=
 =?us-ascii?Q?EY1P8oVlfGLKdcHnlKlyUr873h3oNAKsEyoEXe9I3Y5N3J2wBzjSNQsHMUeI?=
 =?us-ascii?Q?5NS50LK3d25q3Yg88uzwQ6SKJOINppF8UnI4q3tSjvkQDhYniIZNBL4C0zul?=
 =?us-ascii?Q?58ejaJaEFU5yEmGHxrQNpRREyD2CBNnZW+U5F9gx2bvrXzzNA+A9aPdrSuOL?=
 =?us-ascii?Q?5WebWlvtX1Y8aJc/Iv0A2pnqfGEOSsoI9JBgomyAk7Fdw9TUUZNNXjSvDQQW?=
 =?us-ascii?Q?EpaQcgwoGcP7zf/EwYtWFFW/m7Zws7+QHhZ4zG6uK8F8iOTIFDIOdXziMUD6?=
 =?us-ascii?Q?fQVfpjw3Vefn0AZBVtoRkJijOAbn187baZhP+SFMDHgyvn8lc7ctC4+aL2a4?=
 =?us-ascii?Q?RgQFcwoStdQOgD1r3Ovvk1ly9CE/THpucpgObaIqUNuht1FsAoaG6w5IrqsD?=
 =?us-ascii?Q?dtEDuchaAp5+oMzF45h0tckjq9zUYay3LcZX3D0NKpOHChFhXF84X+VoWNY0?=
 =?us-ascii?Q?ssv/jSUb2eNedkFtszbEvHhjLrtSnvtGX0bCjo9kNU7LZd0MFIcpZ6spkx4K?=
 =?us-ascii?Q?FpD/f2dRt/Ka84z5EqwUVawFCUW+bZNbgEYI2EoSFfVdOLp7LiT2m+VjDcKS?=
 =?us-ascii?Q?nkXdbR7B0jxhw+Q6oqqLaLjKC+SNRP+7UVJ65tF9nb3v8edOOF51ly3cLaYp?=
 =?us-ascii?Q?Xgz9yqm3a1TNLRWYvhdhOVBdXP13yQq+lnMir4JPy7X8Wly3bTnv15WQQbBv?=
 =?us-ascii?Q?XN6oqUrBcYubzpGfOUJjpfc+PTeTHs32ejGvx1EuSXiRaElKuJK8G7dwYONd?=
 =?us-ascii?Q?1xBViN948NCL8z3e+1L1kFADBNwDB/EehnDRiVb20VP0gEb47LRDeSbW3YBW?=
 =?us-ascii?Q?2yucclwS8KhvppyL3+1TPYteQ5BsMpl1XuH6Z3qp5SMeZrLo1X/0q/oFhCC0?=
 =?us-ascii?Q?u7Bxjs+DVw/WfDlb5vNFkzAIDOxGNmF5wob5F8dJ55GTR2gynHhKsxsgjmmN?=
 =?us-ascii?Q?C/I5XDj/KqEe2mS0Zgg4IKJmSlI3y3DFbXA1XWgUS9MFUeZJ9FekMx2FsEoW?=
 =?us-ascii?Q?MX/Y7MEjxYvYUtR/GHQ+9cxLK0vLZjBcdqrQt6FE5HtYexbmjTnPsa4Nmr/c?=
 =?us-ascii?Q?J9TtGG3TFP789iE+1rFjtK3Uewq1V+7e0abcT+dYvYiQtPTeRgVTI7DlVsUr?=
 =?us-ascii?Q?Z9YRxTfVlkGSyaAeTvtmI2qLnSBK3vO1imcG26jwCFt/tbk7VIrtbGZMV512?=
 =?us-ascii?Q?hL9EdRFCfbWVjoTzZ7Vg9SvPlPpyZOB8yLRkJpUz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a40fd-e162-4e8e-ac21-08d9d468f549
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 18:42:31.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BG3LZIA8rYgxz22yVVxN8KO1PR+EKHN4hQEdu6u61wRJJ9YiQnUSmT9nwZg5lE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4503
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _oR_mPcpiGGWiznp1tquj_fr_A9hKAhr
X-Proofpoint-ORIG-GUID: _oR_mPcpiGGWiznp1tquj_fr_A9hKAhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_08,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=713
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 09, 2022 at 12:49:56PM +0800, Muchun Song wrote:
> On Fri, Jan 7, 2022 at 8:05 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Dec 20, 2021 at 04:56:34PM +0800, Muchun Song wrote:
> > > The list_lru uses an array (list_lru_memcg->lru) to store pointers
> > > which point to the list_lru_one. And the array is per memcg per node.
> > > Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> > > a pointer size on 64 bits system) when we run 10k containers in the
> > > system. The memory consumption of the arrays becomes significant. The
> > > more numa node, the more memory it consumes.
> > >
> > > I have done a simple test, which creates 10K memcg and mount point
> > > each in a two-node system. The memory consumption of the list_lru
> > > will be 24464MB. After converting the array from per memcg per node
> > > to per memcg, the memory consumption is going to be 21957MB. It is
> > > reduces by 2.5GB. In our AMD servers with 8 numa nodes in those
> > > sysuem, the memory consumption could be more significant. The savings
> > > come from the list_lru_one heads, that it also simplifies the
> > > alloc/dealloc path.
> > >
> > > The new scheme looks like the following.
> > >
> > >   +----------+   mlrus   +----------------+   mlru   +----------------------+
> > >   | list_lru +---------->| list_lru_memcg +--------->|  list_lru_per_memcg  |
> > >   +----------+           +----------------+          +----------------------+
> > >                                                      |  list_lru_per_memcg  |
> > >                                                      +----------------------+
> > >                                                      |          ...         |
> > >                           +--------------+   node    +----------------------+
> > >                           | list_lru_one |<----------+  list_lru_per_memcg  |
> > >                           +--------------+           +----------------------+
> > >                           | list_lru_one |
> > >                           +--------------+
> > >                           |      ...     |
> > >                           +--------------+
> > >                           | list_lru_one |
> > >                           +--------------+
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > As much as I like the code changes (there is indeed a significant simplification!),
> > I don't like the commit message and title, because I wasn't able to understand
> > what the patch is doing and some parts look simply questionable. Overall it
> > sounds like you reduce the number of list_lru_one structures, which is not true.
> >
> > How about something like this?
> >
> > --
> > mm: list_lru: transpose the array of per-node per-memcg lru lists
> >
> > The current scheme of maintaining per-node per-memcg lru lists looks like:
> >   struct list_lru {
> >     struct list_lru_node *node;           (for each node)
> >       struct list_lru_memcg *memcg_lrus;
> >         struct list_lru_one *lru[];       (for each memcg)
> >   }
> >
> > By effectively transposing the two-dimension array of list_lru_one's structures
> > (per-node per-memcg => per-memcg per-node) it's possible to save some memory
> > and simplify alloc/dealloc paths. The new scheme looks like:
> >   struct list_lru {
> >     struct list_lru_memcg *mlrus;
> >       struct list_lru_per_memcg *mlru[];  (for each memcg)
> >         struct list_lru_one node[0];      (for each node)
> >   }
> >
> > Memory savings are coming from having fewer list_lru_memcg structures, which
> > contain an extra struct rcu_head to handle the destruction process.
> 
> My bad English. Actually, the saving is coming from not only 'struct rcu_head'
> but also some pointer arrays used to store the pointer to 'struct list_lru_one'.
> The array is per node and its size is 8 (a pointer) * num_memcgs.

Nice! Please, add this to the commit log.

> So the total
> size of the arrays is  8 * num_nodes * memcg_nr_cache_ids. After this patch,
> the size becomes 8 * memcg_nr_cache_ids. So the saving is
> 
>    8 * (num_nodes - 1) * memcg_nr_cache_ids.
> 
> > --
> >
> > But what worries me is that memory savings numbers you posted don't do up.
> > In theory we can save
> > 16 (size of struct rcu_head) * 10000 (number of cgroups) * 2 (number of numa nodes) = 320k
> > per slab cache. Did you have a ton of mount points? Otherwise I don't understand
> > where these 2.5Gb are coming from.
> 
> memcg_nr_cache_ids is 12286 when creating 10k memcgs. So the saving
> of arrays of one list_lru is 8 * 1 (number of numa nodes - 1) * 12286 = 96k.
> There will be 2 * 10k list_lru when mounting 10k points. So the total
> saving is 96k * 2 * 10k = 1920 M.

So, there are 10k cgroups _and_ 10k mountpoints. Please, make it obvious from
the commit log. Most users don't have that many mount points (and likely cgroups),
so they shouldn't expect Gb's in savings.

Thanks!

PS I hope to review the rest of the patchset till the end of this week.
