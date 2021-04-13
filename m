Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4660C35D479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhDMAeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 20:34:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39655 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbhDMAeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 20:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618274050; x=1649810050;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ppJ0QV4ifeegMZjg5N/chWVaZo2WgF76SOu/xSLIeuQ=;
  b=nQUd9uGSf6e5eDpj2qHiv9jqs46dI4qDcXKcIBvvAcTsk4F6tcCmU9St
   gn65duSUDvHwk/plaQSa8VqC25Rzkgq+dlI9ZsXkaR/nI036l3rDFQwRW
   iAS5FMV8KPna5fQyPTkk20iTAwhs31psvRx2zQD6TnAwdTuCp7kIvGYXZ
   h/aUvJL0TlbDZJokwA6mZ4OYa+PNOvUOlFny9JkzpB0kAbLE8WVZY6lPp
   CICC0lBCtzDe+frQuksgCE6JDpWXSygk5AumzlLmiW704R9uZo4PDt0X9
   SheUuMwdQxU5oxluVMgraxbjoMVP/Vfw1g3UjedVT4kZsHUvOhjvWjZeY
   g==;
IronPort-SDR: GDIp98SwfKumKXNxqq5OzwBzt/FJxQpR05kNgoXfdxDjq+vS8KYsFSCP+9js0DRU209HOjX4y7
 tgIS1d2xVQGuA6zekO9HqAdqEvp32pWP5jMOa9aBCCYyvXdRh6+mrZeGv9PzhpGegMb0n4vHol
 ulhrppYhtiQ2i4KIBXtJfWN/kV+H0XYcJGszMaZn9UivRSOkGCV2i1Gmj0F19zfjtXcJxuXRaR
 m9LCajiTIAZm8s5zmxp6JIlYIuuLMMVAJTsMwpudoVnptsUPNy9uwYoV4m16Z5PfCagzuzO3ao
 q8s=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="268792245"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2021 08:31:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TokSMyoy5DFnK9BqU+lEpa+06NISgULrIC12oNYNZ06qt71Uh7tL0NAvhSnYqptW8ZJY5Ilnz774+8TDkETus2F4e8DMKcrAu/3nDYiQAKxM2I4kzeoso56aaoZxnHTEG2oCKnNjFrJsDdtiPAUTItRwWezP/J7VzyyM8tCx+8Dmlw2bUUvMm4PMXF8XEl2zoG+o0L5rFPR37UEbEOSXu/TpK8yJAQqOgVrwhRZHjqbjhJBrYnssRCglSsJ2RPRGxoc1MpUT4rgbUFxnRCpdfvz24CQFnyb7ycM6y8ers8G1TLg1j1Scpcq2CS7jthxvXEtdSwzpRfHPZ29yOyZQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S80LtorSaLgyC108G23FnB0+qRjn7WNduMq6AJkCWeA=;
 b=YfhBaQhs/hvSQftc6CCfC59psaOU60RX+W4EWMgLDB50p3W4mp5YQPJiqJ1sa+aw1ZOX11UMdnKtfs3B/CKfiJKI9EvakCWmWtoTAgsPd3MQBabbJvlaw4Q/XWPBg2qZ95GyJgBC83ZSglk8cI+DmagJ78A8ljcU9g3PQuXu48688pct+O5bXk6vIssfn9iSf7xuzW4SD6x2BA3wu7e1hEPurILUyJWWf74xPcT9eizXeiV9uiUMlXCC0MqlkDAXD6Hwkw19s3Vwb4XwYUOm5Yu0C5wX6PSJ795vbNJOq+t1gSfBL3eNgJ02CXBb1BcWYVvHwSez9uiEjdToW9K4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S80LtorSaLgyC108G23FnB0+qRjn7WNduMq6AJkCWeA=;
 b=LN9gP+JRwUgZoJdOMlv3WxrPlE5LGZzxpJGJmRzOcKMD3WR3/Zy9IiAYaoogFKC5Bg6adMjbz3+2a2evn0gioYhcDDerFiMIMtmnAXQApA6ATjjIsZ9DhQ6bbgDqty1NvZLragVqsolKLv2fwqDSPAxowlxBlRnGvfIeWnsBgsE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6416.namprd04.prod.outlook.com (2603:10b6:208:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 00:32:14 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 00:32:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Selva Jove <selvajove@gmail.com>
CC:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Topic: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Index: AQHXByxWhY0q9dGq/EW9B8B+rRJ+Hw==
Date:   Tue, 13 Apr 2021 00:32:14 +0000
Message-ID: <BL0PR04MB65146169A9C7527280C15D4AE74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
 <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
 <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vYvtOaVL4LG0gAGCMz+a8uha8czH==Dgg3eG+TWA+xeVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b8edd7-995f-47f7-1b22-08d8fe1395e7
x-ms-traffictypediagnostic: MN2PR04MB6416:
x-microsoft-antispam-prvs: <MN2PR04MB6416FDF25A008AFDAEDBE0AAE74F9@MN2PR04MB6416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKohhaa6OzN/n+8G8XH8XUFePW2IUGfrEm92pjNN93Y5q/ASyJi+C/EocbwYzY7MODjX2qM5Om0Rka9iPgARfb3+I9gb83r0l4F2QNv10VT1ERIvWfIAGFihzl91wFlunJPaOPwgYfV6Jm7SQ4QhYGO7qIJwk3rsVVCwhB99RgjRz/BFY29mc3+zNNoeUSvVlfDVHFTa5rahEMilHjif82NqpmZaJMfXkNOurpQC0S0nOy7tqm+8GPEvHzGt9P4r09WS1BHbZSAyNQ7EpgX8NAMMNgDA1VxYzVHeuwSIUf+wkvJrpYIH5jrmKPRXRH/blFUoFhK8hs79dz0cC7CSp7dacp2cWRcWuXMtAWMhnLuuLbK+dEwSvhzrbxBZNdoquCdYG7XIFUZfwLq+HQXSpu7gQkUEA9eYUwP6b5+TY1miDGUsFEYP1SF5yLGXVlncxe66+y65xrdcalBubaP4MtRlBLMg0XnlsfiqqKNVNDRylTrAnzlNQBQvB1VfRjTTsaU4CPs7T88YLyGcFdVEok1qR0Fbj6EW0KiK7henLVrzvqXCisK5demaYVjVRSHelyqOv298jV7w3j4mxUcxWgLB1v/EEPzhs73J8/MebtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(55016002)(478600001)(5660300002)(38100700002)(9686003)(86362001)(66556008)(316002)(66946007)(6916009)(53546011)(66476007)(4326008)(76116006)(8936002)(64756008)(66446008)(71200400001)(33656002)(83380400001)(2906002)(7696005)(54906003)(186003)(52536014)(6506007)(8676002)(91956017)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U77AZYKlIQq2UxIhbeODYn+c5wvBWysPzwE75cSgUqPOlD+R+MgkAafdGUUz?=
 =?us-ascii?Q?mk7gUaT0b8x8NT0Gc1K9f27YihuI3r7e3uKYzPx/FxXt8RzspGKZPwFm4a5q?=
 =?us-ascii?Q?ll8+dkvMm2qzTUyHExdhU0l+I0FDf8jCxB8uZIMtKxlugHffsDZaCHyQaLtz?=
 =?us-ascii?Q?xkHcqGCWUZ/XzZH18gAgf0vRlggEoms90ifsa1Ati+fB1ALRGwbThbpKaIXG?=
 =?us-ascii?Q?H0QT7mWXDLclVdU6Cv5XUtL5GW44UN9hSBuMlHtWOEZkN2m7E6P3XE2+zlS/?=
 =?us-ascii?Q?kGbjVxFqhgZ0r4pqy7dNlCoz/HkR+dMrj9wzr4u2YrhuX7qsT8lDBoP5BCAv?=
 =?us-ascii?Q?KxDRW3lfTucudjFOJ8naRWKC5CiwA/mqbyRgLRoWoJDBpsk0SgiHBYG4dSao?=
 =?us-ascii?Q?Q+U5H7k/SEAzAqebf/uXP+Xosi4rQ1A+RT9JKjDIhDOkw0JA6MbJp2Vwyiym?=
 =?us-ascii?Q?3sH7tZagk9vHeIZP1xJN0vT5p5xHJwuMlhijP0QaKEWD0JkZ9sQs0PpZ+n4K?=
 =?us-ascii?Q?ic1+/ta1ueKUK7nGOKNS8VKS2zflhyOACqH9UK2rSka66S2SWT9/UTVgYOGD?=
 =?us-ascii?Q?6VbN1R3hDUh6uiOV6+sXh+C3y5ppb/kJBAA9YYDsm97F4yqVQIGzTHw2QdVm?=
 =?us-ascii?Q?mtt1GMLupxXikwiDcNwvZ9gGoGD69vHSH66n6vV9wBMhDIyoyYs7Zp70pu3g?=
 =?us-ascii?Q?sblRjUgvZcn4VV1wiIpXWSH9TfM6X2QFgQQeYuAxPejHYaWXH2dcvOn/+DwF?=
 =?us-ascii?Q?kWGYMLZvvF38C4zT56oLGcGGhc/FYesHwJ/V+W8gXglwUyxOg8T2Eq5n0tL5?=
 =?us-ascii?Q?Inv19l3m7gFrZBTGR0enKiYkCk43HLQJBYerMaIMypzI8ivGaxqi9YR0Nakb?=
 =?us-ascii?Q?5YFm41RML3d/GL9bTZnilYfBEHGREpUxb+g5mM0GvnjtRbOSQfiyrbHe/QrP?=
 =?us-ascii?Q?uDRjIFcPW0qFJHF6Y97R8gN3F+3r3/yALItB7K9StfvdhBeoxBV/rUlrnT+k?=
 =?us-ascii?Q?+eExMUcEmKMdmz9pcNkL3wBmlDKMXvNDAbnuT9Bx9UT+8Vg5KT62m7HR/3Ps?=
 =?us-ascii?Q?6Nwc/4oRoWMHcMA43XPsnum9x4RScwwtOPmozlsN8fIG9UhzcEfGhYcjDmgu?=
 =?us-ascii?Q?KClpoTWFB41jzNHmNjVTIb3/KoRuEG2/dzmoPeuPhsEe2MP+bAMf+GWP4Mec?=
 =?us-ascii?Q?OU80NvCYPXpJoYb85HTmt1/yy8RQSWd9ACeVPYrsvunyF/pQj3Uvw+7FyUq7?=
 =?us-ascii?Q?GdT1J1cGoLI/UkJM2AhGdi1bZ+c8LNHT8jk5tL9jSPHK/kyFGVCil/prfrBG?=
 =?us-ascii?Q?G6UwBZKKzA8Wsvxr7JVYmPpSKNGB/ofOfrnz+eRdMAhLM0EaoophF10fb9N8?=
 =?us-ascii?Q?FDd7FWKFfmUshgSVmyY3z0UDO9/EQRQuEo04VYi1Va+gPOa73Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8edd7-995f-47f7-1b22-08d8fe1395e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 00:32:14.4505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q45jY7heLab0BUCytM6USTe3hTqEd8yxrYCHY9+xsAtRp+etxiabX4DsjXyIq4Dk4FtwiNDlMFa8ed9fxwucjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6416
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/12 23:35, Selva Jove wrote:=0A=
> On Mon, Apr 12, 2021 at 5:55 AM Damien Le Moal <Damien.LeMoal@wdc.com> wr=
ote:=0A=
>>=0A=
>> On 2021/04/07 20:33, Selva Jove wrote:=0A=
>>> Initially I started moving the dm-kcopyd interface to the block layer=
=0A=
>>> as a generic interface.=0A=
>>> Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is=0A=
>>> tightly coupled with dm_io()=0A=
>>>=0A=
>>> To move dm-kcopyd to block layer, it would also require dm_io code to=
=0A=
>>> be moved to block layer.=0A=
>>> It would cause havoc in dm layer, as it is the backbone of the=0A=
>>> dm-layer and needs complete=0A=
>>> rewriting of dm-layer. Do you see any other way of doing this without=
=0A=
>>> having to move dm_io code=0A=
>>> or to have redundant code ?=0A=
>>=0A=
>> Right. Missed that. So reusing dm-kcopyd and making it a common interfac=
e will=0A=
>> take some more efforts. OK, then. For the first round of commits, let's =
forget=0A=
>> about this. But I still think that your emulation could be a lot better =
than a=0A=
>> loop doing blocking writes after blocking reads.=0A=
>>=0A=
> =0A=
> Current implementation issues read asynchronously and once all the reads =
are=0A=
> completed, then the write is issued as whole to reduce the IO traffic=0A=
> in the queue.=0A=
> I agree that things can be better. Will explore another approach of=0A=
> sending writes=0A=
> immediately once reads are completed and with  plugging to increase the c=
hances=0A=
> of merging.=0A=
> =0A=
>> [...]=0A=
>>>>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,=0A=
>>>>> +             struct range_entry *src_rlist, struct block_device *des=
t_bdev,=0A=
>>>>> +             sector_t dest, gfp_t gfp_mask, int flags)=0A=
>>>>> +{=0A=
>>>>> +     struct request_queue *q =3D bdev_get_queue(src_bdev);=0A=
>>>>> +     struct request_queue *dest_q =3D bdev_get_queue(dest_bdev);=0A=
>>>>> +     struct blk_copy_payload *payload;=0A=
>>>>> +     sector_t bs_mask, copy_size;=0A=
>>>>> +     int ret;=0A=
>>>>> +=0A=
>>>>> +     ret =3D blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_m=
ask,=0A=
>>>>> +                     &payload, &copy_size);=0A=
>>>>> +     if (ret)=0A=
>>>>> +             return ret;=0A=
>>>>> +=0A=
>>>>> +     bs_mask =3D (bdev_logical_block_size(dest_bdev) >> 9) - 1;=0A=
>>>>> +     if (dest & bs_mask) {=0A=
>>>>> +             return -EINVAL;=0A=
>>>>> +             goto out;=0A=
>>>>> +     }=0A=
>>>>> +=0A=
>>>>> +     if (q =3D=3D dest_q && q->limits.copy_offload) {=0A=
>>>>> +             ret =3D blk_copy_offload(src_bdev, payload, dest, gfp_m=
ask);=0A=
>>>>> +             if (ret)=0A=
>>>>> +                     goto out;=0A=
>>>>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {=0A=
>>>>=0A=
>>>> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why w=
ould that=0A=
>>>> user say "Fail on me if the device does not support copy" ??? This is =
a weird=0A=
>>>> interface in my opinion.=0A=
>>>>=0A=
>>>=0A=
>>> BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy(=
) callers=0A=
>>> to use their native copying method instead of the emulated copy that I=
=0A=
>>> added. This way we=0A=
>>> ensure that dm uses the hw-assisted copy and if that is not present,=0A=
>>> it falls back to existing=0A=
>>> copy method.=0A=
>>>=0A=
>>> The other users who don't have their native emulation can use this=0A=
>>> emulated-copy implementation.=0A=
>>=0A=
>> I do not understand. Emulation or not should be entirely driven by the d=
evice=0A=
>> reporting support for simple copy (or not). It does not matter which com=
ponent=0A=
>> is issuing the simple copy call: an FS to a real device, and FS to a DM =
device=0A=
>> or a DM target driver. If the underlying device reported support for sim=
ple=0A=
>> copy, use that. Otherwise, emulate with read/write. What am I missing he=
re ?=0A=
>>=0A=
> =0A=
> blkdev_issue_copy() api will generally complete the copy-operation,=0A=
> either by using=0A=
> offloaded-copy or by using emulated-copy. The caller of the api is not=0A=
> required to=0A=
> figure the type of support. However, it can opt out of emulated-copy=0A=
> by specifying=0A=
> the flag BLKDEV_NOEMULATION. This is helpful for the case when the=0A=
> caller already=0A=
> has got a sophisticated emulation (e.g. dm-kcopyd users).=0A=
=0A=
This does not make any sense to me. If the user has already another mean of=
=0A=
doing copies, then that user will not call blkdev_issue_copy(). So I really=
 do=0A=
not understand what the "opting out of emulated copy" would be useful for. =
That=0A=
user can check the simple copy support glag in the device request queue and=
 act=0A=
accordingly: use its own block copy code when simple copy is not supported =
or=0A=
use blkdev_issue_copy() when the device has simple copy. Adding that=0A=
BLKDEV_COPY_NOEMULATION does not serve any purpose at all.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
