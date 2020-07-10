Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD521BC84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGJRoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 13:44:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18597 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594403058; x=1625939058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v8LzXrPxt2s2EdaxYW+qqTqbAM2rYwMH9jLTymO5GHU=;
  b=rZM8TpLleI/phmbeTiOqYNAAmFvspO67uwHNYj0jPE/5IGbq4j3PJOcl
   GA3nR0SgFLU21e0QV9BNZrpRQ42R8m/7ftBL/6O0dPeB4YdEyrwJWBVMv
   yazcoGF8Hgip/yjRw8rvQ94VCOXhvHbciGfs6eXaiD8KpmrpimZR0xsxD
   L6xE6R85CGawWni/q0vdIikutFpLcHlCXGbBpTUkhBgatYoRWrj/4K/DB
   k+HFhnaPO8ntUrGEJJlssf2Cth5kwL05D7Z59Cc5NjTWUvJCuojqy0GaZ
   GpAXqC5hiCzozr73dmTOjYVQcAil4HuDy64l/lOBI9H33tr8znpRYcYNR
   g==;
IronPort-SDR: Z0KWrHU6QnJtTRfkkHg1dK3FxXa6/hF+HylgPW1YTY8ygyvQCCCk5bQYn/HXe5NtM6qGT0dzj3
 5/M5c0jwXo6ScSV0jtwcJE9v+VOLQmqBCyHunngw7swz1u6+k2i75CT+hI2cdFLCLdGlP0mrc8
 HC70i87bL4+ZiyA2zxt+Ob0vkGF5yIEFhzraNZAyOtYhUA2n1CoYdLf8SgTFStXTfJ3VDOsXLT
 6HgbcIaklR5uMEZIOit+qdQdTjjIicoLSGOwTvVFaAdhI8A2e5N16nrQeiLr7Mx/9dNLDQDQ3H
 af8=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="143472441"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2020 01:44:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHKCodNtIkvO/6xSMxshbd7pcgnyPrFhOpqzfK3ljp88P0iicO0+PSmlJVWyRZ9oRNBIL0jUjVimgmHZ3iTKnJgvyQ0n8WeCHjqQpIMzdlDnHtAr1bvZO92VGQAfvLS7V0o6crKZZggToH2oKZ3XKxEMoxcktW/Noa4+9eeniLkiyot+0fVciIw4wHKZsd2PQ2JBywG8pudisWd0XJJoEG8GxLotd/jvfcShGpxTPCasC0jY6sRtVX2VnE3gVAlssus+qVOC4WGHBbeKID17cvfmnv7JAC3/cyeRQYVssjMdyoCQskDxDD1PeDyG2XWl5UnSKVifWWWf8/iW8TRnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDmwX/3rJgD3orMthiasYsmRgaRGILFdu93+UZnvv60=;
 b=PzctdDDjmVaPbF5FaV2IedcR2XaFuftDt83ffYGo9WZ/njj6kgwbKzBqL5WZkHuWCG67Sc3rPXUCWkl8Yfh9tB2+4l+4uCohxn/sZEsm0kxL7j38xZCEdpSQ2xbTJhSVwTjQz6DoBMw3gT7af5HBDRwBu+YPSG6XpXdzM1psLVl5AMAA1bJA5++Fz6cVP9xXrT2VXqRcygnbpQztHTrhzxFa5Iu2t6VSwWOw3Fcmuv2hXZbGvFwlHSMMPfXVq2Rr20f5Ds7sYhnGfN4DDfYXh6Mv0yMnXeAKLFavyrc2FsL+pJNa3VSFlto0ZZk9TkkNrVj2DYZ47nHCFV3wr4k81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDmwX/3rJgD3orMthiasYsmRgaRGILFdu93+UZnvv60=;
 b=tpWX74q+G85cKgm7huhdqgYiSB2w2dIHZlcEzA5rKenHMDjJ75eFylWDbyPS8M0CHRNcwmdK0pGXZFyCPSP/rN9+mzve1aW8h5I/mxvnf+PTZsLYbFQ4Wdo5rf4RTTi3JzSLmj2+j0F94bCiZZSphg67xk05Gap1xZSkFvGNleE=
Received: from BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12)
 by BYAPR04MB4358.namprd04.prod.outlook.com (2603:10b6:a02:f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Fri, 10 Jul
 2020 17:44:15 +0000
Received: from BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b]) by BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 17:44:15 +0000
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
Thread-Index: AQHWUIkRI5HubGFr/0O9cA9AIcqh/aj8EGmAgABHC2CAAKfqgIAAq79QgADswQCAAAOEMIAAQhoAgAAA+FCAAhpY0A==
Date:   Fri, 10 Jul 2020 17:44:15 +0000
Message-ID: <BY5PR04MB6995519F7DE60699C18207718C650@BY5PR04MB6995.namprd04.prod.outlook.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <d262eba9-31d5-6205-3244-b5176a17637c@huawei.com>
 <BY5PR04MB6995AD34A289A013932E1A698C660@BY5PR04MB6995.namprd04.prod.outlook.com>
 <038b0276-d6b4-73b7-7844-8da6219976b3@huawei.com>
 <BY5PR04MB69956185F538985101390AB78C670@BY5PR04MB6995.namprd04.prod.outlook.com>
 <9b7dedd4-e9e9-e084-5ce0-372ac6bbac01@huawei.com>
 <BY5PR04MB69957B019C925E7AE7816AC88C640@BY5PR04MB6995.namprd04.prod.outlook.com>
 <0eda465e-5a79-9c06-3b86-30cb17592213@huawei.com>
 <BY5PR04MB69951C587EBF9C5E5015C4B18C640@BY5PR04MB6995.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB69951C587EBF9C5E5015C4B18C640@BY5PR04MB6995.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [49.207.57.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea3d9478-2c33-4ce1-3f66-08d824f8dd57
x-ms-traffictypediagnostic: BYAPR04MB4358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB43587E4B9414F3D4CB6FF0098C650@BYAPR04MB4358.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 046060344D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zk/466VyAZiLvqQWs0JZdo/kUDBZZ3jBQl0m1eMAqNgKXzVcxsYZ4Wb6b+O0NH+jaGrXzRBqpRvjlZwfUnxv0dsxM5VnrBwfgqLC8OOxPtgGri1AFyPpiMpnejQUbkjQCElZRGPN+14askuZ581IRvtvLVV2K/kLmcx5/ujI2l6qJRtokMyiQ0xH85ikL+c5exzOtau1wv85hNaFJKarsz2VOkJfqgf2tfWtzeoBKjIv7Oq+yTIRYQB40tQeP+TwiJjnDiI7zZRI99d0t+SGh+plmtxUsMV9lwmVvDlKRPNCBJa+h41+WJ5Kqsr7DELIZEqlKlcVYvy0dlcrrk58iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6995.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(66446008)(53546011)(6506007)(26005)(2906002)(64756008)(7696005)(66476007)(86362001)(8676002)(9686003)(55236004)(8936002)(55016002)(4326008)(83380400001)(54906003)(110136005)(316002)(66946007)(478600001)(76116006)(30864003)(5660300002)(71200400001)(33656002)(66556008)(52536014)(186003)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tlp3G2M7+z36Sp6NbSYigE3XgnPSnp4lQ/oMU3Ubd/+M/BVeKGN8pkUblgLozQ7E5qa3fz+Vgv7uyRxYy/gMv+wGW7bj+vlZxDbtZoaWfi296mI8JbJBnpNGVcuIsLgx48bgAa5YbrQVo4Jek8c0Fh6DcEnu8tOSq3sohzgZpQXny92yIF1G5CA4/uUtCrwk95/bBFJMER52iVxguwSESZjTSRi7eCm7ntUKZaimgrfr5S4LH5YErM9HkFa79M/Lc/oi5LGRbstPQQNqwlDbWvu+5bXDXRaOIO+gWCpRf8QaBinIDDLdEaLIO59hu3uXgoaPmOxVX9ZXAemaJNZXrUaLns4eckZAokTvuN6PrQRvfL813bFAfdTz2iHoLm1kaUu4/GPiZcX4DW+hIWIHVbDuajHuMtupGVBeg1D4ntgTK7uuI0LuqfSy6CdPjdqJIN9e5wkXUduna682L0BzHDpgbngGSRw94apVSH1tH5s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6995.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3d9478-2c33-4ce1-3f66-08d824f8dd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 17:44:15.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qTOkEyyb19PtPATBIWPFemejznQjFSwVj4xJcbkEnYuK82J2/vBoYSLw1YsQD/j/fEmJ8/pISblJSHKj4IoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4358
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Chao,

I have sent the second version of this patch, with below changes.
Have merged the 2 patches into one.=20
Updated commit message with nvme-cli output, as you suggested.
Updated check_block_count().
Updated f2fs.rst.
Changed kvfree() to kfree().
Please see inline, regarding one comment on kfree().

Please let me know your feedback.

Thanks,
Aravind

> -----Original Message-----
> From: Aravind Ramesh
> Sent: Thursday, July 9, 2020 12:41 PM
> To: Chao Yu <yuchao0@huawei.com>; jaegeuk@kernel.org; linux-
> fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net; hch@lst.=
de
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> Subject: RE: [PATCH 1/2] f2fs: support zone capacity less than zone size
>=20
> Comments inline.
>=20
> Thanks,
> Aravind
>=20
> > -----Original Message-----
> > From: Chao Yu <yuchao0@huawei.com>
> > Sent: Thursday, July 9, 2020 12:35 PM
> > To: Aravind Ramesh <Aravind.Ramesh@wdc.com>; jaegeuk@kernel.org;
> > linux- fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net; hch@lst.de
> > Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> > <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone
> > size
> >
> > On 2020/7/9 13:31, Aravind Ramesh wrote:
> > > Please find my response inline.
> > >
> > > Thanks,
> > > Aravind
> > >
> > >> -----Original Message-----
> > >> From: Chao Yu <yuchao0@huawei.com>
> > >> Sent: Thursday, July 9, 2020 8:26 AM
> > >> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>; jaegeuk@kernel.org;
> > >> linux- fsdevel@vger.kernel.org;
> > >> linux-f2fs-devel@lists.sourceforge.net; hch@lst.de
> > >> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> > >> <Niklas.Cassel@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> > >> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone
> > >> size
> > >>
> > >> On 2020/7/8 21:04, Aravind Ramesh wrote:
> > >>> Please find my response inline.
> > >>>
> > >>> Thanks,
> > >>> Aravind
> > > [snip..]
> > >>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> > >>>>>>> c35614d255e1..d2156f3f56a5 100644
> > >>>>>>> --- a/fs/f2fs/segment.c
> > >>>>>>> +++ b/fs/f2fs/segment.c
> > >>>>>>> @@ -4294,9 +4294,12 @@ static void init_free_segmap(struct
> > >>>>>>> f2fs_sb_info *sbi)  {
> > >>>>>>>  	unsigned int start;
> > >>>>>>>  	int type;
> > >>>>>>> +	struct seg_entry *sentry;
> > >>>>>>>
> > >>>>>>>  	for (start =3D 0; start < MAIN_SEGS(sbi); start++) {
> > >>>>>>> -		struct seg_entry *sentry =3D get_seg_entry(sbi, start);
> > >>>>>>> +		if (f2fs_usable_blks_in_seg(sbi, start) =3D=3D 0)
> > >>>>>>
> > >>>>>> If usable blocks count is zero, shouldn't we update
> > >>>>>> SIT_I(sbi)->written_valid_blocks as we did when there is
> > >>>>>> partial usable block in
> > >>>> current segment?
> > >>>>> If usable_block_count is zero, then it is like a dead segment,
> > >>>>> all blocks in the segment lie after the zone-capacity in the
> > >>>>> zone. So there can never be
> > >>>> a valid written content on these segments, hence it is not updated=
.
> > >>>>> In the other case, when a segment start before the zone-capacity
> > >>>>> and it ends beyond zone-capacity, then there are some blocks
> > >>>>> before zone-capacity
> > >>>> which can be used, so they are accounted for.
> > >>>>
> > >>>> I'm thinking that for limit_free_user_blocks() function, it
> > >>>> assumes all unwritten blocks as potential reclaimable blocks,
> > >>>> however segment after zone-capacity should never be used or
> > >>>> reclaimable, it looks calculation could
> > >> be not correct here.
> > >>>>
> > >>> The sbi->user_block_count is updated with the total usable_blocks
> > >>> in the full file system during the formatting of the file system
> > >>> using mkfs.f2fs. Please see the f2fs-tools patch series that I
> > >>> have submitted along with
> > >> this patch set.
> > >>>
> > >>> So sbi->user_block_count reflects the actual number of usable
> > >>> blocks (i.e. total
> > >> blocks - unusable blocks).
> > >>
> > >> Alright, will check both kernel and f2fs-tools change again later.
> > >> :)
> > >>
> > >>>
> > >>>> static inline block_t limit_free_user_blocks(struct f2fs_sb_info *=
sbi) {
> > >>>> 	block_t reclaimable_user_blocks =3D sbi->user_block_count -
> > >>>> 		written_block_count(sbi);
> > >>>> 	return (long)(reclaimable_user_blocks * LIMIT_FREE_BLOCK) / 100;
> > >>>> }
> > >>>>
> > >>>> static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *=
sbi) {
> > >>>> 	block_t invalid_user_blocks =3D sbi->user_block_count -
> > >>>> 					written_block_count(sbi);
> > >>>> 	/*
> > >>>> 	 * Background GC is triggered with the following conditions.
> > >>>> 	 * 1. There are a number of invalid blocks.
> > >>>> 	 * 2. There is not enough free space.
> > >>>> 	 */
> > >>>> 	if (invalid_user_blocks > limit_invalid_user_blocks(sbi) &&
> > >>>> 			free_user_blocks(sbi) < limit_free_user_blocks(sbi))
> > >>>>
> > >>>> -- In this condition, free_user_blocks() doesn't include segments
> > >>>> after zone-capacity, however limit_free_user_blocks() includes the=
m.
> > >>> In the second patch of this patch set, free_user_blocks is updated
> > >>> to account for
> > >> the segments after zone-capacity.
> > >>> It basically gets the free segment(segments before zone capacity
> > >>> and
> > >>> free) block count and deducts the overprovision segment block count=
.
> > >>> It also
> > >> considers the spanning segments block count into account.
> > >>
> > >> Okay.
> > >>
> > >>>
> > >>>
> > >>>>
> > >>>> 		return true;
> > >>>> 	return false;
> > >>>> }
> > >>>>
> > >>>>
> > >>>>>>
> > >>>>>>> +			continue;
> > >>>>>>> +		sentry =3D get_seg_entry(sbi, start);
> > >>>>>>>  		if (!sentry->valid_blocks)
> > >>>>>>>  			__set_free(sbi, start);
> > >>>>>>>  		else
> > >>>>>>> @@ -4316,7 +4319,7 @@ static void init_dirty_segmap(struct
> > >>>>>>> f2fs_sb_info
> > >>>> *sbi)
> > >>>>>>>  	struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> > >>>>>>>  	struct free_segmap_info *free_i =3D FREE_I(sbi);
> > >>>>>>>  	unsigned int segno =3D 0, offset =3D 0, secno;
> > >>>>>>> -	unsigned short valid_blocks;
> > >>>>>>> +	unsigned short valid_blocks, usable_blks_in_seg;
> > >>>>>>>  	unsigned short blks_per_sec =3D BLKS_PER_SEC(sbi);
> > >>>>>>>
> > >>>>>>>  	while (1) {
> > >>>>>>> @@ -4326,9 +4329,10 @@ static void init_dirty_segmap(struct
> > >>>>>>> f2fs_sb_info
> > >>>> *sbi)
> > >>>>>>>  			break;
> > >>>>>>>  		offset =3D segno + 1;
> > >>>>>>>  		valid_blocks =3D get_valid_blocks(sbi, segno, false);
> > >>>>>>> -		if (valid_blocks =3D=3D sbi->blocks_per_seg || !valid_blocks=
)
> > >>>>>>> +		usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, segno);
> > >>>>>>> +		if (valid_blocks =3D=3D usable_blks_in_seg || !valid_blocks)
> > >>>>>>
> > >>>>>> It needs to traverse .cur_valid_map bitmap to check whether
> > >>>>>> blocks in range of [0, usable_blks_in_seg] are all valid or
> > >>>>>> not, if there is at least one usable block in the range, segment=
 should be
> dirty.
> > >>>>> For the segments which start and end before zone-capacity are
> > >>>>> just like any
> > >>>> normal segments.
> > >>>>> Segments which start after the zone-capacity are fully unusable
> > >>>>> and are marked as
> > >>>> used in the free_seg_bitmap, so these segments are never used.
> > >>>>> Segments which span across the zone-capacity have some unusable
> > >>>>> blocks. Even
> > >>>> when blocks from these segments are allocated/deallocated the
> > >>>> valid_blocks counter is incremented/decremented, reflecting the
> > >>>> current
> > >> valid_blocks count.
> > >>>>> Comparing valid_blocks count with usable_blocks count in the
> > >>>>> segment can
> > >>>> indicate if the segment is dirty or fully used.
> > >>>>
> > >>>> I thought that if there is one valid block locates in range of
> > >>>> [usable_blks_in_seg, blks_per_seg] (after zone-capacity), the
> > >>>> condition will be incorrect. That should never happen, right?
> > >>> Yes, this will never happen. All blocks after zone-capacity are nev=
er usable.
> > >>>>
> > >>>> If so, how about adjusting check_block_count() to do sanity check
> > >>>> on bitmap locates after zone-capacity to make sure there is no fre=
e slots
> there.
> > >>>
> > >>> Ok, I will add this check in check_block_count. It makes sense.
> > >>>
> > >>>>
> > >>>>> Sorry, but could you please share why cur_valid_map needs to be
> > >>>>> traversed
> > ?
> > >>>>>
> > >>>>>>
> > >>>>>> One question, if we select dirty segment which across
> > >>>>>> zone-capacity as opened segment (in curseg), how can we avoid
> > >>>>>> allocating usable block beyong zone-capacity in such segment
> > >>>>>> via
> > .cur_valid_map?
> > >>>>> For zoned devices, we have to allocate blocks sequentially, so
> > >>>>> it's always in LFS
> > >>>> manner it is allocated.
> > >>>>> The __has_curseg_space() checks for the usable blocks and stops
> > >>>>> allocating blocks
> > >>>> after zone-capacity.
> > >>>>
> > >>>> Oh, that was implemented in patch 2, I haven't checked that
> > >>>> patch...sorry, however, IMO, patch should be made to apply
> > >>>> independently, what if do allocation only after applying patch
> > >>>> 1..., do we need to
> > >> merge them into one?
> > >>> The patches were split keeping in mind that all data structure
> > >>> related and initialization Changes would go into patch 1 and IO
> > >>> path and GC related
> > >> changes in patch 2.
> > >>> But if you think, merging them to a single patch will be easier to
> > >>> review,
> > >>
> > >> Yes, please, it's not only about easier review, but also for better
> > >> maintenance of patches in upstream, otherwise, it's not possible to
> > >> apply, backport, revert one of two patches independently.
> > >>
> > >> I still didn't get the full picture of using such zns device which
> > >> has configured zone- capacity, is it like?
> > >> 1. configure zone-capacity in zns device 2. mkfs.f2fs zns device 3.
> > >> mount zns device
> > >
> > > Zone-capacity is set by the device vendor. It could be same as
> > > zone-size or less than zone-size depending on vendor. It cannot be
> > > configured by
> > the user. So the step 1 is not possible.
> > > Since NVMe ZNS device zones are sequentially write only, we need
> > > another zoned device with Conventional zones or any normal block
> > > device for the
> > metadata operations of F2fs.
> > > I have provided some more explanation in the cover letter of the
> > > kernel patch set
> > on this.
> > > Step 2 is mkfs.f2fs zns device + block device (mkfs.f2fs -m -c
> > > /dev/nvme0n1 /dev/nullb1)
> > >
> > > A typical nvme-cli output of a zoned device shows zone start and
> > > capacity and
> > write pointer as below:
> > >
> > > SLBA: 0x0             WP: 0x0             Cap: 0x18800    State: EMPT=
Y        Type:
> > SEQWRITE_REQ   Attrs: 0x0
> > > SLBA: 0x20000    WP: 0x20000    Cap: 0x18800    State: EMPTY        T=
ype:
> > SEQWRITE_REQ   Attrs: 0x0
> > > SLBA: 0x40000    WP: 0x40000    Cap: 0x18800    State: EMPTY        T=
ype:
> > SEQWRITE_REQ   Attrs: 0x0
> > >
> > > Here zone size is 64MB, capacity is 49MB, WP is at zone start as the
> > > zone is empty. Here for each zone, only zone start + 49MB is usable
> > > area, any lba/sector after 49MB cannot be read or written to, the
> > > drive will fail any attempts to read/write. So, the second zone
> > > starts at 64MB and is
> > usable till 113MB (64 + 49) and the range between 113 and 128MB is
> > again unusable. The next zone starts at 128MB, and so on.
> >
> > Thanks for the detailed explanation, more clear now. :)
> >
> > Could you please add above description into commit message of your kern=
el
> patch?
> > And also please consider to add simple introduction of f2fs zns device
> > support into f2fs.rst for our user?
>=20
> Sure :).
> I will update f2fs.rst and patch commit message in V2.
> Thank you.
> >
> > Thanks,
> >
> > >
> > >>
> > >> Can we change zone-capacity dynamically after step 2? Or we should
> > >> run mkfs.f2fs again whenever update zone-capacity?
> > > User cannot change zone-capacity dynamically. It is device dependent.
> > >>
> > >> Thanks,
> > >>
> > >>> then I shall merge it and send it as one patch in V2, along with
> > >>> other suggestions
> > >> incorporated.
> > >>>
> > >>> Please let me know.
> > >>>>
> > >>>>>>
> > >>>>>>>  			continue;
> > >>>>>>> -		if (valid_blocks > sbi->blocks_per_seg) {
> > >>>>>>> +		if (valid_blocks > usable_blks_in_seg) {
> > >>>>>>>  			f2fs_bug_on(sbi, 1);
> > >>>>>>>  			continue;
> > >>>>>>>  		}
> > >>>>>>> @@ -4678,6 +4682,101 @@ int f2fs_check_write_pointer(struct
> > >>>>>>> f2fs_sb_info *sbi)
> > >>>>>>>
> > >>>>>>>  	return 0;
> > >>>>>>>  }
> > >>>>>>> +
> > >>>>>>> +static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned in=
t
> zone_idx,
> > >>>>>>> +						unsigned int dev_idx)
> > >>>>>>> +{
> > >>>>>>> +	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
> > >>>>>>> +		return true;
> > >>>>>>> +	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq); }
> > >>>>>>> +
> > >>>>>>> +/* Return the zone index in the given device */ static
> > >>>>>>> +unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned i=
nt secno,
> > >>>>>>> +					int dev_idx)
> > >>>>>>> +{
> > >>>>>>> +	block_t sec_start_blkaddr =3D START_BLOCK(sbi,
> > >>>>>>> +GET_SEG_FROM_SEC(sbi, secno));
> > >>>>>>> +
> > >>>>>>> +	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
> > >>>>>>> +						sbi->log_blocks_per_blkz;
> > }
> > >>>>>>> +
> > >>>>>>> +/*
> > >>>>>>> + * Return the usable segments in a section based on the
> > >>>>>>> +zone's
> > >>>>>>> + * corresponding zone capacity. Zone is equal to a section.
> > >>>>>>> + */
> > >>>>>>> +static inline unsigned int f2fs_usable_zone_segs_in_sec(
> > >>>>>>> +		struct f2fs_sb_info *sbi, unsigned int segno) {
> > >>>>>>> +	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
> > >>>>>>> +
> > >>>>>>> +	dev_idx =3D f2fs_target_device_index(sbi, START_BLOCK(sbi, se=
gno));
> > >>>>>>> +	zone_idx =3D get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno),
> > >>>>>>> +dev_idx);
> > >>>>>>> +
> > >>>>>>> +	/* Conventional zone's capacity is always equal to zone size =
*/
> > >>>>>>> +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > >>>>>>> +		return sbi->segs_per_sec;
> > >>>>>>> +
> > >>>>>>> +	/*
> > >>>>>>> +	 * If the zone_capacity_blocks array is NULL, then zone capac=
ity
> > >>>>>>> +	 * is equal to the zone size for all zones
> > >>>>>>> +	 */
> > >>>>>>> +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > >>>>>>> +		return sbi->segs_per_sec;
> > >>>>>>> +
> > >>>>>>> +	/* Get the segment count beyond zone capacity block */
> > >>>>>>> +	unusable_segs_in_sec =3D (sbi->blocks_per_blkz -
> > >>>>>>> +
> > >> 	FDEV(dev_idx).zone_capacity_blocks[zone_idx])
> > >>>>>>>>
> > >>>>>>> +				sbi->log_blocks_per_seg;
> > >>>>>>> +	return sbi->segs_per_sec - unusable_segs_in_sec; }
> > >>>>>>> +
> > >>>>>>> +/*
> > >>>>>>> + * Return the number of usable blocks in a segment. The
> > >>>>>>> +number of blocks
> > >>>>>>> + * returned is always equal to the number of blocks in a
> > >>>>>>> +segment for
> > >>>>>>> + * segments fully contained within a sequential zone capacity
> > >>>>>>> +or a
> > >>>>>>> + * conventional zone. For segments partially contained in a
> > >>>>>>> +sequential
> > >>>>>>> + * zone capacity, the number of usable blocks up to the zone
> > >>>>>>> +capacity
> > >>>>>>> + * is returned. 0 is returned in all other cases.
> > >>>>>>> + */
> > >>>>>>> +static inline unsigned int f2fs_usable_zone_blks_in_seg(
> > >>>>>>> +			struct f2fs_sb_info *sbi, unsigned int segno) {
> > >>>>>>> +	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> > >>>>>>> +	unsigned int zone_idx, dev_idx, secno;
> > >>>>>>> +
> > >>>>>>> +	secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > >>>>>>> +	seg_start =3D START_BLOCK(sbi, segno);
> > >>>>>>> +	dev_idx =3D f2fs_target_device_index(sbi, seg_start);
> > >>>>>>> +	zone_idx =3D get_zone_idx(sbi, secno, dev_idx);
> > >>>>>>> +
> > >>>>>>> +	/*
> > >>>>>>> +	 * Conventional zone's capacity is always equal to zone size,
> > >>>>>>> +	 * so, blocks per segment is unchanged.
> > >>>>>>> +	 */
> > >>>>>>> +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > >>>>>>> +		return sbi->blocks_per_seg;
> > >>>>>>> +
> > >>>>>>> +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > >>>>>>> +		return sbi->blocks_per_seg;
> > >>>>>>> +
> > >>>>>>> +	sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi,
> > >> secno));
> > >>>>>>> +	sec_cap_blkaddr =3D sec_start_blkaddr +
> > >>>>>>> +
> > >> 	FDEV(dev_idx).zone_capacity_blocks[zone_idx];
> > >>>>>>> +
> > >>>>>>> +	/*
> > >>>>>>> +	 * If segment starts before zone capacity and spans beyond
> > >>>>>>> +	 * zone capacity, then usable blocks are from seg start to
> > >>>>>>> +	 * zone capacity. If the segment starts after the zone capaci=
ty,
> > >>>>>>> +	 * then there are no usable blocks.
> > >>>>>>> +	 */
> > >>>>>>> +	if (seg_start >=3D sec_cap_blkaddr)
> > >>>>>>> +		return 0;
> > >>>>>>> +	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> > >>>>>>> +		return sec_cap_blkaddr - seg_start;
> > >>>>>>> +
> > >>>>>>> +	return sbi->blocks_per_seg;
> > >>>>>>> +}
> > >>>>>>>  #else
> > >>>>>>>  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
> > >>>>>>> { @@
> > >>>>>>> -4688,7 +4787,36 @@ int f2fs_check_write_pointer(struct
> > >>>>>>> f2fs_sb_info
> > >>>>>>> *sbi)  {
> > >>>>>>>  	return 0;
> > >>>>>>>  }
> > >>>>>>> +
> > >>>>>>> +static inline unsigned int
> > >>>>>>> +f2fs_usable_zone_blks_in_seg(struct
> > >>>>>>> +f2fs_sb_info
> > >>>> *sbi,
> > >>>>>>> +							unsigned int
> > >> segno)
> > >>>>>>> +{
> > >>>>>>> +	return 0;
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>> +static inline unsigned int
> > >>>>>>> +f2fs_usable_zone_segs_in_sec(struct
> > >>>>>>> +f2fs_sb_info
> > >>>> *sbi,
> > >>>>>>> +							unsigned int
> > >> segno)
> > >>>>>>> +{
> > >>>>>>> +	return 0;
> > >>>>>>> +}
> > >>>>>>>  #endif
> > >>>>>>> +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > >>>>>>> +					unsigned int segno)
> > >>>>>>> +{
> > >>>>>>> +	if (f2fs_sb_has_blkzoned(sbi))
> > >>>>>>> +		return f2fs_usable_zone_blks_in_seg(sbi, segno);
> > >>>>>>> +
> > >>>>>>> +	return sbi->blocks_per_seg;
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>> +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > >>>>>>> +					unsigned int segno)
> > >>>>>>> +{
> > >>>>>>> +	if (f2fs_sb_has_blkzoned(sbi))
> > >>>>>>> +		return f2fs_usable_zone_segs_in_sec(sbi, segno);
> > >>>>>>> +
> > >>>>>>> +	return sbi->segs_per_sec;
> > >>>>>>> +}
> > >>>>>>>
> > >>>>>>>  /*
> > >>>>>>>   * Update min, max modified time for cost-benefit GC
> > >>>>>>> algorithm diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > >>>>>>> index f261e3e6a69b..79b0dc33feaf 100644
> > >>>>>>> --- a/fs/f2fs/segment.h
> > >>>>>>> +++ b/fs/f2fs/segment.h
> > >>>>>>> @@ -411,6 +411,7 @@ static inline void __set_free(struct
> > >>>>>>> f2fs_sb_info *sbi,
> > >>>>>> unsigned int segno)
> > >>>>>>>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > >>>>>>>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > >>>>>>>  	unsigned int next;
> > >>>>>>> +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi,
> > >>>>>>> +segno);
> > >>>>>>>
> > >>>>>>>  	spin_lock(&free_i->segmap_lock);
> > >>>>>>>  	clear_bit(segno, free_i->free_segmap); @@ -418,7 +419,7 @@
> > >>>>>>> static inline void __set_free(struct f2fs_sb_info *sbi,
> > >>>>>>> unsigned int segno)
> > >>>>>>>
> > >>>>>>>  	next =3D find_next_bit(free_i->free_segmap,
> > >>>>>>>  			start_segno + sbi->segs_per_sec, start_segno);
> > >>>>>>> -	if (next >=3D start_segno + sbi->segs_per_sec) {
> > >>>>>>> +	if (next >=3D start_segno + usable_segs) {
> > >>>>>>>  		clear_bit(secno, free_i->free_secmap);
> > >>>>>>>  		free_i->free_sections++;
> > >>>>>>>  	}
> > >>>>>>> @@ -444,6 +445,7 @@ static inline void
> > >>>>>>> __set_test_and_free(struct f2fs_sb_info
> > >>>>>> *sbi,
> > >>>>>>>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > >>>>>>>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > >>>>>>>  	unsigned int next;
> > >>>>>>> +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi,
> > >>>>>>> +segno);
> > >>>>>>>
> > >>>>>>>  	spin_lock(&free_i->segmap_lock);
> > >>>>>>>  	if (test_and_clear_bit(segno, free_i->free_segmap)) { @@
> > >>>>>>> -453,7
> > >>>>>>> +455,7 @@ static inline void __set_test_and_free(struct
> > >>>>>>> +f2fs_sb_info *sbi,
> > >>>>>>>  			goto skip_free;
> > >>>>>>>  		next =3D find_next_bit(free_i->free_segmap,
> > >>>>>>>  				start_segno + sbi->segs_per_sec,
> > start_segno);
> > >>>>>>> -		if (next >=3D start_segno + sbi->segs_per_sec) {
> > >>>>>>> +		if (next >=3D start_segno + usable_segs) {
> > >>>>>>>  			if (test_and_clear_bit(secno, free_i-
> > >free_secmap))
> > >>>>>>>  				free_i->free_sections++;
> > >>>>>>>  		}
> > >>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> > >>>>>>> 80cb7cd358f8..2686b07ae7eb 100644
> > >>>>>>> --- a/fs/f2fs/super.c
> > >>>>>>> +++ b/fs/f2fs/super.c
> > >>>>>>> @@ -1164,6 +1164,7 @@ static void destroy_device_list(struct
> > >>>>>>> f2fs_sb_info
> > >>>> *sbi)
> > >>>>>>>  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);  #ifdef
> > >>>>>> CONFIG_BLK_DEV_ZONED
> > >>>>>>>  		kvfree(FDEV(i).blkz_seq);
> > >>>>>>> +		kvfree(FDEV(i).zone_capacity_blocks);
> > >>>>>>
> > >>>>>> Now, f2fs_kzalloc won't allocate vmalloc's memory, so it's safe
> > >>>>>> to use
> > kfree().
> > >>>>> Ok
> > >>>>>>
> > >>>>>>>  #endif
> > >>>>>>>  	}
> > >>>>>>>  	kvfree(sbi->devs);
> > >>>>>>> @@ -3039,13 +3040,26 @@ static int init_percpu_info(struct
> > >>>>>>> f2fs_sb_info *sbi)  }
> > >>>>>>>
> > >>>>>>>  #ifdef CONFIG_BLK_DEV_ZONED
> > >>>>>>> +
> > >>>>>>> +struct f2fs_report_zones_args {
> > >>>>>>> +	struct f2fs_dev_info *dev;
> > >>>>>>> +	bool zone_cap_mismatch;
> > >>>>>>> +};
> > >>>>>>> +
> > >>>>>>>  static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned=
 int idx,
> > >>>>>>> -			       void *data)
> > >>>>>>> +			      void *data)
> > >>>>>>>  {
> > >>>>>>> -	struct f2fs_dev_info *dev =3D data;
> > >>>>>>> +	struct f2fs_report_zones_args *rz_args =3D data;
> > >>>>>>> +
> > >>>>>>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > >>>>>>> +		return 0;
> > >>>>>>> +
> > >>>>>>> +	set_bit(idx, rz_args->dev->blkz_seq);
> > >>>>>>> +	rz_args->dev->zone_capacity_blocks[idx] =3D zone->capacity >>
> > >>>>>>> +
> > >> 	F2FS_LOG_SECTORS_PER_BLOCK;
> > >>>>>>> +	if (zone->len !=3D zone->capacity && !rz_args->zone_cap_misma=
tch)
> > >>>>>>> +		rz_args->zone_cap_mismatch =3D true;
> > >>>>>>>
> > >>>>>>> -	if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > >>>>>>> -		set_bit(idx, dev->blkz_seq);
> > >>>>>>>  	return 0;
> > >>>>>>>  }
> > >>>>>>>
> > >>>>>>> @@ -3053,6 +3067,7 @@ static int init_blkz_info(struct
> > >>>>>>> f2fs_sb_info *sbi, int devi)  {
> > >>>>>>>  	struct block_device *bdev =3D FDEV(devi).bdev;
> > >>>>>>>  	sector_t nr_sectors =3D bdev->bd_part->nr_sects;
> > >>>>>>> +	struct f2fs_report_zones_args rep_zone_arg;
> > >>>>>>>  	int ret;
> > >>>>>>>
> > >>>>>>>  	if (!f2fs_sb_has_blkzoned(sbi)) @@ -3078,12 +3093,26 @@
> > >>>>>>> static int init_blkz_info(struct f2fs_sb_info *sbi, int
> > >>>>>> devi)
> > >>>>>>>  	if (!FDEV(devi).blkz_seq)
> > >>>>>>>  		return -ENOMEM;
> > >>>>>>>
> > >>>>>>> -	/* Get block zones type */
> > >>>>>>> +	/* Get block zones type and zone-capacity */
> > >>>>>>> +	FDEV(devi).zone_capacity_blocks =3D f2fs_kzalloc(sbi,
> > >>>>>>> +					FDEV(devi).nr_blkz *
> > >> sizeof(block_t),
> > >>>>>>> +					GFP_KERNEL);
> > >>>>>>> +	if (!FDEV(devi).zone_capacity_blocks)
> > >>>>>>> +		return -ENOMEM;
> > >>>>>>> +
> > >>>>>>> +	rep_zone_arg.dev =3D &FDEV(devi);
> > >>>>>>> +	rep_zone_arg.zone_cap_mismatch =3D false;
> > >>>>>>> +
> > >>>>>>>  	ret =3D blkdev_report_zones(bdev, 0, BLK_ALL_ZONES,
> > f2fs_report_zone_cb,
> > >>>>>>> -				  &FDEV(devi));
> > >>>>>>> +				  &rep_zone_arg);
> > >>>>>>>  	if (ret < 0)
> > >>>>>>>  		return ret;
> > >>>>>>
> > >>>>>> Missed to call kfree(FDEV(devi).zone_capacity_blocks)?
> > >>>>> Thanks for catching it. Will free it here also.

This case is actually handled. If error is returned, the control goes to de=
stroy_device_list()
and does a kfree() on it, so it's not needed here.=20

> > >>>>>>
> > >>>>>>>
> > >>>>>>> +	if (!rep_zone_arg.zone_cap_mismatch) {
> > >>>>>>> +		kvfree(FDEV(devi).zone_capacity_blocks);
> > >>>>>>
> > >>>>>> Ditto, kfree().
> > >>>>> Ok.
> > >>>>>>
> > >>>>>> Thanks,
> > >>>>>>
> > >>>>>>> +		FDEV(devi).zone_capacity_blocks =3D NULL;
> > >>>>>>> +	}
> > >>>>>>> +
> > >>>>>>>  	return 0;
> > >>>>>>>  }
> > >>>>>>>  #endif
> > >>>>>>>
> > >>>>> .
> > >>>>>
> > >>> .
> > >>>
> > > .
> > >
