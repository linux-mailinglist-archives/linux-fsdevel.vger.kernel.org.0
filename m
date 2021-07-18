Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6A3CC9D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGRQLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 12:11:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230307AbhGRQLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 12:11:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IG3QJN003483;
        Sun, 18 Jul 2021 09:07:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=j17D4wYSZPwTgVStQmxWqR/RnK7egKWvd9tC0vbjGaM=;
 b=gyniGVK7xf7q8InRVkVf2D7LjyN0y1wbiNjkKKFOhk+DzwNu3sfeU24Q1jGFgZp61vy0
 2mkrmkGb7y0TmPiwLcuZ3hbbF8ZGM9hqPJYudUHdo7FQfUkIc9Q9HYKnx7enb/L6OZO4
 I5lKIjlRuCbV8vjVkcEgFrfL9SjdT9dc3IE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39uvb05h6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 18 Jul 2021 09:07:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 18 Jul 2021 09:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FriwXYhy86HsC3JKl5dVzcHfV9+s77n+jYqfBx9o/ItECMLhz+DRa8pgtSl8fc61hHU0ZJ+PMsYtzbJ+mldMw1oU7KMzO772zS0Jbsbo1HA1HQwPJc3lq0zG8M7w1uCoaMvcLNmJfmvNQCQq/J0wN65Byy8B3CrEFAhBh9Ooy9MQenav7nlku6QCjLacc7esk8MrPdrUzRPLenq82AYBAX1FAVT6ZptATs2TpNOkQlTSjUpeQU1oGnO6voACfFoyamp023Bb+EAazbXNO4J7vQn7geeD99abZl+tAQO6r484a3JMmtOps5izjV+sTzwhHpO40DsvBp1asHBdOIBxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j17D4wYSZPwTgVStQmxWqR/RnK7egKWvd9tC0vbjGaM=;
 b=e1mcNNNwAFDgXoq8bxR5fT0KJ0rxJyDHr1GISlpiK85481eKwCB5G3zFdv2WATj8OXwu3BIh+3e/Bq45ikcSjn0cU86pupJBqs7E2vKnsG78bnKHYPi0fEMFJsYr6koZzWX6xzqW/fkg7lGRc6+jtbk7IqnllOPR+H0POfmHuUi9GikojzXf+Fceo0Dteitlx7NStc9azHlVoa3Iu7LAGvC4e3axmcnX8vmBMMRoB/idyKzs+Hz5g7p+0a+WDiO9DUYPSSW/3JKDM0yktEvDlpYQCDgELKe/Due9VPbp2RsbZ2Jx6x3L2dP1dNDge68p0XOPCX5eK2j/5gaZY/DaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (20.177.229.24) by
 SJ0PR15MB4407.namprd15.prod.outlook.com (13.101.76.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Sun, 18 Jul 2021 16:07:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4331.032; Sun, 18 Jul 2021
 16:07:44 +0000
Date:   Sun, 18 Jul 2021 09:07:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPRRzS+WaQebrHmz@carbon.lan>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
 <20210717171713.GB22357@magnolia>
 <YPNU3BAfe97WrkMq@carbon.lan>
 <YPNnCItyLXWb3/dB@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YPNnCItyLXWb3/dB@casper.infradead.org>
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:c0dd) by BYAPR11CA0103.namprd11.prod.outlook.com (2603:10b6:a03:f4::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Sun, 18 Jul 2021 16:07:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d07f18-a478-407c-fe7b-08d94a062d50
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4407:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4407E6C3E0458649F9AB0A93BEE09@SJ0PR15MB4407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEl9psyKs5v2wmZVYVH1xFFaJ9dEtzXy7L6uZa29otbp6L91Zw/eR+5RB+lVj57qDg3z8DfFgAKZHHIzmz/mWVtoCZWk8V3FGSP9N/mma6K0OD98Oh+14MuSGH4UxASzY/qJO4GVOhL9CicFgEytmK7Mci2/Axe8s7DrGknu0d21oK4CoWPf1iouycuC84LZ06bt5XjdPhIw7A1dnM+i27hp93soGho7KjHQKn05/s7khbxhtqyS/ePrfW99k91dJtrIkfwLGD09ZkYvfc8wHYndF2YAXmXc41m/rNG+7gESzFdnrilMTCwpsA7etlHhzu1LCjwUVJHXDCuuOgqa2DAbBydYu1QK1t44MhQiw+NjijU9VUh4NioIKIsUeiUjGEHm9WQQ1NO72et0SUPnPLUl0WcJI/eBFVnfKZAHj8G+Vbheuc2kdiZ5lrxUfx6LziMI/u7qYxb68rBXruZAHsr0Hk+36QIkWeRbqPug1wQam2EpO2nwXKnDvxNKr4L38a4lIqf0RG4QkaRH+Ac2NfeNPwVSgGexl0+aCBcYy4ZQTrZ1y0y8ubSi7/iWtaixPH1KW5N1REAin6+ZCUVSn/wIlqbvDrFpNGnR6C9z8iYyiu8i24fZpexUmXTJosBrRWwmdUKG9T8LVF3nlN526NHy5w0kQyQHd5no3D8LnCll/TzbsnCTFWd6jVd+HT45
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(8676002)(38100700002)(7696005)(508600001)(36756003)(55016002)(9686003)(6506007)(54906003)(316002)(53546011)(6916009)(66946007)(66476007)(66556008)(186003)(2906002)(86362001)(83380400001)(4326008)(8936002)(8886007)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGq15uocT2p9GY0cmM6SktZN1de0UKk37151/7hasnsQiFslBGPvQ1gJgCq6?=
 =?us-ascii?Q?QcYypcT36nWhYOT7aKvE/JhUgWjWWp5AAwiyEWuvjUvCrIUJf6pRZrFqSIF7?=
 =?us-ascii?Q?Ul/7v2TGzw/sYmBhN29TyXeGdeMIKeBH/iWeeTxFM3rLvQ50KtZ9QIm2vXGE?=
 =?us-ascii?Q?x/ZUji0CesnexAwaVB5Jn32RUFQHQNpeA3tqSAdf+5qbmK1rJ+1LL9i5QbIY?=
 =?us-ascii?Q?sTx8B6VWhpRJTQAvNZe3QNh5fmaDo5IOFDz5XYdp8m24H64UMKbjLBC5Mmha?=
 =?us-ascii?Q?e1xhdrGAX0/MjgOzuRXBTBoRGa7GeuB5SIlH1uGlf9P0pDO4T8u07NxLBeie?=
 =?us-ascii?Q?jncJp7AG1YogGhXs06Ewf5tQvgE+FqxDdTXj5zSSgCxc+rjnstF0yysXjtQF?=
 =?us-ascii?Q?eGvyjncHqvwrS14Olc7Rv7mwXwyEv+xYVJ0quqp4cmsUwGHM2LcCpsC59G/b?=
 =?us-ascii?Q?2YmJsJArJ/FkcJsaN/izbKShPLIrd57AMmoRbOngLDSA+gpzIYgGUDQ3ApE2?=
 =?us-ascii?Q?CapVPUndUMGAbEBGxsafdEJkTYAtHgU65xiZW1uMjrYXYMOiBGgAHAHbh8Bt?=
 =?us-ascii?Q?hUyZvHk2UP84BCTDTbN7t3W3kiEgwItjKtmTyzW4AFXSgNPb9WxD6wScNiXa?=
 =?us-ascii?Q?ne1ctucDypFGTLNolH1vSWesemV0lLAQZCVK4DDzfVIYs6JaaEOudQgyfzZZ?=
 =?us-ascii?Q?8ZbmMsIjAXuomCx3F7h0u6DQLzmgj3jn0l/U6hlVyXWcW3F9NS/V2eiwJvlZ?=
 =?us-ascii?Q?OspV7LB6LTorKyjNwCSj8KcxMf05ULa9hn5cirZzYt2kFqtPRB+NAwM+sG3o?=
 =?us-ascii?Q?FK9kHArXuxu5nmiU6EaH2YAAJvqUK+bSx/wOWGbhWCd022mR351YQGbjxaCK?=
 =?us-ascii?Q?Rc03bc0LW8glmNUx6d9Ff6acGSUALRf0iUrHdQ5piIGlyykJVtQAg+jmr5qW?=
 =?us-ascii?Q?q0Frt1yy9PKjqmII2a37HuV8WaBe2n8rc6go93VeLOShUO+7nNTibvlR1/so?=
 =?us-ascii?Q?brWOkP1zDmTHZUd9OlyAeOZKeTg504rwgxvGkDwT9/MFm7ylHexMN0xf/n0o?=
 =?us-ascii?Q?5VspN71SNyvWdtt52jWZ7ZcaUl67CkdKr2K+PDQLTgQCKZSaiA9Kr5/BJfIl?=
 =?us-ascii?Q?Q/rBJ7fxzPq0tXYDaQA+ZRgVmt4+eAS/e+2CzgM8tvkFVJ7ePakOaD9+ywxb?=
 =?us-ascii?Q?joADYJilC9a4d3XQh37W2bndI1hXzcq7ytcb0R8R58JQf9PRfjaAnlj9x6OZ?=
 =?us-ascii?Q?FM7PoetKFtMm5HZKvembIQV5O/RFbdALCY+W9jmrFoxH+n5T4v5auzfwaZoU?=
 =?us-ascii?Q?hewBwsgu/G4WipORsMWl+LtcVBEXGMQkeo9mZ/qfuux8DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d07f18-a478-407c-fe7b-08d94a062d50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 16:07:44.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZigBAgakcwB7Hh1Sr4ZysPIlJFng+I1vCe1JQZzjns0dAMwvTYhvnTUKJT67qDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4407
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6BXd0PqtNXf88Mm9cNQVf5Dz8FQHA7ZO
X-Proofpoint-ORIG-GUID: 6BXd0PqtNXf88Mm9cNQVf5Dz8FQHA7ZO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-18_08:2021-07-16,2021-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:26:00AM +0100, Matthew Wilcox wrote:
> On Sat, Jul 17, 2021 at 03:08:28PM -0700, Roman Gushchin wrote:
> > On Sat, Jul 17, 2021 at 10:17:13AM -0700, Darrick J. Wong wrote:
> > > On Fri, Jul 16, 2021 at 01:13:05PM -0700, Roman Gushchin wrote:
> > > > On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> > > > > Hi,
> > > > > 
> > > > > On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > > > > > mount option:  -o dax=always
> > > > > > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > > > > > can hit this panic now.
> > > > > > >
> > > > > > > #It's not reproducible on ext4.
> > > > > > > #It's not reproducible without dax=always.
> > > > > >
> > > > > > Hi Murphy!
> > > > > >
> > > > > > Thank you for the report!
> > > > > >
> > > > > > Can you, please, check if the following patch fixes the problem?
> > > > > 
> > > > > No. Still the same panic.
> > > > 
> > > > Hm, can you, please, double check this? It seems that the patch fixes the
> > > > problem for others (of course, it can be a different problem).
> > > > CCed you on the proper patch, just sent to the list.
> > > > 
> > > > Otherwise, can you, please, say on which line of code the panic happens?
> > > > (using addr2line utility, for example)
> > > 
> > > I experience the same problem that Murphy does, and I tracked it down
> > > to this chunk of inode_do_switch_wbs:
> > > 
> > > 	/*
> > > 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
> > > 	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
> > > 	 * pages actually under writeback.
> > > 	 */
> > > 	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > here >>>>>>>>>> if (PageDirty(page)) {
> > > 			dec_wb_stat(old_wb, WB_RECLAIMABLE);
> > > 			inc_wb_stat(new_wb, WB_RECLAIMABLE);
> > > 		}
> > > 	}
> > > 
> > > I suspect that "page" is really a pfn to a pmem mapping and not a real
> > > struct page.
> > 
> > Good catch! Now it's clear that it's a different issue.
> > 
> > I think as now the best option is to ignore dax inodes completely.
> > Can you, please, confirm, that the following patch solves the problem?
> > 
> > Thanks!
> > 
> > --
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 06d04a74ab6c..4c3370548982 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -521,6 +521,9 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
> >          */
> >         smp_mb();
> >  
> > +       if (IS_DAX(inode))
> > +               return false;
> > +
> >         /* while holding I_WB_SWITCH, no one else can update the association */
> >         spin_lock(&inode->i_lock);
> >         if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> 
> That should work, but wouldn't it be better to test that at the top of
> inode_switch_wbs()?  Or even earlier?
> 

Hm, inode_switch_wbs() is not called from the cleanup path.
The cleanup path works like this:
  cleanup_offline_cgwbs_workfn()
    cleanup_offline_cgwb()
      inode_prepare_wbs_switch()
      inode_switch_wbs_work_fn()

While the generic switching path:
  inode_switch_wbs()
    inode_prepare_wbs_switch()
    inode_switch_wbs_work_fn()

Thanks!
