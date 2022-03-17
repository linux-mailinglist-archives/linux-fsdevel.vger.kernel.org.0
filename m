Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CC4DC03D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiCQHiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiCQHhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:37:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C8EA742;
        Thu, 17 Mar 2022 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647502593; x=1679038593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lmTctuGy666HCgqxvDo5ysANvspSnwEVexvJRTSbKDo=;
  b=WL5nw9+fZNeGRaabF/AtG2nwHOqqidfEkt3JvwZ5mGKdHeqlNG6MMJBW
   8izucDPWfV09Yh5bo05+G405EY0LVZnyBNlxXzoq8mV2x0VEyru+ot2Ys
   lQ2Z+hQ5ONok7VstMmsBslh5okEZ/Bo3l752BJvd0q25B0yfxkk7/Va11
   FkJ0KewF+On8Owh/+hB4oZrEsU8Tq7BMmpeVoZ5z0RaB3UODCJ6mRxK1u
   E0MRpKiZ9VKb7iaDTlNbdNOOFbMRsRR8pf5Snzpwql6S34vVcm6mp0TT2
   yRH/Z4JA7eBzFaz4JzSQJADUbycjAjJj/eKSk5lfKwaoHs/T+AAbEyq47
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,188,1643644800"; 
   d="scan'208";a="299728475"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 15:36:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1ZjrvPtmxP/xFpSY4NsEGdqxqjL3ZLcz+RezGLEEDBJ0nq3nERZAG9pd074TcKhlc3V19Ie06ea/JALvCK+MGU2X+KASt+dlCw0x1hFY2qWMhiCa7MUfny7cw2/zznHLvc0FZzerK0CMfOrXvtazrvSC7st/Vq6wMuQnG3lX/emq4RCFU9y3lR9xMq0oM6/8dJiV9qTLJnfkG7J2MQD5oo6K0urkOjFNf71C1V1MkwEJD6TekMLiP3Qvlwb2zYXQmm1SbYps5jbRSQrAR0yKh8B/pmHuOUxbrAHknZeZZAg9sysn2luWRZHssEDzi3TFQik621YAFM9gwttNuibTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoHBH9tHJkJEOjv26ma3/wgmDMdd2jIhwGPYGud3OHY=;
 b=RD+dLPlK9bs17aF86bKPluc1zIV0vBsFyZYrmCnz8dfS5URUKZO539eECldWzdnYJx5ywV/eUiKiZc6Y8QTFIFKp5N83Ijupdh32WdH2eGwIF0xtHwOUu5p3n01+U4sXG2sjOqWHf7Qs6r5ucPgamuSwpukL7Ez/uQOQ8/jsJmdexoIaI+Tjh/pfrP3MlpdAqCxhFmXRvmwVCbUQEgIJNUv/xLHEI+D39RBisULXndYYArDYZfJEhEf1MXkVWail5Ms9avApDB7AO7rrAM9BUvsMfZOcT+gty4Av0J7CSDKmfu1gz8lfNQuLPiGxm7TXS3YgrZCxdItfQzbc3EDp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoHBH9tHJkJEOjv26ma3/wgmDMdd2jIhwGPYGud3OHY=;
 b=els3R+ASzyoueKIgTvHZMVHE+EXTLH6G+VEjHGy2982RVwDTdUL1SeHJQ+WLIJCbicYxULej3kihUoRWTHh6GcgLuchqNwJ+wKm4YeMSbtTu4I/KVB7TSyRBa7AOkwOeDqrxgJgO1vpYU8q3qDsWMFiA+ptbBSIFp5zsc5mKuAo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN6PR04MB0674.namprd04.prod.outlook.com (2603:10b6:404:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 07:36:29 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:36:29 +0000
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
Thread-Index: AQHYOTj/hKwZmfYHbUmaDCBwHOvDCqzCLSEAgAED2QA=
Date:   Thu, 17 Mar 2022 07:36:29 +0000
Message-ID: <20220317073628.slh4iyexpen7lmjh@naota-xeon>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
 <YjILAo2ueZsnhza/@debian9.Home>
In-Reply-To: <YjILAo2ueZsnhza/@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6adcc31c-d3b3-46c0-0efb-08da07e8d9aa
x-ms-traffictypediagnostic: BN6PR04MB0674:EE_
x-microsoft-antispam-prvs: <BN6PR04MB06746CB309739AEA052CFE888C129@BN6PR04MB0674.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBUFpWVXPeWlwi8fpW43IfA9v1mzuuAx70rdcEG3WFgpXRJrU01DFybxN61bQ/lWXHnMxP0qGHJ/kbmKzmREd3BhVhnl1QIw7T/V7jLDYeO2335QaKJ/VXI5hUVOCRlQV334QU224ifBIX1if1H+6KIJ9tVjoJJO1dZPy/sXrQKEaakwqxm81LjVWx1Y1VC8nAXmYe9yGF6mQLJne1vP+YLMQHXmbaj2jtvqCIP41WMaf1vQf6LwUzVVdFzGXepW04K0hiuHmkd8zM4EgvsMvs67sX4Q+b5FusgxGnoo6RwnPk+ZjooLZk9xbI3NCrVVf67s6f2SwU4el//YwLqSyKJOxd1k357D+c/jb4P6GU4cbHDNcnkTz98MlU99mRTcpxJS08e7dh+Ja9oucqBLeVMs+lOsSqwYE1w+a/QE8pnjeHikb2aCSI18au+Fu/1mNqXD1kXMs+9rjLWM+8DUCNU/X9umSIFyTs5GvR6WUSLDORmGcC70hEGfNOYoJGJQXbWiQIBS9iIhqjo7TZpZM8Z4b/f+wQW0/NYGiRykq0lRTHi5j+LvhJIOBE1jf5L/nT2VQTt2ZYNIy9KLbGqd7wkjrpE7igvaONZq8L44QRoTL5i5vCdNA595IrwjowqpEN4yvuPIHxaQx7BtQ5d0LiBf8H/LKA7g0uY7V7fj++RRNRVcfbCeKNK74mLqvKNSnS2uMXcHZGCiQvAu9jnC5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8936002)(5660300002)(26005)(6506007)(9686003)(316002)(83380400001)(6512007)(2906002)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(66946007)(91956017)(76116006)(186003)(86362001)(33716001)(38070700005)(122000001)(82960400001)(71200400001)(1076003)(6916009)(54906003)(6486002)(508600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4m9eDOe+d6AlOEjsV/N9wJjI3dh5HykdRLXP/8mkBGmWz5B51C2qxUa1yKB?=
 =?us-ascii?Q?uTs66ebOQnaFmCUUmPdhdcQlx6idHRn0qJgD3k429acyLkh3IBPYm9Ygr2ND?=
 =?us-ascii?Q?DIIk96LBg1uPmfVn+/fYvG7PPa5JHrBDmY5COdO9pXjgJ/vxC42YaivN3lsx?=
 =?us-ascii?Q?1wRHCiWsmxFRuFc6TTkfgocQlgzBQ47rsIF7Asn/CpzyCuZvc1lkcQeDhyjP?=
 =?us-ascii?Q?QZnstoeOOuUhzdaR6XXQtGaNNERhYUgMzGXgCMvrCuLChBKjb0uuF9PBYYL6?=
 =?us-ascii?Q?XiHTI3nhYXcYVOePgZJs8A8xjnFE39FTb0AJiFlGCbeH0TXJRaCcc4aN2BPr?=
 =?us-ascii?Q?+MmjTSvwYXD/8CgL/CEmby00R5m+cZfPE9hSYgcjyIsTB+YH+rzKHwmKzJQD?=
 =?us-ascii?Q?TemMpWHEcAcbkTKmgiSJ+7a/9rpUZPGRWK2kjzrjcmIva9G+vaMkwi6a7mJN?=
 =?us-ascii?Q?MDeoZasHY6w3GkVC2XNO7li2lA/4VHbpuX5hH+VZLFwrHAeWqFStdFEZ3W4B?=
 =?us-ascii?Q?Mrof5NJd8gURr92AXftcNygHGoTo5O5tlZnw709rRAMK/3PCT52i8k0zIYq2?=
 =?us-ascii?Q?lM+6nrG7HoPJxTudvmNBIsEG+8P6p8ELOGjGgJdXiMTrM0AEiIpO5HEP0j2C?=
 =?us-ascii?Q?9DDYunc9nmTcT1FvV3ygMCB9A/CU5tWpOamKz6+Vz0NvCse4vANQaFuko7ik?=
 =?us-ascii?Q?fa9Bk5hVUHhhc18LaHG0eWOTUuhTqJYB2NzioOWrUgJWSlAM3P9VZqMcWc01?=
 =?us-ascii?Q?G3NiyE/bHtVpbnRsBB3A+XXy9xoDbXxXMkdKQe9LMyod+S7KhsbohMJzQ0hp?=
 =?us-ascii?Q?BWteuamNCZBkGR7kz+ff31np0hRIBXNnV2N0FBXAWWv1+ZkkHAWM3sgWvtYM?=
 =?us-ascii?Q?LiN0fatMDw5wED9SW1bBrfW8ocGOvKcdWsupQeZ9zoFJ8+NoKgIDrK5Y1sSi?=
 =?us-ascii?Q?eOGNI0bKWoex1YkJ0iYI0hmkZasO6/+jTidGIUIF7ZMvWc+QifHATqdnQd3V?=
 =?us-ascii?Q?AiBYQEGE2mZUG/b/uF2yRNwUKz+OR0hzOtRVQL4Eq1bRwT0BeqSoIb3D5DrW?=
 =?us-ascii?Q?gVLzok2LArR0z9EhI1GKm3fy1JxmZVTJxHPiGMsZcRo4tKAITvVix4KtIe99?=
 =?us-ascii?Q?Bve+Mrf6qN+l7ZagHl5cDQkelFS9riXrovNvxVB50ptbjfMptWynN7smBMFU?=
 =?us-ascii?Q?c188JTEZEoQMEebeZrEtlnJTdtKCzKNhT0F4JcnGrt5Mmfdg5lCX6V1+Kzu8?=
 =?us-ascii?Q?SxmyJUvSlAQ2zdEeHaESfxrN92gtPVLZqnyAl9D//KrgewLcpWe6ootxP+K2?=
 =?us-ascii?Q?DFvck/1Ix2ls3ZDTyEvJLcjGWEBtmBYm4ssk8CP7keOqoMGHU6VRgEUupICv?=
 =?us-ascii?Q?1TOHjq3acUcpCPvqiIglvrIJcS+MGXhT81Bo7Q/GgSHeXzMzlRM7adtWJohA?=
 =?us-ascii?Q?J1dki+it5hnIlwQE4t/8GC2x7wqfcimN5DzfmaxcYjkLqkGZ3iEJPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BC29704E8B5E44B962D7DAAEAB73F32@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adcc31c-d3b3-46c0-0efb-08da07e8d9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 07:36:29.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jh/m06GO4c5JMvZqDwECgU3pCyHTYQC8lY9aiDPEmIqIxWJu1sjuPLKyIpGGR9lU33cjFHDLhAXTaYm1XCUT8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0674
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:06:26PM +0000, Filipe Manana wrote:
> On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> > file-system internal writing. That writing can cause a deadlock with
> > FS freezing like as described in like as described in commit
> > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> >=20
> > Mark the device addition as mnt_want_write_file. This is also consisten=
t
> > with the removing device ioctl counterpart.
> >=20
> > Cc: stable@vger.kernel.org # 4.9+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/ioctl.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 60c907b14547..a6982a1fde65 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *file,=
 void __user *argp)
> >  	return ret;
> >  }
> > =20
> > -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __=
user *arg)
> > +static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
> >  {
> > +	struct inode *inode =3D file_inode(file);
> > +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> >  	struct btrfs_ioctl_vol_args *vol_args;
> >  	bool restore_op =3D false;
> >  	int ret;
> > @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_=
info *fs_info, void __user *arg)
> >  		return -EINVAL;
> >  	}
> > =20
> > +	ret =3D mnt_want_write_file(file);
> > +	if (ret)
> > +		return ret;
>=20
> So, this now breaks all test cases that exercise device seeding, and I cl=
early
> forgot about seeding when I asked about why not use mnt_want_write_file()
> instead of a bare call to sb_start_write():

Ah, yes, I also confirmed they fail.

>=20
> $ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
><snip>
> Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> Failed 5 of 5 tests
>=20
> So device seeding introduces a special case. If we mount a seeding
> filesystem, it's RO, so the mnt_want_write_file() fails.

Yeah, so we are in a mixed state here. It's RO with a seeding
device. Or, it must be RW otherwise (checked in
btrfs_init_new_device()).

> Something like this deals with it and it makes the tests pass:
>=20
><snip>
>=20
> We are also changing the semantics as we no longer allow for adding a dev=
ice
> to a RO filesystem. So the lack of a mnt_want_write_file() was intentiona=
l
> to deal with the seeding filesystem case. But calling mnt_want_write_file=
()
> if we are not seeding, changes the semantics - I'm not sure if anyone rel=
ies
> on the ability to add a device to a fs mounted RO, I'm not seeing if it's=
 an
> useful use case.

Adding a device to RO FS anyway returns -EROFS from
btrfs_init_new_device(). So, there is no change.

> So either we do that special casing like in that diff, or we always do th=
e
> sb_start_write() / sb_end_write() - in any case please add a comment expl=
aining
> why we do it like that, why we can't use mnt_want_write_file().

The conditional using of sb_start_write() or mnt_want_write_file()
seems a bit dirty. And, I just thought, marking the FS "writing" when
it's read-only also seems odd.

I'm now thinking we should have sb_start_write() around here where the
FS is surely RW.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 393fc7db99d3..50e02dc4e2b2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2731,6 +2731,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_in=
fo, const char *device_path
=20
 	mutex_unlock(&fs_devices->device_list_mutex);
=20
+	sb_start_write(fs_info->sb);
+
 	if (seeding_dev) {
 		mutex_lock(&fs_info->chunk_mutex);
 		ret =3D init_first_rw_device(trans);
@@ -2786,6 +2788,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_in=
fo, const char *device_path
 		ret =3D btrfs_commit_transaction(trans);
 	}
=20
+	sb_end_write(fs_info->sb);
+
 	/*
 	 * Now that we have written a new super block to this device, check all
 	 * other fs_devices list if device_path alienates any other scanned
@@ -2801,6 +2805,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_in=
fo, const char *device_path
 	return ret;
=20
 error_sysfs:
+	sb_end_write(fs_info->sb);
+
 	btrfs_sysfs_remove_device(device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);

> Thanks.
>=20
>=20
> > +
> >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_i=
nfo *fs_info, void __user *arg)
> >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> >  	else
> >  		btrfs_exclop_finish(fs_info);
> > +	mnt_drop_write_file(file);
> >  	return ret;
> >  }
> > =20
> > @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned int
> >  	case BTRFS_IOC_RESIZE:
> >  		return btrfs_ioctl_resize(file, argp);
> >  	case BTRFS_IOC_ADD_DEV:
> > -		return btrfs_ioctl_add_dev(fs_info, argp);
> > +		return btrfs_ioctl_add_dev(file, argp);
> >  	case BTRFS_IOC_RM_DEV:
> >  		return btrfs_ioctl_rm_dev(file, argp);
> >  	case BTRFS_IOC_RM_DEV_V2:
> > --=20
> > 2.35.1
> > =
