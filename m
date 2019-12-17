Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5C121FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLQA0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:26:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27778 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfLQA0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576542382; x=1608078382;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3Wkj7ckoB9rgmxFWqukKNPAePqPqp3J1vPiEy8c09Oc=;
  b=amf0y7qy9yOtWFb8s/RP4W3sOUn4Bb37XvGtw8RQUCKl2+xi0iAncElr
   EfOliyEUUhn+VXDZwkM+h0Q+mg9ySCnc/5Y8KjCpLSrv+4TtXH53TlE6e
   mz6SzS5/70mBV7izm32JcE62DDuB4rxpvYiLHzRxafWZLfC4B6M1b9a9Q
   /HcHbhXmFTAsabKCTNcKZdPy/n+sHSMOwnw/iXMeEVW0IIjgH+Rxw8FPP
   aVIVLzDEpmUGh85G5ma1BOU1CUOWRakbtQ3nvqsSqAilwuYMUimCFNb/U
   teUXeIr934ZE81w9PKsU3qh/SL5WpQa/VKI2odcZHTw8GK9SwibQ5Uyvp
   w==;
IronPort-SDR: C80LjoJIxtuvRoCvNvQwyEO0JI2cg128NMOrxYPQjbrPffACYm8LCE0clthMtFfWU0rE3biO1Y
 Kb8SGV5BRKKSs6lpPa7/z015xVEPSgYNXHwNs0Jn35St/6YNKy2dL0E1d1/MwjLXjAPHqaKGjQ
 lBGUux0Pcuu0tL9WtNgLmPv+Kq2Z9NhyJMP165+7B2IrOrSrnqMT6YtFVNnhc63s+k7Fv/vPli
 0hI/PQuLadMR/cti+1mcAN7Jaem/eOZq1VEywdRoqmAa1NrNU1ljNzEhUrTtm+9Xd+0ovxW9pK
 49Q=
X-IronPort-AV: E=Sophos;i="5.69,323,1571673600"; 
   d="scan'208";a="126267959"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 08:26:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGaevJphCrVaLvr4ZcMesxNEnMRzKtKwDnqXsQ/v9lHe8bhIFnr8/F4MKq4kfO+LWAmg2ijkvBPBy6+kcmJfubdek/kHH5Ac0iD0XxqgFrGdkvPJcExtZke81kYtd96lg1j02lY0mkj+J+698LSmhb7n3+UeqbfhueI3E1pODRo54517gwCRnyVTFnr+Z/ROnPyWzkKM8/A4i+UvzqZZlljcfMmtLDOGeQbASFeXJGn7oBaaTALSN1dgOTLySmvFYavGEDNDI39rSB6K9W7LMaauPhu2B0mTqSgH/oVk6cph1VzKca9MX6llN9ztM0/zO+C3jnsYxKlG0fmaH8Rbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wkj7ckoB9rgmxFWqukKNPAePqPqp3J1vPiEy8c09Oc=;
 b=XDdIQGMGqi2Q/3fgkvOopa6PaI5OtbYWgOFOOOqfX2L9bOIHQ9gspBhQe0L+FYotERDnNhRf3UeWxskg2dIUeKJS4joyuD6Wv8VTZiyym2M20E/R/1LJ7oFLVKgcCFwmulouaAibNw2KYRcBkgsrXJl54fE+iXsKelvqv2h62XH+T0vq/WdHRsFU0QCo8RzTxuj10ZHzvWfYCuRtwjBBZd2+aPd4wpPr4gqBOz8BuspSRRBFiJQrfBzd6Ne5jGxW/8PZEjGwmCQ33Zz1okOHTXtOAog/kyBtAL4l70aDAqJRDw4hdFpfMk+oU1Ht466fylAEfIEiBM1nDL7pcHxIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wkj7ckoB9rgmxFWqukKNPAePqPqp3J1vPiEy8c09Oc=;
 b=CFuIrEPZDUGFDv83O4plBqadR1+fSj5w4qDBHf1fOve1m6cqlJCg6n0m1qPX7YLTX3BfXCHEZTZPi5bmRlrNIEZAjgSLcqFuhckd+b6s4hmyHapZJFKA30wMoFYYDB0J6+ie6GjLD12EQc2Z3o/WecUhHeBqzaQ0nmXcR4WKBeg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3928.namprd04.prod.outlook.com (52.135.213.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 00:26:18 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 00:26:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] New zonefs file system
Thread-Topic: [PATCH 0/2] New zonefs file system
Thread-Index: AQHVsRth1IpCuMwSZ02s8MNISyP74A==
Date:   Tue, 17 Dec 2019 00:26:18 +0000
Message-ID: <BYAPR04MB5816894E05A9334C122E785DE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
 <20191216094241.til4qae4ihzi7ors@orion.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f01a255a-8f03-403b-fa3a-08d78287bc47
x-ms-traffictypediagnostic: BYAPR04MB3928:
x-microsoft-antispam-prvs: <BYAPR04MB392820DA36A14F088762FE60E7500@BYAPR04MB3928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(316002)(8936002)(53546011)(6506007)(86362001)(7696005)(26005)(71200400001)(186003)(110136005)(9686003)(55016002)(2906002)(5660300002)(81156014)(91956017)(8676002)(52536014)(66476007)(66556008)(64756008)(33656002)(81166006)(66946007)(76116006)(66446008)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3928;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMAxZQ+OACJ2azuqfMQRGDGRVWrUfPtS3S0t1DYchCMMNYlR66T6dc+ZHUhIfitC09PHqCE22MUn0B1rGc9MtXF1+yZWvgii5OG8cYd6zTA2Rbt0Qr4q7Ve2oimpzpjUTwyc7HuZWpICpqyqNL9E9vfB1K2OQOlivk+TBzLW9ebax//Q1DvxKi5w/pXyBc6t99S/e/4sx0zlp0192ZcX3RGEzIdA9G/qzxDlKEzAiWUb5lQwewW4LSxqf4/oRWM0L9vzVvF6h2DVHskIF1yGdIOgcGoVAum1S16l2d8qzihibm8nU/CF07Tt8isZFEufVMNrmxTyD8zX9MiNtACNotC4QiZabjvnZ7mkJCt2Srl+Gg48O74UWxGyI6VobdbUXwipvmzu5OeKvVKHJJX4SvHYm0TTV7ehU8f3yCr6zO2hj0bkuhxF9XsxGoYMdq8h
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01a255a-8f03-403b-fa3a-08d78287bc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 00:26:18.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj5ls3eboo80naIrScnfG09J+uK4rLdob6tX9caT1dt/zd3LtCd2LoQ6ZcndPsjx9wfyoXWV89Hk2a8PWQVKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3928
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/16 18:42, Carlos Maiolino wrote:=0A=
> On Mon, Dec 16, 2019 at 10:36:00AM +0100, Carlos Maiolino wrote:=0A=
>> On Mon, Dec 16, 2019 at 09:18:23AM +0100, Enrico Weigelt, metux IT consu=
lt wrote:=0A=
>>> On 12.12.19 19:38, Damien Le Moal wrote:=0A=
>>>=0A=
>>> Hi,=0A=
>>>=0A=
>>>> zonefs is a very simple file system exposing each zone of a zoned bloc=
k=0A=
>>>> device as a file. Unlike a regular file system with zoned block device=
=0A=
>>>> support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide=
=0A=
>>>> the sequential write constraint of zoned block devices to the user.=0A=
>>>=0A=
>>> Just curious: what's the exact definition of "zoned" here ?=0A=
>>> Something like partitions ?=0A=
>>=0A=
>> Zones inside a SMR HDD.=0A=
>>=0A=
> =0A=
> Btw, Zoned devices concept are not limited on HDDs only. I'm not sure now=
 if the=0A=
> patchset itself also targets SMR devices or is more focused on Zoned SDDs=
, but=0A=
> well, the limitation where each zone can only be written sequentially sti=
ll=0A=
> applies.=0A=
=0A=
zonefs supports any block device that advertised itself as "zoned"=0A=
(blk_queue_is_zoned(q) is true) through the zoned block device=0A=
abstraction (block/blk-zoned.c). This includes all SMR HDDs (both SCSI=0A=
and ATA), null_blk devices with zoned mode enabled and DM-linear drives=0A=
built on top of zoned devices.=0A=
=0A=
On the SSD front, NVMe Zoned Namespace standard is still a draft and=0A=
being worked on be the NVMe committee and no devices are available on=0A=
the market yet.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
