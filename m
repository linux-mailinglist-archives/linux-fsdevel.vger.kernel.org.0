Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A23276DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 06:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhCAFTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 00:19:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16859 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhCAFTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614575945; x=1646111945;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gNv6MCLU2DcVQVxZYYWX/fF7yk89fXlu+JJZiy1nILM=;
  b=iUqK2qKX611TLff2ib+iLCB87EEC5uoSwFnDYtz866U1A+RpGgy8qFwz
   RU8BTD3u1vthBmdUXv584gUFLybLaLU2xVNSh6Bg3yDDS6OJc0L1lO6iM
   HXZHaox9dzDNusxHy1l0Y1QFgmHDJ3w66XgU+l+T0aIfdAZViz6n0WHFB
   2AAyLFQERetsgg4WuU+j/ttZMtZDz+fLtgDGETy9qVlq82mZD1+MfC3bh
   narpBwojkcqT+nU5/lGMQFPrH8IwgStnt4/pS26MX7vz9rnZ+mNshz9Qq
   3/KuOmANoRDtlqPvp1NIvVQ+sMTOwmQd97Or18UqyuqzsJWXQyDi+jdWT
   Q==;
IronPort-SDR: jdu/XeP2tLmOJXKCKpwnMsJ9lYjikV8OuFiF4izYTvol28DxgLCl8P5j8nvo6UWrDP2tCYJ7li
 NT8YT/qGGotV6ym1xzfHD4ueWWMKfjTUOKESNTejo4kxY1QEPkpAWdn4kh3EFa2z2wSI/Gl546
 AjCn7qykPWCnfTrLo+C/PB+Mv7pMAk+eUe2/A9XBnfuGUvnpcoEHBODz0Uxn8nx3e4nRvRVnLf
 ev7QcHWagNIKdIzNjgNrOte7oRetqonUCVTNiHy/wFwjkNTViz3jdS31OywFiad30WirEZZ5aA
 WDc=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="161050758"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 13:17:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC/YkNP++Sslcp9qHpOmzBLCl5p1UAuknnYIBLJcTFETfT6M+/Dm0DYxAQrhz1DeiItlEnNDyFOLCmsBQ2muIPzA94jKLa+mqHteOEJTi20cXKKxGzjgNWLCfveY5l4m208Id/nzSUGamkTqihm/cisyLRs77TpjNppF87wj5o0dOG3Gfjs1QGA8OYMOj+fqBrRqNBd9JZsaFsc18T9tTcYjhdPKXZa38POtRg4Jp3Jrsotia0/aO2tOl5fd4Y6lWrsL3Gi3DQW1oxVmXGvCov23egJvUIRtZflRXDeo+YzaseluOFqHs1XUFVbaEPKxpR5bq1QX64eiV7N0gPaFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLCbndEDUQAvFYkuVvpM42fVkdTchveIwwYKiS8p1O8=;
 b=Zt0eR1QLb31s8Oiszc8lnsR/vQHx15pu+x7Mc8PJh/4rp+JihBpI1CVi8QeKP8xXc7bBcy4r5tsB3nwO4K/AZTp8FU0lgQVKpPSBv2axlQWCOSanD6QlFMbTSNR+9RPi8iqebYvZqEojjmzBa+SzhJCQkqV6wsezIVBliVae1/oCMR1b0GcvX9IJ/2LUzGCAnCvh10JUBHPKslUmUy6wS+kOoSk23J/a8kM9crrm2vG/hvAD8GMdzF4oNZFIpU9u9bdLZ5+OOHxRfnG3YrRdX7SWxK8mgLLO19RNtfagAHXVP/NKe9p84if+alGKQtrklEPgMckesW6eDWogshxnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLCbndEDUQAvFYkuVvpM42fVkdTchveIwwYKiS8p1O8=;
 b=h9cXLoedVL3a/OXzxwTDjnF/Xql6zHsEx0+WWd51DGoXAIXkSwBZsplnYl/JhPHpeL4dEyGMVpRHVoobAVJEjyDlrmZLfbrAnkpa192ekK8rsqFnwdxVO6k8u2jaosiITKurmEdVA/uKKV4oxKUNl2Futq7FQ9EvPKJgM7aJwQw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6991.namprd04.prod.outlook.com (2603:10b6:208:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 05:17:53 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:17:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXDCNMBC1SHFUmFka2H7Apg4b4+g==
Date:   Mon, 1 Mar 2021 05:17:52 +0000
Message-ID: <BL0PR04MB651469B0D0AE850CF0E069ADE79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
 <20210226191130.GR7604@twin.jikos.cz>
 <20210301045548.zirmwk56almxgint@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:347a:bb00:3286:307b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c039145-b5cd-4538-3e3a-08d8dc715d7b
x-ms-traffictypediagnostic: MN2PR04MB6991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB69918372ED97E00E7D6F6F7EE79A9@MN2PR04MB6991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gwm1dQ3qW826K5b/5cvq+yhuUoiPmO/TGuLi2cz3cu8VePhrrJjahii+3+jVuWqZ5gUCnhmAKIGl5H3tps9k3JVXMqUWFSNUPL3ucoLxgrNvDVtiUdZt41JFGEDe4m37+NYRtkIEc3EjqLdJShEQB4XY297Gv47wHAW2KU6edeQBOF8MKlJ7g8CxXJHu43gAmBX1ECak+VqtTfccl/defX9ZeI/LrOwKk6iwLDbgHxXzjTfvXkoEFLiBmEpfHcr7JfBSLtUKolAjGITBPL6drUIONX75UjtYMtk+WICJLXUqrkzCuZ7RcAp4MQSEDOijUMiz7ZSTagMUHwMuf/IZXv0PTJUlGpU7sF66q0fcKvjPC1FDYsX0Tp470iLMYxijch4PKOYRSJCmepojvI5pCl9hMuxiY2l3VBPXVS9nOq5c43ws8WRuVKYxeT+SHRvp5k5g6lqX9Waj3h5Tn2eT4t3CAMFXMUDNIyFkr875fGlvH/PpwD2KfjJPzE+bDQMdWd7iGU2TwwiV8VtzV4ZM+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(86362001)(83380400001)(110136005)(316002)(2906002)(186003)(8676002)(55016002)(66946007)(8936002)(9686003)(66556008)(7696005)(66446008)(64756008)(66476007)(478600001)(53546011)(5660300002)(71200400001)(6506007)(91956017)(76116006)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9+SOoxR1Eek7XAsfAiPleBTv2F4roPaPEoaG9sZSgxV1I1nxW+YcLldBWXx/?=
 =?us-ascii?Q?9OLp+AhS3XeEL+f4NI5RhZ9yQYpwdwNVb4FJOXq4x6y5YbStME4810rOMkeY?=
 =?us-ascii?Q?hzG9TMKAUkojF3qk9AzYp98bMEvD6amiB3ygrgvp5bWVemuJbtPopXsqliRA?=
 =?us-ascii?Q?IS5nDsFVEm72vryB3RHd4Efb//WX2Uyx8qp02wN+KYq/CJQWHON403vwFHG7?=
 =?us-ascii?Q?WNc3NsEzJ42ys/tp4Q1duvYB8mpJ/44LntfabSV6tS+uU6Trm90U8EptuT48?=
 =?us-ascii?Q?eyuiXTcYvtgIk7ziUs/DNiBp1LT81D6hR6KKeGYQmwTLI9foT0k9mryrEa8k?=
 =?us-ascii?Q?OtQDxanhgZXv/4uz0BAHSjaaKcL2njkKxZAToxLoPTRS1V+2ZjJ79QmiNtxE?=
 =?us-ascii?Q?/zwrmx3na7Ptnvjk+yvyQ2a+geKWfmJX2I5GEn2w9GwWtIf9ydyuQ4gZCw9e?=
 =?us-ascii?Q?9eu+emx8dcmZE291nqRZ6slDZ0SkApY2gg95DA9WrTcRTCvw3Estms7psVCp?=
 =?us-ascii?Q?4SrlqOg+0xFLxcDEQRnOsQCctLUHuIxig2Ec6TquErOIc602Um9oTgiJyiMB?=
 =?us-ascii?Q?1Gaz3G5h2TixVJKQIzCsFCvgu9cXt8m0fZRUjSJOzBcQTZSdmRcpjUI6/u8C?=
 =?us-ascii?Q?Xq7Gbok1zxTb72AHn8FnIZiif8g0lSNyvaB2uCwH9b4sF/CmE7mwZSu3FutV?=
 =?us-ascii?Q?eM83Jye7PPz9u/NOJfGq+foUR7xB9G0Pszbt5JMZrugc5ZMVpr69Bi2MqTog?=
 =?us-ascii?Q?FGwiMNTNxvpcJVVUcfm+5dok5FK9DJxM4qHy9kiWLT17ePJDiicMTMFFfoJ+?=
 =?us-ascii?Q?OtP2EchTqo7JuZnF0IwGl8m6z4rUx1lYykB2TZReH4U1sMdB/1LZBw0O8ZwV?=
 =?us-ascii?Q?MobAxzdtPZFiPAlUQBpNcGb2sn9uBM95vEjMc91NLE6o+qj6vd8G9YsqK4iY?=
 =?us-ascii?Q?ZSHa8zwJVeOXVm/9glVsTFd0Azr3K6ukX3UQ+Wd4lgW1mRDbIpVNZvlHD+qd?=
 =?us-ascii?Q?wQBW/1tGTnCGA9ali1AOZuDU7dxVvKcDjuuxZ0yiYbXKM8lalJzmjE2F6Hcf?=
 =?us-ascii?Q?COt0+96ZpiCZtMiP6jWKpV2dmfFs75gPKAzl5juE8N/5YF3hj43zm8+dzfX9?=
 =?us-ascii?Q?3YLqSm7RXI5H9VPQ+PhyhpjZXDU635lQYG4m1HS/SR5Xm9TqBS7bxvJfqsmr?=
 =?us-ascii?Q?jkX02Hyh94WDbdEMpXdoyKi7z+XybrM+g7nJM2HMhblZy5F8DtFgj/Y81k5r?=
 =?us-ascii?Q?UP3SRkMwMFtCTF2aEfkERqNwDRyvdbJzQ2IMPuebk6s0BDXhmNnd1nbr++rE?=
 =?us-ascii?Q?C6n2iFbZeHhcJWgbeYDM9k3BeNtQm4PQBANP/nVuONxTWGPajhzSdJf4jGZ9?=
 =?us-ascii?Q?YPdKmoV9zseGyG+YeQMHV3og2anhk+Mt29ophGcVtjx6i+rwUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c039145-b5cd-4538-3e3a-08d8dc715d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:17:52.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yke4vJw1ziQVIOScJNYsYZy3PbP0e1FGbV5JZrgDmWx3Ym8L84iU4Y16CFOdKni24yRGjPUGwBTBBosNXzmyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6991
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/01 14:02, Naohiro Aota wrote:=0A=
> On Fri, Feb 26, 2021 at 08:11:30PM +0100, David Sterba wrote:=0A=
>> On Fri, Feb 26, 2021 at 06:34:36PM +0900, Naohiro Aota wrote:=0A=
>>> This commit moves the location of superblock logging zones basing on th=
e=0A=
>>> static address instead of the static zone number.=0A=
>>>=0A=
>>> The following zones are reserved as the circular buffer on zoned btrfs.=
=0A=
>>>   - The primary superblock: zone at LBA 0 and the next zone=0A=
>>>   - The first copy: zone at LBA 16G and the next zone=0A=
>>>   - The second copy: zone at LBA 256G and the next zone=0A=
>>=0A=
>> This contains all the important information but somehow feels too short=
=0A=
>> given how many mails we've exchanged and all the reasoning why we do=0A=
>> that=0A=
> =0A=
> Yep, sure. I'll expand the description and repost.=0A=
> =0A=
>>>=0A=
>>> We disallow zone size larger than 8GB not to overlap the superblock log=
=0A=
>>> zones.=0A=
>>>=0A=
>>> Since the superblock zones overlap, we disallow zone size larger than 8=
GB.=0A=
>>=0A=
>> or why we chose 8G to be the reasonable upper limit for the zone size.=
=0A=
>>=0A=
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>> ---=0A=
>>>  fs/btrfs/zoned.c | 21 +++++++++++++++------=0A=
>>>  1 file changed, 15 insertions(+), 6 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>>> index 9a5cf153da89..40cb99854844 100644=0A=
>>> --- a/fs/btrfs/zoned.c=0A=
>>> +++ b/fs/btrfs/zoned.c=0A=
>>> @@ -112,10 +112,9 @@ static int sb_write_pointer(struct block_device *b=
dev, struct blk_zone *zones,=0A=
>>>  =0A=
>>>  /*=0A=
>>>   * The following zones are reserved as the circular buffer on ZONED bt=
rfs.=0A=
>>> - *  - The primary superblock: zones 0 and 1=0A=
>>> - *  - The first copy: zones 16 and 17=0A=
>>> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, a=
nd=0A=
>>> - *                     the following one=0A=
>>> + *  - The primary superblock: zone at LBA 0 and the next zone=0A=
>>> + *  - The first copy: zone at LBA 16G and the next zone=0A=
>>> + *  - The second copy: zone at LBA 256G and the next zone=0A=
>>>   */=0A=
>>>  static inline u32 sb_zone_number(int shift, int mirror)=0A=
>>>  {=0A=
>>> @@ -123,8 +122,8 @@ static inline u32 sb_zone_number(int shift, int mir=
ror)=0A=
>>>  =0A=
>>>  	switch (mirror) {=0A=
>>>  	case 0: return 0;=0A=
>>> -	case 1: return 16;=0A=
>>> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);=0A=
>>> +	case 1: return 1 << (const_ilog2(SZ_16G) - shift);=0A=
>>> +	case 2: return 1 << (const_ilog2(SZ_1G) + 8 - shift);=0A=
>>=0A=
>> This ilog(SZ_1G) + 8 is confusing, it should have been 256G for clarity,=
=0A=
>> as it's a constant it'll get expanded at compile time.=0A=
> =0A=
> I'd like to use SZ_256G here, but linux/sizes.h does not define=0A=
> it. I'll define one for us and use it in the next version.=0A=
=0A=
Or just use const_ilog2(256 * SZ_1G)... That is fairly easy to understand :=
)=0A=
=0A=
I would even go further and add:=0A=
=0A=
#define BTRFS_SB_FIRST_COPY_OFST		(16ULL * SZ_1G)=0A=
#define BTRFS_SB_SECOND_COPY_OFST		(256ULL * SZ_1G)=0A=
=0A=
To be clear about what the values represent.=0A=
Then you can have:=0A=
=0A=
+	case 1: return 1 << (const_ilog2(BTRFS_SB_FIRST_COPY_OFST) - shift);=0A=
+	case 2: return 1 << (const_ilog2(BTRFS_SB_SECOND_COPY_OFST) - shift);=0A=
=0A=
> =0A=
>>>  	}=0A=
>>>  =0A=
>>>  	return 0;=0A=
>>> @@ -300,6 +299,16 @@ int btrfs_get_dev_zone_info(struct btrfs_device *d=
evice)=0A=
>>>  		zone_sectors =3D bdev_zone_sectors(bdev);=0A=
>>>  	}=0A=
>>>  =0A=
>>> +	/* We don't support zone size > 8G that SB log zones overlap. */=0A=
>>> +	if (zone_sectors > (SZ_8G >> SECTOR_SHIFT)) {=0A=
>>> +		btrfs_err_in_rcu(fs_info,=0A=
>>> +				 "zoned: %s: zone size %llu is too large",=0A=
>>> +				 rcu_str_deref(device->name),=0A=
>>> +				 (u64)zone_sectors << SECTOR_SHIFT);=0A=
>>> +		ret =3D -EINVAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>>  	nr_sectors =3D bdev_nr_sectors(bdev);=0A=
>>>  	/* Check if it's power of 2 (see is_power_of_2) */=0A=
>>>  	ASSERT(zone_sectors !=3D 0 && (zone_sectors & (zone_sectors - 1)) =3D=
=3D 0);=0A=
>>> -- =0A=
>>> 2.30.1=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
