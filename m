Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E666692C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfGLIbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 04:31:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27610 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562920308; x=1594456308;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yw/tRwJFuDxlVjp57M8PDaSBKDNOalPDZ2HMIB7Rpz0=;
  b=BvxtzBTafgCmtL9vtqoXpzZC/rc4VzsotFl1XriiNe+0gkM+y2+Y9l5u
   6g/TWpKrIv9Kmdgi89m27oEMgHDFLIOXhfvCDNHPRuP/K51dWDjSs3n4M
   xw3nqJlX4HZ2THHLRDcDGRIDVf12TwaaTbsdGYrUtnurrPJzGSufwpcdx
   q+AR4230c3CPS4Rcgsry/kQ5AV4HFNBTuDbrUXl50TTYI3sMHGF6NDMGN
   5lMfspVlHKLlW9QCe65Z3SVOlsIqmX67qQ1yIWCmPAIkSIM3eU6QmGtXX
   Rf008jznq4WQka7IYAhHXqxOjy4z64qV2xpddVLYgFb9jH+KlbN5h40K9
   g==;
IronPort-SDR: 1ZUrJETeVge23ySRRwHe6SiBk0saFi0TazmOLLlB/78il9ikKNmoc3TEQVXJkXafV8LMeoOE+K
 1ktWNHvgiOn/Hjo6hlQpzCINKfS/t1izqN+dZ8emrrbGdB0sSJd/XvV3ycAB212hXc/DABfyQ5
 61cuezeIesgmHladotce3IzCgFwwttwNBJD1Q5t4Q4gA+Ia8mqsDqtjhsORveGLvE4MFYSl7Kv
 WQB/N+4A4u3WUaP0+X5iikrcm6Z8ldxx8OlyYsN4bWAT/cLJoV6BVqb01gk0Zw+38oYCA0DEFu
 1Hs=
X-IronPort-AV: E=Sophos;i="5.63,481,1557158400"; 
   d="scan'208";a="112870999"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 16:31:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd9s6OEeCq5BGL7/0yo44poN+wf5neg2VwhjNWQbXRo=;
 b=DPFhuB2AfheZEE+1Oza8NqylX8sGdVMIB0T1aHNYlsvjckUerYUbsw1ZGwOHO0VL5m7MAa2cJ+uDNEDtfBn6k1b7fGZmQZ6SzgFS0X4Co2CjTr+Kzg3/byqF+8MuwDU2tx718xQtCHqrNsENHhydHGiSW7DEHuv3qVXOtP2HTqk=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5617.namprd04.prod.outlook.com (20.179.72.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 12 Jul 2019 08:31:32 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16%4]) with mapi id 15.20.2052.019; Fri, 12 Jul 2019
 08:31:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Fri, 12 Jul 2019 08:31:32 +0000
Message-ID: <BN8PR04MB581241A65E81F79882508F4BE7F20@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <20190712080022.GA16276@x250.microfocus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6519d56d-8871-4ffb-6fed-08d706a35839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5617;
x-ms-traffictypediagnostic: BN8PR04MB5617:
x-microsoft-antispam-prvs: <BN8PR04MB5617127D34FE9B9CB4AB5D5DE7F20@BN8PR04MB5617.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(51914003)(76176011)(6506007)(55016002)(14454004)(26005)(64756008)(25786009)(66066001)(33656002)(9686003)(53546011)(476003)(5660300002)(2906002)(66946007)(68736007)(229853002)(4326008)(186003)(53936002)(486006)(3846002)(6116002)(7736002)(74316002)(446003)(8936002)(86362001)(66556008)(6916009)(6436002)(66446008)(81156014)(305945005)(66476007)(8676002)(52536014)(71190400001)(91956017)(256004)(76116006)(71200400001)(99286004)(6246003)(7696005)(14444005)(102836004)(81166006)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5617;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wr65UVziSSdfwnp6uvZRh2t8RChm9vGSncJkvLtnygWLv+mdlWH0XOkTKIua68xWi3by2HKxODYun45RpHBZqQCu+nkJFx5dUdXYGrP0453+z9CCf4pDh8UBvpbWpO2pNY6rkgJ2E1Pomwok87areKdKmVY3RZ5Z+aFfogn/Br/ohZ+PSpQWW4YP1eY/szx9XBTOuucWbRstzZPl/Rohzza+c5V2M3JuTaJzaML55mt2Mri5VK4XcqE0M5LAKaWL92OxcV7MyHS7RcbPLdbUWsZPoH9lxdlXMS+UAPcKGO6B7HAaHmEenkgoo9u2bwBXLa6PmTd6Jkwwao5lIZhbBc2H1ldZIMgcCQLs9+tqLPdjAKAgKE4ZNjWtgU7RuS5bKNJH0rLB4MC/zKIxdY9JEnS1fdXqWqSl47T03mIgyUc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6519d56d-8871-4ffb-6fed-08d706a35839
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 08:31:32.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5617
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/12 17:00, Johannes Thumshirn wrote:=0A=
> On Fri, Jul 12, 2019 at 12:00:17PM +0900, Damien Le Moal wrote:=0A=
> =0A=
> Hi Daminen,=0A=
> =0A=
> Thanks for submitting zonefs.=0A=
> =0A=
> Please find my first few comments, I'll have a second look later as well.=
=0A=
> =0A=
> [...]=0A=
> =0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  fs/Kconfig                 |    2 +=0A=
>>  fs/Makefile                |    1 +=0A=
>>  fs/zonefs/Kconfig          |    9 +=0A=
>>  fs/zonefs/Makefile         |    4 +=0A=
>>  fs/zonefs/super.c          | 1004 ++++++++++++++++++++++++++++++++++++=
=0A=
>>  fs/zonefs/zonefs.h         |  190 +++++++=0A=
>>  include/uapi/linux/magic.h |    1 +=0A=
>>  7 files changed, 1211 insertions(+)=0A=
>>  create mode 100644 fs/zonefs/Kconfig=0A=
>>  create mode 100644 fs/zonefs/Makefile=0A=
>>  create mode 100644 fs/zonefs/super.c=0A=
>>  create mode 100644 fs/zonefs/zonefs.h=0A=
> =0A=
> It'll probably be good to add yourself as a maitainer in MAINTAINERS, so=
=0A=
> people see there's a go-to person for patches. Also a list (fsdevel@) and=
 a=0A=
> git tree won't harm.=0A=
=0A=
Oops. Yes, indeed. I forgot to add that. I will.=0A=
=0A=
> =0A=
>>=0A=
>> diff --git a/fs/Kconfig b/fs/Kconfig=0A=
>> index f1046cf6ad85..e48cc0e0efbb 100644=0A=
>> --- a/fs/Kconfig=0A=
>> +++ b/fs/Kconfig=0A=
>> @@ -41,6 +41,7 @@ source "fs/ocfs2/Kconfig"=0A=
>>  source "fs/btrfs/Kconfig"=0A=
>>  source "fs/nilfs2/Kconfig"=0A=
>>  source "fs/f2fs/Kconfig"=0A=
>> +source "fs/zonefs/Kconfig"=0A=
>>  =0A=
>>  config FS_DAX=0A=
>>  	bool "Direct Access (DAX) support"=0A=
>> @@ -262,6 +263,7 @@ source "fs/romfs/Kconfig"=0A=
>>  source "fs/pstore/Kconfig"=0A=
>>  source "fs/sysv/Kconfig"=0A=
>>  source "fs/ufs/Kconfig"=0A=
>> +source "fs/ufs/Kconfig"=0A=
>>  =0A=
> =0A=
> This hunk looks wrong.=0A=
=0A=
Yes it is wrong. No idea how that sneaked in here. Will fix it.=0A=
=0A=
> =0A=
>>  endif # MISC_FILESYSTEMS=0A=
>>  =0A=
> =0A=
> [...]=0A=
> =0A=
>> +	/*=0A=
>> +	 * Note: The first zone contains the super block: skip it.=0A=
>> +	 */=0A=
> =0A=
> I know I've been advocating for having on-disk metadata, but do we really=
=0A=
> sacrifice a whole zone per default? I thought we'll have on-disk metadata=
=0A=
> optional (I might be completely off the track here and need more coffee t=
o=0A=
> wake up though).=0A=
=0A=
Yes, indeed we do not really need the super block for now. But it is still =
super=0A=
useful to have so that:=0A=
1) libblkid and other such userland tools can probe the disk to see its for=
mat,=0A=
and preserve the usual "use -force option if you really want to overwrite"=
=0A=
behavior of all format tools.=0A=
2) Still related to previous point, the super block allows commands like:=
=0A=
mount /dev/sdX /mnt=0A=
and=0A=
mount -t zonefs /dev/sdX /mnt=0A=
to have the same result. That is, without the super block, if the drive was=
=0A=
previously formatted for btrfs or f2fs, the first command will mount that o=
ld=0A=
format, while the second will mount zonefs without necessarily erasing the =
old=0A=
FS super block.=0A=
3) Having the super block with a version number will allow in the future to=
 add=0A=
more metadata (e.g. file names as decided by the application) while allowin=
g=0A=
backward compatibility of the code.=0A=
=0A=
>> +	end =3D zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];=0A=
>> +	for (zone =3D &zones[1]; zone < end; zone =3D next) {=0A=
> =0A=
> [...]=0A=
> =0A=
>> +=0A=
>> +	/* Set defaults */=0A=
>> +	sbi->s_uid =3D GLOBAL_ROOT_UID;=0A=
>> +	sbi->s_gid =3D GLOBAL_ROOT_GID;=0A=
>> +	sbi->s_perm =3D S_IRUSR | S_IWUSR | S_IRGRP; /* 0640 */=0A=
>> +=0A=
>> +=0A=
>> +	ret =3D zonefs_read_super(sb);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
> =0A=
> That would be cool to be controllable via a mount option and have it:=0A=
> 	sbi->s_uid =3D opt.uid;=0A=
> 	sbi->s_gid =3D opt.gid;=0A=
> 	sbi->s_perm =3D opt.mode;=0A=
> =0A=
> or pass these mount options to zonefs_read_super() and they can be set af=
ter=0A=
> the feature validation.=0A=
=0A=
Yes, I thought of that and even had that implemented in a previous version.=
 I=0A=
switched to the static format time definition only so that the resulting=0A=
operation of the FS is a little more like a normal file system, namely, mou=
nting=0A=
the device does not change file attributes and so can be mounted and seen w=
ith=0A=
the same attribute no matter where it is mounted, regardless of the mount o=
ptions.=0A=
=0A=
> [...]=0A=
=0A=
Thanks for the nits and typos pointer. I will fix that.=0A=
=0A=
>> +struct zonefs_super {=0A=
>> +=0A=
>> +	/* Magic number */=0A=
>> +	__le32		s_magic;		/*    4 */=0A=
>> +=0A=
>> +	/* Metadata version number */=0A=
>> +	__le32		s_version;		/*    8 */=0A=
>> +=0A=
>> +	/* Features */=0A=
>> +	__le64		s_features;		/*   16 */=0A=
>> +=0A=
>> +	/* 128-bit uuid */=0A=
>> +	__u8		s_uuid[16];		/*   32 */=0A=
>> +=0A=
>> +	/* UID/GID to use for files */=0A=
>> +	__le32		s_uid;			/*   36 */=0A=
>> +	__le32		s_gid;			/*   40 */=0A=
>> +=0A=
>> +	/* File permissions */=0A=
>> +	__le32		s_perm;			/*   44 */=0A=
>> +=0A=
>> +	/* Padding to 4K */=0A=
>> +	__u8		s_reserved[4052];	/* 4096 */=0A=
>> +=0A=
>> +} __attribute__ ((packed));=0A=
> =0A=
> I'm not sure the (end)offset comments are of any value here, it's nothing=
 that=0A=
> can't be obtained from pahole or gdb (or even by hand).=0A=
=0A=
OK. Will remove.=0A=
=0A=
>> +/*=0A=
>> + * Metadata version.=0A=
>> + */=0A=
>> +#define ZONEFS_VERSION	1=0A=
>> +=0A=
>> +/*=0A=
>> + * Feature flags.=0A=
>> + */=0A=
>> +enum zonefs_features {=0A=
>> +	/*=0A=
>> +	 * Use a zone start sector value as file name.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_STARTSECT_NAME,=0A=
>> +	/*=0A=
>> +	 * Aggregate contiguous conventional zones into a single file.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_AGRCNV,=0A=
>> +	/*=0A=
>> +	 * Use super block specified UID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_UID,=0A=
>> +	/*=0A=
>> +	 * Use super block specified GID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_GID,=0A=
>> +	/*=0A=
>> +	 * Use super block specified file permissions instead of default 640.=
=0A=
>> +	 */=0A=
>> +	ZONEFS_F_PERM,=0A=
>> +};=0A=
> =0A=
> I'd rather not write the uid, gid, permissions and startsect name to the=
=0A=
> superblock but have it controllable via a mount option. Just write the fe=
ature=0A=
> to the superblock so we know we _can_ control this per mount.=0A=
=0A=
This is another view. See my thinking above. Thoughts ?=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
