Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67174D06D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 07:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfJIFTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 01:19:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63654 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730649AbfJIFTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:19:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x995FcfO008160;
        Tue, 8 Oct 2019 22:19:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Qvk7/kiHugxaXCF3moYlR7jWpV4dBIDbl/FaH5cs6wU=;
 b=mASdQYvDpsBJJWYG7A86d64S0ORtGz80aO+R5ZukFaHF6KDVh66GHbzI25J08bZ7b7Ny
 j9rkrmJVHBj2Rs+eJQLZz7LcOHCtROylZ6b8dQtTwuQpnrhSeidmVvX7Ro4e8N8V8cYI
 ybIxBI+TbM9jtpXFPWkADm02N+AK3r6GePc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vh1ukt006-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Oct 2019 22:19:09 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Oct 2019 22:19:08 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Oct 2019 22:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRvzgZfvgz0BB2p7Ab+8sJzr4+9vINaRqiLtpCnDbKr6jigBnAGcHM/nJ7d8K6byj4KsY7609Zb7uRDKvzWuauZ1hiaNJnLmBtm9b7KfPYykcJpNlNRdh+v37/4jGrbv0TvmLNJdwWOLUYibp/Qyy6PhQ5EBYs6zAW1jH3/sgwANatvCSDT/XS2DtmCrrQQF0sgkyBboxwzKUzNU9ocjUDZmO09BzX/SsBk/zVG5/zzNp5PEootXiGzcLqRnPTSk3G5BL0WzvPKImqMWSS6i9kG6CWodz+swieG+1AHS1VE/X0zxDcskhjew/grHkIhUSRFg6LXHbh0ez4KcvSw67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvk7/kiHugxaXCF3moYlR7jWpV4dBIDbl/FaH5cs6wU=;
 b=EuuhGZF++7WLmn7QmmXjKS1JkORTKGZjlBXfol8fMW//AKT0o0qXmSewJssRz4j3EzC+6YP995mfxzLCV3gvmLFb9cYtTxk3TJkGh1y1kuKGQg7tWl1QjnM1gVUeOUmIt0+wgOh3KSX+iiOt0dTQm0jC4i1VViDhyvYMbAXUfI7Hr2IDHJEJhx4Qc1Hn8MPPIvIbFaG1GUajKKVloq8tc1jNIbqjSw1ChLYIA9DEn8XbqezugzKxgUshuD8W1niwd9/RnJxiF/uSbOPaweaU38LMRhzF76MdTAZgvBmAHTMQl+xQ2shs5uOzPwSSYSS9fwskVk/1CNRDC+62ZPPV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvk7/kiHugxaXCF3moYlR7jWpV4dBIDbl/FaH5cs6wU=;
 b=AVMloKaTQ0F4M08h6cgUF+KdF1KsqjSAJXtDI9hBpHUO2HDSAFLHyVARAqtWAVY7iPdU+MjbthUky+N8KNqRIXCXcLh3VU2UOp8UoW4s51gSYgmMX/v4CyzXJgtd++5nEGuPIfED1opvSSZuA/CmkQky9M70PzuOQ5lEQ2FGL74=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2657.namprd15.prod.outlook.com (20.179.138.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 05:19:07 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 05:19:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Dave Chinner <david@fromorbit.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Topic: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Index: AQHVewChQOAw+GKbfEyRn45Yoe7HH6dQJYaAgAAZ0ACAAC0xgIABX5cA
Date:   Wed, 9 Oct 2019 05:19:06 +0000
Message-ID: <20191009051902.GA17538@castle.dhcp.thefacebook.com>
References: <20191004221104.646711-1-guro@fb.com>
 <20191008040630.GA15134@dread.disaster.area>
 <20191008053854.GA14951@castle.dhcp.thefacebook.com>
 <20191008082039.GA5078@quack2.suse.cz>
In-Reply-To: <20191008082039.GA5078@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::65f4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b810993-6044-42f7-432d-08d74c783525
x-ms-traffictypediagnostic: BN8PR15MB2657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2657CA14A80395FAE2052459BE950@BN8PR15MB2657.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(54094003)(189003)(199004)(46003)(6916009)(11346002)(446003)(486006)(86362001)(476003)(256004)(305945005)(478600001)(1076003)(5024004)(7736002)(14444005)(33656002)(186003)(25786009)(5660300002)(8936002)(66446008)(64756008)(229853002)(52116002)(2906002)(66556008)(71200400001)(71190400001)(81166006)(81156014)(8676002)(76176011)(6246003)(4326008)(6116002)(66476007)(6436002)(6486002)(102836004)(9686003)(6512007)(99286004)(66946007)(316002)(54906003)(14454004)(6506007)(386003)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2657;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMZRQNHQMI6IeaOY2V8+YYiH8v8CcjD+YW+GgrizyvAoM+qwti2c1lgZ7tV0lNu6l2affaepnSQeaLrL/08o8AcbqzmoAgQYtNjHYkLWyea8ttG6CtxvtIOCb12vmwvtDGfS8pXiAkp6svv3y03Z+dbL0ZnQfSUtoYtLCYUKUIFfBUxWP/OSiq1VkLIB4dUFSpqSaUc3cDUnF+JanAYMg6SgOwpxwPiTCfQ9jrCUHAE2YLiX1YZwKeM5AUs66gTdvn4LZI7z/O9h+Uc0O4QprGhUrz4MJkYSnIKg+MTO9HhURuzUtHGR4umbPk1K52ZBlhNhh/IS4kafPK9BtCQIS8f5NgOV80ksL6PjsmQG2pArF0LfWEJ1Z5sKHpjv0Rtn26ocbsoxFNjNMRxcq2nrKXlVG4Ichec4FN/RRUsbzxc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85D99F0BD27E2F44B467D32596D4AE96@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b810993-6044-42f7-432d-08d74c783525
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 05:19:07.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99vXsraEXtZY3CvBrcWbqKU+ZjqNGuNPk3f7sC55vUlGCf1ONMFusVuo0tcng/7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2657
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_02:2019-10-08,2019-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910090047
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:20:39AM +0200, Jan Kara wrote:
> On Tue 08-10-19 05:38:59, Roman Gushchin wrote:
> > On Tue, Oct 08, 2019 at 03:06:31PM +1100, Dave Chinner wrote:
> > > On Fri, Oct 04, 2019 at 03:11:04PM -0700, Roman Gushchin wrote:
> > > > This is a RFC patch, which is not intended to be merged as is,
> > > > but hopefully will start a discussion which can result in a good
> > > > solution for the described problem.
> > > >=20
> > > > --
> > > >=20
> > > > We've noticed that the number of dying cgroups on our production ho=
sts
> > > > tends to grow with the uptime. This time it's caused by the writeba=
ck
> > > > code.
> > > >=20
> > > > An inode which is getting dirty for the first time is associated
> > > > with the wb structure (look at __inode_attach_wb()). It can later
> > > > be switched to another wb under some conditions (e.g. some other
> > > > cgroup is writing a lot of data to the same inode), but generally
> > > > stays associated up to the end of life of the inode structure.
> > > >=20
> > > > The problem is that the wb structure holds a reference to the origi=
nal
> > > > memory cgroup. So if the inode was dirty once, it has a good chance
> > > > to pin down the original memory cgroup.
> > > >=20
> > > > An example from the real life: some service runs periodically and
> > > > updates rpm packages. Each time in a new memory cgroup. Installed
> > > > .so files are heavily used by other cgroups, so corresponding inode=
s
> > > > tend to stay alive for a long. So do pinned memory cgroups.
> > > > In production I've seen many hosts with 1-2 thousands of dying
> > > > cgroups.
> > > >=20
> > > > This is not the first problem with the dying memory cgroups. As
> > > > always, the problem is with their relative size: memory cgroups
> > > > are large objects, easily 100x-1000x larger that inodes. So keeping
> > > > a couple of thousands of dying cgroups in memory without a good rea=
son
> > > > (what we easily do with inodes) is quite costly (and is measured
> > > > in tens and hundreds of Mb).
> > > >=20
> > > > One possible approach to this problem is to switch inodes associate=
d
> > > > with dying wbs to the root wb. Switching is a best effort operation
> > > > which can fail silently, so unfortunately we can't run once over a
> > > > list of associated inodes (even if we'd have such a list). So we
> > > > really have to scan all inodes.
> > > >=20
> > > > In the proposed patch I schedule a work on each memory cgroup
> > > > deletion, which is probably too often. Alternatively, we can do it
> > > > periodically under some conditions (e.g. the number of dying memory
> > > > cgroups is larger than X). So it's basically a gc run.
> > > >=20
> > > > I wonder if there are any better ideas?
> > > >=20
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  fs/fs-writeback.c | 29 +++++++++++++++++++++++++++++
> > > >  mm/memcontrol.c   |  5 +++++
> > > >  2 files changed, 34 insertions(+)
> > > >=20
> > > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > > index 542b02d170f8..4bbc9a200b2c 100644
> > > > --- a/fs/fs-writeback.c
> > > > +++ b/fs/fs-writeback.c
> > > > @@ -545,6 +545,35 @@ static void inode_switch_wbs(struct inode *ino=
de, int new_wb_id)
> > > >  	up_read(&bdi->wb_switch_rwsem);
> > > >  }
> > > > =20
> > > > +static void reparent_dirty_inodes_one_sb(struct super_block *sb, v=
oid *arg)
> > > > +{
> > > > +	struct inode *inode, *next;
> > > > +
> > > > +	spin_lock(&sb->s_inode_list_lock);
> > > > +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> > > > +		spin_lock(&inode->i_lock);
> > > > +		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> > > > +			spin_unlock(&inode->i_lock);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		if (inode->i_wb && wb_dying(inode->i_wb)) {
> > > > +			spin_unlock(&inode->i_lock);
> > > > +			inode_switch_wbs(inode, root_mem_cgroup->css.id);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		spin_unlock(&inode->i_lock);
> > > > +	}
> > > > +	spin_unlock(&sb->s_inode_list_lock);
> > >=20
> > > No idea what the best solution is, but I think this is fundamentally
> > > unworkable. It's not uncommon to have a hundred million cached
> > > inodes these days, often on a single filesystem. Anything that
> > > requires a brute-force system wide inode scan, especially without
> > > conditional reschedule points, is largely a non-starter.
> > >=20
> > > Also, inode_switch_wbs() is not guaranteed to move the inode to the
> > > destination wb.  There can only be WB_FRN_MAX_IN_FLIGHT (1024)
> > > switches in flight at once and switches are run via RCU callbacks,
> > > so I suspect that using inode_switch_wbs() for bulk re-assignment is
> > > going to be a lot more complex than just finding inodes to call
> > > inode_switch_wbs() on....
> >=20
> > We can schedule it only if the number of dying cgroups exceeds a certai=
n
> > number (like 100), which will make it relatively rare event. Maybe we c=
an
> > add some other conditions, e.g. count the number of inodes associated w=
ith
> > a wb and skip scanning if it's zero.
> >=20
> > Alternatively the wb structure can keep the list of associated inodes,
> > and scan only them, but then it's not trivial to implement without
> > additional complication of already quite complex locking scheme.
> > And because inode_switch_wbs() can fail, we can't guarantee that a sing=
le
> > pass over such a list will be enough. That means the we need to schedul=
e
> > scans periodically until all inodes will be switched.
> >=20
> > So I really don't know which option is better, but at the same time
> > doing nothing isn't the option too. Somehow the problem should be solve=
d.
>=20
> I agree with Dave that scanning all inodes in the system can get really
> expensive quickly. So what I rather think we could do is create another '=
IO
> list' (linked by inode->i_io_list) where we would put inodes that referen=
ce
> the wb but are not in any other IO list of the wb. And then we would
> switch inodes on this list when the wb is dying... One would have to be
> somewhat careful with properly draining this list since new inodes can be
> added to it while we work on it but otherwise I don't see any complicatio=
n
> with this.

Good idea!

I've mastered something like this, will test it for a day or two and post h=
ere.

Thank you!
