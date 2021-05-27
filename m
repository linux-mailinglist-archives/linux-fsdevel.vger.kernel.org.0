Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA373393409
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhE0Qet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 12:34:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235001AbhE0Qer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 12:34:47 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGUebm026612;
        Thu, 27 May 2021 09:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kBZoW71KNvinWsNxpEHmdIjaAW5oZLgT6CohaQ2MJms=;
 b=ideZhw5e52FYLchVn7XLAX7ZkU/NyaZSUpmXyk6mjxP9Ju8FLlBIhx1eJjCfqu6Q3GL5
 sYZb1PUvfrsDyBbjuvPGLgFc9DIyRs85n5PgmMOXfaN+B+qTPHINSYhm7cluaCiraJ+x
 VAgS2ZMNGPenenxhDJkghuGEictU1gW6yr8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38sshs7qx5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 May 2021 09:33:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 09:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLBh0S82w3uSmbdS7GPaNJ+U8Y7qT9enLXO2B5AqJeMOnpVXWzR3MlKguvMPfPWD8VDtNZAGuRWIxYuYcRMAQES9pRitbyfsL71ncYarov44aywXFRClm7vCuO25otRiDq/5gHj/5peYVV0h6VzxBkoY4kxHejphn70Es9ItkSCtrXRdjwjcwpFbCgq+DQsKcLWHezgLGN0s7a+KtOj2sEJX/0E/M9FdPvePr/Jk8TD8RqlX0+qTdZwo5wOrXnY64zv/a8dO9vRKhcTK6CCPt59gD2CRDOklQcBdf6bEsbvQ9obuqEx5mOUDSyuhXUxA1oGCYDcrVbzTI6V/FdDxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZoW71KNvinWsNxpEHmdIjaAW5oZLgT6CohaQ2MJms=;
 b=IfldWdq4lleCcDCe2n3Yb8G49kUA/Y2z5DuS3oJRSQsgmYK6y+5/eMupTjOXo6eCBH1Gi2igfWajANfFMz7kkwU6mLoz6krpYhuaJ/Sx8jkHXkNEOVh+EhTfzfYBJLpBIH0FfJGoplXyFPl38GDru4YwCVcVJv5BRTelZOW3+WjihjMU7LGHmO/82PnHqtsFsvPlev2Om8k9g6chq3qNwKzGVPn39UlSNZFEfsUeRqfD7cocf9VGAoIFknQcle5o6HtDgIx5AvICmT+GUfhwQ9o+S+L0ZYrwR2Be3fLVJdvbn9kDrZZ+CCJr5OPsHUZWYi3nQ3d8WkqOiL3hEVJGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA1PR15MB4769.namprd15.prod.outlook.com
 (2603:10b6:806:19d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 16:33:02 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 16:33:02 +0000
Date:   Thu, 27 May 2021 09:32:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] writeback, cgroup: keep list of inodes attached
 to bdi_writeback
Message-ID: <YK/JueoCO4LisjDo@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-2-guro@fb.com>
 <20210527103517.GA24486@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210527103517.GA24486@quack2.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:bcf1]
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:bcf1) by MW4PR04CA0318.namprd04.prod.outlook.com (2603:10b6:303:82::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 16:33:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27499e3b-bf1a-4af4-2001-08d9212d18e3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4769:
X-Microsoft-Antispam-PRVS: <SA1PR15MB47699F21B01C9A7C9ABD3A05BE239@SA1PR15MB4769.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtCP3x6IvxpDhUgBNft2452AF1dqDbUmJCWxr07sbpUBLfmI1rUdh4DsAUrdYwI2fQ+AktQDzxUsHaMNodHwSyIoT78k/qLlOpaleJLD78nKdGGvOHI4VNuBG9o0GYaz1Yhiz5Qgg+LO2Omcf3pLWn+Az+ojeTpZrzzRD+N6oXsGU+CLc9iKon1Qr23sQ9vpKqnI3U9/QuaOcWW5tRHT8vH6aqGNMDr3s4BMV10YBwEpasYWtPhsgLFhHBKMrLDYVcAuX2hjR/1TFkje82t1WG7aCGmr9PRS0UzEHaVR4w6OUNf48aXGeVAyzwThp9SQeNkUAOPyhsKzeJD1f0CWBnhaem7gwIMH06/w0d4BIYDVDFgOJZ1Vi132Hmb6pCcHVDlP92puSvgEAXvOaAm2RpxtIpJdvSwX+yf1HdAS9hVlVttkQasrY5gvdQOd1ZhOLzUynk4pfPmT/P97F5Uw+GgFDVXfWXTxlNWZnOq5uajvWh55hcL+CQm7F0p2WHvNz2FXlVF5+crJYpcahJiK5uAmW7bYLUfbRnZjnZyD7KWpH0xAkNY804qVzk4qG8Srr6ndhjH83SffCuCSpYAgQVS/aEo8B7WLJurCavLLjsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(66476007)(66556008)(66946007)(186003)(16526019)(5660300002)(55016002)(4326008)(6506007)(9686003)(6666004)(7696005)(52116002)(86362001)(83380400001)(6916009)(478600001)(8936002)(38100700002)(316002)(54906003)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?H4rwlaek08SbZB2/nnQEGg6qkXmCm3SX4VgggVmseVyyr7rmm3rrYyx91PBp?=
 =?us-ascii?Q?bNXxuB9C4Nezf2IYJgy9JTzAh8iURuW0Wh7Y9JBaAlUr7NxCqclYenLquFIE?=
 =?us-ascii?Q?3f5wiPHEzdwBO0hny7q4J6wHIG+dVCOv3CbLznYd4Ac5o7VlWG7jJTU8BtIp?=
 =?us-ascii?Q?NWCYeCU+7mfsjFBxjunhQhXSq6LJBejtcPZpQHJOVnhY4Tu2dDtigxcP1COc?=
 =?us-ascii?Q?GuDeOMyGSjyowetVI52WRUsyuX2p3DZcr75i0ZUWlZd2RBdoTrDzU3tbMyeu?=
 =?us-ascii?Q?Q901Y1XaoQm+HPa5T/h6pHUqxnWjDCDiVcvaaspgXRkJSTqctBz2xPnsrm4E?=
 =?us-ascii?Q?kPzeJxgHhoEo1pSdMqMc6DzfCPIpWc/kGwDd31pSkY2PhOprBmwXn+q3Yo9L?=
 =?us-ascii?Q?WgUMywGw5eGpRQwWhwoEC0GbWSagZGluANg86WtTwgZG87OkquqcuOqPO6dS?=
 =?us-ascii?Q?KyQRl2+lXv9oudB4gb9tvK0P0Pd4cjIjEsnKDuNeQR8n7sZhXw1zw7+tKSbV?=
 =?us-ascii?Q?ccclBJLq4LOcnJnxMeAltq9n8Qj9LgvPn6bd5q+qbTOaJJ/DS/1o8zVC+0BO?=
 =?us-ascii?Q?c96BYA10DJTckcHa2kU/Q6XQ969zNVoodD3jDESZsLCpw02tGOIOkw3ukzyR?=
 =?us-ascii?Q?6GQiGnn33E1GfMwCITDgapIMBCfrDWJmUytGMKY6fYmt+Hqqj/hz9wLq8vKs?=
 =?us-ascii?Q?gbRAt+gyPFUuahKDsAekbL0/Sf55pbrJaF8dYt0mDgMNkNaMQS0o/izOVRX2?=
 =?us-ascii?Q?Ohoz2Z4dGSpdReI+ibPOTJtWU/wm6SGgu6HZUBo0KX65i9nJhfKieCESjsqx?=
 =?us-ascii?Q?5lI9jr1ODRnUZfScMgrvXmaqD9RW0a/mdsvMjlUmn8tYjMGleF0Qvbragdde?=
 =?us-ascii?Q?vpCP9L17lTCIeJUP+BPNgP+Y5YquBYdTOXvhGa6WO/C/fGcTPNzD9sCJjuqQ?=
 =?us-ascii?Q?bJ7JR2GXv2goFQuXBa3NqczR0sFXvLL/SLABeoOlNBUOe3dt+9Jf+u5WUy7+?=
 =?us-ascii?Q?bA24puvuSD8bJCxDypcyXSpP3tQGwZZ/Dqq+16QBSgGqVf4AtfjUwsLvOxer?=
 =?us-ascii?Q?6EGYL3BuXXpvPU8QcE0h+pUPLAnZSCLa6OnpFsF/qDVy+Ljsg2aCMRf//E1C?=
 =?us-ascii?Q?VpzN/uT91qpzuN0UBNRfMhsz/vmYBHNxbRNFRrn+VnxvQbDytZBlxUIobgqs?=
 =?us-ascii?Q?y1bStUKHkqUeHJvUv1+1ryC+TY5ptM+fyV0JjeDX6fZRmRjmNXKL97CxBuv8?=
 =?us-ascii?Q?0A+N3to1uFQMy45P9378GZgdpnu+wPdP0LjoDYJDgaRFu4feAMF0+OzBFKkN?=
 =?us-ascii?Q?tNgN3RqGyM05YXrPkg0PlTXaPQZri3lc+eekZvNu45mTgw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27499e3b-bf1a-4af4-2001-08d9212d18e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 16:33:02.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojS1ldwDiqFYdEfAUhZCreVfAAm4HLs0tjcwePe2igPxhA8x77mxRW39WRxWMkYO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4769
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pyDt7Um2wPFxZ43U0zZR0yLtgO0gcK_4
X-Proofpoint-ORIG-GUID: pyDt7Um2wPFxZ43U0zZR0yLtgO0gcK_4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_09:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=531 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 12:35:17PM +0200, Jan Kara wrote:
> On Wed 26-05-21 15:25:56, Roman Gushchin wrote:
> > Currently there is no way to iterate over inodes attached to a
> > specific cgwb structure. It limits the ability to efficiently
> > reclaim the writeback structure itself and associated memory and
> > block cgroup structures without scanning all inodes belonging to a sb,
> > which can be prohibitively expensive.
> > 
> > While dirty/in-active-writeback an inode belongs to one of the
> > bdi_writeback's io lists: b_dirty, b_io, b_more_io and b_dirty_time.
> > Once cleaned up, it's removed from all io lists. So the
> > inode->i_io_list can be reused to maintain the list of inodes,
> > attached to a bdi_writeback structure.
> > 
> > This patch introduces a new wb->b_attached list, which contains all
> > inodes which were dirty at least once and are attached to the given
> > cgwb. Inodes attached to the root bdi_writeback structures are never
> > placed on such list. The following patch will use this list to try to
> > release cgwbs structures more efficiently.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Looks good. Just some minor nits below:
> 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index e91980f49388..631ef6366293 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -135,18 +135,23 @@ static bool inode_io_list_move_locked(struct inode *inode,
> >   * inode_io_list_del_locked - remove an inode from its bdi_writeback IO list
> >   * @inode: inode to be removed
> >   * @wb: bdi_writeback @inode is being removed from
> > + * @final: inode is going to be freed and can't reappear on any IO list
> >   *
> >   * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists and
> >   * clear %WB_has_dirty_io if all are empty afterwards.
> >   */
> >  static void inode_io_list_del_locked(struct inode *inode,
> > -				     struct bdi_writeback *wb)
> > +				     struct bdi_writeback *wb,
> > +				     bool final)
> >  {
> >  	assert_spin_locked(&wb->list_lock);
> >  	assert_spin_locked(&inode->i_lock);
> >  
> >  	inode->i_state &= ~I_SYNC_QUEUED;
> > -	list_del_init(&inode->i_io_list);
> > +	if (final)
> > +		list_del_init(&inode->i_io_list);
> > +	else
> > +		inode_cgwb_move_to_attached(inode, wb);
> >  	wb_io_lists_depopulated(wb);
> >  }
> 
> With these changes the naming is actually somewhat confusing and the bool
> argument makes it even worse. Looking into the code I'd just fold
> inode_io_list_del_locked() into inode_io_list_del() and make it really
> delete inode from all IO lists. There are currently three other
> inode_io_list_del_locked() users:

Yeah, good idea. Will do in the next version. Thanks!
