Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC0489F84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbiAJSsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:48:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242217AbiAJSsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:48:00 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AIWCca002052;
        Mon, 10 Jan 2022 10:47:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=miRMnr03q3qFDYDAzWQgLsliuZJuOUQsAkIIQuDzl4Q=;
 b=evehsqZBDwiUDqc8pZWpASLbwU9bjuNquxz3AYgCiQlL9bLYafbtvbThuYNJDzMMpp6k
 CmIq4JidpGieLsHvjYy8e6iDkZbohaK1lJV3CB+0JfG4BMgGEL8VH+jwQQdBLLveOKbV
 RnLi2Ae/PXIU5rl5VfUBX9zOFOgzh/EK1y4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgnq6j58b-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jan 2022 10:47:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 10:47:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq4JMEoSCj0SDJR1SfgjM39cIn7k2ytFstDrJqTgs0kGgLauAPW94S+VW9g6a8HqhEl64HqcJjvU+hJhDt5mH/0s4Uhl9sZB8yMTqXb3jS6ZKnQdJhQCbSR9EzVDXOCmSEjdpRCjoBvnKWKhF0VdThghm1lwgElWStp6p6Wg5TcbM3gw30vQGUNGutXgLai/ihpSZpx1ruwXZgLfJTA3FUgPiIK6tlxy2XdEuVHI0wCY/kgeGtgZGlmii93P5b6am5WV4kWLh7Wc02DwqDobThO22swdgK+0NCp8SUZG22zVLp2Z/tGT6u33rhuBMzEeHA9Fx8QlHDw2dMrGdlW9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miRMnr03q3qFDYDAzWQgLsliuZJuOUQsAkIIQuDzl4Q=;
 b=N+GvsR8jfVdoVWueDefcUt3N8xKXAIh3dxX5rW6TTjVDwtrLiX1Yqiae/sRVRflB6hCjweUdq0ZnzNJr16wjLs/ON73jdtCO9SFpvs4vb0cYHKYVdU5YG621rwo4ex6KuFBoMzpR9ZF2sMfuhYKmZU10Cwjn4LtE0E6j6c1Dv+OkzinABxCcY3La0XnSrgD9jP61ZdY484uqWQcIQcPQ9LSXC8CBjR2Jg5IvocnTeteBttTDDbxr3Scr4KDRQLKGV2Eyk0Jb0upnCEKqRnfmPwCh9PXzLjOLdQgJess5+wJjwhBZBuAaUz0qJvzOS7E/yJINMYuOlhAJZNcEKJThXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2341.namprd15.prod.outlook.com (2603:10b6:a02:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 18:47:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 18:47:16 +0000
Date:   Mon, 10 Jan 2022 10:47:12 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>
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
        Muchun Song <smuchun@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
Message-ID: <Ydx/MFK72xrsXE0l@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-3-songmuchun@bytedance.com>
 <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
 <CAMZfGtWmwTLHdO6acx9_+nR68j-v9SKjMsq-0v4ZDeQORgaQ=w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtWmwTLHdO6acx9_+nR68j-v9SKjMsq-0v4ZDeQORgaQ=w@mail.gmail.com>
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3a59e7-a92a-4b94-8d3a-08d9d4699f74
X-MS-TrafficTypeDiagnostic: BYAPR15MB2341:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB23416902B118CEB7B9A25EB3BE509@BYAPR15MB2341.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlCAi5oymg8SjjkU2qkP36JtV9VIr1Hvsir/K01vzYUIE6VEnwNKmw7jSCB4NlUrL8dLHfVpy5SfOS46NU5VPA9aoBOQp0bmgHkaYm54Zf1e3FJFpD0hguDHFyPj65YyYTw1XFevrx5Lz10JgjqT5isEV1v0EG1wRW2zjJVUJkGYHx+htts/m3209rJR7b/+566nx1LFf7xIhZrmFzahjwLUEL162KfLlrNOvn9W6qrCUWgBDeDhjnIyiztGlOJIFLd7ok3arz7T7yo94lm86B47vr7+2Mk93Xv3NOkbqisyOFUaqrXwISmlRM7e7gT7e7qbbugnzqPt8XmQLRRDtnv8hpZAANhHhSYf3qUtDl9qS3Zb0j55qQhWfQOZ0WzlKXfqH6rqgUQba7vZs9nz7UK9xImjytTyVw/C1evtrrOgrfA3XRvWMFuIhmc0nKeGssnOyLtNOE4q6i3HGk1cVHLW8RGQQf7g3oOEIFWSPw6tsdmqfvUTJwq6GbvJG63it7pCiHtDGRiH72vVAf4BuI6j3nL23r9hSX1LqpANz9OtqwSN4PsF0+5GQ+0D8jIzO3+KUiFiH50iA6hf/lZukn680cRu4pJF+DPQ/OJ6VIlJ7zyIxXINr+ww6lR+/tawh+8WAT7dmGs2YBHynVm5fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(66946007)(66476007)(83380400001)(186003)(6486002)(8936002)(6666004)(66556008)(38100700002)(9686003)(2906002)(4326008)(53546011)(8676002)(6506007)(6512007)(86362001)(7416002)(508600001)(5660300002)(316002)(110136005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qs843/ZdIB8hGOHJWlytSN8e4vL3EfyK+NFiVoNj/ejR59MIZhP5zSEoCqvf?=
 =?us-ascii?Q?0fbvjR4QSGimnfJsa3YNGJx5PmS7Z1ChAaP3Z4W7Xd8ecKHRrbc5c9dwzHLw?=
 =?us-ascii?Q?K3VSGxHu+YY+uwZhtT1JF3dzijyddxjRjNCVuKYVrZFCnNdhHRdK148wlbag?=
 =?us-ascii?Q?4igPC9X9rw0QVilm693ZFmquwZCG62UtCYDhOuqi+J+WMjCK78Zla0k/KH6G?=
 =?us-ascii?Q?p5cSsIn712Xp+2EfK5e7FxKvdKz4YFulDs2scqTWCsgh7br29cGD5qQdE8ai?=
 =?us-ascii?Q?8MP4SQVJAhy79RNIqP7gCNbX853IKyl2GdqyK6R+pdqvCcBZN/hRD3i788Pj?=
 =?us-ascii?Q?asimMy9zHokYo0wbPHqg7hTUDZp92Uyg8LHXIsG19cfSSIZp74m7leM8UdRQ?=
 =?us-ascii?Q?OyRBDWle+boatwIY3Wrtt+1gXD5/N9w+2XytXac9f6lyqJePLhSI4rPbYec3?=
 =?us-ascii?Q?+5yImuKRZk0D5pxNP6oSDXlSf02NrBZMy0FvqhEYAm25ZR9+bA/Rgg/7oe4F?=
 =?us-ascii?Q?5gwx13y2LKESIVygPgZN6JWrwnPebvisfToIgxVzHLoipvrDXv+WoTcwih/A?=
 =?us-ascii?Q?v/kzI0I2y1xCfgp9G8STjQNXhIZxxwTllHt0QeK3usnt9SdQp1yso9SzGRwW?=
 =?us-ascii?Q?p+zUOZ7dJhkN69tJC76dqCjUT1b3cZd/gnu5eMR0HNowTfAVTbAt0SbJn2oj?=
 =?us-ascii?Q?W3oyj4WuApqp7wePV7MVInuZe/kEBdgIWPYfmAksWAp0CF9jHTh2uGo9uBDi?=
 =?us-ascii?Q?Wf/BqkkolXKUbYazHrsAV4eN7zNBb/LYfwxr2TZSlJcMu4Oda6xLGDUXw0HS?=
 =?us-ascii?Q?Z5Wmfx2NVkYCI5Uy1LE0hORIMG+IOUJT3AjWLoH0ornfuW8t7wLkxiuf3HaL?=
 =?us-ascii?Q?CmEQPv/3JT9zWdbuPNbdoGH4n6Cv++L/u5QdibKEeC3gWXiZsXeXCaO13c28?=
 =?us-ascii?Q?wXTOCzO4dPN/HgzMbwLIH5nvkQPQprKBYVcAzCXh1ltNw4L8OfVCKIXvnsae?=
 =?us-ascii?Q?CNVGQiMMkxrWswHylOG4q02P+PmCvdW5zEdCTHnW+qrSYM/DMAsJsOcjTRPu?=
 =?us-ascii?Q?Slxrh6O6J/n/1vWe6vYUkiJZJe9Ad4Su9dn8SC1pdkD+ma6DVeDBV7WhyPIe?=
 =?us-ascii?Q?etp0gSomoRFWa/9GWGczDW3s3a1Ah4yAaY8w9KG6ImaCApIRZ0FiJbc44AAP?=
 =?us-ascii?Q?ERQYcgA5HBfsgh7OGp3IQEmQHCqMyzZ/3APCSb9eJw/JrVj3kElfGOa61xeJ?=
 =?us-ascii?Q?+Kta1QXN14/OyiM0sk1Jk1ZIgZMi/QmyCX3cZQvEIbcTKxfOL7ciY55BnsKH?=
 =?us-ascii?Q?Kz1mm/qE/PvhJO2TUi7hmWk5JE3mEycI5SW5ZBdmsztCnB4RvRJuQuc+tP6m?=
 =?us-ascii?Q?/EGHd7sg0bM72F1rZrU2xX9xT6SmaTf+5p9lDcJwExYYP33Kj7wJUWiRMeJt?=
 =?us-ascii?Q?kh7Qj1e4cTkrCtfedhj6BW6Xo8CgIvzL2eW45atFN0WCTVGKvCP3nvbd4SEF?=
 =?us-ascii?Q?mASTpRajxnXs2N6VyUlNtrqWGeOXv67/3vDhf98sLSVrUrPPT/cnD0Lyl6yQ?=
 =?us-ascii?Q?lLeKQhOVJKpfaG8CW+UGGS8OLpwSZTkFWL8Y4Wy7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3a59e7-a92a-4b94-8d3a-08d9d4699f74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 18:47:16.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /51BArDWEOg4hT5EOLB/nWgswWcWSMsmobmt08omabZE/mZ2V9hke5BNv/oUfJuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: e3V3i3EK0E8viBiZINGZfIzKGidUhP7L
X-Proofpoint-GUID: e3V3i3EK0E8viBiZINGZfIzKGidUhP7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_08,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=889
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 09, 2022 at 02:21:22PM +0800, Muchun Song wrote:
> On Fri, Jan 7, 2022 at 11:05 AM Roman Gushchin <guro@fb.com> wrote:
> >
> [...]
> > >  /*
> > >   * struct kmem_cache related prototypes
> > > @@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
> > >
> > >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> > >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > > +void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > > +                        gfp_t gfpflags) __assume_slab_alignment __malloc;
> >
> > I'm not a big fan of this patch: I don't see why preparing the lru
> > infrastructure has to be integrated that deep into the slab code.
> >
> > Why can't kmem_cache_alloc_lru() be a simple wrapper like (pseudo-code):
> >   void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >                            gfp_t gfpflags) {
> >         if (necessarily)
> >            prepare_lru_infra();
> >         return kmem_cache_alloc();
> >   }
> 
> Hi Roman,
> 
> Actually, it can. But there is going to be some redundant code similar
> like memcg_slab_pre_alloc_hook() does to detect the necessity of
> prepare_lru_infra() in the new scheme of kmem_cache_alloc_lru().
> I just want to reduce the redundant overhead.

Is this about getting a memcg pointer?
I doubt it's a good reason to make changes all over the slab code.
Another option to consider adding a new gfp flag.

Vlastimil, what do you think?

Thanks!
