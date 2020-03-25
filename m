Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86F1924B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCYJyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 05:54:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42693 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585130086; x=1616666086;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T7sS0yhvHwsucVNAusRVf8+DSWwW9FNEvOxrvJH1TnA=;
  b=gU7GyM7tcU0nyHa1H/Y92mCkzBH5iDmqbz5OVFlchjacTPh+cJa2vlIz
   9ktghRWq6vrYF0RYlUteTK/e7PXmosn3hdUdtS/7OGtdrjGgBQCwLBcGK
   sP12fF4FLbYj5uf9ciqbX1fY6kqTu6YRrxD3LluVph8I3bwS76VZ9HKuC
   8o/Fd4ANM7IXQVuIzFbbNegDy0M44dkaLExTtZp2yzRZBFb6Ft5Pr5FxX
   BKw2Oe72R7OAsDxg5Wl9/ooytR/MlPK3c8jJ9k1o3gj/Q5fBGCzUhF/Sf
   q3onFuE/7NtGqjp4sBlheuhuS2jUX6kWo27RqbzXbBOHLYiHfYsYLb7J6
   Q==;
IronPort-SDR: PHa0xHfyla0utOZu58IqwoNRUKuyE+TOBho6XqaKd8NsqQHUoBAcaXcIolBIdAtGgtKfVmtkhs
 4rrWaBcuIsZ7719CuAhtr3TfdRkYBLaxgoHzbnnzI62R4MKc4e3UfeF2X6Wyu2F6qnQ6QbUJRj
 AMkDJpPVKklSJiOEBqR2VwXpdEJl3Ct5nL6GexXl/7xbYbVbObH/N8z+32nWPk1mehdD1eNxFN
 mAUTNc0/EWyWoHcsO6QxOz8E1p8D3mTlduaYiE85ZKML3LBacDB8xMKp4fMRP/hUXywVJ3Z4Fi
 eYI=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235678531"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 17:54:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfFp8tvXG87qJDkAe8W5r8ygpjbHx9O28rYXh++zxVJVWBmqP6ENVV/9z7za3Ps80z3DsewybUyU1UIngE8KK0fam9L9bZtTfpSIX61VH3bSE9nW6Ibzgnt37T0rKuD3BnsLO8tQqBeyZejQBYiaAOwIVcWNvHG9EgCWG5H/R4xQYAr5GgnoNzQC8Wd3Z9vM5Ea7bP7LdT3O/VRnbpVfxpnDXuQUJZj1Go5sLYgyHdSChGBlkVKgvsy4iVjCr/VwMxPxsh0hqa9l3JjtgLa+dDGy8xg+lXIFljeuasI3Dk62yyzgH02Mu86bVW/3cO/IPzRz7Y9JrxdUhq4EKMGhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P7Rd2s5CCgbToP/oJ4IgnvOEEkHj0dcwzAsv8Dh924=;
 b=DHOSbt610e5qWCO7Qvtt+ggaq6EMKFA3hRGqJlxke2Nd/6Fpy5FwlzUehtCw+odKMMLgODNnppJYbBtjctQrw9152R/YNN0v3oLpdNrbvJBRAXlepcwIaZpl4lNpAmhjJ+oJOBc2wyhOgxQmK4Gs8QMWDE8EJRtd8pQw7xVfmyhJR5twWgO+O2RN050MGQwvSinhzsqU4jRAhf4PcJ3u+R7NRNaL4VzqjiC39E5ZShdloIyALKbM+CH19/2PkJmme+mNwb9DmYs3KOFSmUcdvgKuVN0osxOHn95zV9ADHjL87I5MEHgTqjzvaGyzsS4AdeqFr/1/NhlKhttIDO9+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P7Rd2s5CCgbToP/oJ4IgnvOEEkHj0dcwzAsv8Dh924=;
 b=pWrQ3yD+k9heyP6m/+Ye988eO0AxUTFDNnJTBybFjCjz2USCA3kK0R6BDHMlLrfQs6SvXciRDZhfHKOfEQr/QOZ6fcbohDa8xKI8Gxi+9NtTWa8qxTGT/dlOyzxVMogUWyfUwpf4NecZxi3RH3pvNrVK/6VzKT8EHTXhHnVsX6g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3613.namprd04.prod.outlook.com
 (2603:10b6:803:46::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 09:54:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Wed, 25 Mar 2020
 09:54:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwrmUQROWSvUa2jUG+SCcnLQ==
Date:   Wed, 25 Mar 2020 09:54:12 +0000
Message-ID: <SN4PR0401MB359862258DFC97C1337C8F8E9BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
 <SN4PR0401MB35980056EFCD6D0003463F939BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200325094828.GA20415@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3249c4f-f3dc-47f8-78ef-08d7d0a2790d
x-ms-traffictypediagnostic: SN4PR0401MB3613:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3613993C0582FFBB6AD609AA9BCE0@SN4PR0401MB3613.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(81156014)(91956017)(86362001)(52536014)(76116006)(4744005)(478600001)(2906002)(8676002)(81166006)(8936002)(66476007)(4326008)(7696005)(6916009)(71200400001)(5660300002)(26005)(53546011)(186003)(55016002)(9686003)(54906003)(66556008)(316002)(33656002)(6506007)(66446008)(66946007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3613;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ACfLe7S1M8BjPmXTL65Hy0zaZ3mdMN4IiJAF9k5tslz1SAQcTyj8w8esfxAFXggFJUbtTaNv6UY4PpuNf3QfTtH34aSn7sWek9CGh7udySFYUGKmr9hrCqu7v0m2zFwqinUBduHwIRiUUYpeU3leI+oATMCvsOIMbgBt4mAKhGfaMGsWzHfLH3cNSgq3fnGStx5rsVOMbPxBhiV4HNem2fe9NmqJtQgijDRZjERP0UZY5GmBYdRq9oG0rJDrC2jCCeK44wg8+SnKcoCXym+3Fvpx+vQYoM090oMmJasxwZx2V911XjYxRoaIAEf7utOwzMwQHlDAmiRqI3BDVBB/XC0GVOvmrg3U5+h5t05yAGHochQWCUsPycTupchtcf/ZpQy7Q/cANo36Cf6axBUMpmzlxJw39RfGtggb2IySIY7PvAhI09MN5XTi4T4yjtf
x-ms-exchange-antispam-messagedata: t08/6RI94Ot7RXbqA5L1lEy9s6R5/SwRNzYAzwgQjY3HByhY4WRfVeO1hBb7plUwI+xIbwM19BX5m5jF9aGvX977rLYy9S724nAicYwT19DKnavWNzEITFCbvMfkZmKiUGxbMmNp1RnvkMbOPMTugg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3249c4f-f3dc-47f8-78ef-08d7d0a2790d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 09:54:12.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9Gdm2GZULV5IMzDZIDlrcJHx+A0tePhERHHnlULh6c+mE336EsE4g+lPxORFAH9rzEDLwoVo4eiMxARhc2UwH9c/EcGafO+rzBo6yAJ9xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3613
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/03/2020 10:48, hch@infradead.org wrote:=0A=
> On Wed, Mar 25, 2020 at 09:45:39AM +0000, Johannes Thumshirn wrote:=0A=
>>=0A=
>> Can you please elaborate on that? Why doesn't this hold true for a=0A=
>> normal file system? If we split the DIO write into multiple BIOs with=0A=
>> zone-append, there is nothing which guarantees the order of the written=
=0A=
>> data (at least as far as I can see).=0A=
> =0A=
> Of course nothing gurantees the order.  But the whole point is that the=
=0A=
> order does not matter.=0A=
> =0A=
=0A=
Ok now I'm totally lost. The order of data inside an extent does matter, =
=0A=
otherwise we have data corruption.=0A=
