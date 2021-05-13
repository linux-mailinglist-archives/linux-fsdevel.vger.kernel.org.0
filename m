Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52B37FD16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEMSNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 14:13:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhEMSNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 14:13:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DIBdTG012204;
        Thu, 13 May 2021 11:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+kkgakILbWTJbTE/kHSm7xES1n0DeUFJYq+koPqRhYA=;
 b=IT8QEuFdx1ZZoJRPdQIBkrNAeTB1paXbzERM2Im+sbzaUlSX1ghozNLmpX+iwdTtrm9F
 F+nfXjVuDlJGWZgUbBAt4rarxKBnlrpgV3K3znrAk9E36Hl/qpCOnrihjUVk9xY/UyVn
 jqJwKx6bQl7WQc3bChxb6s5gz/1/5NExPx0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38gpm8wm49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 May 2021 11:12:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 11:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRnn8wjTDhuJ0SgHQBShoWr45mviCu+Ba5rMpgDJf9zeW1K2WzcNHq2aplw9O7jwdcfUqpu5yXsmS+/fc49I8opP2FTWXXLTrZSDzjSI1Bjt0t3Sr1LPdbsBMQtQ8rBJ8TZqiuyv6Io37W83MbmkZSYCX34HV3Du/ao2WA9ICBu5JfKM2/EGjw6dSzxTkBtS1i9Ea35LpOcqXVrxarAPQi8Jd9IWAiJGblZvRAxay2JHXoU/LnZKpu8pZwaplzPnqAg8mAITLMgc2zFcMC6O2B9QNz8s/Tj/NsrFvppqXS9mbtLHSj9yqZ4NUJUogVa8CfWvseV2/g6KWqZwXUCNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kkgakILbWTJbTE/kHSm7xES1n0DeUFJYq+koPqRhYA=;
 b=UKtI/zLKYJRw2Kxt0aGwxnfk3o4vmOIdl9r/3L9oXaM4dJTn/L+sRt+J1JbUcSgjwgjbzTgrlAHzWQjfZvG4rBJvKnEyv1AsBclmEbMT3SMSAjSsSPYoH0j5M1mIDvAB5bYylj/LYNc0g7mOAlgJuqKWXcWcXbWw/InNapQ/osGHori5lsf40mLumUbNtFMnTxHOZ1w6e5TadPbLu0Ldget1KKA6WSRXzS/ihn0S+1F3AHr+qo1nQOHSBoibcS+NvvDXKwY/DJkF83j34QBs41f+3MMBmeRpJrLh8wNz1KwNCmye22lPByVNwWeIRD3QjWeWygcxsCxf0Unn5ODfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4325.namprd15.prod.outlook.com (2603:10b6:a03:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 18:12:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:12:22 +0000
Date:   Thu, 13 May 2021 11:12:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YJ1sALo2KaP813Dy@carbon.DHCP.thefacebook.com>
References: <20210513004258.1610273-1-guro@fb.com>
 <20210513101239.GE2734@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210513101239.GE2734@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:d527]
X-ClientProxiedBy: MWHPR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:320:31::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:d527) by MWHPR18CA0046.namprd18.prod.outlook.com (2603:10b6:320:31::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 18:12:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280d3937-ed4b-4280-e8f4-08d9163aa751
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4325:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43259768BD9F12AAEF9E633EBE519@SJ0PR15MB4325.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeiAPZp9cWqnmMQgeVX5DcpLrMED9carW21O2yloaq2pPomKoHre2nbRoL4QtrvcMS++wQ/it2edHaJCl6Y3Yq3qVXm7kbQofJdM3q04+sVRDycPw1lvrFpNviyfA6vtvniKql3uW0Z6w9BmR+2KbGX+c/lhhI6Y1yiv8bDKIofktltvXDNp8Rk6d0pc5+KBZg2B7Nhgb3pbRRHK1j7c09sVvYmq8uhpOtpcU4TpcoSe/qRmu1ALjdDM9fx7k3gNmZ0YQtKpmpyi8aJHFbREWxLWQAcFMvK7C1AWDMS1B9jcwXmzTwcgRaIz8aRc9jPpBRiL6C4gdHOKC2o+JRCk3LwadHwI+efg7id7qgPTt/DcwKd0fNWpDtvu3YsnfdaTCz1Sq4SmSTs3Wb54IrnbbczEAYnXSI1mh862o9Er6gFzRwS18SlMp8HyALUbq96IDAS8liRjSUFPx6nTOYb3XmYnfkEs2Yrl63JCYCwbhjhyvoGC7S8otvA8FbJq0gHh5OWMcldgCClMYkSYYm9YacOHQY9hVzYiwnvd+vFdNbJ3ifRKvxtSVgnF2QBUiPmItza89fEpy6lPOocoYgtMRkP3REwXrz6SIsSCePG1fGRj6q1WhEV0bmB90BAc2kILfNRpW2Emqk9IgNTxPUXMow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(6916009)(478600001)(66476007)(6506007)(6666004)(83380400001)(8676002)(9686003)(4326008)(54906003)(86362001)(55016002)(66556008)(52116002)(38100700002)(2906002)(66946007)(16526019)(5660300002)(316002)(7696005)(186003)(8936002)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wfAcrxmD+gdopejVU0NMBNOGPqII3/zXNgcn2H8zf27OHGGtR3CMdSWdtGqd?=
 =?us-ascii?Q?GOlAwQsSPfLl6bfzSdhfaiGAXMhYvVt4kvg88CGQYBAgdFXNyPhdgWqfb02Y?=
 =?us-ascii?Q?Vu0x59vZy9cMHt1LzVDPVkQWi083nhc1tGC7BYomtuqnEZJCb7yQcNtXN6fz?=
 =?us-ascii?Q?FbIQDh+zWGO9JK3Y/GfQ2wqhqqV8LdLrtMaSKtZhajomRqN8N+oVkeHAeNLA?=
 =?us-ascii?Q?pI0rlOWJCnBuhGsVADmbMj5UYHF3p1ybFPj3bhgVEP6VjczNOqk66eJqsmao?=
 =?us-ascii?Q?aRTLfvQO0JDXo8ObjZUTJFyryYZs/jgaCYAuR/5By+xP6R1gzYW9ZzJRuTQs?=
 =?us-ascii?Q?Ml034QjY0U1lIoblMEWUrnSmhj5QggeSdMs55t0WDChVf9dPEUEJUNMpMEI4?=
 =?us-ascii?Q?3u9uHj7pPNQXFCcqydjZVbtnWZesQ9+UM4QSCxoQ5k1ldMWtjSKIKKOdKlSy?=
 =?us-ascii?Q?E0ZYFDLQwqwXD8Xy+1OKIj2Oh1nNzDMaywqNk0s8ad3dyl8GR9KRWgR9GnkK?=
 =?us-ascii?Q?IhacvpXgFe6gdM8M3t4o+7sSUD9S89vgwO4u/NYW7Y0Wrxf0sr1mP7ApBOQd?=
 =?us-ascii?Q?UwSYrbIUKhypstkON1jKTICN/wvlv+1nLUa+XCrewjBAegtbIzZl3KTVz8wt?=
 =?us-ascii?Q?EFAeoUO9xMm+urtjxyIWVTRek5C32bAoBOe10/6FMXMOZbRmGe7F9bsCoMVV?=
 =?us-ascii?Q?RxF0gnJq6+7UADiqCrTuPLF4OsXZrj/sK+uH7aP40NdBj3rOO6IUDLvzu2QW?=
 =?us-ascii?Q?xUTBJNTb4Nz33myKjMv5Z3Z13CmsuP62urpMynj/BUfRRiGXXCGFT/QoRinI?=
 =?us-ascii?Q?NMPbnYa9trhNqRQ55dvEu48aKyG+433JV3a4mCotRgRqrXiaSF+qpjrBjOtz?=
 =?us-ascii?Q?ZJJJFWYoaowi50Mlle3Gn/ZXitHt6xe6MfSkg37ZB5hSHfE6rWDFH8iVJw1n?=
 =?us-ascii?Q?tElEWpchP+p71p+V+5G3cFScZcXssU20AFqbRQuDzf2sa51DuFzGptWDWWuD?=
 =?us-ascii?Q?qgbxorH0uRsJILN5oB81lt2TJd+M52JbkZC81rS7sgS8BgtpHjrWAH0rpf3c?=
 =?us-ascii?Q?TUq0SUMxs7kZfeUagxQ6B/7nOWmLrrpaUJP+WQjuQPEEUwOyUoLmfxmMeTBU?=
 =?us-ascii?Q?JuHUisSLF3DJlrXAeitrpJoamCh6pDBxaYgnqwJE58QS3UNXkv0s/XuGOMeM?=
 =?us-ascii?Q?sqFpURGf2lLlSP3K2KhN4pIcivlrwe32xgCTorSzUelaHVoF77rZCn4GPrPe?=
 =?us-ascii?Q?YR73kdet/Jo9slwYoNu1glQCoW5Dxrxfwq14s3YJervHe6AF/lV12ZsrHJjc?=
 =?us-ascii?Q?/ugquytSOYPt7gVXrsb6FsMWQ239LNvgvZZjNWpBGc+sVg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 280d3937-ed4b-4280-e8f4-08d9163aa751
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:12:22.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9cC0UD+wcFOSqWwEobseZEzZKCdqymg/RrtxOh96Q7JI/eNz9mrCAbiu6jJKH4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4325
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GDD7vQ4zyUcgN4BD8jEgmj-rlQIWTgf3
X-Proofpoint-GUID: GDD7vQ4zyUcgN4BD8jEgmj-rlQIWTgf3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_10:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 12:12:39PM +0200, Jan Kara wrote:
> On Wed 12-05-21 17:42:58, Roman Gushchin wrote:
> > When an inode is getting dirty for the first time it's associated
> > with a wb structure (see __inode_attach_wb()). It can later be
> > switched to another wb (if e.g. some other cgroup is writing a lot of
> > data to the same inode), but otherwise stays attached to the original
> > wb until being reclaimed.
> > 
> > The problem is that the wb structure holds a reference to the original
> > memory and blkcg cgroups. So if an inode has been dirty once and later
> > is actively used in read-only mode, it has a good chance to pin down
> > the original memory and blkcg cgroups. This is often the case with
> > services bringing data for other services, e.g. updating some rpm
> > packages.
> > 
> > In the real life it becomes a problem due to a large size of the memcg
> > structure, which can easily be 1000x larger than an inode. Also a
> > really large number of dying cgroups can raise different scalability
> > issues, e.g. making the memory reclaim costly and less effective.
> > 
> > To solve the problem inodes should be eventually detached from the
> > corresponding writeback structure. It's inefficient to do it after
> > every writeback completion. Instead it can be done whenever the
> > original memory cgroup is offlined and writeback structure is getting
> > killed. Scanning over a (potentially long) list of inodes and detach
> > them from the writeback structure can take quite some time. To avoid
> > scanning all inodes, attached inodes are kept on a new list (b_attached).
> > To make it less noticeable to a user, the scanning is performed from a
> > work context.
> > 
> > Big thanks to Jan Kara and Dennis Zhou for their ideas and
> > contribution to the previous iterations of this patch.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Thanks for the patch! On a general note maybe it would be better to split
> this patch into two - the first one which introduces b_attached list and
> its handling and the second one which uses it to detach inodes from
> bdi_writeback structures. Some more comments below.

Good idea, will do in the next version. And thank you for taking a look!

> 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index e91980f49388..3deba686d3d4 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -123,12 +123,17 @@ static bool inode_io_list_move_locked(struct inode *inode,
> >  
> >  	list_move(&inode->i_io_list, head);
> >  
> > -	/* dirty_time doesn't count as dirty_io until expiration */
> > -	if (head != &wb->b_dirty_time)
> > -		return wb_io_lists_populated(wb);
> > +	if (head == &wb->b_dirty_time || head == &wb->b_attached) {
> > +		/*
> > +		 * dirty_time doesn't count as dirty_io until expiration,
> > +		 * attached list keeps a list of clean inodes, which are
> > +		 * attached to wb.
> > +		 */
> > +		wb_io_lists_depopulated(wb);
> > +		return false;
> > +	}
> >  
> > -	wb_io_lists_depopulated(wb);
> > -	return false;
> > +	return wb_io_lists_populated(wb);
> >  }
> >  
> >  /**
> > @@ -545,6 +550,37 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	kfree(isw);
> >  }
> 
> I suppose the list_empty(&inode->i_io_list) case in
> inode_switch_wbs_work_fn() is impossible with your changes now? Can you
> perhaps add a WARN_ON_ONCE there for this? Also I don't think we want to
> move clean inodes to dirty list so perhaps we need to be more careful about
> the selection of target writeback list in that function?

Good point, will add in the next version and double check the clean inode case.

> 
> > +/**
> > + * cleanup_offline_wb - detach attached clean inodes
> > + * @wb: target wb
> > + *
> > + * Clear the ->i_wb pointer of the attached inodes and drop
> > + * the corresponding wb reference. Skip inodes which are dirty,
> > + * freeing, switching or in the active writeback process.
> > + *
> > + */
> > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > +{
> > +	struct inode *inode, *tmp;
> > +
> > +	spin_lock(&wb->list_lock);
> > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > +		if (!spin_trylock(&inode->i_lock))
> > +			continue;
> > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > +		if (!(inode->i_state &
> > +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
> 
> Use I_DIRTY_ALL here instead of I_DIRTY? We don't want to touch
> I_DIRTY_TIME inodes either I'd say... Also I think you don't want to touch
> I_WILL_FREE inodes either.

You're right, will fix it.

> 
> > +			WARN_ON_ONCE(inode->i_wb != wb);
> > +			inode->i_wb = NULL;
> > +			wb_put(wb);
> > +			list_del_init(&inode->i_io_list);
> 
> So I was thinking about this and I'm still a bit nervous that setting i_wb
> to NULL is going to cause subtle crashes somewhere. Granted you are very
> careful when not to touch the inode but still, even stuff like
> inode_to_bdi() is not safe to call with inode->i_wb is NULL. So I'm afraid
> that some place in the writeback code will be looking at i_wb without
> having any of those bits set and boom. E.g. inode_to_wb() call in
> test_clear_page_writeback() - what protects that one?

I assume that if the page is dirty/under the writeback, the inode must be dirty
too, so we can't zero inode->i_wb.

> 
> I forgot what possibilities did we already discuss in the past but cannot
> we just switch inode->i_wb to inode_to_bdi(inode)->wb (i.e., root cgroup
> writeback structure)? That would be certainly safer...

I am/was nervous too. I had several BUG_ON()'s in all such places and ran
the test kernel for about a day on my dev desktop (even updated to Fedora
34 lol), and haven't seen any panics. And certainly I can give it a
comprehensive test in a more production environment.

Re switching to the root wb: it's certainly a possibility too, however
zeroing has an advantage: the next potential writeback will be accounted
to the right cgroup without a need in an additional switch.
I'd try to go with zeroing if it's possible, and keep the switching to the
root wb as plab B.

> 
> > +		}
> > +		xa_unlock_irq(&inode->i_mapping->i_pages);
> > +		spin_unlock(&inode->i_lock);
> > +	}
> > +	spin_unlock(&wb->list_lock);
> > +}
> > +
> ...
> > @@ -386,6 +395,10 @@ static void cgwb_release_workfn(struct work_struct *work)
> >  	mutex_lock(&wb->bdi->cgwb_release_mutex);
> >  	wb_shutdown(wb);
> >  
> > +	spin_lock_irq(&cgwb_lock);
> > +	list_del(&wb->offline_node);
> > +	spin_unlock_irq(&cgwb_lock);
> > +
> >  	css_put(wb->memcg_css);
> >  	css_put(wb->blkcg_css);
> >  	mutex_unlock(&wb->bdi->cgwb_release_mutex);
> > @@ -413,6 +426,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
> >  	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
> >  	list_del(&wb->memcg_node);
> >  	list_del(&wb->blkcg_node);
> > +	list_add(&wb->offline_node, &offline_cgwbs);
> >  	percpu_ref_kill(&wb->refcnt);
> >  }
> 
> I think you need to be a bit more careful with the wb->offline_node.
> cgwb_create() can end up destroying half-created bdi_writeback structure on
> error and then you'd see cgwb_release_workfn() called without cgwb_kill()
> called and you'd likely crash or corrupt memory.

Good point, will check it.

> 
> >  
> > @@ -633,6 +647,48 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
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
> > +
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
> > +		wb_put(wb);
> > +	}
> > +
> > +	if (!list_empty(&processed))
> > +		list_splice_tail(&processed, &offline_cgwbs);
> > +
> > +	spin_unlock_irq(&cgwb_lock);
> 
> Shouldn't we reschedule this work with some delay if offline_cgwbs is
> non-empty? Otherwise we can end up with non-empty &offline_cgwbs and no
> cleaning scheduled...

I'm not sure. In general it's not a big problem to have few outstanding
wb structures, we just need to make sure we don't pile them.
I'm scheduling the cleanup from the memcg offlining path, so if new cgroups
are regularly created and destroyed, some pressure will be applied.

To reschedule based on time we need to come up with some heuristic how to
calculate the required delay and I don't have any specific ideas. If you do,
I'm totally fine to incorporate them.

Thanks!
