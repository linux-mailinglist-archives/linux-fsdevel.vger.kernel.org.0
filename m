Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102948B4A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiAKRyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 12:54:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344362AbiAKRym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:54:42 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHRNCv023896;
        Tue, 11 Jan 2022 09:54:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=B/YfnN7w0EaV56zvux0CwBgeQoaaRb5SD7BVy928/hE=;
 b=gRZ22MSut3ZlJX5n9KvKmCE6Q9JoFQKNwrApV0rytedjKYcAmwzKh1i3ZeXL19I/3CyY
 cZ/BiJHRBKkT5fuYhZ0kr+jvYv2pH9DtlxWQSaX26hRm9v2ODlhWAdzHVFrwbf+o/0mV
 oiiaJTdqsjAtQ5kqIRW2RPkXzE+rIYMr0Qg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dh86j323f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 09:54:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 09:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWSV/6XoSIpV52sjcTUvYRP4b95DeeFIsN5diPcTrquoJXfSHyqpnldDH9hEecv4halAFKTo+8HW0xfsSJLkNzjx70dN5XJVma/EJSVeXbeO+nDVE+giwXJXEZUCH4inUl3etD2z3iLroHdIWPK4Jta7pQdP0+bGTtJ7CZ+n23XhaFQLNUINenR/W7NieV5cUyngmM7l99yc0p9HmfrflLSTGZl/uRyxpto2spoO1Hrg59FV/FWYAYlzN1AQarz0G9UsNoggunQxtuYfkXwPGqea80W+ukyvpJXfp9ZEB9Frr0IfV4q855BNKKnv/AO5klv3iQO12o/oBZg+pzEnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/YfnN7w0EaV56zvux0CwBgeQoaaRb5SD7BVy928/hE=;
 b=m9c7neS00hwZd4DOEmHWilRSMz+iHLiP0SbO62cF5cTcoj6uriWzwc1bKZZgdmr8hQQVQeKGMfDmqXbvYurpwfGckaClkl+Y4RjuFObh8uChqrbRW8o3hDT1tVpW2RtQLlrW0wa4jwGEUFUqazizlTheNkRk7aYScTzvptmcMC4bdUW/oPtjBo4OjQwNcznU8SxwsMgHDLqys7aB5CajBsztJaxbrwZkhN7mj1j8HwBJQbMIQhAZ8M5ULNN8jwY3utig/qRiCxoGSB+Ofs+tyv73e7fBzVUzTkH+lmfSUCYGkcAk5skW4DxKi8q6URmTSCgBUAqvkdH3aiGqwRPQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4375.namprd15.prod.outlook.com (2603:10b6:a03:370::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:54:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:54:09 +0000
Date:   Tue, 11 Jan 2022 09:54:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
Message-ID: <Yd3EPCIQv6qo4fHw@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-3-songmuchun@bytedance.com>
 <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
 <CAMZfGtWmwTLHdO6acx9_+nR68j-v9SKjMsq-0v4ZDeQORgaQ=w@mail.gmail.com>
 <Ydx/MFK72xrsXE0l@carbon.dhcp.thefacebook.com>
 <a72a4e3a-3af9-7a36-4583-6181f3579cfb@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a72a4e3a-3af9-7a36-4583-6181f3579cfb@suse.cz>
X-ClientProxiedBy: MWHPR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:301:4a::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 674465a1-74a3-4b3c-f0a3-08d9d52b5e21
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4375:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4375F4005202428169EC965EBE519@SJ0PR15MB4375.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtAIxjF9ddhmxPKZM1Jx37vbS4jCYRaLKxUUWEIzO/oF7u8yBTf2ySsTMp+anwMoLvt4pvAgNEYti4QIlP5T2lPGvmWPC/D8mv3yelktw3LIRcQ1YNEuxXlKzrrK0fSwk4XsOJcDijkSi1jHllx5UbxS5SN3A1Z95hO4kI2T0lRONgV6qCzPegEewFmrFL8DnM6REGwQUF9vDW7tm8c4xZEjmVHDsqIsEUI2EOd18c4HTkjdkRfAW9pd3vN9eoBAoonmIP9sO3wcmIRTl+SvYOxPaahFe2fcPg1ymQG+dfQdyDLNX7LmfXzz3CsBQ+Xa+NLqs8DGgQqs1SBE1byWtWyDkMHy54K9JlWu+NtFjkPKkBNZS7TFVm5TYSMG2Xuuh4Ix34a9Psx7w21eemfMrytfBf16DAYK5MXAbjKW0Em64TjY2UiwZexpViQXkyuhDfv6F2vNu+s6xVKKky7jUXg81heuyoxJpL6ZGB0iiNLsv/6UWUmwhYcFfr8Vm1Fmrl6TswlS0kyqnJokB9aOjvGA+/Y8kUbIVW5Y2YNP+3PRGQOK50Qw/8XLimBK4spxDHwl5WqkH3BgycENo35TGIXgJnIdZNOl1Drw9wX++PqOVfICSCRAN2AmjBxxshCfdyRqSFmCV20e6YoJzGbzlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(66556008)(8676002)(66476007)(66946007)(6506007)(4326008)(6486002)(53546011)(52116002)(7416002)(83380400001)(5660300002)(6916009)(6512007)(6666004)(8936002)(508600001)(54906003)(9686003)(186003)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/YznwanJclmPwAuEiW8BWl1S+c42gQJC2Bl7c27CcWmf/+l6P7z+lqDJoWy?=
 =?us-ascii?Q?u3xOlKchTSr7x0uCl8ljs1F/2oYanG93lf/wi5OXuk9cH/dR308iUaIov9aZ?=
 =?us-ascii?Q?KHZuqTewvQzB8/RhEfc8rCPcZF0TuY0AqR2w5YtHxYQxDiICVcXTTNAazELZ?=
 =?us-ascii?Q?5vkEmAQgWo5I+bkW/hBdTJcKzraeKwWvjtPULcG6c86Ig+fjgyyW/wGXTsD3?=
 =?us-ascii?Q?CTwv0hAF6jq8c/mwM5qxmNMW/7Vc7JWhtitOYlxf7ypzJTwIRveiY7IqPr/m?=
 =?us-ascii?Q?Zf/1lFWweKuOIDHO5U1r81+/ogXShBRkiHT6Pl7gRJ3TBqWTQEuMLgJrqimK?=
 =?us-ascii?Q?py3zbthivY0RykSIYqz9SvqaSsLQ7Ff/V4igJTYxMdDg6ud9iz8zvpliHEY7?=
 =?us-ascii?Q?F8xos3bd4vqT2k8lLW48FKEXbahsdgpTmpK58ZEw9Re3TSulVlmG7LUhsCQG?=
 =?us-ascii?Q?WWFP3YhuF1cw7F1zTIWg70nDcU+D841gKBarkfX8G+SgLd+c+U2rNc4Z3L2m?=
 =?us-ascii?Q?wR0eLPlipiB1+llAA8omMkGu7q+Laxpg0iM/v4xrrSo/KypyrFSxH/NbSnUz?=
 =?us-ascii?Q?G7N5OvifEJmBiABpEl4WIY9XSzh06+CyuAMgTORhyS4+QD7vmWT3ylm0FMRU?=
 =?us-ascii?Q?YRGSwsH1GO/E3zvuQC1i40qEJ7UdhoIaLsyMV0Z8JRDtMH3hdwb9aW99iUmc?=
 =?us-ascii?Q?GdUUgZA01b1ozvLly2Jg+J+PgfG+mhXo3cxSEWRnZm1eS/sBJM7ZQi84Ad0X?=
 =?us-ascii?Q?ykWgGzuev5cZODN16//EAEFB9af0clFbQ1ggMloDW0akIQOVuH038GJIxLoE?=
 =?us-ascii?Q?epBpTA1777ZSJd8/ItfAdnlGlqH094WMFwdlLDvTVGGlsxicjID8l4zGVaQr?=
 =?us-ascii?Q?Ll9EEsApYsbRUQ/iE8tXcrwH6QNsDV06vqrebd3+zVmZbrlYL/osIPJu5Nju?=
 =?us-ascii?Q?M2+l3wqq8hPCn2nlDQdr71IuRQtho5+hf1OKsfdQeIPer1iHOARJ/UTl2sWZ?=
 =?us-ascii?Q?Z19noEEHiudi3ZhAxhtzwKH4Tun6e1W2fXhQ0Etory7rlWufI7H9WsrSX3sf?=
 =?us-ascii?Q?CSSu64/DlDvlUWr5wVQYh6AW0uRZIZiK9bc8e/0TpMbMdka8Ev1AM1AVYb6X?=
 =?us-ascii?Q?ym2Ul6jX2tvfltCFLQFMBWIj5ePCX/bGntS/gjFoloJa/oMYBg9b7Y6jqJXS?=
 =?us-ascii?Q?FAe5kAHOpx+iL8BybyqOeq4wWKb3BfXRQfW/1nbEkjI/4muowDXc3OQSSB4W?=
 =?us-ascii?Q?TO4oQMxU/7wl7qLN9nrZjg9BvLtwYfwOf8aUeRIymXmdr7Yuxfodel++rH7H?=
 =?us-ascii?Q?FnWxbIzpz7Yp1vAcYp5fpVPdG+uJchTMIsmFZASVy/PLGEWmNZLKLE9jx/pt?=
 =?us-ascii?Q?wlb+zA4v00Au03OqeQEbY7VEp3eSo8yY7R2UWKTtJz7ovVjHuOQRck1OjD8R?=
 =?us-ascii?Q?sTnU2q2UdkYYThaCxDEoPvwdX2xzzUPea7pab91PcIuf18wt2SPgAres8tJY?=
 =?us-ascii?Q?qjJ8W7diritdPH8i67sJ07Jouxbsfy9FYjPCmnOIyPJKgBLyrX5r7p6xmQs0?=
 =?us-ascii?Q?CN04EoTSDnFzBEMfouqXpX0zAnSkOlnRshsgfl5m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 674465a1-74a3-4b3c-f0a3-08d9d52b5e21
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:54:09.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkIA3niQDKER3D9D9uoK/kJn6JOnjj86OZ/mAdp88QVCGy/pdBD45lhZUxRw1iML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4375
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Ev3kBSDQ_I-pRPamAePRc5nP_1BoqxpY
X-Proofpoint-GUID: Ev3kBSDQ_I-pRPamAePRc5nP_1BoqxpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=892 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 04:41:29PM +0100, Vlastimil Babka wrote:
> On 1/10/22 19:47, Roman Gushchin wrote:
> > On Sun, Jan 09, 2022 at 02:21:22PM +0800, Muchun Song wrote:
> >> On Fri, Jan 7, 2022 at 11:05 AM Roman Gushchin <guro@fb.com> wrote:
> >> >
> >> [...]
> >> > >  /*
> >> > >   * struct kmem_cache related prototypes
> >> > > @@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
> >> > >
> >> > >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> >> > >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> >> > > +void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >> > > +                        gfp_t gfpflags) __assume_slab_alignment __malloc;
> >> >
> >> > I'm not a big fan of this patch: I don't see why preparing the lru
> >> > infrastructure has to be integrated that deep into the slab code.
> >> >
> >> > Why can't kmem_cache_alloc_lru() be a simple wrapper like (pseudo-code):
> >> >   void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >> >                            gfp_t gfpflags) {
> >> >         if (necessarily)
> >> >            prepare_lru_infra();
> >> >         return kmem_cache_alloc();
> >> >   }
> >> 
> >> Hi Roman,
> >> 
> >> Actually, it can. But there is going to be some redundant code similar
> >> like memcg_slab_pre_alloc_hook() does to detect the necessity of
> >> prepare_lru_infra() in the new scheme of kmem_cache_alloc_lru().
> >> I just want to reduce the redundant overhead.
> > 
> > Is this about getting a memcg pointer?
> > I doubt it's a good reason to make changes all over the slab code.
> > Another option to consider adding a new gfp flag.
> 
> I'm not sure how a flag would help as it seems we really need to pass a
> specific list_lru pointer and work with that. I was thinking if there was
> only one list_lru per class of object it could be part of struct kmem_cache,
> but investigating kmem_cache_alloc_lru() callers I see lru parameters:
> 
> - &nfs4_xattr_cache_lru - this is fixed
> - xas->xa_lru potentially not fixed, although the only caller of
> xas_set_lru() passes &shadow_nodes so effectively fixed
> - &sb->s_dentry_lru - dynamic, boo

Indeed.

> 
> > Vlastimil, what do you think?
> 
> Memcg code is already quite intertwined with slab code, for better or worse,
> so I guess the extra lru parameter in a bunch of inline functions won't
> change much. I don't immediately see a better solution.

Ok then. Thanks for taking a look!
