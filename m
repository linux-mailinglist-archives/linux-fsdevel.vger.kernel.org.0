Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32015AB2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBLOpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:45:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63036 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgBLOpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581518718; x=1613054718;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=orUCshZ4d74e5b+k8MOq4ro3duSf+R73dJkHkDs3BaM0+9SIS1j2Qwyd
   GEgMQ5LxzUcvTVcCoGPmI7KT3aWuTS64l0IGmMRxUFgNDD57ZreV3KIMH
   wNEJGJyrG/THDDl8stM9NVCxX8fmKXA61SW711AHWz2mCCGHiVWpO7/7v
   DsljpE3ThOv9TZnYEBuWxL+/2gIrD/2l+CN2k/rzl3dmbKOlY4uJPwX/S
   6E09Z8pbhFpxvZBocdH4oZGQR0VtbHdCQSOp83ufPk+ZPSWBAq7Uixtq9
   0kFZAx6M4R1ORG8AhrlHX7BeKaZJr1bgPAMCpFYBN5OaAJ0c/6P77oHTo
   Q==;
IronPort-SDR: 1AhYCgn+c1yLa5JVMp/ZHk4ae5HpeVo7dbJ5frhwwtKLvV68JfFcQQrC6QBFExNAQZnNYVlfod
 Dw19p//LHgcrNXGYy3N99u6o3g9mvJA5JEcb7DH0+7D6IYssUdyfK/EwHWKhhhmw5qVXtXpR5/
 /DJR4l9/al957hPV3bj6N/ud2kGIh5YSoB8E6wcOK7U6jTOht666H0Lr+BWV/ahjcYFLw1oSDw
 wAlML05QVm5ZuQafeGanwyjOZZdIG32fXhbBl0AWSlXMFConvbGXuue7S74CDFkC0LPa7z6ewD
 8Ew=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="237696303"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:45:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2zolxkCBfkni270opJA7BRFAum77TrvPD8a8XRhsyrLQywkIM7NSBXv/fbr+zCrXhxhsVlln5rdYXNq036suwplRpI1pZxKcYSr2qUrOx4tA95hfDqPYjkhbhmeoRH4rGeYqK+2ee+iDbK7+i6zFvPGYJ5R0uVCCfsbBGcRIKBYGK2SLjI7Qk5HcMSlagQ8dCoTz/NY9A/e9JvvWWZWoVX6Wo1gwow9fDQJ9X150oxx5OoWwVBw6wrdl8JLsrT7FkVg9U1nFek5yf+60BUwGTb2hYL2qjtBsS+5oJxG7xjnIKp4NIvILeICBBX0cK3fuAhvq0UptrHv5+9DYsEW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Nmv5gmdKSJMH4t1ogX2Q3bTdGG1TKZs92cX1UjkKjYllFDuqbJtEJuoPlK9hFUkZg7ho5enLwEapGSmP+p4wgseLbGl5WLRTdExq2jAe3FHoX9t1P/8TGb+IWE6ArksYDYluym4mB+r4447V3CuArsGXA4qiopR+74zIMcbjU3TD7+VUHw4N4dgMpK7al02T/4L+GDbdP8mlae4U5eKEGVA1G4N86OkRNcYgKQKQVLfQPQ7KT7q+2D8yJwG3gt1l4qEosJ99f0HZ6mp9qiv3dAonaObB8vXbbigozRFFZDAxjtJsOmrMPLpszUsG61USBUyGjf446N7S3ZD/Bzhm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iTt6gWMl/8VKMdO5IDJdEkF+tPaDN3dpoEe48t56KjCLvbFlPIqq+kSf+gXTaXaiMQUlLWx8InaIGTEcduk2m9VdLc786krpxJzXsG0IULyA0TWfCX22YlEysy9/JchKQeeUWexJyG+91GqIl+NqoaCfUxd4kAAemKJH+XrWDo0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 14:45:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:45:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 14/21] btrfs: factor out do_allocation()
Thread-Topic: [PATCH v2 14/21] btrfs: factor out do_allocation()
Thread-Index: AQHV4XUKa9fWilmUoECCUgmRkvquoA==
Date:   Wed, 12 Feb 2020 14:45:16 +0000
Message-ID: <SN4PR0401MB3598D3D16488FF95DC2DD3369B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-15-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ff3e45-d3ab-4533-e508-08d7afca2cfb
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3711E559E8321E22DD0DAF439B1B0@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(81166006)(81156014)(8676002)(86362001)(33656002)(6506007)(71200400001)(478600001)(55016002)(8936002)(76116006)(558084003)(66446008)(19618925003)(66946007)(91956017)(66476007)(66556008)(54906003)(64756008)(110136005)(186003)(2906002)(4326008)(4270600006)(316002)(52536014)(9686003)(5660300002)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpeBQ2U/YkF5UKIiy1mkNvHnyt9qMpJa7OZiGlKC+EKFi5RhvnI0YfKfVFUyd4QgyM3dDuFe6PjKNmRWdADxGx5+24UfBff4if9PsvZY65eaYitxLRNrmv2GT+odw0RJeL4xWQ5to1SMhjVK03a8EAbl8X/MBOAYXvkvUoFYD2Iya4o3Id2xBa6YdYsGgP4zbnOkWyqpcjJi8/LVZzH46xIhlrYRB1s0tu/vutnjBTVc9Ihz7oN8XhSl/cx9HqysqlYUzEOYZ/jVFE/Lg894W/lKaAHTHkiaSkwudeJC420U1nyIX5HEpz27vIKUg9vmiQbRFei7mBDxZH3XrQHJGG+utOib8V0sFghupqdAWNGlLfJRs9PAhTKLEaL7ExAPOkvnZQM5cVe+oRtEduC9cHQERhtE80q0PMnnxKqKAxfCGqYuxinWILjvURSht6xo
x-ms-exchange-antispam-messagedata: E4pS4UjwMMOdTVCCNkMw/36zxclUjbd47vmWtuUmCLd6uKD0mYq1UZ9A56j7m4FdQcIo/05B6UkPnskL4vzbs7Z9MJCHYPHuykVo5EuKtf+JNSlgJpo2M49eZrBvIdRPrUWyeFDFgMKozrELcodftw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff3e45-d3ab-4533-e508-08d7afca2cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:45:16.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9x7gGqKfMziEW+ugPLJwP+WdaVph2u0iF14VdqvvXbCKyba0exC4q01A5CKREW3foDNQGAm76Mcmc+ZT9dAT0PJ2sLg1eVzFkHSXNcddoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
