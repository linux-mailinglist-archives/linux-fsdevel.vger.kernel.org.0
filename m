Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7065944D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF1GkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 02:40:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54928 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1GkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561704041; x=1593240041;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nRhFlmYNp3gYbeF9Q2/oebTs2rJTDTVmhBdRoRfZNS4=;
  b=mRCXT8DINQZIUAx0VcTyOtrMFCIfvyNHu2ChVWNB0X4VvFIO5CLOij9C
   5a9jnm0zStUj4KozTskEGSComjGLVXN92tX4W5T/7GjL/mDAoMKLwAHf+
   wW1ofD7CKIkv1oBGWezkJCGS0jDMU2ixIrOmWFIASD7u3v2U8Q/+Githm
   F4NFu7NmYY5qsqaeM+O7eLKP65PfsjuDXO7stwyj75EeS1DLMvcMplDak
   3yTs4QdtvWnAbn8LAHzNZ2G4/X0s8XAHES7gjcCH4F3ffxdxG1uSIm84V
   liukavy+hK1njIuRWfuiIdWu3HYhk5AxcuRqOvapM7/gbq15HgWanrLiU
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,426,1557158400"; 
   d="scan'208";a="211577689"
Received: from mail-by2nam05lp2051.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 14:40:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=qUCyTptd8IoiY3Fy/WEjj56WaEN5e8Ca7/MbiaJu9xfN9HLY5V5iueXZuY789+bNL77J5vEcUGOAkwfhjxWozYMmBOBVPMm+vgVwmJVNOUqgEhwGPbfLQ9o60JaKLVni7x29KaR0chBlJLUF0L8mvZkYwu17NW0LWzsndAj/d7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESmkexQp6xMXPePZbCqOfeCVTYm7TK103WeA/yyskxM=;
 b=d4dvgo3DfHmsH7qypiDeE/mY9vS9Xh2Y7Vs1sAxtBnk3+wOXlmzLoIJR8FAeNg5Bi3gxgqJR+stf/cjB0DsIhjmg6CDtm1qIR0ALrx3IcFDrZp4808ajDfa6r84lI0ea/aMq/BtZNVzau+rbsGfClSCr/nteq0KCz3PZ0SGMtrI=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESmkexQp6xMXPePZbCqOfeCVTYm7TK103WeA/yyskxM=;
 b=AIguh8n4uwl8WOwr8+aN8x8J8n+hPCF7pIgSku6MRj8I8ruJibLafVd02rSBUe+Wk0G6IAdk9wSiOxypUVLrfd6jK7OLORPZRKCc+8dXtBPXMcmEMcCgU9tmx43A5Xlk/Fpw6URzGNR9S5tKi17V7yaE+gWwZjzYtPHd3IddVyE=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5119.namprd04.prod.outlook.com (52.135.116.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Fri, 28 Jun 2019 06:39:59 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 06:39:59 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Topic: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Index: AQHVHTKI41mlZbldhUiKC20uoMUKKg==
Date:   Fri, 28 Jun 2019 06:39:54 +0000
Message-ID: <SN6PR04MB52315AB9E229D0BAAB930D5B8CFC0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
 <0ca3c475-fe10-4135-ddc9-7a82cc966d9a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea6f06c6-7936-476d-7c3d-08d6fb937130
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5119;
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-microsoft-antispam-prvs: <SN6PR04MB5119A80413B27896960723708CFC0@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(199004)(189003)(8676002)(6116002)(74316002)(66556008)(7696005)(66946007)(71200400001)(25786009)(305945005)(3846002)(4326008)(99286004)(81156014)(81166006)(66446008)(8936002)(7416002)(71190400001)(5660300002)(66476007)(73956011)(229853002)(446003)(486006)(64756008)(68736007)(66066001)(91956017)(14454004)(76116006)(7736002)(476003)(6246003)(9686003)(54906003)(14444005)(316002)(72206003)(110136005)(53936002)(55016002)(6436002)(6666004)(256004)(76176011)(186003)(478600001)(2906002)(52536014)(86362001)(53546011)(2501003)(26005)(6506007)(102836004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5119;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uI3ajd+JN2RD30EasG4Zco/e28nG10i1vdiqunRoVQo0AK8sGSzY3MlYam7+SMsglVJ00eCHOld2vICSjy4v2DQXsTZB0Mu4GGutT//GFQ4JNQtm/ztapJiMD0izvqXJ7zm5uiKVTsh69VmQypnlmDVGRDbCdJk41Dk2WZsP0AE6FQtOK6r4lYxvFS3BpAV41leJHBYyZeujqeQ3YOjrap3Ppooaz6vYO27xvlrRm9SzB8DtKfYs3u/lps3fUa5ID+e0pqzjAHHWplsJO9iq8jLM4gtZ52qjKa3PzUJWAz6C0OfJx/8b/hIsLBPLdNGI3RErmVjlE0CgNpVLToaU7mo/tiLEgFAX+kbqpzsQ/gqA5C6V2io/sQQoxk4Hli+4hWqreLJsMgeDGN8JDEUrOKw8FLo5LzQfKHXw6amBX0A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6f06c6-7936-476d-7c3d-08d6fb937130
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:39:54.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/28 12:56, Anand Jain wrote:=0A=
> On 7/6/19 9:10 PM, Naohiro Aota wrote:=0A=
>> When in HMZONED mode, make sure that device super blocks are located in=
=0A=
>> randomly writable zones of zoned block devices. That is, do not write su=
per=0A=
>> blocks in sequential write required zones of host-managed zoned block=0A=
>> devices as update would not be possible.=0A=
> =0A=
>    By design all copies of SB must be updated at each transaction,=0A=
>    as they are redundant copies they must match at the end of=0A=
>    each transaction.=0A=
> =0A=
>    Instead of skipping the sb updates, why not alter number of=0A=
>    copies at the time of mkfs.btrfs?=0A=
> =0A=
> Thanks, Anand=0A=
=0A=
That is exactly what the patched code does. It updates all the SB=0A=
copies, but it just avoids writing a copy to sequential writing=0A=
required zones. Mkfs.btrfs do the same. So, all the available SB=0A=
copies always match after a transaction. At the SB location in a=0A=
sequential write required zone, you will see zeroed region (in the=0A=
next version of the patch series), but that is easy to ignore: it=0A=
lacks even BTRFS_MAGIC.=0A=
=0A=
The number of SB copy available on HMZONED device will vary=0A=
by its zone size and its zone layout.=0A=
=0A=
Thanks,=0A=
=0A=
> =0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>    fs/btrfs/disk-io.c     | 11 +++++++++++=0A=
>>    fs/btrfs/disk-io.h     |  1 +=0A=
>>    fs/btrfs/extent-tree.c |  4 ++++=0A=
>>    fs/btrfs/scrub.c       |  2 ++=0A=
>>    4 files changed, 18 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 7c1404c76768..ddbb02906042 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct b=
lock_device *bdev)=0A=
>>    	return latest;=0A=
>>    }=0A=
>>    =0A=
>> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos)=0A=
>> +{=0A=
>> +	/* any address is good on a regular (zone_size =3D=3D 0) device */=0A=
>> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device *=
/=0A=
>> +	return device->zone_size =3D=3D 0 || !btrfs_dev_is_sequential(device, =
pos);=0A=
>> +}=0A=
>> +=0A=
>>    /*=0A=
>>     * Write superblock @sb to the @device. Do not wait for completion, a=
ll the=0A=
>>     * buffer heads we write are pinned.=0A=
>> @@ -3495,6 +3502,8 @@ static int write_dev_supers(struct btrfs_device *d=
evice,=0A=
>>    		if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D=0A=
>>    		    device->commit_total_bytes)=0A=
>>    			break;=0A=
>> +		if (!btrfs_check_super_location(device, bytenr))=0A=
>> +			continue;=0A=
>>    =0A=
>>    		btrfs_set_super_bytenr(sb, bytenr);=0A=
>>    =0A=
>> @@ -3561,6 +3570,8 @@ static int wait_dev_supers(struct btrfs_device *de=
vice, int max_mirrors)=0A=
>>    		if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D=0A=
>>    		    device->commit_total_bytes)=0A=
>>    			break;=0A=
>> +		if (!btrfs_check_super_location(device, bytenr))=0A=
>> +			continue;=0A=
>>    =0A=
>>    		bh =3D __find_get_block(device->bdev,=0A=
>>    				      bytenr / BTRFS_BDEV_BLOCKSIZE,=0A=
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h=0A=
>> index a0161aa1ea0b..70e97cd6fa76 100644=0A=
>> --- a/fs/btrfs/disk-io.h=0A=
>> +++ b/fs/btrfs/disk-io.h=0A=
>> @@ -141,6 +141,7 @@ struct extent_map *btree_get_extent(struct btrfs_ino=
de *inode,=0A=
>>    		struct page *page, size_t pg_offset, u64 start, u64 len,=0A=
>>    		int create);=0A=
>>    int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);=0A=
>> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos);=
=0A=
>>    int __init btrfs_end_io_wq_init(void);=0A=
>>    void __cold btrfs_end_io_wq_exit(void);=0A=
>>    =0A=
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
>> index 3d41d840fe5c..ae2c895d08c4 100644=0A=
>> --- a/fs/btrfs/extent-tree.c=0A=
>> +++ b/fs/btrfs/extent-tree.c=0A=
>> @@ -267,6 +267,10 @@ static int exclude_super_stripes(struct btrfs_block=
_group_cache *cache)=0A=
>>    			return ret;=0A=
>>    	}=0A=
>>    =0A=
>> +	/* we won't have super stripes in sequential zones */=0A=
>> +	if (cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ)=0A=
>> +		return 0;=0A=
>> +=0A=
>>    	for (i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {=0A=
>>    		bytenr =3D btrfs_sb_offset(i);=0A=
>>    		ret =3D btrfs_rmap_block(fs_info, cache->key.objectid,=0A=
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c=0A=
>> index f7b29f9db5e2..36ad4fad7eaf 100644=0A=
>> --- a/fs/btrfs/scrub.c=0A=
>> +++ b/fs/btrfs/scrub.c=0A=
>> @@ -3720,6 +3720,8 @@ static noinline_for_stack int scrub_supers(struct =
scrub_ctx *sctx,=0A=
>>    		if (bytenr + BTRFS_SUPER_INFO_SIZE >=0A=
>>    		    scrub_dev->commit_total_bytes)=0A=
>>    			break;=0A=
>> +		if (!btrfs_check_super_location(scrub_dev, bytenr))=0A=
>> +			continue;=0A=
>>    =0A=
>>    		ret =3D scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,=0A=
>>    				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,=0A=
>>=0A=
> =0A=
> =0A=
=0A=
