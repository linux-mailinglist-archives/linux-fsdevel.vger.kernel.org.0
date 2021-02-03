Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EE30D3ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhBCHLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 02:11:25 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14680 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhBCHLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612336278; x=1643872278;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JeGJv3Rlh/t8rsuHh/yjM66SAnDARxUA2aUzBN7CsM0=;
  b=YE6YTJh2i8q5w0VMKQhnqRGR5T/1jbLLVFXOlLho1fVsrkjdE0s8IU1h
   IP5x+2VsSw9ICnkKycNa8+Or0KvWPvs35wlQR40E2GZvS8uzlok46MO0C
   XR21OOoB7J7e+Jhzb9N93T5bY/ueJ/2jA6LgtSYlcCmh1zDqqT5NtiakF
   5Uym+8JO9TLqI/KQkadSZSTIvvZHJIbOSG8sh/eDPlipCf4CovFrGgs6G
   urbymq8na5ObR4udNObxc6FZtisEK7T3MoTc0vrXhqfboHa966+oFSCpc
   m44ci5QNGY6IitTL/O8kgzqWiGZegffKHKledBChEfjvovMV8tRMUqlKk
   Q==;
IronPort-SDR: vaW8zmQ2cj2QsSEwwczeUgDxlHXOMlP5ndLxAitxcrhV+K/OUWWiDv98NCf46VgJh8J2tpbm5p
 JntLjWkfWNZhzpViu8dgvI2KhRgIKXn12AwYCGJU5dNWnvW0z6hyMUGMztpTNC+W2dZbDbnZDN
 bBd1T9bL4Ku4uharIxZ6AZDEK7jCd8MxVMsh06XVBc8tLAKj4l8GzK1YdjKxcJmagX5jyi68UU
 lAjrW6sFWsLDSPHeXtkk9WQgLdxHR1xi+3/gMiVsGKXNOm4ETEI/EtqSOQk7Hzt7d+5yGuaOkU
 2kM=
X-IronPort-AV: E=Sophos;i="5.79,397,1602518400"; 
   d="scan'208";a="269421181"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 15:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exy7Xffimtposd6ZQF05pawbA5+3I3ZY+OAD8sU/AImTBuaEA/n2B6Id4euIW7Mj1CBXsWA+Zh18D10Q/+yqLfREDkDGMZpm1fkRmyy3MmD44rX+YcCEMIt9t3wMelcmn3nZHhR2goWDKKaXdN7XPFpdfhXRSrHdlb1+qslUnbcKcZ8jc4NHIUDykM8ERmMt4PVVlC+EfSsRP+UUl5+fJ4NZR3h+TjOPdBlMGHuN89zbMQeYyptr7Hd45jPobkhe6Qsp96f+/7pJdoHcwSqaGXGkZFaR1va/DsFqShUXT0fdQBIf21ggdYSJq9a7UoYcywVgaeYEUA2mazzju6xcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBaCOOEXqG+tntblkFnPxF1EeELCk2TzUFEcRaMFASs=;
 b=RW/lyN+TZ1kY8s6+L/p26sVCUEBm/vDkwIQYOP/ncMWc8Amb/ndK1ix4kf7n2gOUFdviU2ILZg6v+TUVul1HgP68Fbns89PuxmAnV2Di5dfPEVqc0xaMIFIU560qs38n/55EPv3Pi+LipEdnBPjkGghJHLrV1pDCu/sspVqRPgpdfrK1hOwIQBugNdhWZKutzw7VtZTpVBolgxkMY4m3Iz7fR/SBXzzilhvPScLA+xP9gSMA6q8BmpWflguQVa6yKNnK47CK+iRxgSRJw35Q7mKfPx8oT5+8+EWtqlZOfJkyPA9cNMeBvy9IlC4FQ6K5id9oxWbURmmTD7W/5eZsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBaCOOEXqG+tntblkFnPxF1EeELCk2TzUFEcRaMFASs=;
 b=ZeVzh14mBRw695FyAR8U1Su4JwnyTn5J1Ajb4YdXpQ4l/ElIL0cU17v5RoMGOG+A0w72z+DnEzbORnR3jfUyL+EY88krn/2QHDR7zI3o6hfwVbu4M252cQET0Aems7ad2BCK69IZUAmeh0+rWPON0TLvZ3sqnqPXhIFsMPWaGMk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4914.namprd04.prod.outlook.com (2603:10b6:208:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.28; Wed, 3 Feb
 2021 07:10:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 07:10:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v14 12/42] btrfs: calculate allocation offset for
 conventional zones
Thread-Topic: [PATCH v14 12/42] btrfs: calculate allocation offset for
 conventional zones
Thread-Index: AQHW9BktaO5iCD632kqldlrurSTmaw==
Date:   Wed, 3 Feb 2021 07:10:09 +0000
Message-ID: <BL0PR04MB65140A1D843F9A652EF39D2FE7B49@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
 <c1ba8d31-09f7-bab5-72ec-414bf8d7fcc1@oracle.com>
 <BL0PR04MB6514F8BEC71EFA6E8DE76DE9E7B49@BL0PR04MB6514.namprd04.prod.outlook.com>
 <a8f1aeb9-70c4-2d4f-50f3-d4902c3e4173@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00fef06f-c0fc-49d3-57fd-08d8c812be3a
x-ms-traffictypediagnostic: BL0PR04MB4914:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB49140F98070B6F34A707BF63E7B49@BL0PR04MB4914.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qz2A6ve07Ml5dPUyXrUT2vJ2kx3INJu5+CBXPJihclRlF0Hii5H2yjwXkzhB1Vzd7tqIHogTC4KZjVAFQiU52dnIRplrsgF0Q9+zWADZvXXvzXip1I8EB3qSVBxp2vtDYzG0rUyvQMF0DzhwSJi4Ej2pfhZdNiMoHRHDvlM/27aa0qpDt6sJacwJBK5aw2fawlu6OBYh6u26Taj84X188W+E/MjBEiBt3/n1D0aINmncpCKlWb6zGoK7llAehrpKbxYEyXlw+2VC16X2y2GlsWkBBrNYanA9rXKIZCon8zYnV1bPoQaVnuB2S7e1ECxOFyo5YbWzuPYyJIChHXHDucp7dOu/Fgo0dr+M3G9z3yH7JFzdpWhqT7ADQ5z1UcW2MfTlAO2vyKaCfnGFFq/ivdDZC2USITVygxGXSvdlIgmy+pFGI6IjM6L6ShEL3dm+EmQ0yKMazfqBFoAhgSgFUFi+UqX1osxJBn773trd9RyCkznYVsx/Bybk8c9WdyC+0jQ9pKTaBSCKaif7tR+rlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(66556008)(5660300002)(66476007)(64756008)(66946007)(52536014)(7696005)(76116006)(2906002)(66446008)(8936002)(186003)(4326008)(91956017)(55016002)(316002)(83380400001)(71200400001)(33656002)(9686003)(54906003)(6506007)(86362001)(53546011)(110136005)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?feeXJsBNz5h8E1ciES3mVnN4Y7fjpzepRM9VXjqPXkywmPRw8Muie39uuv+d?=
 =?us-ascii?Q?UR/SzxIjJJrbuisZMuQDg8O1VTMtOhma4mPa27WmKZb9AoffBB+s5ar1yPVC?=
 =?us-ascii?Q?e3sqBY2DsjqYAi5qx2rePAfjQNe2pjtJQCzf4NVbYtHMYj9mNuasAr6cQU89?=
 =?us-ascii?Q?JJw9SFNAGkzVmjs81BCE9LYkU1WjaA1MZKVq5t118XH2JUzdbTn1rUKyldOK?=
 =?us-ascii?Q?BhA2Y8PDqf3+v31aozZAY9mOyIJdzBGKwPjSIHHzEybCnR3ykvBEOOdxpIBF?=
 =?us-ascii?Q?Swp/rCY67lFd6BlYuDnqEJ5KRb0Xb9WzyM/N3A5gpNW39Z3Mcs+Xv8HUC5Sa?=
 =?us-ascii?Q?OAmo7vvY+/W1XgmkN0QjCovWoQr9r8XQ0ziP8Kem4NPY71onYj7HkyoHcecI?=
 =?us-ascii?Q?81ac9eclGBYzezq+w2iISuDws2UjVu0UpU9wk6EkCet4fSe+A1YHF9YfvfIZ?=
 =?us-ascii?Q?Ni07IWRdUhX5OHmP4B8YnLtVvOJpMIYjKkhPtbln07IhxxhsflWl8+ySjiCR?=
 =?us-ascii?Q?CyizXEIjjOtjClmfYg3T+hzqhg5X26q2hzds5lgKwy88Ydsr6hTA3B3YasgF?=
 =?us-ascii?Q?j6WO41c//FbzNCgbfEE9GPg702u3nHfszbQGmcPJEu0g+gIDt8TXD+VNEORx?=
 =?us-ascii?Q?0FkIoVUxN/qi+Xz/fR3DHBF8hX8RtPMHwY5YotqMeMaJpLG6xqRGRNnHMW5L?=
 =?us-ascii?Q?eiB+7U25KUR1DL/G8cWGiBtc9an6VgzJm51VizBGOvVsp8DAxQ4Liy5B3+cD?=
 =?us-ascii?Q?L6WltsbyyGMuDdS2DCSL9laeSUQZUMEXXhAzIR8Nw+3dwAvYKahfqoQVPy6o?=
 =?us-ascii?Q?vw4U8fxyfvs8OlGLwACygdz5kB1WjEUiV9RSKruqLSrjXQu8MsPpocrgsK60?=
 =?us-ascii?Q?AZ4veR4KSElZenP7iFl04SSZjLdFrFVRWSELzULQMLShIJyeZkaxm8DSPVfH?=
 =?us-ascii?Q?/q/LWkaKMDamio+HF0Gjz0nPcQXc8qB/yNgwB1JgWEcP7t+r3wnIHUreN24P?=
 =?us-ascii?Q?5OXpqhi5zsK8ggX07+h5xNNYxSQUqgbUvvvPzlOf6E4oHfEvid2PXFi+e0GT?=
 =?us-ascii?Q?m3YYRv1vWEIXqU58yip+XtKwC939ltE8QIyjd8G8vCpPcb2vtDp3FXvb6c8D?=
 =?us-ascii?Q?zWL9dPrEfjl6myvmN1321pTAByQOtVezo6Soar+QFfcEZymxkEdFDUdGT2WZ?=
 =?us-ascii?Q?RK4ukDNCjXAHlx8ULRio0XD8Q2fLnCPdS6qt1N5Vfnm2Fr/GIViDUrc7CraW?=
 =?us-ascii?Q?QazZiD3SEXwYtNHpskWO5DBPgVvo7RaLgdXfa1LuZcM63yvd/qbc8Y91eFtz?=
 =?us-ascii?Q?M8/7DvK9+K+1BQDlkdZSpdpSQwCWv64l85ns0oG9BiKX9tLanF8T6covdaQr?=
 =?us-ascii?Q?d8pom6p6+5CrBGZcMZZ8nGR05jYSaAQJnun8+75OgotSWGpY9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fef06f-c0fc-49d3-57fd-08d8c812be3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 07:10:09.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qdukczf5Hg0V650lYsmseIs2011opgaLpoU6pY3VXhtddFnMRPi46X+ZZEIv98LulY/5DE0iy/EnDoPFN6oCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4914
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/03 15:58, Anand Jain wrote:=0A=
> =0A=
> =0A=
> On 2/3/2021 2:10 PM, Damien Le Moal wrote:=0A=
>> On 2021/02/03 14:22, Anand Jain wrote:=0A=
>>> On 1/26/2021 10:24 AM, Naohiro Aota wrote:=0A=
>>>> Conventional zones do not have a write pointer, so we cannot use it to=
=0A=
>>>> determine the allocation offset if a block group contains a convention=
al=0A=
>>>> zone.=0A=
>>>>=0A=
>>>> But instead, we can consider the end of the last allocated extent in t=
he=0A=
>>>> block group as an allocation offset.=0A=
>>>>=0A=
>>>> For new block group, we cannot calculate the allocation offset by=0A=
>>>> consulting the extent tree, because it can cause deadlock by taking ex=
tent=0A=
>>>> buffer lock after chunk mutex (which is already taken in=0A=
>>>> btrfs_make_block_group()). Since it is a new block group, we can simpl=
y set=0A=
>>>> the allocation offset to 0, anyway.=0A=
>>>>=0A=
>>>=0A=
>>> Information about how are the WP of conventional zones used is missing =
here.=0A=
>>=0A=
>> Conventional zones do not have valid write pointers because they can be =
written=0A=
>> randomly. This is per ZBC/ZAC specifications. So the wp info is not used=
, as=0A=
>> stated at the beginning of the commit message.=0A=
> =0A=
> I was looking for the information why still "end of the last allocated =
=0A=
> extent in the block group" is assigned to it?=0A=
=0A=
We wanted to keep sequential allocation even for conventional zones, to hav=
e a=0A=
coherent allocation policy for all groups instead of different policies for=
=0A=
different zone types. Hence the "last allocated extent" used as a replaceme=
nt=0A=
for non-existent wp of conventional zones. we could revisit this, but I do =
like=0A=
the single allocation policy approach as that isolate, somewhat, zone types=
 from=0A=
the block group mapping to zones. There is probably room for improvements i=
n=0A=
this area though.=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>=0A=
>>> Thanks.=0A=
>>>=0A=
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>>> ---=0A=
>>>>    fs/btrfs/block-group.c |  4 +-=0A=
>>>>    fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++=
---=0A=
>>>>    fs/btrfs/zoned.h       |  4 +-=0A=
>>>>    3 files changed, 98 insertions(+), 9 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>>>> index 0140fafedb6a..349b2a09bdf1 100644=0A=
>>>> --- a/fs/btrfs/block-group.c=0A=
>>>> +++ b/fs/btrfs/block-group.c=0A=
>>>> @@ -1851,7 +1851,7 @@ static int read_one_block_group(struct btrfs_fs_=
info *info,=0A=
>>>>    			goto error;=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>> -	ret =3D btrfs_load_block_group_zone_info(cache);=0A=
>>>> +	ret =3D btrfs_load_block_group_zone_info(cache, false);=0A=
>>>>    	if (ret) {=0A=
>>>>    		btrfs_err(info, "zoned: failed to load zone info of bg %llu",=0A=
>>>>    			  cache->start);=0A=
>>>> @@ -2146,7 +2146,7 @@ int btrfs_make_block_group(struct btrfs_trans_ha=
ndle *trans, u64 bytes_used,=0A=
>>>>    	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))=0A=
>>>>    		cache->needs_free_space =3D 1;=0A=
>>>>    =0A=
>>>> -	ret =3D btrfs_load_block_group_zone_info(cache);=0A=
>>>> +	ret =3D btrfs_load_block_group_zone_info(cache, true);=0A=
>>>>    	if (ret) {=0A=
>>>>    		btrfs_put_block_group(cache);=0A=
>>>>    		return ret;=0A=
>>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>>>> index 22c0665ee816..ca7aef252d33 100644=0A=
>>>> --- a/fs/btrfs/zoned.c=0A=
>>>> +++ b/fs/btrfs/zoned.c=0A=
>>>> @@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device =
*device, u64 start, u64 size)=0A=
>>>>    	return 0;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)=
=0A=
>>>> +/*=0A=
>>>> + * Calculate an allocation pointer from the extent allocation informa=
tion=0A=
>>>> + * for a block group consist of conventional zones. It is pointed to =
the=0A=
>>>> + * end of the last allocated extent in the block group as an allocati=
on=0A=
>>>> + * offset.=0A=
>>>> + */=0A=
>>>> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,=
=0A=
>>>> +				   u64 *offset_ret)=0A=
>>>> +{=0A=
>>>> +	struct btrfs_fs_info *fs_info =3D cache->fs_info;=0A=
>>>> +	struct btrfs_root *root =3D fs_info->extent_root;=0A=
>>>> +	struct btrfs_path *path;=0A=
>>>> +	struct btrfs_key key;=0A=
>>>> +	struct btrfs_key found_key;=0A=
>>>> +	int ret;=0A=
>>>> +	u64 length;=0A=
>>>> +=0A=
>>>> +	path =3D btrfs_alloc_path();=0A=
>>>> +	if (!path)=0A=
>>>> +		return -ENOMEM;=0A=
>>>> +=0A=
>>>> +	key.objectid =3D cache->start + cache->length;=0A=
>>>> +	key.type =3D 0;=0A=
>>>> +	key.offset =3D 0;=0A=
>>>> +=0A=
>>>> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);=0A=
>>>> +	/* We should not find the exact match */=0A=
>>>> +	if (!ret)=0A=
>>>> +		ret =3D -EUCLEAN;=0A=
>>>> +	if (ret < 0)=0A=
>>>> +		goto out;=0A=
>>>> +=0A=
>>>> +	ret =3D btrfs_previous_extent_item(root, path, cache->start);=0A=
>>>> +	if (ret) {=0A=
>>>> +		if (ret =3D=3D 1) {=0A=
>>>> +			ret =3D 0;=0A=
>>>> +			*offset_ret =3D 0;=0A=
>>>> +		}=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);=
=0A=
>>>> +=0A=
>>>> +	if (found_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY)=0A=
>>>> +		length =3D found_key.offset;=0A=
>>>> +	else=0A=
>>>> +		length =3D fs_info->nodesize;=0A=
>>>> +=0A=
>>>> +	if (!(found_key.objectid >=3D cache->start &&=0A=
>>>> +	       found_key.objectid + length <=3D cache->start + cache->length=
)) {=0A=
>>>> +		ret =3D -EUCLEAN;=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +	*offset_ret =3D found_key.objectid + length - cache->start;=0A=
>>>> +	ret =3D 0;=0A=
>>>> +=0A=
>>>> +out:=0A=
>>>> +	btrfs_free_path(path);=0A=
>>>> +	return ret;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache,=
 bool new)=0A=
>>>>    {=0A=
>>>>    	struct btrfs_fs_info *fs_info =3D cache->fs_info;=0A=
>>>>    	struct extent_map_tree *em_tree =3D &fs_info->mapping_tree;=0A=
>>>> @@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs=
_block_group *cache)=0A=
>>>>    	int i;=0A=
>>>>    	unsigned int nofs_flag;=0A=
>>>>    	u64 *alloc_offsets =3D NULL;=0A=
>>>> +	u64 last_alloc =3D 0;=0A=
>>>>    	u32 num_sequential =3D 0, num_conventional =3D 0;=0A=
>>>>    =0A=
>>>>    	if (!btrfs_is_zoned(fs_info))=0A=
>>>> @@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct bt=
rfs_block_group *cache)=0A=
>>>>    =0A=
>>>>    	if (num_conventional > 0) {=0A=
>>>>    		/*=0A=
>>>> -		 * Since conventional zones do not have a write pointer, we=0A=
>>>> -		 * cannot determine alloc_offset from the pointer=0A=
>>>> +		 * Avoid calling calculate_alloc_pointer() for new BG. It=0A=
>>>> +		 * is no use for new BG. It must be always 0.=0A=
>>>> +		 *=0A=
>>>> +		 * Also, we have a lock chain of extent buffer lock ->=0A=
>>>> +		 * chunk mutex.  For new BG, this function is called from=0A=
>>>> +		 * btrfs_make_block_group() which is already taking the=0A=
>>>> +		 * chunk mutex. Thus, we cannot call=0A=
>>>> +		 * calculate_alloc_pointer() which takes extent buffer=0A=
>>>> +		 * locks to avoid deadlock.=0A=
>>>>    		 */=0A=
>>>> -		ret =3D -EINVAL;=0A=
>>>> -		goto out;=0A=
>>>> +		if (new) {=0A=
>>>> +			cache->alloc_offset =3D 0;=0A=
>>>> +			goto out;=0A=
>>>> +		}=0A=
>>>> +		ret =3D calculate_alloc_pointer(cache, &last_alloc);=0A=
>>>> +		if (ret || map->num_stripes =3D=3D num_conventional) {=0A=
>>>> +			if (!ret)=0A=
>>>> +				cache->alloc_offset =3D last_alloc;=0A=
>>>> +			else=0A=
>>>> +				btrfs_err(fs_info,=0A=
>>>> +			"zoned: failed to determine allocation offset of bg %llu",=0A=
>>>> +					  cache->start);=0A=
>>>> +			goto out;=0A=
>>>> +		}=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>>    	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {=0A=
>>>> @@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btr=
fs_block_group *cache)=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>>    out:=0A=
>>>> +	/* An extent is allocated after the write pointer */=0A=
>>>> +	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {=
=0A=
>>>> +		btrfs_err(fs_info,=0A=
>>>> +			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",=0A=
>>>> +			  logical, last_alloc, cache->alloc_offset);=0A=
>>>> +		ret =3D -EIO;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>>    	kfree(alloc_offsets);=0A=
>>>>    	free_extent_map(em);=0A=
>>>>    =0A=
>>>> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h=0A=
>>>> index 491b98c97f48..b53403ba0b10 100644=0A=
>>>> --- a/fs/btrfs/zoned.h=0A=
>>>> +++ b/fs/btrfs/zoned.h=0A=
>>>> @@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device=
 *device, u64 hole_start,=0A=
>>>>    int btrfs_reset_device_zone(struct btrfs_device *device, u64 physic=
al,=0A=
>>>>    			    u64 length, u64 *bytes);=0A=
>>>>    int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start=
, u64 size);=0A=
>>>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)=
;=0A=
>>>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache,=
 bool new);=0A=
>>>>    #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>>>    static inline int btrfs_get_dev_zone(struct btrfs_device *device, u=
64 pos,=0A=
>>>>    				     struct blk_zone *zone)=0A=
>>>> @@ -119,7 +119,7 @@ static inline int btrfs_ensure_empty_zones(struct =
btrfs_device *device,=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    static inline int btrfs_load_block_group_zone_info(=0A=
>>>> -	struct btrfs_block_group *cache)=0A=
>>>> +	struct btrfs_block_group *cache, bool new)=0A=
>>>>    {=0A=
>>>>    	return 0;=0A=
>>>>    }=0A=
>>>>=0A=
>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
