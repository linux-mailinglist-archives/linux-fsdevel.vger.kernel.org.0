Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19922309F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgG1M0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:26:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50638 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595939192; x=1627475192;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eAYrw0dHY4vUGt5auOiPXeRYo7jZ0TIrvgqn0IgVs2HdXyxKOMk9Url6
   2GcTwGRx0VR9Y0wwmmBHh+GgsrFbksKZZPEifye06t0b6o93M6cEiFfwJ
   UXPe2Rl2tBqbRCWxl/2FDedBXOM7u5o2aWniVh3a2Tt4pEjpojz6Ekzr5
   nSubSgUUVPzaI2ObjTCi6uGAc1p+RfXiJ2mL4DLFpPzx2zw+89hnmuTfP
   W7JU17Lf47gtovwIroMrNYmuJflPyc/IeD7m9bcrgNVrjnA7REZFcFUHf
   3SNROUpiJgWOAe0T/pdmYpzuey2f8UNM1g1xxerYo9W4VXQu0AWGW6pnZ
   w==;
IronPort-SDR: laqEaV+0GF3XeqnKL2Ca1NSMpxDsbtWMFX90l88Wb8l3NKD00Vx+J5QtOEFM7F7U4tG1JNnQ//
 bgF61VQ7GFdAiM8A7DCsukrWsJ6IiMWIZJPAb+Vvbpbc+CfWay+G9ctrhhvHcyMQMQk5sXwwO6
 o0V7EQmhcX3nRXgmk4fTjyAiAZSqytZkbBteBrTpVvrUKAwayBZZHHUNtzlsmXvEzxLeZqtSKn
 Z/uZKHVr9CE/yc4xwxgVpnV/2YvEQ2ae4YZUDYbS+oaCSzK912C2n4NRdaQlJnPtXku5BiB7zx
 vnQ=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="147860120"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:26:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f20Jfx0J8Y4268qwaJ3LqRPUmNmJDXtZdsBZq3AEtDcX3JOKr+JnCjk4l3yI3t9E0ju9vDWyt4zu2HuIx1FXALDPlZmOsgT/eedt2Re1h8vhgUVRD4Abp9TYTh9oliiNs7hC0csAqr6h1eAiXYGaqN8/pc9VvV7NADBicp+tC7JuWJJOGY+eQfYC9QkxecHN9LUSASrPgFsW/ys/ebeyep8CrLUd68vduTzetKcLd8b6NOLUufH0tCQsZEI8x9Y4cgS2CdWzs9z23dVbBW5OKqye7hftGBRXKm/3abik4yvcAGpbU77oPKe5bYqxJEEGLqWAMHgaWjvPpbgteGkSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WL61azz46xOo57FM0eJIz0yQ3+HIx3YMck4E4CBZoauJn3RlM5CBLqQXcrAhz6IKCO8/L/9omOwy5syKjABDQHB3SMHtHNCh3CclzF8N9HRRmnviUhWKOSWSwx/rNxu2XCmD7S4+kvmiPb+lCC3vZ9pPcTOb6FMNjxVe62CBodal1RMk3o/UQBj6UaXzewpPx45CqguQOZ02EOSsXS4zFL4Pv8Ym6A6AHLghqaKmYVPDgaE9vDf22dYLu811LQLkOVA+MGRBwiCcak4fTZPTHqyJG0jpGT2l4QDH3IfSMF2lTi1dXxeIQir8FacoeckoPpn/6ggaO2CfwyxKEL8bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LSrH1yfAUbvTUzmi4ptW70n2TaD7K58y4oo2WAYRm8Uyytc8DgzIn+5XBqXBT7gF4E5+RbS4wT+E5b94d7tYxjnXugHGoFUV4KIcGrJG7ld/MVX2iEcaDKvReex8KcAwPwSNdqnMwOgUoHksTVcOWQ6gGwz79rUwBbLVXkGbJjY=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3590.namprd04.prod.outlook.com (2603:10b6:4:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 12:26:28 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:26:28 +0000
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
Subject: Re: [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Thread-Topic: [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Thread-Index: AQHWYYzpyCioqy45xEWUjYqj6zs+eA==
Date:   Tue, 28 Jul 2020 12:26:28 +0000
Message-ID: <DM5PR0401MB359158A8461462BA1965C0309B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60fcadc6-39d6-423d-b1ca-08d832f173ab
x-ms-traffictypediagnostic: DM5PR0401MB3590:
x-microsoft-antispam-prvs: <DM5PR0401MB359035DD8826FBCF19DDB1809B730@DM5PR0401MB3590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNeJrGF18+rjdGFcv8Gd9GiCTGBx/O0+iAKv5WbgmxBqP4F06zUKlCRokzzAh+YR4CqIUFAJ2YaTZXMfNFPhmHOMqFUZ0QaYd83L3ZXGMLCTY0PvMLKFVUNB6vYG/G398j7HKbJZtZYJ6e4UV34lYdNksbTWw1O5J+76LG20YIc2TgrRTPOSAzumdjmkwXHtT4oWHu8IAUR6FxQFVh4lVQeHNFcMEkPcFelA+YzJU70ooS9/2P2nxv/DKRTVYfvPVRCESv/goKc+bPDkk4ociNQVXYESJGTM57jgfFkFI8J3YV3by6iEC1dRrWamXdfwmS6U0iNCdP1rerGp1EPDnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(110136005)(54906003)(186003)(4270600006)(9686003)(8676002)(8936002)(71200400001)(86362001)(26005)(7416002)(478600001)(2906002)(4326008)(6506007)(33656002)(558084003)(52536014)(91956017)(19618925003)(76116006)(66446008)(316002)(66946007)(5660300002)(66476007)(66556008)(7696005)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /rI+ex+Ij+KJVHn+T9b3VTZgtoJGTsnYFvl6bqq8nTg8Ns355hktYSMF9CeYLbbunhGUKhemsqZlJAbJ3Po2hfDfI3903NyjtEqD8LpUWrv3I+jU6qdrcK/B3yAXJ5P6kKEtQIDDEake0zduOCd4dB1E/EEPUmSZSi+6w8J7Jfha10bzbYA49N7Mz3VOhVNE4R2rZQKezKBMXoMjfcHGSPkP6hPFzIVbRJX1WvA6AXl1wP/1ScymqQXuJ1DkwWpQhfmV8TYkNOpaiUGG4s9CUGH74vkjf4M7uMxa6rIr/s4v5RkL0JmL1QEKF19/c+2I3rmIYPRFeiRdcVUKmlSn8fFqqAbyoi469mJZ0TsQy8bfK/lgTj09mbgQvOksXD6LAcmB4dFxdWOUS7q01ocHCWa21Ssbv2s3Bj3hG+xB+tz2rlFAWb/0jRCrTyAyVExlKxtJ1mjXh9xXZ5gDaKfd77p+2KaTRIeTwi85zh8y8VPH4MLujYpW0NDD31Mz17xD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fcadc6-39d6-423d-b1ca-08d832f173ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:26:28.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeAyTh2unrTuXe68K1tDk8VrgGzI+H9VSPCbvZJAeo58+QMVGJRmS9LyryOEHeJCpwOa2zfyFWiSE28wSucXZEbVoONl1laetiAP/Iqj25M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3590
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
