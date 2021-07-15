Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02863CAD97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbhGOULc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:11:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242601AbhGOUL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:11:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FK1CPu012029;
        Thu, 15 Jul 2021 13:08:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tvyolxMH94/pfvM8LwSP4byT+OuM4yOxkMozWlWPDEk=;
 b=Rud8+M7GDOuuvTC4OeyZezntS783Z/HuxU1EkLGV2JV2bO5fcMNQE+a9oZHPssKpnzrm
 hYI9njs/5x4qtmyJO+gtDZ/QRrt3N3TBa15VOo4vVcWejMoG6dT3FdtPwj4VUWQKqRsr
 7qkMB9cX6tJGjv0g3xlzt/2vqLqwsQfevzc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39tqth1pxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 13:08:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 13:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ67sNfiaFkuhMRU/y9uTxA4RjSKeBqwGYPnlSrN9uV68bQIrf383Lwidb+9kjh2WFf/ByJlXDWfZAnQrQIfimTeVlsQjD7ygx5YdaHUCwH3sQ7zHnLgGmqcYKBCuMBwSWImUQqxD63NFBqgJmE4WbS+zJ9z0Z3D53293IHXV9k/ZjBUwi9RpYBE6Rkluir2OUjNuesx6bdq0VaZDz2Y/RO5mSJcbaaNdPCjNlgMgowFCqbbY0JDyJBBrPFMr6aksaUH+57O4PrkmXqlYYBIsfjKsudLEtYdrqMZc6rf+jh98yZH+G0q54BZDLkCa3yXndg3hk2A/DnYlD7QZ/6DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvyolxMH94/pfvM8LwSP4byT+OuM4yOxkMozWlWPDEk=;
 b=Fn6whdGKdnaqTKTGUyGfzRq9U4WTQnihnt7HEPOudCdcproKyQ6dKtl2OkKrt7ak/cF2Rp6ykJLOV/ltFX+vl/qT0aGANuxr3Zmn86Vjm7ej+M9XCoeRSfEVdS05/mKvyx7vakvZ+VmJh1Xu/9GsMCxe20Fp3pNoaUx3hy+sI7ulkSU4XYPfCFiNZm67+uy3AoSoCNMxmVDmYIBpqvN6koU04cZyR3OVyOalZUweO7gMc7pvznOJ3afDeQd0GOS5a9B4/Jg5zmV87705uaq0vafnn0xYxfCg/5iMwPenMrQ/VwOlPSKriByTaMvEsAJiWe+8N4Al2kwaJPkTvjGzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3398.namprd15.prod.outlook.com (2603:10b6:a03:10e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 20:08:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 20:08:17 +0000
Date:   Thu, 15 Jul 2021 13:08:15 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Boyang Xue <bxue@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <YPCVrwov6R9yaBcG@carbon.dhcp.thefacebook.com>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org>
 <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
 <20210715171050.GB22357@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210715171050.GB22357@magnolia>
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cc18) by SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14 via Frontend Transport; Thu, 15 Jul 2021 20:08:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a6288a8-6c16-4542-6faf-08d947cc4909
X-MS-TrafficTypeDiagnostic: BYAPR15MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3398475541B9A71BD3E7F1DBBE129@BYAPR15MB3398.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faak/wcKVBeM6AGotDJ5FAuDuvSlB/YKvKbg+rh+k3d1CMmcC9pIYD8sEdibahcEcpZmkBVX5O+mVuN6z5SpwjhVip9Zd5nSFy10bwk81zjoRPQD4rhU03sGeeByZ9us2gxNlL11rfMJ47X7cPSTISFGxj7LeeK0fZ2LenQmTflwTwkS9dYr2n4ImDqTinGOJ+e+8CDefdEu7c45PvPVhKx8OPCXm3KJnWUO7uFKQzQih0KpXF8uAhCHLMvJ+TsBHxZAcuSpS8D8kqgliXJMkVxgvfzoEcKP0VhpAUz28UNN/iOjR4MeNM+8wB6ggABKGQ/VZop/j3FaeWnoc1GC711zvdhceFoS3A4cbvqlYKSVs+i2yBABHpwLdQLn3y8V7hamGtWJnQg2fQhegftzB+2b0a+bFFj5KB2Trnf2CDdgyJDj86L7sEWpZOTS5N/apIZFA9IXY+6k7mSxwj9+jLxucJzeBVzgz8V3BpV0sKlHBxD4c0lcmUCcWw1uNBhX3moS3Ob6QX5QTwcn3p5vtdqJD36uA958nUuX9tpfpgjTx968oGGZ1dRGLdVBmsOWthxbvn50nmBfAZl7KG2fxzVEgm41/iskDeWQM7f4H6DZI0sY87sIRF+RXngWyWFg3S9TLDZYWejtHrvGG5QLTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(54906003)(8676002)(316002)(83380400001)(5660300002)(52116002)(8936002)(4326008)(66556008)(66476007)(7696005)(6916009)(66946007)(2906002)(6506007)(86362001)(38100700002)(53546011)(55016002)(186003)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dehW6t3dIpTcePgPTXXr6z9yMUoPlmF9o4Lz4xVgXoGGjC2TXpUb5gw2/VJr?=
 =?us-ascii?Q?ZUouLYSqV/uj5eo45PtVqBqD65nzG1akg0e6K7h5eCWpt8C7P4zPUGMxaVMY?=
 =?us-ascii?Q?SQpLfVjEfGM6R5EPlxuO21AnesdrxVkxDQzHLDy8whXKDdKxjoodAfSvN/zz?=
 =?us-ascii?Q?D+CnZoZlcl59YRceQmF60Bj2nyCXezEeLyznrKtOxliwJ95z8INC14jjEbs7?=
 =?us-ascii?Q?oWbM5muvTNxxhXzdlA8yJYDX1WxsN8oyF45XwSVLFMIPoJZNX5yl6OgCUfs2?=
 =?us-ascii?Q?VVNIEL8SVxlxojbi0xFZYgTfD6JZcYBFIesktylXssrgeADLJW8KSncocA7k?=
 =?us-ascii?Q?Iv0y2+UZ/apyi6lhHy+rx9zXKY8FqZRJCtJ41FHPrJPoN6pXjf/5uVM20ACI?=
 =?us-ascii?Q?Y9BV7czaGLPNIJQugzBd9ghDk4EI6egAu2EcL/wrqJhQEnr4MXfbdIXsLeUn?=
 =?us-ascii?Q?wg4+VRJk9qRlPy8jvLl5n25TLG7sv7bO8WsvRcvKd3WOxgXadW82l+2HU0Pk?=
 =?us-ascii?Q?buSkf6rdrPGBtISNTAKatUDlEArYlM7pYC9DWFUaHUhRwzfx935bqMLS+4YC?=
 =?us-ascii?Q?6ZG97r3jW3xxkXWTVkCsSRi2L2/2ceaaQgr/jncRHSGQ6usD0cRH4dLolxhe?=
 =?us-ascii?Q?MR2tSguIwupkFgmTMJeifppfraSSHl4j9hvPYyY3lx4odhjjwnJ/6gEF+fbo?=
 =?us-ascii?Q?usNCjEw86/lV2jq/nzzZeS+ybS8Og72lGjPfUsXYylXNGs7vvZrjEYnPG/kw?=
 =?us-ascii?Q?R3j20jc6EPWvguuNgXB0jddYWE2wvo/naSIkfzIGonpkv8FAc3mWFlp0kvNg?=
 =?us-ascii?Q?JxOMWuSmoHKsNsf9qBxzvtwA4T2NtHRCUxRFo9KMQx0Rhq03LHZmuh4Mk3a1?=
 =?us-ascii?Q?5+I+LiuFoPVLmbfZglcjgzYEO5OPLp7xeHsoRVCR/dpEVtC3CnbySBlk86Ln?=
 =?us-ascii?Q?jrwI18ed1e4Jz+S7BeoKV86yZOJbZztf65RcVvKVnUOt3mKmOl6LvqqWnQFv?=
 =?us-ascii?Q?xDr/dqCpE1RGXYpy84Rv62m0vwAhC4SrdOiEis2lw2t8KpobIBt/ONvY0h+3?=
 =?us-ascii?Q?vdMOxSJ9SGOCGJ4jUQA0gXx6+nAYcEDz3JRc39jcoRypvDoCF64jn5glGcoR?=
 =?us-ascii?Q?p+jMdFrTUyWjxfTxX8QhODCcGtzREVgT8kM0wNukvPxouRfKQAnMwmVIcbt/?=
 =?us-ascii?Q?PpPWPAbWVCTF/Dg/sPtk+AsojVCsavY4XmHYCWkkCjiaEQEtbXwVg2rrcQkk?=
 =?us-ascii?Q?5HNhlPEgixAaD8WabxZrMV9zmtFQNafMOTLsM5Ok1JY3kR90IZPl8jxsIOlV?=
 =?us-ascii?Q?zKS/z29D+DMhPRrxPjQz/Jh3Q+KktgYdkaehDTHk+Sf1Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6288a8-6c16-4542-6faf-08d947cc4909
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 20:08:17.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3rCd8SjHWgauFoHMUOD9sipSNIxlPTdkYTM2nDwkz+mdBFFAMnXXSUqxxHIdNUe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3398
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: CpyVdLH0Fq2vqPdJv6oDYx6h7nsQQlH8
X-Proofpoint-GUID: CpyVdLH0Fq2vqPdJv6oDYx6h7nsQQlH8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_15:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=867 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 10:10:50AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 11:51:50AM +0800, Boyang Xue wrote:
> > On Thu, Jul 15, 2021 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > > It's unclear to me that where to find the required address in the
> > > > addr2line command line, i.e.
> > > >
> > > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > <what address here?>
> > >
> > > ./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394
> > >
> > 
> > Thanks! The result is the same as the
> > 
> > addr2line -i -e
> > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > FFFF8000102D6DD0
> > 
> > But this script is very handy.
> > 
> > # /usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/faddr2line
> > /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > cleanup_offlin
> > e_cgwbs_workfn+0x320/0x394
> > cleanup_offline_cgwbs_workfn+0x320/0x394:
> > arch_atomic64_fetch_add_unless at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
> > (inlined by) arch_atomic64_add_unless at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
> > (inlined by) atomic64_add_unless at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
> > (inlined by) atomic_long_add_unless at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
> > (inlined by) percpu_ref_tryget_many at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
> > (inlined by) percpu_ref_tryget at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
> > (inlined by) wb_tryget at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
> > (inlined by) wb_tryget at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
> > (inlined by) cleanup_offline_cgwbs_workfn at
> > /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679
> > 
> > # vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
> > ```
> > static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > {
> >         struct bdi_writeback *wb;
> >         LIST_HEAD(processed);
> > 
> >         spin_lock_irq(&cgwb_lock);
> > 
> >         while (!list_empty(&offline_cgwbs)) {
> >                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> >                                       offline_node);
> >                 list_move(&wb->offline_node, &processed);
> > 
> >                 /*
> >                  * If wb is dirty, cleaning up the writeback by switching
> >                  * attached inodes will result in an effective removal of any
> >                  * bandwidth restrictions, which isn't the goal.  Instead,
> >                  * it can be postponed until the next time, when all io
> >                  * will be likely completed.  If in the meantime some inodes
> >                  * will get re-dirtied, they should be eventually switched to
> >                  * a new cgwb.
> >                  */
> >                 if (wb_has_dirty_io(wb))
> >                         continue;
> > 
> >                 if (!wb_tryget(wb))  <=== line#679
> >                         continue;
> > 
> >                 spin_unlock_irq(&cgwb_lock);
> >                 while (cleanup_offline_cgwb(wb))
> >                         cond_resched();
> >                 spin_lock_irq(&cgwb_lock);
> > 
> >                 wb_put(wb);
> >         }
> > 
> >         if (!list_empty(&processed))
> >                 list_splice_tail(&processed, &offline_cgwbs);
> > 
> >         spin_unlock_irq(&cgwb_lock);
> > }
> > ```
> > 
> > BTW, this bug can be only reproduced on a non-debug production built
> > kernel (a.k.a kernel rpm package), it's not reproducible on a debug
> > build with various debug configuration enabled (a.k.a kernel-debug rpm
> > package)
> 
> FWIW I've also seen this regularly on x86_64 kernels on ext4 with all
> default mkfs settings when running generic/256.

Oh, that's a useful information, thank you!

Btw, would you mind to give a patch from an earlier message in the thread
a test? I'd highly appreciate it.

Thanks!
