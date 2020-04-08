Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935801A1D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDHI3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 04:29:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:3689 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgDHI3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586334566; x=1617870566;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=r5sx2Hhq+a4us+zrnDccr4vw+4ntiIRxMjpnb8FsN8M=;
  b=j/2R9+hWupfJi7S0NH1XXc1HKxlOkDH66iqTcKnn2YPFHyLQ5wbui/5T
   9Swr2Qz8w4/qspCsDHTykEl31r8Kobr+bfJJ80fr+ItTZWyd+gI06+V5v
   wYXsgyce7kELd7bSwqwAW/OimZh0tm3aF2aLUoi4lf9Mu94rfeZhGGvQu
   ehTqriSrekM6EyCvxuxAbt/jlnMPD5qg8GiQC7TFBTcjjnlj/inu5BR5J
   AM8m/DUFOjFdkY4fXBvpr6o6P50UGkv18HPe77vwLvZd2pin+AuaGbXtc
   QrB+hzMTKJFsETMMg6P/trGt3LIQ7dhhxfaUxZjsjAwFFkvG6LdYuHH36
   w==;
IronPort-SDR: 927wuTtHHyvDf4O3j6BC5mVxvHWL9P6dpVTOmqJT7EbfNtTS1WdvSMJ1dQZvM6htlnlbPWnnW1
 dI5ZE9R6E4eEAFh5YlzxWWDr/piNJIwN9NMZRpibneM3w3a3pBhxZL/yXEcvl0hF3zLD+H16Q2
 yZmIt37q6bHZg0TxKG7kkANaPpSEdh5wPyMDFR6GvXiWe5BeBZyQe6v9VdpEnxIFfIxMKJGQaX
 UOXp4MJHDW9irp2AHwjzed1+yAxdDI1E+UvP14XTCAe6m+JjhrRgxMrXUKF7xPFnJoY6i0gHYq
 9+E=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; 
   d="scan'208";a="237178915"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 16:29:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu1le1J5h2XmtWz0EdJ8nbxTIsLq38nzhXTiG0JBaAx5qAdUnoA0bxifhg8ETbfkUrH1iAYbV4WgLxrRDTcsTaKJpvncKeHaKDXr0ugt6yWw9hty1+D8AgAHX5ulNkQipfhiaY6a/a7MlMJs9awQ5sbMIMiHOYeubxJgogEiSSCe0PtNBbij7+yZnLuokKlphL6Qklkv6awEd9yU6jmq0rH3DQFsR0cQPVLjc89bkArvafgwZP9sJo4mFERn7TgamiObpzQ//VC+eQNKhNBfFxQ1Wg5zYd7Q3+QVlJhjmW/ocObAkkSdSxAQpmqwyFLBjehD5dbXaHKexpk61PqqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyMeHEVc8ltD/Kacqh2tnyDG6M+TQ8jbGsu5B2twTm8=;
 b=nhoJFAInCF6JKE6wlNy9I8/ZCIhjVkOweaIWjuMA8SZsZu3ImIrNAbVKjjbj2FBL+37YhRvJ7qmVpGid2jvNH2DfVQyfI92u92L4Z1zdHVXKxdydDbIHbIMCIX/vbHUb7JSfmhvQe1A+OciMsayj57Sbf7kpAEiL9iQESWepi7lyWo0APij+eYc76+j61i2oyq/r1W2CEMiC9kggRN76xkGkDL5lAbtB3gSnJI0MiHligj5ILNYEg9Yuf+C9zWvQK0Z+rlMaE6U9oGUBJmksr4uaemyTNXxS4bbnAM+/sSXMmO8zSYek1BBBiuJM8vnhnBlhWUPylGfb5vOzKzszVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyMeHEVc8ltD/Kacqh2tnyDG6M+TQ8jbGsu5B2twTm8=;
 b=I+p1fMaWExp615rfpjY92tAtbvma+C3JMQs0RZD4uE4zNbsJYpVBuLy2pb46PShdvgICzVk+6IpZbwUdY2Xn705/ts+ouRArfKVC7q8zEFA0pq4o21cNKv0pdJcet0QECFuCqUa3J+IigVUnio99CGo5sXd/iyLs/DwmI7Ecrdw=
Received: from CH2PR04MB6902.namprd04.prod.outlook.com (2603:10b6:610:a3::24)
 by CH2PR04MB6966.namprd04.prod.outlook.com (2603:10b6:610:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 08:29:13 +0000
Received: from CH2PR04MB6902.namprd04.prod.outlook.com
 ([fe80::b54c:8c9b:da45:2034]) by CH2PR04MB6902.namprd04.prod.outlook.com
 ([fe80::b54c:8c9b:da45:2034%5]) with mapi id 15.20.2878.014; Wed, 8 Apr 2020
 08:29:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 04/10] block: Modify revalidate zones
Thread-Topic: [PATCH v4 04/10] block: Modify revalidate zones
Thread-Index: AQHWDX/I7G1WKtgU50i0ssFmaUC/zg==
Date:   Wed, 8 Apr 2020 08:29:13 +0000
Message-ID: <CH2PR04MB690293BBEA93CAFDB769E6ADE7C00@CH2PR04MB6902.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-4-johannes.thumshirn@wdc.com>
 <20200407165350.GC13893@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9e78ba1-339f-4ad5-55d4-08d7db96eb52
x-ms-traffictypediagnostic: CH2PR04MB6966:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB696617C4BA79FEE49B58A25FE7C00@CH2PR04MB6966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6902.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(81156014)(316002)(2906002)(8936002)(52536014)(8676002)(55016002)(186003)(7696005)(110136005)(26005)(9686003)(54906003)(5660300002)(86362001)(91956017)(33656002)(66476007)(66946007)(66446008)(64756008)(66556008)(4326008)(76116006)(81166007)(6636002)(478600001)(6506007)(53546011)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmVTjWrSzOlZ8tfaVW0gh9K2Tk6w/MS7G14i9cit5KIq4Aq+cS6KjQmSubIy16EmhrTGIquj9eoC4xRqREG7glK5hUyvM2mev1rdAzIM4HlPXHeg/NbE/bEnDGOun9oihBrDsN2qjfMOQcMc0qxr5/49B57pcAJmLJF6saEOEO+N97PMcPo6qRAG2v0wqExkfxxIwtYJfZLomf1Ski8KkjyE0wrBf4VuGn3uUreReU0T+jqi1g6FS7Sl518msGISSpABAAkphgbHvdn32xpncNpLzQLpnLEg0GuqMhO2ezxGU4kf58XLfG7OjvoR8VjgAH78Ngv1kt+3jhRQitaX7fbcbYg6CVXwpGiETMaCkfTDcDf1kZHIHqLyBK/GLE3d/l2B8+Zhf3NOyB0GFW/2ugi/GHpK3LeU4yN7vTyI3nblrehMzwQbZMIYXfK21pmP
x-ms-exchange-antispam-messagedata: u4QppphzvgWqQkYzfFYWQAy4GfHZkJSYCC+YSUunx+TO0RZx4Ni8bGP7dOXyzuPZmKIFXCwYWvk64+7zEL50OPbMEX9PF9wXSqXF2/87hnTh9k7qT9oKBjayH3K1OAiIOSQWkQqzl1/GJRRgX6bvOQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e78ba1-339f-4ad5-55d4-08d7db96eb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 08:29:13.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVXGpgNh7jBGkoe0gJUXhNL1RT0XsP/4w31vq6LP9geqlEivYOa+DgTW9naQfxmp9c64yXSMdnd8zMrr79VGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6966
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/08 1:53, Christoph Hellwig wrote:=0A=
> So this new callback is exectured just before blk_revalidate_zone_cb=0A=
> returns and thus control is transferred back to the driver.  What=0A=
> speaks against just implementing this logic after the callback returns?=
=0A=
> ->report_zones is not just called for validation, but does that matter?=
=0A=
> If yes we can pass a flag, which still seems a bit better than a=0A=
> code flow with multiple callbacks.=0A=
> =0A=
=0A=
(Changed the subject to point to the correct patch)=0A=
=0A=
Yes. Indeed we can do that. A flag will keep the interface of the report_zo=
nes=0A=
method simpler.=0A=
=0A=
But the second call to the revalidate callback done after the zone report i=
s=0A=
done is still needed so that the wp_ofst array can be updated under the que=
ue=0A=
freeze and avoid races with number of zones, bitmaps etc updates. I have no=
t=0A=
found any good way to avoid that one if we want to preserve=0A=
blk_revalidate_disk_zones() as a generic helper. Of course if we reimplemen=
t=0A=
this in sd_zbc, things are simple, but then we will have a lot of code repe=
ated.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
