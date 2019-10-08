Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16364CF233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfJHFjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 01:39:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44648 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729568AbfJHFjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:39:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x985d7MD029851;
        Mon, 7 Oct 2019 22:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e7B4/bZHvy01YpoupmquNBsySRyPawYB21FZ9XJq/zA=;
 b=RwgNlcPk8OgFM5X3/aUocwfggkBoqUr+8iQJhXwt8an41lhXEsRct967f2WObF59Yn4G
 /l6PELV46Wq6CyJIb2I2L3D4iS6joQbNzFk2LCsDnQzh2ZHldp/LTWDAp2UOpGaGmP9A
 95ODx795/vHe1mwQ+PiLwvVFd/41VgC/FbM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vgcj21smg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Oct 2019 22:39:07 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 22:39:01 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Oct 2019 22:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE+ZOA6buX+PueEPK3kd6tfBKEE+BO4thLi4AGI2ydywi6SnCGTP6iex1dRFolyhjiKtylYvCMB/cHV7d44rnXgbFSbJc5WY1lMf/Q9gTLkdFQf2O+G5eW3szJpxx+w7WCZZ22d06wBOzGeqcQxPv2sVaPJ8NiuDXiQX89FFPeJ97EEkGfAw6Z5jx7hMdvCENjY2s9LwaNQsJ9qO3wP14JXWEt6ZBfkWFaMQdsRuC90s1TRM9BxYBh1DcB66XuxLiWRm5y8v4NQ3sMk8BNi5Vlr5ykj1QQM70infbVz1xlJntCdKhLiWE48EyWbI/e5H7mZML6rBzD+gVChiJcOM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7B4/bZHvy01YpoupmquNBsySRyPawYB21FZ9XJq/zA=;
 b=MK9SMPGNgYZ+2eF2z5wZhWV2YKJjllgmH4sNtu1Fw1WncFrp9mYUpvxNHSRuQIE/+HCVlH3kXIG1B9kKIrwhTEjM154paaJyhoq6k/y0ogqpIFrIdf7nS6/1Zt7baVqKkRXYo5PvJZ9IjTm9bbzKcfaN3sbqyW+CqjJxdGb9a6lZ7Mn+wzS3XDuytjMx9XPtSg9AXTd2kKPU6yB5pb1qy+dHi+UPmhzeP8BkhNACOD6tX8wUCDZ5YhwWt0lwY1mQG850pIIzgVbZF5LRIfq4veuaZNSEVmV/Z/s9rtO1Ox8DYn2RjKKKyT04R1SbPaAKq3a9w/YravkZEyeSf1ZRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7B4/bZHvy01YpoupmquNBsySRyPawYB21FZ9XJq/zA=;
 b=T6NvRb9pkbY4Go9p+ooU8U3X5L14KqYIMNVDo5E0CycNaUf2Bq0Pxcycg8HvnjTWYr9GVw5v+3dXMD+RsgiPbtsSMLfR6e/p3XaZ/EyRBxYa5cYqvoRSd4NbNp5YlnffxmQwpVKBrc05Kk8TAlBlJVqFbrSp3fNSwy2/V4IuAtw=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2548.namprd15.prod.outlook.com (20.179.136.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 05:39:00 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 05:38:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Topic: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Index: AQHVewChQOAw+GKbfEyRn45Yoe7HH6dQJYaAgAAZ0AA=
Date:   Tue, 8 Oct 2019 05:38:59 +0000
Message-ID: <20191008053854.GA14951@castle.dhcp.thefacebook.com>
References: <20191004221104.646711-1-guro@fb.com>
 <20191008040630.GA15134@dread.disaster.area>
In-Reply-To: <20191008040630.GA15134@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:104:4::33) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::4ffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa576697-411a-4f21-b474-08d74bb1d186
x-ms-traffictypediagnostic: BN8PR15MB2548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2548FB60123DCE27F45583FDBE9A0@BN8PR15MB2548.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(54094003)(8936002)(6486002)(71190400001)(186003)(256004)(33656002)(4326008)(71200400001)(5660300002)(6506007)(386003)(54906003)(6916009)(6246003)(1076003)(46003)(14454004)(5024004)(6116002)(305945005)(2906002)(11346002)(446003)(14444005)(486006)(478600001)(9686003)(6512007)(316002)(86362001)(476003)(6436002)(66946007)(102836004)(81156014)(25786009)(99286004)(7736002)(8676002)(64756008)(66446008)(76176011)(66556008)(81166006)(52116002)(229853002)(66476007)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2548;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WVpRWT4o745CvmeD4vd7cW7yWWHTwAYgBn4wAiZ1i2PoHNHzmai4S0SS8EzNI+4ROJFBnqJ3uJJg4aQ0ZHySOqt/tP9xXDpUqCJN6Tdi9B7L1qur6h8ikwJdkx/cN2NYQ2egvyVp7jusCatK6eRMGljRl4t+GlhIRVuIXdBAb+E9sHL5IXEj/+E91cgHv9L6yXN5dMo8ytBXfZiDO9+syl2XbQ+dxAsKG385RjBmyUnqqYolvN6FShm1yI9J8c4OvBzwxuugStEvJnxvSyOurPMTGpGzsM7A6fWKbCyxUcH5hlgrcoHhCxzKuJHv4OS4GsFYw7jslCGC2/as7AxAKl59A4tnaLkvoStlLHZgObnjFxWLOP3+caswlGA628JJWCy+xsv93M5i8TWGaVTNfHgU8qPazjfnvyLBen1xVk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8F98902AC536C44BF3CEF6196DD0833@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa576697-411a-4f21-b474-08d74bb1d186
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 05:38:59.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgebR5MUDA3VP7bwsPz4+Yrdo6s8bCUttqo8ak7l6s9UwujSa3udhzrxdikHoJ8x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2548
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_02:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080058
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:06:31PM +1100, Dave Chinner wrote:
> On Fri, Oct 04, 2019 at 03:11:04PM -0700, Roman Gushchin wrote:
> > This is a RFC patch, which is not intended to be merged as is,
> > but hopefully will start a discussion which can result in a good
> > solution for the described problem.
> >=20
> > --
> >=20
> > We've noticed that the number of dying cgroups on our production hosts
> > tends to grow with the uptime. This time it's caused by the writeback
> > code.
> >=20
> > An inode which is getting dirty for the first time is associated
> > with the wb structure (look at __inode_attach_wb()). It can later
> > be switched to another wb under some conditions (e.g. some other
> > cgroup is writing a lot of data to the same inode), but generally
> > stays associated up to the end of life of the inode structure.
> >=20
> > The problem is that the wb structure holds a reference to the original
> > memory cgroup. So if the inode was dirty once, it has a good chance
> > to pin down the original memory cgroup.
> >=20
> > An example from the real life: some service runs periodically and
> > updates rpm packages. Each time in a new memory cgroup. Installed
> > .so files are heavily used by other cgroups, so corresponding inodes
> > tend to stay alive for a long. So do pinned memory cgroups.
> > In production I've seen many hosts with 1-2 thousands of dying
> > cgroups.
> >=20
> > This is not the first problem with the dying memory cgroups. As
> > always, the problem is with their relative size: memory cgroups
> > are large objects, easily 100x-1000x larger that inodes. So keeping
> > a couple of thousands of dying cgroups in memory without a good reason
> > (what we easily do with inodes) is quite costly (and is measured
> > in tens and hundreds of Mb).
> >=20
> > One possible approach to this problem is to switch inodes associated
> > with dying wbs to the root wb. Switching is a best effort operation
> > which can fail silently, so unfortunately we can't run once over a
> > list of associated inodes (even if we'd have such a list). So we
> > really have to scan all inodes.
> >=20
> > In the proposed patch I schedule a work on each memory cgroup
> > deletion, which is probably too often. Alternatively, we can do it
> > periodically under some conditions (e.g. the number of dying memory
> > cgroups is larger than X). So it's basically a gc run.
> >=20
> > I wonder if there are any better ideas?
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  fs/fs-writeback.c | 29 +++++++++++++++++++++++++++++
> >  mm/memcontrol.c   |  5 +++++
> >  2 files changed, 34 insertions(+)
> >=20
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 542b02d170f8..4bbc9a200b2c 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -545,6 +545,35 @@ static void inode_switch_wbs(struct inode *inode, =
int new_wb_id)
> >  	up_read(&bdi->wb_switch_rwsem);
> >  }
> > =20
> > +static void reparent_dirty_inodes_one_sb(struct super_block *sb, void =
*arg)
> > +{
> > +	struct inode *inode, *next;
> > +
> > +	spin_lock(&sb->s_inode_list_lock);
> > +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> > +		spin_lock(&inode->i_lock);
> > +		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> > +			spin_unlock(&inode->i_lock);
> > +			continue;
> > +		}
> > +
> > +		if (inode->i_wb && wb_dying(inode->i_wb)) {
> > +			spin_unlock(&inode->i_lock);
> > +			inode_switch_wbs(inode, root_mem_cgroup->css.id);
> > +			continue;
> > +		}
> > +
> > +		spin_unlock(&inode->i_lock);
> > +	}
> > +	spin_unlock(&sb->s_inode_list_lock);
>=20
> No idea what the best solution is, but I think this is fundamentally
> unworkable. It's not uncommon to have a hundred million cached
> inodes these days, often on a single filesystem. Anything that
> requires a brute-force system wide inode scan, especially without
> conditional reschedule points, is largely a non-starter.
>=20
> Also, inode_switch_wbs() is not guaranteed to move the inode to the
> destination wb.  There can only be WB_FRN_MAX_IN_FLIGHT (1024)
> switches in flight at once and switches are run via RCU callbacks,
> so I suspect that using inode_switch_wbs() for bulk re-assignment is
> going to be a lot more complex than just finding inodes to call
> inode_switch_wbs() on....


We can schedule it only if the number of dying cgroups exceeds a certain
number (like 100), which will make it relatively rare event. Maybe we can
add some other conditions, e.g. count the number of inodes associated with
a wb and skip scanning if it's zero.

Alternatively the wb structure can keep the list of associated inodes,
and scan only them, but then it's not trivial to implement without
additional complication of already quite complex locking scheme.
And because inode_switch_wbs() can fail, we can't guarantee that a single
pass over such a list will be enough. That means the we need to schedule
scans periodically until all inodes will be switched.

So I really don't know which option is better, but at the same time
doing nothing isn't the option too. Somehow the problem should be solved.

Thanks!
