Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D20364242
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbhDSNCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 09:02:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33510 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhDSNCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618837339; x=1650373339;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=V3YqxnhMZBSwZJ4684l/N2cIOUNUNB5nMz3uUe2dXH8=;
  b=JL0qjVOZD6ReaootRSkqc1rT1M5Z7Q4faWcvtm4Ny5mz/3ivS4OlDB+A
   N6DFV7Y8VXT0DGuPI+tM7zfcmA9GozwlQxo24rq8IFXW24d7rOQed4WbP
   nL020pJNXosSXDlE2UireBbWpcGw4GBEHXBW/Jd5x9fri9DcD4oaxSSDP
   K5FzkcD4E2psy9bhgInRsX4XLt793VO+5YIRomK96PpoQDVuCHc7epS5C
   8qWyk+lzJ1N6d3MKbPXtpskKNZhpKxL9ohvxn/xrCyhznrx349KPebtZ9
   8SbYv3PX6OuU93AdHNLDdV2Xve/YbHtpRtkRPK3v59H6TIAM4BpBqCBzG
   g==;
IronPort-SDR: xqNcnZx1ZhrN+1NAKilfediZFlV5NiWhPTYVkmuEWjlDOoMtP08cwPMaGWmpEgaMuGUyzPIsG+
 jUOmD1VhuBGp27+ZNJgxSB4pvQ0g7AHy8sV2NV4yOoijs4UYRBwCvEGp5OQ7j7w9K8ttVAjWbA
 QkrgEXC5jZhCR80RfJuyME+/m4iFtqd5P0iANFqvxnHzhk4FO8WEbofUDviOQ6oHxUnfwPu9Ft
 hDq8gZyDdIvclATsejykKOLdIPDZJ4FnSK7skV3EfZozIk+BeIv3KqZHmqhTLim4UqLpJKYTjW
 kp8=
X-IronPort-AV: E=Sophos;i="5.82,234,1613404800"; 
   d="scan'208";a="169974056"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 21:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEbtfaZcLxCqAuOh3j+ogcGJSHDybbtEOnjD5wZpgxhc1AOuHuTCxnKKNonoBzj4T/SREwldx6nC+W6PeMeW9QwJrqOmHv8dzqxcA+cw/yA22XQxM+s2+eY/+j3K4b3Rqt9PyBvRKt8cGAKbn6I9x0KLh848cfJg3bLaElYeb77jPZKYuMaYxroMln+K+y/hHPz8pD01tKReWWdu9qG7BdnE2+xlQ0FZUJwzDGcMkp2odehTp0ccRwJtcD7Kopx6a/Lp1PUvOq0NOG5ihMUHCh9Z0zatclhLTb/xW3R9gRACY+Qvnoh4UAboRczuMScZCYVHG5UeoG1T1HzJbr1/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3YqxnhMZBSwZJ4684l/N2cIOUNUNB5nMz3uUe2dXH8=;
 b=FuUcsL/xPzqSlQ16REe40rIlKM2+zEtNdg5Ja9yGT3odelB3rsq3iAGh9UBQfWskBN/xvdhr9G6HmSOFiWIPuoL1brJLB5XMShpNcCObz9AVYWqMVNBHlH45NNX6GltLUJ8cc9PDLoESEmt/atYM9BVMXsY7ZZGTwVEkgCBQG0APmFTYme+nVS+eKKxlPB4vdwTCEGC8s7wbO02W+J9FRVvBP0GHrdYRV427GbM92SJ1qyxUSLuMDl3yYcRAqGWxWmb1TZUbIu5gbtoLHi5QiyvqNVo4zbI8sUM4/jW7D7Nm68wilz1UjQOXxWO3GncvWiwN/uemcRBmIJEHTmFnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3YqxnhMZBSwZJ4684l/N2cIOUNUNB5nMz3uUe2dXH8=;
 b=bojzCdsA6GaccfcOSev4c7k51oE9AWCakT9yWtEoa6AcTWUnVepNI9j9ZX1eWakWktBKMw9Hh0BiFkC3KBszxD6brfkPzTLo9qGEaIkA0hG7WxFPZoTQGHqhSbopQKROYFE4CCVDPDwjiGInMhN5fZbPp8Oq0GAXkhVKGBdjuGg=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5059.namprd04.prod.outlook.com (2603:10b6:208:54::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 13:02:12 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:02:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device support
Thread-Topic: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device
 support
Thread-Index: AQHXMzIMIWm8p8e930y0CZBnJXiLwQ==
Date:   Mon, 19 Apr 2021 13:02:11 +0000
Message-ID: <BL0PR04MB65147D94E7E30C3E1063A282E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d019:11b6:a627:87d8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff83eae9-22da-4d86-49bc-08d9033358f1
x-ms-traffictypediagnostic: BL0PR04MB5059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB5059115DD2989DC5D1C603E1E7499@BL0PR04MB5059.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLHAkeTYE0P0uo1U/rYH8iSdgehgTg/sFkMgpBvjhSFCP1l1tj7W39a9KUtJgcw/Sfb1uVXr30DNPj1yKdawH69GL6CU3Xs67IEojj9ISP1IIhVrW2IfGRlq+S9AN02+ezuMq+2t35h4hhjz5ukFqdh1xZlRh6h+0uQLi7x2DhQdE9zDGyoIWAjQT1N/carpjoIiJzzH+VHwHRmH2LhzNXvvFxTNeSVxiQF8rPrK0y/ndmw1pKtEqQsmQHyv6wkwXPjgtAoIX7/5QruTKc/CtI6ARGobRM5DT2vM+vg49GLEuDg5cj6KOxxVeA6bjEl+/gBJMhG+tHu6FC6oBLEUULrLMHaEfK997x75KD1wWFITB3nOvU0lCclVg3/JkpU4AA3C+aOsYFgJDnOk2eUShXLHl2ks450Ksch6T81Do7zGQj7yp+IyXPT+ZDgRN27XO1U7cWZIAbQ88DaaTUofmT+vM5nzUwnZCTiGTuHHVCLdrYnMl4pUQGK0N+qopoU7IXuqrtMo7q8U7ilwoqLYVnpMdsG1LlVM43qPVDM3OY6WzEFc57I/+eNonLMYYyKA5qlM/wq/YVZe512XKsGBAyKs6dbs4DXBJ1ELF3+rCsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(8676002)(64756008)(55016002)(66946007)(52536014)(71200400001)(66446008)(9686003)(86362001)(66556008)(122000001)(54906003)(6916009)(316002)(66476007)(33656002)(478600001)(5660300002)(8936002)(91956017)(38100700002)(76116006)(4326008)(7696005)(7416002)(6506007)(53546011)(186003)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j9TpK8qi93hXUy7xagj8wmKl6ChndPsz9D/LbdK43dE74uTGpGzqy//kBxiK?=
 =?us-ascii?Q?MuFsoV/OPUvzJiN75kJ8IvaF4b14cBDGzxIQ0BVmN7qdfFct3uUDzTkpCAHI?=
 =?us-ascii?Q?/QqYyOZtHEU+vR70kte5xhBi0NKH8BWEr9OTLnLvWlLuCdqmykb89fivPmmX?=
 =?us-ascii?Q?BWQHnJ3ATWswfgRqTAsh63gTZwg1bMahLUFWa34cX3QRk1Q0nMgaCseHBWU7?=
 =?us-ascii?Q?ZCTE2MUoL4Qfm/xyPUUet52Lmievw07WZa0cka/tiiWWpYAgnF5aAhhYw6WQ?=
 =?us-ascii?Q?T2YXIbpUoaWCFezyTYnlvsUJ6sUHmkosItPRleO/dtOd0rA0UoZl/eozndwG?=
 =?us-ascii?Q?Uc7W7Mc7gLfomR10aFYsN9ksl9EadgKPqckmtzcNM6WiPhxV5xOyA0lWqekU?=
 =?us-ascii?Q?x5rBoEs9O/MYfUnYIal2CxsCABzCNSzO1SNJK9tj878/XQaFRhfIuAs2EN7I?=
 =?us-ascii?Q?i8Zow/thZBm4JMqRwysYnml260g5W9g1YiVH/NVqlpgu56o72ftdhouIYWvD?=
 =?us-ascii?Q?XyxVKNuvMLe6kFfySIahhXi4jtG1r6+/F4YR9e+LinhDH+tBYciXLC6l/TAk?=
 =?us-ascii?Q?naeT96hUQcW+Gjkdcz1Xxqjj4dsp31DS+s+8HTCg909eQM2rmtJit1VwTFBq?=
 =?us-ascii?Q?klFlbrVk5WoffdK3/o5q8h5GJd9gmztkiUiNdPE7iIoZRCrJJ3pTKhVDykLw?=
 =?us-ascii?Q?7jiWeozPmCoUa7rHTF7cWnDMwGs6fP8A5y003TIm3+lo6A0dm+F93fyVFmBe?=
 =?us-ascii?Q?PdTYO83Z9CpozSd87itMDghN/IyGXlBGLQtnLzO+zntJU2AaDMozfBflfIKj?=
 =?us-ascii?Q?j4iyqNZ0TaLMdgsWSjjqgJKmGcl3toqvClW1E04A2u2REtcuQpPc/Rx4JEn5?=
 =?us-ascii?Q?QJ1C3+t+/s1UBt4TTwP3faaEfoGyq2riTmYQT8utlsdkwijV66wnfmiOqdZS?=
 =?us-ascii?Q?FevaafR9GrgD8fHayWoLNUkNQSvEHrxuZPsBAq4Sk0OAFl/SLV9eYQBOYUsc?=
 =?us-ascii?Q?8C/mj9wlq47+yj8ton2vsDgdlHaeD1mEiPIkAxjdLQyu6locaZYrMgaaO82c?=
 =?us-ascii?Q?RJmwLK2+EVevHmnKr2Er8ZGPWSnU7j/RiZekR26XMePoZik0m0kJuG8S3kvg?=
 =?us-ascii?Q?BGS/hOzrvNFBtk0+7dDcGTlicOHCXl2boLHPiKZKXmUGb8i4GN9mK35FUVip?=
 =?us-ascii?Q?b3wtfk0RIRzHqrnzJv69+QcNv2VjBtT7Y6Ex1bjLzUkc7ETGnKlLYqpDCyfp?=
 =?us-ascii?Q?qtHSc/vjO1bkaC0fdw9TVx83yAJD4WETepu1/wHhRSleaXWMIOPeUsvzssG9?=
 =?us-ascii?Q?mcAouGJhdU+q4sSJHs6nr2tSXV4bvPik5Sluk0DEFhDtE8WtZRtB4MhVGpGY?=
 =?us-ascii?Q?qZ5wuiRSuFK/4tHaWYl0Y27QMiZOF9yD7NUATXNQV1kyoLjF1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff83eae9-22da-4d86-49bc-08d9033358f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 13:02:11.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbIpHg7w9ScOXSYD0TxBTIArKUGC9rYLMkyxOMERoZ91nKQ3az01MHoWhy1CkMeVL2A/aCWYT20jgSau4jiJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5059
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/19 21:52, Mikulas Patocka wrote:=0A=
> =0A=
> =0A=
> On Sat, 17 Apr 2021, Damien Le Moal wrote:=0A=
> =0A=
>> Mike,=0A=
>>=0A=
>> Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector=0A=
>> of the zone to be written instead of the actual location sector to=0A=
>> write. The write location is determined by the device and returned to=0A=
>> the host upon completion of the operation.=0A=
> =0A=
> I'd like to ask what's the reason for this semantics? Why can't users of =
=0A=
> the zoned device supply real sector numbers?=0A=
=0A=
They can, if they use regular write commands :)=0A=
=0A=
Zone append was designed to address sequential write ordering difficulties =
on=0A=
the host. Unlike regular writes which must be delivered to the device in=0A=
sequential order, zone append commands can be sent to the device in any ord=
er.=0A=
The device will process the write at the WP position when the command is=0A=
executed and return the first sector written. This command makes it easy on=
 the=0A=
host in multi-queue environment and avoids the need for serializing command=
s &=0A=
locking zones for writing. So very efficient performance.=0A=
=0A=
>> This interface, while simple and efficient for writing into sequential=
=0A=
>> zones of a zoned block device, is incompatible with the use of sector=0A=
>> values to calculate a cypher block IV. All data written in a zone is=0A=
>> encrypted using an IV calculated from the first sectors of the zone,=0A=
>> but read operation will specify any sector within the zone, resulting=0A=
>> in an IV mismatch between encryption and decryption. Reads fail in that=
=0A=
>> case.=0A=
> =0A=
> I would say that it is incompatible with all dm targets - even the linear=
 =0A=
> target is changing the sector number and so it may redirect the write =0A=
> outside of the range specified in dm-table and cause corruption.=0A=
=0A=
DM remapping of BIO sectors is zone compatible because target entries must =
be=0A=
zone aligned. In the case of zone append, the BIO sector always point to th=
e=0A=
start sector of the target zone. DM sector remapping will remap that to ano=
ther=0A=
zone start as all zones are the same size. No issue here. We extensively us=
e=0A=
dm-linear for various test environment to reduce the size of the device tes=
ted=0A=
(to speed up tests). I am confident there are no problems there.=0A=
=0A=
> Instead of complicating device mapper with imperfect support, I would jus=
t =0A=
> disable REQ_OP_ZONE_APPEND on device mapper at all.=0A=
=0A=
That was my initial approach, but for dm-crypt only since other targets tha=
t=0A=
support zoned devices are fine. However, this breaks zoned block device=0A=
requirement that zone append be supported so that users are presented with =
a=0A=
uniform interface for different devices. So while simple to do, disabling z=
one=0A=
append is far from ideal.=0A=
=0A=
> =0A=
> Mikulas=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
