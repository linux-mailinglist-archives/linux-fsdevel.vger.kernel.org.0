Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9641E3268EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 21:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBZUvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 15:51:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1981 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZUvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614372690; x=1645908690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5Y0w+A/HzoqmUnIZSY2Pp9RJrN6TZnTGt79fOdZiDcU=;
  b=OaTPcTkAIht/+Ch3BU4wRnP75D7bfrFf7RP+xHx51yb0yzGqvRyju0LA
   FnP+h9BOLwWRHebcVnD2gKe3Wx5Tpu7jtmb2aitnAm/VwyHl36l2Rkj9O
   ti0X/8u0n57ggtqIK9LRj2y6NFYKtLlu9ndrmrXOxUQittddxOj/C7eAM
   hDWszO9WbVP0uGy7E7noNzbhvFHk/yZ5PqL8Ajtcn2QjzgLVW06BttODM
   G6U28t9mDYA0WlnbEa4XvuAbMVXCZkb0fdYWbdVbsP6D15bKyYiLYBdFJ
   MQSyvIMgQ9n2np4wzmLY0AqWCuNr1uTChPo6TDV7RUcxUMMdvyOi7wf3T
   Q==;
IronPort-SDR: MvronQlZIkrsMYMfTv04avfmrVqPGUlzNxzqAPxSRrw3320/psoX4vWfw/vX0Xk2NO9w7UmqC5
 5qUpWs1C6SI8t9yYrYeu647nyT34KsPEUner96zctU5skqEU5oMiL4ZoEjMbwrm3AUxvKtX4s4
 z5Ua58c2vjxTkSc0XYWDScxagKA2RWfzfT2CNExA6jjBNdHApsLqGIMf6DBVGiQLKd5rQ6ds49
 8J2e8Us4wEx/W/DByJCG4ese/duVotq4olyNJQROF6eJ5pQwtMVpL4gnNbEshwa15Rprg6roEB
 Lmo=
X-IronPort-AV: E=Sophos;i="5.81,209,1610380800"; 
   d="scan'208";a="160932692"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2021 04:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHfx6goUwLjV4ZXScncIoHpMc+0pboHlyCPh23NXwniXCjlWu8qp7xnbS8hpOp0gtk6FOa3MyXStjFrI6T9hBfLV/STcFddgXlF6MjPfxjDHxM/wNryQAXzYvVuatGC77U19XWWuvrF/LpsKfkspzm+8OGH5pivLr01sxzyavs6uiC/PUsxWDLNWr2lxsdhkWZzVsvb4x/soaU08nzNzsOSlBn/sR5dkeXGZut3E2aKOjAc3H8Zp6L7M1SvtTjzJ6lCKD57dfsPW7G5PKDlyroRhr0eOu0eykRxBfX3tE9xb0SXmjZq7C1NnMM0QigDgoMFCvUODuZGGEEKCKC09AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWaDuENHLZOISpvBbnogj2bTaV8nX0VScoe+6T34A54=;
 b=ZS58uEUu17/XsySTPJB14FgzBkhjF+QkeW8SCWtDlwgltDKd1wap2m8RjId6ElDY7IwIOfuZam1WespQTvmsjfFNIhDOd7lKdOTTD4xUht5Q4m1HvnN/CayZVTSfcybgT4xRQu4nLalvOpHJfs4oP6N6Gau1lQYdvKklb0XCjow+gz1ujWnUwZIi8zSbz40cbdHc5oEka+CrZOLtdFJL88sIL/wc1xXm2PkaUmwedgzrONlQj2s27/BnT0AlOeeiwCExYeiGiP3CMZ0qlPHDJbpVJkMtSk+83yzX7WHh7cCgNqQ4QZw8PxRx4ubGkhrXkEaVakj4iPOiMrWAqfrflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWaDuENHLZOISpvBbnogj2bTaV8nX0VScoe+6T34A54=;
 b=mFHKojIqCxodJJu4IqGWZnHF2JqVT/1oax8Jd/RoGfgvJiusPZ3LYhrRFbC4/oEs/Uypl3im+I/uvGGUqgA+IE2xIOL3SoyABXjJu4KPJYTxG2o9xqigeVt+EMDHf+8ZYpCfeTw7c/KneWnGpCd8+YCcze+pBZf7KrNccsgLHck=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6426.namprd04.prod.outlook.com (2603:10b6:5:1ed::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 20:50:21 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3890.019; Fri, 26 Feb 2021
 20:50:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Add bio_max_segs
Thread-Topic: [PATCH v2] block: Add bio_max_segs
Thread-Index: AQHW9fj4u1sNnCoQE067u7zFLPrTUw==
Date:   Fri, 26 Feb 2021 20:50:21 +0000
Message-ID: <DM6PR04MB497224CEBD0261A620A47E35869D9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210129043857.2236940-1-willy@infradead.org>
 <20210226203819.GH2723601@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f369f5f1-8fcf-4205-de09-08d8da982255
x-ms-traffictypediagnostic: DM6PR04MB6426:
x-microsoft-antispam-prvs: <DM6PR04MB642693987320773046439E65869D9@DM6PR04MB6426.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh3YrkuYGHGKqdHZ3KR857hAAYAZQUqCGFCqz6q7e2PqikhLP1fbHGADYSJ43oic/ZeXvM5XA5XXpc8+Iw2+9LAbvfiZarYktAkj7HMkG4trjaZLK6Qv2SxR7tZTBGvZg78CI+CcqOcQBSrStsDXxC7HrRD+WQCDK5g4IZV0VgKu9lRmnoRFLAETos+D17kKFsp/ygOAVdWERPmjjOel8St2ZzygPzK8ICooOOnkZqpVJFnKzc2O/BPQO5LP9/TA9hmkOaTxjJsBtycaMAESUmKBVSoT49fcYnPbCLFOmiN8+4zLZ5RDUUh734eSZy/CZwlJOZyC8Ff40qPLPb79ovsJMxZ/rf7zRGPOJVsRdOeYu84Bl/LhqGf0fKXspEgBGQE0yCGsfKzlNkpHvHL5TOBuQGb1Av1AdiMAYGkvQIIgCHU1iAyZOelT+ntPMYyAeiqT/pc9XFmBz57hs+XrDmhRp/OzDZ7pRwJ7HFbJXg8O5R+7u1/PrNbp30YU1wopr/Oz7EcX5/2dYs2TQ9X5kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(6506007)(55016002)(478600001)(4744005)(66556008)(66446008)(33656002)(54906003)(2906002)(83380400001)(53546011)(110136005)(52536014)(5660300002)(316002)(71200400001)(7696005)(8676002)(4326008)(76116006)(186003)(26005)(66946007)(9686003)(66476007)(91956017)(8936002)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sedgfwfgQ1x3Tmyk3hY6aH96ajogj5SrI8HM42pbckqd32lTq8cQDd7L87Ne?=
 =?us-ascii?Q?crKQo7YRegMTSM6VjxJ99kvOz16sGQehWP0WBZakJjTo7CJcEHSNBpbRTbsb?=
 =?us-ascii?Q?HzqkHBxJadPLBOq1jDWIvSq/fp4t1oHPFR1pXfx6VU6CqiavXqqWitne4T4K?=
 =?us-ascii?Q?qA0kYWSixjT+FTLV+h6WtMCtW0UAFN6w4MRoLTXfIHsVM9tUWtm+8nC3Ab+u?=
 =?us-ascii?Q?ZWvtWlfLNtMtCEycFs2IjZ95Vivd+3IfnBXTD2CLQYlCwMQjQuuqeB3F/gl2?=
 =?us-ascii?Q?FLU+OluOKnYKC5YJjx7uVMFlGBXx64ghd8o8HAMvE7VxYmmkTV0VtPX7Z993?=
 =?us-ascii?Q?GaPjIm/HaC22tSDPkWlMSzMXvJTYcDNSvg3HkxVrOL7aiVNRhD5RVjkya4D8?=
 =?us-ascii?Q?bzHZKrx36rvlYaWfpR5y3s0MC0fNpN22o9dnkOUq5lQlukb9FqovVZDNOK2h?=
 =?us-ascii?Q?GN0UNIsYr29bAtTf8J2YCfrw3iFfoQb7iAKprUsunyNVc+F2Jc8b/PrwZWUg?=
 =?us-ascii?Q?mnpdXme0BmVKFvb/eb2dxwi9lyisHELVvSovRiURgLv+5IbtVF8M9vo+yeKX?=
 =?us-ascii?Q?LkR+1JRS53VOQE2KUwKJUMCGdqQmPftzd8u60mBcRQmX+aBBYWK6RacRCE83?=
 =?us-ascii?Q?C7Ab8LSpgyf8QD1zo04RsDRINwhsSzUi37PtjfyferZUI6dvwoBw0tJIBFwh?=
 =?us-ascii?Q?ZZu9xPNGNxmBkd8npA90PAl9QCx2nE37Z9pYMuzIiYAY39278M6b2NKfLTj/?=
 =?us-ascii?Q?eWzPCw+jVeaJ9PxV4eCJ5RVfhlWnpb62HmLO87MohFPxbdpVOdyhapOrSkGP?=
 =?us-ascii?Q?vMCIGR7PAQQp+pdBM7XmAy/7Ja1AOhanE3nYYebLuq9ZVc9j+S5SP8uV2lVg?=
 =?us-ascii?Q?txGGihoFdphOMMr7oaUTpRQE9EQN7q+jQ0LeZOuBUjDjIazfimJ9MDoYb4Hz?=
 =?us-ascii?Q?2RaPjcHCLwG6qFLCc4tA+HJscEpjmA6Q2W/DvKctRNKU3YLqTLcxh+b64/0F?=
 =?us-ascii?Q?ZOGpVxggAXTH51yVF6himNGalNkdQ9u5YKRUTo46oXew7XJfmYyGVs1xfPPd?=
 =?us-ascii?Q?Iu7pUmqlb2dGtTOdwqvdBOQli95kBT4KVV65p3c6jfrSE9xqQsjtGEFREpSI?=
 =?us-ascii?Q?dGjy1rOcE5SmpuhlVjJEkm5ReUkNdN9STXlrefq30awO9c+HanUXNgYQlPuv?=
 =?us-ascii?Q?q4cP/2DF6x0RQLiogTOH3iMydz2WyKkULJ+Z7Sx9L+tXSJMGRTj+/gjIU7lK?=
 =?us-ascii?Q?Lxy7Oo7vEVSOm1vGyyFMq2Ym8F/eVkUBLWgvw9QoNKCuVnBuA82aZR84IUSR?=
 =?us-ascii?Q?Hps/z2choaW7bHOtHryfflA7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f369f5f1-8fcf-4205-de09-08d8da982255
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 20:50:21.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juLkdnNJqTsitol1L2RnNiA1x/Edhy04f+F5eoGtSYOEzg0U/jeSg6lIvxDBvrL5iFk99yLYBDbHE/tSBVlGrkbZRroTynOdqC/spK0VLfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6426
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/26/21 12:39, Matthew Wilcox wrote:=0A=
> This seems to have missed the merge window ;-(=0A=
>=0A=
> On Fri, Jan 29, 2021 at 04:38:57AM +0000, Matthew Wilcox (Oracle) wrote:=
=0A=
>> It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the=
=0A=
>> sign to be the same.  Introduce bio_max_segs() and change BIO_MAX_PAGES =
to=0A=
>> be unsigned to make it easier for the users.=0A=
>>=0A=
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>=0A=
>> ---=0A=
>> v2:=0A=
>>  - Rename from bio_limit() to bio_max_segs()=0A=
>>  - Rebase on next-20210128=0A=
>>  - Use DIV_ROUND_UP in dm-log-writes.c=0A=
>>  - Use DIV_ROUND_UP in iomap/buffered-io.c=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
