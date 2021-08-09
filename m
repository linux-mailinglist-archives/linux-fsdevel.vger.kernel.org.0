Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12443E47D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhHIOn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:43:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5320 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhHIOjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628519927; x=1660055927;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=B7cenyg0F20pF6uiAghkofD3AOVBKwJi8dxHVoMj3kUzeapuZiDUISU5
   KKnpHeId90llpjnmHi24CDzF4NUWTMa9yoWn6xfl2QG0QNCYGLljUJk9g
   rkWbY5s8eXOjdhkiNFTt4iyDYibPvX4IQ+EDV0ntadOZm46tetE2xsySU
   hJYHotLrCMp0zPmKvMgPiQBm7tvAqr5rfm4aBoqEjWP2jzK3lOKusuxXD
   LQDe2p9NOFPXgmAH5B/AuyRF9D5bnFIoBF9iWRt/6kHUKinF/CGpx7BZ7
   M4QI+rCTG7sMCn0vRx1rkMIv4uDFk0pnz9h1J87YWsi0aweqy8LYiu8+9
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="280533852"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 22:38:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHhp8AOavL3raECtXyqjkAxWdlITJvqZFNozjf5TEMudLy/+LyYm6cl7pBYnNAKRHmPDjb/bIW1iFQzX1KBJdG2IJDtVwCy3XYxLrORU9/v9fziYFS5fLceiL+tUJ4QBE92vVnHjVAUfEyQhXgvipf7KFJnjarioV1uZv0IoiagJPUnbBrbrZRjEDwUATGws9K0oqdsym8aPFM3+U9X2004nd1ilLyXq6HiV9V0fJkxfxm5519GUdco9k7v8muioOQ+lbro3KlSK652WF9Q/lZTVDH+CSOfqqB7+f5soxd8W71kPClx2haKSx9E2ezyna2s37wNY/gRqCte/rPhqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eX7vix3kjFCCTMhIZ3vd2yyabD4ZtZKffFs91Rp6Q+SBdTdics1Up7AW/qSh5wuKh4XAHPnkzfIkTN4iMvP8PLCZ8fMQNlctUnDaF6kAlsHSjIcOeRRDibUFRSQGxkn7sKkMps1Dq8cOF4bK5LN+WqflcJf/vGfpekkYm9R2drENkOm8CUuf88eILRetXtbYNulpExNGmD1ujxC5NglnhQSDs3DSxfrMBdZtx70LLDD1E3rtHCjYkYG9U5Qx3TwqnDL6xvFf2bBtC/3DRX8BKhUpirM0elZr0lWPkYPuEe3J+vZionC1hTzEwUI1fYXN0Zo7C1435KEWi7si9eangw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kaokVoi/t2Yc7Pbmzar10pKZssWmQAChPkpovOUccp6Yfk8ijhWRaupxXR72NeV9Ja4vVG/bRD1IUW3oD3jO0WA4RUdDDktBJRAZejITP6i9RzuZis3u6H9lZSEUj4Dn1PZNsSS0cgXbl6yETjE93Ebi7wFGAZTLEEROTmeaGI8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Mon, 9 Aug
 2021 14:38:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:38:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
Thread-Topic: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
Thread-Index: AQHXjSl2W56sxLOLXEOyeYDHgXgcpQ==
Date:   Mon, 9 Aug 2021 14:38:44 +0000
Message-ID: <PH0PR04MB7416F6DEEC0E6FC1ABCA3F4C9BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58c4e204-cbb7-4ef0-df2a-08d95b4363a3
x-ms-traffictypediagnostic: PH0PR04MB7176:
x-microsoft-antispam-prvs: <PH0PR04MB7176CDC92ECEB321C4634B1A9BF69@PH0PR04MB7176.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAkIVRQQt/XsIiIbL+Ttn4jXFM0rUNWXusKYUO9/YYj6Y4BPowlz6m1q48GlQJVi115VEZ0u9AfEz55YyyPkWpVh/6sFPE11h4krFG0SLLWO54FYqeX0jJCqSFe+Zo2l/7rRDgjaB54nuNW541mtKFy1KPhTem8E5D+7dT0DnS/X/9C+50pbXw+PpwDoqcvGl68HFQLwTgol4DdM6V6VtedUPlVHozzCA870rn/vu6n6Tv+9hOoHHN8fLkVVp+OthXRA1fTTJ2DLKrXot25Ot92mh+OfPpVNYYZldVLmrgF5+P5wsLKmNi3hrl6vuQ4m2J7CgDW1x9JKR1maDrblsVQs1nUPws2vyK5yrXAHY1MH+Jx5h2KRtwXdLQBn4ogNBtbyN3SUDPEPRJKRi5hpttRIBuAzgOC9+maovOecw5zu7goUDOiQpgetOu1pPJ6StmerVRQK2qiKbDToZ5EZ/Pf34oa1IRlJzHJ0lJfzPk21U1ixnH/GzBu71wCKOMVhiUSzbzC0ITc2NAE41F/sbXhqiPjoJy6qBwqJtasx1xVMQdMP6fnualr2tzLy/oPWSLpmH0GFEPY0qFDQAczse4VRfz9iNo02eUlojIV+5G5WN+9kdfwcVYlZDHa9AisapvrK2HyGIXsROajZDyF9WNv9Sn8ouguz/2s1mQpbyStYWCQvsw2RMJL3UHRTvvEYBCyN0gKwnueNZuSPJ0ninA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(2906002)(7696005)(4270600006)(52536014)(19618925003)(86362001)(186003)(54906003)(55016002)(33656002)(71200400001)(38100700002)(66446008)(5660300002)(66556008)(66476007)(508600001)(64756008)(76116006)(558084003)(316002)(66946007)(8676002)(38070700005)(8936002)(4326008)(110136005)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GLWAxrG1L5sZOEk/n85higkHbg5+gjpow8pJu9W3gk96/aNpH5b2+XqIszPd?=
 =?us-ascii?Q?5YneHB5FoiP9SFghzh3WXZMO+Tx4w74Hf53B4Vwj5hR+MGmiuEpsJMVf/cA/?=
 =?us-ascii?Q?Mvst9IrFSr8dx2kTjy2bdpmoAnFgc5NQQvndTAAg/4Zk6ux324qF2VNjIc++?=
 =?us-ascii?Q?ksK2AXrlludbHLMzjcbNhCyYsx68mqO3Hnls4tbMElhrIeN0V0cvKA+K7aT/?=
 =?us-ascii?Q?j12bwyme5wOSaRjbwrgOTLqPYC0FJEdXT3Yqv0QfKqdew8VKke5qqIxhBPvs?=
 =?us-ascii?Q?K0QYFL3uk1DUH055MdwbqTx36BR2HTs8/TZjYp69fFn1a9LMi2+NobsDuh1k?=
 =?us-ascii?Q?MPkkDzAd3Lj6C31ozwdXzWgZk2Vk80Ik87m/TF6leQnff7JUluEPdWTSwfkW?=
 =?us-ascii?Q?pJykDHrC18XcCYkdGn5GLsaDnyLv93HQo4ZJdWhlT420h6XFjW/su6EKBbui?=
 =?us-ascii?Q?1t1/Y03a5lXKPRw20kN5md+7eluibV36wdCP2nKs866/FChEN4aYrD3UYxKU?=
 =?us-ascii?Q?f5oGAc3A/7rBypBNwMd5kwrw9blvTi4K9FGQit000lt50O3AieykOY1fEQJc?=
 =?us-ascii?Q?Eio9AKSs7QtkXsaGK3FHjY6LJoQYNwOoP+Zfy8mXKbSovlyA0fvZA09xT4hN?=
 =?us-ascii?Q?AAnQZm6SA5eZqbFCUP4icwY6pvI1YERb6Pgu0W3d08AhXg8KQbdRs4Xf+zrF?=
 =?us-ascii?Q?TYhTvebq/jLYQG1MTalwEDmc3NY4pwPfIF+7g26LYVLo1boOCgrKjK7jDr25?=
 =?us-ascii?Q?5Thhhy3AFaARp0ZBhHrgpPrKJBjDlGORJBodms2etenFJzdP9aEwS2IK2mho?=
 =?us-ascii?Q?lmtlSP+yTL5uX93ipdvAaVNQPUOdUHceaoSlmMedjf16b5lYUQUjkteKwfWB?=
 =?us-ascii?Q?BDSFUL/WWNNmmFpuVuEFzEjaVbCmwxhEJ+ZEqS0/lG6qHHfSOjZCJ15SbOai?=
 =?us-ascii?Q?oclp0+3P9WUe+NsyLThQoLNH54ckWssIfcos4WgHQx9B0z3rvPs8dNyB3TVt?=
 =?us-ascii?Q?/c6ZBut4Ao0/hnS2YJrGMcge0+4z8jqcxlF/KmXfscsaaZz0hDoBpG+OICJw?=
 =?us-ascii?Q?hgd4NqZ62cdmYkBDYhAqFRUVOikB0+dabwV1tEDleKDAFDeudUOcF0YoDLrO?=
 =?us-ascii?Q?EqDNeFW7ixhT4P6Mt/TSrpQlldjT0MHi+cAJ/thRM3lQSd2k4W3Pzw+pZGdX?=
 =?us-ascii?Q?ZZBvjopPHojkTvGgO7mFufJAlIcqCy9ZqsmaDTNNalkeYZAkj/5y0wEnLOK3?=
 =?us-ascii?Q?htMWShnWNfx0v/uHxBakRXFAXlh2NGWhBnYB0RG0mhet9/ZAK43Yeeq7o2J7?=
 =?us-ascii?Q?3dL3dD/keEErW34X48Ej4XXCXnBwjyr0tLZBXtwsA3c2YR5llWUVBKIsRi97?=
 =?us-ascii?Q?OJEwbZQxebEHxOpKTe+mO1j7uqr3X0s/dDRY1KjeAxFQYzXkYg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c4e204-cbb7-4ef0-df2a-08d95b4363a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:38:44.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0d5f/I2rLzxj1ptT78UHzRmRwpwv0mrSEMGyVwD7jAZkI/Z9HV+vlwr4dUHZz48v4wtGHRgTVoBzBM2BEq1z+REz0ybgSbz4V1yRq3/sM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
