Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238773CC694
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhGQWLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 18:11:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31726 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhGQWLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 18:11:37 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16HM6omh028552;
        Sat, 17 Jul 2021 15:08:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PqfIwTNS6VzESpI8xCoJIyL92I9iA4O+AxJbIMBryyE=;
 b=Cse/UzYwf0gLJL3TdBSOKg93CLvLndwRBytybt49Mc/+jsz54iiMsPxo5i02sgS3dCZc
 Z+3TI40PzusF9t7GqDl6KOJrzLU093S7wUZyV5seIxk4S7ghcV8uhYTiIwIvwcxU8Wu0
 DedBkCzkdd9d5tLrqCzazuw/P1XP5WbNQB0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39uvr1ja8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 17 Jul 2021 15:08:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 15:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfV1DGhDRCkVlo+pTST9FXy7TOtdEhawS0tjTWUX9fo8Si0FvEi/LsvBmVQ/VGjod5AyeAKbZm9WkWeZxTfKXljHD4ytVFqMQpnX/0XNQd85cDU2nE7JUgINmeYlLQnwaGgTZ0HGKo8/tQ90swAWOA0+ygBnNYaJYSWmNGyRCWn9E/1bIqV2rz55A6tnS1nrhBjtC7uPDSkO7+18hsgcvAcJlU9Y4vn3VXMPWE1XBRNo53h2hpMDkYe9uDOKNZsNyGuvEXKlt5ufV82IgzPSIcSQgrr3vn16c/LqjQ93jtv+aMzkBbsr/BG7dmu3rWUsfvCW+G4LlTzaxIMJPh+yWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqfIwTNS6VzESpI8xCoJIyL92I9iA4O+AxJbIMBryyE=;
 b=fFwV2EUke5RMBQwXF69wAlmLpF/Pruu+Vknxf+/+QdvAsbwECvUv49t/wZmN/6FkVhFwRCYf9uLyShVJjfiXkuM7vtWEQtygumk0YB2pBIrqXF6o5O7nwo1c0sPGr11ojm71T0nwyOdyFjvBjUVifOpoJBaY4JBmSWdnYLnywcHv95ocaeqBM5nbt1fRu39xFzWBQA4u5sKrXoJZeXkkn1kzrthanxXXilgmxqgRtgnMfLWB181wuYZLAkdEKlfS8IwlCNOuYGMYzrhlFFh3xhFoEORGjBuAZ4sUfmMadTFik5mp5WvySATiBwG76Qxgs36g6km+pRyxz8MLraBzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Sat, 17 Jul
 2021 22:08:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4331.031; Sat, 17 Jul 2021
 22:08:32 +0000
Date:   Sat, 17 Jul 2021 15:08:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Murphy Zhou <jencce.kernel@gmail.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPNU3BAfe97WrkMq@carbon.lan>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
 <20210717171713.GB22357@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210717171713.GB22357@magnolia>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:4887) by MW4PR03CA0182.namprd03.prod.outlook.com (2603:10b6:303:b8::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Sat, 17 Jul 2021 22:08:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 314c09e1-ce92-44ac-41f6-08d9496f6a34
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3144775DAC90B89EEAA5FD9ABE109@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeGl+x/IDd4Y0JeN4xwoP93ArwhbVdBgBJNiIw6Sj0l6Qkmp8V1l1ZPolQSLLfS6At6uYz33WjvN9qb1H7e7K5zapkL9K91hk4Zo/cs07/+8VRfI6Rhwf47rMBSNSFA1ZkftObCSwOqjGz56dFD8S+h34PoX3dR5opfCviBkMqdvHRoLktfqIq7vUaXmjNpPn9VdQAaA5D4CvoRGEZr14g7UqIV1MgkZY2jwpE+mpFVS7urajY4r5l8JToKtKNXfuiiVLnu/HNbQB/ERj9382+MnZXM5rApxMioIzWaaZtT+lADubrdg9Gdq87s2tf+HG93RncYT70fcE/ymx09iGjjQBiQmJRD4TQXpzGXJTXmqUhwQ00XcJYqX4Eocx/EeR8TEG/1iKfQwZ6j6llQLBlUCvni0IJP8S9XnXgv55X9DVM4MOtgPxPRmk8iXwvt/5pG+jGRKt/n7Sd50kZlWH8+qMRqCxdDLh5TCrol8biZ2CK3OACcGCXXXhSzQY3UYfTssaHWpyLGq431KSsFxzxqpEQUIL79N/OMCzdhqs5J4veVak1mYSdChW2s/9BYZWVZto6sSSU5lz9DrBiGN+k624gfhH2hpFd3e3+eB/Xw9pGPth5k1bJM4EAHkSZbwTyVvzB9y2gkJRTK+wAkzQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(54906003)(66946007)(186003)(478600001)(83380400001)(66476007)(66556008)(36756003)(52116002)(6916009)(5660300002)(8936002)(4326008)(7696005)(8886007)(38100700002)(2906002)(86362001)(6506007)(55016002)(9686003)(53546011)(316002)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjI4tXjS5PEdU9CrlO0If17yiWok3IJ3g46t9zlAMnLnZ5zLPxyZVWwoNrY3?=
 =?us-ascii?Q?+n9JkjyZvLfs5l6Z2RiBx+EKD1kWcScEn1QMDWkg0rsEfIrQf26qPWGVp9zh?=
 =?us-ascii?Q?HaEcHNYBy3GGbPIjAkEB/On3pVGdVBeuj1zCh7SJUg9nqYAV2Y2/5qNDWpnE?=
 =?us-ascii?Q?CmK6GR/aCEYOVB96LDfiwZpkp1PG2vqrJegbXrDa83+7HBPCFZp4D59M847T?=
 =?us-ascii?Q?Y/3VpuoApLsJ4Jlr0k0tE2z1Lrww47FqEuXqNiFKA5jxS8qPtwJhE1E2UZ0b?=
 =?us-ascii?Q?U08fDylf+g+EaM+g5rW0846HUGdTzdXVnXAJna49pF2LGBEIsztHjKZiXmCO?=
 =?us-ascii?Q?n/y+9I2amCyfcztFnkDVbJlzlpZNgx4rMbZomF5T8m35ySR3nYs+pVs6fsmF?=
 =?us-ascii?Q?dkZvyeLxmARVRzA3VyJpC0QtElQnXtIcwcHDaGwcBpOH3plbkeTYsXokXioR?=
 =?us-ascii?Q?yYBNn0krmJCu9pts/0GecOJsuWQ5EvIZiVtMOG3S6TKhcJboMaWNpzbaa0Uw?=
 =?us-ascii?Q?hhh/bnSpro+CsrNVx2vafRSfXhVMtaeMmruVX8WR33fQ3W8SNf4aVYHQ+Wsx?=
 =?us-ascii?Q?X008Gaal+DmZuB8M70Iy5KPfNYDyEOwaGaNSqF2DKWbdD8fI5fkgqtDT+OPF?=
 =?us-ascii?Q?GHxoTWZ7RzccdHJpvPS40o7gWb6+1vlcMBsvZ9knqo0/BJb9GE4PPYXpu5vT?=
 =?us-ascii?Q?pJ74IN/QBgc/DtG3G2850HbGNqfykX/ZVEYZaORdZvGc/5KL5pCQMWUH3eCv?=
 =?us-ascii?Q?7KZffHr0DB1iYl7SX+bMyZ/bahN/90mC//Euyk4I8NfQj9z1VVTB+YUAnyV9?=
 =?us-ascii?Q?CYUg4HIVZIQDsiBA22LGc1WPnl00GSQrgBqGSKhkIPJiYpQMRxOBwesrzcpA?=
 =?us-ascii?Q?yET7oAzo00N0HHHkht+kQMXg0pQKsG38NUoL3eLhUsKkyxnbcdOpS4RIHzzM?=
 =?us-ascii?Q?o9lDlVCahqUabBTMCVrQyo6BeVkoH0KxKR/vhEeSmocwUooj6GvwKk7Gc4D2?=
 =?us-ascii?Q?/4b9vw/Rst7rsPtrxWHlmT5gpneYX+JGQuXOGY4Yhx2pDkxfUU1FBz41asNZ?=
 =?us-ascii?Q?DOGhVxzZJ5XG/9sdBxhpg4C1FDYAuY9ziTAmrD5I03TKEaGxWPFMCacz7h47?=
 =?us-ascii?Q?kdBIIXF7d6uDPeMIgy54U5FusIlqSCd7QUShVCkXtf9K0JwpcT25C7VprqcH?=
 =?us-ascii?Q?jJfuuSTu/t3YQIa78IdJDfUK+J/i8VfshQ6NGuo61ZAYtkBk+Cac5D0h8gY1?=
 =?us-ascii?Q?yMPjb7suqkcROGmCM6g46Gq1+jEjM3R5zBcQALyq1j1Yyy0jFNcGV7w+hp42?=
 =?us-ascii?Q?kzFlIX5WpT9Y0kEx2AJ2Uy5g3RCETSU+AdIwLzL6yevnpA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 314c09e1-ce92-44ac-41f6-08d9496f6a34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 22:08:32.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0IEfSgnrLkjqCz5+AkzulzFkGVFu7br+JGVKUVgk+RsCx4ARXuoqxHBtx2voWI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OXrf9e2jh-A_xzgTB9X6WJgaCwkr6N3O
X-Proofpoint-GUID: OXrf9e2jh-A_xzgTB9X6WJgaCwkr6N3O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-17_07:2021-07-16,2021-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107170131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 10:17:13AM -0700, Darrick J. Wong wrote:
> On Fri, Jul 16, 2021 at 01:13:05PM -0700, Roman Gushchin wrote:
> > On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> > > Hi,
> > > 
> > > On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > > > Hi,
> > > > >
> > > > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > > > mount option:  -o dax=always
> > > > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > > > can hit this panic now.
> > > > >
> > > > > #It's not reproducible on ext4.
> > > > > #It's not reproducible without dax=always.
> > > >
> > > > Hi Murphy!
> > > >
> > > > Thank you for the report!
> > > >
> > > > Can you, please, check if the following patch fixes the problem?
> > > 
> > > No. Still the same panic.
> > 
> > Hm, can you, please, double check this? It seems that the patch fixes the
> > problem for others (of course, it can be a different problem).
> > CCed you on the proper patch, just sent to the list.
> > 
> > Otherwise, can you, please, say on which line of code the panic happens?
> > (using addr2line utility, for example)
> 
> I experience the same problem that Murphy does, and I tracked it down
> to this chunk of inode_do_switch_wbs:
> 
> 	/*
> 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
> 	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
> 	 * pages actually under writeback.
> 	 */
> 	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> here >>>>>>>>>> if (PageDirty(page)) {
> 			dec_wb_stat(old_wb, WB_RECLAIMABLE);
> 			inc_wb_stat(new_wb, WB_RECLAIMABLE);
> 		}
> 	}
> 
> I suspect that "page" is really a pfn to a pmem mapping and not a real
> struct page.

Good catch! Now it's clear that it's a different issue.

I think as now the best option is to ignore dax inodes completely.
Can you, please, confirm, that the following patch solves the problem?

Thanks!

--

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 06d04a74ab6c..4c3370548982 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -521,6 +521,9 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
         */
        smp_mb();
 
+       if (IS_DAX(inode))
+               return false;
+
        /* while holding I_WB_SWITCH, no one else can update the association */
        spin_lock(&inode->i_lock);
        if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
