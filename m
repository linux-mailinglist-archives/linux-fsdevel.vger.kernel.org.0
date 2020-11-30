Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE41F2C84E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 14:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgK3NQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 08:16:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43116 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgK3NQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606742179; x=1638278179;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ppqdErKD2k5U4pHSnTnu7RBT7azst/SAaC0jnzFn7qI=;
  b=p55RI8kNMUEZVD1WYtq4LQjIGFmmt+7/9HynoE/Nyyv6BkBcOjH2XKHV
   ue3aXxDQshXfKyfZQ33MB2DP75HHoFwF1WSuz0AJjjDZTKN08VEilFJgh
   k+mNy0AYrywOctGj5ncdGobvDt1aEHqCkfPCXjHSTvGohdUMK5HBWrp2F
   2zjNnHO3unTUBVl1NwVDuxWOpd+W7uF9IdYPzsa3wr0DqY9e+5CUCQdpg
   g+fRE6egWyr5MtZQ4cGEjXEAW4R5+AFc6/eOsfgSNlDsgw8Qxlf9VzueJ
   +md/bROtx82aZ0cgr3BpMCTTPzdjcTFkh4e+kc1L7T8Nq2sdNq1dsoFSs
   g==;
IronPort-SDR: +qqEqQWeNXLk2f3UXJtFmJitn0J5SzMk7s2HksyD9DqKob4PNZ6c79on8o287PgerkOszRBsYP
 Unv6jfi7cTFqd6T3tdlj3vIM+s90lFD6hO0ypjOlGNr2khIC3eK6dXrVlAz99Yha5hL8rAd/3X
 x56Re4FNaVBRctRfQIb9BXHU0KddwpWAJCLWQ7d1FK1uIter6NF9vq4FjvVGM4Gt0gI5EWtWwN
 pRnPLHUV/Ekew0nTFrXr/CvHG+xH/yQUXnnmW5BNo4cL2gpHYwnXxGQUWJ094tJ3iFCOHwr1kX
 aro=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="153881021"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 21:15:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHRV1eJMfpUiQiNODCYgbTqfnGNYPf9Mek0+i0df/bj0MaHP2UCC56+OdPoDk7QNVqzc4JNMLBvwY+3hUQk5lj6kW2tNNhOC0FpTfSDlv840TOyMxb4LYtDhKgHGsmUFfIlUw2/Xynvosan9/baoKH8eCQAVACD1aHSVFu8J4y4kyXRRk8nk4btyTK0N0RtRbUKpg/IQZLRqlwL3EQzbnOxyOm7i1StwKfoZtwpLvWF3c38LuAlTYpaYNkJ/uFqo8Fw6HniyThvpBJNvpZKt3WqNcjv0wCyFT5ujuc8qJGNNZyyicQ3wfk30pLtJ6NvUAqM1Adsc45+bOR0UmcbefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2PEQxXySu5jtUBUDie9kWXHJkySd9gYurvSNOCIWwM=;
 b=NyHNu3W50P/mHZag7M06xI+oUFb38JsmX0zHrQBUcnuAIRMWtEzKgb3oTjmQZ/YP7eHD/CRjVOwemKCEVyVoDZs5qwbNIZDeMV3IzjX6pdiWOWm8Or5k4aKZB6zSeEUyKgQP/8ItRwAISsYl7NrzMAsfPZu1jgjkl+VRvglNyT2g5zLFLDU034sFKZ8sL6Z127H5k4tP1mjEUchICHMeUqXaCa/f6XVUoIipXT7BDSfAb//v7cNveP3GTlEGzZW0hHTJz+p4JBCs0HL71tVMRp4FNCDw9qB6anQb2Rh9yKT3OY88lLZ7qjKx6Xs2ZvKb4NtlbqW17xY6ktb0YmpOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2PEQxXySu5jtUBUDie9kWXHJkySd9gYurvSNOCIWwM=;
 b=S/qg82hAfW10NqQF3QSNJUseuJcuaFCkRmmD2rBqbeS8gIFEv/4xCrs3ttFCymY9jXZ5RIHob5GXpB3rEO93AR9uW/Gru+uh+dq3FVE9HO5CI23nYSYyN3OdRX6fWH9akv/vAGDuzYdT/40Ka6OKWm3gTcIKCBYdRf/E98/Nqlo=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7110.namprd04.prod.outlook.com (2603:10b6:610:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 13:15:11 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 13:15:11 +0000
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
Date:   Mon, 30 Nov 2020 13:15:11 +0000
Message-ID: <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94c46351-507d-4f77-8332-08d89531f7e6
x-ms-traffictypediagnostic: CH2PR04MB7110:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB71101BB3FBD65E832CD99A2CE7F50@CH2PR04MB7110.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox16t7iEeaEExYe3iswXYa42C03OZhoooBTsgKmHjYSNIAQEjlEJVzUN4DUy8er2GANYOCFw0MykloeJyd0/T/5h/tQec1Bxystb8UqPykPkUv0hvMzbIJEjAud0znRCXOcNgjXb0npNM71hFJivODyP+n3/HVddHgF3CHL00qh+KD/KGllI7YBiIRvdrGi0bToEgQAWsfeGLSJLnYgTTv2ONpgchp+l5yjurlW4pCBt57Ltbt/9blRq4lN5JWd+IvmsIKP1HFys4iWU1yx8FwoiHw06q7Y4fM93gJuPlQo6VyaIZEjMCyzEP+M6WGgeCVyOEBuoUhiVwyL6/Sm226NWKCW0CRqxWpLDR7I/E1Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(8676002)(478600001)(7696005)(52536014)(86362001)(7416002)(186003)(8936002)(33656002)(921005)(5660300002)(66556008)(66446008)(64756008)(66476007)(55016002)(6506007)(71200400001)(76116006)(53546011)(91956017)(66946007)(2906002)(110136005)(83380400001)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9e4a3STt91m14oo6wXIseZHbAyvR6nO/2tDT2U4GGIcujgRJKX1cbRB3mt6z?=
 =?us-ascii?Q?9GJdZ3No9U4LHPw5EKi++0nJ7Vmhtp05jmlCfxdCJRz4AsbKzlGPgGgaVPEg?=
 =?us-ascii?Q?WocddpDVkrt9uYSU9bd2up4/mo72LhIT6qfYahIWE6hdob3X/DJhAQbyDeMD?=
 =?us-ascii?Q?KKQOXQDgXO02j0nCfUSskKKEgbEvcWM8gdLtbVv+r7nKuVr3P996T1bq/j95?=
 =?us-ascii?Q?TxM9yEbl+EhjKx+X6A8IaBbNICD7TojgHNa5JPS5oGkG+tifv+RgXU4E9c7u?=
 =?us-ascii?Q?aGaR29+juz9TbC/PkuuwB2AN6XggpBBFp6B2av4nujy/kjEBzSQ9kyXFkK1A?=
 =?us-ascii?Q?xbr4tEtIANV1hObNs/GQXcjlB4lCb4EfWRtUaxYnPSYcAzK2anthk22o3kZb?=
 =?us-ascii?Q?nB3/XISO5v1vv9uT/weX+vrFS0jkH18ZPjidRtBkw1w+VpVI1VoWgobfDcTr?=
 =?us-ascii?Q?aTBA6cDiYb5ux9rUjK9gLqevI7ct8C6FbnWFvJUSXrMICUbQiwJTRIq4BPY2?=
 =?us-ascii?Q?6UyJqACGXWakN6DamoaAZOTR57BEX5PajMb7EmNllBg4RSu6BVAcqWwE7E/U?=
 =?us-ascii?Q?vry7WgOLBFnyrgGyN9XCl4K6amdVHwEfiZ0/kaAt01GqoFVFyTJNodXXZLtx?=
 =?us-ascii?Q?jsLIQ3qmJ70VIuUMAYltfOeR6bOKrpf4xm/FYJMA/lf69VB2UStvzCShBMqS?=
 =?us-ascii?Q?LdNAUR5bzxIdJC4g4kP0/huSA6qr2HN0gJ4cQi7fPm9aZFKpf3mKYxG6Vrtp?=
 =?us-ascii?Q?OX29+VAi/QpxTj33lVszz/Lts6Vjqve+VStjbfIZstYxgxG3ZnLt00EGM7p0?=
 =?us-ascii?Q?JsqdJ/UQNR0MaeXSrf82+rZkJhfNtgHG9GWhq7YNLYEhukRofww9fgxxyn1O?=
 =?us-ascii?Q?aCR7upMbRS/OcR3OJvgLGoIEJ2Hki/SXdHzIh73ZjQ4/bI2bZ9CeveJebH9w?=
 =?us-ascii?Q?KXwETAyXK0xLX0invIcVVQN289PfoyJdkbL9C1H879wUpZ4OjWz0b5KZUBLa?=
 =?us-ascii?Q?qqUMtz3l0bXk41NmubHV/18Apw3/GzY6ae7i9hDYP2Q6jVSC+vpXsjpy9aB4?=
 =?us-ascii?Q?2uJs+y9z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c46351-507d-4f77-8332-08d89531f7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 13:15:11.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j96zD720ZfRkX5y0Om9KCLg2o5PSpqQgFUyRvI11pzbGY6EAYS33MleqagBouSflxtnvNltVczmDVQ/IXwv4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/30 21:13, Anand Jain wrote:=0A=
> On 28/11/20 2:44 am, David Sterba wrote:=0A=
>> On Wed, Nov 18, 2020 at 07:29:20PM +0800, Anand Jain wrote:=0A=
>>> On 10/11/20 7:26 pm, Naohiro Aota wrote:=0A=
>>>> This commit introduces the function btrfs_check_zoned_mode() to check =
if=0A=
>>>> ZONED flag is enabled on the file system and if the file system consis=
ts of=0A=
>>>> zoned devices with equal zone size.=0A=
>>>>=0A=
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
>>>> ---=0A=
>>>>    fs/btrfs/ctree.h       | 11 ++++++=0A=
>>>>    fs/btrfs/dev-replace.c |  7 ++++=0A=
>>>>    fs/btrfs/disk-io.c     | 11 ++++++=0A=
>>>>    fs/btrfs/super.c       |  1 +=0A=
>>>>    fs/btrfs/volumes.c     |  5 +++=0A=
>>>>    fs/btrfs/zoned.c       | 81 +++++++++++++++++++++++++++++++++++++++=
+++=0A=
>>>>    fs/btrfs/zoned.h       | 26 ++++++++++++++=0A=
>>>>    7 files changed, 142 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>>>> index aac3d6f4e35b..453f41ca024e 100644=0A=
>>>> --- a/fs/btrfs/ctree.h=0A=
>>>> +++ b/fs/btrfs/ctree.h=0A=
>>>> @@ -948,6 +948,12 @@ struct btrfs_fs_info {=0A=
>>>>    	/* Type of exclusive operation running */=0A=
>>>>    	unsigned long exclusive_operation;=0A=
>>>>    =0A=
>>>> +	/* Zone size when in ZONED mode */=0A=
>>>> +	union {=0A=
>>>> +		u64 zone_size;=0A=
>>>> +		u64 zoned;=0A=
>>>> +	};=0A=
>>>> +=0A=
>>>>    #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>>>    	spinlock_t ref_verify_lock;=0A=
>>>>    	struct rb_root block_tree;=0A=
>>>> @@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_=
fs_info *fs_info)=0A=
>>>>    }=0A=
>>>>    #endif=0A=
>>>>    =0A=
>>>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)=0A=
>>>> +{=0A=
>>>> +	return fs_info->zoned !=3D 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>>    #endif=0A=
>>>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>>>> index 6f6d77224c2b..db87f1aa604b 100644=0A=
>>>> --- a/fs/btrfs/dev-replace.c=0A=
>>>> +++ b/fs/btrfs/dev-replace.c=0A=
>>>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct b=
trfs_fs_info *fs_info,=0A=
>>>>    		return PTR_ERR(bdev);=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>>>> +		btrfs_err(fs_info,=0A=
>>>> +			  "dev-replace: zoned type of target device mismatch with filesyst=
em");=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto error;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>>    	sync_blockdev(bdev);=0A=
>>>>    =0A=
>>>>    	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_lis=
t) {=0A=
>>>=0A=
>>>    I am not sure if it is done in some other patch. But we still have t=
o=0A=
>>>    check for=0A=
>>>=0A=
>>>    (model =3D=3D BLK_ZONED_HA && incompat_zoned))=0A=
>>=0A=
>> Do you really mean BLK_ZONED_HA, ie. host-aware (HA)?=0A=
>> btrfs_check_device_zone_type checks for _HM.=0A=
> =0A=
> =0A=
> Still confusing to me. The below function, which is part of this=0A=
> patch, says we don't support BLK_ZONED_HM. So does it mean we=0A=
> allow BLK_ZONED_HA only?=0A=
> =0A=
> +static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info =0A=
> *fs_info,=0A=
> +						struct block_device *bdev)=0A=
> +{=0A=
> +	u64 zone_size;=0A=
> +=0A=
> +	if (btrfs_is_zoned(fs_info)) {=0A=
> +		zone_size =3D (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;=0A=
> +		/* Do not allow non-zoned device */=0A=
=0A=
This comment does not make sense. It should be:=0A=
=0A=
		/* Only allow zoned devices with the same zone size */=0A=
=0A=
> +		return bdev_is_zoned(bdev) && fs_info->zone_size =3D=3D zone_size;=0A=
> +	}=0A=
> +=0A=
> +	/* Do not allow Host Manged zoned device */=0A=
> +	return bdev_zoned_model(bdev) !=3D BLK_ZONED_HM;=0A=
=0A=
The comment is also wrong. It should read:=0A=
=0A=
	/* Allow only host managed zoned devices */=0A=
=0A=
This is because we decided to treat host aware devices in the same way as=
=0A=
regular block devices, since HA drives are backward compatible with regular=
=0A=
block devices.=0A=
=0A=
> +}=0A=
> =0A=
> =0A=
> Also, if there is a new type of zoned device in the future, the older =0A=
> kernel should be able to reject the newer zone device types.=0A=
> =0A=
> And, if possible could you rename above function to =0A=
> btrfs_zone_type_is_valid(). Or better.=0A=
> =0A=
> =0A=
>>> right? What if in a non-zoned FS, a zoned device is added through the=
=0A=
>>> replace. No?=0A=
>>=0A=
>> The types of devices cannot mix, yeah. So I'd like to know the answer as=
=0A=
>> well.=0A=
> =0A=
> =0A=
>>>> --- a/fs/btrfs/volumes.c=0A=
>>>> +++ b/fs/btrfs/volumes.c=0A=
>>>> @@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info =
*fs_info, const char *device_path=0A=
>>>>    	if (IS_ERR(bdev))=0A=
>>>>    		return PTR_ERR(bdev);=0A=
>>>>    =0A=
>>>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto error;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>>    	if (fs_devices->seeding) {=0A=
>>>>    		seeding_dev =3D 1;=0A=
>>>>    		down_write(&sb->s_umount);=0A=
>>>=0A=
>>> Same here too. It can also happen that a zone device is added to a non=
=0A=
>>> zoned fs.=0A=
> =0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
