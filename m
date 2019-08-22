Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38A398914
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfHVBrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 21:47:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26298 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfHVBrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566438461; x=1597974461;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PetDagC4mSDpfyzLmshFDsRB/x3yTzLnl7RdjWlI5pA=;
  b=S0pEsnaNDZcNZbVIzoLhh2uPN+99AKZh5i/BLMqkOZlXnwRzx2ZhMPtS
   GuSTUf9RKhnxjXVUNgGQ/rPRwBI0uvwYXT3E5JsWTm+YWxvIbmP6cO4Fx
   F//MuanoyD3llBzAc+MfAHSA+V7yWpko5ksWCpEJgcxhqfZXTCBZDrJG0
   oyj+UnO+MbvtiHQvi0gdJivssuhQ+SeMj0ckVG4xwBr9AsW8wYFGBEpPy
   6O2Maz8PiFdH4oyNW27fNE+Ve2kFm8X8UMIkBhzlDueroYAvq0htj1Ak/
   SRP5hSmUUzc1X8CiUOCgLIO19iQ2rW3PVvu+UKF/wdQWU7GIWUu5owf48
   g==;
IronPort-SDR: eEOeZziwKlsm6vxsyby5DdyjtAwJVBUqOMxHoQlHk9inP+wcuBSr5OVTpBdiQ82bypz8RBCK7u
 dAklKMLSapHe8wkIJ17BmdqO7WYJ/yUGdlQKvEen+XpPzTomzggJDqDZTD1KCOKD01tWRdafN6
 tfuVBpM3bAYh0XuubcYhWuLi/sKkcZQCcIFPTNWOIYImTnCaGw2LHiO2Uud4mckRbtfKA9eStZ
 tHIrWaDAuCNfq5o1ygNpLz13DGUBLuBxIvCpBL4U8L5jFCQhA45KX2W8HDryGEadILPv7hw5AO
 gGE=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="117310973"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 09:47:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmPJvivVHFXbYXGhPp1o2DJsYUEBxTt+D7TyHSjWUN8d2KO5hlFlcQTpphAZR5N6x+Klha/vpneTrjOV0uqlSjTq6XClOFXMperkEYdu0P6x4ZoYn0ooEbwDT5pvismtuRv93cTwT7MpvUN3iVh3tJBpkFyVlCxYRX9IC3zM/SQ2JsElwlmNtGitlj5Onc3ral4wg2PpjPHQUjidllpbUhlPRseS9WnF0cGubjl9FpBBCQQJRp8i7PtYCm2bVcLcucvBrAiUcRy96dtWlRHryiPQQfihTci+VR8F6CT7AOVtf5Hnn+mN4ue56MbdN/m0RzmnuKM3bKPJy7DQkHGZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfbbuHnMNWopDSgXBss9Kag//HIfTeMUbMB92l5EtM=;
 b=KSghGwVUldT7zph0xGL4NbSgcUZGAAaJZf7siAlE6w1eRNcOqlI9EvLdOI0nJcIC1Gn42bhDxy60FoYLd2dJeh+KuGnO2HXMYe38xlNtTqe0v8eukfKKM0TO2csv4WZ0xdcaE1Ryzp7+MTHLyd0tQJ/BO2417hWvX3MW1RJOWrbQCqtXofnwKos2bluhWjR/4CLltVQCSk3WtldloD17T5lQM5zt5Q4Es2Wxlz3FveqjHopY5sRLbkmQ6DcBtBKKwlw7GtvSYKwDE+45+NYpVs5W9Xzb7+PRtcJtP7gSWnTnd5Q7C7uvjjJhgdZiRvlsHiQjL05VgFUEW9QpiB0aFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfbbuHnMNWopDSgXBss9Kag//HIfTeMUbMB92l5EtM=;
 b=b2SlEQO88+S0jKY4OLG91JvXhwzaTuUTyCBSoZsc5Cm7E3P2Bcwa2D9S7mr5a7sVplijV+7WXs1v4YIJVqCxXg5qVQURofI25S/iQygg9xvkUsv+16tiX59PqsFnuV6DseI6Qn1ofTEh486W/7AoLesx+zOmR1qCzuLTv2PIjrs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4903.namprd04.prod.outlook.com (52.135.232.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 01:47:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 01:47:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V3] fs: New zonefs file system
Thread-Topic: [PATCH V3] fs: New zonefs file system
Thread-Index: AQHVV+6BGBTM4G0GmU+CLBAUhcNmkA==
Date:   Thu, 22 Aug 2019 01:47:37 +0000
Message-ID: <BYAPR04MB5816B366B2AC1D5F8FA81F61E7A50@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190821070308.28665-1-damien.lemoal@wdc.com>
 <20190821145854.GE1037350@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7539e4f3-f96c-4096-158d-08d726a2b5d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4903;
x-ms-traffictypediagnostic: BYAPR04MB4903:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB490350B301B53FEB016F4D7AE7A50@BYAPR04MB4903.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(54906003)(76176011)(86362001)(9686003)(6306002)(55016002)(4326008)(966005)(186003)(26005)(66066001)(71200400001)(8936002)(6436002)(6246003)(33656002)(7696005)(5660300002)(102836004)(6506007)(446003)(478600001)(52536014)(6116002)(14454004)(3846002)(71190400001)(486006)(81166006)(81156014)(316002)(305945005)(2906002)(74316002)(53546011)(7736002)(53936002)(476003)(99286004)(6916009)(229853002)(76116006)(66446008)(256004)(14444005)(91956017)(66946007)(8676002)(66476007)(66556008)(25786009)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4903;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y0/nVTshkxMmGBf1tly/++JGTIr7vmxYWU8VOOG5b1+ytOu2Mg8AjHX8JdnJRarkziWNIr1Kt7I4PA2k/M/umlKnuVYt9tRPDaXDavZFiUkSx1FGBiElZFbaQ3ixjHBAWtBE7divxoHKcLBgrWiLnf5JcTBdIOW82zA1QYDlnkIwI88YPLS6kj3+Yos8b2Puv5wHoT53SJ1mr7uTac20QnctOL3nSQjFuMbDNaXZwHn7ZdLw7674OFzeYVGqnfd1qqmK3n3l+yAWTHQoviLC5/AP9apxNtS5CAHPI1ogVVyCvSURs7xteOBduak9l+RFcdVy9khryNWvMllOm4kWgY0upa0j7h1eFs7KrxZiljLJXcL0j6md4yhPJo8OCzNKgQCbApAweHgkWO9s0JJncVlbllXgnpXb5HKg4wjAqz4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7539e4f3-f96c-4096-158d-08d726a2b5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 01:47:37.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ/5y+F/ndOcpbl8qW1EhmOkZSSlCVcLynQ3QPi0YBpj3xTeVPB0sTrldMATmwlMDHq6ccUsyUzki+Ox+TgaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4903
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/21 23:59, Darrick J. Wong wrote:=0A=
> On Wed, Aug 21, 2019 at 04:03:08PM +0900, Damien Le Moal wrote:=0A=
>> zonefs is a very simple file system exposing each zone of a zoned=0A=
>> block device as a file. zonefs is in fact closer to a raw block device=
=0A=
>> access interface than to a full feature POSIX file system.=0A=
> =0A=
> <skipping to the good part>=0A=
> =0A=
>> +/*=0A=
>> + * Read super block information from the device.=0A=
>> + */=0A=
>> +static int zonefs_read_super(struct super_block *sb)=0A=
>> +{=0A=
>> +	const void *zero_page =3D (const void *) __va(page_to_phys(ZERO_PAGE(0=
)));=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct zonefs_super *super;=0A=
>> +	struct bio bio;=0A=
>> +	struct bio_vec bio_vec;=0A=
>> +	struct page *page;=0A=
>> +	u32 crc, stored_crc;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	page =3D alloc_page(GFP_KERNEL);=0A=
>> +	if (!page)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	bio_init(&bio, &bio_vec, 1);=0A=
>> +	bio.bi_iter.bi_sector =3D 0;=0A=
>> +	bio_set_dev(&bio, sb->s_bdev);=0A=
>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>> +	bio_add_page(&bio, page, PAGE_SIZE, 0);=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(&bio);=0A=
>> +	if (ret)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	super =3D page_address(page);=0A=
>> +=0A=
>> +	stored_crc =3D super->s_crc;=0A=
>> +	super->s_crc =3D 0;=0A=
>> +	crc =3D crc32_le(ZONEFS_MAGIC, (unsigned char *)super,=0A=
>> +		       sizeof(struct zonefs_super));=0A=
>> +	if (crc !=3D stored_crc) {=0A=
>> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",=0A=
>> +			   crc, stored_crc);=0A=
>> +		ret =3D -EIO;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D -EINVAL;=0A=
>> +	if (le32_to_cpu(super->s_magic) !=3D ZONEFS_MAGIC)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	sbi->s_features =3D le64_to_cpu(super->s_features);=0A=
>> +	if (sbi->s_features & ~((1ULL << ZONEFS_F_NUM) - 1)) {=0A=
> =0A=
> Most other filesystems would do:=0A=
> =0A=
> #define ZONEFS_F_ALL_FEATURES (ZONEFS_F_UID | ZONEFS_F_GID ...)=0A=
> =0A=
> and then this becomes:=0A=
> =0A=
> if (sbi->s_features & ~ZONEFS_F_ALL_FEATURES)=0A=
=0A=
OK. Will do that.=0A=
=0A=
>> +		zonefs_err(sb, "Unknown features set\n");=0A=
> =0A=
> Also it might help to print out the invalid s_features values so that=0A=
> when you get help questions you can distinguish between a corrupted=0A=
> superblock and a new fs on an old kernel.=0A=
=0A=
Good point. Will add that.=0A=
=0A=
> =0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +=0A=
>> +	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {=0A=
>> +		sbi->s_uid =3D make_kuid(current_user_ns(),=0A=
>> +				       le32_to_cpu(super->s_uid));=0A=
>> +		if (!uid_valid(sbi->s_uid)) {=0A=
>> +			zonefs_err(sb, "Invalid UID feature\n");=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +	}=0A=
>> +	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {=0A=
>> +		sbi->s_gid =3D make_kgid(current_user_ns(),=0A=
>> +				       le32_to_cpu(super->s_gid));=0A=
>> +		if (!gid_valid(sbi->s_gid)) {=0A=
>> +			zonefs_err(sb, "Invalid GID feature\n");=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))=0A=
>> +		sbi->s_perm =3D le32_to_cpu(super->s_perm);=0A=
>> +=0A=
>> +	if (memcmp(super->s_reserved, zero_page, sizeof(super->s_reserved))) {=
=0A=
> =0A=
> Er... memchr_inv?=0A=
=0A=
Ah. Yes. Good idea. That will avoid the need for using zero page.=0A=
=0A=
> =0A=
> Otherwise looks reasonable enough.  How do you test zonedfs?=0A=
=0A=
I created a small test suite that I put together with zonefs-tools in the g=
ithub=0A=
repo (see https://github.com/damien-lemoal/zonefs-tools). The tests run aga=
inst=0A=
real devices, DM devices (dm-linear chunks of a larger device) and null_blk=
=0A=
devices with memory backing and zoned mode enabled (there is a script for=
=0A=
running against this one automatically).=0A=
=0A=
This test suite is still small-ish but improving. For now, I have tests for=
=0A=
checking number of files created and their attributes, truncate and unlink,=
 and=0A=
IO paths (read and write, sync and async) using dd and fio. I need to add s=
ome=0A=
more test cases for mmap at least (tested "manually" for now). I will event=
ually=0A=
need to go through xfstests to see what generic test cases can apply. Not m=
any I=0A=
guess given the limited features of zonefs. Will see.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
