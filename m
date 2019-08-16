Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30764903D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHPOTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 10:19:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43746 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfHPOTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565965176; x=1597501176;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DFn94+s3WxHTYhkSk+Pg7Y9W9Sw3lIxJRLoW23p7F0g=;
  b=aIWNq8pm3TMegcNfW0z7ZBsoqyRUEbYv9jT4Z9JUz/uwn5d5krWzz5vw
   LTUBW44jEBbh7sUjZJ0R5oj2Oa0k2tTqJJvK/TusTREeDmVlejbYOxVBH
   PqIacY62X1YaSNKe+0stLAT02t9rUIRueEls+m0okxzZeYJC6IlepUbIv
   KpNH4fTZ0//lsexFnWvJL4HsD1WGYCSSDmBkS6cnXonEjFOFMSK8nnxTQ
   4LkpTAWYC5bemz4PhBAnNcW3pfLcpmQ1PF5DQ7nSEsZEYSOVHekcQg8Eq
   PBYZhAjckvdbBqbennQ1zJcFPf778weEbenK3FB+oTVa8RZBVsgADJdNa
   w==;
IronPort-SDR: 9n7ceHRtPsFZc2KbwNBLGAYHA1QDKRaPbEXn9rHdJXGMsTQo+i0zNLYGHCq+J6WzvRriDpESC/
 q+yhtweFautMr+lICiPsG4LS+8yOizpttZgE+52697Y6u6hV5+xuWazDSMoW3Tyyg1ncjLhGeM
 8vhly6Ey99IMUZ8nl5PX1gCfcbWVMrs7bGjtsOyGvgraH2KZDBhnZdYzg00LhrxlMcUskdW8l6
 VjYFOqWy2iu5YWhifSxLw60L3AAf/GsUAUaBZ1U8F6ZiqqukrzNjmzEn2kOlzVu0vH82yQPMiM
 nTU=
X-IronPort-AV: E=Sophos;i="5.64,393,1559491200"; 
   d="scan'208";a="120590864"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 22:19:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHRFR15V5l0RBqADR+cjcQPUFi9j+rJhhlIWEITVp6LzB7Vtm2WXstnLAhovqmXbSsePgcNxlU6s2dpAihh1sOhHQt4CFI/0YlK4xq3n9o30wtrc3UWTPbC+hyNyLf/TBRYnovjM8PrLxrtV3BUWHgA2CkiHzqVMGYEpHm91lf6SSKY1pf79kTi4hWCgWn5IIgKzwrCybVIhJhJVJM/bltX8JNv4FbcA2zxh5GHcCn4y6kJC1wbRaX9X0KLyCKMRlZmAh7un/BAMVL5FTlaTZdIc7i5I68vwzTXeykwKwmfV9Y2Rd28qLRi/tQK9J2iByfvN76vHCOkQ/jkgm0t3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu0ZHkatIVrOyM5FdCpduqCxivbtZVkAshC+KKa097A=;
 b=C/2MQ+AO60TlY4TSfDtAc03Dh21GNQuSRBbEeSrPlmyzaT/uSO4K5RkZZJcJ+KzfvESPaw+ctEQEsh/o0VXCHREvINvUcvhYwE+LjW547nydR5xt0N36qEya4OBBdf9OJWgeORtY7IJQPvcKBCftgVXAKN1m1xcXjTeyl2+aD5+1UEk+Gt0m4kwe9e8gfNcpc+dBF30qthUdsxu+pcasYaaUsZjJXBxEL42OVkDrqHRbTO4e9vqjtIvRqt4kdXDFXFLCQyNZIRynjyU4RXmIRgAkt801rgiD41itMrL6O8eKFB3nYlXYqYDEwYUxX/AB5Qew8PRsgVPeh5VH6k1OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu0ZHkatIVrOyM5FdCpduqCxivbtZVkAshC+KKa097A=;
 b=SLDgSEtnEz63hSuH2VnLFxRnNfLdh4PqjkO3oday67IqQBOls+shw6bIU+F9LL/UEVDmBT1HHkDZmfNIbcZmoED8BgCAhMBF+1MFUWxZW1Wys5+LGywTUeSN0Y8pLVk1OJenm0vZzLPo3D5r+MoGDBhgtyQszqJgnIv7B/wtmvM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5461.namprd04.prod.outlook.com (20.178.51.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 14:19:33 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 14:19:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/27] btrfs: Get zone information of zoned block
 devices
Thread-Topic: [PATCH v3 02/27] btrfs: Get zone information of zoned block
 devices
Thread-Index: AQHVTcwJ3mXpSFAoAke32QrSccXb8g==
Date:   Fri, 16 Aug 2019 14:19:33 +0000
Message-ID: <BYAPR04MB5816442B6CD412BC6925D90AE7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-3-naohiro.aota@wdc.com>
 <fd5b4006-0413-c63b-9376-8618e5fcb8f0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [66.201.36.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5587feaf-db77-47b8-20b7-08d72254c2c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5461;
x-ms-traffictypediagnostic: BYAPR04MB5461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB54612074CC0A5FBDFBFBB8D0E7AF0@BYAPR04MB5461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:68;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(43544003)(199004)(189003)(66946007)(476003)(316002)(3846002)(186003)(6116002)(229853002)(14454004)(30864003)(54906003)(102836004)(7736002)(6246003)(25786009)(64756008)(52536014)(53936002)(76176011)(2501003)(4326008)(5024004)(53546011)(14444005)(66556008)(256004)(71200400001)(71190400001)(66476007)(8676002)(110136005)(76116006)(305945005)(8936002)(66446008)(33656002)(6506007)(74316002)(26005)(81156014)(5660300002)(486006)(478600001)(9686003)(99286004)(446003)(66066001)(55016002)(7696005)(86362001)(81166006)(2906002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5461;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e7ThMapGj5hfaQE/OU4rUr/NEA4OZzykkpf7eM/YwB0vD6EgL3hTx6PPF+2/5tHYsL0vAk9BKYqG9YSCZajjM8OIBu7bmXKm5KPnv+SZRZqXXIqedPcUZDmn6cnyqwDSh8FNBQBRday9so08AkW3rycswXkBFH/uxjFSPxdAH/OFHeWaPcmAr1rlPTKy/A2GLbHX3wCFAs+ZcTQ5s8jOIzBSqNsoPynv1uYgxYy6D5AzCKOYuK6l20aMYOkDrnb5TNNd7M8jJZXI34vVQdcdGpF9FNy7/5jArCvv5OuU5kb95qfNlajg9h77jZoG51UW08Riolk1+JW9u6jg4bkjZmFdRlI+4r9mKJF51tEQ3Qqxw+lCd58EoVzWWEb1aCSckMusElQzECOS2iMCCOH0qo80a1jvJ6iIa6LG7On/2gc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5587feaf-db77-47b8-20b7-08d72254c2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 14:19:33.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRjtK3QcazIPt+nc/is9Bxm1KiQojIq7abhGGeJSXXiUybJd8Vd1MxfB8KhHXJcP+j7Qs1EWETh9PoqSwuT97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5461
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/15 21:47, Anand Jain wrote:=0A=
> On 8/8/19 5:30 PM, Naohiro Aota wrote:=0A=
>> If a zoned block device is found, get its zone information (number of zo=
nes=0A=
>> and zone size) using the new helper function btrfs_get_dev_zonetypes(). =
 To=0A=
>> avoid costly run-time zone report commands to test the device zones type=
=0A=
>> during block allocation, attach the seq_zones bitmap to the device=0A=
>> structure to indicate if a zone is sequential or accept random writes. A=
lso=0A=
>> it attaches the empty_zones bitmap to indicate if a zone is empty or not=
.=0A=
>>=0A=
>> This patch also introduces the helper function btrfs_dev_is_sequential()=
 to=0A=
>> test if the zone storing a block is a sequential write required zone and=
=0A=
>> btrfs_dev_is_empty_zone() to test if the zone is a empty zone.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/Makefile  |   2 +-=0A=
>>   fs/btrfs/hmzoned.c | 162 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/hmzoned.h |  79 ++++++++++++++++++++++=0A=
>>   fs/btrfs/volumes.c |  18 ++++-=0A=
>>   fs/btrfs/volumes.h |   4 ++=0A=
>>   5 files changed, 262 insertions(+), 3 deletions(-)=0A=
>>   create mode 100644 fs/btrfs/hmzoned.c=0A=
>>   create mode 100644 fs/btrfs/hmzoned.h=0A=
>>=0A=
>> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile=0A=
>> index 76a843198bcb..8d93abb31074 100644=0A=
>> --- a/fs/btrfs/Makefile=0A=
>> +++ b/fs/btrfs/Makefile=0A=
>> @@ -11,7 +11,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \=0A=
>>   	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \=
=0A=
>>   	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \=
=0A=
>>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o =
\=0A=
>> -	   block-rsv.o delalloc-space.o=0A=
>> +	   block-rsv.o delalloc-space.o hmzoned.o=0A=
>>   =0A=
>>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o=0A=
>>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o=0A=
>> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..bfd04792dd62=0A=
>> --- /dev/null=0A=
>> +++ b/fs/btrfs/hmzoned.c=0A=
>> @@ -0,0 +1,162 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
>> + * Authors:=0A=
>> + *	Naohiro Aota	<naohiro.aota@wdc.com>=0A=
>> + *	Damien Le Moal	<damien.lemoal@wdc.com>=0A=
>> + */=0A=
>> +=0A=
>> +#include <linux/slab.h>=0A=
>> +#include <linux/blkdev.h>=0A=
>> +#include "ctree.h"=0A=
>> +#include "volumes.h"=0A=
>> +#include "hmzoned.h"=0A=
>> +#include "rcu-string.h"=0A=
>> +=0A=
>> +/* Maximum number of zones to report per blkdev_report_zones() call */=
=0A=
>> +#define BTRFS_REPORT_NR_ZONES   4096=0A=
>> +=0A=
>> +static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,=0A=
>> +			       struct blk_zone **zones_ret,=0A=
>> +			       unsigned int *nr_zones, gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	struct blk_zone *zones =3D *zones_ret;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!zones) {=0A=
>> +		zones =3D kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);=0A=
>> +		if (!zones)=0A=
>> +			return -ENOMEM;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,=0A=
>> +				  zones, nr_zones, gfp_mask);=0A=
>> +	if (ret !=3D 0) {=0A=
>> +		btrfs_err_in_rcu(device->fs_info,=0A=
>> +				 "get zone at %llu on %s failed %d", pos,=0A=
>> +				 rcu_str_deref(device->name), ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +	if (!*nr_zones)=0A=
>> +		return -EIO;=0A=
>> +=0A=
>> +	*zones_ret =3D zones;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +int btrfs_get_dev_zone_info(struct btrfs_device *device)=0A=
>> +{=0A=
>> +	struct btrfs_zoned_device_info *zone_info =3D NULL;=0A=
>> +	struct block_device *bdev =3D device->bdev;=0A=
>> +	sector_t nr_sectors =3D bdev->bd_part->nr_sects;=0A=
>> +	sector_t sector =3D 0;=0A=
>> +	struct blk_zone *zones =3D NULL;=0A=
>> +	unsigned int i, nreported =3D 0, nr_zones;=0A=
>> +	unsigned int zone_sectors;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(bdev))=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	zone_info =3D kzalloc(sizeof(*zone_info), GFP_KERNEL);=0A=
>> +	if (!zone_info)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	zone_sectors =3D bdev_zone_sectors(bdev);=0A=
>> +	ASSERT(is_power_of_2(zone_sectors));=0A=
>> +	zone_info->zone_size =3D (u64)zone_sectors << SECTOR_SHIFT;=0A=
>> +	zone_info->zone_size_shift =3D ilog2(zone_info->zone_size);=0A=
>> +	zone_info->nr_zones =3D nr_sectors >> ilog2(bdev_zone_sectors(bdev));=
=0A=
>> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))=0A=
>> +		zone_info->nr_zones++;=0A=
>> +=0A=
>> +	zone_info->seq_zones =3D kcalloc(BITS_TO_LONGS(zone_info->nr_zones),=
=0A=
>> +				       sizeof(*zone_info->seq_zones),=0A=
>> +				       GFP_KERNEL);=0A=
>> +	if (!zone_info->seq_zones) {=0A=
>> +		ret =3D -ENOMEM;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	zone_info->empty_zones =3D kcalloc(BITS_TO_LONGS(zone_info->nr_zones),=
=0A=
>> +					 sizeof(*zone_info->empty_zones),=0A=
>> +					 GFP_KERNEL);=0A=
>> +	if (!zone_info->empty_zones) {=0A=
>> +		ret =3D -ENOMEM;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Get zones type */=0A=
>> +	while (sector < nr_sectors) {=0A=
>> +		nr_zones =3D BTRFS_REPORT_NR_ZONES;=0A=
>> +		ret =3D btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,=0A=
>> +					  &zones, &nr_zones, GFP_KERNEL);=0A=
> =0A=
> =0A=
> How many zones do we see in a disk? Not many I presume.=0A=
=0A=
A 15 TB SMR drive with 256 MB zones (which is a failry common value for pro=
ducts=0A=
out there) has over 55,000 zones. "Not many" is subjective... I personally=
=0A=
consider 55000 a large number and that one should take care to write approp=
riate=0A=
code to manage that many objects.=0A=
=0A=
> Here the allocation for %zones is inconsistent for each zone, unless=0A=
> there is substantial performance benefits, a consistent flow of=0A=
> alloc/free is fine as it makes the code easy to read and verify.=0A=
=0A=
I do not understand your comment here. btrfs_get_dev_zones() will allocate =
and=0A=
fill the zones array with at most BTRFS_REPORT_NR_ZONES zones descriptors o=
n the=0A=
first call. On subsequent calls, the same array is reused until information=
 on=0A=
all zones of the disk is obtained. "the allocation for %zones is inconsiste=
nt=0A=
for each zone" does not makes much sense. What exactly do you mean ?=0A=
=0A=
> =0A=
> =0A=
> Thanks, Anand=0A=
> =0A=
>> +		if (ret)=0A=
>> +			goto out;=0A=
>> +=0A=
>> +		for (i =3D 0; i < nr_zones; i++) {=0A=
>> +			if (zones[i].type =3D=3D BLK_ZONE_TYPE_SEQWRITE_REQ)=0A=
>> +				set_bit(nreported, zone_info->seq_zones);=0A=
>> +			if (zones[i].cond =3D=3D BLK_ZONE_COND_EMPTY)=0A=
>> +				set_bit(nreported, zone_info->empty_zones);=0A=
>> +			nreported++;=0A=
>> +		}=0A=
>> +		sector =3D zones[nr_zones - 1].start + zones[nr_zones - 1].len;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (nreported !=3D zone_info->nr_zones) {=0A=
>> +		btrfs_err_in_rcu(device->fs_info,=0A=
>> +				 "inconsistent number of zones on %s (%u / %u)",=0A=
>> +				 rcu_str_deref(device->name), nreported,=0A=
>> +				 zone_info->nr_zones);=0A=
>> +		ret =3D -EIO;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	device->zone_info =3D zone_info;=0A=
>> +=0A=
>> +	btrfs_info_in_rcu(=0A=
>> +		device->fs_info,=0A=
>> +		"host-%s zoned block device %s, %u zones of %llu sectors",=0A=
>> +		bdev_zoned_model(bdev) =3D=3D BLK_ZONED_HM ? "managed" : "aware",=0A=
>> +		rcu_str_deref(device->name), zone_info->nr_zones,=0A=
>> +		zone_info->zone_size >> SECTOR_SHIFT);=0A=
>> +=0A=
>> +out:=0A=
>> +	kfree(zones);=0A=
>> +=0A=
>> +	if (ret) {=0A=
>> +		kfree(zone_info->seq_zones);=0A=
>> +		kfree(zone_info->empty_zones);=0A=
>> +		kfree(zone_info);=0A=
>> +	}=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +void btrfs_destroy_dev_zone_info(struct btrfs_device *device)=0A=
>> +{=0A=
>> +	struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
>> +=0A=
>> +	if (!zone_info)=0A=
>> +		return;=0A=
>> +=0A=
>> +	kfree(zone_info->seq_zones);=0A=
>> +	kfree(zone_info->empty_zones);=0A=
>> +	kfree(zone_info);=0A=
>> +	device->zone_info =3D NULL;=0A=
>> +}=0A=
>> +=0A=
>> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,=0A=
>> +		       struct blk_zone *zone, gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	unsigned int nr_zones =3D 1;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	ret =3D btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);=
=0A=
>> +	if (ret !=3D 0 || !nr_zones)=0A=
>> +		return ret ? ret : -EIO;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h=0A=
>> new file mode 100644=0A=
>> index 000000000000..ffc70842135e=0A=
>> --- /dev/null=0A=
>> +++ b/fs/btrfs/hmzoned.h=0A=
>> @@ -0,0 +1,79 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>> +/*=0A=
>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
>> + * Authors:=0A=
>> + *	Naohiro Aota	<naohiro.aota@wdc.com>=0A=
>> + *	Damien Le Moal	<damien.lemoal@wdc.com>=0A=
>> + */=0A=
>> +=0A=
>> +#ifndef BTRFS_HMZONED_H=0A=
>> +#define BTRFS_HMZONED_H=0A=
>> +=0A=
>> +struct btrfs_zoned_device_info {=0A=
>> +	/*=0A=
>> +	 * Number of zones, zone size and types of zones if bdev is a=0A=
>> +	 * zoned block device.=0A=
>> +	 */=0A=
>> +	u64 zone_size;=0A=
>> +	u8  zone_size_shift;=0A=
>> +	u32 nr_zones;=0A=
>> +	unsigned long *seq_zones;=0A=
>> +	unsigned long *empty_zones;=0A=
>> +};=0A=
>> +=0A=
>> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,=0A=
>> +		       struct blk_zone *zone, gfp_t gfp_mask);=0A=
>> +int btrfs_get_dev_zone_info(struct btrfs_device *device);=0A=
>> +void btrfs_destroy_dev_zone_info(struct btrfs_device *device);=0A=
>> +=0A=
>> +static inline bool btrfs_dev_is_sequential(struct btrfs_device *device,=
 u64 pos)=0A=
>> +{=0A=
>> +	struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
>> +=0A=
>> +	if (!zone_info)=0A=
>> +		return false;=0A=
>> +=0A=
>> +	return test_bit(pos >> zone_info->zone_size_shift,=0A=
>> +			zone_info->seq_zones);=0A=
>> +}=0A=
>> +=0A=
>> +static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device,=
 u64 pos)=0A=
>> +{=0A=
>> +	struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
>> +=0A=
>> +	if (!zone_info)=0A=
>> +		return true;=0A=
>> +=0A=
>> +	return test_bit(pos >> zone_info->zone_size_shift,=0A=
>> +			zone_info->empty_zones);=0A=
>> +}=0A=
>> +=0A=
>> +static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *de=
vice,=0A=
>> +						u64 pos, bool set)=0A=
>> +{=0A=
>> +	struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
>> +	unsigned int zno;=0A=
>> +=0A=
>> +	if (!zone_info)=0A=
>> +		return;=0A=
>> +=0A=
>> +	zno =3D pos >> zone_info->zone_size_shift;=0A=
>> +	if (set)=0A=
>> +		set_bit(zno, zone_info->empty_zones);=0A=
>> +	else=0A=
>> +		clear_bit(zno, zone_info->empty_zones);=0A=
>> +}=0A=
>> +=0A=
>> +static inline void btrfs_dev_set_zone_empty(struct btrfs_device *device=
,=0A=
>> +					    u64 pos)=0A=
>> +{=0A=
>> +	btrfs_dev_set_empty_zone_bit(device, pos, true);=0A=
>> +}=0A=
>> +=0A=
>> +static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *devi=
ce,=0A=
>> +					      u64 pos)=0A=
>> +{=0A=
>> +	btrfs_dev_set_empty_zone_bit(device, pos, false);=0A=
>> +}=0A=
>> +=0A=
>> +#endif=0A=
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
>> index d74b74ca07af..8e5a894e7bde 100644=0A=
>> --- a/fs/btrfs/volumes.c=0A=
>> +++ b/fs/btrfs/volumes.c=0A=
>> @@ -29,6 +29,7 @@=0A=
>>   #include "sysfs.h"=0A=
>>   #include "tree-checker.h"=0A=
>>   #include "space-info.h"=0A=
>> +#include "hmzoned.h"=0A=
>>   =0A=
>>   const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D=
 {=0A=
>>   	[BTRFS_RAID_RAID10] =3D {=0A=
>> @@ -342,6 +343,7 @@ void btrfs_free_device(struct btrfs_device *device)=
=0A=
>>   	rcu_string_free(device->name);=0A=
>>   	extent_io_tree_release(&device->alloc_state);=0A=
>>   	bio_put(device->flush_bio);=0A=
>> +	btrfs_destroy_dev_zone_info(device);=0A=
>>   	kfree(device);=0A=
>>   }=0A=
>>   =0A=
>> @@ -847,6 +849,11 @@ static int btrfs_open_one_device(struct btrfs_fs_de=
vices *fs_devices,=0A=
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);=0A=
>>   	device->mode =3D flags;=0A=
>>   =0A=
>> +	/* Get zone type information of zoned block devices */=0A=
>> +	ret =3D btrfs_get_dev_zone_info(device);=0A=
>> +	if (ret !=3D 0)=0A=
>> +		goto error_brelse;=0A=
>> +=0A=
>>   	fs_devices->open_devices++;=0A=
>>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&=0A=
>>   	    device->devid !=3D BTRFS_DEV_REPLACE_DEVID) {=0A=
>> @@ -2598,6 +2605,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path=0A=
>>   	}=0A=
>>   	rcu_assign_pointer(device->name, name);=0A=
>>   =0A=
>> +	device->fs_info =3D fs_info;=0A=
>> +	device->bdev =3D bdev;=0A=
>> +=0A=
>> +	/* Get zone type information of zoned block devices */=0A=
>> +	ret =3D btrfs_get_dev_zone_info(device);=0A=
>> +	if (ret)=0A=
>> +		goto error_free_device;=0A=
>> +=0A=
>>   	trans =3D btrfs_start_transaction(root, 0);=0A=
>>   	if (IS_ERR(trans)) {=0A=
>>   		ret =3D PTR_ERR(trans);=0A=
>> @@ -2614,8 +2629,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path=0A=
>>   					 fs_info->sectorsize);=0A=
>>   	device->disk_total_bytes =3D device->total_bytes;=0A=
>>   	device->commit_total_bytes =3D device->total_bytes;=0A=
>> -	device->fs_info =3D fs_info;=0A=
>> -	device->bdev =3D bdev;=0A=
>>   	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);=0A=
>>   	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);=0A=
>>   	device->mode =3D FMODE_EXCL;=0A=
>> @@ -2756,6 +2769,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path=0A=
>>   		sb->s_flags |=3D SB_RDONLY;=0A=
>>   	if (trans)=0A=
>>   		btrfs_end_transaction(trans);=0A=
>> +	btrfs_destroy_dev_zone_info(device);=0A=
>>   error_free_device:=0A=
>>   	btrfs_free_device(device);=0A=
>>   error:=0A=
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h=0A=
>> index 7f6aa1816409..5da1f354db93 100644=0A=
>> --- a/fs/btrfs/volumes.h=0A=
>> +++ b/fs/btrfs/volumes.h=0A=
>> @@ -57,6 +57,8 @@ struct btrfs_io_geometry {=0A=
>>   #define BTRFS_DEV_STATE_REPLACE_TGT	(3)=0A=
>>   #define BTRFS_DEV_STATE_FLUSH_SENT	(4)=0A=
>>   =0A=
>> +struct btrfs_zoned_device_info;=0A=
>> +=0A=
>>   struct btrfs_device {=0A=
>>   	struct list_head dev_list; /* device_list_mutex */=0A=
>>   	struct list_head dev_alloc_list; /* chunk mutex */=0A=
>> @@ -77,6 +79,8 @@ struct btrfs_device {=0A=
>>   =0A=
>>   	struct block_device *bdev;=0A=
>>   =0A=
>> +	struct btrfs_zoned_device_info *zone_info;=0A=
>> +=0A=
>>   	/* the mode sent to blkdev_get */=0A=
>>   	fmode_t mode;=0A=
>>   =0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
