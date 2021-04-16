Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF1361A1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhDPGyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 02:54:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57626 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhDPGyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618556065; x=1650092065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=iT2SNG84s/fbTy4WbjfIIraFTvtMs8h5YYU4I9nWrTuqscasASVnoLzE
   Qm4dgxnjPgTNv5Z+XCKGXVR2ln4G5mGwY2/5XG8Vj2bIzC86lU8h6432O
   o0ZqB5j7gmc+lMuMzctHBmZyBCKuCbzVD8rx0DUnRYp8+lc0h5+54jIZG
   efwUh6sJowBhAZI8OB9t3Q1lCm00ywH3jIE8BQR9Fhc3W2gAKawZgJoe7
   O0rtRbaY6Vy7iHIRUYu+BVlCTSkwmJxkO/PnYDZf60f8aOaYUPpY2UdZx
   w3DZ3+aBR5L2Wb+D9AHkfYdR8ALn+C6TY5YA+vv9qooa5POcHL9N1wNuS
   Q==;
IronPort-SDR: XObSiK8eJtCESMuEYkJT66MmS/q61AfgxHyiD/rxgvvmz7tnIlBlnQTNgyJZCmD6EpNiTcIQ1Z
 gVMHJXMnNuczJRvKVpvcbDxS3wHTr8Oa2ZH9ISrgfSBazfnKYQiHciKrDV5+o4ERkflDNKykCo
 ocyYMQ8bDswq4EukER/E4fcYLR9u0OqKQxGip21HIIFdTNZLYRg4Ys1BV8OSiu0/5+b1hKYG3j
 qLFEO16XFJTkQ2o0BHnV1deCkEkZCO3KeYW12jyFjR3eIhXuoS1syelfx81GWFgKW8wmSHQlRs
 n0A=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="164435572"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 14:50:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYMP9i8hbjuxJhiSZOK2C/d3k//Qa0vtmcU4moNw6G38O3vtP6hc4CsVD8WvmFHfVtjwRF4p5pQv984OnfKrZsJxWFJQCI+o8d9XS64YypwUM7cqK+elcSh5mbQY0N6iBgup2t19HbrHpmbxcjVfqlWr8sopyVeUQ66LB/RH9m5e07iTP+mh5w096s/n9HrgfWiHQbmQef9WI7KRSlptbNC+Ukix0PbSM6eyVRr/X+ZT57eCcPOJNi8M6vpJiuXyrzmd42APWiaUYR0SAWewxdFamaBceCc+qenCJI+v835uLLJVwv2uXVZMp2PaDgzN3cbZCWLudb/YxAs0XIVchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aQDzj9CV93qBKBWHQGx5fY6Q7XzYhTXxC2kJc69RcxZKpFQXK0DUUBkmc79lAq/5Gg9bZnm3vGM4rjPRMWrOW96y4++6Ga4BcDxcSUbwZZcIh+NIT0602oOUgskPnGyYFHENGG2uXyECzAHxy22Trp4tRt4JQgg59cIoczB67CwEIVCk46AU41yuG2JcwnKKS1tx6twjegYiVzshT2qBtnQc/4t/RyjuemEZ6NDkctDAYNWEEwrq19O/opNluTEJV6kkbH2OFM8So6oKhCuiDMBPv7zdInKlFvQW3BXkXaGKScGzfDSPDnfo4JEwY+jTSJUeCmxHOJXtfAhENuqngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oOjkYc30VQjdBb9f5wZnmo8wKmiz/oIO1ifC+d1nO28dmxSFFeXpE8hUrZG4geKCxBrdAd2hdL9xmM97X/2IdDfgYHj9VepY8QnjDzQQU0R+7NkwSSEQmnx46PP4EsoY93mzjYJ0xRS/lcV6X13OFMhbbH4zVkevwbu97o5M4DM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 06:50:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 06:50:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 4/4] zonefs: fix synchronous write to sequential zone
 files
Thread-Topic: [PATCH 4/4] zonefs: fix synchronous write to sequential zone
 files
Thread-Index: AQHXMm1m7H5bwoYRjkK0xFA15aMquw==
Date:   Fri, 16 Apr 2021 06:50:15 +0000
Message-ID: <PH0PR04MB74163E5D0B2D9FFAB2AD74ED9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-5-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40b16cf9-000a-4475-43f9-08d900a3e3f4
x-ms-traffictypediagnostic: PH0PR04MB7416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB741633E3A168CEAAA2781CD39B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrDKmQYrw5Yy4sKEGHMRfpeoY0Na/G7VNJ1366PO+B94yQaI/8LpLdEkYmWqopBJWluZjrgFPh4lpnUXskwhhXjde5Mw2CUpL4Li5Qz7SfQQiYAkrzp126Gc+qJQd5ntHvGjhhGkpytHm213RAQG946l1a8hf476iUC0Z2GC2KdrNt51Vnt0b0Rko2/xLj0fUVY7mAaUeiHDenC39gQjoy3QArZ7Ob8YHRU6xr4oXWFd1bvdji7urwGhlOcAUGi5KllIOzEnzwn8GQboubmaoPitni3rgcbZe+uxecUGIDRsuT6UWkTd0M6IN8wfBm8hKtzJcRwkszEc7rQDatLB3Au944lfWnFL0aDnQ4X5JdD8U+xwhGiB7lvpqUoWRG1reXT0NFASX63QE70K4fi6JHWAbbAwMQ+4m+1gfiRXvUU7xA1uBeSA+pHR9a+Z2kZMpaFlWmfmxeeHWTlRdGrme8QIUty6FQZRGa3UOO+9X5GOqpHssPYNxipu03Z+DyhxsqkelCrFo/+s6pdWRVC2T6lYkNfamYGEGib1Kncl4kSV1onG8S94R9vdm9fWKqnAtpxuCL+z/BKAqKjUysOiVVW+Tv1LayZL8sqSW0ui7ffOzxtuJCj3+N/TZuylfL9+UxxHbmQq0lN1np1IIUeCBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(6506007)(4270600006)(55016002)(9686003)(52536014)(186003)(5660300002)(71200400001)(122000001)(66476007)(66946007)(66556008)(38100700002)(76116006)(86362001)(91956017)(66446008)(7416002)(8676002)(8936002)(558084003)(4326008)(64756008)(478600001)(7696005)(54906003)(19618925003)(110136005)(33656002)(316002)(2906002)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?11D44UkIl3ymG7H5mxIeCAv5yGiPWAXaZWo2erilNq6U+TuQWfhEBi1FVIMk?=
 =?us-ascii?Q?N9mM9tz4qADa4l7OUpaF5yjrMwP6gfZlJ2SdF+O0tQXASSFOcFgdYdF5F3dq?=
 =?us-ascii?Q?2Aql9UEvnMYv6+5XU5oKm8S8hWOWgdrwzAC4cvXtxhSAHHT4nB6qs0HC1aP0?=
 =?us-ascii?Q?L5JcjkGe8YAnQfb+zTbARnpbfw5GAqnN1YIjBPG5Sj5R24DrPis2RulTW51D?=
 =?us-ascii?Q?mxD89f1/TXd3swLW8RcYzbaZi1Qhyywge32bAbv2Hf8sDKHcJSUPVVOGhwa/?=
 =?us-ascii?Q?pa65btFLKz/fad4MG+3toxiROyJovHFnec90+nrTj7zHc8v8wHupWcL5MlMk?=
 =?us-ascii?Q?k4P92AVkq8JbnB+Sk3MUCddwDmEIShuY+xtYVT+5bvsi6aGlEQsY/UfhVOZk?=
 =?us-ascii?Q?a59n5blJoufkiQfqpjUsru96qAK4dmQyMkD+UO9Dcv6ZnFPgYWwNxcWm8GLk?=
 =?us-ascii?Q?5eaLExiwpWPZUamDxw+vSqE1KUarQ82UfoFbY2LWTWLsXO5ltanbZxvbsn1/?=
 =?us-ascii?Q?0KCsFdiVq1GuP1Eh4UTZ2UK4Lh1SCpTUlemNlTteS8kbkLhKPjCKq5PCBk6f?=
 =?us-ascii?Q?WLY8Dk2t0iSbmBFsCCbaqQ8xsiewUj+Y45oMl+Fzf9rac3C1HrURzhF40Kbf?=
 =?us-ascii?Q?AJnaifCL/I9V6QFCFK0NmuCBjIdhZrOOEG08ztT9v6T/j1z/Es5pSUvrWzLs?=
 =?us-ascii?Q?XA8Qo9LNfQVAZiSM5XWex/TX+KUB0ejD5T+2M7+6co+v6xqj2/bmFTXElaNE?=
 =?us-ascii?Q?vdCPGjDUm11np9nJwx/6LloSjWPenWlFdleU4S2eTkv4fnBTf0vXl004d6vE?=
 =?us-ascii?Q?m3abmUz9ajwo75YHaxBJtPb2bPL1rYpPlG+HzbhhGfZPXPsiTTbF2smhELB1?=
 =?us-ascii?Q?526Qw4eftUbaZgbfRqTcTzWRrikNl9VuaBSPQR1oqGernpspkRFDBOLx6hIQ?=
 =?us-ascii?Q?EkugQCX6Sj7zPIVW8cG5a/ScxP02gnfn2Xi7fzLQYC6Rz6fLB+JZc8MbJdGx?=
 =?us-ascii?Q?l3NQu6aVF7Paq7SA0D40hPnI8mkeUBfTQpfFelAqnjWm6KZsoRQd2+YCVjLX?=
 =?us-ascii?Q?G0HR+yuRtuelbvMx7d2ysNwQAnBrpbGb1ktNrbocG4riHVrFxZGbfZL7Q4aD?=
 =?us-ascii?Q?eoG1adDOQSrkN5/H6EovoNB8NdxiTeiLozUvrc+RR7tn8U7UMOzF2rRkw4Q4?=
 =?us-ascii?Q?yQfTWVUcDIOF4yMDcoXenKeyUXzHdsKrolTmWH8E9oFvVJI/uocRPqSAnfDE?=
 =?us-ascii?Q?FmThfLvys1CPKAD5YoZr7ALRyjWG6PJLwOQmBSpWRrM46tuKFkM12sIq7vq7?=
 =?us-ascii?Q?TIWvhfKOND2Xuwn9j8ie6Ey95ZRkTl6R4Ew1MRq494Wa7PKWbsRN2H4xuWW4?=
 =?us-ascii?Q?I66tSMtlUzDDNp9SirCVlwtZpsl0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b16cf9-000a-4475-43f9-08d900a3e3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:50:15.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTrJp8UjEbTCW8Ch6nnDHSfTI100ZvESwpEFUmyvcUVEti7HZXCVjOwsPpLOLEp9Q5TgvxAjudQ42hRS8dAOpmFxwcDu1tThja4eLcpsn+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
