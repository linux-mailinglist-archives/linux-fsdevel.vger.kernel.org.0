Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB63945D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhE1Q17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 12:27:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9810 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236661AbhE1Q15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 12:27:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SG9DXB002422;
        Fri, 28 May 2021 09:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xIeA5yz6KfOxenLYSWbuwhRKLR3xoWUpQeF2uv7plk4=;
 b=PIbv+/nFVbvRClTztpUBFE1TO17ol0cfQA4vnKNwRLDm8sfVKvTJtqsFNopGM7pMaZd0
 D5AQSApARMUxUWGLJ7HezqoI3X+OwkAv6MnzF/F6z3T++Ng+9LkorWeqrPbbLWikbcH8
 OB4OSJccfYaTN7YlpPlIr/ka+R0Nxn1Cn1I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38tp47bwgd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 May 2021 09:26:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlZGkcIJg1TNSHsKAgxEFPGC8PfeQ9F30ugZ0yc3+gHK/KLFpmnjX/IbNYjONIrps+ykJuX5exUTH+zX0UXStu9ral2w0aa8n63auWh92XGKynBh45CRbzp0gU0EhbfyPlTxYUI2cDiGx+VDCVftAeWoEuNHQxTNDhXxgLqAKzp9u+wWogUyymoYQw5cOX/s0JqZ9oQsLN1rb1ktJ2klNfBNJDzenfqBFYfqHdWG1dIwyLlOK8qzu2vqcim7vkGXCzLksaYLrWuELfYAeB+1dwN3xKfkd+CnG4D7NOTk+ogv4YN8W+O3cILsW/2QnZHRxpTtjl+NmiTCghEh+NRktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIeA5yz6KfOxenLYSWbuwhRKLR3xoWUpQeF2uv7plk4=;
 b=GUgFwpy3R5XoAlT90w8wcg28IZ6sOFWlWay+t1rgdw898vU72NNjf+Le58x1IajSaIr6Bj8oBQn1RB8RhpxnNAsaX6LzjLu+XU9CwKaqkZrbS2lhB60ka2s2TKFfdzjuCc1/HtFAIQr1PjpE2IV9eIy8lR2RfFYVHpkgpQ2cQHhPD4CtLikxW/DxdbzUD1BR4s4bNb6y0zdy4IPazYd7OTe9jWKuVO/AJCFHvIhPYunsEEKMAiFpXHAS8dcXmp1Av3CmmJZdVKDQL3nDeiPu3GIXUoC2mctR5yLklh8LZuclQFCvTDawb6PHCxvEgQ6BnFv5Rid+7jD5uFJgtluZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4867.namprd15.prod.outlook.com (2603:10b6:a03:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 16:26:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 16:26:03 +0000
Date:   Fri, 28 May 2021 09:25:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YLEZlpUMc03uYM7V@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
 <20210527112403.GC24486@quack2.suse.cz>
 <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
 <20210528130543.GB28653@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210528130543.GB28653@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:17b8]
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:17b8) by MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 16:26:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c20942-7336-450e-cf24-08d921f54950
X-MS-TrafficTypeDiagnostic: BY3PR15MB4867:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4867EDEE156BE4E1AD6C8979BE229@BY3PR15MB4867.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi9CswGEg17e9lt+ExprvOUzQj9KcvFCtBjmxHJ+531NzC+E1G0NPRVv+hS2wPgR3QmUkgzNGCEbVxjHPRQrvoReJO3p/xCBUzJ7Qs8cgnIYqXmIyyqFfwWmiK73mJpWsgDzQPWdaGEQnrj72y+8lR+56/QrEKGjCB1Xpg/KsduuIBoFWDsOIxcXgrEGeOsVmqiVs0cIWVQfGtCH6elvO65vz8YyZxpCqnrd9SHHRCG1uW/szdA+AS5Z4tLDm5mdxpdAiiRifDKb2Wa/nXs4ZBOb9EdS8jv7gxmGXLB8Cpu4t4emfjOs9GkqQBGXDhspv0pEmz0hZ3HrnGDGGpViIgsNIYBrQXIjoZpm7nerL8WmIKhEUwEeHFiwkaE2blvtGynM13EycKDdkeIMdSokIoUzJ2I+D2rOYNikDyKhEvjpA9Rug2fRh7bwmVJ9oCv65q5Hhy5Zn2Bmu7vuOtdu/BYrfSVNYs5f94sgNDsnJ38kZ+y+hdYhFmvK8B2UBpsK2JlRhgNUyOEiPzEPFX+tMVxzOMV+IWT74yyS1BQP5/ws1dTCy5s5dA42Q4umRR/O5b++sps/ZaUAdSSzt/QsnrtUMszxeTuai9ivewn1/4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(83380400001)(6666004)(66556008)(66476007)(66946007)(4326008)(38100700002)(478600001)(6916009)(55016002)(316002)(6506007)(86362001)(2906002)(54906003)(9686003)(186003)(16526019)(52116002)(8936002)(5660300002)(8676002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OPIxRiFDcbOQm7qqSSf4i4Pf5YX5JDpyqGBGHONuQVJ91DW4xJLQTWumFW9E?=
 =?us-ascii?Q?O7Tw3u+W7PKN3x8PQKzVSpddvjge8R1PRJm6QPGQ1x75xXOCM/+KsEVMd2UZ?=
 =?us-ascii?Q?4xdgswSyXmWMKQb1cYKh4Y0UBj7R1mfhvpnOV+5AtDAx5NEd2RyhPR1/J94Y?=
 =?us-ascii?Q?11n/Dv2JqTJP2We+kFqt8KCKEtZRUslGCJFB4dxdcahZkvWK1SsJZS3I/+/d?=
 =?us-ascii?Q?xF3d4yKWgm5wFHNsYMZDaIEqPsdOkLmdypGOGUrdkzbMlIEvGFi0JYYNyeb8?=
 =?us-ascii?Q?LROwHnFVYJAkuj2A6aSd2DY35uYbnjcoEyIr4tN4MjTgoEei8jwywsb02/uN?=
 =?us-ascii?Q?dL9vn/X9x5bILaizHGBvnjiyfAZnkCz4Pxztm8zXrj75kn5SyEYNzJvFtYQE?=
 =?us-ascii?Q?/U9wkldbMybAz709xKlLNJWg5VQIezHEreOyQKpDCn+HkvFkzvQQzPWjHt6f?=
 =?us-ascii?Q?gB/VMYBqS9NMR02mZQk2uOoHGn3Fy/+OY4XPKS1PSQu8u5MsvLL97v8Xf+Br?=
 =?us-ascii?Q?ybMrj0FEJo/k7CY7929mY2fkLbwN3VmV9OjE5scos2e6Xk66hpElg4PRW2wg?=
 =?us-ascii?Q?DvRP+N2w36aL5taGhj+qDnieXAqU+9HiCXHS21KJhAsFTCxoQG1LOKhEZEp4?=
 =?us-ascii?Q?5/zXeEW1faj0t+aZx+rb2+MYh3iPE2PlPHDilDVixFePLS16J6pY9mLa6hLU?=
 =?us-ascii?Q?/a10t5ehnU1hFghzGLBhqdSAKHe8o55IGYpxt292uZRmSDsIvZJIqscnIIpB?=
 =?us-ascii?Q?5M6ez6/CoLVJklS9HKHsOqaPtPdLMKMqFYY13x5L8O3HNLU5wgMdBsiNHQqU?=
 =?us-ascii?Q?eiEL46hvPssI9VwyRL2jGLxn5hhseN6qA5ddJnnOjXbTwnA9fUj3IV6hIxX1?=
 =?us-ascii?Q?OjMIT4IOoZLvGAuFpyugm2kRS9iohJMtjkvJf/RGk++PK2Q6IkBSJhyawLUb?=
 =?us-ascii?Q?EOpxW0uQsFKEm8XrQxsyRGIw/FY4i1LwQLXUBWzZQrQnP58y1r9gk8Ygx4mH?=
 =?us-ascii?Q?wN/9oGqfSiPkIf8LJv2R2kEl7tj1JBa9p6cPybUOui2IbwugMW0EPM0lgOvE?=
 =?us-ascii?Q?GvlntEJ48ISqKNHxpX/a8E6q+V63LQQV2EI54SkBrhtda/A6oVugI7nOP979?=
 =?us-ascii?Q?IL01ebtIWZtfs9mzlweUKpsTsKCdIcuyMSSPodpSLfrdnCgQCQjz5US8X6uQ?=
 =?us-ascii?Q?byK/mbdkDz6DQxncuM6CgykyiFuVH0mn2L1mBE1YxgOjzF9wiR5Sov1jfxEx?=
 =?us-ascii?Q?VWXQ1jVNdoP/MciCN42X+lR8nlePJhPq1p50KEVKwX6i2eFiazItPvwHaxMW?=
 =?us-ascii?Q?Wrrx6Nc6EY7ozcciti4JglgZOd5zCgujBFY0VqIHfERwKA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c20942-7336-450e-cf24-08d921f54950
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:26:03.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDwgD4vUdxRmcCOPrDqdefpw1w+WJs+oAI6fiiIYXGefYnEbCulXo6g19wpPzooH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4867
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kLKIZ8wkPBA-LyEBb1KbBqJxuGOrx1SO
X-Proofpoint-ORIG-GUID: kLKIZ8wkPBA-LyEBb1KbBqJxuGOrx1SO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 03:05:43PM +0200, Jan Kara wrote:
> On Thu 27-05-21 10:48:59, Roman Gushchin wrote:
> > On Thu, May 27, 2021 at 01:24:03PM +0200, Jan Kara wrote:
> > > On Wed 26-05-21 15:25:57, Roman Gushchin wrote:
> > > > Asynchronously try to release dying cgwbs by switching clean attached
> > > > inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> > > > structures themselves and of pinned memory and block cgroups, which
> > > > are way larger structures (mostly due to large per-cpu statistics
> > > > data). It helps to prevent memory waste and different scalability
> > > > problems caused by large piles of dying cgroups.
> > > > 
> > > > A cgwb cleanup operation can fail due to different reasons (e.g. the
> > > > cgwb has in-glight/pending io, an attached inode is locked or isn't
> > > > clean, etc). In this case the next scheduled cleanup will make a new
> > > > attempt. An attempt is made each time a new cgwb is offlined (in other
> > > > words a memcg and/or a blkcg is deleted by a user). In the future an
> > > > additional attempt scheduled by a timer can be implemented.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  fs/fs-writeback.c                | 35 ++++++++++++++++++
> > > >  include/linux/backing-dev-defs.h |  1 +
> > > >  include/linux/writeback.h        |  1 +
> > > >  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
> > > >  4 files changed, 96 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > > index 631ef6366293..8fbcd50844f0 100644
> > > > --- a/fs/fs-writeback.c
> > > > +++ b/fs/fs-writeback.c
> > > > @@ -577,6 +577,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > > >  	kfree(isw);
> > > >  }
> > > >  
> > > > +/**
> > > > + * cleanup_offline_wb - detach associated clean inodes
> > > > + * @wb: target wb
> > > > + *
> > > > + * Switch the inode->i_wb pointer of the attached inodes to the bdi's wb and
> > > > + * drop the corresponding per-cgroup wb's reference. Skip inodes which are
> > > > + * dirty, freeing, in the active writeback process or are in any way busy.
> > > 
> > > I think the comment doesn't match the function anymore.
> > > 
> > > > + */
> > > > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > > > +{
> > > > +	struct inode *inode, *tmp;
> > > > +
> > > > +	spin_lock(&wb->list_lock);
> > > > +restart:
> > > > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > > > +		if (!spin_trylock(&inode->i_lock))
> > > > +			continue;
> > > > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > > > +		if ((inode->i_state & I_REFERENCED) != I_REFERENCED) {
> > > 
> > > Why the I_REFERENCED check here? That's just inode aging bit and I have
> > > hard time seeing how it would relate to whether inode should switch wbs...
> > 
> > What I tried to say (and failed :) ) was that I_REFERENCED is the only accepted
> > flag here. So there must be
> > 	if ((inode->i_state | I_REFERENCED) != I_REFERENCED)
> > 
> > Does this look good or I am wrong and there are other flags acceptable here?
> 
> Ah, I see. That makes more sense. I guess you could also exclude I_DONTCACHE
> and I_OVL_INUSE but that's not that important.
> 
> > > > +			struct bdi_writeback *bdi_wb = &inode_to_bdi(inode)->wb;
> > > > +
> > > > +			WARN_ON_ONCE(inode->i_wb != wb);
> > > > +
> > > > +			inode->i_wb = bdi_wb;
> > > > +			list_del_init(&inode->i_io_list);
> > > > +			wb_put(wb);
> > > 
> > > I was kind of hoping you'll use some variant of inode_switch_wbs() here.
> > 
> > My reasoning was that by definition inode_switch_wbs() handles dirty inodes,
> > while in the cleanup case we can deal only with clean inodes and clean wb's.
> > Hopefully this can make the whole procedure simpler/cheaper. Also, the number
> > of simultaneous switches is limited and I don't think cleanups should share
> > this limit.
> > However I agree that it would be nice to share at least some code.
> 
> I agree limits on parallel switches should not apply. Otherwise I agree
> some bits of inode_switch_wbs_work_fn() should not be strictly necessary
> but they should be pretty cheap anyway.
> 
> > > That way we have single function handling all the subtleties of switching
> > > inode->i_wb of an active inode. Maybe it isn't strictly needed here because
> > > you detach only from b_attached list and move to bdi_wb so things are
> > > indeed simpler here. But you definitely miss transferring WB_WRITEBACK stat
> > > and I'd also like to have a comment here explaining why this cannot race
> > > with other writeback handling or wb switching in a harmful way.
> > 
> > If we'll check under wb->list_lock that wb has no inodes on any writeback
> > lists (excluding b_attached), doesn't it mean that WB_WRITEBACK must be
> > 0?
> 
> No, pages under writeback are not reflected in inode->i_state in any way.
> You would need to check mapping_tagged(inode->i_mapping,
> PAGECACHE_TAG_WRITEBACK) to find that out. But if you'd use
> inode_switch_wbs_work_fn() you wouldn't even have to be that careful when
> switching inodes as it can handle alive inodes just fine...

I see...

> 
> > Re racing: my logic here was that we're taking all possible locks before doing
> > anything and then we check that the inode is entirely clean, so this must be
> > safe:
> > 	spin_lock(&wb->list_lock);
> > 	spin_trylock(&inode->i_lock);
> > 	xa_lock_irq(&inode->i_mapping->i_pages);
> > 	...
> > 
> > But now I see that the unlocked inode's wb access mechanism
> > (unlocked_inode_to_wb_begin()/end()) probably requires additional care.
> 
> Yeah, exactly corner case like this were not quite clear to me whether you
> have them correct or not.
> 
> > Repeating the mechanism with scheduling the switching of each inode separately
> > after an rcu grace period looks too slow. Maybe we can mark all inodes at once
> > and then switch them all at once, all in two steps. I need to think more.
> > Do you have any ideas/suggestions here?
> 
> Nothing really bright. As you say I'd do this in batches - i.e., tag all
> inodes for switching with I_WB_SWITCH, then synchronize_rcu(), then call
> inode_switch_wbs_work_fn() for each inode (or probably some helper function
> that has guts of inode_switch_wbs_work_fn() as we probably don't want to
> acquire wb->list_lock's and wb_switch_rwsem repeatedly unnecessarily).

Ok, sounds good to me. I'm a bit worried about the possible CPU overhead,
but hopefully we can switch inodes slow enough so that the impact on the
system will be acceptable.

Thanks!
