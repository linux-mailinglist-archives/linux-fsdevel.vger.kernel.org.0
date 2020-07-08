Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D221886C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgGHNFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:05:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1086 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgGHNFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594213500; x=1625749500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Wvu/yPl9FtAKyiXuazAQWtaL144qCfXA4zFvgzXKoM=;
  b=KU4n3w2WBf1K4LC9VxYqnQUeA4q8RPNOGqiJzYHIcziDoMpPd3NSKUFN
   dfr+iGLnZbP0+GSsmEMq7aarAbscGA7t7bMerBJdLOlIlWIxfw3QXx1dw
   TZOCkfoeB5+Xz9J/3bCAlt+paszppn5IX+yrav64KbKRvl+UI5iGefTvK
   krehtTic20Rhtrx/s3H/ePlR1NHzSlPt4ZTWv3BzOsvbdcFe43uDUKSOm
   0i43u94QOEmN8EeQf+HfOHHtDqoHDhfNuMc/f5duVi/Q0IboBvcw074mS
   ZnEeO6erYAskaC8lVrmM5gODN/li/rwr+fKzzAZA55U+eRWcWnWkBqyPc
   w==;
IronPort-SDR: cBtVhrL2uLhXcVzFWdgPUggYe5zLSfdbsGE0BKHs2TcKfyAhCS6JGLIrvx1X3AdwB6z5/dBpTA
 b0+sh7r3p0AKV7ZYUq4+Khfbnzv6P7rVkUxQ7uPLKMvweYJ1F40ckHrWOw80lOQojrmq9zXUaF
 mh3C0+H64W5hEQMlogJdl6pD4wjzCfFboqL0FsldBbk1JS+EfLXvH76SYfXF8YkOKG/kDbGHB1
 Zqr/nXzMbziyj0QBsTSIOWstA2FRpS2kLcrRdblkx/QKummDTRA+EBqjE65O6OQJftzL+Mgjw1
 1kA=
X-IronPort-AV: E=Sophos;i="5.75,327,1589212800"; 
   d="scan'208";a="251164775"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 21:05:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk6YYt4H/C685Vc2h1hVaJTEByFsz2/QZWbSQzEmg7O1/Po7GXbhZs5ZWATDFDVnuk7+YrT+fXWsu24ZgDffJkaEvQc9qHCLHJ4MyOU4f+KdyFQrVgFa6SICuPwpF00tiB261THl25MACZljo4Or4ItArne2PLIUOz40zqt+920GBWijL+v8A82SFm2ZA0hlpIVgOzACaqVWV3UCvlc7KW+6RtrUfOQbPGlTNx9k0VLT/5xoocUEKEPpadl+LN9nSXHoD2RMsewhOn6ZiTZ8R9FnBqRkv05NSiPNmoMcHM28sqXPQLBljAMHSiUs6GEUU+HIbvpkTAM09FNnNEFnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdm2dEphy5dprcGtqXUuQxtJBIRoehNIRhL18UJ3jjA=;
 b=Ma4LiWbTdIjwoGSMkrgi1BB8kZLm4Gc2hJ8FBJKWD2qndkij7kFSoTYeT9iapIC+d26xwqf8TdnThtAZUDfY2jIJKn7LOpSZBGEIQithRCSJkdIA8RbDe9SxIn/JI8ZQi/oDbe4MNO26ePnQIbsXj4cZVi772VDt9EmU5dDB4ApnxzfrxYcRpUVFbHMna1a0UuyRNSpHAzVEbmQA22qVulr1vE/KScupwMDmwC22CGl/AQzahQ2TF17T+RkKyNgPg6YmXSqJM+D3BMlVkOJ/zaGbZfJN3QrIqKFd2fAAle6YviVMqsyE4/jgyTxCt9QyPyK606cfN/WnkYLy9tzF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdm2dEphy5dprcGtqXUuQxtJBIRoehNIRhL18UJ3jjA=;
 b=m1WlqFiULwJk+oBpbIYNQgldhVLWmCHk0XQLgDTVaTHxOPKho7DM5UgrMkwgdg8IjYcpP/oub55E9dR58i6uxarrocbIqz1CpnOD+5uA2sqPg5NyXnn0TEUfyMbc72/yHnxKrDNCqySshEhz8MSnwwWv8pSI7meLqlgTNs0Yb50=
Received: from BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12)
 by BYAPR04MB5781.namprd04.prod.outlook.com (2603:10b6:a03:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 13:04:58 +0000
Received: from BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b]) by BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b%7]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 13:04:58 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Chao Yu <yuchao0@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>, "hch@lst.de" <hch@lst.de>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: RE: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Topic: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Index: AQHWUIkRI5HubGFr/0O9cA9AIcqh/aj8EGmAgABHC2CAAKfqgIAAq79Q
Date:   Wed, 8 Jul 2020 13:04:58 +0000
Message-ID: <BY5PR04MB69956185F538985101390AB78C670@BY5PR04MB6995.namprd04.prod.outlook.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <d262eba9-31d5-6205-3244-b5176a17637c@huawei.com>
 <BY5PR04MB6995AD34A289A013932E1A698C660@BY5PR04MB6995.namprd04.prod.outlook.com>
 <038b0276-d6b4-73b7-7844-8da6219976b3@huawei.com>
In-Reply-To: <038b0276-d6b4-73b7-7844-8da6219976b3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.109.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a8a6585-bc81-4966-2f45-08d8233f84b7
x-ms-traffictypediagnostic: BYAPR04MB5781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5781515A4168F410B89363868C670@BYAPR04MB5781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVdv2oSZyzbMgVU3J5Kz6XiXK2azoxNCYFnwNRrYXn2bPK4s+tz1JxrPZ8eU0/NAPqwAUTcve6/g/coObtcVRLbuprkEBiUf5vbf2mCmQIh/t31jUKR6y4ib08mNkLi2u2q6G3YSWHdcibAzJj2I97VbiYLSYjEeWYy2h9FfM6DAsem2hOABjmST0Yg4bNTxYr/83/tNuGvbvNxK6XFS4v2Wvt9UMOK2G5cm77MaSp1uBAgZosKJ3l7Hb4k1jSV2rjVYghZbwT9aCkJYZ8sF3DsLFbfAP3OkfFUDe3kzPYFXrrSd3S6rzNBl4Z9iRr36rgRdziR+4e6IVyjsgGl3Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6995.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66476007)(2906002)(53546011)(30864003)(186003)(52536014)(66946007)(54906003)(8676002)(478600001)(110136005)(316002)(83380400001)(86362001)(8936002)(7696005)(9686003)(55016002)(71200400001)(66446008)(66556008)(6506007)(64756008)(4326008)(26005)(76116006)(55236004)(33656002)(5660300002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vc5eHtL0s3MDVeMcXvWWW+ViIKcdHQWpY2DwRJ9frw5ax8BrIioZtnlE3a7h1nAm6NBKueavEdgerMwH/aIWuDtoCgdhILNhaPhxk1MeOQoxv4Tgez8loKdJ8drpk1uAV1gtUKJT2eYf69yeTjgn0j3YoOYwnjrFWsG7+xC4fUbMEMdMzGwZ4zncouBDPFAEWvfmzy+Ri0xttrPwX5EC+/gZQcgEgW2OVZllCR3PwKqBKXg++303jrYG4Ay5+l1lNkqiYJDeY5Ifx1Nn4ylusdUiMu7gMVN1hRDZfAinYnxZKa6xUgxU1IkVMpN+nnGpVwpJ4nswuHxwqadjmnyYvy5/DFs8vF4OGtMQB0largYMOMciL/TqACUbcWRbO5eKNWNXu65P+znbYFhgfUbhIoqJyEgXKfJ9ax/28dU6m/4oi7kvXMc7+R32jfud1a3VAbEe60iz52W4E47NE39HrKcJn/nAMu0H9iJ07PZOav33qnc9xeGDee7kBCCUPpPt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6995.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8a6585-bc81-4966-2f45-08d8233f84b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 13:04:58.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpk1jaYNkJx0G8GmADxc6mwUZRPk7PIc9NZavnAEFvQC0xNqNpsbXmRboeCnxzUqIjjF9cK5EWQcLsB3NMYMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5781
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please find my response inline.

Thanks,
Aravind

> -----Original Message-----
> From: Chao Yu <yuchao0@huawei.com>
> Sent: Wednesday, July 8, 2020 8:04 AM
> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>; jaegeuk@kernel.org; linux-
> fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net; hch@lst.=
de
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
>=20
> On 2020/7/8 2:23, Aravind Ramesh wrote:
> > Thanks for review Chao Yu.
> > Please find my response inline.
> > I will re-send a V2 after incorporating your comments.
> >
> > Regards,
> > Aravind
> >
> >> -----Original Message-----
> >> From: Chao Yu <yuchao0@huawei.com>
> >> Sent: Tuesday, July 7, 2020 5:49 PM
> >> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>; jaegeuk@kernel.org;
> >> linux- fsdevel@vger.kernel.org;
> >> linux-f2fs-devel@lists.sourceforge.net; hch@lst.de
> >> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> >> <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> >> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone
> >> size
> >>
> >> On 2020/7/2 23:54, Aravind Ramesh wrote:
> >>> NVMe Zoned Namespace devices can have zone-capacity less than zone-si=
ze.
> >>> Zone-capacity indicates the maximum number of sectors that are
> >>> usable in a zone beginning from the first sector of the zone. This
> >>> makes the sectors sectors after the zone-capacity till zone-size to b=
e unusable.
> >>> This patch set tracks zone-size and zone-capacity in zoned devices
> >>> and calculate the usable blocks per segment and usable segments per s=
ection.
> >>>
> >>> If zone-capacity is less than zone-size mark only those segments
> >>> which start before zone-capacity as free segments. All segments at
> >>> and beyond zone-capacity are treated as permanently used segments.
> >>> In cases where zone-capacity does not align with segment size the
> >>> last segment will start before zone-capacity and end beyond the
> >>> zone-capacity of the zone. For such spanning segments only sectors
> >>> within the
> >> zone-capacity are used.
> >>>
> >>> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> >>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> >>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> >>> ---
> >>>  fs/f2fs/f2fs.h    |   5 ++
> >>>  fs/f2fs/segment.c | 136
> >> ++++++++++++++++++++++++++++++++++++++++++++--
> >>>  fs/f2fs/segment.h |   6 +-
> >>>  fs/f2fs/super.c   |  41 ++++++++++++--
> >>>  4 files changed, 176 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> >>> e6e47618a357..73219e4e1ba4 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -1232,6 +1232,7 @@ struct f2fs_dev_info {  #ifdef
> >>> CONFIG_BLK_DEV_ZONED
> >>>  	unsigned int nr_blkz;		/* Total number of zones */
> >>>  	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
> >>> +	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks
> >>> +*/
> >>>  #endif
> >>>  };
> >>>
> >>> @@ -3395,6 +3396,10 @@ void
> >>> f2fs_destroy_segment_manager_caches(void);
> >>>  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);  enum rw_hint
> >>> f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> >>>  			enum page_type type, enum temp_type temp);
> >>> +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> >>> +			unsigned int segno);
> >>> +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> >>> +			unsigned int segno);
> >>>
> >>>  /*
> >>>   * checkpoint.c
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> >>> c35614d255e1..d2156f3f56a5 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -4294,9 +4294,12 @@ static void init_free_segmap(struct
> >>> f2fs_sb_info *sbi)  {
> >>>  	unsigned int start;
> >>>  	int type;
> >>> +	struct seg_entry *sentry;
> >>>
> >>>  	for (start =3D 0; start < MAIN_SEGS(sbi); start++) {
> >>> -		struct seg_entry *sentry =3D get_seg_entry(sbi, start);
> >>> +		if (f2fs_usable_blks_in_seg(sbi, start) =3D=3D 0)
> >>
> >> If usable blocks count is zero, shouldn't we update
> >> SIT_I(sbi)->written_valid_blocks as we did when there is partial usabl=
e block in
> current segment?
> > If usable_block_count is zero, then it is like a dead segment, all
> > blocks in the segment lie after the zone-capacity in the zone. So there=
 can never be
> a valid written content on these segments, hence it is not updated.
> > In the other case, when a segment start before the zone-capacity and
> > it ends beyond zone-capacity, then there are some blocks before zone-ca=
pacity
> which can be used, so they are accounted for.
>=20
> I'm thinking that for limit_free_user_blocks() function, it assumes all u=
nwritten
> blocks as potential reclaimable blocks, however segment after zone-capaci=
ty should
> never be used or reclaimable, it looks calculation could be not correct h=
ere.
>=20
The sbi->user_block_count is updated with the total usable_blocks in the fu=
ll=20
file system during the formatting of the file system using mkfs.f2fs. Pleas=
e see the f2fs-tools
patch series that I have submitted along with this patch set.=20

So sbi->user_block_count reflects the actual number of usable blocks (i.e. =
total blocks - unusable blocks).

> static inline block_t limit_free_user_blocks(struct f2fs_sb_info *sbi) {
> 	block_t reclaimable_user_blocks =3D sbi->user_block_count -
> 		written_block_count(sbi);
> 	return (long)(reclaimable_user_blocks * LIMIT_FREE_BLOCK) / 100; }
>=20
> static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi) {
> 	block_t invalid_user_blocks =3D sbi->user_block_count -
> 					written_block_count(sbi);
> 	/*
> 	 * Background GC is triggered with the following conditions.
> 	 * 1. There are a number of invalid blocks.
> 	 * 2. There is not enough free space.
> 	 */
> 	if (invalid_user_blocks > limit_invalid_user_blocks(sbi) &&
> 			free_user_blocks(sbi) < limit_free_user_blocks(sbi))
>=20
> -- In this condition, free_user_blocks() doesn't include segments after z=
one-capacity,
> however limit_free_user_blocks() includes them.
In the second patch of this patch set, free_user_blocks is updated to accou=
nt for the segments after zone-capacity.
It basically gets the free segment(segments before zone capacity and free) =
block count and deducts the=20
overprovision segment block count. It also considers the spanning segments =
block count into account.


>=20
> 		return true;
> 	return false;
> }
>=20
>=20
> >>
> >>> +			continue;
> >>> +		sentry =3D get_seg_entry(sbi, start);
> >>>  		if (!sentry->valid_blocks)
> >>>  			__set_free(sbi, start);
> >>>  		else
> >>> @@ -4316,7 +4319,7 @@ static void init_dirty_segmap(struct f2fs_sb_in=
fo
> *sbi)
> >>>  	struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> >>>  	struct free_segmap_info *free_i =3D FREE_I(sbi);
> >>>  	unsigned int segno =3D 0, offset =3D 0, secno;
> >>> -	unsigned short valid_blocks;
> >>> +	unsigned short valid_blocks, usable_blks_in_seg;
> >>>  	unsigned short blks_per_sec =3D BLKS_PER_SEC(sbi);
> >>>
> >>>  	while (1) {
> >>> @@ -4326,9 +4329,10 @@ static void init_dirty_segmap(struct f2fs_sb_i=
nfo
> *sbi)
> >>>  			break;
> >>>  		offset =3D segno + 1;
> >>>  		valid_blocks =3D get_valid_blocks(sbi, segno, false);
> >>> -		if (valid_blocks =3D=3D sbi->blocks_per_seg || !valid_blocks)
> >>> +		usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, segno);
> >>> +		if (valid_blocks =3D=3D usable_blks_in_seg || !valid_blocks)
> >>
> >> It needs to traverse .cur_valid_map bitmap to check whether blocks in
> >> range of [0, usable_blks_in_seg] are all valid or not, if there is at
> >> least one usable block in the range, segment should be dirty.
> > For the segments which start and end before zone-capacity are just like=
 any
> normal segments.
> > Segments which start after the zone-capacity are fully unusable and are=
 marked as
> used in the free_seg_bitmap, so these segments are never used.
> > Segments which span across the zone-capacity have some unusable blocks.=
 Even
> when blocks from these segments are allocated/deallocated the valid_block=
s
> counter is incremented/decremented, reflecting the current valid_blocks c=
ount.
> > Comparing valid_blocks count with usable_blocks count in the segment ca=
n
> indicate if the segment is dirty or fully used.
>=20
> I thought that if there is one valid block locates in range of [usable_bl=
ks_in_seg,
> blks_per_seg] (after zone-capacity), the condition will be incorrect. Tha=
t should
> never happen, right?
Yes, this will never happen. All blocks after zone-capacity are never usabl=
e.
>=20
> If so, how about adjusting check_block_count() to do sanity check on bitm=
ap locates
> after zone-capacity to make sure there is no free slots there.

Ok, I will add this check in check_block_count. It makes sense.

>=20
> > Sorry, but could you please share why cur_valid_map needs to be travers=
ed ?
> >
> >>
> >> One question, if we select dirty segment which across zone-capacity
> >> as opened segment (in curseg), how can we avoid allocating usable
> >> block beyong zone-capacity in such segment via .cur_valid_map?
> > For zoned devices, we have to allocate blocks sequentially, so it's alw=
ays in LFS
> manner it is allocated.
> > The __has_curseg_space() checks for the usable blocks and stops allocat=
ing blocks
> after zone-capacity.
>=20
> Oh, that was implemented in patch 2, I haven't checked that patch...sorry=
, however,
> IMO, patch should be made to apply independently, what if do allocation o=
nly after
> applying patch 1..., do we need to merge them into one?
The patches were split keeping in mind that all data structure related and =
initialization
Changes would go into patch 1 and IO path and GC related changes in patch 2=
.
But if you think, merging them to a single patch will be easier to review,=
=20
then I shall merge it and send it as one patch in V2, along with other sugg=
estions incorporated.

Please let me know.
>=20
> >>
> >>>  			continue;
> >>> -		if (valid_blocks > sbi->blocks_per_seg) {
> >>> +		if (valid_blocks > usable_blks_in_seg) {
> >>>  			f2fs_bug_on(sbi, 1);
> >>>  			continue;
> >>>  		}
> >>> @@ -4678,6 +4682,101 @@ int f2fs_check_write_pointer(struct
> >>> f2fs_sb_info *sbi)
> >>>
> >>>  	return 0;
> >>>  }
> >>> +
> >>> +static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone=
_idx,
> >>> +						unsigned int dev_idx)
> >>> +{
> >>> +	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
> >>> +		return true;
> >>> +	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq); }
> >>> +
> >>> +/* Return the zone index in the given device */ static unsigned int
> >>> +get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
> >>> +					int dev_idx)
> >>> +{
> >>> +	block_t sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi=
,
> >>> +secno));
> >>> +
> >>> +	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
> >>> +						sbi->log_blocks_per_blkz;
> >>> +}
> >>> +
> >>> +/*
> >>> + * Return the usable segments in a section based on the zone's
> >>> + * corresponding zone capacity. Zone is equal to a section.
> >>> + */
> >>> +static inline unsigned int f2fs_usable_zone_segs_in_sec(
> >>> +		struct f2fs_sb_info *sbi, unsigned int segno) {
> >>> +	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
> >>> +
> >>> +	dev_idx =3D f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> >>> +	zone_idx =3D get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno),
> >>> +dev_idx);
> >>> +
> >>> +	/* Conventional zone's capacity is always equal to zone size */
> >>> +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> >>> +		return sbi->segs_per_sec;
> >>> +
> >>> +	/*
> >>> +	 * If the zone_capacity_blocks array is NULL, then zone capacity
> >>> +	 * is equal to the zone size for all zones
> >>> +	 */
> >>> +	if (!FDEV(dev_idx).zone_capacity_blocks)
> >>> +		return sbi->segs_per_sec;
> >>> +
> >>> +	/* Get the segment count beyond zone capacity block */
> >>> +	unusable_segs_in_sec =3D (sbi->blocks_per_blkz -
> >>> +				FDEV(dev_idx).zone_capacity_blocks[zone_idx])
> >>>>
> >>> +				sbi->log_blocks_per_seg;
> >>> +	return sbi->segs_per_sec - unusable_segs_in_sec; }
> >>> +
> >>> +/*
> >>> + * Return the number of usable blocks in a segment. The number of
> >>> +blocks
> >>> + * returned is always equal to the number of blocks in a segment
> >>> +for
> >>> + * segments fully contained within a sequential zone capacity or a
> >>> + * conventional zone. For segments partially contained in a
> >>> +sequential
> >>> + * zone capacity, the number of usable blocks up to the zone
> >>> +capacity
> >>> + * is returned. 0 is returned in all other cases.
> >>> + */
> >>> +static inline unsigned int f2fs_usable_zone_blks_in_seg(
> >>> +			struct f2fs_sb_info *sbi, unsigned int segno) {
> >>> +	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> >>> +	unsigned int zone_idx, dev_idx, secno;
> >>> +
> >>> +	secno =3D GET_SEC_FROM_SEG(sbi, segno);
> >>> +	seg_start =3D START_BLOCK(sbi, segno);
> >>> +	dev_idx =3D f2fs_target_device_index(sbi, seg_start);
> >>> +	zone_idx =3D get_zone_idx(sbi, secno, dev_idx);
> >>> +
> >>> +	/*
> >>> +	 * Conventional zone's capacity is always equal to zone size,
> >>> +	 * so, blocks per segment is unchanged.
> >>> +	 */
> >>> +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> >>> +		return sbi->blocks_per_seg;
> >>> +
> >>> +	if (!FDEV(dev_idx).zone_capacity_blocks)
> >>> +		return sbi->blocks_per_seg;
> >>> +
> >>> +	sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno)=
);
> >>> +	sec_cap_blkaddr =3D sec_start_blkaddr +
> >>> +				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
> >>> +
> >>> +	/*
> >>> +	 * If segment starts before zone capacity and spans beyond
> >>> +	 * zone capacity, then usable blocks are from seg start to
> >>> +	 * zone capacity. If the segment starts after the zone capacity,
> >>> +	 * then there are no usable blocks.
> >>> +	 */
> >>> +	if (seg_start >=3D sec_cap_blkaddr)
> >>> +		return 0;
> >>> +	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> >>> +		return sec_cap_blkaddr - seg_start;
> >>> +
> >>> +	return sbi->blocks_per_seg;
> >>> +}
> >>>  #else
> >>>  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)  { @@
> >>> -4688,7 +4787,36 @@ int f2fs_check_write_pointer(struct f2fs_sb_info
> >>> *sbi)  {
> >>>  	return 0;
> >>>  }
> >>> +
> >>> +static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_=
sb_info
> *sbi,
> >>> +							unsigned int segno)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_=
sb_info
> *sbi,
> >>> +							unsigned int segno)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>>  #endif
> >>> +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> >>> +					unsigned int segno)
> >>> +{
> >>> +	if (f2fs_sb_has_blkzoned(sbi))
> >>> +		return f2fs_usable_zone_blks_in_seg(sbi, segno);
> >>> +
> >>> +	return sbi->blocks_per_seg;
> >>> +}
> >>> +
> >>> +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> >>> +					unsigned int segno)
> >>> +{
> >>> +	if (f2fs_sb_has_blkzoned(sbi))
> >>> +		return f2fs_usable_zone_segs_in_sec(sbi, segno);
> >>> +
> >>> +	return sbi->segs_per_sec;
> >>> +}
> >>>
> >>>  /*
> >>>   * Update min, max modified time for cost-benefit GC algorithm diff
> >>> --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
> >>> f261e3e6a69b..79b0dc33feaf 100644
> >>> --- a/fs/f2fs/segment.h
> >>> +++ b/fs/f2fs/segment.h
> >>> @@ -411,6 +411,7 @@ static inline void __set_free(struct
> >>> f2fs_sb_info *sbi,
> >> unsigned int segno)
> >>>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> >>>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> >>>  	unsigned int next;
> >>> +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> >>>
> >>>  	spin_lock(&free_i->segmap_lock);
> >>>  	clear_bit(segno, free_i->free_segmap); @@ -418,7 +419,7 @@ static
> >>> inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
> >>>
> >>>  	next =3D find_next_bit(free_i->free_segmap,
> >>>  			start_segno + sbi->segs_per_sec, start_segno);
> >>> -	if (next >=3D start_segno + sbi->segs_per_sec) {
> >>> +	if (next >=3D start_segno + usable_segs) {
> >>>  		clear_bit(secno, free_i->free_secmap);
> >>>  		free_i->free_sections++;
> >>>  	}
> >>> @@ -444,6 +445,7 @@ static inline void __set_test_and_free(struct
> >>> f2fs_sb_info
> >> *sbi,
> >>>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> >>>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> >>>  	unsigned int next;
> >>> +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> >>>
> >>>  	spin_lock(&free_i->segmap_lock);
> >>>  	if (test_and_clear_bit(segno, free_i->free_segmap)) { @@ -453,7
> >>> +455,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info
> >>> +*sbi,
> >>>  			goto skip_free;
> >>>  		next =3D find_next_bit(free_i->free_segmap,
> >>>  				start_segno + sbi->segs_per_sec, start_segno);
> >>> -		if (next >=3D start_segno + sbi->segs_per_sec) {
> >>> +		if (next >=3D start_segno + usable_segs) {
> >>>  			if (test_and_clear_bit(secno, free_i->free_secmap))
> >>>  				free_i->free_sections++;
> >>>  		}
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> >>> 80cb7cd358f8..2686b07ae7eb 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -1164,6 +1164,7 @@ static void destroy_device_list(struct f2fs_sb_=
info
> *sbi)
> >>>  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);  #ifdef
> >> CONFIG_BLK_DEV_ZONED
> >>>  		kvfree(FDEV(i).blkz_seq);
> >>> +		kvfree(FDEV(i).zone_capacity_blocks);
> >>
> >> Now, f2fs_kzalloc won't allocate vmalloc's memory, so it's safe to use=
 kfree().
> > Ok
> >>
> >>>  #endif
> >>>  	}
> >>>  	kvfree(sbi->devs);
> >>> @@ -3039,13 +3040,26 @@ static int init_percpu_info(struct
> >>> f2fs_sb_info *sbi)  }
> >>>
> >>>  #ifdef CONFIG_BLK_DEV_ZONED
> >>> +
> >>> +struct f2fs_report_zones_args {
> >>> +	struct f2fs_dev_info *dev;
> >>> +	bool zone_cap_mismatch;
> >>> +};
> >>> +
> >>>  static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int i=
dx,
> >>> -			       void *data)
> >>> +			      void *data)
> >>>  {
> >>> -	struct f2fs_dev_info *dev =3D data;
> >>> +	struct f2fs_report_zones_args *rz_args =3D data;
> >>> +
> >>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> >>> +		return 0;
> >>> +
> >>> +	set_bit(idx, rz_args->dev->blkz_seq);
> >>> +	rz_args->dev->zone_capacity_blocks[idx] =3D zone->capacity >>
> >>> +						F2FS_LOG_SECTORS_PER_BLOCK;
> >>> +	if (zone->len !=3D zone->capacity && !rz_args->zone_cap_mismatch)
> >>> +		rz_args->zone_cap_mismatch =3D true;
> >>>
> >>> -	if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> >>> -		set_bit(idx, dev->blkz_seq);
> >>>  	return 0;
> >>>  }
> >>>
> >>> @@ -3053,6 +3067,7 @@ static int init_blkz_info(struct f2fs_sb_info
> >>> *sbi, int devi)  {
> >>>  	struct block_device *bdev =3D FDEV(devi).bdev;
> >>>  	sector_t nr_sectors =3D bdev->bd_part->nr_sects;
> >>> +	struct f2fs_report_zones_args rep_zone_arg;
> >>>  	int ret;
> >>>
> >>>  	if (!f2fs_sb_has_blkzoned(sbi))
> >>> @@ -3078,12 +3093,26 @@ static int init_blkz_info(struct
> >>> f2fs_sb_info *sbi, int
> >> devi)
> >>>  	if (!FDEV(devi).blkz_seq)
> >>>  		return -ENOMEM;
> >>>
> >>> -	/* Get block zones type */
> >>> +	/* Get block zones type and zone-capacity */
> >>> +	FDEV(devi).zone_capacity_blocks =3D f2fs_kzalloc(sbi,
> >>> +					FDEV(devi).nr_blkz * sizeof(block_t),
> >>> +					GFP_KERNEL);
> >>> +	if (!FDEV(devi).zone_capacity_blocks)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	rep_zone_arg.dev =3D &FDEV(devi);
> >>> +	rep_zone_arg.zone_cap_mismatch =3D false;
> >>> +
> >>>  	ret =3D blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zon=
e_cb,
> >>> -				  &FDEV(devi));
> >>> +				  &rep_zone_arg);
> >>>  	if (ret < 0)
> >>>  		return ret;
> >>
> >> Missed to call kfree(FDEV(devi).zone_capacity_blocks)?
> > Thanks for catching it. Will free it here also.
> >>
> >>>
> >>> +	if (!rep_zone_arg.zone_cap_mismatch) {
> >>> +		kvfree(FDEV(devi).zone_capacity_blocks);
> >>
> >> Ditto, kfree().
> > Ok.
> >>
> >> Thanks,
> >>
> >>> +		FDEV(devi).zone_capacity_blocks =3D NULL;
> >>> +	}
> >>> +
> >>>  	return 0;
> >>>  }
> >>>  #endif
> >>>
> > .
> >
