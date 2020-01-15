Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5413B981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOGXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 01:23:23 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10159 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAOGXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579069403; x=1610605403;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sBz5yEynQN18sd3/+XWiGtBHqrV9RWd5M+5NMRde7aQ=;
  b=m3c5MLG4XOJfs1j7jHz1Brdzgw54YuoSA99w8/PCDQY2Ul0r6w/cfOyd
   0ynBH7VLCe824Z/uw/g5Oj919t82H4qM7HgfNOntpXoA7CpN/YnWk5Ia+
   tgvjdko25et9WpLqjabD5or5CJhThqw9NUdOV1nz+R/mZbKYWOaAW/qG+
   XdDCZ/90OE+1x99nilthGGdPKlDQXSHEEJvgQrJdLhU1mUh/MsLfUzz6W
   yhjjUrnnBVtq9I3MPcMrZqM5dcNYOMoEeq00rLwAjjRwRXQ5BdURfuvw5
   BOBvd3pLivD838tzFuSSW/ZU3KccpIKfQQZ3llkS4zCDY1IepT8qWTafb
   Q==;
IronPort-SDR: DGmXEaYf4p71WlXzu8rl3JiLxVtqmrWsyTa35Vut3X37Ohodte4KpOydOIEkpq4cf6UjGE6xxm
 OW+JiT6KgVlsi/nJRlyQmp9OXxV8JP0jVbwywT1pSJ4KK5gRxhmCDDzFO6We7/0yjXk8ANhFpw
 z6Z4pVQfWH4KrDnhENrBfpPIBmfwW1ZJW4mjnhRpbfJgJg7z1kNU0G5WVO8+1KzE7ECUEjb7Pt
 hd2df+DyoV5/b2KKEW0GvP37O5gskaSvuoS6nkRyE4rVSZ1QteR5XFvTRsRhWCk7tNX34+B0S6
 glY=
X-IronPort-AV: E=Sophos;i="5.70,321,1574092800"; 
   d="scan'208";a="128189428"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2020 14:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5dxsWU9IFeipfT5r8D4UWQYXxQNqTntD/IE1ZUUkd+2Qc2KJZXBb0ydAMT6qY1J19YF7w2WZkPep/GVyKRZwlHUo7LV4c4Bo5duV5JUCdKteLNlEQ+pG5gr8/c/DtvmJQthKd4rIuXyDrhMQ+UAO5oH1p9hDiEuIGtJNUTwpDyLRT4J5dcr3JFt8EKBA34rRQeHoia7+Bvv6lIW+IEOT9Fija7D3s5ZHphv5P2l5IG+3SfTju8gLGq7jxv7HxqiIjB0u6XqPL97wPhfRAM+MJqmKAaUqzbtXgWjz65CWqfD6yIq45FykvxUpqpdY6mXCxxCCbXeTPXaZO2E5ayTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWE/mkm7IsUVt0WVYaEldwnjKiX+h8hPPDaLiRrFU38=;
 b=fEWt9lx/ShjLMP671Y5LAfZ4u2AmO+Zvt2+rpSZ+lmoP+Alj4g2o0TX7gmmrNsB+RhM36faopx2ftUYRaUJEgCAoQmWz4Uzvzda6GLVSx3Hqx/AuSvkMUV3HXkspxXyda4nyc5WwiPagi1sukTMlMgR9sNxNN2ex8Zm8m4mGkTxR2LwfZqmE4s8kICK24G4NWFN5CBklwNtOhE8BWxw6EPTN2gQIlu2frd/xQQYTnqU+C6ZqiwnSwewpqxzdXtwJR32K3Q/cTlDFRUEXoSZHV6E9xyLXt2dEIv1Var6np+K/JYNveXAekEAXftUVc1YDHy3wYkRf1fH4Q3bYsgjOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWE/mkm7IsUVt0WVYaEldwnjKiX+h8hPPDaLiRrFU38=;
 b=KdmrF0bzG7/DIvt2Lngj1dK+Vrfp2Y4oFqPLOiqvB55h8czfTK+ZvitO2Qfcu5jgbMWJ1imrlgBgmXSnv2HG4IcFgodxgKb8HI2OdYev56MM/8V98bLhve0W7jU1mRSNqoS51Wr0ajvNo++UwiQGay5ZX+ARA/Dw/gyxsG9SOL8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4261.namprd04.prod.outlook.com (20.176.251.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 06:23:21 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 06:23:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 2/2] zonefs: Add documentation
Thread-Topic: [PATCH v6 2/2] zonefs: Add documentation
Thread-Index: AQHVxf7Snqi2k881OEaR6BUy1rYblA==
Date:   Wed, 15 Jan 2020 06:23:21 +0000
Message-ID: <BYAPR04MB5816BB7B5946E4E8643F9DC3E7370@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108083649.450834-1-damien.lemoal@wdc.com>
 <20200108083649.450834-3-damien.lemoal@wdc.com>
 <c9f37661-03a0-22e3-4b99-b97c47917b5d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.180.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5750383-3455-400d-8d64-08d799836b22
x-ms-traffictypediagnostic: BYAPR04MB4261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4261246BAF8E83DF2DE0D2B9E7370@BYAPR04MB4261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(64756008)(2906002)(54906003)(71200400001)(66476007)(76116006)(66556008)(110136005)(186003)(66946007)(66446008)(26005)(316002)(4326008)(91956017)(478600001)(9686003)(8676002)(33656002)(86362001)(81166006)(81156014)(4744005)(6506007)(8936002)(7696005)(53546011)(52536014)(55016002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4261;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DV6clk8ANvLBaYd2uOWu83DX5+SV1gq4hzDFLuf/AIoV8a6Vn4AcbALaVCuYtV9Su4Rf46i23I0UuEei2IPrLox2U6l2enav/EpiBwazbYpMD0X+z6y0TMLKvWqewqaSxpQSxF9ObNt5QGT5vhVQOLW1Xx6FAivQsxFtOwQUdNFHPzvSU72SDVEG7Q4GVwzps/gh3N4A10o2i/AgBO9fmINd8F4xnwPTZ5Uc0abqctVyFP4rDPdGbZTTDwLYCJGWULss0hwFfla1OMeI7/I29U2a4d0fKvPDgNxWO8FBlS6ty9TSYJ65J0cqRIb30/MPsA7S8PfbtIyJxZkRJBv5DNQ2NMGP8p/zsv3SPt4jN5Du8CWsGj0JVeALKvCgSYott7Mco96vYibab2q6fiOIJo6vuCyvAh19vlQThKA+ra26ndGsYbYNuhHM6aTsu/Jd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5750383-3455-400d-8d64-08d799836b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 06:23:21.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9HhkHjoBRXwaPm+ObpjtZxSBuuzCpRiNjotPvx5d/8h6Oe7UnVNO0Qu6058vlA7wteEOvipo8OCmNkfGp3Z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4261
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy,=0A=
=0A=
On 2020/01/15 3:25, Randy Dunlap wrote:=0A=
> Hi Damien,=0A=
> =0A=
> Here are a few editorial comments for you...=0A=
=0A=
Thanks ! All fixed.=0A=
=0A=
[...]=0A=
>> +For sequential write zone files, the file size changes as data is appen=
ded at=0A=
>> +the end of the file, similarly to any regular file system.=0A=
>> +=0A=
>> +# dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotrunc =
oflag=3Ddirect=0A=
>> +1+0 records in=0A=
>> +1+0 records out=0A=
>> +4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s=0A=
> =0A=
> Still slow.  You don't want to change that?=0A=
=0A=
Good catch. I thought I had fixed that. Here is the updated dd run,=0A=
after making sure that the disk has woken up from low power state before=0A=
running:=0A=
=0A=
dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotrunc oflag=
=3Ddirect=0A=
1+0 records in=0A=
1+0 records out=0A=
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s=0A=
=0A=
The HDD write cache is on and empty at the time of running this, which=0A=
explains the much lower I/O time.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
