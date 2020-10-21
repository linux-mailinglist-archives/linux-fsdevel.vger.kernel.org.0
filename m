Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13898294B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441835AbgJUK5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 06:57:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37792 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410469AbgJUK5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603277824; x=1634813824;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7EIF0E8FOvnsgBLv78MDjm0vhunxZDJF1i/9Tlrd21k=;
  b=HRtKiWp9GyP/5MUGzDjtaosGfv/Rs7xo5Eez2DkHSkUaUCLDSlh15cPW
   2fddwekKfovB2vMMNMcIn+1txQHsaJQEYdD8bXsxL11W8DL1y+vurgGvk
   lSAwZxXyLDARXX3TkJTgTNdX5hvKPb/86VfnqG42Igl982CqyQgG9IoXV
   3YA29FH02bTR6rZFUGOROybNiX0rgloeu5ggk/abyACCpkjFrdPSTvPRX
   UWGIPk+Sf5o+3EJQaRItoAUBBY236IIHrRxzX9MAuUEPUxT3kOJwYmnPd
   pRsaAjBiOSuBcppDAJsxZtY7cDMESt9ZnFwdK/my221/1lygtEOCFMZBF
   w==;
IronPort-SDR: 3Q2/xnk9/DEJxC42DRGF+nMb020vdpaotzedObeFnlKyCj+se8ctUcBLN+Mn3dBZ3G84cgwCIp
 qPeqpnZO+kh2cav82z7XkhDkwZBtnUoBuDvToGCm+E3tujlt8ALncyED2mBCXNSySKT7oLJqhO
 /FLaItKTOy0M1TCe/KYg8I81JAktD7YtRihS7X7d+e90QcrQolJ0n2f4sh0qyS0/UfQWb3itAM
 Rw2cxIlrhwcd8G3zsZ/zsrNNasTQwPzNME7aSrwCY1XfW7DPzeTsR5hNuf0BMdNHwXbA9QwRVs
 8yc=
X-IronPort-AV: E=Sophos;i="5.77,401,1596470400"; 
   d="scan'208";a="260399621"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 18:57:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYcgbe+qPoARcgO50z5xsyKA7rBxHIHsyfSTrHp7EiKK0Y9j9O48EErmbKOAyhbQSJ9y5b/Wqg68R9/Wy2lJgpSR0gZrqOtewRZmfQ8TEYbHlimAaLvoOMlHG96XVeKTvI11jV2wT+3MH9RsDuhU8UARG7piOc0OazOykA4sZJkddxX8c2N3mhlvgy+uX/2nbMqcWA5gFWHHyEjGBAYnnYo/4mjEaXRLbItX/hOjGcCJM/jCpMsP/slYcnZA/NIlx+igEdP/FCVfXCYOlLYoCyqkjdretRQacSz/TNr6l1vlrCQS7zO+id8pU9hlgljR6Lj8kOviBcsWcIOX3eNezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gumYh1m3nIdmuVGpfB5QsmE0HHwH05lIp6UBR9oQutw=;
 b=mZg1RmevrclsLSj8kRFchVKADES1HTJiymMp8Oa8cH/8mM5ndhyd+wMSKMF2rgNj2UwstqB1Bmc/kO81XjVxaqyAxfNgT8XhBQtfd78L4tZ5NTwAjMNQUztrTNRKCZkcZJilx6/gqsOy0qalitF22GNiBAuKHwBc3b0YlFLXqRdyoXDzT2J5SiYcex3H2zTJyXAj0flzPb+o+og+sZt35IzCGO6dknMOck7+buh9Bcf8h75bR/N/MjBNIe9v0d+iNxa18VSOh8KrMpvTdXSLFF7pcxap4nKxSSe2TtAIyuJwB0Dhdslta6nIk84IMbh0rBZaDffy5mZK+4yHp0qIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gumYh1m3nIdmuVGpfB5QsmE0HHwH05lIp6UBR9oQutw=;
 b=s1+6sav/VMpDTkf+uMcRvluQc/wJo/rPmdbN7XILzzeS2mUA7WHz+6dA+MBcCJyQ2RtX4Xm9Mbg+jgfVIWuEAvc/vHlgQuyYaOkDMR+50rj4L/uPKiza3x8CtDn+TencV3ViYboh55HlMT9/LXGJTQBBZFT/ukW1qYNm8QpmGRg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 10:57:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 10:57:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Topic: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Index: AQHWp5jo+FBwU+0LhU2DuGQVCdRitA==
Date:   Wed, 21 Oct 2020 10:57:02 +0000
Message-ID: <SN4PR0401MB3598C9C5B4D7ED74E79F28A09B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d96ae911-ace2-4659-6a19-08d875b00ae0
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB23178CA8412E16AB63388ACB9B1C0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79tYQq5HvSN6jCKAv+ROKMyEALbDXV25ItNnPEz5cbY/LKmfOcaE2+Cwm0lMvoUv8n/LcFO7YzANY7iRk47UHsXFxP0BVgqdE9Gu+lQeS3EE2lUE1zWYpn72tXelZ3Wtao6QNUPDJDPmmMMH+Ken2pAlmZX3fA+6cTGoUWGzJ15EwpKrJQlxnbinRe+drF5SSEXuSHMFuTMT9wNJ5F6cqh57S9AyxdkukXRRbb3fXgTL5vp5jKpW6RH1d08sYN+8iF+0eFatiH/RwJbLpTPOg9oy3XM5TrkMS9wXs/pUNl/0BWvcS6OM5Yui0P/65nbuvvFd9qaJ1ayCQwkBNjTwtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(54906003)(66946007)(55016002)(316002)(4001150100001)(478600001)(8936002)(86362001)(26005)(6916009)(8676002)(4326008)(9686003)(186003)(7696005)(6506007)(2906002)(64756008)(66476007)(66446008)(91956017)(71200400001)(76116006)(66556008)(5660300002)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zq4FRd6ci1dV61UR0CegO5GKSk2K/3pTD+Mjm75YM+ek6UuS1mGN2i8hbcNAR5Dj1bmeFiSOgipPI7RzYLbuAC8Wy172RIR6OPzyKYz0mBOdLO5/ZKMzg20ZPutdjrPLejkk9J/L1sO/JZvx8Nj+UTevwHwNgHGWczURv7FkC9N5lo16da944AapUcDQvGlxXE1/Ng1pdmFty68hxaKQekMuEFhp9JvdTXxlhen7i8va9sofvSzEEnCh5/XOes3cfcFHLr1amRM5j1xO/Tc+241eZcyrx1QApN/eTr1XqDlYMC1PcmFOJVNVPIce9IE5IwTO36bmrEzHlJdF2amuc6QaCGRgIFs34SDujYir1cJFEQsQQbxYSpjpSmAte+df2RxXk+tJpmPqp6E3X9wyEstPrL5xzOn5s8Y8T3gWV/VDodXuSJiIVz3j8C4hM3CbpJy49Kms/M7s5rerCDVaNqlzL2nkE3aiHrz18GO7OY9C5iPmEtzBz2let7Pg+GR/oDIIiy8U/j1VR5gXGRBWvw+3m6MKxoJuqvoTkk5mh7AONzyFKxByXX2kaxu2gVEUjc4z6FXXkWE/cMWY3UumX5DYAtuva9EcaMG/iDuMzXQkXOUZuAMQn284jgZCHRs2vUzZlaQ28Ra38chQISjkGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96ae911-ace2-4659-6a19-08d875b00ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 10:57:02.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VO/6lloPfWn67+fizwmIyiJYMewsDR3wVCS24kAfHRvZz7uZVD2YbxYt/aZYFbGUjIdBUFcsEdCwWQwqiy5HveahKtz/MBrysZzZEAVCYO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,=0A=
=0A=
I've encountered a USBSN [1] splat when running xfstests (hit it with gener=
ic/091)=0A=
on the latest iteration of our btrfs-zoned patchset.=0A=
=0A=
It doesn't look related to our patchset but it looks reproducible:=0A=
=0A=
johannes@redsun60:linux(naohiro-v8)$ kasan_symbolize.py < ubsan.txt =0A=
rapido1:/home/johannes/src/xfstests-dev# cat results/generic/091.dmesg=0A=
run fstests generic/091 at 2020-10-21 10:52:32=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13=0A=
shift exponent 64 is too large for 64-bit type 'long unsigned int'=0A=
CPU: 0 PID: 656 Comm: fsx Not tainted 5.9.0-rc7+ #821=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf=
21b5a4-rebuilt.opensuse.org 04/01/2014=0A=
Call Trace:=0A=
 __dump_stack lib/dump_stack.c:77=0A=
 dump_stack+0x57/0x70 lib/dump_stack.c:118=0A=
 ubsan_epilogue+0x5/0x40 lib/ubsan.c:148=0A=
 __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe9 lib/ubsan.c:395=0A=
 __roundup_pow_of_two ./include/linux/log2.h:57=0A=
 get_init_ra_size mm/readahead.c:318=0A=
 ondemand_readahead.cold+0x16/0x2c mm/readahead.c:530=0A=
 generic_file_buffered_read+0x3ac/0x840 mm/filemap.c:2199=0A=
 call_read_iter ./include/linux/fs.h:1876=0A=
 new_sync_read+0x102/0x180 fs/read_write.c:415=0A=
 vfs_read+0x11c/0x1a0 fs/read_write.c:481=0A=
 ksys_read+0x4f/0xc0 fs/read_write.c:615=0A=
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46=0A=
 entry_SYSCALL_64_after_hwframe+0x44/0xa9 arch/x86/entry/entry_64.S:118=0A=
RIP: 0033:0x7fe87fee992e=0A=
Code: 0f 1f 40 00 48 8b 15 a1 96 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff =
eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff f=
f 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28=0A=
RSP: 002b:00007ffe01605278 EFLAGS: 00000246 ORIG_RAX: 0000000000000000=0A=
RAX: ffffffffffffffda RBX: 000000000004f000 RCX: 00007fe87fee992e=0A=
RDX: 0000000000004000 RSI: 0000000001677000 RDI: 0000000000000003=0A=
RBP: 000000000004f000 R08: 0000000000004000 R09: 000000000004f000=0A=
R10: 0000000000053000 R11: 0000000000000246 R12: 0000000000004000=0A=
R13: 0000000000000000 R14: 000000000007a120 R15: 0000000000000000=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
BTRFS info (device nullb0): has skinny extents=0A=
BTRFS info (device nullb0): ZONED mode enabled, zone size 268435456 B=0A=
BTRFS info (device nullb0): enabling ssd optimizations=0A=
=0A=
Is this a known splat?=0A=
=0A=
Byte,=0A=
	Johannes=0A=
