Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD747216489
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 05:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGD2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 23:28:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27424 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGD17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594092479; x=1625628479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LM5IgdSDJ/Km1MEn/v4m+FJ0HOEoUyCTLWybUMi651c=;
  b=qRh+pwU010u5IFBA7snMH8AhhRbUH7AMrwTN+WKobjlQGdkJn6SFEKoQ
   /rY0Z5xfIW3PdHhxv9pblEG0yLSfZh7a+JY31HPdiBMw8qunJOLZqcrPB
   hjjIDb2ZmFzgNaZ+tBF4PnsHXlmJty3BObqEhIC+8BLmR2fG1GevgNid8
   YVvdZMojBCFKqKjh5Rf4KjwnQvruN/RfeA050O6y4PPU40oirYxJguyoM
   RAiML1T5EZ5ZqpytSLBHNHTeoy7tMZfJ2ymLH6vD2z7pb0QkcUUPHvUAg
   qR1GQJk27ItkV5jIsNJJIDJ8V6TXdj7OTMQUaSWTNAYxGKOwZRdLpOSQc
   Q==;
IronPort-SDR: oC0JXzIk1IvX7wmkB6OKk1HQ/vTKu2Anr2I05SrW0ikeecjT8l3GeNM4szJtGjjhFG72z23MYq
 vzOsME8oP/Zik0ZjeT47iIv78i8SmxwepK/YNgz3S/hneyS1Yln3q/bjV35iUotFSERbAW6Bsw
 e+FBj71C0UmZOE0kVPccDH0bb9Xpz6eNdv8U5X2x4Co8oBgpAmeZS05R0e2ErLUqSSxHcsX579
 Qrqqwr/l5HVqTkrMlRF+tqTsCkcovg9gdOiJ6mHQOV5bP7cZz14eZRQCHFnPJHoh0fICxsGdo4
 srk=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; 
   d="scan'208";a="143113980"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 11:27:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0zHzygofoEIpK/Sp3ObKnttjWGCOe1osBqP/ec2sd8IdfVgrgWKkfxYVjOFjhDyGkoDittVxsztVAGTDkcGyKBNTdPzueceWC66eXFXRt6sXuFZMxCajlRQajpNKUfwiB1+Ur9580kmL8NBXQjWDvT8MQ0QpwLLu5jkKo2jOwu4DErD7UsgEJz/xFQmF5cYsDc9hGCP71scTMweb9J6cYNjmVojwzo35x9vAI0iJIo+mgsFgzRuHq1J70tKrrfLYQoScCMnxXTyYxCLB5Cyjjv+Wftm9pJi/rloCXGig34zGlGF4Pwc1sgGFZHk2qRd1JaIuw+LPhEK3OJhpqn9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZrCr/6QJrtbFiSQD0FQ/L+cY+qRY+nZqPcWoIX1iKA=;
 b=Ca7ZF3n7jWdHM78Cgku32w43rug7KG1RwxG0qcVnuzVbSz6AeaxeKiMqJqRdP9m1VWQQ2iFh5VLd9SIh8Iu8Bd5AKTxvIHryuDgK73WbLrafh1vXNUMikaRIumzGw/WwN5GyPBwiQtc1iNxd4c8cl8sNj7NGW9pgCXCkdSehPzRraFLw2smzLNDnMDuUgT7FQckEYsT1ZrIKAaJ3l4uvzdAxHU0+af5r7cOyq2zvjW/c8eqSHEE4NpeFb0yXS7FRt/4QzfC4579sYXLHA1e4q4Ltw0c3Ldz+AatxtKB5MzgqPl/I91A41UGvtdyizEUDsGOkWCVAFlkYP+ZOXA1OoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZrCr/6QJrtbFiSQD0FQ/L+cY+qRY+nZqPcWoIX1iKA=;
 b=nD8GSwD1cEosCcIt3KlSENQbH79krY3aukGfWomRRhQwzl/D60V6FLRPnIOOesbBjbsh1f1oWfYDggv3IpSUCbsp9Na9Mz15cLD8AEoQJzWUpgvsmqFhqxMM9cC4aoFLQCl1AXNZxEyGcRtWR3u5sTzdBRHKwbOQmwv32DBVOiE=
Received: from BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12)
 by BYAPR04MB6166.namprd04.prod.outlook.com (2603:10b6:a03:ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 03:27:56 +0000
Received: from BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b]) by BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 03:27:56 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: RE: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Topic: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Index: AQHWUIkRI5HubGFr/0O9cA9AIcqh/aj7RBoAgAA12+A=
Date:   Tue, 7 Jul 2020 03:27:56 +0000
Message-ID: <BY5PR04MB6995E03B6FE331FF0CDEE7AD8C660@BY5PR04MB6995.namprd04.prod.outlook.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <20200707000722.GB2897553@google.com>
In-Reply-To: <20200707000722.GB2897553@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.109.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ad5247f-9c59-4bca-f70f-08d82225bdda
x-ms-traffictypediagnostic: BYAPR04MB6166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB616622F69822F31F75A94BC88C660@BYAPR04MB6166.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYYTDltvTQ+aVOAYFQgsmoFGcI1/a6O8izoEuJM1I12Vw1Q54CoJFDJ0xd7awlkOlHUY9of/yr7pXAdY8MrJE0gJODye/m/YvNOGiSL6p9pkg3KinI6axmdXouFYP3zNdJmF3wy4jraFEKiIxl+WiWGPbufEF2W0nYr25vjiw9vUmfjovj2msdosy+2RxUAADaT+rirrMAiLZ7y/43VIdu+/H/S5fkyF+R+NQNHkkCJwFaIa0OHDLxhaGxNzfiIJaoqC5Y9kwhdnQKA8RJVx7FIRwFWZAgCSyFFCjzPsDdB88UoQVYiio2FQiRtARH/I1x/uChukEovHBxF6lbzYC745TJS6UxMU9WG7S/c2RL0QFjfGooQmpi5c3ETGAvKQnMAa3inPkwOcERQ6wZtT6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6995.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(7696005)(4326008)(9686003)(966005)(5660300002)(478600001)(71200400001)(83380400001)(53546011)(6506007)(186003)(55016002)(26005)(52536014)(2906002)(8936002)(30864003)(8676002)(54906003)(55236004)(86362001)(66476007)(64756008)(316002)(76116006)(66446008)(33656002)(66946007)(6916009)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZDJPfZu/AhcRQD/QGyfoPvUv14U9NSYHzzQiEoKqIOv8Maj0DeBrtlAYLBEv7pFdrNbnrqGUeSx8NO6BJbKkob2ylw4M2upB4YjM0/xp610XQ4vltWmKPMCA/Be5iZirwt/cAwNEf922/9bfVn68JAuV4VcrOEWuPSTX4yQu51ndrEd1sbfZrrSjsHgQZ8VI6afBK7OQBTJNbNsQ0dDUwzcDwSIRRVkGc9MB8OSu54Poyvghy8xtKwvI5f2+pY1bbdL46acLmuqkbHafkTPgGdasbvtOBh58rFqL9zZnDtdnLy/1B15h7PmdnscWyAtTEMf7nwvoRfPDX3jG04KKko1tQlM3cvg7r0kmwebwEExqtMvvlIIrTg9if2qgaSp4X8IOKBZEBLdZ19gCFOzr3Ree/dvn2NeeacReP77FTRMNGmALV2KTkh3pDu9WdQjVR9iXG7/2ihh8BwOaMk6hx2VHZ8P4mqBIb6sQyLU5IWPYFcpHWJe6yTCvk00MD5vs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6995.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad5247f-9c59-4bca-f70f-08d82225bdda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 03:27:56.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3p6FXuJvRKGSqGwX4SeJ8R8zAx7wCP+fd3Mx5crrumn49OzLtc/WQrB/wJv4L6t4oLi8U1WWYE4ojphmzMQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jaegeuk,

I had mentioned the dependency in the cover letter for this patch, as below=
.

This series is based on the git tree
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git branch dev

and requires the below patch in order to build.

https://lore.kernel.org/linux-nvme/20200701063720.GA28954@lst.de/T/#m19e019=
7ae1837b7fe959b13fbc2a859b1f2abc1e

The above patch has been merged to the nvme-5.9 branch in the git tree:
git://git.infradead.org/nvme.git

Could you consider picking up that patch in your tree ?

I have run checkpatch before sending this, it was ok. Ran it again.

f2fs$ scripts/checkpatch.pl ./0001-f2fs-support-zone-capacity-less-than-zon=
e-size.patch
total: 0 errors, 0 warnings, 289 lines checked

./0001-f2fs-support-zone-capacity-less-than-zone-size.patch has no obvious =
style problems and is ready for submission.

Thanks,
Aravind

> -----Original Message-----
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Sent: Tuesday, July 7, 2020 5:37 AM
> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>
> Cc: yuchao0@huawei.com; linux-fsdevel@vger.kernel.org; linux-f2fs-
> devel@lists.sourceforge.net; hch@lst.de; Damien Le Moal
> <Damien.LeMoal@wdc.com>; Niklas Cassel <Niklas.Cassel@wdc.com>; Matias
> Bjorling <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
>=20
> Hi,
>=20
> Is there any dependency to the patch? And, could you please run checkpatc=
h script?
>=20
> Thanks,
>=20
> On 07/02, Aravind Ramesh wrote:
> > NVMe Zoned Namespace devices can have zone-capacity less than zone-size=
.
> > Zone-capacity indicates the maximum number of sectors that are usable
> > in a zone beginning from the first sector of the zone. This makes the
> > sectors sectors after the zone-capacity till zone-size to be unusable.
> > This patch set tracks zone-size and zone-capacity in zoned devices and
> > calculate the usable blocks per segment and usable segments per section=
.
> >
> > If zone-capacity is less than zone-size mark only those segments which
> > start before zone-capacity as free segments. All segments at and
> > beyond zone-capacity are treated as permanently used segments. In
> > cases where zone-capacity does not align with segment size the last
> > segment will start before zone-capacity and end beyond the
> > zone-capacity of the zone. For such spanning segments only sectors with=
in the
> zone-capacity are used.
> >
> > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  fs/f2fs/f2fs.h    |   5 ++
> >  fs/f2fs/segment.c | 136
> ++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/f2fs/segment.h |   6 +-
> >  fs/f2fs/super.c   |  41 ++++++++++++--
> >  4 files changed, 176 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > e6e47618a357..73219e4e1ba4 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1232,6 +1232,7 @@ struct f2fs_dev_info {  #ifdef
> > CONFIG_BLK_DEV_ZONED
> >  	unsigned int nr_blkz;		/* Total number of zones */
> >  	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
> > +	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
> >  #endif
> >  };
> >
> > @@ -3395,6 +3396,10 @@ void f2fs_destroy_segment_manager_caches(void);
> >  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);  enum rw_hint
> > f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> >  			enum page_type type, enum temp_type temp);
> > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > +			unsigned int segno);
> > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > +			unsigned int segno);
> >
> >  /*
> >   * checkpoint.c
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> > c35614d255e1..d2156f3f56a5 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -4294,9 +4294,12 @@ static void init_free_segmap(struct
> > f2fs_sb_info *sbi)  {
> >  	unsigned int start;
> >  	int type;
> > +	struct seg_entry *sentry;
> >
> >  	for (start =3D 0; start < MAIN_SEGS(sbi); start++) {
> > -		struct seg_entry *sentry =3D get_seg_entry(sbi, start);
> > +		if (f2fs_usable_blks_in_seg(sbi, start) =3D=3D 0)
> > +			continue;
> > +		sentry =3D get_seg_entry(sbi, start);
> >  		if (!sentry->valid_blocks)
> >  			__set_free(sbi, start);
> >  		else
> > @@ -4316,7 +4319,7 @@ static void init_dirty_segmap(struct f2fs_sb_info=
 *sbi)
> >  	struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> >  	struct free_segmap_info *free_i =3D FREE_I(sbi);
> >  	unsigned int segno =3D 0, offset =3D 0, secno;
> > -	unsigned short valid_blocks;
> > +	unsigned short valid_blocks, usable_blks_in_seg;
> >  	unsigned short blks_per_sec =3D BLKS_PER_SEC(sbi);
> >
> >  	while (1) {
> > @@ -4326,9 +4329,10 @@ static void init_dirty_segmap(struct f2fs_sb_inf=
o *sbi)
> >  			break;
> >  		offset =3D segno + 1;
> >  		valid_blocks =3D get_valid_blocks(sbi, segno, false);
> > -		if (valid_blocks =3D=3D sbi->blocks_per_seg || !valid_blocks)
> > +		usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, segno);
> > +		if (valid_blocks =3D=3D usable_blks_in_seg || !valid_blocks)
> >  			continue;
> > -		if (valid_blocks > sbi->blocks_per_seg) {
> > +		if (valid_blocks > usable_blks_in_seg) {
> >  			f2fs_bug_on(sbi, 1);
> >  			continue;
> >  		}
> > @@ -4678,6 +4682,101 @@ int f2fs_check_write_pointer(struct
> > f2fs_sb_info *sbi)
> >
> >  	return 0;
> >  }
> > +
> > +static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_i=
dx,
> > +						unsigned int dev_idx)
> > +{
> > +	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
> > +		return true;
> > +	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq); }
> > +
> > +/* Return the zone index in the given device */ static unsigned int
> > +get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
> > +					int dev_idx)
> > +{
> > +	block_t sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi,
> > +secno));
> > +
> > +	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
> > +						sbi->log_blocks_per_blkz;
> > +}
> > +
> > +/*
> > + * Return the usable segments in a section based on the zone's
> > + * corresponding zone capacity. Zone is equal to a section.
> > + */
> > +static inline unsigned int f2fs_usable_zone_segs_in_sec(
> > +		struct f2fs_sb_info *sbi, unsigned int segno) {
> > +	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
> > +
> > +	dev_idx =3D f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> > +	zone_idx =3D get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx)=
;
> > +
> > +	/* Conventional zone's capacity is always equal to zone size */
> > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > +		return sbi->segs_per_sec;
> > +
> > +	/*
> > +	 * If the zone_capacity_blocks array is NULL, then zone capacity
> > +	 * is equal to the zone size for all zones
> > +	 */
> > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > +		return sbi->segs_per_sec;
> > +
> > +	/* Get the segment count beyond zone capacity block */
> > +	unusable_segs_in_sec =3D (sbi->blocks_per_blkz -
> > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx])
> >>
> > +				sbi->log_blocks_per_seg;
> > +	return sbi->segs_per_sec - unusable_segs_in_sec; }
> > +
> > +/*
> > + * Return the number of usable blocks in a segment. The number of
> > +blocks
> > + * returned is always equal to the number of blocks in a segment for
> > + * segments fully contained within a sequential zone capacity or a
> > + * conventional zone. For segments partially contained in a
> > +sequential
> > + * zone capacity, the number of usable blocks up to the zone capacity
> > + * is returned. 0 is returned in all other cases.
> > + */
> > +static inline unsigned int f2fs_usable_zone_blks_in_seg(
> > +			struct f2fs_sb_info *sbi, unsigned int segno) {
> > +	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> > +	unsigned int zone_idx, dev_idx, secno;
> > +
> > +	secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > +	seg_start =3D START_BLOCK(sbi, segno);
> > +	dev_idx =3D f2fs_target_device_index(sbi, seg_start);
> > +	zone_idx =3D get_zone_idx(sbi, secno, dev_idx);
> > +
> > +	/*
> > +	 * Conventional zone's capacity is always equal to zone size,
> > +	 * so, blocks per segment is unchanged.
> > +	 */
> > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > +		return sbi->blocks_per_seg;
> > +
> > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > +		return sbi->blocks_per_seg;
> > +
> > +	sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
> > +	sec_cap_blkaddr =3D sec_start_blkaddr +
> > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
> > +
> > +	/*
> > +	 * If segment starts before zone capacity and spans beyond
> > +	 * zone capacity, then usable blocks are from seg start to
> > +	 * zone capacity. If the segment starts after the zone capacity,
> > +	 * then there are no usable blocks.
> > +	 */
> > +	if (seg_start >=3D sec_cap_blkaddr)
> > +		return 0;
> > +	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> > +		return sec_cap_blkaddr - seg_start;
> > +
> > +	return sbi->blocks_per_seg;
> > +}
> >  #else
> >  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)  { @@
> > -4688,7 +4787,36 @@ int f2fs_check_write_pointer(struct f2fs_sb_info
> > *sbi)  {
> >  	return 0;
> >  }
> > +
> > +static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb=
_info *sbi,
> > +							unsigned int segno)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb=
_info *sbi,
> > +							unsigned int segno)
> > +{
> > +	return 0;
> > +}
> >  #endif
> > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > +					unsigned int segno)
> > +{
> > +	if (f2fs_sb_has_blkzoned(sbi))
> > +		return f2fs_usable_zone_blks_in_seg(sbi, segno);
> > +
> > +	return sbi->blocks_per_seg;
> > +}
> > +
> > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > +					unsigned int segno)
> > +{
> > +	if (f2fs_sb_has_blkzoned(sbi))
> > +		return f2fs_usable_zone_segs_in_sec(sbi, segno);
> > +
> > +	return sbi->segs_per_sec;
> > +}
> >
> >  /*
> >   * Update min, max modified time for cost-benefit GC algorithm diff
> > --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
> > f261e3e6a69b..79b0dc33feaf 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -411,6 +411,7 @@ static inline void __set_free(struct f2fs_sb_info *=
sbi,
> unsigned int segno)
> >  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> >  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> >  	unsigned int next;
> > +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> >
> >  	spin_lock(&free_i->segmap_lock);
> >  	clear_bit(segno, free_i->free_segmap); @@ -418,7 +419,7 @@ static
> > inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
> >
> >  	next =3D find_next_bit(free_i->free_segmap,
> >  			start_segno + sbi->segs_per_sec, start_segno);
> > -	if (next >=3D start_segno + sbi->segs_per_sec) {
> > +	if (next >=3D start_segno + usable_segs) {
> >  		clear_bit(secno, free_i->free_secmap);
> >  		free_i->free_sections++;
> >  	}
> > @@ -444,6 +445,7 @@ static inline void __set_test_and_free(struct f2fs_=
sb_info
> *sbi,
> >  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> >  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> >  	unsigned int next;
> > +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> >
> >  	spin_lock(&free_i->segmap_lock);
> >  	if (test_and_clear_bit(segno, free_i->free_segmap)) { @@ -453,7
> > +455,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *s=
bi,
> >  			goto skip_free;
> >  		next =3D find_next_bit(free_i->free_segmap,
> >  				start_segno + sbi->segs_per_sec, start_segno);
> > -		if (next >=3D start_segno + sbi->segs_per_sec) {
> > +		if (next >=3D start_segno + usable_segs) {
> >  			if (test_and_clear_bit(secno, free_i->free_secmap))
> >  				free_i->free_sections++;
> >  		}
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> > 80cb7cd358f8..2686b07ae7eb 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1164,6 +1164,7 @@ static void destroy_device_list(struct f2fs_sb_in=
fo *sbi)
> >  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);  #ifdef
> CONFIG_BLK_DEV_ZONED
> >  		kvfree(FDEV(i).blkz_seq);
> > +		kvfree(FDEV(i).zone_capacity_blocks);
> >  #endif
> >  	}
> >  	kvfree(sbi->devs);
> > @@ -3039,13 +3040,26 @@ static int init_percpu_info(struct
> > f2fs_sb_info *sbi)  }
> >
> >  #ifdef CONFIG_BLK_DEV_ZONED
> > +
> > +struct f2fs_report_zones_args {
> > +	struct f2fs_dev_info *dev;
> > +	bool zone_cap_mismatch;
> > +};
> > +
> >  static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx=
,
> > -			       void *data)
> > +			      void *data)
> >  {
> > -	struct f2fs_dev_info *dev =3D data;
> > +	struct f2fs_report_zones_args *rz_args =3D data;
> > +
> > +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > +		return 0;
> > +
> > +	set_bit(idx, rz_args->dev->blkz_seq);
> > +	rz_args->dev->zone_capacity_blocks[idx] =3D zone->capacity >>
> > +						F2FS_LOG_SECTORS_PER_BLOCK;
> > +	if (zone->len !=3D zone->capacity && !rz_args->zone_cap_mismatch)
> > +		rz_args->zone_cap_mismatch =3D true;
> >
> > -	if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > -		set_bit(idx, dev->blkz_seq);
> >  	return 0;
> >  }
> >
> > @@ -3053,6 +3067,7 @@ static int init_blkz_info(struct f2fs_sb_info
> > *sbi, int devi)  {
> >  	struct block_device *bdev =3D FDEV(devi).bdev;
> >  	sector_t nr_sectors =3D bdev->bd_part->nr_sects;
> > +	struct f2fs_report_zones_args rep_zone_arg;
> >  	int ret;
> >
> >  	if (!f2fs_sb_has_blkzoned(sbi))
> > @@ -3078,12 +3093,26 @@ static int init_blkz_info(struct f2fs_sb_info *=
sbi, int
> devi)
> >  	if (!FDEV(devi).blkz_seq)
> >  		return -ENOMEM;
> >
> > -	/* Get block zones type */
> > +	/* Get block zones type and zone-capacity */
> > +	FDEV(devi).zone_capacity_blocks =3D f2fs_kzalloc(sbi,
> > +					FDEV(devi).nr_blkz * sizeof(block_t),
> > +					GFP_KERNEL);
> > +	if (!FDEV(devi).zone_capacity_blocks)
> > +		return -ENOMEM;
> > +
> > +	rep_zone_arg.dev =3D &FDEV(devi);
> > +	rep_zone_arg.zone_cap_mismatch =3D false;
> > +
> >  	ret =3D blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_=
cb,
> > -				  &FDEV(devi));
> > +				  &rep_zone_arg);
> >  	if (ret < 0)
> >  		return ret;
> >
> > +	if (!rep_zone_arg.zone_cap_mismatch) {
> > +		kvfree(FDEV(devi).zone_capacity_blocks);
> > +		FDEV(devi).zone_capacity_blocks =3D NULL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  #endif
> > --
> > 2.19.1
