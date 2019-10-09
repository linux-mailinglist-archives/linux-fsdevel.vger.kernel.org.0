Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A242D1B32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfJIVst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 17:48:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20182 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbfJIVss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:48:48 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99Li2bS028966;
        Wed, 9 Oct 2019 14:48:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qWnpHCfVp5Lzw+vnoik5zZtmTBjtcdBUpVmPTwapPFk=;
 b=NBBlvtsjI5CzlD5SDZYvSbns2j2wbGD25+pKz+CuI19FTMxSOfNjMivElZKvzO2G9NM4
 rBM+/bu4igZTkv2Y9/PjUERmcwbE7SygPOjIT3khwJ/aVbpp0AKxNEn7Yk6PLY+QhXMk
 PAb96jVMoha20dMwTXqS7KF9D7abYdedTI4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vh6awcjq0-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Oct 2019 14:48:35 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 14:48:32 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Oct 2019 14:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJRP05FuD3bqH7J+p/L/YR/xsltBC9jEMe6USZEzTVw+Ay37x1D80k6Ez9IiAWlIpgtUp+YKrS3wkZY72UQNMgKR5l6hPGsDeMnN0D6wFq1TS5PNn12vk8JHiPK2f7v2q4buF9DcU57bwzRxZtLBMUJEJfzKmgAmuMKx3vbZ0pR2ZuXI0hnliN8ZNkPn/sLQcDDIie+TotW2ZKVCkCKiKB/7hxp5bwl4NvSVVS1gkubho9wfE7Lh3EoMtVPiheeHY9zOq3LwZIUXaoEeVeollGISBdJGiv6A/q6f26q6xDNSTzZ4bdVqBmp9/ja9BOWgfpSzMkv+Mc7Y76nS8z71OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWnpHCfVp5Lzw+vnoik5zZtmTBjtcdBUpVmPTwapPFk=;
 b=LScnW16Zstoql7qB01rd7kyn+TICuYMAJORJRy+7hqqaCLltPXJOvbBP277pMnZ9rRuyiWBxSdyi6lEpRtJs+qsX9vMHBicygn5x0lEZ9jtEHm1aHvgpLXfHXDO194i3Hu59aSY1PjC4hB2qxAxFFaAvTgIIaAxmJeBmizBgRu/ZbspWoe6DQ1RqnxIIsGolN8qQRvef8VlVDidky/9jDW8uJn9kKFvUXxJ3fXGXaDdHbUcov6+Wr1ig/HqqkqdFvUKYY4KW4Xl7U/fSNjYN6vmRSBwIuQSgoBKiszj07D9g6KodgzszABEORPAt2CgE4d3wzqW4WQokwXF715Vpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWnpHCfVp5Lzw+vnoik5zZtmTBjtcdBUpVmPTwapPFk=;
 b=b6hJHfO7mqOZceyUrB2+vdtgxrgw0kT1F6Wo1Q3xIdOX/qPgwFm0gfHekJsD/Tr5J6+DhB1erISgxzaaifcL+VSm3h7lV2HHsEylYyzc5844zdDdRK6/LU1ziL/devhqW6YayId5dtXulvlSkSDioDHrgEGGW3TlORsutNqf+ss=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2803.namprd15.prod.outlook.com (20.179.139.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 21:48:30 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 21:48:30 +0000
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
Thread-Index: AQHVewChQOAw+GKbfEyRn45Yoe7HH6dQJYaAgAAZ0ACAAC0xgIACdAWA
Date:   Wed, 9 Oct 2019 21:48:29 +0000
Message-ID: <20191009214825.GA30747@tower.DHCP.thefacebook.com>
References: <20191004221104.646711-1-guro@fb.com>
 <20191008040630.GA15134@dread.disaster.area>
 <20191008053854.GA14951@castle.dhcp.thefacebook.com>
 <20191008082039.GA5078@quack2.suse.cz>
In-Reply-To: <20191008082039.GA5078@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ed76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846066bc-69b0-4aed-8b94-08d74d026c2a
x-ms-traffictypediagnostic: BN8PR15MB2803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2803747A69F94FB51497F5FEBE950@BN8PR15MB2803.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(54094003)(199004)(189003)(316002)(6916009)(52116002)(102836004)(305945005)(229853002)(33656002)(46003)(71200400001)(71190400001)(1076003)(25786009)(76176011)(8936002)(4326008)(86362001)(53546011)(5660300002)(6506007)(386003)(6246003)(14454004)(30864003)(6512007)(9686003)(6486002)(66446008)(7736002)(2906002)(64756008)(66556008)(54906003)(476003)(478600001)(11346002)(446003)(6116002)(486006)(66476007)(14444005)(81156014)(186003)(99286004)(81166006)(5024004)(256004)(8676002)(66946007)(6436002)(14143004)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2803;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdIv3HQPI028P9B4TZeRwGtiWqEiYhJX3DgZenLoUszsGjChLeUZ/V3bz4JQiqG9RAwWoFoAKbGemuqAswbs389dSnEtqyVc/FdQc6DC/wc5iWQQ3+7BgM9xCHGxgD40mhF+s6korb6kfdZwJJkw/TMnDf/dkQFG/lejhAW5MA2OFiIkLxVG1Xz18gBD6Ln7iicg72GsgoVD+IWh5ordCK5oHsRZT24m0RsSpE5AwO2LJu0rEgbCPwbeznjUsKsi6rw/qy1tcI1M45jHtPkPd0ZeHmVdm9N+8IZTzzbiuzyq/+tTY9AKq+lvx7j+cxDVLw8idsEAkyqgUWYGpeFtd+TJA7RpvP68p0gX3rHLYnpmrZXPMOJ1UBhjB1qtK6OIgrks5su4z6ine0h3ZDPBqCJmzgme29BS+QDhUnmgpUU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE298DFF0D4E504D8748A7DE749616D1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 846066bc-69b0-4aed-8b94-08d74d026c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 21:48:30.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tV64qbXOPJUg6/cxDtHbGm42A9y+QU+wNdajkf5yjZMP7OJfvAvP0iAzrNqoUoZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2803
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_10:2019-10-08,2019-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910090170
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
>=20
> 								Honza

How about this one?

--

From e74bd7f3cf79e07e8d6e776ee2558a729664cbb8 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 9 Oct 2019 13:14:04 -0700
Subject: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups

We've noticed that the number of dying cgroups on our production hosts
tends to grow with the uptime. This time it's caused by the writeback
code.

An inode which is getting dirty for the first time is associated
with the wb structure (look at __inode_attach_wb()). It can later
be switched to another wb under some conditions (e.g. some other
cgroup is writing a lot of data to the same inode), but generally
stays associated up to the end of life of the inode structure.

The problem is that the wb structure holds a reference to the original
memory cgroup. So if an inode has been dirty once, it has a good chance
to pin down the original memory cgroup.

An example from the real life: some service runs periodically and
updates rpm packages. Each time in a new memory cgroup. Installed
.so files are heavily used by other cgroups, so corresponding inodes
tend to stay alive for a long. So do pinned memory cgroups.
In production I've seen many hosts with 1-2 thousands of dying
cgroups.

This is not the first problem with the dying memory cgroups. As
always, the problem is with their relative size: memory cgroups
are large objects, easily 100x-1000x larger that inodes. So keeping
a couple of thousands of dying cgroups in memory without a good reason
(what we easily do with inodes) is quite costly (and is measured
in tens and hundreds of Mb).

To solve this problem let's perform a periodic scan of inodes
attached to dying wbs, which don't have active io operations,
and switched them to the root memory cgroup's wb.
That will eventually release the wb structure and corresponding
memory cgroup.

To make this scanning effective, let's keep a list of attached
inodes. inode->i_io_list can be reused for this purpose. This idea
was suggested by Jan Kara.

The scan is performed from the cgroup offlining path. Dying wbs
are placed on the global list. On each cgroup removal we traverse
the whole list ignoring wbs with active io operations. That will
allow the majority of io operations to be finished after the
removal of the cgroup.

To avoid scheduling too many switch operations, let's stop on a first
failure. To make it's possible, inode_switch_wbs() can return a
boolean value: false if it's failed to schedule a switching operation
because there are already too many in flight, or if there is not
enough memory; true otherwise.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c                | 64 +++++++++++++++++++++++++------
 include/linux/backing-dev-defs.h |  2 +
 include/linux/writeback.h        |  2 +
 mm/backing-dev.c                 | 66 ++++++++++++++++++++++++++++++--
 4 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e88421d9a48d..af608276fbf6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -136,16 +136,21 @@ static bool inode_io_list_move_locked(struct inode *i=
node,
  * inode_io_list_del_locked - remove an inode from its bdi_writeback IO li=
st
  * @inode: inode to be removed
  * @wb: bdi_writeback @inode is being removed from
+ * @keep_attached: keep the inode on the list of inodes attached to wb
  *
  * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists an=
d
  * clear %WB_has_dirty_io if all are empty afterwards.
  */
 static void inode_io_list_del_locked(struct inode *inode,
-				     struct bdi_writeback *wb)
+				     struct bdi_writeback *wb,
+				     bool keep_attached)
 {
 	assert_spin_locked(&wb->list_lock);
=20
-	list_del_init(&inode->i_io_list);
+	if (keep_attached)
+		list_move(&inode->i_io_list, &wb->b_attached);
+	else
+		list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
=20
@@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_struct=
 *work)
 	if (!list_empty(&inode->i_io_list)) {
 		struct inode *pos;
=20
-		inode_io_list_del_locked(inode, old_wb);
+		inode_io_list_del_locked(inode, old_wb, false);
 		inode->i_wb =3D new_wb;
 		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
 			if (time_after_eq(inode->dirtied_when,
@@ -485,24 +490,29 @@ static void inode_switch_wbs_rcu_fn(struct rcu_head *=
rcu_head)
  *
  * Switch @inode's wb association to the wb identified by @new_wb_id.  The
  * switching is performed asynchronously and may fail silently.
+ *
+ * Returns %true is the operation has been scheduled successfully or
+ * if the inode cannot be switched because of its own state
+ * (e.g. inode is already switching). Returns %false otherwise.
  */
-static void inode_switch_wbs(struct inode *inode, int new_wb_id)
+static bool inode_switch_wbs(struct inode *inode, int new_wb_id)
 {
 	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	bool ret =3D false;
=20
 	/* noop if seems to be already in progress */
 	if (inode->i_state & I_WB_SWITCH)
-		return;
+		return true;
=20
 	/* avoid queueing a new switch if too many are already in flight */
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
-		return;
+		return false;
=20
 	isw =3D kzalloc(sizeof(*isw), GFP_ATOMIC);
 	if (!isw)
-		return;
+		return true;
=20
 	/* find and pin the new wb */
 	rcu_read_lock();
@@ -519,6 +529,7 @@ static void inode_switch_wbs(struct inode *inode, int n=
ew_wb_id)
 	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
 	    inode_to_wb(inode) =3D=3D isw->new_wb) {
 		spin_unlock(&inode->i_lock);
+		ret =3D true;
 		goto out_free;
 	}
 	inode->i_state |=3D I_WB_SWITCH;
@@ -536,12 +547,43 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
=20
 	atomic_inc(&isw_nr_in_flight);
-	return;
+	return true;
=20
 out_free:
 	if (isw->new_wb)
 		wb_put(isw->new_wb);
 	kfree(isw);
+	return ret;
+}
+
+/**
+ * cleanup_offline_wb - switch attached inodes to the root wb
+ * @wb: target wb
+ *
+ * Switch inodes attached to @wb to the root memory cgroup's wb.
+ * Switching is performed asynchronously and may fail silently.
+ *
+ * Returns %false if at least one switching attempt has been failed,
+ * %true otherwise.
+ */
+bool cleanup_offline_wb(struct bdi_writeback *wb)
+{
+	struct inode *inode;
+	bool ret =3D true;
+
+	spin_lock(&wb->list_lock);
+	if (list_empty(&wb->b_attached))
+		goto unlock;
+
+	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
+		ret =3D inode_switch_wbs(inode, root_mem_cgroup->css.id);
+		if (!ret)
+			break;
+	}
+unlock:
+	spin_unlock(&wb->list_lock);
+
+	return ret;
 }
=20
 /**
@@ -1120,7 +1162,7 @@ void inode_io_list_del(struct inode *inode)
 	struct bdi_writeback *wb;
=20
 	wb =3D inode_to_wb_and_lock_list(inode);
-	inode_io_list_del_locked(inode, wb);
+	inode_io_list_del_locked(inode, wb, false);
 	spin_unlock(&wb->list_lock);
 }
=20
@@ -1425,7 +1467,7 @@ static void requeue_inode(struct inode *inode, struct=
 bdi_writeback *wb,
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
-		inode_io_list_del_locked(inode, wb);
+		inode_io_list_del_locked(inode, wb, true);
 	}
 }
=20
@@ -1570,7 +1612,7 @@ static int writeback_single_inode(struct inode *inode=
,
 	 * touch it. See comment above for explanation.
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
-		inode_io_list_del_locked(inode, wb);
+		inode_io_list_del_locked(inode, wb, true);
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
 out:
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-d=
efs.h
index 4fc87dee005a..68b167fda259 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -137,6 +137,7 @@ struct bdi_writeback {
 	struct list_head b_io;		/* parked for writeback */
 	struct list_head b_more_io;	/* parked for more writeback */
 	struct list_head b_dirty_time;	/* time stamps are dirty */
+	struct list_head b_attached;	/* attached inodes */
 	spinlock_t list_lock;		/* protects the b_* lists */
=20
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
@@ -177,6 +178,7 @@ struct bdi_writeback {
 	struct cgroup_subsys_state *blkcg_css; /* and blkcg */
 	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
+	struct list_head offline_node;
=20
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a19d845dd7eb..7f430644a629 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -220,6 +220,7 @@ void wbc_account_cgroup_owner(struct writeback_control =
*wbc, struct page *page,
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_page=
s,
 			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
+bool cleanup_offline_wb(struct bdi_writeback *wb);
=20
 /**
  * inode_attach_wb - associate an inode with its wb
@@ -247,6 +248,7 @@ static inline void inode_detach_wb(struct inode *inode)
 	if (inode->i_wb) {
 		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
 		wb_put(inode->i_wb);
+		WARN_ON_ONCE(!list_empty(&inode->i_io_list));
 		inode->i_wb =3D NULL;
 	}
 }
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d9daa3e422d0..774c05672a27 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -52,10 +52,10 @@ static int bdi_debug_stats_show(struct seq_file *m, voi=
d *v)
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	unsigned long wb_thresh;
-	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
+	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time, nr_attached;
 	struct inode *inode;
=20
-	nr_dirty =3D nr_io =3D nr_more_io =3D nr_dirty_time =3D 0;
+	nr_dirty =3D nr_io =3D nr_more_io =3D nr_dirty_time =3D nr_attached =3D 0=
;
 	spin_lock(&wb->list_lock);
 	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
 		nr_dirty++;
@@ -66,6 +66,8 @@ static int bdi_debug_stats_show(struct seq_file *m, void =
*v)
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
 		if (inode->i_state & I_DIRTY_TIME)
 			nr_dirty_time++;
+	list_for_each_entry(inode, &wb->b_attached, i_io_list)
+		nr_attached++;
 	spin_unlock(&wb->list_lock);
=20
 	global_dirty_limits(&background_thresh, &dirty_thresh);
@@ -85,6 +87,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void =
*v)
 		   "b_io:               %10lu\n"
 		   "b_more_io:          %10lu\n"
 		   "b_dirty_time:       %10lu\n"
+		   "b_attached:         %10lu\n"
 		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
 		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
@@ -99,6 +102,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void=
 *v)
 		   nr_io,
 		   nr_more_io,
 		   nr_dirty_time,
+		   nr_attached,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
 #undef K
=20
@@ -295,6 +299,7 @@ static int wb_init(struct bdi_writeback *wb, struct bac=
king_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->b_io);
 	INIT_LIST_HEAD(&wb->b_more_io);
 	INIT_LIST_HEAD(&wb->b_dirty_time);
+	INIT_LIST_HEAD(&wb->b_attached);
 	spin_lock_init(&wb->list_lock);
=20
 	wb->bw_time_stamp =3D jiffies;
@@ -385,11 +390,12 @@ static void wb_exit(struct bdi_writeback *wb)
=20
 /*
  * cgwb_lock protects bdi->cgwb_tree, bdi->cgwb_congested_tree,
- * blkcg->cgwb_list, and memcg->cgwb_list.  bdi->cgwb_tree is also RCU
- * protected.
+ * blkcg->cgwb_list, offline_cgwbs and memcg->cgwb_list.
+ * bdi->cgwb_tree is also RCU protected.
  */
 static DEFINE_SPINLOCK(cgwb_lock);
 static struct workqueue_struct *cgwb_release_wq;
+static LIST_HEAD(offline_cgwbs);
=20
 /**
  * wb_congested_get_create - get or create a wb_congested
@@ -486,6 +492,10 @@ static void cgwb_release_workfn(struct work_struct *wo=
rk)
 	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
=20
+	spin_lock_irq(&cgwb_lock);
+	list_del(&wb->offline_node);
+	spin_unlock_irq(&cgwb_lock);
+
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
@@ -513,6 +523,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
 	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
+	list_add(&wb->offline_node, &offline_cgwbs);
 	percpu_ref_kill(&wb->refcnt);
 }
=20
@@ -734,6 +745,50 @@ static void cgwb_bdi_unregister(struct backing_dev_inf=
o *bdi)
 	mutex_unlock(&bdi->cgwb_release_mutex);
 }
=20
+/**
+ * cleanup_offline_cgwbs - try to release dying cgwbs
+ *
+ * Try to release dying cgwbs by switching attached inodes to the wb
+ * belonging to the root memory cgroup. Processed wbs are placed at the
+ * end of the list to guarantee the forward progress.
+ *
+ * Should be called with the acquired cgwb_lock lock, which might
+ * be released and re-acquired in the process.
+ */
+static void cleanup_offline_cgwbs(void)
+{
+	struct bdi_writeback *wb;
+	LIST_HEAD(processed);
+	bool cont =3D true;
+
+	lockdep_assert_held(&cgwb_lock);
+
+	do {
+		wb =3D list_first_entry_or_null(&offline_cgwbs,
+					      struct bdi_writeback,
+					      offline_node);
+		if (!wb)
+			break;
+
+		list_move_tail(&wb->offline_node, &processed);
+
+		if (wb_has_dirty_io(wb))
+			continue;
+
+		if (!percpu_ref_tryget(&wb->refcnt))
+			continue;
+
+		spin_unlock_irq(&cgwb_lock);
+		cont =3D cleanup_offline_wb(wb);
+		spin_lock_irq(&cgwb_lock);
+
+		wb_put(wb);
+	} while (cont);
+
+	if (!list_empty(&processed))
+		list_splice_tail(&processed, &offline_cgwbs);
+}
+
 /**
  * wb_memcg_offline - kill all wb's associated with a memcg being offlined
  * @memcg: memcg being offlined
@@ -749,6 +804,9 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
 		cgwb_kill(wb);
 	memcg_cgwb_list->next =3D NULL;	/* prevent new wb's */
+
+	cleanup_offline_cgwbs();
+
 	spin_unlock_irq(&cgwb_lock);
 }
=20
--=20
2.21.0

