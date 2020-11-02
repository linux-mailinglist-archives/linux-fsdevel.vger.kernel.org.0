Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F662A3413
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKBTby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:31:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39291 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604345513; x=1635881513;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=soz2/GXX0wYRM3cea9aZ8J0oa1gac1vpMTZtcBH7NCo=;
  b=GM22eHZeeuK/PV8rxKlJwQhTgI/abvtP7IXKcNVUwPM2wHI+N/bSmRRF
   xV6oD1LXWMUXkIMFQm6V4iYuHaflFYFX/pq7tDcMEqat5WfvVVhI5D1fI
   yAAbPbd+lG6RXIJU/SUwMyJq+TO3K4ZQMZdItREqeDMylARXq4nTHtC9g
   +QIUxjTYF4t6pqWpiXL3353aVaIPnhpAnkuw24D6G6pouu74zoSsqlSiC
   BEdLUBe9hCbxbZeAFo3qmaunMt4e04rRT9uyGMcz78JhoagH67HUyIkGe
   kXI25HIC7/IrZRQugszNxw1Zpsc1/02mkSLd+GjLL1AO6LpRV97j3w53E
   Q==;
IronPort-SDR: LIw8n+/PiGod4EvhbzehXm4rGWxAXO+eH1GulKHCOP8W9MlpMqzG+tkR/L0oaORSAdZjOKJtYS
 mm2Cw5SUyuZtIUtpv0Gc0QbKBGfcRj8YJ37KsFyPJF36cSKZ61mxxiRPBK7sFNPvUn/CAN688l
 1fwQG9XPNcrt8kDzLu/rJn10wGsFb0JERztnR4UbTk6wx+INc0lpNavXXxdHmy2ogn745rI1wB
 mGjfEzSm0+2mCGv2i9kntxgzvdSK+p3SkQK5vvzbeN4yF3ju6Ooh5hmoSEnOirwa8fdFwHsRMQ
 QQc=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="152780768"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 03:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUjQP8HBgHSWk0QPX4hAb4OFGp9q+0I1YUBHOQRsIseON9vfEDHiWDAE0/shQ1/YlpBOL4KNjkvOIBTmF0oUWD9Lxf6O2MW7wPw2tnj0H3DBlXm0ptVehvgFk7XyEhcx25QOnkjGVoy/l6PvzOMLp+1Uk5NnaitOLtVae56jVeTp9jrI1wgYeJW905ttqmLgsbU8BFYbA7Ky7uFtvEpkp/3PoiEuipSd4iKnDjgT2wDMsgoBG2Z1aWgm/Kv/kGJxa09voUJFDnuA6ccJws+7l4IPVJKYiJngBGmpNAL9lGZYOqFzxVF2Pfe+Q9WbBuQqipADvyjgB9jS51sMjAJv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I747a4ZWDGH9ryqdOecQ6iXMUO0SPNpj4+KBkht8DAA=;
 b=YpImCRywCEFXmyKv4h+BRvnUhQ4/RNizPF0u9gcp9DjH0JMChLmJl9bfVABAx++wEyFeUKplzVyQE7Fd7gt5DyCFij4jjiTCOqqYvF/Ax3nwniMwuMNccRVLpIuVPnWpkG75Pwl55zKbm1iIQp/DCKsqFuQlhrwj/NwnplHlQxmKBHCgLIrcrsvSCSUH6RAXFgK77511IzHpslLtpDkgITzuz0UPqWtv05gl0v+GzgfHA7X3p+jN+rv+IZtMFHtPWyV9DGgZbGmBiIFqmz/KhZ+xWNgpx14840b10froxISzOCb3bWut1EF+K8AgX5T5Q0b2QayBJ8GLl+ZgbZ0J2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I747a4ZWDGH9ryqdOecQ6iXMUO0SPNpj4+KBkht8DAA=;
 b=OIqdqqHjYEFUobUwZftXqRXks+LIpLchAWMPKxf7sEPnkP8VHz2GazEEjjLCQ/yoVEyZV1JUSwdvX5sjwxUZcnFK4YnD+4GtLkblLTzEUP7FoDD8Pv6+vTBaMMG439b8UBRYpXc8aa9Z8JpMHFGtdkK19JDIpBUvdT/0Uwzkx0s=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2240.namprd04.prod.outlook.com
 (2603:10b6:804:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 19:31:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:31:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Topic: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Index: AQHWrsP6KGClmxP82kqQJxWMXgFaaQ==
Date:   Mon, 2 Nov 2020 19:31:50 +0000
Message-ID: <SN4PR0401MB359896FA522CAFA767803D779B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
 <SN4PR0401MB3598937F8C4499BE687667A89B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <65e72221-a9a5-f1cb-3fa5-5ffd98e45b2b@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e6d36ad-6db1-49c3-bbfd-08d87f65f25e
x-ms-traffictypediagnostic: SN2PR04MB2240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2240B9E66196531266F8A2039B100@SN2PR04MB2240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/nIga2TfHUYT87w00VtSUzhVAju72YTzFBcOd/hagZqKjDZCC3lC9hxzlmBHk9cXxCcWPgKkerVd5PaFt2KawuZSLWgIC2OFajtfRtezQ0fioFyyhOwLJa4QKW837m+NIb57RU6cJ7IGKPu6PUqEmkQvN90/TnhEIceZ0tWBcfZ+rxyBPcZ0jKrfqP+xt2LPIiVMa4MYgCw4Xtfc1uPglti0uCQzdalVXuxesSZ4fzJNDwPTAqmCCk2h+f0JKAVm52FeFNnvbpfWApRgAbC85T8c2pUYs2g5eZ0NJlvPTmQ90unBdBb2TndPpuWBV5L28uuTih7jkSnw1pwkOdH+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66476007)(66946007)(76116006)(316002)(4326008)(110136005)(91956017)(54906003)(83380400001)(66446008)(64756008)(478600001)(33656002)(55016002)(66556008)(8676002)(6506007)(2906002)(52536014)(5660300002)(53546011)(186003)(86362001)(7696005)(9686003)(71200400001)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QCgvnsmlK6yAm5BbQzumwgMmX4JCGobrNlHVyxHeYe/lw+q/RZmfefRo/+nd/sN8h6fVD2WAQi9oyXcUdTH9cDTdbDjKMe9ZYP9cgBI/ao0vJbUBdyZw7fk8i3L93RAS42ZRvwqQ0xq2lNFVkBX+H7lhp/tn0+g1a3U9OJsTEAoP7sfvPtgTYg/7FVVmTnkMKDo7yfornhJZwze+ejEbcIMgtBXfkD99YWgdS3H69oVVKvM89Y9TLgTZVeXPAcmzNzD9voqZCFxxqm3LJtwP4q+utR4loZKJXXVI5el59fykfeNNnVVpqOa4mH1pQ3RKP4W9520Pfd1wFMde6wGkZa8bg9szSuOlirBHsqhxuOEZaYU3Whe8LKKjyOYbeZSgnPGegYYgMngGlbFLNVLTKTrp8Fc/wXF0ZcO7yR/6/P1xsgsM1HY+T2UCNyS6t1cG1zmeGtnTwbZseDe03XUxbwdD7fIQsuU+tKLfW9nyOWY7T44pykGLd1/MbtJ7KjBCePq2YR/wp4gyUBzSdWPgu8a6pQrzBYSIHn+2S7iZqrrj7Kph/g/vNWv4hkhz6h/unQrbsa+bL0L8/V2BsqGIgrbkp2gkvMDnTuGGfY2CHGP06Ja6qWYSwl+W5b1jK/tC7dtxq8aD96zLfcrKj8yR8A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6d36ad-6db1-49c3-bbfd-08d87f65f25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 19:31:50.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gchwGjFWLYkLZizaAFoIf08Yt0jMP9wBxpIQhMOD4VIQW5MqRndycsyuTQOqghlTzoWKvYt2jsRBN78eTy7nyDE+qHVymRM96NQLpf2VJ2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/2020 20:02, Josef Bacik wrote:=0A=
> No it should return nr =3D=3D 1 in the single case.  This maps physical a=
ddress to a =0A=
> logical address in the block group, so it could be multiple, but if that =
bytenr =0A=
> falls inside the block group it'll return with something set.  Hence my =
=0A=
> confusion.=0A=
=0A=
OK so from my debugging [1] it looks like we're hitting the !in_range() con=
tinue=0A=
case in __btrfs_rmap_block()'s loop.=0A=
=0A=
But I'll need to defer to Naohiro to answer this question.=0A=
=0A=
[1]:=0A=
mount -t btrfs /dev/nullb0 /mnt/test                                       =
                                                                           =
                              =0A=
[    2.189080] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 65536                                       =
                                =0A=
[    2.191168] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
5536, 536870912, 268435456)=0A=
[    2.193068] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0                                                                     =
                                =0A=
[    2.194603] BTRFS error (device nullb0): exclude_super_stripes: nr: 0   =
                                                                           =
                                =0A=
[    2.195973] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 67108864                                    =
                                =0A=
[    2.197378] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
7108864, 536870912, 268435456)=0A=
[    2.198382] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.199160] BTRFS error (device nullb0): exclude_super_stripes: nr: 0   =
                                                                           =
                                =0A=
[    2.199871] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 274877906944                                =
                                =0A=
[    2.201030] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(2=
74877906944, 536870912, 268435456)=0A=
[    2.202088] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.202864] BTRFS error (device nullb0): exclude_super_stripes: nr: 0   =
                                                                           =
                                =0A=
[    2.203549] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 65536                                       =
                                =0A=
[    2.204621] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
5536, 805306368, 268435456)=0A=
[    2.205590] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.206394] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
[    2.207078] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 67108864=0A=
[    2.208131] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
7108864, 805306368, 268435456)=0A=
[    2.209111] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.209885] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
[    2.210540] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 274877906944=0A=
[    2.211595] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(2=
74877906944, 805306368, 268435456)=0A=
[    2.212620] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.213388] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
[    2.214076] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 65536=0A=
[    2.215079] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
5536, 1073741824, 268435456)=0A=
[    2.216039] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.216801] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
[    2.217491] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 67108864=0A=
[    2.218548] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(6=
7108864, 1073741824, 268435456)=0A=
[    2.219537] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.220322] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
[    2.221020] BTRFS error (device nullb0): exclude_super_stripes: calling =
btrfs_rmap_block() for bytenr: 274877906944=0A=
[    2.222150] BTRFS error (device nullb0): __btrfs_rmap_block: !in_range(2=
74877906944, 1073741824, 268435456)=0A=
[    2.223165] BTRFS error (device nullb0): __btrfs_rmap_block: nr: 0, *nad=
drs: 0=0A=
[    2.223945] BTRFS error (device nullb0): exclude_super_stripes: nr: 0=0A=
