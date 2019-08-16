Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C06903EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfHPOXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 10:23:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfHPOXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565965436; x=1597501436;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=emmpqzP/cOoMpIWuZwAsSNtWGEy0Ujmmd50GvOx/Skw=;
  b=OkEiNSD2cVxNaTqHmv4ou+WAqfbUZLsz6Kp+OFhtwX5YwVcDhjh/8Bg5
   HNf2eS3j2yGb01anwSaRNn+F00p31ylQu4PB2Q+ONrcvxC32VEmOeMMGv
   TPKsXmJlqSaARKVYwT10qzU+LfrpGUuJgV2jm4eV8dVjchhL9ZRyoOB7b
   cf8jTIH0IIdauXgzTL0GUnAonTKzpKw8U0+88pQZjrWa0q//VqITEP2dG
   60Tsv+a+azG89b4KbHLzhZzqSx3lrHmgZAgms/8wWJsKzEXcEIriJJIBU
   DLFNFj8c8v4vk5ogoiginREWMjE3HqhiJXjIU7syDm6VUgVv45LEjRJSN
   Q==;
IronPort-SDR: A4obyhPPU51oxfR5KOAJMQciJ4L8PnD5n94Y7WeO5nhk9AC9mb8qSoY96oQNsg8OOlB2fp45NI
 5WMAY+Ifqlk11ImzjCQIP3pjHYbZjiDqy6h2sjaO5pJC8Cc8ReoHDE9kLw4qLNa7KhUBIXAzkh
 pWMzaRSEFUhk5tR/HaJPjij4LNKAURwLPeh6RZntH4Nj+IuNmRGDAoLwAGcYrY/QMhaQlRNAb9
 t/BahCHvCI5/nnmoDr1uRhoGQ5idf0vs+2BuyxqbK6QNhZX8jTsZCjq4x3I5oDB8VUZWpUbDlp
 lO0=
X-IronPort-AV: E=Sophos;i="5.64,393,1559491200"; 
   d="scan'208";a="216364951"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 22:23:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3m4+GPRH8QDZB46QzR2rUJlQ1Tz4lOEk4erMlkKG8IiPOtkifie5VXhuH+yh1PH4EuZZ4+RzHLpyfIgvoFifZ4kSk4SFJy+nhTJtxG+UT029EEDndx4jqC3/ny7iWBh0zBaZizRCbdWr+E8+kFFhxBIux/S/dRQsa99parawnPWu5AoNLpAzf+mYedJS87vFJnAXzj91jG8GcysRQs6yeMCGVB6cQ9eMxOT97sWf3avF1wDKi/ZHihnR50s6JM0RBWb7mDQNVPq2o2ocEoQ8nEi3ZtSt7C9HhLg3WgbBQrrIQ5uyNgeD68p/v7KZWsVrbkFeRHvC1lotcRhMr/jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuzfrsGQmK2TTRbLNdyoABlAi75nAfZfIQKCKou6hbs=;
 b=cKOtVFTaX2irSV5GT71am2bjinvyv6NMRNmxwynq+DGQBktMduS/4FzD9KqhKu3LLqZBahHE2Fg4f12+VBK9PxRr+OV1uu2R6Gn+ZhWgxKa44d9xbNvpuIybJjrPwJL9DCRMwV+7xwJkI6gSY015aXuxZydZJ9IzkWzw8ppBfMKVCp4+Iy8WHp/7LSuRQd4X/kV37nhCG19qSBX7nYG+BmHPpZqosG7+UyzRO8lMm7HRhNM4qnQ+q26RaDCAxi4b52P+IvXjx2uZxZf9KqB8EvwfDvRDKZTwkaEMR71MyMWiBp2NJm8Biij0oMjBGG1+KbJCo3UV4J5b5ndatMCx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuzfrsGQmK2TTRbLNdyoABlAi75nAfZfIQKCKou6hbs=;
 b=YuNGWuRU4ts+EIgq7uZhVp0NusB4Os/gD9UuDUZJUDf+wbwnWi8VQvj9vhhEfiobb6GV3snyvcCDdm0HqcrT6ZceyXsMjwUesTSOPf9kYLHAaqyZIEeGUUzX46/NECrZ0UjkciQPBlQIdfmInA3l+4ljQ+d68XWnzD/QEg9aWBE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5461.namprd04.prod.outlook.com (20.178.51.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 14:23:47 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 14:23:47 +0000
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
Subject: Re: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Thread-Topic: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Thread-Index: AQHVTcwLvihvHr6r6EyyA8TQQ8Cdzg==
Date:   Fri, 16 Aug 2019 14:23:47 +0000
Message-ID: <BYAPR04MB5816FCD8F3A0330C8B3DC609E7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-4-naohiro.aota@wdc.com>
 <edcb46f5-1c3e-0b69-a2d9-66164e64b07e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597c6c4b-14a9-45e4-1b79-08d7225559e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5461;
x-ms-traffictypediagnostic: BYAPR04MB5461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5461D13E733B39943E2BD830E7AF0@BYAPR04MB5461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(66946007)(476003)(316002)(3846002)(186003)(6116002)(229853002)(14454004)(54906003)(102836004)(7736002)(6246003)(25786009)(64756008)(52536014)(53936002)(76176011)(2501003)(4326008)(53546011)(14444005)(66556008)(256004)(71200400001)(71190400001)(66476007)(8676002)(110136005)(76116006)(305945005)(8936002)(66446008)(33656002)(6506007)(74316002)(26005)(81156014)(5660300002)(486006)(478600001)(9686003)(99286004)(446003)(66066001)(55016002)(7696005)(86362001)(81166006)(2906002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5461;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NTvnin7UiApjTV5I/XsaVmUZ7Do2pt9kAEtlMoK5YD+ZzDjuGHQYyi+Fo+Lohw3u+y4xl3yo/aSPbhyYI3ZbROAvbEuQuYCLk+1069jZalXIVdqnN03FDzd4SnCdKsm82CzuoRtGXoOBSeDWqfwVhZOwyucB0JpSLDGgiRji9fYlfVxBQyVRWUuNqir78PKmIP8svorEm9Kp/aK3WS4nIsbBQR6n8nQ5j3ie/y1evjaParcKsmPQVQta3eVx6Ou0wKg4bwqmSyfxfACRP8hYPyEmfgXybrkOd04GZ0tQ5qas/vw7uu6IsdWnh8rKqJlnKuChJsULetQ3z4CweRYFHq+qVkSHFXTP0/qzgONRsfp6XRxZ/Nlh0RUrCKmwXHEkPIJH+EzafuVMKp8Rqoot9WXIM9YxJQiOZxcMm3+UlkU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c6c4b-14a9-45e4-1b79-08d7225559e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 14:23:47.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlkZufBtSMW6JSvRjTIPw6cY/070x+mS31vXlUJIdeNl90FbAlAYdFUnFdYDl0eA57HukgeViKhfGc/YsGsAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5461
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/15 22:46, Anand Jain wrote:=0A=
> On 8/8/19 5:30 PM, Naohiro Aota wrote:=0A=
>> HMZONED mode cannot be used together with the RAID5/6 profile for now.=
=0A=
>> Introduce the function btrfs_check_hmzoned_mode() to check this. This=0A=
>> function will also check if HMZONED flag is enabled on the file system a=
nd=0A=
>> if the file system consists of zoned devices with equal zone size.=0A=
>>=0A=
>> Additionally, as updates to the space cache are in-place, the space cach=
e=0A=
>> cannot be located over sequential zones and there is no guarantees that =
the=0A=
>> device will have enough conventional zones to store this cache. Resolve=
=0A=
>> this problem by disabling completely the space cache.  This does not=0A=
>> introduces any problems with sequential block groups: all the free space=
 is=0A=
>> located after the allocation pointer and no free space before the pointe=
r.=0A=
>> There is no need to have such cache.=0A=
>>=0A=
>> For the same reason, NODATACOW is also disabled.=0A=
>>=0A=
>> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the=0A=
>> INODE_MAP_CACHE inode.=0A=
> =0A=
>   A list of incompatibility features with zoned devices. This need better=
=0A=
>   documentation, may be a table and its reason is better.=0A=
=0A=
Are you referring to the format of the commit message itself ? Or would you=
 like=0A=
to see a documentation added to Documentation/filesystems/btrfs.txt ?=0A=
=0A=
> =0A=
> =0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/ctree.h       |  3 ++=0A=
>>   fs/btrfs/dev-replace.c |  8 +++++=0A=
>>   fs/btrfs/disk-io.c     |  8 +++++=0A=
>>   fs/btrfs/hmzoned.c     | 67 ++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/hmzoned.h     | 18 ++++++++++++=0A=
>>   fs/btrfs/super.c       |  1 +=0A=
>>   fs/btrfs/volumes.c     |  5 ++++=0A=
>>   7 files changed, 110 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index 299e11e6c554..a00ce8c4d678 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -713,6 +713,9 @@ struct btrfs_fs_info {=0A=
>>   	struct btrfs_root *uuid_root;=0A=
>>   	struct btrfs_root *free_space_root;=0A=
>>   =0A=
>> +	/* Zone size when in HMZONED mode */=0A=
>> +	u64 zone_size;=0A=
>> +=0A=
>>   	/* the log root tree is a directory of all the other log roots */=0A=
>>   	struct btrfs_root *log_root_tree;=0A=
>>   =0A=
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>> index 6b2e9aa83ffa..2cc3ac4d101d 100644=0A=
>> --- a/fs/btrfs/dev-replace.c=0A=
>> +++ b/fs/btrfs/dev-replace.c=0A=
>> @@ -20,6 +20,7 @@=0A=
>>   #include "rcu-string.h"=0A=
>>   #include "dev-replace.h"=0A=
>>   #include "sysfs.h"=0A=
>> +#include "hmzoned.h"=0A=
>>   =0A=
>>   static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,=
=0A=
>>   				       int scrub_ret);=0A=
>> @@ -201,6 +202,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btr=
fs_fs_info *fs_info,=0A=
>>   		return PTR_ERR(bdev);=0A=
>>   	}=0A=
>>   =0A=
>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>> +		btrfs_err(fs_info,=0A=
>> +			  "zone type of target device mismatch with the filesystem!");=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto error;=0A=
>> +	}=0A=
>> +=0A=
>>   	sync_blockdev(bdev);=0A=
>>   =0A=
>>   	devices =3D &fs_info->fs_devices->devices;=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 5f7ee70b3d1a..8854ff2e5fa5 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -40,6 +40,7 @@=0A=
>>   #include "compression.h"=0A=
>>   #include "tree-checker.h"=0A=
>>   #include "ref-verify.h"=0A=
>> +#include "hmzoned.h"=0A=
>>   =0A=
>>   #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\=0A=
>>   				 BTRFS_HEADER_FLAG_RELOC |\=0A=
>> @@ -3123,6 +3124,13 @@ int open_ctree(struct super_block *sb,=0A=
>>   =0A=
>>   	btrfs_free_extra_devids(fs_devices, 1);=0A=
>>   =0A=
>> +	ret =3D btrfs_check_hmzoned_mode(fs_info);=0A=
>> +	if (ret) {=0A=
>> +		btrfs_err(fs_info, "failed to init hmzoned mode: %d",=0A=
>> +				ret);=0A=
>> +		goto fail_block_groups;=0A=
>> +	}=0A=
>> +=0A=
>>   	ret =3D btrfs_sysfs_add_fsid(fs_devices, NULL);=0A=
>>   	if (ret) {=0A=
>>   		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",=0A=
>> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c=0A=
>> index bfd04792dd62..512674d8f488 100644=0A=
>> --- a/fs/btrfs/hmzoned.c=0A=
>> +++ b/fs/btrfs/hmzoned.c=0A=
>> @@ -160,3 +160,70 @@ int btrfs_get_dev_zone(struct btrfs_device *device,=
 u64 pos,=0A=
>>   =0A=
>>   	return 0;=0A=
>>   }=0A=
>> +=0A=
>> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)=0A=
>> +{=0A=
>> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;=0A=
>> +	struct btrfs_device *device;=0A=
>> +	u64 hmzoned_devices =3D 0;=0A=
>> +	u64 nr_devices =3D 0;=0A=
>> +	u64 zone_size =3D 0;=0A=
>> +	int incompat_hmzoned =3D btrfs_fs_incompat(fs_info, HMZONED);=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	/* Count zoned devices */=0A=
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
>> +		if (!device->bdev)=0A=
>> +			continue;=0A=
>> +		if (bdev_zoned_model(device->bdev) =3D=3D BLK_ZONED_HM ||=0A=
>> +		    (bdev_zoned_model(device->bdev) =3D=3D BLK_ZONED_HA &&=0A=
>> +		     incompat_hmzoned)) {=0A=
>> +			hmzoned_devices++;=0A=
>> +			if (!zone_size) {=0A=
>> +				zone_size =3D device->zone_info->zone_size;=0A=
>> +			} else if (device->zone_info->zone_size !=3D zone_size) {=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "Zoned block devices must have equal zone sizes");=0A=
>> +				ret =3D -EINVAL;=0A=
>> +				goto out;=0A=
>> +			}=0A=
>> +		}=0A=
>> +		nr_devices++;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (!hmzoned_devices && incompat_hmzoned) {=0A=
>> +		/* No zoned block device found on HMZONED FS */=0A=
>> +		btrfs_err(fs_info, "HMZONED enabled file system should have zoned dev=
ices");=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
> =0A=
> =0A=
>   When does the HMZONED gets enabled? I presume during mkfs. Where are=0A=
>   the related btrfs-progs patches? Searching for the related btrfs-progs=
=0A=
>   patches doesn't show up anything in the ML. Looks like I am missing=0A=
>   something, nor the cover letter said anything about the progs part.=0A=
> =0A=
> Thanks, Anand=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	if (!hmzoned_devices && !incompat_hmzoned)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	fs_info->zone_size =3D zone_size;=0A=
>> +=0A=
>> +	if (hmzoned_devices !=3D nr_devices) {=0A=
>> +		btrfs_err(fs_info,=0A=
>> +			  "zoned devices cannot be mixed with regular devices");=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in=0A=
>> +	 * __btrfs_alloc_chunk(). Since we want stripe_len =3D=3D zone_size,=
=0A=
>> +	 * check the alignment here.=0A=
>> +	 */=0A=
>> +	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {=0A=
>> +		btrfs_err(fs_info,=0A=
>> +			  "zone size is not aligned to BTRFS_STRIPE_LEN");=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",=0A=
>> +		   fs_info->zone_size);=0A=
>> +out:=0A=
>> +	return ret;=0A=
>> +}=0A=
>> diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h=0A=
>> index ffc70842135e..29cfdcabff2f 100644=0A=
>> --- a/fs/btrfs/hmzoned.h=0A=
>> +++ b/fs/btrfs/hmzoned.h=0A=
>> @@ -9,6 +9,8 @@=0A=
>>   #ifndef BTRFS_HMZONED_H=0A=
>>   #define BTRFS_HMZONED_H=0A=
>>   =0A=
>> +#include <linux/blkdev.h>=0A=
>> +=0A=
>>   struct btrfs_zoned_device_info {=0A=
>>   	/*=0A=
>>   	 * Number of zones, zone size and types of zones if bdev is a=0A=
>> @@ -25,6 +27,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u6=
4 pos,=0A=
>>   		       struct blk_zone *zone, gfp_t gfp_mask);=0A=
>>   int btrfs_get_dev_zone_info(struct btrfs_device *device);=0A=
>>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);=0A=
>> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);=0A=
>>   =0A=
>>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device=
, u64 pos)=0A=
>>   {=0A=
>> @@ -76,4 +79,19 @@ static inline void btrfs_dev_clear_zone_empty(struct =
btrfs_device *device,=0A=
>>   	btrfs_dev_set_empty_zone_bit(device, pos, false);=0A=
>>   }=0A=
>>   =0A=
>> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *f=
s_info,=0A=
>> +						struct block_device *bdev)=0A=
>> +{=0A=
>> +	u64 zone_size;=0A=
>> +=0A=
>> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {=0A=
>> +		zone_size =3D (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;=0A=
>> +		/* Do not allow non-zoned device */=0A=
>> +		return bdev_is_zoned(bdev) && fs_info->zone_size =3D=3D zone_size;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Do not allow Host Manged zoned device */=0A=
>> +	return bdev_zoned_model(bdev) !=3D BLK_ZONED_HM;=0A=
>> +}=0A=
>> +=0A=
>>   #endif=0A=
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
>> index 78de9d5d80c6..d7879a5a2536 100644=0A=
>> --- a/fs/btrfs/super.c=0A=
>> +++ b/fs/btrfs/super.c=0A=
>> @@ -43,6 +43,7 @@=0A=
>>   #include "free-space-cache.h"=0A=
>>   #include "backref.h"=0A=
>>   #include "space-info.h"=0A=
>> +#include "hmzoned.h"=0A=
>>   #include "tests/btrfs-tests.h"=0A=
>>   =0A=
>>   #include "qgroup.h"=0A=
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
>> index 8e5a894e7bde..755b2ec1e0de 100644=0A=
>> --- a/fs/btrfs/volumes.c=0A=
>> +++ b/fs/btrfs/volumes.c=0A=
>> @@ -2572,6 +2572,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path=0A=
>>   	if (IS_ERR(bdev))=0A=
>>   		return PTR_ERR(bdev);=0A=
>>   =0A=
>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto error;=0A=
>> +	}=0A=
>> +=0A=
>>   	if (fs_devices->seeding) {=0A=
>>   		seeding_dev =3D 1;=0A=
>>   		down_write(&sb->s_umount);=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
