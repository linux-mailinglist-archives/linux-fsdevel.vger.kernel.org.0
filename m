Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1423A7896
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFOH6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:58:20 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:8254
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229781AbhFOH6U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Vm+UCzlk6plqw5RPrAPwgg6lj0AJ2gk5QtfIeo5aM=;
 b=HS46X1xsVNb0dPq02GCO8HzM+Vroyl/RiyXSDiAAnH0wzf4JOyP/EryOzpczsN00irFQnBROnN3Pc6MjtvqYi5DjvCoXRZz068X5cHmbRq23wic/IzebqqEz5o0UXm5XdrbLb//DknTKKkdxKhciwPi5VTCj+D6vmBBf15wSRzQ=
Received: from AS8P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::15)
 by AM0PR08MB4964.eurprd08.prod.outlook.com (2603:10a6:208:157::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 15 Jun
 2021 07:56:13 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::23) by AS8P251CA0002.outlook.office365.com
 (2603:10a6:20b:2f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 07:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:56:13 +0000
Received: ("Tessian outbound cdfb4109116c:v93"); Tue, 15 Jun 2021 07:56:12 +0000
X-CR-MTA-TID: 64aa7808
Received: from 50518d7e34b8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F5C77C70-4559-4432-8785-E30410DA95EF.1;
        Tue, 15 Jun 2021 07:56:06 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 50518d7e34b8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 07:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGqL2R5hV6ZCMMoK+pLVwUITVtnoFWXb3l3Cw80eCM6wWG+tiqSRyBqaYdbnjp6Z1XHv7OpoAxocVmE0eWn//gmBLHylE/+4RaXKZ1ICcyk+DLAhaSserre8WeFmaBt+nIV4dfipm8Uxt3iksitcNtMJfmGT9uFZTqyF/+Wkl0AKvvQ0/aEBI+RgyIEPj/MfmSruDh3CKSH+9dsYTfmUS6noKWzLrdeBYJ684WCRMlOzFJwFZFP3eMFXcl5hFjgTSgSNRWDG6mcr30sBYIqQGCiGURN4RUV81WLW2ve9dfOuzsY2+6MTCABRJcD8PmCjYpgSW9dh+DpnmWR6vylxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Vm+UCzlk6plqw5RPrAPwgg6lj0AJ2gk5QtfIeo5aM=;
 b=DgbrrTEKgPwISfLmzFOXGFKSMOMkd1VVCy5dEjECVGjpBTKDbDNR43dZiCbVv8fbcMDrU+82PC+j0kSUjdPVdu/swlECtfPtfdRSQRIaXRf/X1KVj3gNbejm8dX4Avnw9uSYxcc5bdRDE3BfTUNwVxkLfKnafi5aBj/78vq13aHY3qoG+XLCLzb/OoQ78aehNDx8ZJo451LBfQWADC/wdEHBMF/AGZbg8uHheVBAvVODpErAyr+T8yR65LzGmOGXfsANIkRESfgq7jtb5nJHI3JhpyHTGOkpVzc/gFrUIq4M1Af2/h7a48qiQD2PRXuQ1MCPdxwzKoL0xH94FKA8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Vm+UCzlk6plqw5RPrAPwgg6lj0AJ2gk5QtfIeo5aM=;
 b=HS46X1xsVNb0dPq02GCO8HzM+Vroyl/RiyXSDiAAnH0wzf4JOyP/EryOzpczsN00irFQnBROnN3Pc6MjtvqYi5DjvCoXRZz068X5cHmbRq23wic/IzebqqEz5o0UXm5XdrbLb//DknTKKkdxKhciwPi5VTCj+D6vmBBf15wSRzQ=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6599.eurprd08.prod.outlook.com (2603:10a6:20b:332::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 07:56:02 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 07:56:02 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Topic: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Index: AQHXXtr4yj2ZFiynnEqJXnMpAugWBKsTqoYAgAEBowCAAAuGAIAAAUJw
Date:   Tue, 15 Jun 2021 07:56:01 +0000
Message-ID: <AM6PR08MB4376DCEC0F689A5736597B40F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com> <YMd5StgkBINLlb8E@alley>
 <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <55513987-4ec5-be80-a458-28f275cb4f72@rasmusvillemoes.dk>
In-Reply-To: <55513987-4ec5-be80-a458-28f275cb4f72@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 11C8325FF76C2947A4E32D1F72A0FA9A.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7295c74d-b721-4905-54d0-08d92fd30bf6
x-ms-traffictypediagnostic: AS8PR08MB6599:|AM0PR08MB4964:
X-Microsoft-Antispam-PRVS: <AM0PR08MB496490405BE2938A57D19685F7309@AM0PR08MB4964.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AuZzqLC0abemZgQhz0Tt9WV5x4tHE84YvPE4X7uf0wI+lvDo5zqvLhc/h2rD38FMlEJA/cxlR8uA/hQFcaGONaxsuMW8zth8ED5vLOkW73hdVDXxMVJt5IIlTNekUv3Gpmz6pLvkA90J/r4bcet4j3JOqksovdQdihy7RlsAa2O1j2xH7Maz/h/NuBSNij1o3AXg/FYL7puQMD6cQ1f8KB58ZX+0A+8eYbmEBIxNRP8sHZFeaQRcfFn2oRroFlUTCKGluaix7ZY4FopZL25Qp2JodBHrdfEfqucS6yv2X+5Ul7e/OENPsSdn9xOzcEV1IX0scZegvd4uQHdjOl66hkO1aU5/M3yJJEiQewoCkz+7/iPtaQTBdpwtKna+NyW0QmFroi7skqaZskhfGELDu4ZugRIb5FgWx8fEB96Dr+03UHgq5i9vm/COSsEJtKPpXkcvlC36StasU0NKrjZXvhTbI9DDwYiTOKtbuTzcgLtZWxQposJAMhQlZRy67iR5UKp8wsYnPopKTV1dHRhyCoOpGcYrhjKkjmiIsU21/6GzQt5iFQUDHKAENZecuJR8A8kjOGe6fEGVt0zG6KH2JFeZrHecS3Rz5d3aSKjXL78=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39850400004)(122000001)(8676002)(38100700002)(55016002)(66946007)(71200400001)(53546011)(66446008)(66476007)(64756008)(66556008)(54906003)(110136005)(52536014)(8936002)(6506007)(76116006)(7696005)(5660300002)(7416002)(316002)(4326008)(26005)(2906002)(186003)(83380400001)(9686003)(478600001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ffHBHgTGhusOB+wWeEmsrNYDq87O4Me0XJUWn7mVC3kksY5KbqRwUxsjbmkH?=
 =?us-ascii?Q?2/M52AIHrC9rS+XR1+QDFwAbKkm0hXxbGJbbf3GvkF/zTpAzPZ1CNzlxyqRr?=
 =?us-ascii?Q?HHwboXm/PTUF5RI5Ml6cxRKkVM+8E14WQbKzGBUUKHWY4nBm4z/D5f+zUn7n?=
 =?us-ascii?Q?u6d9KwK/ECI3nkoKnMVT+8qYsE2aWpIzq8SVyraXqjdJWeP70nvy2puqDd2C?=
 =?us-ascii?Q?/fn2pkEFx+/cf5TljTb93e3A4rAT+1/wYBIefeoaSbRX9vbmWA5ifVrGUypv?=
 =?us-ascii?Q?UMbR5XQawxuo9ATjSVElNtINomE1slU4pSoOkCxfTfFf+IrDsK0gd9BvMCMr?=
 =?us-ascii?Q?Jpe9bGalD2iRaoD5Ah0da/VY2Rzt++idoWU7MoW942WZZ6x+vh0dlqCSWKba?=
 =?us-ascii?Q?qIzeAN4QdhNocxr2xpJaHh48fNiOTZNaMj6+mT0pGIOHZGirRz98xP8R3D3T?=
 =?us-ascii?Q?Rwmyg6PZWqNFczetS27+zLbj6kd3TZ+HhUpWDYVeQOtOqlKmfIMcoTIPPXUp?=
 =?us-ascii?Q?/5tXp170I9xMlVlS++t24Bw0CJ1iHN/rkh3xy4tgkIqiq58v+UdqtCOjWxyZ?=
 =?us-ascii?Q?V3OAr9jr1Z+kReCtx5tG4S3OA4P+hdYzoSvoHlVqR5LUmTBG1gWppbBYOiUw?=
 =?us-ascii?Q?PEBwi+hE6wU22sDUefcCgSXs1Gn/BkXX/4AHO7Q/r8zijA10RsntrHjPgBUv?=
 =?us-ascii?Q?VSpOg1w/Yi/QjVTAMR0fEdirzV0ClGlwpyBtbAYyMIt1kmhMIXoJAE9Kzlm2?=
 =?us-ascii?Q?cVvgC2FbBZSlUfWNqmgyI4IGrsp5gZQAOcY2bdohtx6QUm6UminJDcvtcgkv?=
 =?us-ascii?Q?Lb+1Ye9M6ITKuB/F4Zo3C1ZGsEg2fkIMXUlbKe9Q3MYtolE5L0TtjlnR+2pE?=
 =?us-ascii?Q?GaV/6oX8sPHXREhiNbaTrv5CbYib6fX3YSKqe5KPZFU472MpRPIk/3QFXnA6?=
 =?us-ascii?Q?n0zizR6ZljTQE66iIgmDcbP3DIfUFYRco9asTDQLfrFmIR3LtlRQE9sbL1UP?=
 =?us-ascii?Q?XEIkdyUuweI0wkO8YVepCkFueLFHBuNH+15cEubtD2LBKoomp17XkD4MaLld?=
 =?us-ascii?Q?N+lvP/Bv6FYQoOu+wMD5HICzvMlTEiwMAtjGFkyzg+MHfjpQ+tkKC66HIfzd?=
 =?us-ascii?Q?qz28p0QMJxETabmbekrrAhTuMBpAbedDTC1YpD6xdInPLen0UJm9EjB8G2lx?=
 =?us-ascii?Q?9ARpM6Db1/bU/hJSu0M0JmaZRHt8c4QzxGEou/X7iZrrrgSKHYUotiWlt4R8?=
 =?us-ascii?Q?CiVQsPxjorr3PmRoK/iFronQrvHaVPEiH8R48IKa19acr+xvrItg5q03+IVQ?=
 =?us-ascii?Q?g63eWZEEgvlXUEzt16EIyoCp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6599
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: dcc36132-df19-4efa-c181-08d92fd30522
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekvznoEWbXzIW+U9NHIhVM6DRQJsrb6U9GMFkw9QjAsaj1QCPMgiyJHqvwbBX4/6/pJvf0XtoCy0EeqQS/GBbaPup2gNCE8u5mWWDJ9QKEpBrU95I7mslwXVSLZ51xPMj1ZsBAgHu0ZXraynwbL/EKXL+Z9VD+9WZkb0J+5ZtEFqtZ96RkNBbBoT01J6Pimkg+jJNZU/+ExvuT4cvM/GEGnZwtSWrH4mq+It5Y3pjbdKJc8wLa2pJSoOSdYD0oixDNcY8Une6d3ZyYgeMRIo2yxYeLMEVEChTuYCq3iDe/745tO9vCn8BVlyBkX7KsyccBbHtzzIkoDaLEFhy2kq6EoANEtcse+D8Omc/Eb6aJuInkxdRQCBHvwoO9bfJHmaHAbrSaVW+QFyLGflPYo6U40U/gIaNEjgiRCnCQjbEsZSGJztQtKwyjrkD0yVvmc/zVXLYuTc7tjuf3yGi2+kQnWYmdlQMHLhfB79xQlEzJN4199wOkJdHzpcDUMP8fUrhwFVivSCvkaVJvsa173pBcsmp4h/rWG7nDoegbB20rjYY0omqeYf7tV4xG8cMGTbs1G/1pm2R/3sXJvElpW1tbzJ7ZNzqzjx0VyZIr+A1c0wLb0jCnlKaKUh6kVpt7Rj2K1jDGdxInc5FCsygrhW+w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39840400004)(346002)(36840700001)(46966006)(26005)(52536014)(81166007)(33656002)(8676002)(450100002)(70586007)(356005)(186003)(9686003)(336012)(8936002)(55016002)(70206006)(7696005)(36860700001)(53546011)(2906002)(82310400003)(83380400001)(5660300002)(4326008)(6506007)(54906003)(110136005)(478600001)(316002)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:56:13.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7295c74d-b721-4905-54d0-08d92fd30bf6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4964
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Tuesday, June 15, 2021 3:48 PM
> To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
> Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
>
> On 15/06/2021 09.07, Justin He wrote:
> > Hi Petr
> >
>
> >>> +static void __init
> >>> +f_d_path(void)
> >>> +{
> >>> +   test("(null)", "%pD", NULL);
> >>> +   test("(efault)", "%pD", PTR_INVALID);
> >>> +
> >>> +   is_prepend_buf =3D true;
> >>> +   test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, =
-
> 14,
> >> &test_file);
> >>> +   test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 1=
4,
> >> &test_file);
> >>> +   test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file,
> >> &test_file);
> >>
> >> Please, add more test for scenarios when the path does not fit into
> >> the buffer or when there are no limitations, ...
> >
> > Indeed, thanks
>
> Doesn't the existing test() helper do this for you automatically?
>
>         /*
>          * Every fmt+args is subjected to four tests: Three where we
>          * tell vsnprintf varying buffer sizes (plenty, not quite
>          * enough and 0), and then we also test that kvasprintf would
>          * be able to print it as expected.
>          */
>

Yes, it had invoked vsnprintf for 3 times in __test()
vsnprintf(buf,256)
vsnprintf(buf,random_bytes,...)
vsnprintf(buf, 0,...);
seems no need to add more test cases

> I don't see why one would need to do anything special for %pD.

Okay, got it, agree


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
