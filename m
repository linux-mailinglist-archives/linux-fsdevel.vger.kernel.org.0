Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D744380A69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhENNdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 09:33:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233966AbhENNdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 09:33:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EDTYIs018332;
        Fri, 14 May 2021 06:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rGbn2MMPU+fF/C7cWp8fw5UPU5KEHS12UZbiGqS9N2E=;
 b=MNterIN4JWn6qWZ9LkARnALIZUqWctv4I+MUTk3xRF0kTEw0QhlLFRel1keUxZYZkr+e
 HjFUA0QbhJM7BLT40ldCE+sAF/CEEnPpenbSNJ2+6ABfGULrE0LkyOdXJU0ChlSqgdP6
 uCG2+cJ+LSM9ac2hxIQpA9+hRBXrSjafccc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38gpm7absk-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 06:31:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 06:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joahzGVq2oQbzmYsT+DoI2V8FBBYkYdve1lPCa6vSY7l5OWceknrFjrXYv97W9P3AA3YSE6YuE55pxWiKz0VbqyGw3uyCXycSnANG5JH63GiInBoeGIazLbcwfGRZhdFMQri5h4wl1e7LyfW5NSbW1H6NK2DpJpjHI/xNMEPntai2JyfAywp8vyxcKVxKwJbIrNqUtbjIYW/lrCJs1TQqtGOkZY4GC3WI+vKSPcOLPPiYIknEt0an1JW/3OgcM79bThBIWwwLW9TmbM5lu0D2Wgmq3Nv6fjDMVfX8UP4pR1ZioZzFNVmJy4C8Mx6100hdHU6sIbJ+11PHmIR8x86gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGbn2MMPU+fF/C7cWp8fw5UPU5KEHS12UZbiGqS9N2E=;
 b=EyxhpswVI/Upa2i3qqMYvXmdc32Lg22CNby7gAjspXj41N8qHP7GK7MpNACYqRnToik5FwUGrpLQWW99Uxk/UJy4JyiR+O5zsDE13C428ttoStVZpDy/s/Sd6GAmdAhx4yqY81tKLtxc3lJ3urR7pwANxFMzQ1W7T2lAxQRVF5foPKiqhA8uGQu9i9eBO6YsqFyR+MKqwmHThG4JFIYTzLJQ+tkMplIuUWISziCO/BWGdqsBJU615iCeyOgRbceGLonWncBpP+HzndADfSKb/FSyzx5pglV0xn8WM75qKUZxuuObGEmvQLeVKKx4pTZqrCzC9lo09JijDDIHUr6RcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4156.namprd15.prod.outlook.com (2603:10b6:a03:2e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 13:31:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 13:31:43 +0000
Date:   Fri, 14 May 2021 06:31:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YJ57u0v5K9MXQxoP@carbon.DHCP.thefacebook.com>
References: <20210513004258.1610273-1-guro@fb.com>
 <20210513101239.GE2734@quack2.suse.cz>
 <YJ1sALo2KaP813Dy@carbon.DHCP.thefacebook.com>
 <20210514112320.GB27655@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210514112320.GB27655@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:bd46]
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:bd46) by MWHPR1701CA0015.namprd17.prod.outlook.com (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 13:31:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10d84c8-87df-4609-add7-08d916dc9d0d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4156:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4156C64B444775DC3717417EBE509@SJ0PR15MB4156.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBerxeBeO2Jadg6S3zzbDYGY0yeA3tsO0TJzZMqP9CnR7gvaRLMEfZk2hTzRVKArzDl4RIAWtkOoIwamCWpe5XUNtZUiJLynBEZCtKgD38Jee3q9CDdrG6dWebPfrPY+LNLnETjpgmM7Ntg1thR/WTxjTOoBC1aBtWu50PwK29GZH5vcgoDgpLNb5RbBnhRTktTck9QI8kgeRuglQHl8donGZuALxmhw/q0CeSFPiwZ3/GUK27pHAKROtYGDUFzxKSCBP4PfVresFj9y3cH7pcEeOG/fNhkGE24UV7vOgiaxPYU/fqWaT+FlZDUNhZQUIPI/HK1OxTpbBnZd8zlUTSeROrPt5o2vaDkJBHYjU0i+eXWvkTGy7LIYHUlGuFNKOpy4W1MZj4pkBJtqrGqQw0HpxXnPKvyIQNFWWY6ileqCgXF9wy1WyzOQgOPAEOD1R/L7T0XzKdjsQAsiPZjm6Tz1y30aG7ogwSuMxL+aQAEwxOEMPpKa6pNwhhqBnBcFOP+zEzS9UkRaEeFlqVfnYuAq/KZdIxgYX4lpB63W1f2mm6GwBRWaOLnXt0rEvJJf+yarVraXOPMEpwY9ZrU9ef/0zjhLTRG6+hGxeCoBL5LekEZWPSxBJP92dEu9vUOpobj9ap/n0u38wJqNcI2u4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(38100700002)(5660300002)(316002)(8936002)(55016002)(186003)(6506007)(86362001)(7696005)(16526019)(478600001)(66946007)(83380400001)(66556008)(66476007)(52116002)(8676002)(6916009)(6666004)(2906002)(9686003)(4326008)(54906003)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GITCbl4vI2MAn9gWD+QLrVe4f0M6MYKHEjfxI+14DM5yzLZxyppjNxbOzolk?=
 =?us-ascii?Q?HpL3H5FivA+irYh6TiJP1Gs0ikNFonQrYiBuZP0x9y8RDQM/qK/G3fGJIxnr?=
 =?us-ascii?Q?xH3fak/3GPCTZIgwLI40JsYwU8PX8r+3ZWRsOT0YFd7twZd0bgHD1ZZmT4jS?=
 =?us-ascii?Q?vspnIte9PXy34PhzgZBYI7vGayQms3iTtk3ZL9Q4HnF18QwcUGnnKbRMQ3Kd?=
 =?us-ascii?Q?r6jQdXtJMII7b3O9N6aPn1eYHnuqj5K96IcCUem041Pky658fhaKlr7wf6W8?=
 =?us-ascii?Q?2sUhF67XzsOISCrvm1zn1/slALSt2hnSY1hsVN0ksysPm1PcSQ6orxmx++q6?=
 =?us-ascii?Q?dFsMjy/WF2xCnVxL2bZmGkMZuZo+X5bGFwwaKCcvDVQlyn6HGSA162cdm9ga?=
 =?us-ascii?Q?ua5W/PNTzr2Lob5nD17kUKsDy+tH5t3l+ylWthFae0ILrMfjJX7XDhJAwyJq?=
 =?us-ascii?Q?cv3UW1rJ+dnMyKsFaNt2hjr0+BXRP5+zhpGmpe2efDD0MwZ14EGsOFxzNXlX?=
 =?us-ascii?Q?tep+e9dYk5XOWSzZ7oKd0bIt6oftgVLTDQL+gADiMrkpEUXFbK72xB2KIQX0?=
 =?us-ascii?Q?R2h+uJZZDI8rQgIDc5F1s5/qpMWEv0A/XJF+MgCMdJsp2sKLJ1Bt8hW2p2ng?=
 =?us-ascii?Q?ycxFkoLRDn+eKwr4furaoCwyBkI1NrZ/ZVJ58dfcHrdoknNjePqGzV3yiIun?=
 =?us-ascii?Q?Z3ZiF9iHfJc0YE1nki6xS5TngvVtAUe4XiBKDX0CQfzfYBbpwkawmIyDw06e?=
 =?us-ascii?Q?wxTwOqmIrfcCT+pTiHzgQ+j1wWINd5geBOMe89DeBTEdXNlY/6TF8Par03Z+?=
 =?us-ascii?Q?Sy3b4+ylg0XrY1VYPb2KuHuLelBtcpvQ3WopvIVip/M6R4jVeYe4Q7mS+YmJ?=
 =?us-ascii?Q?n4ZhBzvCabs2AACO2y5Yn3rSi+kmBgDyn6owGqNezqFP84+s4yFxTmMl9zZl?=
 =?us-ascii?Q?9NUpaZbxiDsX3m0QgSlOKkTM2a3jnCmYY0rq08chsKRX6RJW2CvlidhjFjbo?=
 =?us-ascii?Q?jv9IPyj4bi3KqsCXHa3aEjYSpmu3eD2x3pDuGuV7pVoVnROitkSzBAO7ibcR?=
 =?us-ascii?Q?UWVb46oQv1AKa6e/BdtRhlwNEmHV5d+ehIe87PoSfxfOUclZ0CJEZ3nILvqi?=
 =?us-ascii?Q?w/B2+DrxdxNt2iSiDfisuZC8DMHQr+k/vBcT1yh2h7Q1pXDJtTs5sVnZ3zEz?=
 =?us-ascii?Q?YwAdK/IEi3TbC7ycL1posDrSSkYaKYLoPHFP0ylcRw8ZEvgWVNsjXssG6gN1?=
 =?us-ascii?Q?rc9gPtGtPapJy+AC9FKMqJ2sHbqy8GPmamxB1NeFl8xU/KNLT5QD6IxbN7t7?=
 =?us-ascii?Q?RG9CUQ34a6hMTK4JfXNdOP8AQ59A7ftQ5tggSeZYEMJ36Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b10d84c8-87df-4609-add7-08d916dc9d0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 13:31:43.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3fTwiQUkA7ZcHXDNdWqx2hf1fl83xBc4Ri1OX73XvKeKCIf9Lv8oHFnYV4tTzVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4156
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: sHpoalfqcelkM0S-84lEtX-H7MuxAhYB
X-Proofpoint-ORIG-GUID: sHpoalfqcelkM0S-84lEtX-H7MuxAhYB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 01:23:20PM +0200, Jan Kara wrote:
> On Thu 13-05-21 11:12:16, Roman Gushchin wrote:
> > On Thu, May 13, 2021 at 12:12:39PM +0200, Jan Kara wrote:
> > > On Wed 12-05-21 17:42:58, Roman Gushchin wrote:
> > > > +			WARN_ON_ONCE(inode->i_wb != wb);
> > > > +			inode->i_wb = NULL;
> > > > +			wb_put(wb);
> > > > +			list_del_init(&inode->i_io_list);
> > > 
> > > So I was thinking about this and I'm still a bit nervous that setting i_wb
> > > to NULL is going to cause subtle crashes somewhere. Granted you are very
> > > careful when not to touch the inode but still, even stuff like
> > > inode_to_bdi() is not safe to call with inode->i_wb is NULL. So I'm afraid
> > > that some place in the writeback code will be looking at i_wb without
> > > having any of those bits set and boom. E.g. inode_to_wb() call in
> > > test_clear_page_writeback() - what protects that one?
> > 
> > I assume that if the page is dirty/under the writeback, the inode must be
> > dirty too, so we can't zero inode->i_wb.
> 
> If page is under writeback, the inode can be already clean. You could check
>   !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)
> but see how fragile it is... For every place using inode_to_wb() you have
> to come up with a test excluding it...
> 
> > > I forgot what possibilities did we already discuss in the past but cannot
> > > we just switch inode->i_wb to inode_to_bdi(inode)->wb (i.e., root cgroup
> > > writeback structure)? That would be certainly safer...
> > 
> > I am/was nervous too. I had several BUG_ON()'s in all such places and ran
> > the test kernel for about a day on my dev desktop (even updated to Fedora
> > 34 lol), and haven't seen any panics. And certainly I can give it a
> > comprehensive test in a more production environment.
> 
> I appreciate the testing but it is also about how likely this is to break
> sometime in future because someone unaware of this corner-case will add new
> inode_to_wb() call not excluded by one of your conditions.

Ok, you convinced me, will change in the next version.

> 
> > Re switching to the root wb: it's certainly a possibility too, however
> > zeroing has an advantage: the next potential writeback will be accounted
> > to the right cgroup without a need in an additional switch.
> > I'd try to go with zeroing if it's possible, and keep the switching to the
> > root wb as plab B.
> 
> Yes, there will be the cost of an additional switch. But inodes attached to
> dying cgroups shouldn't be the fast path anyway so does it matter?
> 
> > > > @@ -633,6 +647,48 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
> > > >  	mutex_unlock(&bdi->cgwb_release_mutex);
> > > >  }
> > > >  
> > > > +/**
> > > > + * cleanup_offline_cgwbs - try to release dying cgwbs
> > > > + *
> > > > + * Try to release dying cgwbs by switching attached inodes to the wb
> > > > + * belonging to the root memory cgroup. Processed wbs are placed at the
> > > > + * end of the list to guarantee the forward progress.
> > > > + *
> > > > + * Should be called with the acquired cgwb_lock lock, which might
> > > > + * be released and re-acquired in the process.
> > > > + */
> > > > +static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > > > +{
> > > > +	struct bdi_writeback *wb;
> > > > +	LIST_HEAD(processed);
> > > > +
> > > > +	spin_lock_irq(&cgwb_lock);
> > > > +
> > > > +	while (!list_empty(&offline_cgwbs)) {
> > > > +		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > > > +				      offline_node);
> > > > +
> > > > +		list_move(&wb->offline_node, &processed);
> > > > +
> > > > +		if (wb_has_dirty_io(wb))
> > > > +			continue;
> > > > +
> > > > +		if (!percpu_ref_tryget(&wb->refcnt))
> > > > +			continue;
> > > > +
> > > > +		spin_unlock_irq(&cgwb_lock);
> > > > +		cleanup_offline_wb(wb);
> > > > +		spin_lock_irq(&cgwb_lock);
> > > > +
> > > > +		wb_put(wb);
> > > > +	}
> > > > +
> > > > +	if (!list_empty(&processed))
> > > > +		list_splice_tail(&processed, &offline_cgwbs);
> > > > +
> > > > +	spin_unlock_irq(&cgwb_lock);
> > > 
> > > Shouldn't we reschedule this work with some delay if offline_cgwbs is
> > > non-empty? Otherwise we can end up with non-empty &offline_cgwbs and no
> > > cleaning scheduled...
> > 
> > I'm not sure. In general it's not a big problem to have few outstanding
> > wb structures, we just need to make sure we don't pile them.
> > I'm scheduling the cleanup from the memcg offlining path, so if new cgroups
> > are regularly created and destroyed, some pressure will be applied.
> > 
> > To reschedule based on time we need to come up with some heuristic how to
> > calculate the required delay and I don't have any specific ideas. If you do,
> > I'm totally fine to incorporate them.
> 
> Well, I'd pick e.g. dirty_expire_interval (30s by default) as a time after
> which we try again. Because after that time writeback has likely already
> happened. But I don't insist here. If you think leaving inodes attached to
> dead cgroups for potentially long time in some cases isn't a problem, then
> we can leave this as is. If we find it's a problem in the future, we can
> always add the time-based retry.

Yes, I agree, we can add it later.

Thank you!

Roman
