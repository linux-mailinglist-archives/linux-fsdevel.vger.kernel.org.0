Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A006A39AFEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFDBiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:38:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhFDBiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:38:21 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1541aJ4t028894;
        Thu, 3 Jun 2021 18:36:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=S1L0ue23Urr+6rn6rGgKO/9RSY4H5BcOTxUoz+3/F4A=;
 b=d3NNls/gIASXFqKhk+fx2Jmx3T+vse5sUCGPPWV2731JjogLiqVxIQMlLz4YXTCqbU/H
 nizg36QInYQrsO5s0PlhYwIIBHojoft6kv1b2sWuFnrL4X/s+gZiC43c8QH1ETEebXAy
 jbQjxEixOO8D97ACDMwnbqfFXoW2Saa2az4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xedh9kwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Jun 2021 18:36:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 18:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEzxm2gVYahX7npiRfFA1pvJiVpL60xh1j25y2gzLhVQBr45pryHkDG/XIVwKMOG+qKYdh7rJI5iLYr33nCmqgzM4cMQm7lahqe3NmqDINp0veMsUXD76R1js6YJez9QvvJDhejLzNqyucQVlLNMsHh51RbYtN6ar7Op/51gDR30wv6Iyz1ScZG2Cn/pD0J1XUHHA5vNMGbhmmWjeZXM3yWL2oCaEABGHqO9O7NeljxilJyIOY+ty7LDNtFWaxuZfHBonCW5mcJjLJjv28WEj6DvYTwcalzu68mZJRX67LKAwR4UP5mfTSkK2iVVAWOcNxN5xm7WE1pUI6VXBSopyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1L0ue23Urr+6rn6rGgKO/9RSY4H5BcOTxUoz+3/F4A=;
 b=oJxV0cVIPK0gyE78Md2Mk3+71sjdREz7TDEbA9OcPVS8kuh7rzE+mnR38gP4kbP2s9R8ACYrwXQgfnYzeNEh9HnX/Asj8/K3P0yejq+Owi/4fGYbRW8uuM2mEzvYAGk2yJX0ZbC6VRFQmJLWLqyvWiHVI774uRdD5/tXIVouBfuFgSN8nyE86xbguS6WHfUz0+EVlGWdhFup5jfsW7LwTVrcJmAGoOhHkgMMmzSlBDjPsPrZqNN7eKsFy7R/nlydToq0mle4y7s2o6UYVQE9VG4wCUqOXClueBbx8gW89Bdz1S3Q17jJd+XrZPMTBQDzmBgFpe4qq8p3AzVBtXR7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4186.namprd15.prod.outlook.com (2603:10b6:a03:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 01:36:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4195.020; Fri, 4 Jun 2021
 01:36:16 +0000
Date:   Thu, 3 Jun 2021 18:36:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YLmDi27fSD4bRbQM@carbon.lan>
References: <20210603005517.1403689-1-guro@fb.com>
 <20210603005517.1403689-6-guro@fb.com>
 <20210603100233.GG23647@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210603100233.GG23647@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:dee6]
X-ClientProxiedBy: MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:dee6) by MWHPR2201CA0051.namprd22.prod.outlook.com (2603:10b6:301:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Fri, 4 Jun 2021 01:36:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0957c8a-0854-4529-c481-08d926f924fd
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4186:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB418607A35249B151A8A660F6BE3B9@SJ0PR15MB4186.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2ldB4FTwtyyJPKfoTsHSkeS08ipORkqU/QMdB1Ee69W4IhRSdsIfZ3qbFbW/khVkfYA1uPWJoNU5YiQvDHeCKJ4PMtLxvoL3Grf4xoGgwfL7plkVzNEvxM7oOMapdHaUnpEp8IhL2HTH+rT9JvcJmuWPMN/aR5TpsNgepJMx1ooi9mg11fuzQNaYa5ntyytRzLw54NxTaVBw5jTeVCL/XaoQ9fzZRJBCUheDmpSxoCtra/ic/AvCxnPvK27+2LkUQStgALnpzijBqh8pxiyE6gzNpF+uvsrFsI1QHl9JaMpLf0vwqk+ddZODkubEMtnrM/H263C3zSRQpcI6xKrDW8JhYuqRAeza8+VU03scGGgwjFJRqIiAD0I5ZiH44p5piWBYqHy1Q58pfrMYa3Avi1g4mE/ssdasa9yCe5g4AeSmPwtFR5G5tpP3hsPxixhxCmxh8UtaoI7+5x8YelrC4f15U41qzYHtosPaB9enQUBw/JYAEIf/X1wCANTt7noLkYD3VyCC9JTV4Sgz+n8S2FQ3iVTj1kQr6k+30OymA/gnRGxZzX/bYMTQOZmH8thhROlk8/LETScB3Fy1Ihq1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(52116002)(6506007)(6916009)(83380400001)(7696005)(478600001)(4326008)(8886007)(38100700002)(6666004)(5660300002)(2906002)(36756003)(16526019)(186003)(316002)(54906003)(66556008)(66476007)(66946007)(55016002)(86362001)(8676002)(9686003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jxepmd96rARZpGCbSt+K7MtvsXIHRV+2FOcnwx5FzpTVsPxXoV8s2utRjdlo?=
 =?us-ascii?Q?HulIcHTMp8HK1nNuD3Um24xQMuObEpLYzC7i9vS9eFinsa3hNC9t4cEPbmoP?=
 =?us-ascii?Q?LL0i3jM6LpaS9d/mOYV76H6ehE4HZYs2F1dt4WAGKSIYWHd/QVoiDRQIsDo5?=
 =?us-ascii?Q?bvSR1/LCKKzn4KU1i12p+FUL1a2ZHMwkYerLHe7Bc9Pbav8Na8fMdNXZ3AgZ?=
 =?us-ascii?Q?Lr6zA08QQDdbg30msmCJe/MWugj4yOV4xo8LCSnkKi/x2Dg3TOr0xENl1/Hc?=
 =?us-ascii?Q?IV6pWUPZ6kCvWgVaX7Qyp8ZUo3u0uarNlVXWbjVXoFpwd2tGlzIrQKRMIBIN?=
 =?us-ascii?Q?+Z6MrCvBl4vVPqcjAvBCPtPcEHtiB1fMGpPWP9llkouhNJF5GnAX087EoucC?=
 =?us-ascii?Q?v8gaAxnX6DoZZ5t2n5ZoPkMvr/PzLnOarnhon5iaOndh++228PUCSAN0Vz7v?=
 =?us-ascii?Q?bDUEOeMX8dXz6g+xQm6jZPbptJS6a0/lDai2WnyAPPD/TFhWCVVXI7N4FPtK?=
 =?us-ascii?Q?m3cB5jYJqLXIGc4ClJtS07Q66/QY9qf1KsTyF7KSuJjqNojxAg07GFqiPZ8H?=
 =?us-ascii?Q?L0XJzoykMrA6bEndD6YhsRwj1i1afLhKh6ee1HU42JvUOl3T11wlx0EnqA0D?=
 =?us-ascii?Q?G36e3f6mvvIsiE15ioVpCZocuquNaM9xSwvCw4aGZtaN8m2bYtjPChRrjWz3?=
 =?us-ascii?Q?M/vIGbK4HFC7d1mxmDALR/z9+ohK6w7XLcn2wQeRT80b8UV4aj/QMzVZm9cO?=
 =?us-ascii?Q?ayKc5BXgSQKEBcGJfavfYwlaipd2cs9pBcOClTc+gmtXgVLSBYpIo4ufmg9i?=
 =?us-ascii?Q?aso4Lm9zccoP19hQs3WHhopuTkb6IHyy8J+e36konKZBkhzmwKcVbPxrLLnr?=
 =?us-ascii?Q?xb1Me6fbHfNrJOeNdy40XH+G/P93tKgWoNsQ008Uzj906MuzHYtG6k7mzNFc?=
 =?us-ascii?Q?7cdy4aNbtkYRTVjDZGcXYFKFMFB9abNakBWLYQ4O+2ItMdYd8WIEjjGLjNvN?=
 =?us-ascii?Q?gKrrgtrlwgiiQNXnv+G3qWwoetT1VcJW+5kMeSNHBJ/Rcojt8JG/1K4KnAnj?=
 =?us-ascii?Q?lG2t3+6qWYbjiaoyfjZdJg08StIlBFPikyzDo5JoK3t34XqtwXzzc8SisFxL?=
 =?us-ascii?Q?mJMaFrlb+/sX6JwgEVogXKMwmx/2cBsKJS6I8tpHb4coh+O/EnvFacey+Vnk?=
 =?us-ascii?Q?cp6f0P+sXURLZrxpAdyQa4ukrpEP7VlY7nTShmIca/b5U7ZFYhBrQy0LbhzY?=
 =?us-ascii?Q?qp0iewwS3T+vNAGIOQzXe4M7X5KgvM3Plzf6+LN5PWCZBqomeBTeW5v1sQe0?=
 =?us-ascii?Q?/hUwlSHxDPevQmZ4O82tChsnbt+PPgKQWdGwnkP68y7TVw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0957c8a-0854-4529-c481-08d926f924fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 01:36:16.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94kgEmAmzTT5+QJIWMW0oQMHbNNxMPt0mCdU5miLlpW/2KTVq6b2gysGr5WsWVGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4186
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FPmamfTctut1hbgXQZdnY-_qJhvw8cwY
X-Proofpoint-ORIG-GUID: FPmamfTctut1hbgXQZdnY-_qJhvw8cwY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 03, 2021 at 12:02:33PM +0200, Jan Kara wrote:
> On Wed 02-06-21 17:55:17, Roman Gushchin wrote:
> > Asynchronously try to release dying cgwbs by switching attached inodes
> > to the bdi's wb. It helps to get rid of per-cgroup writeback
> > structures themselves and of pinned memory and block cgroups, which
> > are significantly larger structures (mostly due to large per-cpu
> > statistics data). This prevents memory waste and helps to avoid
> > different scalability problems caused by large piles of dying cgroups.
> > 
> > Reuse the existing mechanism of inode switching used for foreign inode
> > detection. To speed things up batch up to 115 inode switching in a
> > single operation (the maximum number is selected so that the resulting
> > struct inode_switch_wbs_context can fit into 1024 bytes). Because
> > every switching consists of two steps divided by an RCU grace period,
> > it would be too slow without batching. Please note that the whole
> > batch counts as a single operation (when increasing/decreasing
> > isw_nr_in_flight). This allows to keep umounting working (flush the
> > switching queue), however prevents cleanups from consuming the whole
> > switching quota and effectively blocking the frn switching.
> > 
> > A cgwb cleanup operation can fail due to different reasons (e.g. not
> > enough memory, the cgwb has an in-flight/pending io, an attached inode
> > in a wrong state, etc). In this case the next scheduled cleanup will
> > make a new attempt. An attempt is made each time a new cgwb is offlined
> > (in other words a memcg and/or a blkcg is deleted by a user). In the
> > future an additional attempt scheduled by a timer can be implemented.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> I think we are getting close :). Some comments are below.

Great! Thank for reviewing the code!

> 
> > ---
> >  fs/fs-writeback.c                | 68 ++++++++++++++++++++++++++++++++
> >  include/linux/backing-dev-defs.h |  1 +
> >  include/linux/writeback.h        |  1 +
> >  mm/backing-dev.c                 | 58 ++++++++++++++++++++++++++-
> >  4 files changed, 126 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 49d7b23a7cfe..e8517ad677eb 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -225,6 +225,8 @@ void wb_wait_for_completion(struct wb_completion *done)
> >  					/* one round can affect upto 5 slots */
> >  #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
> >  
> > +#define WB_MAX_INODES_PER_ISW	116	/* maximum inodes per isw */
> > +
> 
> Why this number? Please add an explanation here...

Added.

> 
> >  static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
> >  static struct workqueue_struct *isw_wq;
> >  
> > @@ -552,6 +554,72 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	kfree(isw);
> >  }
> >  
> > +/**
> > + * cleanup_offline_cgwb - detach associated inodes
> > + * @wb: target wb
> > + *
> > + * Switch all inodes attached to @wb to the bdi's root wb in order to eventually
> > + * release the dying @wb.  Returns %true if not all inodes were switched and
> > + * the function has to be restarted.
> > + */
> > +bool cleanup_offline_cgwb(struct bdi_writeback *wb)
> > +{
> > +	struct inode_switch_wbs_context *isw;
> > +	struct inode *inode;
> > +	int nr;
> > +	bool restart = false;
> > +
> > +	isw = kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
> > +		      sizeof(struct inode *), GFP_KERNEL);
> > +	if (!isw)
> > +		return restart;
> > +
> > +	/* no need to call wb_get() here: bdi's root wb is not refcounted */
> > +	isw->new_wb = &wb->bdi->wb;
> > +
> > +	nr = 0;
> > +	spin_lock(&wb->list_lock);
> > +	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
> > +		spin_lock(&inode->i_lock);
> > +		if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> > +		    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
> > +		    inode_to_wb(inode) == isw->new_wb) {
> > +			spin_unlock(&inode->i_lock);
> > +			continue;
> > +		}
> > +		inode->i_state |= I_WB_SWITCH;
> > +		__iget(inode);
> > +		spin_unlock(&inode->i_lock);
> 
> This hunk is identical with the one in inode_switch_wbs(). Maybe create a
> helper for it like inode_prepare_wb_switch() or something like that. Also
> we need to check for I_WILL_FREE flag as well as I_FREEING (see the code in
> iput_final()) - that's actually a bug in inode_switch_wbs() as well so
> probably a separate fix for that should come earlier in the series.

Good point, added in v7.

> 
> > +
> > +		isw->inodes[nr++] = inode;
> 
> At first it seemed a bit silly to allocate an array of inode pointers when
> we have them in the list. But after some thought I agree that dealing with
> other switching being triggered from other sources in parallel would be
> really difficult so your decision makes sense. Just maybe add an
> explanation in a comment somewhere about this design decision.

Added in v7.

> 
> > +
> > +		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
> > +			restart = true;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&wb->list_lock);
> 
> ...
> 
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
> 
> Maybe explain in a comment why skipping wbs with dirty inodes is fine?
> Because honestly, I'm not sure... I guess the rationale is that inodes
> should get cleaned eventually and if they are getting redirtied, they will
> be switched to another wb anyway?

The main rationale here is that the deletion of a memory/blkcg cgroup by a user
shouldn't affect the io distribution. In other words, the remaining io shouldn't
be performed faster than it could be finished had the cgroup remain existing.
