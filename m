Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA132E8F1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 02:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbhADA6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 19:58:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11871 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbhADA6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609722126; x=1641258126;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hySAzz86cunUFwqTSFGWWavjzS4pt62+umMeB7cORG4=;
  b=BUOw7mIX39JMMd6Ps+0g0xqEfi+XyeviiyJqd/Mj1PCEInsb7r92rSqP
   tF8sKE5Mkq/s40ocHfC4ZiOqTC3oCjme8a52lCql8quR1uyU0wl8f+FCf
   AQ277SK2CF5ZY0VBjY7hwuD/gMUUogsy+WuvgDo3Tk2iLUArynQcetR6n
   eyBkQEg5Lp9c2HzpbdDpZejifwf5wdEsgNOWe/gFswi/FXmHCUUkl4uxg
   7eQBSKMgqiqhMaDmKgqTDlz6ohifXvzus6seoY4+6PnkVoEwYrP4/pual
   ZQZ61JsEfxj4XoR0ac/RCiufRMVsdHvgI3PzLAcn4rMVuOCw4n6Q55PP/
   g==;
IronPort-SDR: aZuT+LSkzSybbc9xlQBBj5l9e/B1NFgG9506tKcN3kgKqTzeUqOCgR7ndspdiP1I1Xx2LDkGl2
 U2ervnrKAjjdvTb/YH0yeiVEdgu94jx/olvDz0uqmX7QSXACe0P9T/znMTROffvqUWxpt1Il5r
 BT66JMcsMBO6WS0qGrQPHs1P/6nOU0F5cCFgOrGzi63qXKYdhctgDTQQOaAI5E2quNFfOfd66j
 3FT3PL3l3yKZKyOROyP0FvMGSAewaZrUGcZsitGmhefL5jTB32rpqKZ94xjSJjpPJwVC2RBOuq
 KrU=
X-IronPort-AV: E=Sophos;i="5.78,472,1599494400"; 
   d="scan'208";a="260309331"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 09:00:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqCNcD+AhHZtxL/CeEKRWWstxHCC0MyK5gAwhThJVRgH+6Ql4uRzxIIIL9MRuvDJFl9c6wmoywXZku3Mc+HfPPSctE//rXukDXjhJkDaLzB4UYfevTBZ1x6ViT9edekQNWdwbOX8gb3l16XbeT7rt6ZK48/OpYHl8Emspy4LSbxHrMCFdPlmx5LWXBt5Y+04nEsYkiiaz8EMY0CpdesLEPbrFWieu9EOe7AGV105a5tMI0RVBUeerTukpoCO+7YQjEB/tMoWQIMylXmKsm65M+ovol4YNjinZwdRtb2RQDVIZAuiLdzX4EoWZidVYxbWBJDvHn1dnkwingF1efYSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=825Ea7U0l+eQRZcCTiARuMSlbF/8cW424OKenICmchw=;
 b=IuvpSUBY9IbQh82NGoEfAmAnxEAPiBwUZLlBl3ZTVIUBe7xCBSTfozX2e336yelEWDyBdPYYsR/cb7jzMs97VpajzkA8S4BnFs+4iE2HciDAbfKQitpfk5Pbq7Tlxx6pNaaCYMk1ocMGcnrGWIR0UZlUG6/i465akK1bYDJC/rv9tZEus1oxxICp+oIyK8WPWTjUKXI8DFYC7Me2KyPJPHf2K2qy/j9K9Pw60wV0U4LcBXCSP5gT8Z8XnSUcAKqNWoP4PrV83V5zplFvw/ay+dER9XgbIpa4UtaOD2S7PyAlnVLZ7tF/wheO6Eetixta0byC8p97/PRt/v1PvMpYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=825Ea7U0l+eQRZcCTiARuMSlbF/8cW424OKenICmchw=;
 b=M7tLCMfI84ei6U8KdKioDBXbZTjBzjGW3rqvXG1S0W5kFggAEdw2KJg9crG/w8pAhmxqdyf4xeOkAAcwJUk6wg5/rnDvbWG99jIN9eoV2KjpEkQoML0QflVJkmQTlE7wQGhB14UbLdg1m99Orum4iEAY8ZGcneiMCb0ngMkPQJY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7438.namprd04.prod.outlook.com (2603:10b6:a03:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 00:57:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 00:57:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC V2] block: reject I/O for same fd if block size changed
Thread-Topic: [RFC V2] block: reject I/O for same fd if block size changed
Thread-Index: AQHW3sVYE0D3BnsJEkakKhpEGYvfNw==
Date:   Mon, 4 Jan 2021 00:57:07 +0000
Message-ID: <BYAPR04MB49659FFF1A820C9E7BBC1D0386D20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201230160129.23731-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95144d6f-e103-41df-53ef-08d8b04ba90b
x-ms-traffictypediagnostic: SJ0PR04MB7438:
x-microsoft-antispam-prvs: <SJ0PR04MB7438FDDA15999445E06A3F0186D20@SJ0PR04MB7438.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzbhm1pHmTRkEUcz1rjLSpGzFGme/grooprKs5eDQ+8ihy6d2prrv6zSjm0v2dmL8/1QI3mNXmAqUt095MtIzVl5iH8id+lxoMYtXSxmhcee4fp2b3iy6x/ykKXsF9p9D7OAwlgI1hQdQYk36JMC12WhzJjksJWXU+jXH8H5gFX6CjIWsDPbFVTBAA6Zc57j7YXi8bReRpHzKR5GvT5rkv6DPUb+swhkFTLIKnrialqe3I/LiXMXc4U7/0uw+tO1g+X57zJrgJ7jUDkMOcal+MA8sWMgMA/8RIde/MhKhEksYP3IRefeDiXiCTJkGoX0DQo9QouOaN7NTpt2JD0/CR9viUqpAsi2zIwx0jHQCXQXvAn7lJAiATIKUbWf+Wr+ogD6rXG4R/ZEwgWm89Ei4lhObqxANP/vGpcJyKpQokMusVLy4eGtXsqGtl1aQF5+DPxlAdV2sfBnGrDpgOa5bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39850400004)(8936002)(55016002)(33656002)(6506007)(2906002)(53546011)(966005)(9686003)(76116006)(66946007)(52536014)(66476007)(66446008)(64756008)(66556008)(83380400001)(316002)(26005)(5660300002)(7696005)(110136005)(4326008)(71200400001)(186003)(86362001)(478600001)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UY7s9R2lSbcth77YYQp6Oz4HLqHvDgz4rF4bUIwkiivRO6lI0OIVtAKTBHFQ?=
 =?us-ascii?Q?iRA6ySuErKZA1kZJhpTO1+EyLX0VXGtJgT/2FwArT8yRV4U65hfao0P5I8cy?=
 =?us-ascii?Q?4p8kJVlYmtxXTxSS9rY3R2crgNeX9Md5XSXfmRzcTsi053/FGSSxCptpUHbq?=
 =?us-ascii?Q?Mfm244UjksRgatvtYEZM+9qE/AfmphE9iREjgE89digjGnayuxu+RPODOfVZ?=
 =?us-ascii?Q?sxWf0BFJMS6mLok6WrJSduEYu8nSNnElVRRYjvo19ckS2SrRZuD1PZc/WeCT?=
 =?us-ascii?Q?RVbnPg6dnMiHb9ZNnuLB7+0FEo1aU4vZXwfmLFAnXbJJyLFeOaCcrZctFL1E?=
 =?us-ascii?Q?itKjGa6XwRwoPWkzGT44rpXB/Mr1T81UN5ChwmJ2+dJ6grvE9geg4yVC5GDr?=
 =?us-ascii?Q?EwaSn8MR0N2zajM4j8FhAxf4N2Kz/2hTBACTdILBh52+G3SQr3ZrEUyRiNSl?=
 =?us-ascii?Q?r9UpsoEFKAzKyRj6dLtdxcZEdOsHvYFRf8SKTTDUAMUWwC9Qkx5iE4jOdZY+?=
 =?us-ascii?Q?/ZL6/Xwu3FAo9ZPhFuJaf4sOhM82czKS2iDikmTAybrztE5ye4CrdNMRLcCM?=
 =?us-ascii?Q?0NfAdGQodEpuEYDQSo/8mggKe21Dnb2q8yidQZoMClVSmj4wuOwDSb9WZKCa?=
 =?us-ascii?Q?YSLPW4SB0hiEeOmpe0aJ6tW88MOm+wQarmtYAOLc6upEq4FNchijTlZNdNnq?=
 =?us-ascii?Q?mP7ma8FqMNiithSPewqfdIW7WEp7HTH1CtNICXVW9WIfm7m8NldYZ8sFyYbu?=
 =?us-ascii?Q?bHPJet1a7Md+Ljap9vDfs6sqPeHRS8m4/AwhrWVLPByZluG79JRC9ncBNZEd?=
 =?us-ascii?Q?eLRwKw6QBLV1Bl7frGX8c02WwpIkr2A5rzXGlAp4fgN6GDay8VP4WyR3MKh1?=
 =?us-ascii?Q?BpLAbvHUIcb2GNAaAb+MRh+szyrTO39XQF+R0Xc2D9hN1YcicpQ/OvIyfEnq?=
 =?us-ascii?Q?A+iC2UCK1qDR9xHyskHWpPbWchOyyeOc7F+T1OYbshMP6YSkLb2RPbf1DJX6?=
 =?us-ascii?Q?NhBF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95144d6f-e103-41df-53ef-08d8b04ba90b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 00:57:07.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R4mMaG6QV0AX3rNOlphn9AyOxb5xi48x58571LXrIOH3NkxAS2knAKQ+cuuP0EeF5m+Yuql4KTd9AUKxcZPXha+oBhgKOmC5aqfLRbLrs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7438
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/30/20 08:03, Minwoo Im wrote:=0A=
> Let's say, for example of NVMe device, Format command to change out=0A=
> LBA format to another logical block size and BLKRRPART to re-read=0A=
> partition information with a same file descriptor like:=0A=
>=0A=
> 	fd =3D open("/dev/nvme0n1", O_RDONLY);=0A=
>=0A=
> 	nvme_format(fd, ...);=0A=
> 	if (ioctl(fd, BLKRRPART) < 0)=0A=
> 		..=0A=
>=0A=
> In this case, ioctl causes invalid Read operations which are triggered=0A=
> by buffer_head I/O path to re-read partition information.  This is=0A=
> because it's still playing around with i_blksize and i_blkbits.  So,=0A=
> 512 -> 4096 -> 512 logical block size changes will cause an under-flowed=
=0A=
> length of Read operations.=0A=
>=0A=
> Case for NVMe:=0A=
>   (LBAF 1 512B, LBAF 0 4K logical block size)=0A=
>=0A=
>   nvme format /dev/nvme0n1 --lbaf=3D1 --force  # to 512B LBA=0A=
>   nvme format /dev/nvme0n1 --lbaf=3D0 --force  # to 4096B LBA=0A=
>=0A=
> [dmesg-snip]=0A=
>   [   10.771740] blk_update_request: operation not supported error, dev n=
vme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0=0A=
>   [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async =
page read=0A=
>=0A=
> [event-snip]=0A=
>   kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: di=
sk=3Dnvme0n1, qid=3D1, cmdid=3D216, nsid=3D1, flags=3D0x0, meta=3D0x0, cmd=
=3D(nvme_cmd_read slba=3D0, len=3D65535, ctrl=3D0x0, dsmgmt=3D0, reftag=3D0=
)=0A=
>    ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: =
disk=3Dnvme0n1, qid=3D1, cmdid=3D216, res=3D0x0, retries=3D0, flags=3D0x0, =
status=3D0x4002=0A=
>=0A=
> As the previous discussion [1], this patch introduced a gendisk flag=0A=
> to indicate that block size has been changed in the runtime.  This flag=
=0A=
> is set when logical block size is changed in the runtime in the block=0A=
> layer.  It will be cleared when the file descriptor for the=0A=
> block devie is opened again through __blkdev_get() which updates the bloc=
k=0A=
> size via set_init_blocksize().=0A=
>=0A=
> This patch rejects I/O from the path of add_partitions() to avoid=0A=
> issuing invalid Read operations to device.  It also sets a flag to=0A=
> gendisk in blk_queue_logical_block_size to minimize caller-side updates.=
=0A=
>=0A=
> [1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.l=
ocaldomain/T/#t=0A=
>=0A=
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
Rewrite the change-log similar to what we have in the repo and fix=0A=
the spelling mistakes. Add a cover-letter to explain the testcase=0A=
and the execution effect, also I'd move discussion link into=0A=
cover-letter.=0A=
