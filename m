Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08C62C9537
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgLACaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 21:30:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13238 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLACaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606789845; x=1638325845;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MgmQ0oRfNFxQQR/ScGGDfhkIJUQJ4VlVIJd8haVMLSk=;
  b=YQdX4fc2oSSdhGRQ2us5vdVS9wQqlk/NuUNyKcmI0ARcd6vQ3gMU24pq
   k7F2UgQlK5BDKuscCKJYe3FYWGC8mNM3L5px7dAmIpHqlN5lZtRbHkUTx
   7TdyRcXgY5h2w/i43qEQq1vNK3FVo5TYU9/TM2If215NO9hHfSe/w0SPJ
   2NxXz5X8sUoP0sf9YJgAF9fbtFSqkm3M7PezxkVCOdOdj8+ipfxEHDaso
   s+//8cVnL89SMuDe4z+g5XDnQITLaAxeckCyUfmCZRltpK0Ry8P4UHseo
   jKJ4d6htzFPT1Z2D1KrR59y+53eJS4AOnUx9tC2fTOtPvCdvDijBTsdO9
   w==;
IronPort-SDR: OOeE1fDqCuLZ5bV1qnY7hNBi3uB2XxoHF1PQUwqvFX6OuzPtwYTiFrz3G4BRmDlyL8Ag2OzFef
 +PfHOcH2lsTxCqE/lhZ72k1ycJV8dVh3YHtEUfcmgYQkYZd6pCjfgjaIhiTndLy/ZXeBszWNqG
 3uNSolLc5wk6yWG6jI8TMtFR5f/njL9cx/fzojc50h/C6nFoyi8ixJy5IECNoUuFLUnK0a0Wb2
 4mi0vmaWwQqtBw6mDuGp3wbHK0ee56kBYL7j9OvIXA4uomML6x3Gn+tft4E60/OjCtwoRH4auF
 1WA=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="153940534"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 10:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiZ4CFFSIUbCu4F2pResyh9LM1D+ngL9zRvBluzsZTQY8xivdVH7SMpq9mCLNce9yh6Bf99vX2BUuG6t4BROa3yDEXpyCEmfgOqpsEEiN17vo+E1FbArOkn7Jdekich1h5r6rfcve59gseTuoeqPPC94PcIXATfcGAmG3qHxJLyd4HnlgUdXQqanCj6IFt31tXP+mmTzZc3I3OUMbGhYuRsV/z6Dr6fnGXGBl/iK/uAhbUH0DIeQP5L3+/ufGKbppuJshDVzEdSiBoS3HNrfUX6A2pAwKCDwqTlR5CN2EpX89mGF95KgLJtZK7mT8eR0Y3l0tG7FM8afn6jmFigCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCttjHdJIErhW3ecdAoGBils/pc4ZA+QfkIq7F4lx6o=;
 b=h4NxwkfnrVHsCD0GDBDVgANgaphTjUUot3JX2shwPUI/ARxFmDJ5OEOzcs1Ld4b9NdzIGMU5xCFthgjbveLat/lnsF/8V5T+rvpTVvRKwYChJV6fXZVYIpGOhIThRd7ANyrHj3c1ingWO46FYcKxZtReDhD6CxSNspO51LztTIL2iXHePK+qVFB26Oxq4gYDJlCdjvDZHP9k6wMC13cXUb3k5KAhrL1w+ILtEKjTz6TQdTtVMQMoe26idmqm1UATLqKZGwdLMbikQMzh0Q/yMTJv1405muTweuqafPOBzBZToheooGbkYpYYh1E9Rvb2yXvaRrAGlwLElO3zHalopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCttjHdJIErhW3ecdAoGBils/pc4ZA+QfkIq7F4lx6o=;
 b=G+RTa1WMLXes9T2gMkMifwgxSQmDGYGJRjAIL1k4NocAWWd4bkabg4noCbNJsq130wKzuV2cgxen4tJ5ZKNyz2JPB3Hfsk07ol2qICiUnQvOeKCFxD+aL95EVvoGhcV9i++vouEU2PN/1Bp3BzV5P1jdtQTbf+UojTKR5kbBx5g=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6553.namprd04.prod.outlook.com (2603:10b6:610:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 02:29:37 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 02:29:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Topic: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Index: AQHWt1SX6TBkGrIRlEa+5WXQUx+StA==
Date:   Tue, 1 Dec 2020 02:29:37 +0000
Message-ID: <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a5e02e3-efc0-4c86-5ea0-08d895a0f2c3
x-ms-traffictypediagnostic: CH2PR04MB6553:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6553C7A9B8ECA305EF9594B4E7F40@CH2PR04MB6553.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/bYF2CzFmJFVlYCJ5V8PrtCWoxs8NNpI7LxSaJHm7u1voFMPA5amCV4WXpGj6/ja+QVphIM9ABnUOH7BH3a84pnwF4yRuO981dRSt+bNjvZq6CBc33WqZ6BLQXODwCoSa2Nx//wfCw8+yJQjvcn1vhgb+YC//DoIpulFcG66R625xr4ZGL+QRcGzGln7Du+Ts4AaUs7e5CgzDBrJAAvoHSZytgyfk4GtKlFmDJWLF1HDa1Qx4KUzxVnI1Y4g6pYl8qDwgbLcjD37eddh7AXRMflGzKfEvCXHW8rf38k/5PT5oRHmibn8hjCpPGsiB3emf4/XenFcXNbDAv8HzxkpeOSL9at/YmC4YPOZWZE89n6UoeSPYvVIXY75GIcWkp7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(8936002)(2906002)(316002)(66446008)(66946007)(91956017)(71200400001)(76116006)(66556008)(64756008)(86362001)(66476007)(53546011)(33656002)(52536014)(5660300002)(186003)(7696005)(55016002)(478600001)(110136005)(83380400001)(921005)(9686003)(8676002)(7416002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UWo3MfeWL1kzybPw+V1VXQAihoCnWC7khSCVCC4CCjuGcr8cgzgCJ4LZkpwG?=
 =?us-ascii?Q?kz/TGWRkC5RvdUgecQhmb41xWEps/tU0hob/AWzF0VmI01ncUvwkbTbWJDOE?=
 =?us-ascii?Q?c6SjC7Qqy6H5dDmIXDeKryW4cWFOEdwp7CpMgaYkrny6B7smkgJySplO2Lv2?=
 =?us-ascii?Q?Uq8EMdjcjIsUG8xeNWyfO8+7AOW3dxR3Tuw2m9+KVfjNEyeQrRT3W3TpwbCC?=
 =?us-ascii?Q?kD2HaK3O+utSsNwP6H4zewKTGd8CZFK+YK0zJ/r2UUU5rVPgGSa9TlQsvIiC?=
 =?us-ascii?Q?R6C2NDInbOCoICb0Y2ykd9pD2Lxg3w48c8O+mVrcuT8JhAD4EoqDIo89n0Kw?=
 =?us-ascii?Q?KH85MdorMVMLcMiVR9Y5d8xi7y064HIrpieC7+PuZ+MIVF93WUMuyu9qF8tD?=
 =?us-ascii?Q?L+7osZulCDlZRaJljLKvZgBXWYzj9QWiOngTIw8G7XME2DqVqSp6GaHUty0r?=
 =?us-ascii?Q?AXDX6PNJlCdT2eP4xrduo4pkyT2I4RaQnxM+cCNehak8kApKwOF365TW46yc?=
 =?us-ascii?Q?bYI7qkVJBaEXUJDrzRU92NdVmwfTy4W9dVFe4dlN1to0TDKqAeaD6oP81BkT?=
 =?us-ascii?Q?59bcopAuSmLWWe0sC+vedISDUif21YdD5jhsUKO8BGzyheCrlD1iwYvBbftm?=
 =?us-ascii?Q?tohiWDGWjj/LP+Aiow7WlQZSt4E46ZzAF/ufYW7BuNR9/Kks2mkbUo+o+t2V?=
 =?us-ascii?Q?B5VWQfRncg3L5eaQei8EbEXEmiBo78WLDvF1QxFPyjulzNT/MtpxLB6+Jmes?=
 =?us-ascii?Q?qqvP3NrwZ1L1sKvkTOAWqP590wyXr1YdkB3XPCJdPp+vOaicKd7CXESucV45?=
 =?us-ascii?Q?zXvOptF1fke6gUku4Y3HtRxJHi0SFNyMm1BCRa2qMYYqjqovI0jU/+NrRUS8?=
 =?us-ascii?Q?gu5BtphKC3yO98wRE+lMPO8iyFCl4teSPm2bcpezlBMWvft/ZrZwNRy4Ka53?=
 =?us-ascii?Q?aFXbj5IZZjAkXnz5NssTQb8Q9kqQbGV5qkyhWNFs4qdfI3Dq7fnAbEYtgaf9?=
 =?us-ascii?Q?iAA0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e02e3-efc0-4c86-5ea0-08d895a0f2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:29:37.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pp6N5Rmvs1RZw82Y9VTyMx+4lo3PI7ILgf1Mb4sRJ02gP+k1M0xM1cSvk7w5FWwuFHP/h4N6EIPWfzCxjDyqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6553
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/01 11:20, Anand Jain wrote:=0A=
> On 30/11/20 9:15 pm, Damien Le Moal wrote:=0A=
>> On 2020/11/30 21:13, Anand Jain wrote:=0A=
>>> On 28/11/20 2:44 am, David Sterba wrote:=0A=
>>>> On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:=0A=
>>>>> On 10/11/20 7:26 pm, Naohiro Aota wrote:=0A=
>>>>>> This commit introduces the function btrfs_check_zoned_mode() to chec=
k if=0A=
>>>>>> ZONED flag is enabled on the file system and if the file system cons=
ists of=0A=
>>>>>> zoned devices with equal zone size.=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
>>>>>> ---=0A=
>>>>>>     fs/btrfs/ctree.h       | 11 ++++++=0A=
>>>>>>     fs/btrfs/dev-replace.c |  7 ++++=0A=
>>>>>>     fs/btrfs/disk-io.c     | 11 ++++++=0A=
>>>>>>     fs/btrfs/super.c       |  1 +=0A=
>>>>>>     fs/btrfs/volumes.c     |  5 +++=0A=
>>>>>>     fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++=
++++++=0A=
>>>>>>     fs/btrfs/zoned.h       | 26 ++++++++++++++=0A=
>>>>>>     7 files changed, 142 insertions(+)=0A=
>>>>>>=0A=
>>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>>>>>> index aac3d6f4e35b..453f41ca024e 100644=0A=
>>>>>> --- a/fs/btrfs/ctree.h=0A=
>>>>>> +++ b/fs/btrfs/ctree.h=0A=
>>>>>> @@ -948,6 +948,12 @@ struct btrfs_fs_info {=0A=
>>>>>>     	/* Type of exclusive operation running */=0A=
>>>>>>     	unsigned long exclusive_operation;=0A=
>>>>>>     =0A=
>>>>>> +	/* Zone size when in ZONED mode */=0A=
>>>>>> +	union {=0A=
>>>>>> +		u64 zone_size;=0A=
>>>>>> +		u64 zoned;=0A=
>>>>>> +	};=0A=
>>>>>> +=0A=
>>>>>>     #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>>>>>     	spinlock_t ref_verify_lock;=0A=
>>>>>>     	struct rb_root block_tree;=0A=
>>>>>> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrf=
s_fs_info *fs_info)=0A=
>>>>>>     }=0A=
>>>>>>     #endif=0A=
>>>>>>     =0A=
>>>>>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)=0A=
>>>>>> +{=0A=
>>>>>> +	return fs_info->zoned !=3D 0;=0A=
>>>>>> +}=0A=
>>>>>> +=0A=
>>>>>>     #endif=0A=
>>>>>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>>>>>> index 6f6d77224c2b..db87f1aa604b 100644=0A=
>>>>>> --- a/fs/btrfs/dev-replace.c=0A=
>>>>>> +++ b/fs/btrfs/dev-replace.c=0A=
>>>>>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct=
 btrfs_fs_info *fs_info,=0A=
>>>>>>     		return PTR_ERR(bdev);=0A=
>>>>>>     	}=0A=
>>>>>>     =0A=
>>>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>>>>>> +		btrfs_err(fs_info,=0A=
>>>>>> +			  "dev-replace: zoned type of target device mismatch with filesy=
stem");=0A=
>>>>>> +		ret =3D -EINVAL;=0A=
>>>>>> +		goto error;=0A=
>>>>>> +	}=0A=
>>>>>> +=0A=
>>>>>>     	sync_blockdev(bdev);=0A=
>>>>>>     =0A=
>>>>>>     	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_=
list) {=0A=
>>>>>=0A=
>>>>>     I am not sure if it is done in some other patch. But we still hav=
e to=0A=
>>>>>     check for=0A=
>>>>>=0A=
>>>>>     (model =3D=3D BLK_ZONED_HA && incompat_zoned))=0A=
>>>>=0A=
>>>> Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?=0A=
>>>> btrfs_check_device_zone_type checks for _HM.=0A=
>>>=0A=
>>>=0A=
>>> Still confusing to me. The below function, which is part of this=0A=
>>> patch, says we don't support BLK_ZONED_HM. So does it mean we=0A=
>>> allow BLK_ZONED_HA only?=0A=
>>>=0A=
>>> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info=
=0A=
>>> *fs_info,=0A=
>>> +						struct block_device *bdev)=0A=
>>> +{=0A=
>>> +	u64 zone_size;=0A=
>>> +=0A=
>>> +	if (btrfs_is_zoned(fs_info)) {=0A=
>>> +		zone_size =3D (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;=0A=
>>> +		/* Do not allow non-zoned device */=0A=
>>=0A=
>> This comment does not make sense. It should be:=0A=
>>=0A=
>> 		/* Only allow zoned devices with the same zone size */=0A=
>>=0A=
>>> +		return bdev_is_zoned(bdev) && fs_info->zone_size =3D=3D zone_size;=
=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/* Do not allow Host Manged zoned device */=0A=
>>> +	return bdev_zoned_model(bdev) !=3D BLK_ZONED_HM;=0A=
>>=0A=
>> The comment is also wrong. It should read:=0A=
>>=0A=
>> 	/* Allow only host managed zoned devices */=0A=
>>=0A=
>> This is because we decided to treat host aware devices in the same way a=
s=0A=
>> regular block devices, since HA drives are backward compatible with regu=
lar=0A=
>> block devices.=0A=
> =0A=
> =0A=
> Yeah, I read about them, but I have questions like do an FS work on top =
=0A=
> of a BLK_ZONED_HA without modification?=0A=
=0A=
Yes. These drives are fully backward compatible and accept random writes=0A=
anywhere. Performance however is potentially a different story as the drive=
 will=0A=
eventually need to do internal garbage collection of some sort, exactly lik=
e an=0A=
SSD, but definitely not at SSD speeds :)=0A=
=0A=
>   Are we ok to replace an HM device with a HA device? Or add a HA device =
=0A=
> to a btrfs on an HM device.=0A=
=0A=
We have a choice here: we can treat HA drives as regular devices or treat t=
hem=0A=
as HM devices. Anything in between does not make sense. I am fine either wa=
y,=0A=
the main reason being that there are no HA drive on the market today that I=
 know=0A=
of (this model did not have a lot of success due to the potentially very=0A=
unpredictable performance depending on the use case).=0A=
=0A=
So the simplest thing to do is, in my opinion, to ignore their "zone"=0A=
characteristics and treat them as regular disks. But treating them as HM dr=
ives=0A=
is a simple to do too.=0A=
=0A=
Of note is that a host-aware drive will be reported by the block layer as=
=0A=
BLK_ZONED_HA only as long as the drive does not have any partition. If it d=
oes,=0A=
then the block layer will treat the drive as a regular disk.=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
>>=0A=
>>> +}=0A=
>>>=0A=
>>>=0A=
>>> Also, if there is a new type of zoned device in the future, the older=
=0A=
>>> kernel should be able to reject the newer zone device types.=0A=
>>>=0A=
>>> And, if possible could you rename above function to=0A=
>>> btrfs_zone_type_is_valid(). Or better.=0A=
>>>=0A=
>>>=0A=
>>>>> right? What if in a non-zoned FS, a zoned device is added through the=
=0A=
>>>>> replace. No?=0A=
>>>>=0A=
>>>> The types of devices cannot mix, yeah. So I'd like to know the answer =
as=0A=
>>>> well.=0A=
>>>=0A=
>>>=0A=
>>>>>> --- a/fs/btrfs/volumes.c=0A=
>>>>>> +++ b/fs/btrfs/volumes.c=0A=
>>>>>> @@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path=0A=
>>>>>>     	if (IS_ERR(bdev))=0A=
>>>>>>     		return PTR_ERR(bdev);=0A=
>>>>>>     =0A=
>>>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>>>>>> +		ret =3D -EINVAL;=0A=
>>>>>> +		goto error;=0A=
>>>>>> +	}=0A=
>>>>>> +=0A=
>>>>>>     	if (fs_devices->seeding) {=0A=
>>>>>>     		seeding_dev =3D 1;=0A=
>>>>>>     		down_write(&sb->s_umount);=0A=
>>>>>=0A=
>>>>> Same here too. It can also happen that a zone device is added to a no=
n=0A=
>>>>> zoned fs.=0A=
>>>=0A=
>>>=0A=
>>> Thanks.=0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
