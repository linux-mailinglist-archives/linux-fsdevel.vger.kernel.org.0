Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD6285898
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgJGGYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 02:24:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21825 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGGYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602051892; x=1633587892;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UqrlOubHDfl0B53VvNXTq/PiYnCln13FoCAOfkyk1u0=;
  b=mHMZA0onnzq/AYTUZ11hLiXoKkNrP279Y4jclvYGNK4dUjv4EJcRleFm
   wOotqVvEHGPa0TVASh327/Q9ffUmW/k3N0YuXAVVtN2vXzkxSZ1efkg8j
   AM5TZ0xgnCarezOfofM/5QyeDyQFppferhUyoPHwQCbz7QgQfDc/PeVg4
   54t8vUigUniWhUpyDiOeiBVmtF4yJn3WPFPIvQwW7k/EPP5iy9LDZX1JM
   2JNf3eDQ9n+QyOgC4xfwiYajLP5n//KdGNlao8xh3uE/BLt3viQtMHzpx
   7qEcqFLZ8rToaYnH3zjGOXUZaky24e3RXdXTRKaCGXLqQGZnnVBjWz/Ra
   w==;
IronPort-SDR: AMMQLtl62OKJTTH6q9JhnZd4ngFfR3OHis44ph/oQ4GBTHNcP4p+F4lJ8fExlh+g3xTBI/4h/i
 yfAxMIkqm9Tl/3CK/KIT+CT5pU0HT5h5mUYKxQn1cWgZ6biLKoL9fbZ0dYQl3sEyQZBpm8/FwA
 FI3BrxQ70nk4YnfLcUjyH7OpQy8nAfjn7wh9rqVHujYbqM4LlE+lSclB8Laf4bNCn5cjdjFvKD
 9Vkz8VK7FWWrI3bKK/+JJth05DKQaPfOPqrP+ezUAUsHpqu1izOsCYJN36yIewukwRo7kNi4Ep
 NrU=
X-IronPort-AV: E=Sophos;i="5.77,345,1596470400"; 
   d="scan'208";a="150454308"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 14:24:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdYn2096QO5cY7/zEjR7O+f8mVgi7aU7F24/fYK70inoDvdDSHabUoZ7rFKdMaU4NRXs/vsy755ciOUdgbkDmTlJobpTqeRBtz3PRQKp3W7uofmA/1XCJpJ7v2prmhoe+E/+aYq3J2BreTCHis7fmT0a3O5cA7Bdv3lUlq+143D6tLt0RYSgrJezyU3Zvj+LDtGXJn6kkOH43oZQ5SNIeKdh25IEc701JgrE4N6XOr5xdd4fpuzB9He2C2icWj2qa6goMMja+UY0vqkLNClCPn3wOicIjcuNCKjcd0HH/qDxv8QqpxCCMOzhNJTJanW48THfxEqOidujfQ9UvOlvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaTuWEgvFJnyD/2bUU2Ss/2iRpi6zjVmg7mE/4ishQU=;
 b=Mwv+QtnH2tictl5ly1UU67u3yDV4/JK7KYBC5SlfsbH8Yd2P+R8ZA+DX+39KGFbpZDztE9sAl7iYqFuhIBNAznW4CgsLphmOUtts/X4WGll9h+NY/kbRaxyQ9cGbUOnjAEPF7jor9LvorUuSjQfVU2czmis35wvnjgDBtlD/XzMsrWe5GdZyXZjj6NlL3vrflftYOqA05Zhd1Q2094mpTeym3XpTEBkV0AKREljuhN9gUpyp/p5p+ixJ1mHP9q+KnC5ZXhT9EO7X20moCdSNvQ2QfpHCYrS/nC9VG0h2VRePdYZcE+16QT8SG4AT7aarL1R5banVk+UW5rMzO0CTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaTuWEgvFJnyD/2bUU2Ss/2iRpi6zjVmg7mE/4ishQU=;
 b=WWWu2ukOaQzaXpmW1R5Itdp/wWpR0sUwyXKZ6a4SmSbtDxk9Or1KC2qNiyVF9BcaKkMojFwjzcIqIhbSgUmijJSuDsP4xD0mCx7wVTyvHenc5NKf8cuTsWr8ETXMM23R2OYZ/cpVCsT2PhF9ZoR4p7MVwWxa/R5Rfqqek0M9xVw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3634.namprd04.prod.outlook.com (2603:10b6:910:8f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.44; Wed, 7 Oct
 2020 06:24:50 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 06:24:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Thread-Topic: [PATCH] block: make maximum zone append size configurable
Thread-Index: AQHWm+sZVX11KkT2FEibKlALVuOHjQ==
Date:   Wed, 7 Oct 2020 06:24:50 +0000
Message-ID: <CY4PR04MB375165E4F35DB78390ED5D84E70A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
 <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20201007055024.GB16556@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:6966:9231:e6a:2680]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ae2aaf8-3169-4e15-fe3f-08d86a89b235
x-ms-traffictypediagnostic: CY4PR0401MB3634:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3634930C1F5980A72C2C2B60E70A0@CY4PR0401MB3634.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIW+Wzf5kXNyVKE43b7mQLHI417emzADk3O40sALiVSg+/CtdmXjOB32wItEbbqxp86aY8bRzrf1dd15TDSyQF7qqiOMJGiNRB9CLyu0OTTl1dCCkZVm+5JlGylVMwLAj1aCZKypEkZnb4jWdBzQWI0X1YjvAmD4We3jwu/PD+2o/bqlVsXXf8iFwTj2ZE7O849CFMEJsAuZmY9OgzbX8UziQ8BxBtWR/RJ+PqTBkOB0bRSNHAGeK6R3O3kJqtYaQ5DvbpCi8t+G6SsUw/sc0kyHz1fpXJchgMeSAQPp6zX0QZg44vC31dL+7QZeZv5IaimWpLJQ7+9CdpVjmdDcoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(4326008)(2906002)(478600001)(91956017)(54906003)(76116006)(33656002)(86362001)(83380400001)(52536014)(8936002)(66476007)(66446008)(64756008)(8676002)(6506007)(66556008)(186003)(316002)(55016002)(71200400001)(53546011)(9686003)(6916009)(7696005)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VwTwGv9AuvFoTR9IYIzribpid+rfmAq9dZrIG9ew2BJKmuPTy2YPQIU7eZXAiu3NB0bTFm4c7ghVeZfNMXfh2PQmwVNwKGJVHed9eidMwKhvRe/fvJgI1bbjvM62MNGvlHm6jwolOoCrEtzVAYpvrNf5L77nQsrz6H+8yGNqQyAE9Hvszhy/EQFxxLMWoiCeKWSco3L9WylyDP1pXyeQoEKuJmhUjeW2TlAtTIpx2SyRVgZl0c81OW+XXuIjZC/9LsM6MrYEYXOBnRwt8sm+QgZSHgs2w5XUZQ4cr1YRz7ABrQDugFOcJIBTsOcU32w7/pbF1Cq9mW0gaBpS7s0TXzO7AdlF2BOO7HSae5mIvd4/c4dVT0m9tQOJalPMmFtWw2r/ONw9WXv/WP7lCdPNueNsfnRtGFSdjmVTOiT4cOMt92C3PCAVMQAVxbenLk2dPG88L5PMYWmko82UlBOm8pRbpuXEAnun2ZyGWxeHTfhrZ/2zMDd4Y1wuNzAQFdMW8+UgBi4T601KNt1rM6eLk830y3YELTjyxbb/qYbE9B7U9BEgS3CZVQl9lyD8rI4Q6VJ+8wVTBYCtlM45leffUfmbIE0l7EctmhgjoVz06z/1f0r0Kk0gH58AA7A45PJxrXWJWyu7601KOVhZUA8JzgIJYskDJo02mGalezVKiYxlLB74+By6bckFCbz+Rc09BCMD3S2SZ/ZLqyOL+w57wg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae2aaf8-3169-4e15-fe3f-08d86a89b235
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 06:24:50.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6MDaeggIvj0yAQq4yaEK/XZefokmWO27Szran2E2S8vYWs6/SWQ/wemdJUPttS6Yekj/hf9dkDdi/G8SIphxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3634
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/07 14:50, Christoph Hellwig wrote:=0A=
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
>> index 7dda709f3ccb..78817d7acb66 100644=0A=
>> --- a/block/blk-sysfs.c=0A=
>> +++ b/block/blk-sysfs.c=0A=
>> @@ -246,6 +246,11 @@ queue_max_sectors_store(struct request_queue *q, co=
nst char=0A=
>> *page, size_t count)=0A=
>>         spin_lock_irq(&q->queue_lock);=0A=
>>         q->limits.max_sectors =3D max_sectors_kb << 1;=0A=
>>         q->backing_dev_info->io_pages =3D max_sectors_kb >> (PAGE_SHIFT =
- 10);=0A=
>> +=0A=
>> +       q->limits.max_zone_append_sectors =3D=0A=
>> +               min(q->limits.max_sectors,=0A=
>> +                   q->limits.max_hw_zone_append_sectors);=0A=
>> +=0A=
>>         spin_unlock_irq(&q->queue_lock);=0A=
>>=0A=
>>         return ret;=0A=
> =0A=
> Yes, this looks pretty sensible.  I'm not even sure we need the field,=0A=
> just do the min where we build the bio instead of introducing another=0A=
> field that needs to be maintained.=0A=
=0A=
Indeed, that would be even simpler. But that would also mean repeating that=
 min=0A=
call for every user. So may be we should just add a simple helper=0A=
queue_get_max_zone_append_sectors() ?=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
