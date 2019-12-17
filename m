Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8652C121F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLQAUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:20:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35179 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfLQAUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576542010; x=1608078010;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CglR53AJjw97zWHjLxXhhNbD+ff1664RlYk323EtHM8=;
  b=nMNfACQtfXrzbZ9NU29yj+dit1LqrKTbe8ysi5XfV+SH0TPSO9RTGV3T
   beIfIFWV+zwab9dHeNs3py+nmempHNs0b8dreH9ohRwgiEQFgrx0EklY1
   F0zlDIn1aIiVaChJFYUELIBf/OXFyTD1Qb8Po8B2yxuPTfcpPyScUOKzn
   pu63KiddxsMecrPrwQtHvelDv/9TOKSqGMiSe53mVDPrqWDYg2s0q6Q5x
   H/wRsS6/x8YR6P6a4OWsdCT0Fy0UhvVlVO0cHUgx5fKESdHjinfydZXm5
   PqeTZ6ShxvUjZw70sDd1+FQcUTKzFoj/yyxKv5bKmHM1Jrxj7c0783vWX
   g==;
IronPort-SDR: CzKUQwm/OuKzuGHuZjT2XWbw+P47xXntEfdQwsSuQOCjaCUGCRhuI7ZwhHYDtdRsiPDJBteZX8
 tJ7PXcJwVNh82s4+bwybHQGuqDYq8dh/SD1kNJefh9EdN84iABZLtNzVpGXZM2LiZB/+YTbw7M
 5s+d7xJU2bjdmdLgH8+0/su/JfazdGDMQqQWw/LenH6rO30uF7bomCGfUkyLf1AjEWirFO3YzZ
 aynSSgr2xiJIkBQo3llsKY1Xv1Gd5f9Xa8+XFHNGO6N0XB4vFE4+DWZXZ/jzJ579ST9hEXavLF
 Yy4=
X-IronPort-AV: E=Sophos;i="5.69,323,1571673600"; 
   d="scan'208";a="125486370"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 08:20:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/xQuHQ7eraytt2fB6sKMykyI2h7HDkOVfSnB/JHAkPD+vcMC245amggiDdSsBCoE8jY8x3KXjTde5tljJ6nIy7rx/QM6GRrdmfeBHjvPZfM5t+VwC+3or2S6E9K+MCfVBrNXkcQyuZXpiMQ1Jl9h1hNXJZoWLrtJjo6LC4HVAExHx+DKmRjHJNujQP+jaWE3ZLm3kt/8dAoueLiyOWr/qDvA2Ifam0v10awm37lQ1NQeq3gDncpz6Yop5whLkYPmFx6A+sGg6RsnT1gpJlfzHc9ZiZ0EedpmEjli++pEedPHWoarvb1+cGnt86Rm9LOqDF232NSsWeAYojiuRWYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyVjP70TC9CKz680hAy9ZKK2us3a2t54jvKJGtGwhtg=;
 b=IlucVh3NRCbAiKbPhkzzcY44RZpRr2MqlE9NYIIg8ud8XOhEhhJt+y++aoKlz0+VSoNmOTk9jEaKxYwL3wwm+h06CszPvNeKrMGJC3qUvl/4n+WarSCqZu7l/VhLZ/6OOqfkhiqT8WKnlzwiqsqEF2fu5N6thnvDIRNnBDFzxUAyg7+zWB67joOc9OZIEK4kB/NJsHprEJi3ad9FvWYdrgfYMODLBzX/B6gzM0vmeTu1/f6/ohqNWeZ0A46cPUy8AYvrZouSOMIEGgM1k0tSh51lds4HZ6V1IVakDWcj0o5RF9kyNHir/y6OVq5ok9A7jV9YPlzCF+7JeS4ztTui7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyVjP70TC9CKz680hAy9ZKK2us3a2t54jvKJGtGwhtg=;
 b=vdkScfI3Ab2PjJ/rf5QIKX00uS9TcdZuXAxy0rtYVJEBoYwFay3CP/wwNig0qFNm+usEJWwOzAA9C7VeQKlfTfSWLkNNj48AHt1ASKtyZ1Tn9hontbU88gYVCy8XEUmcADQXcvd3wq4oVwEljDyP3UJ2z1R5TcVkob7wGmThmzc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5462.namprd04.prod.outlook.com (20.178.48.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 00:20:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 00:20:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 1/2] fs: New zonefs file system
Thread-Topic: [PATCH 1/2] fs: New zonefs file system
Thread-Index: AQHVsRtc4OoccT74tkyETJa3Ywntvw==
Date:   Tue, 17 Dec 2019 00:20:07 +0000
Message-ID: <BYAPR04MB5816D17D0A14D5651E37F700E7500@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <20191212183816.102402-2-damien.lemoal@wdc.com>
 <c7f17b54-8f90-3dd3-98f7-cf540d70333d@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5707b9e6-ac58-42dd-3960-08d78286df3b
x-ms-traffictypediagnostic: BYAPR04MB5462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5462CDC9A265E8AD4F75716DE7500@BYAPR04MB5462.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(66946007)(33656002)(76116006)(91956017)(66476007)(64756008)(86362001)(66446008)(186003)(54906003)(5660300002)(26005)(66556008)(71200400001)(316002)(110136005)(2906002)(81166006)(81156014)(8676002)(4326008)(478600001)(9686003)(55016002)(6506007)(53546011)(52536014)(7696005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5462;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kauSOUlE7AyDyhsshnTOsf25yqnUsbbcBGZaiFtxSHc9HiY2rjAO7yq1Or0GT9la/fG4BqkOHQJD7JvC9LXb6rRVwCEN0v8GSSj6yreM7NA0DxXdQiMG5rhcF5+IxpSxaZTcctokD8ZxX3O+UUXPrvdZqF0UO7u0Ag6OChZlRnSkWlrdjVYaR2hs6CTogktLO4duFHC9iGi/ltSpGCPd+8EUG3dOX5MpE1zWUSxOVJcltpjD4xZNyfFt3n0NiSHSu67OBB3SMZ/+IIw8bgh8WIa8AcfXTFS05BbKByd50tEFcs91qxo9u/nwU3GVap2osF2F8luHmjb5DROADNSg1vxsbzGxTyIYUwVvAP2Nrrbt1ZUX2WlkP/3t7STiaVbDScQllwUMmUvJqlzpi6161uWllxO3ICFhV3yTf2ReoBprinaFsYdGg0558cfu+eoj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707b9e6-ac58-42dd-3960-08d78286df3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 00:20:07.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnaoDn0D44eMeP+6SzQnB/XWUa8UvJvlYLIvIUFLX8rRIKewQ4utxD/mQ7WnWUQQk0lK7Ay2wcn5VBDaAW4VRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5462
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/16 17:36, Hannes Reinecke wrote:=0A=
[...]=0A=
>> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_=
t length,=0A=
>> +			      unsigned int flags, struct iomap *iomap,=0A=
>> +			      struct iomap *srcmap)=0A=
>> +{=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	loff_t max_isize =3D zi->i_max_size;=0A=
>> +	loff_t isize;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For sequential zones, enforce direct IO writes. This is already=0A=
>> +	 * checked when writes are issued, so warn about this here if we=0A=
>> +	 * get buffered write to a sequential file inode.=0A=
>> +	 */=0A=
>> +	if (WARN_ON_ONCE(zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>> +			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))=0A=
>> +		return -EIO;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For all zones, all blocks are always mapped. For sequential zones,=
=0A=
>> +	 * all blocks after the write pointer (inode size) are always unwritte=
n.=0A=
>> +	 */=0A=
>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>> +	isize =3D i_size_read(inode);=0A=
>> +	if (offset >=3D isize) {=0A=
>> +		length =3D min(length, max_isize - offset);=0A=
>> +		if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>> +			iomap->type =3D IOMAP_MAPPED;=0A=
>> +		else=0A=
>> +			iomap->type =3D IOMAP_UNWRITTEN;=0A=
>> +	} else {=0A=
>> +		length =3D min(length, isize - offset);=0A=
>> +		iomap->type =3D IOMAP_MAPPED;=0A=
>> +	}=0A=
>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	iomap->offset =3D offset & (~sbi->s_blocksize_mask);=0A=
>> +	iomap->length =3D ((offset + length + sbi->s_blocksize_mask) &=0A=
>> +			 (~sbi->s_blocksize_mask)) - iomap->offset;=0A=
>> +	iomap->bdev =3D inode->i_sb->s_bdev;=0A=
>> +	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct iomap_ops zonefs_iomap_ops =3D {=0A=
>> +	.iomap_begin	=3D zonefs_iomap_begin,=0A=
>> +};=0A=
>> +=0A=
> This probably shows my complete ignorance, but what is the effect on =0A=
> enforcing the direct I/O writes on the pagecache?=0A=
> IE what happens for buffered reads? Will the pages be invalidated when a =
=0A=
> write has been issued?=0A=
=0A=
Yes, a direct write issued to a file range that has cached pages result=0A=
in these pages to be invalidated. But note that in the case of zonefs,=0A=
this can happen only in the case of conventional zones. For sequential=0A=
zones, this does not happen: reads can be buffered and cache pages but=0A=
only for pages below the write pointer. And writes can only be issued at=0A=
the write pointer. So there is never any possible overlap between=0A=
buffered reads and direct writes.=0A=
=0A=
> Or do we simply rely on upper layers to ensure no concurrent buffered =0A=
> and direct I/O is being made?=0A=
=0A=
Nope. VFS, or the file system specific implementation, takes care of=0A=
that. See generic_file_direct_write() and its call to=0A=
invalidate_inode_pages2_range().=0A=
=0A=
> =0A=
> [ .. ]=0A=
>> +=0A=
>> +static int zonefs_seq_file_truncate(struct inode *inode, loff_t isize)=
=0A=
>> +{=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	loff_t old_isize;=0A=
>> +	enum req_opf op;=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For sequential zone files, we can only allow truncating to 0 size,=
=0A=
>> +	 * which is equivalent to a zone reset, or to the maximum file size,=
=0A=
>> +	 * which is equivalent toa zone finish.=0A=
> =0A=
> Spelling: to a=0A=
=0A=
Good catch. Will fix it. Thanks.=0A=
=0A=
> =0A=
> [ .. ]=0A=
> =0A=
> Other than that:=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
