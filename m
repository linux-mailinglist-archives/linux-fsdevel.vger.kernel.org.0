Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00E2C8EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgK3URg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 15:17:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727328AbgK3URg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:17:36 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUK3FZg016588;
        Mon, 30 Nov 2020 12:15:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RdtE83tmijXt7lplw7hDnEBho3pDThFvGVCdYYGG35I=;
 b=nSqAW4vwU6oVyrGEJH2/4ywRu9W63IFUP0nqh5g6HwKyLyFVUDGw0xQ5u6K1VHMkQ/34
 xomjxmLC+k8Viyb1Hvbu6ImFWSagcQDABnLygi05a5oiCZr2UtASfFmqT1mDypjY9UFV
 le8GBXiswToepDgUNoOXLYb7BtuwHp2ns1k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 354g9udq5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 12:15:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 12:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkIYp2xxBnak4MYL+YwfQdCKuXQHncjttEeBD+SaEHcuokoHtqewZWfcvdwRjkO0ioBLfP63SqAt9JO7tEoJW+7k1IL7IbMU3RGNe0aNmnQPMR7gfwfDv2yHjQUBfSWcQf31Fv4b3yj1OdmqbKhARgISgDNoDM2pcBKtmMN3UzI6ssuWK4R9m8NDNhhm2xd57igcHl5ks1ODPexBa3G9Q6Bfi5n7BSZMLpF5GQhKedg0FsB/+xJPQySqf7nLV0FQeaDpBVhk6yKtNKPHFT0tnbpXJ9ukRdf4krq4W9bZaiQjKpStK6V4qEc0zxJY534Vtil237quYqJ2zoAq0SHDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdtE83tmijXt7lplw7hDnEBho3pDThFvGVCdYYGG35I=;
 b=bq6YyXjrkrClMnjVts8q5/EuEyvRQh02BV4MdsfDLMhFqVKBSeGamu6wIKUIcL/MTcaiYsY5rBXkRN0dOjmLJG5oe5aYcam3uxq+8ZWxuKoS1pFD4KAJrz6v+BJMUwt9JOGPpfsDIllZaAYyUv8H7tjp8F7xYqlkg427QIBuNkfh+cyspriRUmLLS7pH0p55FrVA/2tkdMsSFiLp/5F5YYkPvxrtAzkfsnORs0dn98k+TCTHQtftfCvqyYu7bKt3gkWjCl+Gmltv5uTrGYWHzdGFeroaOyY6zVJXUW0ZrQbqgDuh621XqvVYD6kdwXZPIB3171Ch9tOH0Z6e/+VYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdtE83tmijXt7lplw7hDnEBho3pDThFvGVCdYYGG35I=;
 b=eBU3S5NgHMbF10FsFYbZHo5zkCpDWEtLJwDYUG/uc3VtQYTy5dNVteyIeW9A4ZnJ8ksRtrawvFxuzlucGAVs3+8+mzKhyaDj4F+opoZuLf2fW6CIOXfhP2qVqjafv9nhEtbLXcfU8EarIBBbj8RPZjRV8WPr6W2+6TpkszjlOto=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2933.namprd15.prod.outlook.com (2603:10b6:a03:f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 20:15:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 20:15:47 +0000
Date:   Mon, 30 Nov 2020 12:15:40 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-riscv@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v12 07/10] secretmem: add memcg accounting
Message-ID: <20201130201540.GB1354703@carbon.DHCP.thefacebook.com>
References: <20201125092208.12544-1-rppt@kernel.org>
 <20201125092208.12544-8-rppt@kernel.org>
 <CALvZod4MoXod_YkbO+4k2=PS=xdMVbZa2HWWuUnMZ1G9hSr+Jw@mail.gmail.com>
 <20201129172625.GD557259@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129172625.GD557259@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:6c8f]
X-ClientProxiedBy: MWHPR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:301:1::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6c8f) by MWHPR11CA0009.namprd11.prod.outlook.com (2603:10b6:301:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Mon, 30 Nov 2020 20:15:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f1d3a8-1199-45e7-b2c4-08d8956cb943
X-MS-TrafficTypeDiagnostic: BYAPR15MB2933:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2933A5392BBDDBD44467A1E9BEF50@BYAPR15MB2933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFw2mu0Q/5xaFtwWblPc7d2PWZFOYxBg0jDr/XqenwXz3u99bM9acqJomsgPR5WxBM5aCZXp8f1E9jMhHEnhBkyFvcNU/8l38hInIaiyJSc6wcMBiv0o/2dXOdIXaLWlHCWwJIktO9YAR+gGaXQEKzxYFbj9odOUxVOeW9qQAEW70eeDAvQuknrpzThyRLOrBF9uaqPL7yV2Of7mHP5UNa6jyHddWh95WE53cveQQ9r+xeRDZlpNg7erOyZnpt0EMxokJWAlPigOhTjPR7gGV2zdG4hBDdaIOz7S5UM3W7wnVLnJl6/pfj8dJVgCvRjdnsWBeqhueN6TEbbwas92Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(6506007)(16526019)(186003)(7416002)(15650500001)(83380400001)(53546011)(1076003)(66946007)(54906003)(66556008)(316002)(7406005)(8936002)(55016002)(4326008)(7696005)(8676002)(33656002)(5660300002)(478600001)(52116002)(6916009)(86362001)(2906002)(9686003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iqlKOIi4ERXHU7Zr75N4bB44+GuU4q4I8FYiclh5fY/GvAbfOuoM/f8YUfpg?=
 =?us-ascii?Q?6/cFcANL1nVfp4xGxT3aMqGaCbTRhvLcfotICeBRZ9peZlsOgWIl5+Ij2b/n?=
 =?us-ascii?Q?bHxxlJgpwojdK1Mxp4AZhHQvXA+QzIwlpOf6Yd9Grr4ESPjw+SqWEt5J659S?=
 =?us-ascii?Q?jtdL6e6qXjOJs5hKC2QjY2XDEEa6JOB36rTpBhwbHwtmuM7MmuNsou7vNkNC?=
 =?us-ascii?Q?3T63IhemfFLIw9vQ7ITZjHUc186mbqeuaDHEyFdIberhEloiV0vnJi5G6s68?=
 =?us-ascii?Q?uJ1tzp2KSRGr4I6WUAgQy1lUdAUgYbdMEaL3cjp8cuiseIdC7YyFhJINN72W?=
 =?us-ascii?Q?PDMgg7QSGn8+0uyDHjfj7sMI2tpvQHMosLa4/YIRoyQria8orEBi3Yy+1wvL?=
 =?us-ascii?Q?LilFlt4scpTRYeCarn4ZvuQ4go71G0AbPHcX3/pXEQ/sTU0qhLxd9gIrlfyZ?=
 =?us-ascii?Q?rmv804Vx18OS5gP1RTVKDOk+mUUxLAZS8diqejZSchcy2HDrt1BIyAqS86DG?=
 =?us-ascii?Q?PZbyQUsOsh/37xR2QwgvX6ayDusqhF6tBlOhqTu/sjBhODYf3wVWJJpdzzWr?=
 =?us-ascii?Q?98kmD03cHklbtsievGHl5CoCbgbpuagCaIqiQ4e1jEBwQm7YQc+mqjRMA8xI?=
 =?us-ascii?Q?xHBTsHFj0a6uhc1gvurE6C24zqxbyLoU49G3tMAs74vQ94csy2z2r7BYOETj?=
 =?us-ascii?Q?SPlpITSFaY3CeV7kCiWJhL7+ZGjTnpOyfBG5v3CHqpLyuNq9isQvD6rk57vj?=
 =?us-ascii?Q?ljFwk982AoWdOF+VEOIWCk+7Qpzbsn8w5ZLBzWBcbqY6ofnv8ZW8XYSA/8lS?=
 =?us-ascii?Q?KyZVbDUXwvwbvYSQ5OZ41wVds49x/F9q5e/XOvKPoNUNXGUH7e6MgTFJ3G12?=
 =?us-ascii?Q?k7/Rt6bOSXgiVQ7ZQMd4bVPwIvHYIg/873+tjdhlLTyqHprEdU9yWBhEM5V0?=
 =?us-ascii?Q?O6ebtIys0H+9AKoMnERpQX2zFbiiphRLaZ5VA5FZI3saa50oufwArQWERwnT?=
 =?us-ascii?Q?3zla4tmiBEZnteoNG/MxW32oXA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f1d3a8-1199-45e7-b2c4-08d8956cb943
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 20:15:47.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HRyLj7WzWrk8wEPiGyiQ7NpXUvMt3C5xgAH0q9VadSFMowQvih6G/Ng+JbVE7Lx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_08:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=1 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 29, 2020 at 07:26:25PM +0200, Mike Rapoport wrote:
> On Sun, Nov 29, 2020 at 07:53:45AM -0800, Shakeel Butt wrote:
> > On Wed, Nov 25, 2020 at 1:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > when the memory is actually allocated and freed.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Acked-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  mm/filemap.c   |  3 ++-
> > >  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 37 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 249cf489f5df..cf7f1dc9f4b8 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -42,6 +42,7 @@
> > >  #include <linux/psi.h>
> > >  #include <linux/ramfs.h>
> > >  #include <linux/page_idle.h>
> > > +#include <linux/secretmem.h>
> > >  #include "internal.h"
> > >
> > >  #define CREATE_TRACE_POINTS
> > > @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
> > >         page->mapping = mapping;
> > >         page->index = offset;
> > >
> > > -       if (!huge) {
> > > +       if (!huge && !page_is_secretmem(page)) {
> > >                 error = mem_cgroup_charge(page, current->mm, gfp);
> > >                 if (error)
> > >                         goto error;
> > > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > > index 52a900a135a5..eb6628390444 100644
> > > --- a/mm/secretmem.c
> > > +++ b/mm/secretmem.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/memblock.h>
> > >  #include <linux/pseudo_fs.h>
> > >  #include <linux/secretmem.h>
> > > +#include <linux/memcontrol.h>
> > >  #include <linux/set_memory.h>
> > >  #include <linux/sched/signal.h>
> > >
> > > @@ -44,6 +45,32 @@ struct secretmem_ctx {
> > >
> > >  static struct cma *secretmem_cma;
> > >
> > > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > > +{
> > > +       int err;
> > > +
> > > +       err = memcg_kmem_charge_page(page, gfp, order);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       /*
> > > +        * seceremem caches are unreclaimable kernel allocations, so treat
> > > +        * them as unreclaimable slab memory for VM statistics purposes
> > > +        */
> > > +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> > > +                           PAGE_SIZE << order);
> > 
> > Please use mod_lruvec_page_state() instead, so we get the memcg stats too.
> 
> Ok
> 
> > BTW I think secretmem deserves a vmstat entry instead of overloading
> > NR_SLAB_UNRECLAIMABLE_B.
> 
> I'd prefer to wait with a dedicated vmstat for now. We can always add it
> later, once we have better picture of secremem usage.

+1 here.

From what I understand it's not clear now how big typical secret areas will be.
If there will be few 2Mb areas per container (like for storing some keys),
IMO it doesn't justify adding a separate counter. If they will be measured
in GBs, then we'll add it later.

Thanks!
