Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA013CA1D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhGOQIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 12:08:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239679AbhGOQH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FFtqFs001562;
        Thu, 15 Jul 2021 09:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SJUytFywaT4G4TkEeYkufHasi1NXM4eKmvYa98h6cdw=;
 b=EXYx4FmPQUiaT/19QrIMxVXjKob4emihhfp8JQqnys7VA2gWzqC3UrqYv1tmvFFf5FnO
 lZbh0NjfNZrfTb3vFnLJ/XOfBJgZq04TKgeWcMtaapUOgiQqzprO6BdRo/oseRVEcPYc
 Tfc/c/Do87SIeSrUeSrFLUimXJ3rZiL4sRs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39sx7f903s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 09:05:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9U77T/To+HaszRjNjSxloDeeUK7Gd9wnEByfnWcDwEEo/0OqDjMvjnmDvVykIc6IWoA346eKztt1iSpzV+vG8fsZhG1jQjvuaXJ59Xkjm0VHzJQrMQzBiKS8WvSBMjF2kwrFLVp0zjgcFUA/LHI0b0/bhMHIRPdmSU4qLnL82HgsyBx8wLedP/UrEj5XKWzVc4U60MY2kt4Jb9wUGe0QJvqsqx3ZFuTAIQQAZhVV0lk3jjwqWl45avtY6QqwL+mb5BG75V7CLgfRQouUFSlWH9yuQMPgO0nUZJqQVi4W5n+6Jg0/L2Qb29LLtTdYFVRRxHLpItuoTDzorKV3WC/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJUytFywaT4G4TkEeYkufHasi1NXM4eKmvYa98h6cdw=;
 b=CaqqWvzXRYFGMVRExguMKKZvFm5gcDQ+GSDn2KDx/cqWWXcZoC0t6B3JhgNtr4Wo2M26KWjajYlBQTCsamfIJa7yonzz8LHiAFrveLM8U9UGktYdNqHSx9NPThIQMDHnjGxdb0fyDSz7DXBGWgDdGOiJOcmHO8y+/ZMZ/qAsnRw2E7MGRwUJVlLSkjW76GiNrLrtxZfSc+oc+SaY+pCVULECWkcVU/gQxBoKt1HNBCNCdJ7Fm9b+7UCaGE8NTMG55VSl7KIRY9ytGEsdB7ZrYQcv7lkAhC0jEhgOZVeh45Iib3YUXI/2Bz1WM1wYSqDkr3XL7JNfv/tXrezvTMnu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4407.namprd15.prod.outlook.com (2603:10b6:a03:370::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 16:04:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 16:04:58 +0000
Date:   Thu, 15 Jul 2021 09:04:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Boyang Xue <bxue@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <YPBcqIAjaGtTAskK@carbon.dhcp.thefacebook.com>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com>
 <CAHLe9YaNtmJ8xx=A+6Ki+Fc2Kx=5jL745NJ8PL+w95-WhJrG3g@mail.gmail.com>
 <20210715093117.GD9457@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210715093117.GD9457@quack2.suse.cz>
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:1f92) by SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:04:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b50dd4-b706-403b-251a-08d947aa4b75
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4407:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4407EA1BD9A223AF445D1EF3BE129@SJ0PR15MB4407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2ooaPNHm+9b+NycqHW0+THoIhrkgAKSmRI0Gilmg9ZaHGK+H//iUOt5hOm3q+wXoxXbWcopP9AwshqD0i9YnSeE3gWqEXFDh5oxnc+JHSwhQYxuyomZYwUMDrP8auWzdjpi4VvYnyThSukmD+u9pWSl2nxujiAjcF5P8drnOJYsGszdk3/LAo/Wt+y8zD/lOIk+pc+5joye5DfpvnkgOBQ6JfnVowR0SLE+P1LYWI6ulB4wJF8DMW6oLl4ocDoz6HURrRlK/dBvuWfwmZmLEShGqD3NyVmilFrRk7sOyOKcQf0ZT+2E4puXJj3CtULxHB+KkQcNb7iM9/2doMMTGp68yuF7bojbtF1zFh6pV3vWtvTzvuzbtGwNuXVNTsVkncAFuv9FDV2M+Cq8dfVPZpbB0BSh5CfPQi8arRiTXMuK0uvGmOB5EZCF2cwwzpWEly3Q5HUnWTjl8C0FGLwMg3dZqHjUq/JZ+GYy3s2PNhwnmYhL6eDv7fTNA8QEBHM8E3pS/Eq8E9DuZNXHkmAVxcEu+Ex0Z+U/CgHEdydzfkvDrnkqLcDJ837sDr/o+t3L1ZzxUxfUVwsAcSq33k084uFcL9IjVQM4bO2MnvN4vPM5RNEzeYBbIqhFpsvlUu1XMpCsMlpD/rD//93sFTsk0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(5660300002)(83380400001)(52116002)(86362001)(4326008)(8936002)(110136005)(478600001)(2906002)(55016002)(7696005)(66946007)(316002)(66556008)(66476007)(9686003)(6506007)(8676002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpisYN4Gc1kW6MxiYPRcT9Q83laoGHzbQNC8NUf55s+PWy9XYc4o9/jBVjkT?=
 =?us-ascii?Q?V6PH4atarec+zlXXAooZud1yEcXTWYYr2qynwBlBZdxHA8H0W4mB4NGjK43m?=
 =?us-ascii?Q?NUYG8BEBh91ROpRF8/HfoCt3ykrHJ+qQTNGUBMknDojPlaLURrbVz+MH30Xh?=
 =?us-ascii?Q?J1alSFrJHRW1KfU9//9qJoVNYbi5Pc6PTodThbJXB92hsgg4x9j2xrbQnot2?=
 =?us-ascii?Q?fDpJSR6J+dtdAiC7FqW1rKkHjiYm+woSW/5xtBB9ZYDOsLUwKiXdi2djq1cc?=
 =?us-ascii?Q?XbSmKHC7eZzuY9RfoaMc8TNq8M7Z2HTRf1korEeKH8cCz1m85mYNtVf6hN1U?=
 =?us-ascii?Q?GGmxZE4j4ww4gQPlqiok3VhDH3qQgOtygSNfkL/e6+ARNVrk5SDf5jpvbv4M?=
 =?us-ascii?Q?vB7iAAhc1L+rQlPWOYpg91WuusNy0f1HGwZ62bokQ7Zdm4u0gpwYTnzXYWPm?=
 =?us-ascii?Q?cd+0rJu6pXc1a03L3YI7nCBpyqVu5t3zFKe+u/GYrAgCQ3YvM4ZMsYKlzvV8?=
 =?us-ascii?Q?S3tsVA7tBBG+HBpaKrgn2bhGX3B2Usq4huV1pPfGpngMGWIDfFwW+pgZ3R+P?=
 =?us-ascii?Q?wRwsNhQw5lW0iBtaImcKEIIXYWwHLfJ2k0fpwC+rneIapcoMqnF3e0KIJeqL?=
 =?us-ascii?Q?F+F1LVYwO8eLTuqcP0J8R23TDsuElnGDIYLHwsKrboanUR0lLgwLytYtcZX0?=
 =?us-ascii?Q?VYpYYaRFLNuc3sx1L+fLGAEm83VKzrkPlahaKNtAlk3V4y1m6S5cGnzvJ3Qq?=
 =?us-ascii?Q?cT+5NXTY6g4umRzcO8EXYE3qb33WW8dPsdFhBHRqdaRygKB/OZCQvNbEz+Cq?=
 =?us-ascii?Q?6noisRS3cXhXc+7/kKDIpzqtEKKxe/5kgkLZGBbqpVeZu2D4QDmlv6Z2bN3K?=
 =?us-ascii?Q?7hJH1opsFXFSb/l3lpUoa2HB7sR/u0yCkRd27vpHoXg30g1WcgSuF4QMagsf?=
 =?us-ascii?Q?WMACfOgm6ZWWGSHGRFH247IfvNVHw/yJGGI5xluXSZUG3nIOUDfXRWa4lYQF?=
 =?us-ascii?Q?QK49zc3GOVw/wKa9HirSWpwQK0ehkkhbaQl1/FL9uZ16ca+fsBfWQu9UHhFI?=
 =?us-ascii?Q?NHa4YSv4z/Q6dkIKiNaZPHP8hUWZpzwkV12UMjbRv0XB/xH3S8w+1VpVpZvA?=
 =?us-ascii?Q?eLwKSZXQVYpW+rrkKdlnmZqNK018r36uPBY4RauErjsaf6gIA9uNlHCeZq8T?=
 =?us-ascii?Q?Pa0YzP3E0fme66XM5VNRA9XOcOj8X53nqsr+i092Iv1dp/3QtP1C3hezCUut?=
 =?us-ascii?Q?4ZOSGspJmhLLnwSvPt1vFSzBJBE2SYxoLNWl1XOb/Cl4RDYzAvUXcLuxv8lE?=
 =?us-ascii?Q?ePboteuBumGaWp/sNku5+zhu2N96lplEc0QtnhXINf6fGQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b50dd4-b706-403b-251a-08d947aa4b75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:04:58.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uug6tb5SUvf2G7PY6IWpKWEwxyq/deIyjfjQy8xHWnT9JLoVDoDE75xjH6f8dwug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4407
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: aZ0su_cuO8UR0YVyS7ApYbagAmnp6Ywl
X-Proofpoint-GUID: aZ0su_cuO8UR0YVyS7ApYbagAmnp6Ywl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:31:17AM +0200, Jan Kara wrote:
> On Thu 15-07-21 09:42:06, Boyang Xue wrote:
> > On Thu, Jul 15, 2021 at 7:46 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > > Hi Jan,
> > > >
> > > > On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > > > > > Hi Roman,
> > > > > >
> > > > > > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I'm not sure if this is the right place to report this bug, please
> > > > > > > > correct me if I'm wrong.
> > > > > > > >
> > > > > > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > > > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > > > > > it looks like the bug had been introduced by the commit
> > > > > > > >
> > > > > > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > > > > > >
> > > > > > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > > > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > > > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > > > > > >
> > > > > > > Hello Boyang,
> > > > > > >
> > > > > > > thank you for the report!
> > > > > > >
> > > > > > > Do you know on which line the oops happens?
> > > > > >
> > > > > > I was trying to inspect the vmcore with crash utility, but
> > > > > > unfortunately it doesn't work.
> > > > >
> > > > > Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> > > > > can see:
> > > >
> > > > Thanks for the tips!
> > > >
> > > > It's unclear to me that where to find the required address in the
> > > > addr2line command line, i.e.
> > > >
> > > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > <what address here?>
> > >
> > > You can use $nm <vmlinux> to get an address of cleanup_offline_cgwbs_workfn()
> > > and then add 0x320.
> > 
> > Thanks! Hope the following helps:
> 
> Thanks for the data! 
> 
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
> 
> Aha, interesting. So it seems we crashed trying to dereference
> wb->refcnt->data. So it looks like cgwb_release_workfn() raced with
> cleanup_offline_cgwbs_workfn() and percpu_ref_exit() got called from
> cgwb_release_workfn() and then cleanup_offline_cgwbs_workfn() called
> wb_tryget(). I think the proper fix is to move:
> 
>         spin_lock_irq(&cgwb_lock);
>         list_del(&wb->offline_node);
>         spin_unlock_irq(&cgwb_lock);
> 
> in cgwb_release_workfn() to the beginning of that function so that we are
> sure even cleanup_offline_cgwbs_workfn() cannot be working with the wb when
> it is being released. Roman?

Yes, it sounds like the most reasonable explanation.
Thank you!

Boyang, would you mind to test the following patch?

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 271f2ca862c8..f5561ea7d90a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -398,12 +398,12 @@ static void cgwb_release_workfn(struct work_struct *work)
        blkcg_unpin_online(blkcg);
 
        fprop_local_destroy_percpu(&wb->memcg_completions);
-       percpu_ref_exit(&wb->refcnt);
 
        spin_lock_irq(&cgwb_lock);
        list_del(&wb->offline_node);
        spin_unlock_irq(&cgwb_lock);
 
+       percpu_ref_exit(&wb->refcnt);
        wb_exit(wb);
        WARN_ON_ONCE(!list_empty(&wb->b_attached));
        kfree_rcu(wb, rcu);
