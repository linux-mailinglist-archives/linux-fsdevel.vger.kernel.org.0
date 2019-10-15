Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD33ED8255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJOVlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:41:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbfJOVlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:41:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9FLbfMi021774;
        Tue, 15 Oct 2019 14:41:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=78FhtO4pXFV8W8CKi/PZbhN/aPln8jsB2fou21n0jGQ=;
 b=iIIb8/oOlugKH0HMefhBaHEWlBIgAngm2fEs+AgHV9UD/RdIpm7AP2GYN+GgVTEdM0Es
 Qk/JtwA4Nl4qXG6q+MV59nwYAfPwB7JMeiJ3HVVCXODsJKO5TBStUUH1TVMNyNXdEbIg
 d9oADWTfFVrALbFQUr9cRe4cY1mZXY3z+hY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2vn6m8c9kv-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Oct 2019 14:40:59 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Oct 2019 14:40:48 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Oct 2019 14:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3IqCouudSAA4gEST4BkcOoOrBq6wKYFlSEcT55fgXWJJYG9GHoY+SKwc0EhbwsjVtumCs8qp3vr/3DS4bJSZrmTi79tnXBPb4JZOTagVV10bKjq628fZp4bu7cH0sXdrS07Il7x1TtopmKV0uUBYKYOVU6o3BpYC7E13FRS4TpTh+fQAQ5eyPipiacrbiY5ctPWtrLq6xwz3wn0qKDWgHqUkpgb/2UAuxaPdDogCzAgfz5Uv0u+4HfnJ9koDxYgX8oUU852uAPrOn35L6AR0tROB1CuQw5MN0dYkkbdfVY667Hj97s1KuddAl4ho7mQidI26IL2N+UR3F2BiOTX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78FhtO4pXFV8W8CKi/PZbhN/aPln8jsB2fou21n0jGQ=;
 b=j6Y93uZLSV6Na1Los+2hUQm8bk1ZH+IWmwcHgBfgQDW1/2S+sHjsCoFJMEYDzBZ/nsdVuXgJWk8+bgWwUP18zuCFWl6Tjffp4xKfJ11RX4LX96k0SIqrJ95s2gv0pnUgKIVIrc6fKSNMj14099irlH9/A/CT+6oAUsip5sVq9qNxymipZD/0iJXc0wI749nZGlAQvQ5A2Vfxk0IYGeT0jRRJjqgBL3AtKeC+dB0dfha1J/2OKfNnAD2bOimBME+9OJiYIl+P5reS1vJRMtM/6t3lhLU4TrjHnF4i+0tUPXuTPUzB6fDkIDvn2RC4qORzNoiulDRqcKsc6ywcWhTX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78FhtO4pXFV8W8CKi/PZbhN/aPln8jsB2fou21n0jGQ=;
 b=PFMPP95f3/VwGIgSAJYoJEjksh53slY9U4yvrE8TDsFUQ3BpIe4/lOn3AiTbE9f6QLYXG1cACYmSWDMyNKid9n5nnzNtARE4N9/ed9aC3l3tcM0CV8unLna5T9Gjl6q85gyw9M2NOIdgJ+sj9YIuO0qt5r6YZdXjwjRSlOvaPkU=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2594.namprd15.prod.outlook.com (20.179.138.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 21:40:46 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 21:40:46 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Thread-Topic: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Thread-Index: AQHVf8gRoXSX40yW0UC8Fmyi/ziIh6dbcPSAgADR3YA=
Date:   Tue, 15 Oct 2019 21:40:45 +0000
Message-ID: <20191015214041.GA24736@tower.DHCP.thefacebook.com>
References: <20191010234036.2860655-1-guro@fb.com>
 <20191015090933.GA21104@quack2.suse.cz>
In-Reply-To: <20191015090933.GA21104@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0014.namprd14.prod.outlook.com
 (2603:10b6:301:4b::24) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:9767]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 497fb660-8613-4497-1327-08d751b85609
x-ms-traffictypediagnostic: BN8PR15MB2594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB25948C848C6FEF9B8F9B987BBE930@BN8PR15MB2594.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:96;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(76176011)(4326008)(6246003)(6436002)(446003)(7736002)(305945005)(229853002)(478600001)(46003)(6512007)(9686003)(6116002)(86362001)(8936002)(2906002)(486006)(11346002)(81156014)(8676002)(81166006)(71190400001)(71200400001)(256004)(14444005)(476003)(5024004)(66946007)(66556008)(66446008)(64756008)(52116002)(66476007)(54906003)(5660300002)(99286004)(6486002)(316002)(25786009)(14454004)(102836004)(386003)(33656002)(6506007)(186003)(1076003)(6916009)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2594;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQ1Bi48ljLnZi8aksKIdCox++Lvi2nU7GE35S0LXqfWTJ2LzLbQ+uxsALU0fThuFL3A3Joljesr61smgb16i0lWaVVKBjS+47pyj14FQuq8W8HyXdSTJdC3WBfsMsClgKSY+iJb5yJfnvgOZz3/AdRPPmi3YkmxLCPCqESBqlx1ezInB7PIQBm0Pxl/dLIy3Nt1CmHyC5BsL6WN/sxRXADSZGpBD0lGBSD6h3sJAUR5ECW4Rj63HlJzpumGuj5RtrmpELbe3fEJcrr3mpwZ5/oQ8lo7ADm1RAQg5rHoFXQdLZlbjnR5iUiL/0taTcAhGf+tpgQh2nvb4DnqusjxitR83OXtVNKKUvpTpl64LGIeRvzu/NfJ0Ab2XL4PMOnBIA5Ks3obN505UL21Mh+HiKw5yI54r8QQV+W8KQ6/Utrw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <608989CC9AED104FB1184B8398FE30F2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 497fb660-8613-4497-1327-08d751b85609
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 21:40:45.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HCl6zNv7v8Z4Y2EPcGpapYQlS9zykRGREzHdwj/tSwKBj8lL4C4LG7rsNTTk40d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2594
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_08:2019-10-15,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910150185
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:09:33AM +0200, Jan Kara wrote:
> On Thu 10-10-19 16:40:36, Roman Gushchin wrote:
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
> > memory cgroup. So if an inode has been dirty once, it has a good chance
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
> > To solve this problem let's perform a periodic scan of inodes
> > attached to the dying wbs, and detach those of them, which are clean
> > and don't have an active io operation.
> > That will eventually release the wb structure and corresponding
> > memory cgroup.
> >=20
> > To make this scanning effective, let's keep a list of attached
> > inodes. inode->i_io_list can be reused for this purpose.
> >=20
> > The scan is performed from the cgroup offlining path. Dying wbs
> > are placed on the global list. On each cgroup removal we traverse
> > the whole list ignoring wbs with active io operations. That will
> > allow the majority of io operations to be finished after the
> > removal of the cgroup.
> >=20
> > Big thanks to Jan Kara and Dennis Zhou for their ideas and
> > contribution to this patch.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  fs/fs-writeback.c                | 52 +++++++++++++++++++++++---
> >  include/linux/backing-dev-defs.h |  2 +
> >  include/linux/writeback.h        |  1 +
> >  mm/backing-dev.c                 | 63 ++++++++++++++++++++++++++++++--
> >  4 files changed, 108 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index e88421d9a48d..c792db951274 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -136,16 +136,21 @@ static bool inode_io_list_move_locked(struct inod=
e *inode,
> >   * inode_io_list_del_locked - remove an inode from its bdi_writeback I=
O list
> >   * @inode: inode to be removed
> >   * @wb: bdi_writeback @inode is being removed from
> > + * @keep_attached: keep the inode on the list of inodes attached to wb
> >   *
> >   * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} list=
s and
> >   * clear %WB_has_dirty_io if all are empty afterwards.
> >   */
> >  static void inode_io_list_del_locked(struct inode *inode,
> > -				     struct bdi_writeback *wb)
> > +				     struct bdi_writeback *wb,
> > +				     bool keep_attached)
> >  {
> >  	assert_spin_locked(&wb->list_lock);
> > =20
> > -	list_del_init(&inode->i_io_list);
> > +	if (keep_attached)
> > +		list_move(&inode->i_io_list, &wb->b_attached);
> > +	else
> > +		list_del_init(&inode->i_io_list);
> >  	wb_io_lists_depopulated(wb);
> >  }
>=20
> Rather than adding this (somewhat ugly) bool argument to
> inode_io_list_del_locked() I'd teach inode_io_list_move_locked() about th=
e
> new b_attached list and use that function where needed...

Ok, will do in v3.

>=20
> > @@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
> >  	if (!list_empty(&inode->i_io_list)) {
> >  		struct inode *pos;
> > =20
> > -		inode_io_list_del_locked(inode, old_wb);
> > +		inode_io_list_del_locked(inode, old_wb, false);
> >  		inode->i_wb =3D new_wb;
> >  		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> >  			if (time_after_eq(inode->dirtied_when,
>=20
> This bit looks wrong. Not the change you made as such but the fact that y=
ou
> can now move inode from b_attached list of old wb to the dirty list of ne=
w
> wb.

Hm, can you, please, elaborate a bit more why it's wrong?
The reference to the old_wb will be dropped by the switching code.

>=20
> > @@ -544,6 +549,41 @@ static void inode_switch_wbs(struct inode *inode, =
int new_wb_id)
> >  	kfree(isw);
> >  }
> > =20
> > +/**
> > + * cleanup_offline_wb - detach attached clean inodes
> > + * @wb: target wb
> > + *
> > + * Clear the ->i_wb pointer of the attached inodes and drop
> > + * the corresponding wb reference. Skip inodes which are dirty,
> > + * freeing, switching or in the active writeback process.
> > + */
> > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > +{
> > +	struct inode *inode, *tmp;
> > +	bool ret =3D true;
> > +
> > +	spin_lock(&wb->list_lock);
> > +	if (list_empty(&wb->b_attached))
> > +		goto unlock;
>=20
> What's the point of this check? list_for_each_entry_safe() below will jus=
t
> do the same...

Right, will remove.

>=20
> > +
> > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > +		if (!spin_trylock(&inode->i_lock))
> > +			continue;
> > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > +		if (!(inode->i_state &
> > +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
> > +			WARN_ON_ONCE(inode->i_wb !=3D wb);
> > +			inode->i_wb =3D NULL;
> > +			wb_put(wb);
>=20
> Hum, currently the code assumes that once i_wb is set, it never becomes
> NULL again. In particular the inode e.g. in
> fs/fs-writeback.c:inode_congested() or generally unlocked_inode_to_wb_beg=
in()
> users could get broken by this. The i_wb switching code is so complex
> exactly because of these interactions.
>=20
> Maybe you thought through the interactions and things are actually fine b=
ut
> if nothing else you'd need a big fat comment here explaining why this is
> fine and update inode_congested() comments etc.

Yeah, I thought that once inode is clean and not switching it's safe to cle=
ar
the i_wb pointer, but seems that it's not completely true.

One idea I have is to always release wbs using rcu delayed work, so that
it will be save to dereference i_wb pointer under rcu, if only it's not NUL=
L
(the check has to be added). I'll try to implement this scheme, but if you
know in advance that it's not gonna work, please, let me know.

>=20
> > +			list_del_init(&inode->i_io_list);
> > +		}
> > +		xa_unlock_irq(&inode->i_mapping->i_pages);
> > +		spin_unlock(&inode->i_lock);
> > +	}
> > +unlock:
> > +	spin_unlock(&wb->list_lock);
> > +}
> > +
>=20
> ...
>=20
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-d=
ev-defs.h
> > index 4fc87dee005a..68b167fda259 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -137,6 +137,7 @@ struct bdi_writeback {
> >  	struct list_head b_io;		/* parked for writeback */
> >  	struct list_head b_more_io;	/* parked for more writeback */
> >  	struct list_head b_dirty_time;	/* time stamps are dirty */
> > +	struct list_head b_attached;	/* attached inodes */
>=20
> Maybe
> 	/* clean inodes pointing to this wb through inode->i_wb */
> would be more explanatory?

Sure, np.

>=20
> >  	spinlock_t list_lock;		/* protects the b_* lists */
> > =20
> >  	struct percpu_counter stat[NR_WB_STAT_ITEMS];
>=20
> 									Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thank you for looking into it!
