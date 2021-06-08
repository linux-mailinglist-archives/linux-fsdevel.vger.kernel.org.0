Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68663A06F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 00:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhFHWj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 18:39:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29766 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhFHWj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:39:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158Ma3kQ013234;
        Tue, 8 Jun 2021 15:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Dv5K3FCh4Nz9BS19ove+HX0OGpQWhODHlhR95WzQE0E=;
 b=BYEhbg5sqmxZDloEBAgGOU9FG9Vs0oQwpf7+gz221WAPskOG/rn7xID7IUc39MZDAMuD
 o1gtNf6iHuZEYoJjLSCiNw2LlP+QDh4gZGiDkzr7X881ZpGSc+nS226jZf3Pqt6zB+ol
 +Dn4skC1XiJBDdIvJsELIg0th5v0NdmDZU0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 392fmdrmsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Jun 2021 15:37:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6KoYQzspfQg5CvW2p95NN7JIc+l2ithwkR0rHT4byZqAVSoPQ3osz3SrJx8lK6CuLwwwNbGpEDrEsH2CBDsp78C02tyvziJm+0wejJoq2rIzq0gDIF1p9AWecL/kwPfBnZHeJ2+85sZieNNvrnz0lVI6SoqWY/1Itpbs1ox8xpeCTTMkyBZaALz1/Fwrg9mF801l5pk51+M7zn8ngmHfsV603dx/gAqTN5TRnKiQlt6k6ipD3W7Ka2F1Xr6r8h0B4O8WY+d0Wzdb8npQ2xJEVu+fW2M87pkVNw4ZhkdJImlaq4mQjTr9T7b1p6w+22vTxiPb0hnmsxpxg30S604UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv5K3FCh4Nz9BS19ove+HX0OGpQWhODHlhR95WzQE0E=;
 b=HYXqDAblxQSWAmmLatzCPPcn1po2Ce8yA7+lQEWQFEcBP8ZrSDaBy7XQHF/FTLW+kjQDUxhP9FfltxAOa+TuffSm9TL5J0RU4NcfOd1BCbwfaCW/RYWwGs3DiEUKwn7/yMhd5N2CPgaqc1RLIIk2Kt29m9zOjXDn4cnyatTIxzREw5a1Eecoyjev2B2NB166MRVJmWF5YFDFaQgwxiMS8dNu6A2jR7lFYmHTkaNNPjE63GQ1rSzCD5FGqCpq5W3mJPA8mcrgmC1kUOjKx58Rhtz9oXbZ8ErqK1w2KxUbwoRBxExFFs5KU5GcJP8iSyOhDpEhVGdr2BpstpVtaLRvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3350.namprd15.prod.outlook.com (2603:10b6:a03:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 8 Jun
 2021 22:37:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 22:37:23 +0000
Date:   Tue, 8 Jun 2021 15:37:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v8 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YL/xH+DBAYWM6eXK@carbon.dhcp.thefacebook.com>
References: <20210608013123.1088882-1-guro@fb.com>
 <20210608013123.1088882-9-guro@fb.com>
 <YL+WC5beBH/N0ddz@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YL+WC5beBH/N0ddz@google.com>
X-Originating-IP: [2620:10d:c090:400::5:59a2]
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:59a2) by MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 22:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64731336-e127-4ee9-e3ba-08d92acdfbc9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3350BAD702E98D97307984D3BE379@BYAPR15MB3350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC2BA4EDepyVxWBKtcW+pzjF/vujlwpX21ZnUqS9B+EmE0GhZ0BxEYmm3eUmQWG4KsGVSxnGSsTvM0zotaZih0Bo2HxSY6tGadpqJDf3xFNMf89dl09JMlLW7PoA4kX1Tm5/808tQbPeQxS9iLVFxqKi8dvLMPu895La5UYumNL1su+xvg508tXIJ8fP/mHycGKq42YqfRRbWmoDnp5zlv0cglguHwPrB7Q18ShUGeEKVObK5+Vy/XZDv/lfgdhlNuT/AvcWMl8BhNAgorHibLXDhOf5ZWkei1uR1f2mZg5eQjqO9XHyNo5WwfnOLshwidTgy3yUnuNNpuKOXORZWJsxJTooVuzE8AFKfVb9MOPMGsd1GF/IFoW+LKKX0GoH2ZGNCH/zjtlvNKYHDPiwxu6IgTPbhYQYi8t0nSNJrSO5FyGkVcupC+u1H7Z5DQbfLQqB/iwJR1TNw/F7E/DoPFaDbUB8cUzpLCubiX8zfEt0lZY+4Fegyp1NFB8E05Gsm5NE8R+dmYIdJRvAXAmB7NEE34szzbDMlk96ZKf8F/NYccHd4NXiY0F+T8Mi6KT+RllhbI211S/nJMNPi23Nug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(4326008)(9686003)(16526019)(186003)(6666004)(55016002)(52116002)(8936002)(86362001)(316002)(54906003)(2906002)(6506007)(478600001)(66556008)(66946007)(83380400001)(66476007)(7696005)(6916009)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUtCE9P68M2GxOxJFUwDuOLVBhVoQDZ/hQHXIqML5AvHA1tzKGe+8X3T1nw8?=
 =?us-ascii?Q?jbx0X3UlFp8oJktMaOWrkmJtpaAFn5X2cXcXPcPOpnKGBh9vGqTs5aNSa1Bl?=
 =?us-ascii?Q?UEk5uAPzNM5Z8sS/Q1Jz70Qg/R/FcRWbwGJQX6EinMI9YFB5+RNnmbcR3PC8?=
 =?us-ascii?Q?JM2XCTWh3gpady8U7LU8/5dSJVBv5A6FLatb5clOm2YNHO665b0K7vIp7LWl?=
 =?us-ascii?Q?eUuE9I9/kZ1e5D5gze1QgIASiG0TpYacAqa67UwrNDTweYpNzRNMDSSgiXLu?=
 =?us-ascii?Q?cm0RfIYdimv9nkB8UNuRnEyXOfhCfD4KY/S/DHsjw2BAoz0XDl0AcbZxwC/T?=
 =?us-ascii?Q?IodkAhbzRP9PtUwiCz69qGLUDXjsd/Qj9I9xr6RA2G07jCHG3zX9Tp5vyrX+?=
 =?us-ascii?Q?MnRz8JUgjLi6WgZZq+b3GapqqqXm+hds4oaLG7buUwEQoeWRroun3rkGBx/3?=
 =?us-ascii?Q?BTLPfpsObXLgEHZQXCW2j61owyeG+Jv5K3NoQXKgOSx0gnmz+K/DSMXyK9+3?=
 =?us-ascii?Q?XV+tnQQno2T1EAWpD8uqO+SvDSL6MqoEoRlq45QRjN3adnqsSA2Hh9lP3aOL?=
 =?us-ascii?Q?/nNw7y4Sy1UxXn9203fX0+o+46yMyHkz6/Y/7cNg5iteuuazvn3GOU2X/ji+?=
 =?us-ascii?Q?Hslt0ZofaelqlZZVT4Y/t+ImOzkURuLqb3XBMbSKs0NU0+3USbMtxh7iLwkP?=
 =?us-ascii?Q?sO4NwrhNg62BDlvId58pcCAP2SHRrfcTf9GJ+vI2/ezwYRL3xCdQlZGmtfjB?=
 =?us-ascii?Q?iIez83EvCUg8XTOiT+uP6T3KwRzhjLlpt/9wyrln6rKgKp71G+gi1eNmuSCc?=
 =?us-ascii?Q?PCKGk61IGGyFs1EAn+E2X/zgWypgYGTe4ECCBuwBQtSqkpqBKbpWChIBP6do?=
 =?us-ascii?Q?Ipi0LOkH6zFDG7xcl/dFlRHgreGYCae03o3d+TQAY/f618/W1sgT4m7ZeXaR?=
 =?us-ascii?Q?hAYs3lWlupExgn6ikkE3KdHSD9F7v4FWnp/tB69no3fIegUZ6k4Mcv6Xk1zd?=
 =?us-ascii?Q?lAkZgifxP6PCIYttwkzU9zx8h8AlLMbHmt89EiYE0E97/kGMKzWXfl/SDIj8?=
 =?us-ascii?Q?tE9+jVZdtIR+U4mc1FWru+Dppa9sNks60SDT45eJRtrP5ZP7t1XBERqkTp+9?=
 =?us-ascii?Q?iMFaParwtMsusqZLc0oUskN4DlQgl16dcek8vaJsR2iIZRiqVYg/EDQ5U8k/?=
 =?us-ascii?Q?SINxonMMECN6tM+R7t5TUcONBnY50uspSKMLEIqNIL8XPYbDAEfcUmrtm+Uw?=
 =?us-ascii?Q?fJkgJQ+amKq7ytfyVXrZS1cxwyheDwwekPtzI2dA/v4OHYTQe6w0B+3sJuyx?=
 =?us-ascii?Q?7IJeikg6SrWIEJoF4CdLtB922eilkooWyhyRefTu2lUxzQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64731336-e127-4ee9-e3ba-08d92acdfbc9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 22:37:23.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7w3xwhC3cc5CuJw1lTz0gSxjphgZ0RST0aLF0kNnJLJ/QLjWTOdC6J5CRaBvnnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3350
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bUi6SxnIAyTM9y1bk2xRS0ZJKoqZcb5t
X-Proofpoint-ORIG-GUID: bUi6SxnIAyTM9y1bk2xRS0ZJKoqZcb5t
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=554 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 04:08:43PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Mon, Jun 07, 2021 at 06:31:23PM -0700, Roman Gushchin wrote:
> > Asynchronously try to release dying cgwbs by switching attached inodes
> > to the nearest living ancestor wb. It helps to get rid of per-cgroup
> > writeback structures themselves and of pinned memory and block cgroups,
> > which are significantly larger structures (mostly due to large per-cpu
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
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/fs-writeback.c                | 102 ++++++++++++++++++++++++++++---
> >  include/linux/backing-dev-defs.h |   1 +
> >  include/linux/writeback.h        |   1 +
> >  mm/backing-dev.c                 |  67 +++++++++++++++++++-
> >  4 files changed, 159 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 737ac27adb77..96eb6e6cdbc2 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -225,6 +225,12 @@ void wb_wait_for_completion(struct wb_completion *done)
> >  					/* one round can affect upto 5 slots */
> >  #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
> >  
> > +/*
> > + * Maximum inodes per isw.  A specific value has been chosen to make
> > + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> > + */
> > +#define WB_MAX_INODES_PER_ISW	115
> > +
> >  static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
> >  static struct workqueue_struct *isw_wq;
> >  
> > @@ -503,6 +509,24 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
> >  	atomic_dec(&isw_nr_in_flight);
> >  }
> >  
> > +static bool inode_prepare_wbs_switch(struct inode *inode,
> > +				     struct bdi_writeback *new_wb)
> > +{
> > +	/* while holding I_WB_SWITCH, no one else can update the association */
> > +	spin_lock(&inode->i_lock);
> > +	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> > +	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> > +	    inode_to_wb(inode) == new_wb) {
> > +		spin_unlock(&inode->i_lock);
> > +		return false;
> > +	}
> > +	inode->i_state |= I_WB_SWITCH;
> > +	__iget(inode);
> > +	spin_unlock(&inode->i_lock);
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * inode_switch_wbs - change the wb association of an inode
> >   * @inode: target inode
> > @@ -540,17 +564,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	if (!isw->new_wb)
> >  		goto out_free;
> >  
> > -	/* while holding I_WB_SWITCH, no one else can update the association */
> > -	spin_lock(&inode->i_lock);
> > -	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> > -	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> > -	    inode_to_wb(inode) == isw->new_wb) {
> > -		spin_unlock(&inode->i_lock);
> > +	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
> >  		goto out_free;
> > -	}
> > -	inode->i_state |= I_WB_SWITCH;
> > -	__iget(inode);
> > -	spin_unlock(&inode->i_lock);
> >  
> >  	isw->inodes[0] = inode;
> >  
> > @@ -571,6 +586,73 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	kfree(isw);
> >  }
> >  
> > +/**
> > + * cleanup_offline_cgwb - detach associated inodes
> > + * @wb: target wb
> > + *
> > + * Switch all inodes attached to @wb to a nearest living ancestor's wb in order
> > + * to eventually release the dying @wb.  Returns %true if not all inodes were
> > + * switched and the function has to be restarted.
> > + */
> > +bool cleanup_offline_cgwb(struct bdi_writeback *wb)
> > +{
> > +	struct cgroup_subsys_state *memcg_css;
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
> > +	atomic_inc(&isw_nr_in_flight);
> > +
> > +	for (memcg_css = wb->memcg_css->parent; memcg_css;
> > +	     memcg_css = memcg_css->parent) {
> > +		isw->new_wb = wb_get_lookup(wb->bdi, memcg_css);
> 
> Should this be wb_get_create()? I suspect intermediate cgroups wouldn't
> have cgwb's due to the no internal process constraint. cgwb's aren't
> like blkcgs where they pin the parent and maintain the tree hierarchy.

Yes, it's a good point. I'll change to wb_get_create() and send v9 soon.

Thank you!
