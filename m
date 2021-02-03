Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7C30D34D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 07:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhBCGLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 01:11:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60905 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhBCGLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612332682; x=1643868682;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/XVockJGhBnsSNSWhwqC0qrbxq5NMTu1ktVqkqyqf7k=;
  b=KAnW5OZgz2++QlScZhXnwep2KOo9Hlym4CAaZdzeomvV9CccTi63AF3M
   Ae7H32WvHOcNFQYzuOYooPGGceYpJqiW4P6gmq5iTheZHLj07B2TyVUep
   JR8bDFct16dudq6gWavzCkisJO/Ggirmwts9wsyS7SPX/9zgEoCe8z9BA
   amShOE0/FKdSHx9dpwWbnFVz7isNCtawwfkKdxM251i88YIOtnmJABKCP
   hroxfcCKarteUdecDDGjjRhMLaBBvoUWYecu2rz8cYeCDQTd+4m9a8gUs
   //HzlBkeSgNksKNu1OPD/ZGQ+dF7xLO4iwu5028Ofau3aYkBlyHE1NizG
   Q==;
IronPort-SDR: Rfee0tijLftmgPTRo0+xu4y0RSWZWsOiTIZ8LkamALoui+l79C0ghG7Od2EUHiRd04+fAt2ZOO
 fMF8FWcFsMQIHmdWWMguAPXiq9JpIynq6mOoODMfXIx5w3ovSHmVnL8LhcOUc/O5dz0I0Efbc5
 WYj+q9CEQOc7iNCAdBbq2FzZzwQav4M7yKKANX/hxNi94XPivg2jNWB198cIASmN9E8zomNyhi
 BP/2GvbYpmzVE0gX5j1jahRLBvdtQTUFJZyPVQpY1hqHjB5faz4cq3mrcPOTZBS+5fbAjDE/JF
 TXc=
X-IronPort-AV: E=Sophos;i="5.79,397,1602518400"; 
   d="scan'208";a="158994350"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 14:10:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYyLdz/oKtyyULHDg5tuBtNT+L05gGJg+XzhQVBr+iaSeFcSniuikPU5+39n9MpM44CpP8Qq1ybgdJHxJtDiU5AIHzLyCK2R+Kuvvl5D9u0MB2j4SKjfLSEDgLkpzNGpuKlQOk1LcXbRT/KuyDC5laWrKsPPcE06GhCAJaCO/Y3WBJAEuHN7mPHXxO5TinPzEKaq+hJfvtUlsSVrsSu+7jvATBcLy9liwe3H9EqLxctqqkcV/Js1469Nn+cWzKTb36JsoHMAUFw8WQxsnnyQFMJh0VIM+W8ETPsVi4Qz4Dp6LD8DueEzatU9N+BQK8q5RC3z31gpLKMPaAAaJjCdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFUgUcQjcI8fhd7kH5OrfCcFlKmz4Cmy+gdP27lrlKY=;
 b=BBFbYrWYdVmYtNx/FXQGlpDjIwkOsznVSgEqRmixRAuRiLRc0ajqMmUqg98L8LLh/Wlok//LekK1tgAbSXx84v+CJUAjsHL9gydrdeIR83df5hD1fDvK9rt/1sE6SVfXy4Ih6NtvPLpPaWaRiWswruPQjfxpzr27kNdh8b/URHDFDPjxrFFoJzbn2lU8HOMc+MjkZZlJuKcZlMOGB/g3aWNZPqb8LfJfMpGkobLgj+Rt5z5/0/9cJ0lQSaeZpzw5M9aZvmNpg/HsODlHRtR2pFpyNjfMDwYSyvZDewCO9Ay5UAruez7TqWB8/xZgmdOV30jDXhZIwyWUtMinAeVZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFUgUcQjcI8fhd7kH5OrfCcFlKmz4Cmy+gdP27lrlKY=;
 b=vPeLRXNtN1Q/12M6fX6lk7Hz96IcQ8PZ2b9JWDD5FdG4P4SmSaCfE7OjL1q9Oul/2lfxIxB1nhQyvAQ/9yLLs9Ko5Gt6uM50dN4zE0oeXtqV57E6u55/wf17wU/P7lE+JW0vU2z4mn7B9kZnr/P3ar1Xixpcb+5UZ/r4WmgPp44=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 06:10:15 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 06:10:15 +0000
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
Date:   Wed, 3 Feb 2021 06:10:14 +0000
Message-ID: <BL0PR04MB6514F8BEC71EFA6E8DE76DE9E7B49@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
 <c1ba8d31-09f7-bab5-72ec-414bf8d7fcc1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b49c692-af70-4797-7add-08d8c80a5f85
x-ms-traffictypediagnostic: MN2PR04MB6733:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6733055D3A966CFE4D016A41E7B49@MN2PR04MB6733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y69Q2T5HLGIBR39UGkJ77LQUxO/P/FM1J+hawUzfHPctLiYcfk7kcVYLUeZOIRcU/iymf+uuXBuF7j41u4NtJVqcsLYl98v9nPp2ftDumL4ZJptbJI5hFzJjI/EDqTDQsxrKmeK0Y3LffMS/EesDNLJIeCjH+twfPKBAjQnFTtcjoJhyBm8AXf0uv51razIqTgC3L+0moCnDoNgFs1zW3gpJitxqFHeBn7o9+IZYA8fR+rig9IoGOuO4CJBvwJ+X619HdZs9AK69XO1WyECklNd063nQQsDGYlrHMv8DQjcZW1eQfAgK5ErZ0S7I5B6/oB4R9oEmoMuoDBf4Z4dpT6XPi6AATEYzkc0Uq1CPDr9w3K6QFUk6jqD/J4LtqS6QvTNedq2i1GVC1GKsnjodqUW2REcYYNtOgDLzElf9eB57M/aDwaFtNXydOhEoW3P0fN4ShWychQaCzpxSYLl4nvadbC8OJP9ZMDLr08Fv11MesJc1jzsrRPo6lz9J7ZymjONsEGp8UsW+P8XrHON5Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(8936002)(86362001)(4326008)(66446008)(64756008)(6506007)(55016002)(2906002)(5660300002)(91956017)(52536014)(33656002)(53546011)(66556008)(9686003)(66476007)(54906003)(478600001)(8676002)(316002)(71200400001)(186003)(7696005)(110136005)(83380400001)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XLVv3bY4qQVyekjUYBA5voXd+RiKJS1N1bP9czLlgqkyIn/JViBGzEHpYcGs?=
 =?us-ascii?Q?ISdzM79kbZii7W9QGJZwB5FNOb5fgzvsc3Hk8i5TtIvUg6HLekBvU+LJj7G1?=
 =?us-ascii?Q?cn913+aj6K6CZGEI3DAlioCv3L3KbP9Avmg8PY7sCit9iZ5eEEKb851tiars?=
 =?us-ascii?Q?r+W64k3hR5y2dBwnx5FHXkGqBnidNLLTZj6UFSASwtCjhM4F2kft7GZ7Z3vY?=
 =?us-ascii?Q?8w9g6KcFpj3DLbi7D2X77jrg/pG7kn70bGRdBvAmnGlZljsyGFRDdTOpW42p?=
 =?us-ascii?Q?n7O6Jv9jyBj8PxvI1bXnGlzB1VQ0pNEceImZ3HASwvhp4eMVaFPOySt0G6gc?=
 =?us-ascii?Q?3IWYzaTTthbkLQk/D1dljotA4PWcXZaYN+J7jCChbpnmhmMHWHK2vcOSFw6v?=
 =?us-ascii?Q?1ROY/WSVmZehHWP9AgV+4oToCUNLHhZ5NWUvsSQK1VugqwhOXumfqp4rgYp0?=
 =?us-ascii?Q?Lf2qkSC4SvAnv3c3axArsuGbCakU0dNLFwEQUZdo62PupKv8I04ETpYOUsSZ?=
 =?us-ascii?Q?SsFxKJpLvzNn3IMSDBfo1HQ2RfecrAePViAwAkdtWAYqu/0A6jKhUiXhklTS?=
 =?us-ascii?Q?TJ+w/IzquPs2rFb3nTQSw6Idx9xfRl9nLmj/DRkuzfsP7J6V3c/Pw3gdlSqx?=
 =?us-ascii?Q?NEtsuXXsm7kZQoQ3LMrVA/P5isd1fDdrqGUuRMEdfopz9g5/LbsWInmC+X02?=
 =?us-ascii?Q?7ISYO3psou9cBN8g4dR1BOXGZ2FZAoyhkyde79xSkT34RrdnRA457sgKNGju?=
 =?us-ascii?Q?0RvCsfIYS1NGq15rSYfU2hypnJHZ2XxbiExANf1ZmwwTbQh2PDlL2PKrW+rP?=
 =?us-ascii?Q?8YiPv7UXFhBD+xihxu2fI7pLWYDylB6/US2VwqsTXHYSuGEe1MxSQS4jER6S?=
 =?us-ascii?Q?4732z7nDZHmhxBVz7i7PxWCxsT8UTGsM1Xeu+tCy1l2pU0QA5PICWvXxL19X?=
 =?us-ascii?Q?i1wLsvd+4tFGJjbjehQv/UDy169K5OwyOaNbb4sgLnTh6/xgrnEKuz25W/C/?=
 =?us-ascii?Q?BE5UMfU2PHli78dZJtVlqv+pKPd0ZJnaKwWhFGb2AFYosXdBbMoQh1OlxVQG?=
 =?us-ascii?Q?8Nnncsud6t7u81BEy9cDDzUSuPstDdqoh3Y/5yM2/bpGUhi5V1yA/C6hxXB6?=
 =?us-ascii?Q?+fyngkQAChAxk4K5Bz3XtJ8QdTMEMpeXXfNEX0HNw6C+sPbPV8/sJQ9e7Utp?=
 =?us-ascii?Q?VdvjeXyaHmXHBAON0Kqi3z8lkVX9AQRBNlcvMc3zbsyao720uLb4DgX5sUCf?=
 =?us-ascii?Q?OPtNcODGxVPSFGGxHAeUy5fScuoiO+QOyb5G+RgkP3+1D0U+TrrVZ18gNVWb?=
 =?us-ascii?Q?LxSdY56jcNOReHuD155rYBnOqbfoljucWFPZpvZ07AErEIghzTsVn3/Io/Ob?=
 =?us-ascii?Q?Ncd7PQUdmluYHSxw5LUh37Na1UoawajLRkSAwLRtCLeM76rV5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b49c692-af70-4797-7add-08d8c80a5f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 06:10:14.9840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1giNynXyDgujsGsPa+Cu8b5Cdkez5DFGbOLnFM45zTJzMcpigmcZ2L3DJvLxkSqvK9bANtrRwp7JJKTW3aQtCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/03 14:22, Anand Jain wrote:=0A=
> On 1/26/2021 10:24 AM, Naohiro Aota wrote:=0A=
>> Conventional zones do not have a write pointer, so we cannot use it to=
=0A=
>> determine the allocation offset if a block group contains a conventional=
=0A=
>> zone.=0A=
>>=0A=
>> But instead, we can consider the end of the last allocated extent in the=
=0A=
>> block group as an allocation offset.=0A=
>>=0A=
>> For new block group, we cannot calculate the allocation offset by=0A=
>> consulting the extent tree, because it can cause deadlock by taking exte=
nt=0A=
>> buffer lock after chunk mutex (which is already taken in=0A=
>> btrfs_make_block_group()). Since it is a new block group, we can simply =
set=0A=
>> the allocation offset to 0, anyway.=0A=
>>=0A=
> =0A=
> Information about how are the WP of conventional zones used is missing he=
re.=0A=
=0A=
Conventional zones do not have valid write pointers because they can be wri=
tten=0A=
randomly. This is per ZBC/ZAC specifications. So the wp info is not used, a=
s=0A=
stated at the beginning of the commit message.=0A=
=0A=
> =0A=
> Reviewed-by: Anand Jain <anand.jain@oracle.com>=0A=
> Thanks.=0A=
> =0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/block-group.c |  4 +-=0A=
>>   fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---=
=0A=
>>   fs/btrfs/zoned.h       |  4 +-=0A=
>>   3 files changed, 98 insertions(+), 9 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index 0140fafedb6a..349b2a09bdf1 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1851,7 +1851,7 @@ static int read_one_block_group(struct btrfs_fs_in=
fo *info,=0A=
>>   			goto error;=0A=
>>   	}=0A=
>>   =0A=
>> -	ret =3D btrfs_load_block_group_zone_info(cache);=0A=
>> +	ret =3D btrfs_load_block_group_zone_info(cache, false);=0A=
>>   	if (ret) {=0A=
>>   		btrfs_err(info, "zoned: failed to load zone info of bg %llu",=0A=
>>   			  cache->start);=0A=
>> @@ -2146,7 +2146,7 @@ int btrfs_make_block_group(struct btrfs_trans_hand=
le *trans, u64 bytes_used,=0A=
>>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))=0A=
>>   		cache->needs_free_space =3D 1;=0A=
>>   =0A=
>> -	ret =3D btrfs_load_block_group_zone_info(cache);=0A=
>> +	ret =3D btrfs_load_block_group_zone_info(cache, true);=0A=
>>   	if (ret) {=0A=
>>   		btrfs_put_block_group(cache);=0A=
>>   		return ret;=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index 22c0665ee816..ca7aef252d33 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *d=
evice, u64 start, u64 size)=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)=
=0A=
>> +/*=0A=
>> + * Calculate an allocation pointer from the extent allocation informati=
on=0A=
>> + * for a block group consist of conventional zones. It is pointed to th=
e=0A=
>> + * end of the last allocated extent in the block group as an allocation=
=0A=
>> + * offset.=0A=
>> + */=0A=
>> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,=0A=
>> +				   u64 *offset_ret)=0A=
>> +{=0A=
>> +	struct btrfs_fs_info *fs_info =3D cache->fs_info;=0A=
>> +	struct btrfs_root *root =3D fs_info->extent_root;=0A=
>> +	struct btrfs_path *path;=0A=
>> +	struct btrfs_key key;=0A=
>> +	struct btrfs_key found_key;=0A=
>> +	int ret;=0A=
>> +	u64 length;=0A=
>> +=0A=
>> +	path =3D btrfs_alloc_path();=0A=
>> +	if (!path)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	key.objectid =3D cache->start + cache->length;=0A=
>> +	key.type =3D 0;=0A=
>> +	key.offset =3D 0;=0A=
>> +=0A=
>> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);=0A=
>> +	/* We should not find the exact match */=0A=
>> +	if (!ret)=0A=
>> +		ret =3D -EUCLEAN;=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	ret =3D btrfs_previous_extent_item(root, path, cache->start);=0A=
>> +	if (ret) {=0A=
>> +		if (ret =3D=3D 1) {=0A=
>> +			ret =3D 0;=0A=
>> +			*offset_ret =3D 0;=0A=
>> +		}=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);=0A=
>> +=0A=
>> +	if (found_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY)=0A=
>> +		length =3D found_key.offset;=0A=
>> +	else=0A=
>> +		length =3D fs_info->nodesize;=0A=
>> +=0A=
>> +	if (!(found_key.objectid >=3D cache->start &&=0A=
>> +	       found_key.objectid + length <=3D cache->start + cache->length))=
 {=0A=
>> +		ret =3D -EUCLEAN;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +	*offset_ret =3D found_key.objectid + length - cache->start;=0A=
>> +	ret =3D 0;=0A=
>> +=0A=
>> +out:=0A=
>> +	btrfs_free_path(path);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, b=
ool new)=0A=
>>   {=0A=
>>   	struct btrfs_fs_info *fs_info =3D cache->fs_info;=0A=
>>   	struct extent_map_tree *em_tree =3D &fs_info->mapping_tree;=0A=
>> @@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache)=0A=
>>   	int i;=0A=
>>   	unsigned int nofs_flag;=0A=
>>   	u64 *alloc_offsets =3D NULL;=0A=
>> +	u64 last_alloc =3D 0;=0A=
>>   	u32 num_sequential =3D 0, num_conventional =3D 0;=0A=
>>   =0A=
>>   	if (!btrfs_is_zoned(fs_info))=0A=
>> @@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct btrf=
s_block_group *cache)=0A=
>>   =0A=
>>   	if (num_conventional > 0) {=0A=
>>   		/*=0A=
>> -		 * Since conventional zones do not have a write pointer, we=0A=
>> -		 * cannot determine alloc_offset from the pointer=0A=
>> +		 * Avoid calling calculate_alloc_pointer() for new BG. It=0A=
>> +		 * is no use for new BG. It must be always 0.=0A=
>> +		 *=0A=
>> +		 * Also, we have a lock chain of extent buffer lock ->=0A=
>> +		 * chunk mutex.  For new BG, this function is called from=0A=
>> +		 * btrfs_make_block_group() which is already taking the=0A=
>> +		 * chunk mutex. Thus, we cannot call=0A=
>> +		 * calculate_alloc_pointer() which takes extent buffer=0A=
>> +		 * locks to avoid deadlock.=0A=
>>   		 */=0A=
>> -		ret =3D -EINVAL;=0A=
>> -		goto out;=0A=
>> +		if (new) {=0A=
>> +			cache->alloc_offset =3D 0;=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +		ret =3D calculate_alloc_pointer(cache, &last_alloc);=0A=
>> +		if (ret || map->num_stripes =3D=3D num_conventional) {=0A=
>> +			if (!ret)=0A=
>> +				cache->alloc_offset =3D last_alloc;=0A=
>> +			else=0A=
>> +				btrfs_err(fs_info,=0A=
>> +			"zoned: failed to determine allocation offset of bg %llu",=0A=
>> +					  cache->start);=0A=
>> +			goto out;=0A=
>> +		}=0A=
>>   	}=0A=
>>   =0A=
>>   	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {=0A=
>> @@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btrfs=
_block_group *cache)=0A=
>>   	}=0A=
>>   =0A=
>>   out:=0A=
>> +	/* An extent is allocated after the write pointer */=0A=
>> +	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {=0A=
>> +		btrfs_err(fs_info,=0A=
>> +			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",=0A=
>> +			  logical, last_alloc, cache->alloc_offset);=0A=
>> +		ret =3D -EIO;=0A=
>> +	}=0A=
>> +=0A=
>>   	kfree(alloc_offsets);=0A=
>>   	free_extent_map(em);=0A=
>>   =0A=
>> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h=0A=
>> index 491b98c97f48..b53403ba0b10 100644=0A=
>> --- a/fs/btrfs/zoned.h=0A=
>> +++ b/fs/btrfs/zoned.h=0A=
>> @@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *=
device, u64 hole_start,=0A=
>>   int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,=
=0A=
>>   			    u64 length, u64 *bytes);=0A=
>>   int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u=
64 size);=0A=
>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);=
=0A=
>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, b=
ool new);=0A=
>>   #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 =
pos,=0A=
>>   				     struct blk_zone *zone)=0A=
>> @@ -119,7 +119,7 @@ static inline int btrfs_ensure_empty_zones(struct bt=
rfs_device *device,=0A=
>>   }=0A=
>>   =0A=
>>   static inline int btrfs_load_block_group_zone_info(=0A=
>> -	struct btrfs_block_group *cache)=0A=
>> +	struct btrfs_block_group *cache, bool new)=0A=
>>   {=0A=
>>   	return 0;=0A=
>>   }=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
