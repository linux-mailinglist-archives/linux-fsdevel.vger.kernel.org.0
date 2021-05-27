Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD639351D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhE0Rur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 13:50:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229791AbhE0Rur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 13:50:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14RHjQe6031222;
        Thu, 27 May 2021 10:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kxzoRCMHSho4mWIak2bD8GUqCu6LDO350U90SH60GW4=;
 b=C4kIqJSuBZ2ZFJNS2vj8LqH/uUS2bjBYyvYqw9VzpB9UI3eXhz3DBrYHhb6xqzzSZF9z
 MUlnyhRLAXUi5RWbU04v0zRSlaht/mVOJOYufFvxDVJiEOLFIFvpWjRsezRNDSNbl4cB
 ZoJ3aPR0E2naGKi9mrk9Zl42J0Ec/DM71Fs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38smav25h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 May 2021 10:49:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 10:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDZXiBathLao3pUHT0ilDVT63hgjQTPpoOjCFE1pJTSIP7vGwONpTiVr3FpQ4Hl7WsI5Be1useA6EOoWYQUwHPO8wsUlySDidzHZfxFMNWA4k8BNUwaE1t1RnJPBkVU6TY8ER0e9ZIGZFVF9M8KRp2VHlsi5V08WicB6KAPLGcP0JH4EzsUtvH2KK9vHvXI/o8WvaBkFMQI+Y2jktOS5VYJ8b8IQyL0L5ans+1dmduEYsoqQ+sry1l/V5lKE3b6jn/3m+l5/ewMf3Yxx8D6Vy9OH3o6kbeeOLMTkuJt7uhKKv5HGQVfSNX9qHr26g+g2yYKP1J9y78m0jtHq0NsncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxzoRCMHSho4mWIak2bD8GUqCu6LDO350U90SH60GW4=;
 b=gQxs8oODlVltJQWEIaaqiUsjwYCxagC1uHow9atxy/GcChK28VY3E5Ezd+RhDVPPUCE8BaPh1unnlT2zya841s2FFJKukfqm1ZSsaJInYxS56PHymSCJLe28efhaS+Ot7eBskqkAINf8uAW+mCBqHIwnArHj9w8BbuH2hRFEW8oXdQyFOhQ8KOqSn3WMZIyu+3bXtpqRCriQfb8S29WkLn1Cmq77OIwRwM5tDF/H7etAlj8nsbHx/DPuELvqLsIzW3Cr7A9dJFyOCyE/66g2SK9Lh4V7lSUi6iCVdc/XQkqyd8CSEXSz77ksPfK5W7kL46Tz9uIrJ8TU4ysAGBCUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA1PR15MB4823.namprd15.prod.outlook.com
 (2603:10b6:806:1e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 17:49:05 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 17:49:05 +0000
Date:   Thu, 27 May 2021 10:48:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
 <20210527112403.GC24486@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210527112403.GC24486@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:86b3]
X-ClientProxiedBy: MWHPR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:300:95::26) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:86b3) by MWHPR13CA0040.namprd13.prod.outlook.com (2603:10b6:300:95::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 17:49:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985d690a-b5a7-4509-4363-08d92137b837
X-MS-TrafficTypeDiagnostic: SA1PR15MB4823:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4823DE2D142E6FCE47C5C837BE239@SA1PR15MB4823.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98gBDNvnxMHJRyfVSxhRz4Fa4DDdBWR/c8Lvr3weG/XrAXy4vIAZd4FZlnc2D+NvRLtTPUhWdEHt07ifPSxAiMMKrNksb96D8fEhxH11BTHg00m/gLwYXSfPBZQk+pZCxKJvINUgtK424C4rf0gVrikpCQ5kdCeBD5GXJBj3+n97erH+9RYLtJFAApzzEM2vfzQCXmM8eCNtwAaCB4fyBxVDrG/HnE0e8KE+Th+yWWCmwJ5WkkNlBSHotCQ34Vs5PeVuOMtsPvOAae4f2ad4UsMgncwm20wsu6mzLApL5RWTzlee6I5zd1speAzBT9P5K+ojPOBiAMPy2cBIriWJQK0dJVL79tAPnivpBK9omtr4LuMU+CkzjxGN1rFPZBucGZkqaHnQztRcp0/dHxNxXwcgcACo4WF+Tt0SAXhpCwcbfSlNGd1TIo7cog1qeyUStt6Kmz8Lv1ie0aMpDjxUqJbWu3ddNJQEW7OZXKEUlkd4rTd5D01gmH//vJRdgv2Tc84oq0ZwsNTHZqE5STk3TOtOyPUL3wffCB3SeCyKA6Wr6GABG5UtAJcV88T1VlCo5LxHXmQNmk7Eervl9uxU1LAEKJEB9Zf1zLEsKeGuU8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(54906003)(316002)(186003)(4326008)(55016002)(66946007)(30864003)(16526019)(8936002)(66556008)(66476007)(9686003)(52116002)(5660300002)(8676002)(6506007)(2906002)(7696005)(38100700002)(6666004)(86362001)(83380400001)(6916009)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JLwzbIBaU/1TACE/cgjhwddoF+LkzSm/KZzvnim75f3yFCa/W1WQj6eXJUal?=
 =?us-ascii?Q?6vdhkI55MdC+vqhc3XOD8nPkpAN+yX8qmup6m99KAHlzEvdl16ckdJLig/F0?=
 =?us-ascii?Q?ebKZKY9SqFrnR+MKu9lecHx8knHLQsypexxy2wtrNIdLOXGYBrmlRp0msM0s?=
 =?us-ascii?Q?jbEd/vSX/j+rL9ki5l0zEvOCA+suGpXMBqFojbv6oY5amobk+YL85yqitbZo?=
 =?us-ascii?Q?E8Jf99g1O9qRNlkogj6a7zuEV9I+NM1NXhMm0n/qb/JuVFyvoejK9qvrUIvy?=
 =?us-ascii?Q?H3fMmyO65fPu6sLDK2QKWjwdR7DuFlR939PPFcp5hAEH+DGK78YIprilall1?=
 =?us-ascii?Q?55VFGBuT+Nz6eq9aAL6KVoQE2fYXlsKbW4CKDg9B0C5mXFtwlWWCCil0Hx1g?=
 =?us-ascii?Q?jMLekvjactPScpCJ3Pbd85qBbnbJ+Zr+1ZhuNbVuDnWv0AwgUnbcd9ZRTxtk?=
 =?us-ascii?Q?mJG6GL4J796q+eBtyaDCeuy7jQpoXTEPG5nyFhjxKQjfXs39mZj6r7yJwqkS?=
 =?us-ascii?Q?H5iKIybkfrAs804y0Km1a4jIaFY8MiQ+2dcha2LpkYoG1w3hY5kSIgxCgVUq?=
 =?us-ascii?Q?O2R06zijKs7NZvb5GPSxo7/WFCPS+n3/03y25DL5hzGzoqFSRu5MLDy6IWbq?=
 =?us-ascii?Q?/fycDuuWY8qyjIBd1k8uvFuvCQRGdr6C0R1V144cPGlc9KZBRsUiGxTcLp3y?=
 =?us-ascii?Q?Fr7z6Xe9GS3ufgxH/4u1EKtE/rsEtbKywSX2YqcHomV4/Xn3PWw9/VsjRaYq?=
 =?us-ascii?Q?xm5F008oD2HsBfuoshZKRBzC2Lh/vw1PP10TW8OSiOpWCweuQBe5vFMhUVnW?=
 =?us-ascii?Q?nmU/LOBG3haAclrnUHrmWd8I/dGttcx+2ve9mm24wL9wIay/vnewYjRpUTnB?=
 =?us-ascii?Q?MiumsC4h6CFXAx+YegTsimR3H0xpdIhJIbyaYePGhnGgjaOuhAZ8BFNMqK5S?=
 =?us-ascii?Q?E8ZGpJmi/FHjY2tricdPMzK78GRlVVbjGxa0DEJgFpRXsJFYUgfxJppDAKUQ?=
 =?us-ascii?Q?Xwhkw9Lm6qtALbQr/34vj+lyMgZb+u3owmIVHWo9j6I2LJ8ngj+QLeIHiypG?=
 =?us-ascii?Q?glPTjUVnzY6HXj6PGfEmth94+W5PTK1bjO9dN/AeSZMvbALuspy/mP3bgtT6?=
 =?us-ascii?Q?+cUseIjr8KVySjFpODqpuEhKLenCfD3xbvLISUHJ6qi2OEUaHcwM2aXAIpL5?=
 =?us-ascii?Q?wFJAbJIDowWvZsqkETPB4QYHiMgAMhG+pEMyCCHQCaiwS0vBMA03VjY5rT4q?=
 =?us-ascii?Q?pCBr6jzwMV8/BvrA0Y7/Yb7OrA7cnQgkrd2zPtV0HU4KEbQZl1MUenEjT1F9?=
 =?us-ascii?Q?kpp6YNMzVfYrcEGB7xM7f0eLHyTT8ICg1kmot36fFGlk6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d690a-b5a7-4509-4363-08d92137b837
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 17:49:04.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIufGDQB8eaO/U9uSjBGF3HbSDuzrdS3REC3DJnxOlyxMoth+YTYz39N7LDb9BNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4823
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LfLT_ktlfvEKtADT97p1TOmz0NyTRWWA
X-Proofpoint-ORIG-GUID: LfLT_ktlfvEKtADT97p1TOmz0NyTRWWA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_09:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 01:24:03PM +0200, Jan Kara wrote:
> On Wed 26-05-21 15:25:57, Roman Gushchin wrote:
> > Asynchronously try to release dying cgwbs by switching clean attached
> > inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> > structures themselves and of pinned memory and block cgroups, which
> > are way larger structures (mostly due to large per-cpu statistics
> > data). It helps to prevent memory waste and different scalability
> > problems caused by large piles of dying cgroups.
> > 
> > A cgwb cleanup operation can fail due to different reasons (e.g. the
> > cgwb has in-glight/pending io, an attached inode is locked or isn't
> > clean, etc). In this case the next scheduled cleanup will make a new
> > attempt. An attempt is made each time a new cgwb is offlined (in other
> > words a memcg and/or a blkcg is deleted by a user). In the future an
> > additional attempt scheduled by a timer can be implemented.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  fs/fs-writeback.c                | 35 ++++++++++++++++++
> >  include/linux/backing-dev-defs.h |  1 +
> >  include/linux/writeback.h        |  1 +
> >  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
> >  4 files changed, 96 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 631ef6366293..8fbcd50844f0 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -577,6 +577,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	kfree(isw);
> >  }
> >  
> > +/**
> > + * cleanup_offline_wb - detach associated clean inodes
> > + * @wb: target wb
> > + *
> > + * Switch the inode->i_wb pointer of the attached inodes to the bdi's wb and
> > + * drop the corresponding per-cgroup wb's reference. Skip inodes which are
> > + * dirty, freeing, in the active writeback process or are in any way busy.
> 
> I think the comment doesn't match the function anymore.
> 
> > + */
> > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > +{
> > +	struct inode *inode, *tmp;
> > +
> > +	spin_lock(&wb->list_lock);
> > +restart:
> > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > +		if (!spin_trylock(&inode->i_lock))
> > +			continue;
> > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > +		if ((inode->i_state & I_REFERENCED) != I_REFERENCED) {
> 
> Why the I_REFERENCED check here? That's just inode aging bit and I have
> hard time seeing how it would relate to whether inode should switch wbs...

What I tried to say (and failed :) ) was that I_REFERENCED is the only accepted
flag here. So there must be
	if ((inode->i_state | I_REFERENCED) != I_REFERENCED)

Does this look good or I am wrong and there are other flags acceptable here?

> 
> > +			struct bdi_writeback *bdi_wb = &inode_to_bdi(inode)->wb;
> > +
> > +			WARN_ON_ONCE(inode->i_wb != wb);
> > +
> > +			inode->i_wb = bdi_wb;
> > +			list_del_init(&inode->i_io_list);
> > +			wb_put(wb);
> 
> I was kind of hoping you'll use some variant of inode_switch_wbs() here.

My reasoning was that by definition inode_switch_wbs() handles dirty inodes,
while in the cleanup case we can deal only with clean inodes and clean wb's.
Hopefully this can make the whole procedure simpler/cheaper. Also, the number
of simultaneous switches is limited and I don't think cleanups should share
this limit.
However I agree that it would be nice to share at least some code.

> That way we have single function handling all the subtleties of switching
> inode->i_wb of an active inode. Maybe it isn't strictly needed here because
> you detach only from b_attached list and move to bdi_wb so things are
> indeed simpler here. But you definitely miss transferring WB_WRITEBACK stat
> and I'd also like to have a comment here explaining why this cannot race
> with other writeback handling or wb switching in a harmful way.

If we'll check under wb->list_lock that wb has no inodes on any writeback lists
(excluding b_attached), doesn't it mean that WB_WRITEBACK must be 0?

Re racing: my logic here was that we're taking all possible locks before doing
anything and then we check that the inode is entirely clean, so this must be
safe:
	spin_lock(&wb->list_lock);
	spin_trylock(&inode->i_lock);
	xa_lock_irq(&inode->i_mapping->i_pages);
	...

But now I see that the unlocked inode's wb access mechanism
(unlocked_inode_to_wb_begin()/end()) probably requires additional care.
Repeating the mechanism with scheduling the switching of each inode separately
after an rcu grace period looks too slow. Maybe we can mark all inodes at once
and then switch them all at once, all in two steps. I need to think more.
Do you have any ideas/suggestions here?

> 
> > +		}
> > +		xa_unlock_irq(&inode->i_mapping->i_pages);
> > +		spin_unlock(&inode->i_lock);
> > +		if (cond_resched_lock(&wb->list_lock))
> > +			goto restart;
> > +	}
> > +	spin_unlock(&wb->list_lock);
> > +}
> > +
> >  /**
> >   * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
> >   * @wbc: writeback_control of interest
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> > index e5dc238ebe4f..07d6b6d6dbdf 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -155,6 +155,7 @@ struct bdi_writeback {
> >  	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
> >  	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
> >  	struct list_head b_attached;	/* attached inodes, protected by list_lock */
> > +	struct list_head offline_node;	/* anchored at offline_cgwbs */
> >  
> >  	union {
> >  		struct work_struct release_work;
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 572a13c40c90..922f15fe6ad4 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -222,6 +222,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
> >  int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
> >  			   enum wb_reason reason, struct wb_completion *done);
> >  void cgroup_writeback_umount(void);
> > +void cleanup_offline_wb(struct bdi_writeback *wb);
> >  
> >  /**
> >   * inode_attach_wb - associate an inode with its wb
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 54c5dc4b8c24..92a00bcaa504 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -371,12 +371,16 @@ static void wb_exit(struct bdi_writeback *wb)
> >  #include <linux/memcontrol.h>
> >  
> >  /*
> > - * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, and memcg->cgwb_list.
> > - * bdi->cgwb_tree is also RCU protected.
> > + * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, offline_cgwbs and
> > + * memcg->cgwb_list.  bdi->cgwb_tree is also RCU protected.
> >   */
> >  static DEFINE_SPINLOCK(cgwb_lock);
> >  static struct workqueue_struct *cgwb_release_wq;
> >  
> > +static LIST_HEAD(offline_cgwbs);
> > +static void cleanup_offline_cgwbs_workfn(struct work_struct *work);
> > +static DECLARE_WORK(cleanup_offline_cgwbs_work, cleanup_offline_cgwbs_workfn);
> > +
> >  static void cgwb_release_workfn(struct work_struct *work)
> >  {
> >  	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
> > @@ -395,6 +399,7 @@ static void cgwb_release_workfn(struct work_struct *work)
> >  
> >  	fprop_local_destroy_percpu(&wb->memcg_completions);
> >  	percpu_ref_exit(&wb->refcnt);
> > +	WARN_ON(!list_empty(&wb->offline_node));
> 
> Hum, cannot this happen when when wb had originally some attached inodes,
> we added it to offline_cgwbs but then normal inode reclaim cleaned all the
> inodes (and thus all wb refs were dropped) before
> cleanup_offline_cgwbs_workfn() was executed? So either the offline_cgwbs
> list has to hold its own wb ref or we have to remove cgwb from the list
> in cgwb_release_workfn().

Yes, clearly a bug, thanks for catching!

> 
> >  	wb_exit(wb);
> >  	WARN_ON_ONCE(!list_empty(&wb->b_attached));
> >  	kfree_rcu(wb, rcu);
> > @@ -414,6 +419,10 @@ static void cgwb_kill(struct bdi_writeback *wb)
> >  	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
> >  	list_del(&wb->memcg_node);
> >  	list_del(&wb->blkcg_node);
> > +	if (!list_empty(&wb->b_attached))
> > +		list_add(&wb->offline_node, &offline_cgwbs);
> > +	else
> > +		INIT_LIST_HEAD(&wb->offline_node);
> >  	percpu_ref_kill(&wb->refcnt);
> >  }
> >  
> > @@ -635,6 +644,50 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
> >  	mutex_unlock(&bdi->cgwb_release_mutex);
> >  }
> >  
> > +/**
> > + * cleanup_offline_cgwbs - try to release dying cgwbs
> > + *
> > + * Try to release dying cgwbs by switching attached inodes to the wb
> > + * belonging to the root memory cgroup. Processed wbs are placed at the
> > + * end of the list to guarantee the forward progress.
> > + *
> > + * Should be called with the acquired cgwb_lock lock, which might
> > + * be released and re-acquired in the process.
> > + */
> > +static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > +{
> > +	struct bdi_writeback *wb;
> > +	LIST_HEAD(processed);
> > +
> > +	spin_lock_irq(&cgwb_lock);
> > +
> > +	while (!list_empty(&offline_cgwbs)) {
> > +		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > +				      offline_node);
> > +		list_move(&wb->offline_node, &processed);
> > +
> > +		if (wb_has_dirty_io(wb))
> > +			continue;
> > +
> > +		if (!percpu_ref_tryget(&wb->refcnt))
> > +			continue;
> > +
> > +		spin_unlock_irq(&cgwb_lock);
> > +		cleanup_offline_wb(wb);
> > +		spin_lock_irq(&cgwb_lock);
> > +
> > +		if (list_empty(&wb->b_attached))
> > +			list_del_init(&wb->offline_node);
> 
> But the cgwb can still have inodes in its dirty lists which will eventually
> move to b_attached. So you can delete cgwb here prematurely, cannot you?

Hm, I thought that in this case wb_has_dirty_io() check above will fail.
But you're right, nothing really protects wb from being re-dirtied after
the check.
At least we need to hold wb->list_lock for wb_has_dirty_io(wb) and
list_empty(&wb->b_attached) checks...

Will fix it.

Thank you, really appreciate your feedback!
