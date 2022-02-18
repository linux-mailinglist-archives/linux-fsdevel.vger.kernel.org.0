Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997B4BB1D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 07:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiBRGNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 01:13:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiBRGNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:13:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35F26106;
        Thu, 17 Feb 2022 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645164810; x=1676700810;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jsb7fA3ZNxSjmealNBPRNrZ7Ni72Fsa7FjrPqRF4Wi/bnWuFWuddfabS
   xUTZ9T/s9BcIwDRoCMww89t7wv9CTMqihtPprbj4sRmZFED9377ZTVDX3
   G/ztnpgYhlrWhe9rakN5/Zg94qgZiNNPaE3TWN1SJYgBPRPQuNZAqGqPN
   DV5j4XayMgETEGLvArNn5UjplexkAycWjS6/s1+L5g+OId9Wv5lc6UnKU
   LCxG07LP9h8jSbQltgOnBHi1qF1R76HDtL5OR4PpqKgMWebCtWc146qkW
   e4/KkKJn8XrYrjgX6dSS9J0bUjNQEw6oFO+3ZLanSmM8GzCpGb61xC/sS
   g==;
X-IronPort-AV: E=Sophos;i="5.88,377,1635177600"; 
   d="scan'208";a="192191276"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 14:13:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewq5AnO+z7AUGZpP3EfjMimsTfK9dujOWexGLmf1aZOoy81Er4EPUKaxWuSKTygpv5zLvhutjBX+Fw3DUioZw8nNsn4+kv+K5WctkxfamOu40hpvqB4d7VsT5JYUXupXCPcUMb0SyghEVOw22W++pZRNE1uQCGc4Xlq2D4TKu/6mwTzjCVv2Pw+pr+8Wmwc0KRsG1O6CLdrEcTM8Tp92dxxyb73dNAr8NAYejleXynF2/w1Y9CdQ7GkmjZUtAqtWJtfJnpw+GnP28oA+6JeOjpJVp2epKqwwNkXtX388c1MbOss39dQ0B+sdiEY2jhib+Z7dYKcpUVWY9nQtQ3OrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UFkLaNJW5HDTZtbEVE/QEJw2akwDx/+AMHVTlDbW92qkR+kZZ67DwsW8WDK3sVLbrO7xhVnrCFPJ6T5qiewmoeO6oe1w3Iy3WEzNS/CqrZct1Xq2Dsf1gh5D0n/dh9CNVBL+GpKxXP9B4hBYyhNHFjIQK0ugD77O2nnhMbOYLAKlHojc9jPs27u9EVyTDEMdZnKqz4Ja0LEooa8PmNctyclwRIRYYo0R29IBODQ0McLe859DLBO6UdkGD328i3GBW92U0WfIg2QFd8Nn/XEtsUZI8kMPXsxvfy2m+Dg0L7kbv2CHTFL+n6WMZtCAfsC8vSYopN49urhzmMrulQN+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EmJioFvUjLHcbCPT1F2FyQLVzFF/YkqUVmE1At+uFQjwcdU3eY/F58Ka4AgCF0zdxNsbhXqio5tsWGBqqh5dkuHX2Os39aMHiOKLIGLsXx0iGEQgABDKbWArx6Vbwhf7VZmPCgFKrTzjlrdZiaffnpr/+WGlrfDMaS5HX73iuHs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3860.namprd04.prod.outlook.com (2603:10b6:406:bd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 06:13:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 06:13:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYJH4HkkB30IeIdUWNcRGB5G+lGA==
Date:   Fri, 18 Feb 2022 06:13:28 +0000
Message-ID: <PH0PR04MB7416F34B00E8B7FC8718F5179B379@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
 <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d93d9802-1ed0-4853-88a3-08d9f2a5c791
x-ms-traffictypediagnostic: BN7PR04MB3860:EE_
x-microsoft-antispam-prvs: <BN7PR04MB3860E8560FD8933AB9F58E5A9B379@BN7PR04MB3860.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8fauBCKdCvhvQTMD6gIsN8x7/L00HqRIL3fbP2Owuoth/C+4ryJ85WBmT1w+tFfIWpeSA6Tojaeua7VCgxQi71cLGd5SS70C0G4zqNz+oiJ+21q7xb86qR8ZyjRSLXZGBa4uMfoFX8hl5r/kHjZ2uDoLH52bfTyAtih2P7HvxwmchBo5HH/7xbGLmmvcSB5gXQuVjg08R2X78B1HfBSpiXMW4VLYKsCEDxKWIL5HE/L6IsGONVdu0xggmpbe/b78U78t9MlryvB+rh+qUrJgQksqnlddCmRAZPDgOX+fGA0fC3OychQp81Y6nJ3W6JB+PKc2cWbMk7cW958/4IlRLD8+kQ+k7Lpd3eBtcmjcM9jPr6AYaICdi8ANRBuwlfthomeewkRchLi4yT3dkTckDDUtzqMQfuty6lvV5X2KpYAj8PUPbeUZuC3+h7oT2QVqNhujYln++DG1H10awiRTwYYu9Y7oaQDjoSo4Wgg+IphFaMn4tqcvRnyM52MdY3DT4jiU8esxWobCXG6TX8ga29Xra/ObWO1WJnk6Ts/8QArH2gcXT8+uVx2k39KJcpIMqf5ZizzR5cehvhrSVlXRCWg2yGYnSCc69886Z1QtyPFG+X27rk68qyI97hEQGkX91JSwOrnvYzuQESx3U4hYVNf+JNBY3jXgalcPHjUN67DqyOxKv+FNyb5qsPtNPAwi6ohenOSXyJUkRgCpUvMKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66476007)(8936002)(91956017)(2906002)(64756008)(66446008)(4326008)(86362001)(8676002)(19618925003)(66556008)(38100700002)(52536014)(66946007)(122000001)(82960400001)(5660300002)(38070700005)(54906003)(186003)(7696005)(9686003)(71200400001)(508600001)(4270600006)(55016003)(6506007)(316002)(110136005)(558084003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xg9W/WZQIvNUeNugr0Y9IaklQeKZA4TMr5okooYd92nc9hf4m6tOuDXHwj97?=
 =?us-ascii?Q?bhZdYwGgRfdKt1/R1unBnTG9XTB65KO1SAYIGUNpvlnpUwY5x/TLZU9E9ARi?=
 =?us-ascii?Q?oBbFQedDP2Nuz4mWbIxhPHvmRr9N9PDCEXL+ZUM6Vfdtghi2l3MMndiHuq2W?=
 =?us-ascii?Q?HlPU7mT1WVea5SYKyP4tCOw9+AfSlmkBn08cZLWC5EtMhICAjeNhDiJAvegX?=
 =?us-ascii?Q?GCCev0B2zJa9NfpnhAiePnyBRcwCF3e7TuMx131hXsJ1PQX9Xr+HTm5vX72H?=
 =?us-ascii?Q?/zuaWJWfI1k8rG931YIxoneHE+Og8ei5rc+Q51zBLT7LuPuWMGJAKkq/tTXL?=
 =?us-ascii?Q?U33FJtzYb8D79oHY6wPI/4TNxoU2T+tGwVPXCbZ+YIt6seHNgpznMchU0H6o?=
 =?us-ascii?Q?VRvqvyhjg0+At+KvkuAoA0lV7ZMwrja1Smtqy5NYj6tHsRj8G7BxQ60cmHFU?=
 =?us-ascii?Q?sya1c9ATpCmp2i1hacjssSgOWskHBTjumoFPino9GHiEfHH9zT8RgV4HaoLD?=
 =?us-ascii?Q?yqMb30vTcz9DhiysCz//ik54CLD/WbHJ7wLaLXUwiyZcMQL2AFBACCBhiZEp?=
 =?us-ascii?Q?NKVuegCu5DFr8ChGwW4JcpLVoL/c5x/4seS0qqAgHDaVw/GEW3sXil6zZ8VL?=
 =?us-ascii?Q?Wsii5BXlnplTsE02g6XAOUrqGWTBa5CDf7yrWQCh+VvkOM97GYj6hQ4M/FQY?=
 =?us-ascii?Q?TMBmNDplD9v041bnqWhsygXNmjJ83TIwwyMrVJoqT65TVqL5IGNvNqCkOhGf?=
 =?us-ascii?Q?1xk7QmkSSqdzQ8fXq9bQVpS5ajAJiBK4Jh2rFtI+F1Fryimg8z+TQYqBEodY?=
 =?us-ascii?Q?DsuAcNxX8qMlaBBhxsRVvy+HUx7+yFVwA1yO9nBAII1Dh4h/V75I7WP2Kr+N?=
 =?us-ascii?Q?7R1+Gwf9hcjYFau0G2PBm9ecyctctK5CeS9T/UjlYhEDAoQ52PnA1Wqwp0d+?=
 =?us-ascii?Q?TeemTZjhCDkPQSE7QUAz2NBRWyYGkPUpK+HQ78cqhOXGmx1+zdAcVy+3Qd6I?=
 =?us-ascii?Q?c9qPMLS2vP1s3iM+ENhNEH0Ux4iuJxdQhouqsMBMixtrG9QMhsXAGIVwWzj6?=
 =?us-ascii?Q?pOFG68auvrUd7ZSj+AwZgc1eU8I9wZEILjgMKznuL+eleoprpHfMI1Bg2r9M?=
 =?us-ascii?Q?QtOG0Q9XhfvXUJuAoU3QdIE1ZuUhlbF3ViC3ReEgIICAasZSuLqyG0Gp7MzB?=
 =?us-ascii?Q?YyV8cmGK82sL+5KfO/7vwIUCNCiW2GOMNFS0ve4yMhPVehV7nYStlu/3Wt3s?=
 =?us-ascii?Q?0Fpf2GGElMnE+eydx1t52gy8SeulK859LV5epMup0+dVLbhqtv2+jP82EWL0?=
 =?us-ascii?Q?5VUCLE+8Mn75GoCX36o5eUlh5Ckk/1i/OIVlzUqFq5/uxRi39dc0LjBHCWz5?=
 =?us-ascii?Q?ckaAFBf9LTkapx3Bwdb7RCRJbP6AlKS9GdOqsJaw3xC//btgViuq9Ktpf6+N?=
 =?us-ascii?Q?Yr6QID8sTQoSM9n+04iYEta8pRKGgyTm0Yu9qEN5Kia7IDBxnteDqNJ/a0lK?=
 =?us-ascii?Q?nFRyQX70lpaLV3baWdCkdrPCINTx0geOgTffqV4VRj/64Xh1M8DxJjd8Qipf?=
 =?us-ascii?Q?pF1/DfJHZPCU014r3lvSNoorXAFRAFy26e2DMW0nUEcQGX6063/2iCIf6X2L?=
 =?us-ascii?Q?hS/loE/ivGyLQ6ywG87CjFSkmQU55QJiJn/sLagL5Tn46yt7Ux/1/RYTiJ6W?=
 =?us-ascii?Q?HZ5uRzOecE2d8XQCG65p8H1hVD1r9rq7tni2rBcGNZtA/lY4X45XrIUjnKae?=
 =?us-ascii?Q?CWGasuHPlSq6P8HKl9W3xNRyRmb/Lic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93d9802-1ed0-4853-88a3-08d9f2a5c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 06:13:28.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hskv0MD1g4WCRAjJzSEj9BL5qoZLHGJuw8GJwoqnPlguTA7VtzFtPmCbhWnbMY28g8um7pph2cljhJ9LXcxiwN61dazcpJC7MlSV9zor8RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3860
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
