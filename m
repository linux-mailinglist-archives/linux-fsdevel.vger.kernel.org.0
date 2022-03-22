Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF984E37F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 05:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiCVEc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 00:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiCVEc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:32:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF4617C;
        Mon, 21 Mar 2022 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647923459; x=1679459459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iwAb0fRmLfLaHWr5OWpabeLDeDjQM7o/zIZSen7mIcU=;
  b=WcDgP9toj6qSXLeRE3jQZblU5rmenvn7HV8CMu5EDnYIDks80VsbhXqA
   x/PigIlEnxRRvj9YMicPhde/fDYUT4Oj09e41B/h+lCEV2ALntjINwvCx
   qsOi+vNqA4sSkSiBnepd8mwERNZAkdAQ8AM5P7AyoOSO8wDJ5PSm3DwqC
   pHLw4VcHev1WbKPlCT++GwyERrnCmHIpst3SbapLqsF7S74znJnJSScWy
   ZBrP/YBnEg6JF5UfVmIG22qenUylru9C2rxeXezccOjzDbVGqEXepuNK0
   6po8twnJTnfbF+Sc04pR7CHIoLkoTqiQ1ZZ+ZvGx24xPjxGK7ML1s/lE0
   A==;
X-IronPort-AV: E=Sophos;i="5.90,200,1643644800"; 
   d="scan'208";a="194835305"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 12:30:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2pUSbyKAk8tnqwjNE+IOJNcskMuzaTcf9if7Sm/j3BbCIjJAdVHeBFctHgUAHy0tirYKa7ePbZYiD3FvN75E6EBZr8ihLXSDVq7TBPI5LPGDPYPpu/mIEyGZxZOWtugSoyLgwlDT9gBjLK7ps0f7OFcTTK6VgEPuCC+ecLSUl6K4zXVvkQZg32upzVu21P5Y2WahWqRYVFeBWuzjaL0NODWSZpodeDlGc31a1VwoFDMBNqVAoF3TtGNVNxV8qUXlOjlL+qY7HSnbfa6gtRp8wWagnXlxTNsK2bFnADYuuFEYvfp/LjWDNLPyxy/9oL2xxzOuR/LdDR5GDwAXQIIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I6vM1xqXY7PBGnrccjC8UyEsjVpFodTLECAvK7FFNY=;
 b=Q5EmAbYMbaoNPL/u2LTOBKs3RJKmgv1UbUvns7mCqXhxIskoRfhhoaCrf6kx7DQzGo/am4m2p5ThLT5YX42z+Lwa4KnvLyoAeExWX8HXKHFj2QYmV72KmMVqTMttbj0CY+GNjlNtSI6uCsWT+tFTVQOOGMifjoJSx3dX3Z7JGgigBJnfhEb6o9xtrJwUcwOyCI0A3yasVkPD+g+bt3pv9rirLU5Kpz5B23gUJONwUI10cvCbCl4lz2HbvtJp6ko5NzYQQ/x1dRuAdbFHUxWhtxwpIzBKT7x2dzZ6LvYMV9ldcpLr93vB63gab+UrXStovQGo7l753E9WizFKDpGsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I6vM1xqXY7PBGnrccjC8UyEsjVpFodTLECAvK7FFNY=;
 b=Lnc0b19J1J8jHFqDq93GwZauR0i45o6O58R+/rgm6K/45KijbnYuz1IhT1gefYEB3q1SgSXAXrG58Ri6Dzq0vRZ26ts4dkaFaoC2RZONNsXb1Frb3MfphXSDkwfxvbc5FD8ngwUkJdFYFogPczN6CamLpcPOtOO5QAT9jOCpzWQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7517.namprd04.prod.outlook.com (2603:10b6:a03:32d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 04:30:56 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 04:30:56 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Thread-Topic: [PATCH v2 2/4] btrfs: mark device addition as
 mnt_want_write_file
Thread-Index: AQHYOTj/hKwZmfYHbUmaDCBwHOvDCqzCLSEAgAED2QCAADYmAIAHcawA
Date:   Tue, 22 Mar 2022 04:30:56 +0000
Message-ID: <20220322043056.3sgb75menaja4xex@naota-xeon>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
 <YjILAo2ueZsnhza/@debian9.Home> <20220317073628.slh4iyexpen7lmjh@naota-xeon>
 <YjMSaLIhKNcKUuHM@debian9.Home>
In-Reply-To: <YjMSaLIhKNcKUuHM@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8660215b-c021-4e1d-1649-08da0bbcc250
x-ms-traffictypediagnostic: SJ0PR04MB7517:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB751723A5CF406E98786ED6E28C179@SJ0PR04MB7517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zDgO3k4SzbB7pPryYgekGr5Vi03xR5D+xkWkdc986uKEYis3aM4/cOAIazpvCphoCQV8qkkWDRLBjchZIN3/9oYGhZWKzbiAQoG9XbuuzaWVKhTDLRnenRk75kSM7pprizrAJlxFdXAZF4WalEmTxL/wYXOwvNaV3eY8ckATuCKTuOClL8+4FGQwucDGh3idXSaV3LSO/JX6DKbAh9S3vM7yKMVtSbVcsopH9zgl5uVzgFsvHUcvzWea/qrEsfS0G1RhVmuDi1U7V/lcCYj0peXCPoIDkZW0RVEkEATPRzFgh3mxDCH1qzfYI/97x3FlyxUoAiPg8CUttGdIIp/KBc611bf9JSFk205wiIXzngMGWGgiTqMxs0pEwUDswyhWUgOXCC1KwdsyvBObjaw0CDGDWTod2+1JV2q1/4W8bMNaT4VOQYRTliQ2TfZIwMEkfnjLoCU4B27nxrNe2K03JmUmA9BeN4AjauxT91BG2nGIj2iaIbtZnl3e613m/ER7S07H3SgYCmgHZQxq++rYyIvSKMXhMv5h8tHUnvtPPqsWvy55Bn48Qpihwze5uWaeyInpClAv1xxKsIEE+lBaT7CILj+8jeporO7IrbNKAwvqSdOptO782VolaHnQUfUFEXGuuI1y4Sn2LZnrZDPnQbf1B9PeifdjotFvoLAX6zgnh3sAAS7aBZtfY/Ke7fKeQDP+DirqZ69Og4BtjkgT+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38070700005)(26005)(186003)(1076003)(2906002)(6916009)(5660300002)(86362001)(33716001)(38100700002)(8936002)(122000001)(82960400001)(66946007)(6512007)(66556008)(66446008)(66476007)(64756008)(76116006)(8676002)(91956017)(4326008)(508600001)(316002)(83380400001)(54906003)(9686003)(71200400001)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJegexqe+9IfwLWsG/CyMTNIIqMGq2SRqDod1McqGksQAqfrd91EPhz71zNv?=
 =?us-ascii?Q?TAO9Qds267aFfn1A6+1EudHLn5BiHSHs5GJGClQ4s0+ztcdsL/I8W9NfH/Qj?=
 =?us-ascii?Q?zs3zHQ0UoNH4jE0l+7Mnaxf4u72W00PzeFZ3rshs4XImedNtQMyTBrExRsg9?=
 =?us-ascii?Q?i2B+Vg9CKYPU+sWu57yem3bHY+4uwNUj0caGC7PnS7HdI+joskcAxSnRtMZi?=
 =?us-ascii?Q?V2V+RQDL4dh7736Jzl0e5DBnzq6pLZLx05/4WUymKyqNU7RFOzhJm7bcijBy?=
 =?us-ascii?Q?u7JYTYo8gi6R+lq0rxW5357m3dhC0STRyy+oxT6EBMhKcObiAOzPmLuFyGqt?=
 =?us-ascii?Q?410Xa6eap5wR8dNmClOlaeDDfcucDLsk4EhO8/aRa9kKpNs9d0oI9bsfKEjO?=
 =?us-ascii?Q?6gq81IjAL2VbIS3Au6BjwhIiPyvOIRN+TOFTZOBiIfo2diEbjeT2TAmfEABO?=
 =?us-ascii?Q?bVTV5iGswqdseQZ8i7Ig5Q+NGKQUSVjrIQ0Rt7yYzXhTDp+CRQnArAgb7Y8b?=
 =?us-ascii?Q?7ZQ1MBSMXvt2E4v8P4CbI2hF6ERByEiAf4uUSjfGN+wJwNPYJGpu+sMRSaPn?=
 =?us-ascii?Q?edeol/+cWuEDce3d7buGXR2FK0SlMw6HrbikUmkPcfKHx+GWeu48DbeklsBm?=
 =?us-ascii?Q?/N3M2FiOCOrnHhTHDBW3V73HxyesnmVPZHtmlVIC2+7BmKGHyH5/YKrnsCeB?=
 =?us-ascii?Q?YCjbYjZICOp0KV90t68Ax5PVMwWuPBh9qiKarEF05bjINZkixgBkco9tv1NP?=
 =?us-ascii?Q?uoHJccRJXFGthUjsCdF+0YwSZl2Y/wLB4cIe4Slc5MePAETuZHDTjWCliYMr?=
 =?us-ascii?Q?4eZspyfCJy8OzxQ3W7NbD97I0AZBS/LjKm0868olZz6RWpa6ok5ZbVSY4rlP?=
 =?us-ascii?Q?a6ja1W8a+q9VpUXCjtdXY6FAArOy1PKpBzx3rn8eXXfb6YH0HJcr5heZx4EW?=
 =?us-ascii?Q?S5JYKnc7VUWiPFoUbtInqvTJCKuM1Hqh8TDKQ9g2h6SZaXzg91V4lt2ZwR7h?=
 =?us-ascii?Q?F1aw16PSgRuLwou1M3sQxJqs3ZYM8ide79CpvYFbxWlKfTEKbLC3ykta8yw6?=
 =?us-ascii?Q?FoxA+KaJSX192Zt7hUdKdEy76lBStTQj1/VqHktZNW50d6kdMJmxuoh4GbjL?=
 =?us-ascii?Q?hyr0Qm86uaWuWwdoWA2dHYNldG4TTm3zD1guAmgHxMk0scwyAehWtP0fePqD?=
 =?us-ascii?Q?fZngDNqZjlHC5o6PnVUTlTjI0ENw4v4T9XufLbAQJcoawS+ersbihJRAx7Mo?=
 =?us-ascii?Q?GIiT9ZQncz52UfIbXO752xm5exGLkyBa73jGm5fwmbCtShx+oV6h3RhtlU66?=
 =?us-ascii?Q?i0MEfSeMIkS4Ao5Tesp5wYk70QdyE4Q6PxWawQQ0CODi3tWbQM7qWM8/FznH?=
 =?us-ascii?Q?XilCFit+Bns8Rmaxip7/JIiJjQudEi+IaB+W0NfMm7vSMW9tWe5DhaQMkbOU?=
 =?us-ascii?Q?UxhWDYxqGUqR4j2tMPnsM2uXLL1kPR7UZ9OdCMxpOY5W3kPJ3m4QwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30D5BE3310010F43A730F4F8FA1B90C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8660215b-c021-4e1d-1649-08da0bbcc250
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 04:30:56.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jicFbzvTwvFxVITDFL4LPUyazd4UQNR/RePFXJgmbhZYLwOncsLhrTVLRauFP1e02euYghqBVOpXXcgaP7z+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7517
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:50:16AM +0000, Filipe Manana wrote:
> On Thu, Mar 17, 2022 at 07:36:29AM +0000, Naohiro Aota wrote:
> > On Wed, Mar 16, 2022 at 04:06:26PM +0000, Filipe Manana wrote:
> > > On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> > > > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incu=
rs
> > > > file-system internal writing. That writing can cause a deadlock wit=
h
> > > > FS freezing like as described in like as described in commit
> > > > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> > > >=20
> > > > Mark the device addition as mnt_want_write_file. This is also consi=
stent
> > > > with the removing device ioctl counterpart.
> > > >=20
> > > > Cc: stable@vger.kernel.org # 4.9+
> > > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > ---
> > > >  fs/btrfs/ioctl.c | 11 +++++++++--
> > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index 60c907b14547..a6982a1fde65 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *f=
ile, void __user *argp)
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, voi=
d __user *arg)
> > > > +static long btrfs_ioctl_add_dev(struct file *file, void __user *ar=
g)
> > > >  {
> > > > +	struct inode *inode =3D file_inode(file);
> > > > +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> > > >  	struct btrfs_ioctl_vol_args *vol_args;
> > > >  	bool restore_op =3D false;
> > > >  	int ret;
> > > > @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs=
_fs_info *fs_info, void __user *arg)
> > > >  		return -EINVAL;
> > > >  	}
> > > > =20
> > > > +	ret =3D mnt_want_write_file(file);
> > > > +	if (ret)
> > > > +		return ret;
> > >=20
> > > So, this now breaks all test cases that exercise device seeding, and =
I clearly
> > > forgot about seeding when I asked about why not use mnt_want_write_fi=
le()
> > > instead of a bare call to sb_start_write():
> >=20
> > Ah, yes, I also confirmed they fail.
> >=20
> > >=20
> > > $ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > ><snip>
> > > Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > Failed 5 of 5 tests
> > >=20
> > > So device seeding introduces a special case. If we mount a seeding
> > > filesystem, it's RO, so the mnt_want_write_file() fails.
> >=20
> > Yeah, so we are in a mixed state here. It's RO with a seeding
> > device. Or, it must be RW otherwise (checked in
> > btrfs_init_new_device()).
> >=20
> > > Something like this deals with it and it makes the tests pass:
> > >=20
> > ><snip>
> > >=20
> > > We are also changing the semantics as we no longer allow for adding a=
 device
> > > to a RO filesystem. So the lack of a mnt_want_write_file() was intent=
ional
> > > to deal with the seeding filesystem case. But calling mnt_want_write_=
file()
> > > if we are not seeding, changes the semantics - I'm not sure if anyone=
 relies
> > > on the ability to add a device to a fs mounted RO, I'm not seeing if =
it's an
> > > useful use case.
> >=20
> > Adding a device to RO FS anyway returns -EROFS from
> > btrfs_init_new_device(). So, there is no change.
> >=20
> > > So either we do that special casing like in that diff, or we always d=
o the
> > > sb_start_write() / sb_end_write() - in any case please add a comment =
explaining
> > > why we do it like that, why we can't use mnt_want_write_file().
> >=20
> > The conditional using of sb_start_write() or mnt_want_write_file()
> > seems a bit dirty. And, I just thought, marking the FS "writing" when
> > it's read-only also seems odd.
> >=20
> > I'm now thinking we should have sb_start_write() around here where the
> > FS is surely RW.
> >=20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 393fc7db99d3..50e02dc4e2b2 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2731,6 +2731,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path
> > =20
> >  	mutex_unlock(&fs_devices->device_list_mutex);
> > =20
> > +	sb_start_write(fs_info->sb);
> > +
> >  	if (seeding_dev) {
> >  		mutex_lock(&fs_info->chunk_mutex);
> >  		ret =3D init_first_rw_device(trans);
> > @@ -2786,6 +2788,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path
> >  		ret =3D btrfs_commit_transaction(trans);
> >  	}
> > =20
> > +	sb_end_write(fs_info->sb);
> > +
> >  	/*
> >  	 * Now that we have written a new super block to this device, check a=
ll
> >  	 * other fs_devices list if device_path alienates any other scanned
> > @@ -2801,6 +2805,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path
> >  	return ret;
> > =20
> >  error_sysfs:
> > +	sb_end_write(fs_info->sb);
> > +
> >  	btrfs_sysfs_remove_device(device);
> >  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> >  	mutex_lock(&fs_info->chunk_mutex);
>=20
> Why not just reduce the scope to surround the btrfs_relocate_sys_chunks()=
 call?
> It's simpler, and I don't see why all the other code needs to be surround=
 by
> sb_start_write() and sb_end_write().

Yep, it turned out my patch caused a lockdep issue. Because we call
sb_start_intwrite in the transaction path, we can't call
sb_start_write() while the transaction is committed. So, at least we
need to narrow the region around btrfs_relocate_sys_chunks().

> Actually, relocating system chunks does not create ordered extents - that=
 only
> happens for data block groups. So we could could get away with all this, =
and
> have the relocation code do the assertion only if we are relocating a dat=
a
> block group - so no need to touch anything in the device add path.

Hmm, that's true. And, such metadata update is protected with
sb_start_intwrite()/sb_end_intwrite() in the transaction functions.

Maybe, we can just add sb_start_write_trylock() to
relocate_file_extent_cluster() ?

> Thanks.
>=20
> >=20
> > > Thanks.
> > >=20
> > >=20
> > > > +
> > > >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> > > >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> > > >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > > > @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_=
fs_info *fs_info, void __user *arg)
> > > >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> > > >  	else
> > > >  		btrfs_exclop_finish(fs_info);
> > > > +	mnt_drop_write_file(file);
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned =
int
> > > >  	case BTRFS_IOC_RESIZE:
> > > >  		return btrfs_ioctl_resize(file, argp);
> > > >  	case BTRFS_IOC_ADD_DEV:
> > > > -		return btrfs_ioctl_add_dev(fs_info, argp);
> > > > +		return btrfs_ioctl_add_dev(file, argp);
> > > >  	case BTRFS_IOC_RM_DEV:
> > > >  		return btrfs_ioctl_rm_dev(file, argp);
> > > >  	case BTRFS_IOC_RM_DEV_V2:
> > > > --=20
> > > > 2.35.1
> > > > =
