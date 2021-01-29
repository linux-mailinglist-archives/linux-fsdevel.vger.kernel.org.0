Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47743308701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhA2H54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 02:57:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48829 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhA2H4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611907100; x=1643443100;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1BzeCLo8Q12zgtK9ae6/SevX5VHy47j8gUot442vqFM=;
  b=cez71FL9m+YgRkRBxY2BW88zkGf8giCgiA3DAPtF6SfENM+NjAsxbJFh
   P781xw4zcMPratDb/Xhz0HbK71oi5sx50erIYhErdiPCA+FuBy2Oqb1dl
   H3ZNrYU9cv8a3hgIe2J8rFbgajyDtmZrVztM3gvNdVtKhc/4urt+WmmVB
   8z6Fj+X7ZGE8+YceL/beJKqGSwkjPiMxisGeuXdpZL62XDX+GHF4zrZaG
   rSKqSxRIVhcaVLCaKwglPAY3UTJcwfn4UhSx4IG1gEEui1ewLLpY8LXwb
   uMFQ+/f0bDH/aJMxWGt2fjioDP8O5OcpMaredKoQa7LB0anV9k/wnGTWV
   A==;
IronPort-SDR: o0y4xhCNGEDKsz5RlSKdIw180FR883xf/Us2qeqMxYtihyqwHEUIH+4/99EYUnG5meu1W7b5LB
 8FU8TLd5Y3y/X/zofU4XXUCSmbi04RXgO3g1XNk2fAFZi53wGKABzBsHeGQ9mkpHetiNzt1CcK
 5ZKUCaq8A5eU3D6KzKObnAAIDyoiiUmri1PxgCvtmgmyOxUUgg07Xi2bNKDRMqhiSqhvJISxb/
 uJDwpWcVazRbR3aOdfm/YvdWuJJzvMXUuW8QxhtQHj7JcXfdyw9zXs8nrnKw5smitrWATi1cl3
 At0=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="158618590"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 15:56:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/JW989sRtgCOpt3x+buF9QjblXgvGf2CvPxHWiMf2sYWxNZA46Fi41oRRLHY5A1uBQ5zKV1KVoBj46/yulz4idAcao/XHWZuZMSk/bQSm2D0zuq1hifcLyav7qRHd00xUVWadiScERH73+uMqZ9hgY7yqDIsA3gWpB4z8fNrEdqi3J72k0aRL2dPZ97gb6DKW/RfgGoAPAiiQovFIb9rEtFy90CkO5txxCGnkf9ic8/z+acNBgv/LPFHjgXVunvQOggL5AqQ6Jg3g+Sze6kz3JQKUcDU+5LHw+QYoVprLLX3vwQ+wXjW7dMfJnsP4DNpWrpqXJhNydeDJwokOXO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fQ/RJecECLkayYZ9Sr4LmEjY4tffSZOW0F/qsw5Sgc=;
 b=MChfleKG0hcqMt7gEpcRTiYPm41/j/pPUvYbIOJ4Jje84U1X2VlHGZ8+OgNNrYasyQw142V2ZFlAll74qhVjVU8wg3jg/ZZVm2ATpd3EANVMpUEA7cT2zCghMPF77ZCLvAVjYbMl5YkruLec79xdeKfLP1pmmEiFOUKyVESKK9gSKIICW4GDrN0kZjlWtVSmQUwZIjkUCKrnvQHF1FNjOmlxe9H52u3WZM1FrApX5WxLzIKC3ejRNCIb1XwXwSTEPNj0El9oguxp7nUMpJ6BbIfi68PH+0LThpo+yVc9DVgbEh0vLmvhUGwGjsEnlHqTLx3lTXnci5RLTefCWxgnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fQ/RJecECLkayYZ9Sr4LmEjY4tffSZOW0F/qsw5Sgc=;
 b=OrFvPbNLsS4MLeLG42kljxLcQaqdWT7n5ynMqxzepsxUM7W2tLk8dIw62amTB0PYUCgJ33JTpykEmsRBo+OnPgkZm2M9uO5f+Rd+hzoa3u09M5PIhlU1CpeBJlGehqiWhSLUhB7FxdR0UF27Iedg2SpEOD1p2lfIbf9/b1Uvsjw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 07:56:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 07:56:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v14 00/42] btrfs: zoned block device support
Thread-Topic: [PATCH v14 00/42] btrfs: zoned block device support
Thread-Index: AQHW9BnjelVVA5dvZkawooc/VUdIMw==
Date:   Fri, 29 Jan 2021 07:56:14 +0000
Message-ID: <SN4PR0401MB3598F3B150177BD74CB966459BB99@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f684cb4c-f1f7-43b2-1e68-08d8c42b59cd
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4862CE3F1C3D2FC4416ABBA19BB99@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWrR/XJ+o93C1kPEBuTD8zi6hE4ekilLo29l3AfpjbX4i6qp+JZRaYVzZVruwC5zyTmWAhWJU0KW13TITxLsBxmxO5iy65exaWPLnHkHFU6lfZ8ooQUP1P1PZyKQ5JlBIGcvz3qbxQKav5iOC8ir6ngZedgj9Z4TPJjDIWXHlnLQE7XHH0jvTGxPzpMLhUSjx5aEoHbF2Ezvswp/RD5QD2qfIoJTcJ1ug70AJZ2lHtXpxxpI9UUcnMzP4jD66YVJeFy5P7muRJqbI/h8qbwfNAfmjuBFSNU3YLjCzWvsNDCuFdCVcmRzs5Sr7gkyYbwNbOmjwlxpyaUEwgDlAntbNPEqrvlSwHVP/oJMzzs2hDc+Fk37v+FUn1L9VghfRma+XO/+Dc6lTNmQRhsePldk33MSC4oT3Fwx6spwrIdNbbKhxod1L5en/WeAbaFbY/CRhp+MPioUub8Qt/ctYjVLca3Fl16T4WHFVoGl0bqNWKwgl/NOnRMVLFDLUZ8wZrauWRYw+A8uEvzN0yVAaKPQesmIiQq0yp1Ktc1ktIQByRjdzqxIqAc27qlyd7RoR3ZJMYPP0UnbVoKiEDxsUpze6Un/8d77W2IXTxDX6omCB4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(55016002)(2906002)(966005)(52536014)(54906003)(316002)(110136005)(478600001)(53546011)(33656002)(71200400001)(5660300002)(8676002)(186003)(26005)(4326008)(9686003)(86362001)(6506007)(8936002)(66446008)(91956017)(66946007)(76116006)(66476007)(7696005)(83380400001)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lkvS90sFt2edoIpvB76rnKfT/6GCjA0CNzmUwCmGsTGNkynsbca9invNCs1A?=
 =?us-ascii?Q?zu8bkOXGOqh5ByfDS8bhr/C+2fo99veXNKxhciC50k/h4Zp4jX+PbTFouAWD?=
 =?us-ascii?Q?uX+uGOIHxd4w6MRv+i5IXXYEMX1gWF9m5wB5cDOvRo4ETZ2nHi0EzR773Y+E?=
 =?us-ascii?Q?upNTXS0rGuiTH9uPJw73QIAtEm+jdmtsiLtzQpKk+ncUMOaK0dvgF2dcDny+?=
 =?us-ascii?Q?VeCyO4RyX6EgriyEo/24QhTUJWFdwYMass6k1i8l2WsGa2bqAVY+TSPPpFy/?=
 =?us-ascii?Q?K7zlaZyYAIhRt9APTQxfBE6g1P6iSQsIj8OnldpWpv55L3KNwOkp08w0Em5A?=
 =?us-ascii?Q?Xu7IsSjjAdv4zNla+sosBBvPEz+zgIG8/QR+Y70vo9pb7RCTgRLmLx8n5heb?=
 =?us-ascii?Q?cNecZPLmU31qBG9zEu0wcVFOzU+YaTRzKbYSXXymkAASQM48/DRIIZl7RPtd?=
 =?us-ascii?Q?EJjRuHDdKy5VYo8pevy0wks7hK6wsuB/t5/z3Z33i7AxvYmxWTG3OrV15OAq?=
 =?us-ascii?Q?vsjT7O4B1ScRctHNA06S/sQMUn2cBuj8Xo0ysUzU6ApDSTfQGXMJanmTJnWB?=
 =?us-ascii?Q?Fv6TN7DLf8dO+LEjh2Mcxt6gOVjDmffFuNWyhpQ43gOuVJzHPJnkgzr2GkNf?=
 =?us-ascii?Q?aj7iE8JEnMfjkGpVbDOL+f8smlwsssgvJAmm5sn5IOodtQFoF//vOKtC6tL9?=
 =?us-ascii?Q?fpuK1zl3nxj7KaUNBmXeQUo9W1CixzC6AzJ4142brFA+suI0K5J96fNL/G+d?=
 =?us-ascii?Q?I8cPynAVIuzN6zE8S0LPahtk2wIPAV5sqvQgBzAQONJNUls5M1t/UJ6hO/0x?=
 =?us-ascii?Q?CFaDWyZh12PLqGOwvw7reZBrwxmIEKC1jNEEGMFpoooD5oMDmCIgwmjbpWAP?=
 =?us-ascii?Q?3joEp4ZKsXyfQUUuD4dLCi1axJbAEiDgbbqJueaX+98+cRyF1P7brEgIa+On?=
 =?us-ascii?Q?9sPcSL5sE0D+IFncm8uNGXvsORa4u6OY3SuxS5f9RWkLJ42072ssTN5/AM5d?=
 =?us-ascii?Q?5ikh8hTcmR8b60htqPvZDIBT81+et/7aQWeXH/J7+SJfB0hNOrTgkhZhDF5M?=
 =?us-ascii?Q?WWTv7wyxaBpDnS97fS3KvmSr90q6uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f684cb4c-f1f7-43b2-1e68-08d8c42b59cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 07:56:14.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyhpNeiU9fwwIoEvcBO0w0XFiLXPSRPYJsuYTTHR8L+gw6D8Cn7sT5EoFoqZxu3BbmbcJhUBixXkdNHjlkNPBS6KqpWGtZUgCcU/jumObck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/01/2021 20:31, Naohiro Aota wrote:=0A=
> This series adds zoned block device support to btrfs. Some of the patches=
=0A=
> in the previous series are already merged as preparation patches.=0A=
> =0A=
> This series is also available on github.=0A=
> Kernel   https://github.com/naota/linux/tree/btrfs-zoned-v14=0A=
> Userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned=0A=
> xfstests https://github.com/naota/fstests/tree/btrfs-zoned=0A=
> =0A=
> Userland tool depends on patched util-linux (libblkid and wipefs) to hand=
le=0A=
> log-structured superblock. To ease the testing, pre-compiled static linke=
d=0A=
> userland tools are available here:=0A=
> https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp=0A=
> =0A=
> v11 restructured the series so that it starts with the minimum patches to=
=0A=
> run emulated zoned mode on regular devices (chunk/extent allocator,=0A=
> allocation pointer handling, pinning of freed extents (re-dirtying releas=
ed=0A=
> extent)).=0A=
> =0A=
> This series still leaves the following issues left for later fix.=0A=
> - Bio submission path & splitting an ordered extent=0A=
> - Redirtying freed tree blocks=0A=
>   - Switch to keeping it dirty=0A=
>     - Not working correctly for now=0A=
> - Dedicated tree-log block group=0A=
>   - We need tree-log for zoned device=0A=
>     - Dbench (32 clients) is 85% slower with "-o notreelog"=0A=
>   - Need to separate tree-log block group from other metadata space_info=
=0A=
> - Relocation=0A=
>   - Use normal write command for relocation=0A=
>   - Relocated device extents must be reset=0A=
>     - It should be discarded on regular btrfs too though=0A=
> - Support for zone capacity=0A=
=0A=
=0A=
Hi David,=0A=
=0A=
I know we're late for 5.12, but the series has next to no potential for reg=
ressions=0A=
on normal btrfs is there any chance we get get it staged?=0A=
=0A=
btrfs-progs and xfstests patches will follow soon as well.=0A=
