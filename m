Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999135A984
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 02:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhDJAaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 20:30:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33592 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJAaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618014602; x=1649550602;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6rDmOk0fxAFCtDiCdKalxNeyLF65eE5SPFK9YQZQzT4=;
  b=BxKZaGTsFu64HY1zpxerIQL4oaL7hpkl/hGTXHDE//rZjLbK+pCAgMww
   EtVr/IRKl01CI/SCQ7/0X0ACXAYOQPc00Opz5qH60CH28BcecthZYgtL7
   brP5rsCxkYBbTxDUF0GxZOh9nDi0wF4RFuFzI1q1ZrZ9UdZdAXhx22lvp
   bw2IAazqmY1Vlq96g5Qlh79/9mmR7r7vRgs7R1+pCL7SpHyjTXdanYzxG
   CubPMPAqSMlyrs28Wg8bEDlmQQAuZvv3fCS5T7ltIMFscHXykjPtGwZVF
   D5Hg55wNfST6S1C7Un1bBzgSxzLuZXZmv91N11K00SvLpnvCQN6KOGnVP
   A==;
IronPort-SDR: aD2egv+uYik22Zxl9QVNUw1l4FydOmyGYd+G7RXJMbPnDfXWLTus+H/dWrahB5/SqEGsP1xAiu
 n56E+am/3fV4tstN0JHqHdTwnmGTsxy6jZkFUiMJIA3Mms6A6Ij7+IanmpcZNIdzWCEUy5b5sN
 IjqlTx+7AgkQOqZjCsVOyCysq6qVKS+P2XtWcd+DG+LRXAJMvyD+6wKJ5QHQhPEtINLyY77z0N
 WGnQNQoksPOO55DaKTLxjoVnUsA5I1utdm8no0XmVcITrbFzq1OzZTwsCSLGI4uNBTsPkE2Vw3
 Uck=
X-IronPort-AV: E=Sophos;i="5.82,210,1613404800"; 
   d="scan'208";a="168849976"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2021 08:30:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipnluENEv2gZyKHpjfHrK8s93I0JEMBxf93ogQIYUWvZR7Cm70uGSBOuH/c3y2JmUoWfroP2yUOgQvR7HRIhl/L/a6lZtMVnziMwEpdAP2lL7PI0El7/nRUjV4DCIEk17pGmEXtA2GMk+TAZ2OJ0CjeoWyxozruJ3ePuvxCba/gInbybfqzSgtCz84ICzjGuDK7Q7trORnvosulV/r8Z/pABcvDHq5SX56wKyqLrXnY4j4JehSHDhjsiDB6ZdRWMs2er/9WQS8N0t0sNLnwsI0oLqPwbXKjoGBg2D2snpIkgw5C3MDBHM82Jfs0WM7WSyr2DLPgzHbJz7fWW4zRj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhIppyKVcskmIuXZ2gFEOK2puTkpxuijmj+l+MYuYL4=;
 b=YCLoylca87dviGKIE394V9MzF7yK7uUnAAQXQQWGS+jL+Y8zZXc5s/eirz6S6zR0YH7ATn+PT0l+kX9eWOGZFo4nKp4GhD+hCLzOQKBeJQsjXCmwrd5Xo9lpC8/Vmnu4YhRAJtcpiesJPWSSq6Q+YxS6UAW/18v4NbpW0PLbHYq1kQIaCatTIoeXu/cjezpvV/zHwG3U74Dmm1FiwuyUcWHgu4KKkUS1uHn8NWqcf3fsQIdVnX2aO/bt+zzMcsHtehGplu6YQP2Jsiwr1IGEtnl4NRHWjQDfekBwu6r2t6Ac1Qbs2Sxctun/uqYddux4NFd98ii+sJ6OlnyvLP/6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhIppyKVcskmIuXZ2gFEOK2puTkpxuijmj+l+MYuYL4=;
 b=uxIDIgL7E3MZNoaanmzaHKbHJ8Yg5u8RYE6vtDE27y7+pH80ekYcF7BLMUmpWydFJOMyKHQr3DoIZuggeO31NuIBIz4ycsJR4GjcsQ8Qy+seOQSLFbNfOKhQMMf2D/jG5zQdHgEZNoMZ04GL3knqyCBDr8NXbaYLkAoV61EY9t8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7439.namprd04.prod.outlook.com (2603:10b6:a03:29d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sat, 10 Apr
 2021 00:30:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Sat, 10 Apr 2021
 00:30:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Thread-Topic: [RFC PATCH v5 0/4] add simple copy support
Thread-Index: AQHXByxPYjd3lKFugEyHev6iOAHEsg==
Date:   Sat, 10 Apr 2021 00:29:59 +0000
Message-ID: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <b56a18a0-facc-edb3-c809-7436f1b1c15a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ea929b9-8254-4645-a389-08d8fbb7c683
x-ms-traffictypediagnostic: SJ0PR04MB7439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB74392B9C2740C3CD3BBF04CE86729@SJ0PR04MB7439.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TaepJfvUXC9mS8d+G/S9CPlHKIe+6hjpPma6YtqB9MngQ+AVnxclkFjcyhLql09RDlwDdlVrAvyAY7Z0sI8NT/732fXRYYVuIT2hRREbI563oE4WO+IG404Jx8UbwQfSNG0VTuc4hk4HTHCEdN4zzSmNNzUmf0Yrf8JJPSqtWcLHwON8CDHkiLh/wrv4zckznfVdSMNks0oHA7BT8388F50+6Cd6xJEJgt7Carn7A9SRSrGjTDaNepLQ7tC4RbRmck5Qb/8lWb8JXYRZTV3Hdn29p29BTVTpZ566NhcsbQLkTEkrm21+AIMJf4ji0LsxJSoiIUcQOtEq6+pmK2CZQ0ECMBNfkpLTR3IN7z92MqScpd/riFucLe8NNrS93E2ouKC43Z9E9GowfknyRLSrLtBmC7Mdw6xxKq/3jSRy55QLQadGTbx0pIQmuE/9mBnOIvguVsZFrrmuKUEdXfgttO3dVC6e41asEylR05YKU85qePVDQuOh+tvUvgbTJDDoJ0lR1J6IrTDThjuBB+EbBghcUk4VMku1Y0AQ+5e7l+NTUBnJfoXOfR+dxBv1Nb6LjwQE9zQ+NF7umY0EdJSm/0YYhd0Biv2WDoHPBrHpAEt8kw4k+Q4kD86VoZADEzvhl8fTLwfxVUPrzPfcPAtWgtZDTVleq6gRPJsOdVda94GShEMNFtUFjXXmlBu9b1gJ5WyrHuxDx9LRv5yZ9FpBGiVnoh0Tb3xddk/3uWVtD+gc5FLnvZJ8cELfZr82tCn6WwTKZDKlEla7wdLKA5WPoKy6FcqEyI7Y+0XLMQpSns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(76116006)(186003)(38100700001)(4326008)(33656002)(66556008)(66446008)(316002)(64756008)(83380400001)(478600001)(8936002)(66946007)(66476007)(7696005)(5660300002)(86362001)(110136005)(52536014)(71200400001)(54906003)(26005)(9686003)(2906002)(6506007)(8676002)(55016002)(966005)(53546011)(7416002)(43620500001)(15398625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1uqmL6hYj/1btMsacHkl+bRRyG4yzKHDK2jPWCMSPkjiroymsLkWmCg5IL77?=
 =?us-ascii?Q?Sl3tfdienDtTjrIMkcMYquM7YHyD8L8A6uVyEVnb/+wTiFSECKiNap9bjegF?=
 =?us-ascii?Q?f0p0ySs9Vc5TqakN3dkaGo8/wSKPPZjpQA27hENtFMmy6n/jKXKRqNCdtZ7I?=
 =?us-ascii?Q?BRudoAjF/Sr10XI6Xfz3PW88xkOWZ7b6uA5/KKwI60bbA0NOS0w3g4R8SSTK?=
 =?us-ascii?Q?3HrTaynW1I/80hV1KcmzZZsqodvj6RpRrNk9rQ+hGQjo3ZhE4V4lSVFAj8t9?=
 =?us-ascii?Q?Uv0drq9UIwzyNpK8XeQ5kalDY826bZyFm8+JH/2bBIHLc4KBwJTjVuaJ+8rU?=
 =?us-ascii?Q?8TcAk7MynsmgTyfRnSFBKv89aE66k1HFgolKj/vhCSWE4LbIy4vs1R4V4kdI?=
 =?us-ascii?Q?aFHIvyH2vwL7m/GfGJMKFX1kvq1le8zjaMQmWoDnOcZukHRqqdfaXA+iBkJs?=
 =?us-ascii?Q?usU9qIPVS5nYVu9NnRUEmpa28U70qrjA3dYaUyI1Q0gMR6XNWB4XDE2T/tSM?=
 =?us-ascii?Q?+KzUlgujTlfMXncB5pZeZI3O7JINppt2U5DHXa/FVIizzhHASrTwp0V9VZep?=
 =?us-ascii?Q?Ao3amLx6XRPjsR/1iwyJpX+hIxw2kiVaE8gysWn/UdO9zKO+1Kn2fuBgMmHd?=
 =?us-ascii?Q?hi/NfM3J4h/rraw4SegmQUL9le9iPE4T/+GO74B31Gh5+tcY0UVpGcK2dE8P?=
 =?us-ascii?Q?88Y5vPCkPoGIqYQ9XSh4+mmP39nSwN0C5I3b4QoTkl+0OjZRqyskw2ZK6MRs?=
 =?us-ascii?Q?aasRhJwTKAQZZ53OXUqq+ObdnAuL0ymMQehx/QzdKMo7BPudPyDQB//5rdDM?=
 =?us-ascii?Q?CAZlHnEV0GB0vHZUt6fBk+6gxqgh+eBkPKNZUbaw/Ptrovrzsm1MialqPZXt?=
 =?us-ascii?Q?PcWPd4csFglZK+BNhGvrf8Suj12Vkk2+5zoeeS9FgTGsjLMt6iNY3gAmJfYk?=
 =?us-ascii?Q?AyxG/FE2PwCgvHLnuLqQolnhxf3dl3uBFiidofgj44kax7ZQqcsAfXTHi3B6?=
 =?us-ascii?Q?6P8V7t/8F714/cma2xpM32c77gY/kpWqDccYMy5tN80KAey+K+DABLVmPopl?=
 =?us-ascii?Q?uixRWD1bVOqMUrf9ljuF+yM9yahwrqkrH/bSHPZ3aZiQdtKtZC6KLJXfbpUs?=
 =?us-ascii?Q?6zVjecOv5dVKT1RN6axH3t0NmAgJVD/2fuYTof6uDTQ6BO/QKUGz4kFgMDK2?=
 =?us-ascii?Q?0juL8nQM3NEaHn0o2eZsxv5zK+bb6bRgYZ8PKMdfF8G2UCRyT2qVCXHWGRlw?=
 =?us-ascii?Q?2GEVISeQi8blB/yXIZC9iGU3mR4sAgykWHplRcXCp3aBMUg7So6M4nY1JTjw?=
 =?us-ascii?Q?xKMDJVzpH6hsdpeRq8Ado41vBpnxr1W5cpWqwNtzGmmJug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea929b9-8254-4645-a389-08d8fbb7c683
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 00:29:59.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WueXi4KAIYNj0g34osPHVnoxdnpdZsZROOGaWM4jVOXySXeIHidddWbSCXFVkcqurXn3wlgiwZzdbt/Kux4KmYRK/ps3HtUIYclPwliZqrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7439
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/9/21 17:22, Max Gurtovoy wrote:=0A=
> On 2/19/2021 2:45 PM, SelvaKumar S wrote:=0A=
>> This patchset tries to add support for TP4065a ("Simple Copy Command"),=
=0A=
>> v2020.05.04 ("Ratified")=0A=
>>=0A=
>> The Specification can be found in following link.=0A=
>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1=
.zip=0A=
>>=0A=
>> Simple copy command is a copy offloading operation and is  used to copy=
=0A=
>> multiple contiguous ranges (source_ranges) of LBA's to a single destinat=
ion=0A=
>> LBA within the device reducing traffic between host and device.=0A=
>>=0A=
>> This implementation doesn't add native copy offload support for stacked=
=0A=
>> devices rather copy offload is done through emulation. Possible use=0A=
>> cases are F2FS gc and BTRFS relocation/balance.=0A=
>>=0A=
>> *blkdev_issue_copy* takes source bdev, no of sources, array of source=0A=
>> ranges (in sectors), destination bdev and destination offset(in sectors)=
.=0A=
>> If both source and destination block devices are same and copy_offload =
=3D 1,=0A=
>> then copy is done through native copy offloading. Copy emulation is used=
=0A=
>> in other cases.=0A=
>>=0A=
>> As SCSI XCOPY can take two different block devices and no of source rang=
e is=0A=
>> equal to 1, this interface can be extended in future to support SCSI XCO=
PY.=0A=
> Any idea why this TP wasn't designed for copy offload between 2 =0A=
> different namespaces in the same controller ?=0A=
=0A=
Yes, it was the first attempt so to keep it simple.=0A=
=0A=
Further work is needed to add incremental TP so that we can also do a copy=
=0A=
between the name-spaces of same controller (if we can't already) and to the=
=0A=
namespaces that belongs to the different controller.=0A=
=0A=
> And a simple copy will be the case where the src_nsid =3D=3D dst_nsid ?=
=0A=
>=0A=
> Also why there are multiple source ranges and only one dst range ? We =0A=
> could add a bit to indicate if this range is src or dst..=0A=
>=0A=
>=0A=
=0A=
=0A=
=0A=
