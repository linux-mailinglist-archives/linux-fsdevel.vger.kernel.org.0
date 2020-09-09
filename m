Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9F262EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgIIMyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 08:54:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57699 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgIIMww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599655979; x=1631191979;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kxMCkruNmtniFAfLiy9xM2JSmBLYBSXcSlPxZAyZxVQ=;
  b=XPMeyhtp3fv+FA+g+JWbFhvRt5fZkIUt5OjXNg+1NQkwu19uGUtipZ9i
   +rKyT86cp0sG4JuhKdhxwbAwYRAzryfL/pRleLFhsbbGWPxmPiVw2/lON
   6PTA08MOxY3tT9tHOEzREOWYjiS7dFj5CqzjhwuTfrxwrOyBARNopVx5m
   INnr4tpe+hKaXUp8ONlnRluWEJq4m1Z26/Z6jKYrBOS7WRpk2WFMbGXIR
   lRE4bEZK6uZYqMFvhtcjTwtXWNThWJCCyWQVxRnPrK2fqMH8JoQgAaDig
   SwYWKPCEOlDvQV9yImIZFw9RI5VZCntsBb8JUAffmgRE0H4eSnQUa3rHq
   Q==;
IronPort-SDR: WISJmMQqcnRFU13WY0ZXOju9OFJ0asNosJrsY2lSdqqxxhAade4Zx4qdefnwThXFuX1gJ7UH7G
 Gi4vX8rsjBynne+Z8jTii/f6S+Rj+5Ap8pk1jXN1jDVnpJtwOANbENrQwXd5OQ+O1Ivqikl3Js
 lgp29uIDN7jd1oyCXgMF5Q2RBse23q6w2nmFIt3KvYpEEogwYpC4YYCQzOZEVr22aJMLhqGL9s
 TBnZlek5a51lZFXgNaAum8RpN3IYcAsZzZxvy07BeZaa9cEZR4Kbyh+9vKjzGowPtnAilKjTd9
 +7U=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="250224722"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 20:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em6D1K6Uw8Vixz0KkXalJoc6SPaEzDpwopSusXteJe6Npan/HBe5sng1JpMTbUr8L7+V+8UvtydQQ2ZHAmkQuhgeqLzUytwmrKTsbaSZsXZvwyeyvKWql4lZsY1BqSpKoSTiOY79R0br5ifVLNzqy0XFKubIb6XIkH5LQlLRWTmpMl1Ma8PpyS/E4BJCAN6TOPdl0qmt1FvbFDc03Z8/ooWzx1P20xgUYqgknhvJ4QJtvCNw33ALYh/M4w8xiKfSaNWYjCsehGNeYoMTuAimny1j0rCfBbd/qoqa6hoi6PyBem9h//8TD+gVN4Lbmlcze2muwpOKDV5tqSJP6i4x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuxznQ474YVipR2HhYDQmu0bJZJZzIU7sEeiRANJk0E=;
 b=Qoot4JGU8MBSw0dqbTQ2TkAlGh8rHlHN64PghJeoBVl1rhbFFJmnZJbPII+JGu2gSyNtI6VxfP01DpwuxatmNK/MafmksGiwGG+1JdDol6hfaKejVxjopmK5WnOxrJmQAbggjjaJPOaxj1FwIKlZg1g7Int8ESAaVrgDnn07BW9gARH1l3NC+kmwvvvKlNj4Rzy4BgeeCc3eAJDgOvRxQOi04527jWj4zKNNydyq5AORxWQhulgdRyiDCGq/rdoUT4AQrDI1sMiLDoukNXkDPx8yvIL+yU2anFxqPy+1+NZ3PQjW4kw6OzEWUzf933bpi98nOotXnLkCz5/cZsx0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuxznQ474YVipR2HhYDQmu0bJZJZzIU7sEeiRANJk0E=;
 b=jv/ERsMBDfTCbAhcyuKn+jHh9utaFtn3vocKJKirPrQSbUmd0S0vsS91B12o1c+JfuISS5YANWgFVQXR7difGRkMSl0ayLEQu23uEjMPInW8kAckhZ1CwNhYhBzluoT9yAOICOKFDWPHLMwL66/5hRGMe1TL0M9fzxQX6hqFyEY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 12:52:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 12:52:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] zonefs: introduce -o explicit-open mount option
Thread-Topic: [PATCH v2 0/3] zonefs: introduce -o explicit-open mount option
Thread-Index: AQHWhpOxCBfCAGbEIk+JWWMXQ8XvlQ==
Date:   Wed, 9 Sep 2020 12:52:37 +0000
Message-ID: <CY4PR04MB3751FDE476A7EB5A59C8352DE7260@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1c31:4ce8:636b:3f7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6da1a539-2754-43c8-bf8c-08d854bf3aed
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB072700E0951CE707595BD539E7260@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+fYEW3dR8LCiGQXo8gou3/0q7q6Fr4c8VgqUKWqqmGUkQMHGKzGa0U8keuRk37+4RDkV+Pav/PuRQw3PLiha3qBdn+DJcBYKRalyGpkYVfaDJ2Gqv8dCHR01WAhs2Knjt90Q9lRA/SCNq7O1Ldf6GbTNs+1iIirksNjmG3SNfdx97IuPYtlx80oAG9LbqhSIfNYKxqycPslCH2S0ZyC+T5FCBfGOQ2MVtGYXet0Qoq8UkwUrAXBjck1MTqRBQRKZUa7LYBdBuCS127fBxeRG5cK3fxoUYdtlN4AprPBC+SBl+TmLaXyvL7hCQp3G52C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(7696005)(66946007)(478600001)(8676002)(186003)(9686003)(55016002)(86362001)(2906002)(83380400001)(4326008)(6862004)(8936002)(6636002)(5660300002)(64756008)(4744005)(66556008)(33656002)(66476007)(76116006)(66446008)(91956017)(71200400001)(53546011)(316002)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DPLH8A31as5NrCkZVqjXVnNPXqquD5ud9tp0mQphvoQsK6quPevaNDs7Sr5xub+YIZykoduM3vIaTFAnj8FMaSbM2lAaNBt9l+jd0s9CsWmPJGTBdRI8U6qz28zWLHU9A+Xuilvqa9EBHeI/35SyI1f91OV24dRKCptHEanMTtNXGqNcVjnAWe1KULHMNQYDYOZhyOfMV0NMnmsdv0l0VTZjfv8jfpzr7ZcYVJyaeyYLfBVmy2iJeqxmrUH1W+jRswgLf74WXdHVoeNFMBZ060x07WvaaczzIHl7r4G9o3KeLY6r5G8ugYz9ghUO9EHXbS8GjXqN7tWQZmv6Tb1GL8EAtZtKptyrupPuRSbKKalskThFMlS9UXqB9ubkOSc2w4a7k76yvDans6PJ+Fov6yySPohIm35ZeYKNdAITr8HmgjfM+j3kGKqX1jKyDvQcA+B6qxzKPNTRfefGznofc4Ju0zsjL2lgukwuwooBlUfYX37U5W4AvU+x9sLNB2VZ5MIeXBou1Cg94PuXnvtn0SsDCpxKVC7RS3WPjWTcyTk0eehdlViLazAzvk1NTjlGqqpLHCANIqQmrfsQ9hxB/C1suIIUgiCtndtiqvJ3PEIZmDtfOPMXYTFfa2fNkzgiubNeYjAwMzu38Ge+tauhcN2tz/ZDgUBk9osALnmVI8CPhg/B6nXsAruMdYqdWeTKhscnJUtZAaVdF4ItjCk8yw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da1a539-2754-43c8-bf8c-08d854bf3aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 12:52:37.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8tBkql2dIkBa81ryMDQ1OjCggV0TUIIWEy9ymfWjF3JZRKqevyf5l21XORYAwiDrrSP4zrCOB35BGPu9iBgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/09 19:26, Johannes Thumshirn wrote:=0A=
> Introduce a mount option for explicitly opening a device's zones when ope=
ning=0A=
> the seq zone file for writing. This way we prevent resource exhaustion on=
=0A=
> devices that export a maximum open zones limit. =0A=
=0A=
Missing the changelog :)=0A=
=0A=
> =0A=
> Johannes Thumshirn (3):=0A=
>   zonefs: introduce helper for zone management=0A=
>   zonefs: open/close zone on file open/close=0A=
>   zonefs: document the explicit-open mount option=0A=
> =0A=
>  Documentation/filesystems/zonefs.rst |  15 +++=0A=
>  fs/zonefs/super.c                    | 187 +++++++++++++++++++++++++--=
=0A=
>  fs/zonefs/zonefs.h                   |  10 ++=0A=
>  3 files changed, 202 insertions(+), 10 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
