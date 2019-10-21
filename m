Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB0DF8C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfJUXtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 19:49:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728819AbfJUXtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:49:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LNn2En026554;
        Mon, 21 Oct 2019 16:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xG81PXrgdU0mVFKZLor0+mHsKlkP3Abmls6SFFGINjE=;
 b=J7ddiz1qVLenR+dJuwKQsfZH54/SOKs71wmB+NLDE7C3BciBRhmUmSlU6CjlCOy/7KqC
 APyZ9lZKH0iuLlkUIbs3Xqtsl2Lz8KoATpFVochPhqDeMv4TDm1lNhSp+H6P93L6GV49
 DICCvGRFyHSr5zFYEcAY8vwsKRh/rTJvBd8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vshwr98kh-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 16:49:07 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 21 Oct 2019 16:49:06 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 21 Oct 2019 16:49:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Oct 2019 16:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFutKy5iEHPJzJwBtsWN0j5IckXON/lOxbfhcJoft7NKl6v0PV2b/jvTbU4fp6+HXNomjn/H/n4hEJmmDZ5TdYqXezBAlkfxtmnPKcAMoIAa0kEvQLABraSIKOBFtPo2yn9PpwhUzbA/vVY1HEua9GlYmlTDk8qPK7fzbUfF0b7bOJapTlTM/gob8Adaad1hwuOY3NibeCX2Xkcj53puFApjNHx2KTYQ1S3JRfGNYP1Ckp7CUDQW/2b4O+GcrY7/BkBNo735G30v1XiB+MaBzzpJurDPnxyz3acUNS4cH49hjUUwrqkUN/nchzORrYUPOmhqQ3OaWJO5iVtYXbdndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG81PXrgdU0mVFKZLor0+mHsKlkP3Abmls6SFFGINjE=;
 b=CMtatBXJ5MomnnmLzx1JbNyHCLeAPgngeji+WQ1AhT0SrXV0AkSr7J6hZJ2Zu0ljb6CJioHgQv4RSWo8peBy2A4Ax21aAdtghaVIBehMHK5J5fDgytweyWXfGnU+qG0677kTPVoFKve4jAm7MeTB81NyThI1760wiQj4hsb4DYpdRGc6cSOLbkfNHV732IxRXfaZWqqI2FozAekME2Q4t/JuHADbz/T2DqjWZCG9MaLVYwMDG0LK6gqsklhnAXF1OPurzOLOuXKfgk/aD0AZEdZpWYuz1Eg4pWF8qDJAOsSeeSsLKHOZAX2mE6sCU9NJqEfJzC4Isn89kv1jEZqkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG81PXrgdU0mVFKZLor0+mHsKlkP3Abmls6SFFGINjE=;
 b=I4z3dexz+mEcXijF4bMx52yK6v3kRJPJo+FrGHaob3EwN9Wg4nx2BNN3ShR38ru5Cknkoo59dyvB2gMQybDr1LTgH5yCmxyeAzfbjBZnnS9wr4Krq1Fxhg7mpbyMBhjx0KkZ8Uj4jEzL2V6lV6iXtxXXlvJKke2tk58uf3ps8aQ=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2817.namprd15.prod.outlook.com (20.179.140.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 23:49:04 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 23:49:04 +0000
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
Thread-Index: AQHVf8gRoXSX40yW0UC8Fmyi/ziIh6dbcPSAgADR3YCAAMMEAIAIztEA
Date:   Mon, 21 Oct 2019 23:49:04 +0000
Message-ID: <20191021234858.GA16251@castle>
References: <20191010234036.2860655-1-guro@fb.com>
 <20191015090933.GA21104@quack2.suse.cz>
 <20191015214041.GA24736@tower.DHCP.thefacebook.com>
 <20191016091840.GC30337@quack2.suse.cz>
In-Reply-To: <20191016091840.GC30337@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:300:6c::31) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::2973]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3afa0f5-ce6d-4c44-1d72-08d75681415c
x-ms-traffictypediagnostic: BN8PR15MB2817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2817B894F22A21624E7B20A2BE690@BN8PR15MB2817.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(99286004)(6246003)(52116002)(81166006)(8676002)(81156014)(11346002)(305945005)(25786009)(7736002)(6916009)(446003)(6506007)(102836004)(8936002)(386003)(46003)(76176011)(476003)(4326008)(486006)(33656002)(186003)(1076003)(6512007)(9686003)(6436002)(6486002)(256004)(6116002)(229853002)(316002)(71200400001)(71190400001)(14454004)(33716001)(478600001)(2906002)(5660300002)(64756008)(66476007)(66556008)(66946007)(66446008)(54906003)(5024004)(86362001)(14444005)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2817;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeJRRJf+l4Iwo/E/lZPaML6BlOakyuojtW43GTrYnKA4nQmT15eylYG1fr6mJzgjxAqiWGLwYKjwLTd8NCyojdiTGmkqInAKwKEQGu3maAp7JuVSk54FioJjKLiTRwv7wGCKc5zg8WlrJskyXWUn6WW6+lt2Ygrb5a5iLcPNFeviJtk4gUV5UIsG+ui63FQe6X6+ToScgyuysIgUFTsmRLi7Wr+NyyZMCy+N4sYOIWjEwiOXGkU1Da+9Rt8hK14EKpdWyyvTrjL1ky4iEBjBvPaV/+J3otgcxgqA9SlQN8EcixHzIzik38ID3s9YCldD4Qv4C3UlWF8sa5DMRdQMyxX4AXqDymoP4v6sAq8i7DkmUP5aNVdM++0Sz3SGzVHQQ6TEyyJd5qAAzuaUBzjB9EYX6+m2KW7lgC+2RxgzE4aMQGeZpj6F/pz2SADo9ujk
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B28BCC017DF4A549AA540121D0E7D3D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3afa0f5-ce6d-4c44-1d72-08d75681415c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 23:49:04.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJQiFELjaELj2SU2+9AbaubP9gNI66Q6qGOIuJ65IBCoS8TPfMPqAoHx6xzzEWts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_06:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910210226
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:18:40AM +0200, Jan Kara wrote:
> On Tue 15-10-19 21:40:45, Roman Gushchin wrote:
> > On Tue, Oct 15, 2019 at 11:09:33AM +0200, Jan Kara wrote:
> > > On Thu 10-10-19 16:40:36, Roman Gushchin wrote:
> > >=20
> > > > @@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct wor=
k_struct *work)
> > > >  	if (!list_empty(&inode->i_io_list)) {
> > > >  		struct inode *pos;
> > > > =20
> > > > -		inode_io_list_del_locked(inode, old_wb);
> > > > +		inode_io_list_del_locked(inode, old_wb, false);
> > > >  		inode->i_wb =3D new_wb;
> > > >  		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> > > >  			if (time_after_eq(inode->dirtied_when,
> > >=20
> > > This bit looks wrong. Not the change you made as such but the fact th=
at you
> > > can now move inode from b_attached list of old wb to the dirty list o=
f new
> > > wb.
> >=20
> > Hm, can you, please, elaborate a bit more why it's wrong?
> > The reference to the old_wb will be dropped by the switching code.
>=20
> My point is that the code in full looks like:
>=20
>         if (!list_empty(&inode->i_io_list)) {
>                 struct inode *pos;
>=20
>                 inode_io_list_del_locked(inode, old_wb);
>                 inode->i_wb =3D new_wb;
>                 list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
>                         if (time_after_eq(inode->dirtied_when,
>                                           pos->dirtied_when))
>                                 break;
>                 inode_io_list_move_locked(inode, new_wb, pos->i_io_list.p=
rev);
>         } else {
>=20
> So inode is always moved from some io list in old_wb to b_dirty list of
> new_wb. This is fine when it could be only on b_dirty, b_io, b_more_io li=
sts
> of old_wb. But once you add b_attached list to the game, it is not correc=
t
> anymore. You should not add clean inode to b_dirty list of new_wb.

I see...

Hm, will checking of i_state for not containing I_DIRTY_ALL bits be enough =
here?
Alternatively, I can introduce a new bit which will explicitly point at the
inode being on the b_attached list, but I'd prefer not to do it.

>=20
> > > > +
> > > > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) =
{
> > > > +		if (!spin_trylock(&inode->i_lock))
> > > > +			continue;
> > > > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > > > +		if (!(inode->i_state &
> > > > +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
> > > > +			WARN_ON_ONCE(inode->i_wb !=3D wb);
> > > > +			inode->i_wb =3D NULL;
> > > > +			wb_put(wb);
> > >=20
> > > Hum, currently the code assumes that once i_wb is set, it never becom=
es
> > > NULL again. In particular the inode e.g. in
> > > fs/fs-writeback.c:inode_congested() or generally unlocked_inode_to_wb=
_begin()
> > > users could get broken by this. The i_wb switching code is so complex
> > > exactly because of these interactions.
> > >=20
> > > Maybe you thought through the interactions and things are actually fi=
ne but
> > > if nothing else you'd need a big fat comment here explaining why this=
 is
> > > fine and update inode_congested() comments etc.
> >=20
> > Yeah, I thought that once inode is clean and not switching it's safe to=
 clear
> > the i_wb pointer, but seems that it's not completely true.
> >
> > One idea I have is to always release wbs using rcu delayed work, so tha=
t
> > it will be save to dereference i_wb pointer under rcu, if only it's not=
 NULL
> > (the check has to be added). I'll try to implement this scheme, but if =
you
> > know in advance that it's not gonna work, please, let me know.
>=20
> I think I'd just drop inode_to_wb_is_valid() because once i_wb can change
> to NULL, that function is just pointless in that single callsite. Also we
> have to count with the fact that unlocked_inode_to_wb_begin() can return
> NULL and gracefully do as much as possible in that case for all the
> callers. And I agree that those occurences in mm/page-writeback.c should =
be
> blocked by inode being clean and you holding all those locks so you can
> warn if that happens I guess.

Yeah, it sounds good to me. I actually have a patch, which I'll post after
some more extensive testing (want to make sure I do not hit these warns).

Thank you!
