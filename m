Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE92C9772
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 07:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgLAGKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 01:10:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33309 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgLAGKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606803036; x=1638339036;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xbFLa+WBTHjjHKHrkX57f07+6rJID+EO8PHGxJkY5gI=;
  b=RjMBeKoJf5u4afxZnIceHFZSCPS9XL8Z26u8/qOo8h/Y6hOw5FkJzlto
   yWW+2EAyPFcpQI2cos/sW6s6YfE9MRnd4x1eSudeWGmDuTtAsW67fLoWv
   VGfTdjq7ugiO584dVVet99e/r7DvPYWPfbLfNr0T4dSK9/w4B9dZ+4u7g
   zho5mUwCD0OJWDe4T6D82SuLp/IBpIXaVOfkwKqXXI7/CARLCRe6moGkL
   izwQuMdcZ6UcFybYUu04GtLMmoSb85ywp5jeuJ8CZA/b4lS6jygte+9fa
   cYiEozEsiealMUsInr7N8io50i8EiEKk93lCbpvMK7KzkwuuhruSExbiT
   w==;
IronPort-SDR: RSqrT4W3xn+jXgU/G1wpAoQa6vfoGpIXVAxn1YS2M7x3I+Ow1I+1SlHuf04ZHowV5ZXxYP9aHq
 E7H/wdAlmhX7O9Yl07pQARw+NPsVr4WbO//ocI6QrUGerdlb4gIDaYasVctoi99FwHgU27CMEb
 Phq+3stuKMnYZJg331NJLGj2i6Mn0+9DPH2vq9nGUjh1w8D7bEhnL4TrCKLUo0xBVMWsHfysoh
 HqbqzNLYjFn9A/BWSUDRHAmLOjums7DdQ4/p2xMRyl8U64MfSIJ3RWqetplE2LdGQJeJ1NSZKJ
 l9s=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="264013004"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 14:09:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2EXGGIyQu6uFaxdHK6JSN5NGC8QCKRGzVmllBx9Q+INb/mpoa/P8s4XV2sI/Su150u8eE/0Fl4EQklrXePm0YJK+zTVkw7FpPo1j7RVM6HAwYIK6xxKRfZPxEeJ2gmgU0JKPt9bfY1Pw0sC9xDL3NuJ3es32Cte5Gi2BIZUuq+lZaVzwzIcxjB4wjF9rPfQN6lwektLR6jAsMCMLroId40S2SiP0XMLlyCWsCSDyi3fr1vwdqf2CL6Miw0rHfSoz7RmWx3gvXjErOHyeHLd1+lUHMrp4r9220bgdkxVzxEDs7xZtvtMeKGR2EJ0D9W8qTvKjhA1GHwjEeM9Gsx6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gla4OEagpGL6IaAggbpHCy82f7JCvIdAZPzbDmwqP80=;
 b=bFPIg9yYtcZmqiGuYsKtmukAOINdZ/t7ob9rWY4L8ndzPqsGgtIRYzfuBf2fnJqnNNO9RG3Uja636JjNbiB6YbFrI5A13A7n8wxsOUe46K1ljLsLh/TKD0UZwFJrlHkVytmpyp+e/HZaQtmUsZ5ec436A6DF3b2zAN0iEnehd06KR25MVOcumm5YOtp41kLV/Yvo+VjtRXcA/7JLCnRgGFWOO9odXfzTi7GZuJ/3ufcxxS7xiqZPX2mByzP64a6G8VV22odprEpwTJ78iw/D05iX9dp7lOf5Ul17nBHZXv/m/tyLk8XrjIcCw2Ms8MjID5AXVPr6ZC6eqK6xl4rikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gla4OEagpGL6IaAggbpHCy82f7JCvIdAZPzbDmwqP80=;
 b=A68fUD8oxvO5djUDzMdFNE2Ozk0cjE7CZYMeeuWaIrZCeotB37i+DgH6op4YAzXZYKDs2nD9l/XgNcolRf959tqIa7BzkmDSRz9tDbF0Z6hdnHzGS3MMCGGyXrQuhlcKEJWFLNx6ghaUu7jlhvwJGHFo3K04b/l2iyZDyVcYp+0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6646.namprd04.prod.outlook.com (2603:10b6:610:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 1 Dec
 2020 06:09:27 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 06:09:27 +0000
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
Date:   Tue, 1 Dec 2020 06:09:27 +0000
Message-ID: <CH2PR04MB652224DE2A682FADE28F443DE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <47fffa8d-a495-5588-f970-1ab04ece19b6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff972ae0-319d-47f4-e9dc-08d895bfa8f2
x-ms-traffictypediagnostic: CH2PR04MB6646:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB66462CD428BB428644BE8B73E7F40@CH2PR04MB6646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkfPxq3ARYsxCkhimZSvM1IJ3q7AQh/DHC8uxKR3Kz6mDwyKUnAYdISlKd6M1M04s6ydgqWLLRCZ4sYuS/C2LHz1g43p/BCE8PPTppch13OvtItIijzjr5MRMOqVMl3k1EiplmsAigh0Bp+os5709hGlEpp2elgsLtl0WBuxyP0kwl7ZHAkwporr23tdSk8FTvfdj2jgNsEk5zzHDgRantz0iy/GOGw5l/CeVvAvbvgPeEyG8kkHZDw9YgKJwp4PD7Lql941Tgvna6FiyshKZsnnTNa70yNlImLmcAe++b3HQbNyecF+0Z9CXRKSKLP4mOJoMppi338YdvLCQwPxZrdK2GT0m85Cd+dgpYIV1V6ZBi+h3HmpBPe8xq8KvJ12
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(8936002)(5660300002)(2906002)(7696005)(33656002)(53546011)(316002)(52536014)(8676002)(110136005)(9686003)(921005)(86362001)(6506007)(55016002)(76116006)(83380400001)(186003)(71200400001)(64756008)(91956017)(66476007)(478600001)(66946007)(7416002)(66556008)(26005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D6+1S+nkcYRTKoGCnGe74Vri6xFDR/7HgIKbixK7dDbsQpYqVOdYaheCUs7i?=
 =?us-ascii?Q?A0tCWAZu2X+f5olXET9JTo8ahUrOD6hCQWFIvEGrazPFQoMQTZIXDS01qGcC?=
 =?us-ascii?Q?ElWCyBi6f0g0NwVGk60A7MSZKWqQbBJ8o8hqmiHhnmwjr5AGtKRtqSPwlcCL?=
 =?us-ascii?Q?+cnkydlX8P4G9HMRdTJFNyEE3JVa9uHEsAycMMdTB6GwoaRXG4NvWEFHZ+zc?=
 =?us-ascii?Q?E31BJE/y0g3P5VAEPQCZMBKbLf0N5JkQMDLrAO2ToA1bveUH39tu+NFIJdPb?=
 =?us-ascii?Q?wJ1zdbdmQUyR88jRg+pTeqlcq2SFatcrgb55r8lw9U9L7y6ANGXZvP8DgKfC?=
 =?us-ascii?Q?Spe3CVkbbBCZ2QXhyX5/wnKNum/2vIxA0WIuOulv6H7FGXQzJErIm+nivEa0?=
 =?us-ascii?Q?qujYDkIqjf59hvP96sStWbkElE9ovZbzoICDWxiB1pqckeUAZ0o783/yvqM+?=
 =?us-ascii?Q?5e/INT5fVzFck4WnZzbI7H7oOJX8EsvmBU8nrdbM85abKLT9P/F3QbzsweVD?=
 =?us-ascii?Q?DUOWdpf0cPTWZ//el3o5280jd6NyodWy8SqGt5SUIx1FrxURzE6GXiNqT6yH?=
 =?us-ascii?Q?UrkgQclRBpgJ6HkwLa01YU+KA5xzNGN1OlQwtirpqX2Whr07+aPQqjXY+mRq?=
 =?us-ascii?Q?Ua0ELj4XS/7d44hUkPupCsBrX6pvnBjRaqlm8ANNNM2mLkgMshfMawBaArBm?=
 =?us-ascii?Q?q5JgmwE2pnRwNFWuvSDmJFdN9v01w7aIPODk3jDxV+BOOibynB0ROrXadYB7?=
 =?us-ascii?Q?fgZmvdTx+0VmUVOWdo+bxznQXEVv3O09WKU19OZDSSQo8DkkrFv+4HF4pnQn?=
 =?us-ascii?Q?USeyoiCBdnR3JfWpFvQP6hwEhtejgnShc86lnqHjA3pwi7s62Gx0Bm8OMukh?=
 =?us-ascii?Q?QaRtIST+TXEXp7/VWNi8PWB2T5HTPMnF9ydMmR2iPqX44vcuEGFhrMUq2UNx?=
 =?us-ascii?Q?C/gyxBxV5OF5pR0zQUqoCsL1GEREPYA34FOI2QSXPxCwcQqy7Ly7kLcENjuG?=
 =?us-ascii?Q?Jh0w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff972ae0-319d-47f4-e9dc-08d895bfa8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 06:09:27.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsZdBun/5n7Mbju/xOJRnMghz0kKdbIFsYR2G4KGi5NxZwRYDwEdu4tnxegRgcRIntIJYmLlGMxwvGNVJMwRMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6646
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/01 14:54, Anand Jain wrote:=0A=
> On 1/12/20 10:29 am, Damien Le Moal wrote:=0A=
>> On 2020/12/01 11:20, Anand Jain wrote:=0A=
>>> On 30/11/20 9:15 pm, Damien Le Moal wrote:=0A=
>>>> On 2020/11/30 21:13, Anand Jain wrote:=0A=
>>>>> On 28/11/20 2:44 am, David Sterba wrote:=0A=
>>>>>> On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:=0A=
>>>>>>> On 10/11/20 7:26 pm, Naohiro Aota wrote:=0A=
>>>>>>>> This commit introduces the function btrfs_check_zoned_mode() to ch=
eck if=0A=
>>>>>>>> ZONED flag is enabled on the file system and if the file system co=
nsists of=0A=
>>>>>>>> zoned devices with equal zone size.=0A=
>>>>>>>>=0A=
>>>>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>>>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>>>>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
>>>>>>>> ---=0A=
>>>>>>>>      fs/btrfs/ctree.h       | 11 ++++++=0A=
>>>>>>>>      fs/btrfs/dev-replace.c |  7 ++++=0A=
>>>>>>>>      fs/btrfs/disk-io.c     | 11 ++++++=0A=
>>>>>>>>      fs/btrfs/super.c       |  1 +=0A=
>>>>>>>>      fs/btrfs/volumes.c     |  5 +++=0A=
>>>>>>>>      fs/btrfs/zoned.c       | 81 +++++++++++++++++++++++++++++++++=
+++++++++=0A=
>>>>>>>>      fs/btrfs/zoned.h       | 26 ++++++++++++++=0A=
>>>>>>>>      7 files changed, 142 insertions(+)=0A=
>>>>>>>>=0A=
>>>>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>>>>>>>> index aac3d6f4e35b..453f41ca024e 100644=0A=
>>>>>>>> --- a/fs/btrfs/ctree.h=0A=
>>>>>>>> +++ b/fs/btrfs/ctree.h=0A=
>>>>>>>> @@ -948,6 +948,12 @@ struct btrfs_fs_info {=0A=
>>>>>>>>      	/* Type of exclusive operation running */=0A=
>>>>>>>>      	unsigned long exclusive_operation;=0A=
>>>>>>>>      =0A=
>>>>>>>> +	/* Zone size when in ZONED mode */=0A=
>>>>>>>> +	union {=0A=
>>>>>>>> +		u64 zone_size;=0A=
>>>>>>>> +		u64 zoned;=0A=
>>>>>>>> +	};=0A=
>>>>>>>> +=0A=
>>>>>>>>      #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>>>>>>>      	spinlock_t ref_verify_lock;=0A=
>>>>>>>>      	struct rb_root block_tree;=0A=
>>>>>>>> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct bt=
rfs_fs_info *fs_info)=0A=
>>>>>>>>      }=0A=
>>>>>>>>      #endif=0A=
>>>>>>>>      =0A=
>>>>>>>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)=
=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	return fs_info->zoned !=3D 0;=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>>      #endif=0A=
>>>>>>>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>>>>>>>> index 6f6d77224c2b..db87f1aa604b 100644=0A=
>>>>>>>> --- a/fs/btrfs/dev-replace.c=0A=
>>>>>>>> +++ b/fs/btrfs/dev-replace.c=0A=
>>>>>>>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(stru=
ct btrfs_fs_info *fs_info,=0A=
>>>>>>>>      		return PTR_ERR(bdev);=0A=
>>>>>>>>      	}=0A=
>>>>>>>>      =0A=
>>>>>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>>>>>>>> +		btrfs_err(fs_info,=0A=
>>>>>>>> +			  "dev-replace: zoned type of target device mismatch with file=
system");=0A=
>>>>>>>> +		ret =3D -EINVAL;=0A=
>>>>>>>> +		goto error;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +=0A=
>>>>>>>>      	sync_blockdev(bdev);=0A=
>>>>>>>>      =0A=
>>>>>>>>      	list_for_each_entry(device, &fs_info->fs_devices->devices, d=
ev_list) {=0A=
>>>>>>>=0A=
>>>>>>>      I am not sure if it is done in some other patch. But we still =
have to=0A=
>>>>>>>      check for=0A=
>>>>>>>=0A=
>>>>>>>      (model =3D=3D BLK_ZONED_HA && incompat_zoned))=0A=
>>>>>>=0A=
>>>>>> Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?=0A=
>>>>>> btrfs_check_device_zone_type checks for _HM.=0A=
>>>>>=0A=
>>>>>=0A=
>>>>> Still confusing to me. The below function, which is part of this=0A=
>>>>> patch, says we don't support BLK_ZONED_HM. So does it mean we=0A=
>>>>> allow BLK_ZONED_HA only?=0A=
>>>>>=0A=
>>>>> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info=
=0A=
>>>>> *fs_info,=0A=
>>>>> +						struct block_device *bdev)=0A=
>>>>> +{=0A=
>>>>> +	u64 zone_size;=0A=
>>>>> +=0A=
>>>>> +	if (btrfs_is_zoned(fs_info)) {=0A=
>>>>> +		zone_size =3D (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;=0A=
>>>>> +		/* Do not allow non-zoned device */=0A=
>>>>=0A=
>>>> This comment does not make sense. It should be:=0A=
>>>>=0A=
>>>> 		/* Only allow zoned devices with the same zone size */=0A=
>>>>=0A=
>>>>> +		return bdev_is_zoned(bdev) && fs_info->zone_size =3D=3D zone_size;=
=0A=
>>>>> +	}=0A=
>>>>> +=0A=
>>>>> +	/* Do not allow Host Manged zoned device */=0A=
>>>>> +	return bdev_zoned_model(bdev) !=3D BLK_ZONED_HM;=0A=
>>>>=0A=
>>>> The comment is also wrong. It should read:=0A=
>>>>=0A=
>>>> 	/* Allow only host managed zoned devices */=0A=
>>>>=0A=
>>>> This is because we decided to treat host aware devices in the same way=
 as=0A=
>>>> regular block devices, since HA drives are backward compatible with re=
gular=0A=
>>>> block devices.=0A=
>>>=0A=
>>>=0A=
>>> Yeah, I read about them, but I have questions like do an FS work on top=
=0A=
>>> of a BLK_ZONED_HA without modification?=0A=
>>=0A=
>> Yes. These drives are fully backward compatible and accept random writes=
=0A=
>> anywhere. Performance however is potentially a different story as the dr=
ive will=0A=
>> eventually need to do internal garbage collection of some sort, exactly =
like an=0A=
>> SSD, but definitely not at SSD speeds :)=0A=
>>=0A=
>>>    Are we ok to replace an HM device with a HA device? Or add a HA devi=
ce=0A=
>>> to a btrfs on an HM device.=0A=
>>=0A=
>> We have a choice here: we can treat HA drives as regular devices or trea=
t them=0A=
>> as HM devices. Anything in between does not make sense. I am fine either=
 way,=0A=
>> the main reason being that there are no HA drive on the market today tha=
t I know=0A=
>> of (this model did not have a lot of success due to the potentially very=
=0A=
>> unpredictable performance depending on the use case).=0A=
>>=0A=
>> So the simplest thing to do is, in my opinion, to ignore their "zone"=0A=
>> characteristics and treat them as regular disks. But treating them as HM=
 drives=0A=
>> is a simple to do too.=0A=
>>> Of note is that a host-aware drive will be reported by the block layer =
as=0A=
>> BLK_ZONED_HA only as long as the drive does not have any partition. If i=
t does,=0A=
>> then the block layer will treat the drive as a regular disk.=0A=
> =0A=
> IMO. For now, it is better to check for the BLK_ZONED_HA explicitly in a =
=0A=
> non-zoned-btrfs. And check for BLK_ZONED_HM explicitly in a zoned-btrfs. =
=0A=
=0A=
Sure, we can. But since HA drives are backward compatible, not sure the HA =
check=0A=
for non-zoned make sense. As long as the zoned flag is not set, the drive c=
an be=0A=
used like a regular disk. If the user really want to use it as a zoned driv=
e,=0A=
then it can format with force selecting the zoned flag in btrfs super. Then=
 the=0A=
HA drive will be used as a zoned disk, exactly like HM disks.=0A=
=0A=
> This way, if there is another type of BLK_ZONED_xx in the future, we =0A=
> have the opportunity to review to support it. As below [1]...=0A=
=0A=
It is very unlikely that we will see any other zone model. ZNS adopted the =
HM=0A=
model in purpose, to avoid multiplying the possible models, making the ecos=
ystem=0A=
effort a nightmare.=0A=
=0A=
> =0A=
> [1]=0A=
> bool btrfs_check_device_type()=0A=
> {=0A=
> 	if (bdev_is_zoned()) {=0A=
> 		if (btrfs_is_zoned())=0A=
> 			if (bdev_zoned_model =3D=3D BLK_ZONED_HM)=0A=
> 			/* also check the zone_size. */=0A=
> 				return true;=0A=
> 		else=0A=
> 			if (bdev_zoned_model =3D=3D BLK_ZONED_HA)=0A=
> 			/* a regular device and FS, no zone_size to check I think? */=0A=
> 				return true;=0A=
> 	} else {=0A=
> 		if (!btrfs_is_zoned())=0A=
> 			return true=0A=
> 	}=0A=
> =0A=
> 	return false;=0A=
> }=0A=
> =0A=
> Thanks.=0A=
=0A=
Works for me. May be reverse the conditions to make things easier to read a=
nd=0A=
understand:=0A=
=0A=
bool btrfs_check_device_type()=0A=
{=0A=
	if (btrfs_is_zoned()) {=0A=
		if (bdev_is_zoned()) {=0A=
			/* also check the zone_size. */=0A=
			return true;=0A=
		}=0A=
=0A=
		/*=0A=
		 * Regular device: emulate zones with zone size equal=0A=
		 * to device extent size.=0A=
		 */=0A=
		return true;=0A=
	}=0A=
=0A=
	if (bdev_zoned_model =3D=3D BLK_ZONED_HM) {=0A=
		/* Zoned HM device require zoned btrfs */=0A=
		return false;=0A=
	}=0A=
=0A=
	/* Regular device or zoned HA device used as a regular device */=0A=
	return true;=0A=
}=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
