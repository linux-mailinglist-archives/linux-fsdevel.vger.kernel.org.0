Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010C2229203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgGVHUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:20:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60015 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgGVHUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595402421; x=1626938421;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=U27WCAy9zaAs2WpMTz5Jje4K6BBxzqY/xNd71Rc+jMSz84eYh2hEL6G1
   CdbLjgMfCYBzHGhEqOpJ9fs2wiVJv7oFF5VqG83SxSUvc50gznb0Y3pgh
   z8QjQR//V9sF92vWniIZp3Zrg8BPBlwkCYgVo8CT6kCuff8ROz3GxTaQb
   SRVwIpavnYh45iM5vQE0El771nB1T2Y+mryW2gMGp8vvfKKSLYCn6awBN
   LJbAksFUUVyq4m/bpcZMl6anWBweXDBxCrdztz+xNXJjHbX32iYrwfpxP
   9U2GPcaHWASzR6kDHsC+q+5UQaX+JEZtp2hQiWwbysmG0N903c3LxNPPn
   Q==;
IronPort-SDR: X/QBfi9oXs2oNzvdjBDNnaSbKu0sKJMDEpkSBxQVvuYugvRnjkwZVLriexDuoP7hdfcgOZzSx6
 txe7hy4mHx9YSrwl2kAPb07/v+9geyDn/pNZf7shrCEuIGM/NL2emjUtFgY/hfMCJQ6XhajPXJ
 qOb/LQD9hdvirZPXBg0RR1474sazrVi8jPNDbmByv7o/ET+dr4R2qoyeptIy7gYvmx2R1Ip3Px
 MczbKlcxio2bcqllKzCJYjZ7HQkImZBDEjgVVxUuDpidSB4Ji4moRagA4NMnWpdSBOaeXtHRTT
 TDc=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143089024"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:20:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv9C4sayWAuZTuUghXVjwdLu4Alqd68t5gOIJQ6CUeAsB8S85dhstxG+MuOSQWsLgK6QF3F/vHg3vOrkL6IvNi6QjyN18VvdvLuJT/846t2hxs0jDRYhGddGs2VOF2srbbIw4Kb+qPGn42t4AyoaulHZhfKnETO3S7iLAqFJispGSaBnZsiWvPKSzbsBCq13OeNbQCK7BSKKxFy+im+ZK7LkWHqf/imKrRc0Ig4RECBHxgQhiYWMlG4NhVyGU8RV1zYOvi+lU89mPCJxZNHIWN3R4e0GokuZt+NtAkGxtCXs7keobtEZPX4GF6rEODBwpHMGJrWCDdyO34VtMU4nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SS0pJoMtT2x8NEka5VKwqdHdWaySwaxYsqpUrjUdY6UFPA8rK9TbCQmeRFbqU4ywp/KSiAkCDD3bxwvh2sRo3hFbf4uclOHkgjOOnV797TLvlquPCdT+lYfgzacrg2EBIqE0jFPIWlLishSvu691wZC5tpsnB6bhmocpgYnyCPb1uDmTqW7BgW0HMSb30YuzYsgjVrWsMeEnqSkLM6IZhGSPLjPk7u5w6+jcWwj1pBUFTABjW8cEfON3H2D+wTMfjCIBJeK1tHxvQD19/yILgsNAXU2nl6M+eOg7OhiLZ1/UbZ6yg26HyBdiNwXwuUxjoTRw0Ticns6v1xg4ffvvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=w79m+DE0Oyhzvqtk/pHHEEuIOG0gT8Xc6tBM1l9FGRNCARQmr6Ckn3qPabYQnlmHJz5hlYWvkMprtfBvRmbws8BsL1mCcVdjZWHth1PH7bARfQtBjLR8JjsRPiwKz2eJWfy6EoP2jIDDR1DYFPQAt5DP8Te9Wz8SUyWchlV3QVM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5328.namprd04.prod.outlook.com
 (2603:10b6:805:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 07:20:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:20:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 08/14] block: add helper macros for queue sysfs entries
Thread-Topic: [PATCH 08/14] block: add helper macros for queue sysfs entries
Thread-Index: AQHWX/E6SMPB6kgBPUaskZWzXZRPyw==
Date:   Wed, 22 Jul 2020 07:20:18 +0000
Message-ID: <SN4PR0401MB3598294D373946F23B521D0E9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb0b06ec-45be-4edd-6605-08d82e0fb017
x-ms-traffictypediagnostic: SN6PR04MB5328:
x-microsoft-antispam-prvs: <SN6PR04MB5328B9E9862809E1DA6C145C9B790@SN6PR04MB5328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TX4ij0rdNFb7KSO6vRl1tFUjA9Dg0oQNIaD3K6RkI0euOniyvdiiiSutx1IVwB1oxtjXpiMrqbCQG2+o1eQYyhCUHsCmFJEu6XftayBTfSryHtmUUzGjvaPsfEPZXfRDvGomfY6ipjcTvQrJrNiV2vhF7wGd2BaZwik3p4N/kHA/gpwPJjC58IW45YAlva/YAyPbvBNkavyoXWsG0fnYgqzdFqYdneHJBOBX7eIqq4Q/CD2BGmPU/F6KANpWbw3JXzc7pjywDVv52acDGvY3LGFlVJG+64D9lPwjQKG79vUPHJQyI/FC44SGtY3JY0ouxz9z5a6ESELqYOA13HSegQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(478600001)(64756008)(91956017)(7416002)(66946007)(76116006)(66476007)(66556008)(66446008)(33656002)(2906002)(19618925003)(7696005)(6506007)(4270600006)(55016002)(558084003)(4326008)(26005)(186003)(9686003)(8676002)(52536014)(86362001)(5660300002)(110136005)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uxkebodhmSxir3MbaHc4mgxd3LNWJq49AlIYKwNQ7w4Xz8FnWPi/9Yp1akLDh3pK+CoaqYLxJaZrMdL3uQo7PjbxvdZTuybC3vz/wCtZ76RLMPXTuxBNRegvaztz/na51K57xXELrcdzUAp6TI6LUDlRpPgnUUV9qaJ5hevPQAH2H4VPnJBZkgPmhigWxqcJRJfVAdynXRO8WTzl99sWaLrC7QJ3H2GAiucK+UJlx7GcwLgCTTRgQOLluHtm9SoJ+RMIxHfBDICXRPxDQjM/xZgjZV4wYDFCVTXwT8vHUY8r1IYrjq2gp2H/4o8UqF2d2nQ1QdbZLxI2xZWl4OLQH31tXedCe320SEh0XZKr5/tds3zT7VF+55UHIkiHHlHd5nuf755bLMPdVhfXT6MWzj3Q7vizgs+MZFcWiONo5GMa6a/xZ/oM+NFMOryXyIxRl//q7eRsTmLjGFalmunYw5Br87eOyspaxyf4AZVDtPL2NPCBAbxUoVx5O6hVKEAV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0b06ec-45be-4edd-6605-08d82e0fb017
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:20:18.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYhn7lcWKLN+WIysS/xbEyEK9O0zI2quM3KrmzBuTvmyr0V4ebcNx0bGoyEr7IrI2UqHlIRKNXc/sP5k3AN5At1FdXccLUzEU9JvbWk0J+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5328
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
