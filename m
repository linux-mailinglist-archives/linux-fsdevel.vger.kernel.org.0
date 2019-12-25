Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20F812A5AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLYC6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:58:04 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63781 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfLYC6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577242683; x=1608778683;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WoUuBhU5ULlBMW9zHLB3qXbdkKByyhkjVBpOop6CL2M=;
  b=jSgsCu3YX0wE1eSjvSIg9JAlY4K+4mk69VrtlIif4fLFYSfPv43lC9xz
   8YmgwY2H1MSjKKmSEXRV49f1hQY1Z80KfoC4NJFkwhEfR8Q1hSXYH89or
   R0s3Pehk6pfjVh26pk33Aqu4c1WQMpsfjXxPCxOsW9si7twP7vYWaIvHp
   qXcbbo+NBdyYgxn4kBr5Wjd7cEHLTLlv/eLhakzv0E35lntgy9tgLYwTR
   9QEPoMT7z9gfu7zT4c/XKc+kOGanqj4vK0E2Vxdp6KKDS0CUhAacgs1oD
   a0xBrAcwXtEMcUvPXQ8yc6Ed8TV9ZHRwmGBm+HKXNW7XH5n36DRCLV6HO
   Q==;
IronPort-SDR: vxgYlB2tgoQTM5JnhlQFnKEJaHQO37kpR+yrOuXpxCYZu7tFuNGeHjMEdTJEvRVuqSW39W9tyn
 rBktirRTtupUna28KERG12VLX75/tjHbKqoYfDzoWc5bCpcSJGiPDL2Tymq/mASZF6+LNRKjrT
 65NCjIIsdreXOlaUHA+CJFqOiNrbSdy0VXKQI4/seQbsrMwH4oRQyj++qJMLgBynwIOIVSfa6U
 KvCo3ldVrEVARpDyws2zgRWSazu0Yax3pRffdtXwU89l7apYnCn9IoJWZiA/a8OEFbjICmALm9
 Jg0=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="127687701"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 10:58:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUwpYBnBOZHIaaIz2YvcRJ+pvQDQEOEDn58DArAmhCW8i4CAPu7Z32gSJmIuktwDZcZsO98VtEAxVfFOynxR1lXUsPQGk2H5ZJtA7AMa6/y/O7nWdIfsg4zVDYIcq6A5zhQqFJ7h1gm5iMh/c31wb4GnYYhPYncZV57G6B8lBGvwIR4wwly8hKcGYRJbqKcHnp2wcrxkO7HSFMX6361XN3+z/HMF64xhqQXetAsMIlkVS8fODQ5evLj6woNqTxyiCQUUXT/OJdblTK/r+DRtgs/7e4qz61rW3jVcKEQ7L1Xk3mjYjzQvPZiCvDoKG67wXPsbFK5VwGOQapLRJSDEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyrK8YIuHomjoe9LPr85brdCa0UgTx3zfSmZLDNNtYQ=;
 b=MPVdNY/eYsSDyT0bwePMiRUaNn4z9y2KHFAiJWxDAdyY/9t9ZCOm5qMOL6ZDWo90zjyquiGsE7jeTaNiG3IA1zuP+8Ef0E8RLbC7RA2N5hY5IZv4T2GiODw+Ox0/NYO1FSKKQl1cSvU1sr7rYTWShqK6Jhf8OOnJFSErG5vUCiNerhq2+nkMZDshRc6vcAr5TA8xMRIZ6KGma2j0QLoNaWNUDwHtHewIcM/f9YXqcuZuyAQ5sUKSA1dwcifho5twv+lNRKL8+7dik+DfCyHkBhM7ttWBZAowMfhcikzLajQ7sfgDhE8O2rgEF0EpyVxKXAbLECMhcK7D5tna4lSEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyrK8YIuHomjoe9LPr85brdCa0UgTx3zfSmZLDNNtYQ=;
 b=ZqX3nrfnxbpAA63AHnOgvKHAlQO1v2JTB8tBWnuheYhmQobemmCFY737fPEjIUP3mHxDs06RUZnTt6DB7vEmqvuUuh3QogyBi36HD63hsih+gesNS8hkL/iRsGlIjGdZTFNPCERze6SitgpaK+PoiKRhXJHavxYjaBLWi4AYmiY=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5489.namprd04.prod.outlook.com (20.178.215.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 25 Dec 2019 02:57:59 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::b89f:12e0:be8a:8ecf]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::b89f:12e0:be8a:8ecf%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 02:57:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/2] zonefs: Add documentation
Thread-Topic: [PATCH v3 2/2] zonefs: Add documentation
Thread-Index: AQHVuf7Aj/1RgKnKOE6js//cNKXmzQ==
Date:   Wed, 25 Dec 2019 02:57:58 +0000
Message-ID: <BN8PR04MB5812F5201C29A24CAB8C093DE7280@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-3-damien.lemoal@wdc.com>
 <ac1bd604-0088-2002-f03b-5752425bb530@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c90dbc9-3be7-4ef5-3b38-08d788e63fe1
x-ms-traffictypediagnostic: BN8PR04MB5489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB548958E6514D57B3978BA901E7280@BN8PR04MB5489.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(55016002)(4326008)(81166006)(2906002)(8936002)(478600001)(81156014)(9686003)(7696005)(6506007)(66476007)(66946007)(66556008)(64756008)(91956017)(5660300002)(33656002)(71200400001)(76116006)(110136005)(86362001)(186003)(53546011)(316002)(26005)(66446008)(52536014)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5489;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpFNzPgVmTbi1WfBySajkTnNRVeX68C+EZO1C6MGxMmG1aWK9oAiEh/nnJy2ecJJPc6TgJA5olZ+UEKd40B0OrQg9tfGBFlsxfSwmBfGLaoXRW5Z0mY1pLtdJULm3pG33EDBjvPP8DIoulRV7mgCiCCRHgRDTLdOBjONgnAhDDPM4so3xwfFjo6H7DCvnXRlhinUSCgO0h5wKfurrzpJi7IBVdBaGpu6LTv98/VAnEUD8gUq9qaPv/x9dg+76ehHdcCYlLQXZeNiY23xvCz+KchHfe+QByNOyiOwmrTMVmE3vMZmlSh2pzfmhjtt4vHH9KzQf77zTW0w2GJdYy6MoXH4Mbc25z3d7VYW97jWzrKYTdlXHovet6PSqhNFBS3UV7X4JXhbHtH/2rNqyPOv7uZbZOr5pnJduE6yBqs8/nYRKOnqWxbcbWQiN3bdiMi9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c90dbc9-3be7-4ef5-3b38-08d788e63fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 02:57:58.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jx7UQxu+2Z5PGLDMg+CRKYnhFym9D4WEhMgETvBcF8/3/sMrZycoxTJNFmKpLjjCToV/aguk9uxYArkm8F9Mew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5489
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy,=0A=
=0A=
On 2019/12/25 10:33, Randy Dunlap wrote:=0A=
[...]=0A=
>> +Sequential zone files can only be written sequentially, starting from t=
he file=0A=
>> +end, that is, write operations can only be append writes. Zonefs makes =
no=0A=
>> +attempt at accepting random writes and will fail any write request that=
 has a=0A=
>> +start offset not corresponding to the end of the last issued write.=0A=
>> +=0A=
>> +In order to give guarantees regarding write ordering, zonefs also preve=
nts=0A=
>> +buffered writes and mmap writes for sequential files. Only direct IO wr=
ites are=0A=
>> +accepted. There are no restrictions on read operations nor on the type =
of IO=0A=
>> +used to request reads (buffered IOs, direct IOs and mmap reads are all=
=0A=
>> +accepted).=0A=
>> +=0A=
>> +Truncating sequential zone files is allowed only down to 0, in wich cas=
e, the=0A=
> =0A=
>                                                                   which=
=0A=
> =0A=
>> +zone is reset to rewind the file zone write pointer position to the sta=
rt of=0A=
>> +the zone, or up to the zone size, in which case the file's zone is tran=
sitioned=0A=
>> +to the FULL state (finish zone operation).=0A=
> =0A=
> Just to clarify, truncate can be done to zero or the the zone size, but n=
othing else.=0A=
> Is that correct?=0A=
=0A=
Yes, that is correct. That matches the drive processing of the=0A=
REQ_OP_ZONE_RESET and REQ_OP_ZONE_FINISH requests which respectively=0A=
reset the zone (file size down to 0) and transition the zone to full=0A=
state (file size becomes zone size).=0A=
=0A=
[...]=0A=
>> +# dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotrunc =
oflag=3Ddirect=0A=
>> +1+0 records in=0A=
>> +1+0 records out=0A=
>> +4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s=0A=
> =0A=
> why so slow?=0A=
=0A=
Indeed, that is really slow. I missed it :)=0A=
The SMR drive I used for running this was probably in low power mode=0A=
when I ran dd and needed waking up first, hence the slow response time.=0A=
Running the same again, I get:=0A=
=0A=
dd if=3D/dev/zero of=3D/mnt/seq/0 count=3D1 bs=3D4096 oflag=3Ddirect conv=
=3Dnotrunc=0A=
1+0 records in=0A=
1+0 records out=0A=
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000482601 s, 8.5 MB/s=0A=
=0A=
0.5ms for a 4K direct write on an HDD, that looks OK to me (write cache=0A=
is enabled on the HDD side).=0A=
=0A=
The same on a zoned null_blk device gives:=0A=
=0A=
dd if=3D/dev/zero of=3D/mnt/seq/0 count=3D1 bs=3D4096 oflag=3Ddirect conv=
=3Dnotrunc=0A=
1+0 records in=0A=
1+0 records out=0A=
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00017558 s, 23.3 MB/s=0A=
=0A=
175us for a single 4K direct write. Looks OK too.=0A=
=0A=
Thank you for all the typo & nit pointers. I will fix everything and=0A=
post a v4.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
