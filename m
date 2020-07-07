Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37DC21769B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgGGSXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 14:23:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24522 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGGSXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594146213; x=1625682213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NFG6ZcY/Wq+Za+XZKRrl3IM4Q0sf4jb58wLUu/hP/Ek=;
  b=d5+bEMN4+a7qnIc1QJt6l+V1JxVmL59pE+GxYiD4RVBSOR6R1mNl/sLs
   T0GPkJgHge8N9umT1M9UrEEUS1NWEURCsBcuA5Nfr9zyTNLiPTLN/6zRI
   XfpUHIySIGvqMkqRNLOcHFcSY03hiKoYe/NJdV/bnwSeTjJU9hDSvdrLr
   0SdtmgbNTLy9LqjBw0R37Sf6pZt0UJX7jZjHcUkXmRIBbreRdFRkIq9ZT
   //0wu6WBhoGOEMPgkgOjDwqaqt8PzCCL2jDJJK9e7ZC0Wb9jmwbLnjKRR
   uGIA2wDM24tBZ9RP/1Y4YVQJjO5zFHofebv+eS1Qiiw5+XcQ393gUaAEw
   A==;
IronPort-SDR: Z+gYtzkK9uTa7ZZW7Qfb4RqFzmMMAGvAnz6thrUUGJLnGFG4+xV3NOjf+c4IhCnVvC+ZnRmaFN
 xqsoCaMWezXJ5TFpNghtIzGqsPEivYBK0R97v/3DAAb9yFlhZFpMk4cw7+etBCSTZIGJUtlMjA
 aB/U4TQ3dn5MWYqhMTFx7ltY8hev2SU8YcepC583FeGx/0qAa3lcbJLAlRyX7dWTusOwHrELLt
 fhEbQ+1c6PYfzWpAumR4KJKbaurm3TBc+qnaq7DWgEphR6AVWS+6s/0GsY2x/IQYMujRy5FS0L
 QFA=
X-IronPort-AV: E=Sophos;i="5.75,324,1589212800"; 
   d="scan'208";a="143180252"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 02:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PObZ6w8XMIccrE+zd7WDYmbkxISL2UPw3x8BXiUTJZ/CQSFym9y3cC6P4+en0OdCvSJebuvXy9N1XEKGunWp25b93w/0K3/jc8NwB/BMeytRIgKXXlE5IJofP4CoUxV8Qnq0yO/5HGTFXIMn+78okTIIJjGrSAZhPoYhPKO6AH+sC0mWS6dxX/qpB4k1ms5i29gK2LaZ9Ec51Lg0kt9FyGqdXTqOQlg1gHyGwfwiEMBH4WSMC97Pdg4v3uwPrZs7hYu9upX6qEywjvKh1n0Ve2rHSTQLJE6IzEgd8R3vToU7UttlZ8K1DpniEb23qLEhcJ1PFBTeH1YQ70/GBw/1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY4XCyePRDwshO92QndtNwTbWGL4RW9FlKFnVOaALbc=;
 b=SRh0kTnyC/yWFHiFmatD26EHd5u2MJK8R+jI9F8I63U47BpbLcvhOhDQpMGbX985kOHVugH0ACxZHi7lrmOUpH9imMrjbfFviQYcqrzfCSXVWDo0thfYYs39xi2R0VvMPwQk2k0qUC8pi9Kcl+PmSKWC4uRCWbicTXESG2HHFwIjMv+5+KvYYVHbUMbE5I7lWy6SbiORuwN3qPngCf62wH+UiQqzxUQ6xX7m5lqAIZt3rNEtRQMIrzwc5Rlsway0iT4+3tevhwldm0bbrj5YssZnECdiFLEz+wZjjc4F7lMBy6IptQyO6K/Tg2nCkiBYhcxaPRnIkjy1CWUEsrAtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY4XCyePRDwshO92QndtNwTbWGL4RW9FlKFnVOaALbc=;
 b=pOf2Jn3dGOH5geSe/UvRKe8XaoRDjFviA7Z8iMu2suhQDhxHC6IFEu/CTdJ4ToecWjHqK4Q+KLzBQyJamav/98h67dNnSB6TPlrNXAHXrIC6N4/3i6kx45fjBcvFb+ABI47XHttrcfjipizRM39a765AZi8HrtmpbP4kH43bWwY=
Received: from BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12)
 by BYAPR04MB4536.namprd04.prod.outlook.com (2603:10b6:a03:15::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Tue, 7 Jul
 2020 18:23:31 +0000
Received: from BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b]) by BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b%7]) with mapi id 15.20.3174.021; Tue, 7 Jul 2020
 18:23:31 +0000
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
Thread-Index: AQHWUIkRI5HubGFr/0O9cA9AIcqh/aj8EGmAgABHC2A=
Date:   Tue, 7 Jul 2020 18:23:30 +0000
Message-ID: <BY5PR04MB6995AD34A289A013932E1A698C660@BY5PR04MB6995.namprd04.prod.outlook.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <d262eba9-31d5-6205-3244-b5176a17637c@huawei.com>
In-Reply-To: <d262eba9-31d5-6205-3244-b5176a17637c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.109.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e271b691-25c0-4fde-8807-08d822a2da11
x-ms-traffictypediagnostic: BYAPR04MB4536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4536F1EC4585DA82C62F94748C660@BYAPR04MB4536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZmcUIvOgrf+/EOe73sV8OJ5Ru/Or2jZbayhVs7TfuRmQjnROLEJe21CQHjq+wlaGQ+ZnR7cbloeHOBPzsRQUa1ihbzrWBqwelIkq0r/omtcn8e0GAb6qIZ8KvXNsswI5udXLQfKaQ287pkUbaySSO59FF3AyaZ8c0Gk4oceDCY2sL16Oo+UCsGFEuMtdvMl41cUOx4csV0B78eBP3qH7dr7b4SKiUHnXIFH17riXrn6hsQMIa3CHLfDH80A9yx2y5syWCVeu79PvfzOUpOxPT1ap0OfFMkE5xZnK52x82Ak5ABJRXKp0Vj25jgEOz/0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6995.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(83380400001)(30864003)(26005)(64756008)(8676002)(55236004)(66476007)(53546011)(66446008)(33656002)(66556008)(7696005)(4326008)(76116006)(66946007)(6506007)(8936002)(316002)(110136005)(86362001)(478600001)(2906002)(186003)(5660300002)(55016002)(9686003)(54906003)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pp8NJnliHvIDb8Yp/O6SCRmssT3rrVV8ncxVWw0xn/nZilE4leF9yXncth0EKvprETZ9x10K4g2Y7cWhgS3VGJqToCaUIEIju+lGOEbbLkXiFmmxbR+jJupwsGMy2QGP32xrk3KiHk6apRGOKwDLy7cabiaEHz4FD5bZkO8L28cB3txD2eK5IswVKsXPUsPRAbNyNebVgQ56E1N79QkSGlbHQWwT0kOHW/XfgmxvpJdr4vCYpCk+aZuPw/WCywSIMEl5dJBByDfS1wNtNROc6bejH2GAVF90MdISfJldi+0cYMCKVLf/++S6BUl6P3Equ9FtgW7cM7SSDSsXuvs4jnn/BGApimcH5g95E8EJm3fx6gQxED9JASnHuinYL0EGsIwUGnge0WiUcoJUAmbzlEJFI1/zdCp0EZ79jZJbGpDP10logfoyg0nHD41gT8NO2IbLKNegI0kXS0I0T/6LO806HuQeoDbPU8fx7BSuTjZU9LqprwyHDsW7cLc7NmXQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6995.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e271b691-25c0-4fde-8807-08d822a2da11
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 18:23:30.9761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QF8fJm/lXVhWFik09eqWEBmlsQYI9iv8V6wpdCryjDY8xNrU4qNsnXXldkm+8GPi4QTp82UOoLf1vr914W+dQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4536
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for review Chao Yu.
Please find my response inline.
I will re-send a V2 after incorporating your comments.

Regards,
Aravind

> -----Original Message-----
> From: Chao Yu <yuchao0@huawei.com>
> Sent: Tuesday, July 7, 2020 5:49 PM
> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>; jaegeuk@kernel.org; linux-
> fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net; hch@lst.=
de
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
>=20
> On 2020/7/2 23:54, Aravind Ramesh wrote:
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
>=20
> If usable blocks count is zero, shouldn't we update SIT_I(sbi)->written_v=
alid_blocks
> as we did when there is partial usable block in current segment?
If usable_block_count is zero, then it is like a dead segment, all blocks i=
n the segment lie after the
zone-capacity in the zone. So there can never be a valid written content on=
 these segments, hence it is not updated.=20
In the other case, when a segment start before the zone-capacity and it end=
s beyond zone-capacity, then there are
some blocks before zone-capacity which can be used, so they are accounted f=
or.
>=20
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
>=20
> It needs to traverse .cur_valid_map bitmap to check whether blocks in ran=
ge of [0,
> usable_blks_in_seg] are all valid or not, if there is at least one usable=
 block in the
> range, segment should be dirty.
For the segments which start and end before zone-capacity are just like any=
 normal segments.
Segments which start after the zone-capacity are fully unusable and are mar=
ked as used in the free_seg_bitmap, so these segments are never used.
Segments which span across the zone-capacity have some unusable blocks. Eve=
n when blocks from these segments are allocated/deallocated the valid_block=
s counter is incremented/decremented, reflecting the current valid_blocks c=
ount.
Comparing valid_blocks count with usable_blocks count in the segment can in=
dicate if the segment is dirty or fully used.
Sorry, but could you please share why cur_valid_map needs to be traversed ?

>=20
> One question, if we select dirty segment which across zone-capacity as op=
ened
> segment (in curseg), how can we avoid allocating usable block beyong zone=
-capacity
> in such segment via .cur_valid_map?
For zoned devices, we have to allocate blocks sequentially, so it's always =
in LFS manner it is allocated.
The __has_curseg_space() checks for the usable blocks and stops allocating =
blocks after zone-capacity.
>=20
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
>=20
> Now, f2fs_kzalloc won't allocate vmalloc's memory, so it's safe to use kf=
ree().
Ok
>=20
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
>=20
> Missed to call kfree(FDEV(devi).zone_capacity_blocks)?
Thanks for catching it. Will free it here also.
>=20
> >
> > +	if (!rep_zone_arg.zone_cap_mismatch) {
> > +		kvfree(FDEV(devi).zone_capacity_blocks);
>=20
> Ditto, kfree().
Ok.
>=20
> Thanks,
>=20
> > +		FDEV(devi).zone_capacity_blocks =3D NULL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  #endif
> >
