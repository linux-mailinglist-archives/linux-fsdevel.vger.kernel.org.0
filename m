Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D380285B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgJGJCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 05:02:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16911 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJGJB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602061320; x=1633597320;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RQgeUtpkH0PbCtVbe5cA8v9GRcl4dM0JtZYIFOkqIJ4=;
  b=MhyGMbz12z/9S/iNhoGw9tONMJPBZMrtddHk6C5k2N7cJS22rUr/z2NL
   +Aht+QhafzRjx7FrkxTyr4EtjtsJhHJOugls91f8froSOca98Bup4ujMW
   f7ptpOuyCO/0+0wFgRMnvd5ooXBXEK22HWt1ee1GC3L5YiAtOAdf8lBAF
   S4hnsQUgQQSqG1THMQmKpM1NHhf/CHaTE6DrYZXSeJf0ZtO0cxPi6mgdE
   uFoGplQbA4ulYykUOvBc89EgrmomomWUObKY0goK9FzdYzQcbwuH5ByHE
   +YDxYiMDuY5Hl5ubEQqRtVTUib89mKXDgFuUhMi5p2zrCpasYMfsXNR7s
   w==;
IronPort-SDR: 54FnUOPKU1u/dBRLE/4/GZPs8vyYH8wkZRjByvEN9yd02siyNuKzy57L8cpF2tiEaXnnJGPmjc
 KJRvyM7eSAKCSPc/JoR+IeNIX24OxSnw83FIUnUhE433Lu6p+EFAm7gtTp7q6BxGq94gLUJ8ea
 qP5IVXR94DkyQj41cTp3T2Tb68uQqRS4++glCTqPEqKARNFiZ32TiPxHvURlmvMncySmrE2m3Q
 hwe5ICOTkfKaUSAGkT3irbe1TXZP9wgMkqA5ragFmObt0Nl1rEstoGDTYTneQrr79EwPZdgxjL
 czQ=
X-IronPort-AV: E=Sophos;i="5.77,346,1596470400"; 
   d="scan'208";a="149316335"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 17:01:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjb+3dXH47+5xW7wX6EDmmC9qkdAVjormXAInNALiAOsRp80HNj61P2nAIz6CaAHrwZDYorfEckT5WPfhlB0SS6/xD2o47/piuWUsmRIREi0Z+Y6NYMlnFHhFzmOmcAPNOhwTX2hmQSqSOFcygjuAqgQQh/IFsgW35aiWEtp/7KpusyeG8Mcyc8LjSPl+gUh6h4qiwlKY5VhoaqWVvCHnH3eemJGpUw9R0I2elPJX6m77KZAfFbnoM+XIDQcod5N+Am3ngmqiGqLwFp4ej+lA7fKrQkcJruB2STc+WzibTxxwYolG8UzyySk2i8YLYn//cRdTNQL6/wuLi3ngRIjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tydIXujtftt0bfkMNnIlxdG4sBsUOITosI+wjwdsLNk=;
 b=oQeYveJ/XxG64pmSpiOHhhF3IpBaB2+ADNODAU0Mo9Rt0PMm8md7lpPFT32R8GGBgpVio31SZzN40Lm8VCfmkOM7z4doOgkVvh9QBBcFmmMENkAc1++7GvyeVrf+dDwx3ynfbuiA5LXbNenxBvZggnuLhw10W1luV6gtbIM/MbKTDGJV84qUUKKJfEk/kWqg9OJA5auQ42k119a7B2Us2GnKYLEidooWmkKNBbhIYM61bLwoILL8ztUeVdV6WHeNPwxvs+SOQESPmBs8wOyC7U2ZgS7BGxTKuQu8wvEbOLRYyGOG0lU6MYFETK42XK9rIBO3PA+udHwUjvwgD35y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tydIXujtftt0bfkMNnIlxdG4sBsUOITosI+wjwdsLNk=;
 b=soQuwNKfBZCfXlwNBm7lgYYSFBii4XzwHWDlmvrbaMrfjIUSwvES/U9426SdaS30fXMkhuz3hfa/p9OyecNk3trBTaUt6xI9cla6/SbDEMmLxhurG5bWKBYBPLsTs/nl2+h3ZlH+CtotjjHRULNymzTqbWt6aiha47BNmySeF7w=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4398.namprd04.prod.outlook.com
 (2603:10b6:805:32::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 09:01:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 09:01:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Thread-Topic: [PATCH] block: make maximum zone append size configurable
Thread-Index: AQHWm+sasNtmaR7+P0yDCraMVO0/aA==
Date:   Wed, 7 Oct 2020 09:01:57 +0000
Message-ID: <SN4PR0401MB359836DA6CBC1D7590CFEAB99B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
 <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20201007055024.GB16556@infradead.org>
 <CY4PR04MB375165E4F35DB78390ED5D84E70A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:f50d:161f:c6e3:1bfa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe2d30cb-350d-4043-f819-08d86a9fa4fe
x-ms-traffictypediagnostic: SN6PR04MB4398:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4398B00F11C12D4EEF4EF38F9B0A0@SN6PR04MB4398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5V5lyI5HQF3pHo2CQoJ8i2SMakxALmSqeiK1mqrlyPbScI1wyBXViM+ZtIkkcClO0GdCmUioh6EBdOWrtWrmWItPzcf/esgWpmwH83PYn+A8idJLRGvjYeTteYwrlRBeYcn6+vxGG2htL5xEPVgwywAJXPn7qYMjINnbaDYBcczWDwokk4zy8VwJFAzHa7cQ7GZRhxQF5jYzsdjjiNweZATUnyF5YxVknE1EaqZ2ZrD2yJ73RD5UIIuSBec5g/D6Vt2AjMrpyZNJAhhuJg57mxpE3X40rJW6alVS1BMxmSRZ963s0wk4QtowUQzbEVAH0w5uhQQt1p4G1nQOAdugA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(54906003)(91956017)(4326008)(8676002)(186003)(64756008)(9686003)(83380400001)(71200400001)(66556008)(2906002)(53546011)(66446008)(86362001)(66476007)(8936002)(66946007)(52536014)(110136005)(316002)(76116006)(55016002)(478600001)(5660300002)(33656002)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: x8D5bcx/4s2br2uXkUORwY+8NJE9vW/GnCG+ep/eLqAn9UJ6LssIhrnjDkcIVfVkGrOpWo09zpIjDz7Z6Nz9PpV2+rbAXvqWL15Q2Bon/W9FAk8kLSF86CJf+7GYkg9LW2ADqtaFIUxWOXqXeJEie+JKt95JVjvoxpB+SRM/2864Q/e0itcAQ7k88nY6okpEPaXmjvE5iw4LaioHZwkPKssEqsClQ1rh0AiHoiCWRadRsT+LKdR1jBi2B+Gqmv6P29Sb+kaW6HC3DgnTxA44a+4n0v/ujSCeRxhJJ1xvX3YJY/X26k5JYv/2uOr5kK7RByCkBi76JQMYHy6lA6liQ/DUIlgCiklMvvxMV1BvZBe+tB6hySI2FmgOlYUK7HOaxFFm88Clvpuv8OozwCrAeZGqvlVoORXU18aO/BYp+a75DbSRb5KvGJnHxtDBYYd1lyk3QEO9slxtRFFQUF/n/+TkVTOst8zxf8bKwXIezU3kKiAXyB4fP9eezClHSd8c/gALguufBcECGPZt60qylk06Hmo9ksTzcsHY9gfCW4fTRPe1bwgwgGtqP91BsjmnEArRO+K1Jmci+qmZTL/UifiX6XIcbyvKp3VpES+5NEHI0ff0HIz6v95+a0M9zdzwfpLbs/HKpSYgNsQQ2AH6gAWbcZG0idnvMdhbXAF87XLAvTW829oaLuToYC8WRnHlqQWl3LhHUdRl/pgmCXBlFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2d30cb-350d-4043-f819-08d86a9fa4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 09:01:57.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0FaXtOGc8RHz5YqVJaKWm37lPxq6RjyH2ijNgZ2h6mPg53sN22rx0T3ILhohemu1B1IQ/YxBhKRnWZlKlyzU+otkrJVlKBsJl87cTFjkrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4398
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2020 08:24, Damien Le Moal wrote:=0A=
> On 2020/10/07 14:50, Christoph Hellwig wrote:=0A=
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
>>> index 7dda709f3ccb..78817d7acb66 100644=0A=
>>> --- a/block/blk-sysfs.c=0A=
>>> +++ b/block/blk-sysfs.c=0A=
>>> @@ -246,6 +246,11 @@ queue_max_sectors_store(struct request_queue *q, c=
onst char=0A=
>>> *page, size_t count)=0A=
>>>         spin_lock_irq(&q->queue_lock);=0A=
>>>         q->limits.max_sectors =3D max_sectors_kb << 1;=0A=
>>>         q->backing_dev_info->io_pages =3D max_sectors_kb >> (PAGE_SHIFT=
 - 10);=0A=
>>> +=0A=
>>> +       q->limits.max_zone_append_sectors =3D=0A=
>>> +               min(q->limits.max_sectors,=0A=
>>> +                   q->limits.max_hw_zone_append_sectors);=0A=
>>> +=0A=
>>>         spin_unlock_irq(&q->queue_lock);=0A=
>>>=0A=
>>>         return ret;=0A=
>>=0A=
>> Yes, this looks pretty sensible.  I'm not even sure we need the field,=
=0A=
>> just do the min where we build the bio instead of introducing another=0A=
>> field that needs to be maintained.=0A=
> =0A=
> Indeed, that would be even simpler. But that would also mean repeating th=
at min=0A=
> call for every user. So may be we should just add a simple helper=0A=
> queue_get_max_zone_append_sectors() ?=0A=
> =0A=
> =0A=
> =0A=
=0A=
Like this?=0A=
=0A=
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
index cf80e61b4c5e..967cd76f16d4 100644=0A=
--- a/include/linux/blkdev.h=0A=
+++ b/include/linux/blkdev.h=0A=
@@ -1406,7 +1406,10 @@ static inline unsigned int queue_max_segment_size(co=
nst struct request_queue *q)=0A=
 =0A=
 static inline unsigned int queue_max_zone_append_sectors(const struct requ=
est_queue *q)=0A=
 {=0A=
-       return q->limits.max_zone_append_sectors;=0A=
+=0A=
+       struct queue_limits *l =3D q->limits;=0A=
+=0A=
+       return min(l->max_zone_append_sectors, l->max_sectors);=0A=
 }=0A=
 =0A=
 static inline unsigned queue_logical_block_size(const struct request_queue=
 *q)=0A=
=0A=
=0A=
That's indeed much simpler, we'd just need to take precaution everyone's us=
ing =0A=
queue_max_zone_append_sectors() and isn't directly poking into the queue_li=
mits.=0A=
