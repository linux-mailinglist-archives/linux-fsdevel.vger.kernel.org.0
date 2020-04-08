Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902F61A26F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgDHQNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 12:13:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16705 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgDHQNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586362396; x=1617898396;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D3ASIxFJ6am4BrQ/vyM51s8hMEGHAqxNQhoHGh/PDw0=;
  b=r6YqfMzgAZdmwwmIDoapU6spWYCaHkTz1WA0t2B9cvOp7Cz+Oik7nDGL
   XCzCQhkwsKGtyx/dAnrBnAO1220GX0bKisOWY9P/sVu4C3g8ulzRH5/bK
   dvySzIwjCkWM7iOKpAt/JAUzy5MDvbIorArsHFaI+dvzJ2VCJZnsDc0AK
   ss76SltBQRswwoUGwOx6v/2hOFEU0FzAbMZCOXlyn7LDbp3OPRb1c08mu
   BLR713jD7reKOX9/H0j4QinE2eprBqTknsvXIo+Qh9T4KjfbMGCRgT4fC
   mD6FKH2oH3MQRFUO68rHV2Z+C9Ego2b7Ena2pm94MZyNU9v2aMOVC+jY0
   w==;
IronPort-SDR: sIFELYko0SvtFFeji9FiFB37w1ZZQwD8x/NBTJYRWHHuA6l6ylIxRQGvYllMHd3vfwOAK66Gpb
 eyWH8ZplYkjSDS34AjC77sZt5vCfqBoC0e6a/4V5a42J44bHX4Uze/w4hDUmTpQNAHqaPtAKDr
 ySiPYhtjYGw3p/E6Tu7JEdWJZLZc5f8NGOD6wBvd3vbj4suAs28TKOXbM+76pdeFkSzUKRg1fu
 624c8OcX9QkW6fvhlOP9c+b/j6QOhqV2ujVvUoYzY6phFddywHsiUiXfjBo7lMEACz5y6cSH98
 Xv8=
X-IronPort-AV: E=Sophos;i="5.72,359,1580745600"; 
   d="scan'208";a="243437762"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 00:13:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBcOtGNnbPV1GhbPBXbocaZ+o3hf429j/pB32O5ewAu4SSzmf2w9xC4WuwaIzQuuxGdUglSbLxNJ3uFjYMif5TkD+vKuWKliw7pbfQoQW6LiKCSTbG9o3mDSNzj8KOjE9XHBTQaaUTr4iS93MS1tAuBMEwFESdYp9Kq8ywoWn5YgBGbX1LonBTj7Zfs8mrwGRWBJkro5wJ4G5NHIvy9bEnEh82bs623Ki49J3fLmVFjoesgB1q+29eI36P4p6m99A1LHbvAYhWLx69TGp5URc2f6B3m0NSSaQA2RTtP+DOU8VmhsZwdOZGcOlAW6mWNO2q8evevdx3inn+yVRGs2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ASIxFJ6am4BrQ/vyM51s8hMEGHAqxNQhoHGh/PDw0=;
 b=mCgwb9dQovFOB2fSpZTvk7034sg6w4DP8Y0Kf1OthQvFIm0nGcUBMfhrf+495Eo/xTzR7EIHVKIKN1S7MaD9d85TW4yd9sOgUKBuOTbx9DkoCDU6DSYwBrizvBQfRkSSh1BO06+HS+S4PGJeswOZTx0otGmTJHQZ7979nGRATV8AYQsBlwhJe55j+TVjBYISWB65CBVVweRv+wmIBc+6hUcBTbjyDiRtYft8y+ZpnnHcARBqI7O5hmR+2LYu8ps+2jVRBq5QtO61KwwFCfUVc40uyifhVWv6v/Pz53ksUV1l+5SAH6cEzrT59X90xb23FhvdAGpqZOw7aVCS5a5KXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ASIxFJ6am4BrQ/vyM51s8hMEGHAqxNQhoHGh/PDw0=;
 b=tkFCkUhvRJzkHEdzUrZsympULLiFLLGBO6NaLYTmGmYvYz/VEcRNhI/FzL18Y63PQd2vGNwl6FE30Z/58bb0z4+u1CkWdwlJouE1J2+NsIsgDP+dm/1uUi1ho/ZSOhwaniRTkuE1kF9JCG4rZw8FY5kVF0xLxz6PzsBQNaTpfoM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Wed, 8 Apr
 2020 16:13:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 16:13:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWCaCAYfwUuMa7mEmti2uybIkyvQ==
Date:   Wed, 8 Apr 2020 16:13:15 +0000
Message-ID: <SN4PR0401MB359802AEE29A4C37BBA15CB79BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-8-johannes.thumshirn@wdc.com>
 <20200407170501.GF13893@infradead.org>
 <CH2PR04MB6902DCA5A70BBC48B66951E3E7C00@CH2PR04MB6902.namprd04.prod.outlook.com>
 <20200408155846.GC29029@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39f67716-3006-417e-6c98-08d7dbd7be4c
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35836F22B2BACE699E1BBE519BC00@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(9686003)(76116006)(91956017)(52536014)(316002)(8936002)(86362001)(81156014)(33656002)(66946007)(66556008)(81166007)(8676002)(66476007)(5660300002)(478600001)(64756008)(66446008)(55016002)(26005)(54906003)(53546011)(7696005)(558084003)(6506007)(186003)(110136005)(6636002)(4326008)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnRUnAIDR4WQ3Rcw+PwjcioCOXaiNoRJb5oaqcQlTOhBEZ3NYly99Il7/gIFclyozLXRsH7ptz3+6ISc8RWDMkB1uOBgmNx7LNDyaADBA9qgFjpOuYENYRcxw/fjDYd2e4db7wwvUdedr7SR5jsvqCwYT9VGmHCclgBLgzRpgOj0Z0K0pgdbElWtCLELvt97BVNP1UnM0FmU0x/4rEQSs2iq94bvwMV3hjjwzg1Uxqp6+CtQGbOq3RAJ6w+mGzSFOL0ru4dWXPM8/Bm7f2n6IbjMKBF+mCgnIgrJbxG9/tvmiM25/dC1DeigunAma1eUCzkwP2hWTRnbqOe0BtcfGAk2ft7gyZntPBzZFHXsYgu8j/v3VQbmhPrSp/mWj0QmbDvjINGUQghDA6Ho+fo9ZR1A5s2wiMK8uwwcp4Lg307ZUcEm1MMOrqJvAd4MUWyV
x-ms-exchange-antispam-messagedata: BJp0HAmUlqpfKwscWYTP+Tkf7N406pmzcmGLuStDmgVlHwQ3E2gzLUqFb+0BVL5mvekPS2mYM3ZBrHq7WdyiS5MxtMxqwrAQQsbhafFeRvBMQZ396J4GkAMprij4vDySwbhHqkn1YTynhsh9o+a/AA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f67716-3006-417e-6c98-08d7dbd7be4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 16:13:15.2346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQ762ZW51oKJaSkK4ceUeNd6sa+WEsfobIo0AGNxshhGLX4nBnNWDtjy6yn+QI01v52JZ0ox2jAbCqHnVG5SL20VmC9nZC1x6wuVyUrncQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/04/2020 17:58, hch@infradead.org wrote:=0A=
> Thanks, that's what I remembered from last time around and why I was=0A=
> a little surprised we still had this code.=0A=
=0A=
Well it's gone now (at least).=0A=
=0A=
=0A=
