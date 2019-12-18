Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA124F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLRR1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:27:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbfLRR1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:27:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIHPcEM015914;
        Wed, 18 Dec 2019 09:27:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Bf5paS0NjhCZYY+kkHumJ+EcVi9N+rlxqSslFxmK2/k=;
 b=mXbgEKv0gK2IYf4hKxGJiPssAbxeXvLzSSX+DoXohgVrkOXGK75tTRzp5cNIFIG5Yk8q
 nMVBlT+0Sg6RS2/7EX9OjtP9B7guuN01Tl/9lXeKRJk8VS+ZXZoPD4HzuxziWZMRVdZp
 wTnhFKfHjjjtTANEDZmwLL60jo27vQGyRzo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wy61t4rre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 09:27:15 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Dec 2019 09:27:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:27:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqr1SwZlfjdbfAjZEp8rJjMTfNYYuW/eua3UD0KcPoOtbRyFvJm5TRBrVcg+jERXsU+Y1nWoZNeE+EWFXVjooY7AimfXvltxIwKYHN+IskSCwpXeV3xz9hARDIc803Yz8S/iJPVxTSv98BVAebC37ukbJIGxs+z/0zJasTR1Ua38OtuqKIL42JLL2ipJZKyc6YJEX9Bj73CmwF0CJVyFevduyZpl7pza3QnlTfNeAW210GRjeco0fnI1s58ZPGKbHVvGr72NZnh+lI/NQvz4gTLBEv6AKp4iXS7mnxAmcWziv34xnaime+Aaexk2ExWg+qUO9oHTaZ4etNM83Jxnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf5paS0NjhCZYY+kkHumJ+EcVi9N+rlxqSslFxmK2/k=;
 b=NIs9kxWGe5xZPtqW/jGvYGIdAIpgzDpF4NRCFN7kY7gEuvSetcKpuuOhNmwsUAZCOc59qwY+Oaj/h5XFZhyxCzLj6ndT93kiV60YLLqRmvrX0aJ6UefXi9VO0E4lfuXmXS7qoQj8VbB6Revhw+eBLTwWDihCS/waufzMszQ2SLVJNpTDfDM9aGe0dOpC0bAJkMmHyLzIyevJIDRj+XKcIZCW1HZySXvJ1YHgv6t8yODksIkY/GCk+b+Udso8q+fNFzeHa4jxFLLkARkWlv0e0bvIVckahjEtESEX0hX7BVvs8XYc6qrvpPFC+8V33/4DOMfHHlQ+xJL6LjsOyJdllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf5paS0NjhCZYY+kkHumJ+EcVi9N+rlxqSslFxmK2/k=;
 b=ODvYfX7Ugm3UraahaGxRU9Xjx99NXhz2oZE/IUEU/mjhZBz3QgZy2kTcblkXqw7PkIwWam4MtXqdaKVovENHOZBDtXKuxgRWCVHKwICpkRq1tqizWbCq7Z2OcxTZuuW7RAhVZI3++6oVoiUdxpsJ5NU96ae9aYP77bFEjre3lEU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3239.namprd15.prod.outlook.com (20.179.59.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Wed, 18 Dec 2019 17:27:13 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 17:27:13 +0000
Received: from localhost.localdomain (2620:10d:c090:180::9c5c) by CO2PR04CA0200.namprd04.prod.outlook.com (2603:10b6:104:5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 18 Dec 2019 17:27:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Thread-Topic: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Thread-Index: AQHVtM2C/VGzIrFg1kWYxvv2tV9/tae+OE6AgAAGcwCAAEzmAIABm30A
Date:   Wed, 18 Dec 2019 17:27:13 +0000
Message-ID: <20191218172708.GA4144@localhost.localdomain>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
In-Reply-To: <20191217165422.GA213613@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:104:5::30) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9c5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d5586eb-e9de-486f-dda9-08d783df8509
x-ms-traffictypediagnostic: BYAPR15MB3239:
x-microsoft-antispam-prvs: <BYAPR15MB3239BCA46C767F12A0E97D3ABE530@BYAPR15MB3239.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(5660300002)(33656002)(66946007)(66476007)(66446008)(478600001)(4326008)(64756008)(66556008)(316002)(71200400001)(54906003)(86362001)(1076003)(53546011)(2906002)(6916009)(8936002)(186003)(81166006)(81156014)(7696005)(52116002)(6506007)(55016002)(9686003)(8676002)(69590400006)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3239;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QyvI+7XSJSDQ5FhQhTzAgzttJ5Eyf/57Ep0C1Uy+1txGN1pHUjdNv1hLa6hrpP5lmIaXB+m2gQdEnDFZL28riqBFZgU7SUT/1+KYW1HFfuGgtMdmava1WfU9ACrr8l87lhGRqaHcaMFBuU1KYlPS+vX2LYHagESR3kDI6S5gataE3P+rtRtSdtEMOSA0OoV0ds46VA5FZBzG5J8Hi6TvrSA3GdV0BQ36d9kN/sWb2e7Cx8rbheKih6togLz7Q9rWrDaWNYUcowTuqO0y8oKTh0z6v7vZeUp2Tncl14gbS0CFIyoc6Pm5PWbUf6SQjmZmGbSlVUSxjXba/WKhJYv3RJimnQELBqgmAnGeL+3+rZ0q6g89aOmvn3RpQy+/MqqSPYZibiGVk12UcwrvgfvjoxCbV9t28vgQHyvF5JTd/eCP6XK7e5QdGAQhc8oJkuoxquWyKlpNloljkKQH6humjBf5SqOKQtrJSRhMimfSOCb+vN+GUTW73URfq648Kecj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09EE70042F9A014CA6F88E17CDAD06CA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5586eb-e9de-486f-dda9-08d783df8509
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 17:27:13.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ipuvZQeklib2S7a5lJquia3FDn90UyNe03rZleOf+T7RG9RAfeaRXyDNl9RIebq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_05:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180142
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> CCing Dave
>=20
> On Tue, Dec 17, 2019 at 08:19:08PM +0800, Yafang Shao wrote:
> > On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > What do you mean by this exactly. Are those inodes reclaimed by the
> > > regular memory reclaim or by other means? Because shrink_node does
> > > exclude shrinking slab for protected memcgs.
> >=20
> > By the regular memory reclaim, kswapd, direct reclaimer or memcg reclai=
mer.
> > IOW, the current->reclaim_state it set.
> >=20
> > Take an example for you.
> >=20
> > kswapd
> >     balance_pgdat
> >         shrink_node_memcgs
> >             switch (mem_cgroup_protected)  <<<< memory.current=3D 1024M
> > memory.min =3D 512M a file has 800M page caches
> >                 case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
> >                       beak;
> >             shrink_lruvec
> >             shrink_slab <<< it may free the inode and the free all its
> > page caches (800M)
>=20
> This problem exists independent of cgroup protection.
>=20
> The inode shrinker may take down an inode that's still holding a ton
> of (potentially active) page cache pages when the inode hasn't been
> referenced recently.
>=20
> IMO we shouldn't be dropping data that the VM still considers hot
> compared to other data, just because the inode object hasn't been used
> as recently as other inode objects (e.g. drowned in a stream of
> one-off inode accesses).
>=20
> I've carried the below patch in my private tree for testing cache
> aging decisions that the shrinker interfered with. (It would be nicer
> if page cache pages could pin the inode of course, but reclaim cannot
> easily participate in the inode refcounting scheme.)
>=20
> Thoughts?
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a42882..bfcaaaf6314f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list=
_head *item,
>  		return LRU_ROTATE;
>  	}
> =20
> -	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> +	/* Leave the pages to page reclaim */
> +	if (inode->i_data.nrpages) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_ROTATE;
> +	}
> +
> +	if (inode_has_buffers(inode)) {

JFYI: there was a very similar commit a76cf1a474d7 ("mm: don't reclaim inod=
es
with many attached pages"), which has been reverted because it created some
serious xfs regressions.
