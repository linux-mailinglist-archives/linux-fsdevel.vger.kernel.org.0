Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1131314AD7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA1B00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:26:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45565 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1B00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580174785; x=1611710785;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gqfwOiZBw0v/X3RwcF/xvrEUhrFgoxOCxz333LKzd9o=;
  b=GHx7bcGHatUrrPNCY4Xub+Q/MWcvdcZaaqsscyOI07MERqNJLEYlFkZe
   z+DdQf8lMJ+3JdnFYtVnC5+GJSS1SFyHSRBx9WVusiR7RHmzXp+k6lGor
   J6LL1l84Ljba+YpXbmV1gSXKXMqUkEyMzj+Br1dc1ZtQ4o5JAfgTKVESp
   3FGvnG/5HJbYjOiOnwUKCgjOtTWqDSfNdxL7RnoamkiIH51MQpY4yTcq7
   ngDxE1sVCEx77l1JxWP1M+8odFZs4Rw8A8LhUrN8OTZ2aMIUh+jgZINlP
   DhJr+znkgOQbdcxAyJhMCKKTNwDLa1em584G/WDZOIdda/8pB04Yif9YD
   A==;
IronPort-SDR: UiVTGnq6ZDFBI2VBHS8VryXhw4PGmDZ3a+09Ra/iPYi6rYeVB0Ocq3oWXfsMFtq5SiWy7rBZOL
 vegiGmULOQNBX26v7tybLn4ZV9Nh8iRuTxt2cFd5kuyG390oppv+Phc9Nyoztr3s2V/xR7QNWZ
 uXL10E3HyhFGeBBKpJc/UkA/vjT4U6mqxUo/280jsx/E8KvbnsxMQBt2yro0WkfgGUHqyXOO1R
 jgpLp8EMVxYIdpdP8cCjrtPkST5PqqVWfhW6RGl3kyNJhOd2Sgb3IFotXUuqN9koi8eGXzabgS
 iXs=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132897127"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 09:26:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goRAYabnKO7eoIjKTefbCbFHaK9XeUsI7YU8iPnU3/8th4BzRoAgFRoaeB7ZV7zzfKeoXYIEXm1+O844BQFaddNOvbQ/9egZHqJV1A+koAKb9kuhT/zfGzAAos26lAoVB6x6D6e+et/T9s7AjYHI0NnKX4hTfvXCcRBbhhibj81IpYvG4Ptz/EarGZ3mECnfskEJxOaEbl6t/AYxHzb39D56LXRGRkWr81Ntv0MrvRD95n/yb2UUjvGMeBuCVmQ9oVWXfzXp0Yr1k5rw5ta0dKaCMUGOwHhkBeS0isEPV4H8BN2c8uwdpfxF6hha1oDtZxjg3pNJZz+beNWsigppDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqfwOiZBw0v/X3RwcF/xvrEUhrFgoxOCxz333LKzd9o=;
 b=Sc2rj5I9eaZGy/O+FvoMmFWSqeXc3zFSh1wZgetGEqJ+2xlE9/AZAsH5A8IIuwM0Tq0KqHMWakFoWXW8IR50PQADDdlvyuU4VchXCjxcwK1sQSnFwzixTbbwWONIO3dOku1Xbnj09yoDhDyoaClKIBahhBkFnPkHtH+3MFInnGOKANeK43DbSLGJS2zJmLFV5QpSOUFwhoxfuodT0HqwFNsm4bYan4APTA+nC5GgEYskrzQnkK8Rgb/ZTYzEUx/WyagawJAjrqholZ3ntFWcwTuPT5QYw5p8uyZGDbvNTVizI+NDJ+XPY0QJTqncZG7k+1gV1aFtX27hpiEuUjUlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqfwOiZBw0v/X3RwcF/xvrEUhrFgoxOCxz333LKzd9o=;
 b=SVvUYVqrCCfrU/v9zjsNDwpcGiEsiw5q+3c9Fpq9UWATle6Iq7Hiunp1b/VozGDCXL+DkZU0drRnL9O+bUECg965AlH0oSaq3X/zYzNDppNs4vfsD/v1g/+DDUe10nhqTtTD6mEe5EJwqkeVqCihBh8HYDa/jBpG1kSCEGxq60I=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB6088.namprd04.prod.outlook.com (20.178.234.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:26:22 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:26:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v9 1/2] fs: New zonefs file system
Thread-Index: AQHV1RAutcHD/Pi+Kk6hD9a0Q+BomA==
Date:   Tue, 28 Jan 2020 01:26:22 +0000
Message-ID: <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <3021e46f-d30b-f6c5-b1fc-81206a7d034b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15ed1390-2beb-4aac-1e77-08d7a39115ca
x-ms-traffictypediagnostic: BYAPR04MB6088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB60882DCE7199618761B3E5EBE70A0@BYAPR04MB6088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(7696005)(66946007)(52536014)(91956017)(478600001)(76116006)(186003)(66446008)(66556008)(9686003)(64756008)(66476007)(2906002)(26005)(55016002)(4326008)(53546011)(6506007)(71200400001)(316002)(110136005)(33656002)(54906003)(5660300002)(8676002)(81156014)(4744005)(81166006)(86362001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6088;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHo2pnoRY/05A9vJ7IXxh6YdDzKcgQ4FeG9wNW988KaSWx26IX3i/WvFpxBm1V8AjQkPYO+QEUr64LVW26neEY37ib/KKeF/el0NE5A29YAlwp3tflEhbpvqcXNUmq96is0q1UQmtmW/2U5N9tn7leSAeYip4AuW/9bub1wbL0bYSttXsuI/TRGgIJLqdvFtsIfelmw+hZ7dgU6Zsxw6/t605lb6ucn5L7IRnAgodRs6CHOp3Lel+N3xvITRpq0ldneMgnhRfvlBMwiAuMv6Nft9pxXhDqsXShn5d+Q3r8jIReNNL+xdChlXYQ/72t6GIVbgJjYAmhZYBE4g7KKyewQLBLHoW5LiMEmJ2FmJ6MAnlL8fsys8N2JCO9pKS3jwqrI1h7+5y9UPZdRi5yhuTYy8gpY1by1GudVy34LwpeCtPPp326aszoLFSAPJ4nUy
x-ms-exchange-antispam-messagedata: U+bHVXO+Xd2DXRZH01F5JQsBgcknck3xyjSOsJ5YozVYggMSnM/mAgwVJn5wuSx3c37btKeE61Lr0NsruyDUGHE5zR2YcGQqnusWrMvrZ+1XCe4QJTbV3cHPBikm9MIuK5RWXo17gnETL0wmGYGizg==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed1390-2beb-4aac-1e77-08d7a39115ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 01:26:22.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HIHj22g2zfqbXNTFRJjztQtSo8I2wqkOak0ml75NXbPgYQW9XmwZDgm+hfejKgWEKvyYF33wXD8DDmo7Oretw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6088
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/27 21:49, Markus Elfring wrote:=0A=
> =85=0A=
>> +++ b/fs/zonefs/super.c=0A=
> =85=0A=
>> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] =3D { "cnv", "seq" };=0A=
> =0A=
> Would you like to keep this array as mutable?=0A=
> How do you think about to mark such data structures as =93const=94?=0A=
=0A=
Yes, good catch. Furthermore, since this array is used only in=0A=
zonefs_create_zgroup(), I moved its declaration on-stack in that function.=
=0A=
=0A=
Thanks.=0A=
=0A=
> =0A=
> Regards,=0A=
> Markus=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
