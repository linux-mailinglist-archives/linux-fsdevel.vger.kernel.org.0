Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0F345721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 06:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWFTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 01:19:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58483 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCWFTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616476798; x=1648012798;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=h7bMyIhyifGMxKJ0tawaDJ9eankevt3wJDJlatqh3Yc=;
  b=g+RHxXRLq/PqWRYY6rofHVxjufATpZ1ykROtYV8S/kK29q0Yil2XWgsq
   vQYgLeuiUYWjgm/FpY4z5Hy5CANATMeUBkwQi27GvwK0IAkaEFy6Jh7da
   sIgtNJyiukoRxlKpiJdormBTQXN33JxbkLh830L9ujyJ6Md7svcRze4vJ
   pR6NzD4HDX+sG/HxU1bblkH0STnSHLb12fbwXqgtL6dFLT0j8USrAjfNB
   1D1OTsXZHxmIamwb5IifkrgL81UV2YIIWknJIYyKgkrEoh0ZfW9orwaw2
   XH6eMgwI5MLNWxmCVn+eqAJFV75FdtG62rt8kWV7pY3Rw1n7feccHtAZJ
   A==;
IronPort-SDR: h/lKbziexq0jJOKG+xwH/uIiLoJ4B8BPN5TXAyBFHD5vOjUBc21KPPs2Hcp0lKoEAROZJGMg76
 da/zKzN++RdBrncK+CbE3qjMEjMjAUUAX2hRZmRB0MCs6YMSrGrO1JXvBOtrpFyVhaUr5Qymgu
 oEdGgyyxIbDfBekmkeOUMiYzy3+QtdDCmRn4xtkq+HFMg2eidd21rmT8gQxJSqd2NbDgswKAfE
 glTK3ATFow1XKd7gtQltpzd8wzosQZZjw1+HyIICs48DzyYDPoVsnmB4ckEdzLI8d8NHkCSkCS
 oq4=
X-IronPort-AV: E=Sophos;i="5.81,270,1610380800"; 
   d="scan'208";a="267186668"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 13:19:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxZ0LnMFJ4mYp5b68BFPsn/946EbTTjYrPjZuA6TC1b4h10glAUvihHqqsz664E/Mc5Qxwnko3EKyYe4GjIIHqNW0k+Xe1rWlO9Uw/J0T/JYbrKpuLWvhL3J3+sTS6UPTZrFxI4anwA/6SLjNfwAWTym9X4nZWaKaRjunaaHRUq3mH+3eD7lBgi1f+xVRyw0QNWeAckRRq7vD66Oov7aeQFes7CTIzPKeCx/i6lzsXu8aZ3G39dZZCHW1wEE/vK8hkoaujUP6aDmvvccs+kd5NferK3N39PL/59Zi3dujAEQC8fMS5uKDNrigjA6zJKHFDuA8/VqW3pQtWC5MltEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwj04YWo5D6LWwBaRVflSfT5jZgplxnFLccXA6qZ+l8=;
 b=MefK/6ioORI9Trj3gFf7GcY5wvmtx8ITkzPNy43D17oV2MEfz9oicvh4E8TyIBAqY2cxjvn8yOZxhMLnzytuHHiI/hWH9t7PeGQMgoDZOL48n7PCrXnotTvecolsV9amcfqiO5gb1PBwJgGZomHcgw+p0RhXBkjYGIKfpgU7x98s39gy1ePp/NT0QGxutr4mCiE2IzBbOi3D4nSXrM9ltPilgbgBZAbo/L++8Oby6Le1eIK1OV8Sz2dPx/b9WU+9Yf+2itLeSmB4AjGl2oA5SiT7hA+JKEUuwA9+gpAsUQmInSDYpc5CwnsrVHRFn/KsG0HZ0HfKBz16LkSmyqDGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwj04YWo5D6LWwBaRVflSfT5jZgplxnFLccXA6qZ+l8=;
 b=YFUzGM/68H/uXwjnoXoSqlfweRV6PoT2NW5xn9d87pY+WHerIPILrNQ+GqtGfLb7S/Gc4qmZDS+XNCrNrbGNr+/uLlU+msGDGU8KSVqC7c/tjEzBTdmN05+ufa6arPiBKxCgbgi/7B6VEmA8dmxhrtZCWleaCB8tV114Zbp4WG8=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4914.namprd04.prod.outlook.com (2603:10b6:208:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 05:19:38 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 05:19:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
CC:     Hugh Dickins <hughd@google.com>, Theodore Tso <tytso@mit.edu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: introduce a wrapper uuid_to_fsid()
Thread-Topic: [PATCH 1/2] fs: introduce a wrapper uuid_to_fsid()
Thread-Index: AQHXH0JeK2tWlooHCkaxzONeqo3jnw==
Date:   Tue, 23 Mar 2021 05:19:38 +0000
Message-ID: <BL0PR04MB65147FD2B5204C7D1FD18146E7649@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210322173944.449469-1-amir73il@gmail.com>
 <20210322173944.449469-2-amir73il@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f01f:effc:52e2:7eda]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f22d2d8a-c56a-4ac0-8804-08d8edbb419b
x-ms-traffictypediagnostic: BL0PR04MB4914:
x-microsoft-antispam-prvs: <BL0PR04MB4914BB0690C6D46FE02D0A0CE7649@BL0PR04MB4914.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9nil+Ig/RaWJZatWHHEE9I1szPYquHyfb2MGoIC4IjkztOV/HmB+vOUMuicIh8p+mva7SaVxVKgKErdekFfrxvztxMchYQjQ89gTm+NoWhZzQnR7jHPxSgO5hEYZrqo3STK2bgbfxe0subanAfoTdhD08aGJ7xPhSKXVTOqjUXChuia9KQ0qAQsJXKaOfn5s+xpD+Uo0/Bfppb9huNqmlN4L+NTWl2s7f0Vft7c/pDqc/4Diwdc4sURIqKpWHz6UR/nbYyo6ZC//KtPOcTHIfjlG+A/Re9jzwhSD9N5jL7YuMYDcpCHEtcg+j3L7KlPVZxLe1L49aY2oZxSJYrkYcm0CwH/mS9THDrVeJH2TxRYM7tbfjhEqYUCDDza1kFkvteC5Tru/6QYVtGWIyj6ZQUS06Tcyjq0eYhqws4emTYiTmh9I+s10+B2UWGZkC58IOIOGuJ7F2iva3BzYSd71ZVr7x8K7EZ+y2l4TkJ2vApIAoY4zhqBppzOgGKXBX9gJCfHlKd1DRqQcVXcHfLqsgLelx9rErbejq093mpBuhqmZZ6ZQ+qfQ/KY9hpOK6MktJvYdLaiTdF7klO5Scn+u0Zl4lQ5TjM4H45SJIcrRO2cfo/a3Xt7t2/pqo1uaQ2DNrbRwzr8P/9LkRxMrhMN2bY6RZVpv99ApUmErqQrfoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(8936002)(110136005)(186003)(66946007)(83380400001)(54906003)(64756008)(66446008)(2906002)(33656002)(4326008)(86362001)(66476007)(76116006)(66556008)(8676002)(9686003)(52536014)(7696005)(53546011)(478600001)(55016002)(6506007)(91956017)(5660300002)(71200400001)(38100700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PE9BMTQ0VDVd3Nr2TZDbdn0z3ESc4mnEcRqthQSZfrag9NdPO3koleA1z7At?=
 =?us-ascii?Q?Tr0cdKP97UHNsUkFotx8ZE/emVyjh12DVkOBeO6Q6Rz/kqhXnfcVu5bhdtpU?=
 =?us-ascii?Q?0KUI4e6ZVA+FbYG2iHij7QitutNhns3rzH/6D7afRTSd+3zzVV25wZg9OFUr?=
 =?us-ascii?Q?CCS3vkAbCqKtbVgk26K+YQ+YTrsqiYGRJ/I6VLCJq32vRSIa8IaQSFSK67J7?=
 =?us-ascii?Q?BTA4+H1QNnJMv0/wzGtBT73dPnXwlbhNQzahNhe7wFGH4bUGg2Mb6OBrMiM1?=
 =?us-ascii?Q?tPyOvaIm8d38IRKenB3GVg9QwGxMhzROr0tOBczAzKjQR8G4N6h4HQt5Rwlf?=
 =?us-ascii?Q?BAjWx6LC+lpKFO4IV18MWMBMGZuXh+DcAboKR3b3a5676GMc2KJrf9YwnKc8?=
 =?us-ascii?Q?oCtYnUbF+Ibc28P8HfxnhrJe7oDJ9WywuhUbncgkdVp8QCUyGXKdMsMVjawS?=
 =?us-ascii?Q?tdYRmUzBZxkfpyFnxbjTtFswc0l2vcFHT+axq0bSHee054vX/eBZtrhdiI3W?=
 =?us-ascii?Q?sR+rW+3+vzqyeebuJTQIsrcOPMWhIZ0T7Qj2YyJdHZv4s5Eg4cgrp8h6UaAu?=
 =?us-ascii?Q?pLAJvchRGhW07K0W9HVfzzJfq9zVF5ZXi8Var6jcbVhMO1pZvuMPAGpWozhe?=
 =?us-ascii?Q?R56Pd6VJ3yGIC2LMeA9jzfuUkdkh7Dl1wHwI4toUT2v23sph8BTcB5w7W7u2?=
 =?us-ascii?Q?pw/YmVovHjAO4bCU33uABwaczMHPTu148v4o7t50N4NWx+IN7l3E+HSsOfSc?=
 =?us-ascii?Q?fa58ifDMl8KgWCmQVwpZMjgIHH5kg1eBca0MFaVnDAl9cJMfqWt59Y0INN57?=
 =?us-ascii?Q?LqlYbO5nX/H8+VJMR/MWqzkvR6GkmK2XLVmyI3yuNgJH1uJKg9Sa3vPH+H6m?=
 =?us-ascii?Q?LW/Bg2Wk1O0btdVCTobxGE1I/ZtjDw6k6ZEoy1i1icVE0QqMY4t9Dq74JOBn?=
 =?us-ascii?Q?HBdIUTD/OgIVqHayvcFTxInuJCa7NuGWuGqLskmElryCh5fD3f9iyTDKUZwC?=
 =?us-ascii?Q?Q6m82n6J91lverPRSV/dIQBxlwaOhBPWta0UqnqLQrxZHbWu/onUXi0UbvJA?=
 =?us-ascii?Q?agvpbYUXcec/RPfBc5QWhgNPO+KWxaalJOduzcebTTqb4ZGCtx7FqJIOe2jq?=
 =?us-ascii?Q?zK/66gH7vYVHdApEAn0ZOI8RVOKawiVUIFR2k8oc2fkXWzPzFt9mFRSWPb60?=
 =?us-ascii?Q?dusObLIzoGYGMBMDXS4BNZ6s+1lHeNNQklYyhZuaRIYfnscW7xqASPjPk30z?=
 =?us-ascii?Q?6SL2BUVBec2SulLXDug69OvJCgfRPlRfQCRz8rmSbSEg0L938ImdZddN9aMu?=
 =?us-ascii?Q?YKrFJEedArpW1wZ6cErIJUQeb8z3BWoMkbDST+hNR5ob9BMBr41FQQe68g/I?=
 =?us-ascii?Q?JFWl5s1hDrxgHSyNAOt20oYHEb0TNwT9xVr+Wrn6CJPjpsWuhQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22d2d8a-c56a-4ac0-8804-08d8edbb419b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:19:38.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XKKJwI7LDd3nQsN7xSekUpV3udh4wo9K5sRS+OROBn4jDnU1S6YuvV7kdHBGq8flauTYxL3r5YIV4joiD58Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4914
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/23 2:39, Amir Goldstein wrote:=0A=
> Some filesystem's use a digest of their uuid for f_fsid.=0A=
> Create a simple wrapper for this open coded folding.=0A=
> =0A=
> Filesystems that have a non null uuid but use the block device=0A=
> number for f_fsid may also consider using this helper.=0A=
> =0A=
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>=0A=
> ---=0A=
>  fs/ext2/super.c        | 5 +----=0A=
>  fs/ext4/super.c        | 5 +----=0A=
>  fs/zonefs/super.c      | 5 +----=0A=
>  include/linux/statfs.h | 7 +++++++=0A=
>  4 files changed, 10 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c=0A=
> index 6c4753277916..0d679451657c 100644=0A=
> --- a/fs/ext2/super.c=0A=
> +++ b/fs/ext2/super.c=0A=
> @@ -1399,7 +1399,6 @@ static int ext2_statfs (struct dentry * dentry, str=
uct kstatfs * buf)=0A=
>  	struct super_block *sb =3D dentry->d_sb;=0A=
>  	struct ext2_sb_info *sbi =3D EXT2_SB(sb);=0A=
>  	struct ext2_super_block *es =3D sbi->s_es;=0A=
> -	u64 fsid;=0A=
>  =0A=
>  	spin_lock(&sbi->s_lock);=0A=
>  =0A=
> @@ -1453,9 +1452,7 @@ static int ext2_statfs (struct dentry * dentry, str=
uct kstatfs * buf)=0A=
>  	buf->f_ffree =3D ext2_count_free_inodes(sb);=0A=
>  	es->s_free_inodes_count =3D cpu_to_le32(buf->f_ffree);=0A=
>  	buf->f_namelen =3D EXT2_NAME_LEN;=0A=
> -	fsid =3D le64_to_cpup((void *)es->s_uuid) ^=0A=
> -	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));=0A=
> -	buf->f_fsid =3D u64_to_fsid(fsid);=0A=
> +	buf->f_fsid =3D uuid_to_fsid(es->s_uuid);=0A=
>  	spin_unlock(&sbi->s_lock);=0A=
>  	return 0;=0A=
>  }=0A=
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c=0A=
> index ad34a37278cd..3581c1cdc19e 100644=0A=
> --- a/fs/ext4/super.c=0A=
> +++ b/fs/ext4/super.c=0A=
> @@ -6148,7 +6148,6 @@ static int ext4_statfs(struct dentry *dentry, struc=
t kstatfs *buf)=0A=
>  	struct ext4_sb_info *sbi =3D EXT4_SB(sb);=0A=
>  	struct ext4_super_block *es =3D sbi->s_es;=0A=
>  	ext4_fsblk_t overhead =3D 0, resv_blocks;=0A=
> -	u64 fsid;=0A=
>  	s64 bfree;=0A=
>  	resv_blocks =3D EXT4_C2B(sbi, atomic64_read(&sbi->s_resv_clusters));=0A=
>  =0A=
> @@ -6169,9 +6168,7 @@ static int ext4_statfs(struct dentry *dentry, struc=
t kstatfs *buf)=0A=
>  	buf->f_files =3D le32_to_cpu(es->s_inodes_count);=0A=
>  	buf->f_ffree =3D percpu_counter_sum_positive(&sbi->s_freeinodes_counter=
);=0A=
>  	buf->f_namelen =3D EXT4_NAME_LEN;=0A=
> -	fsid =3D le64_to_cpup((void *)es->s_uuid) ^=0A=
> -	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));=0A=
> -	buf->f_fsid =3D u64_to_fsid(fsid);=0A=
> +	buf->f_fsid =3D uuid_to_fsid(es->s_uuid);=0A=
>  =0A=
>  #ifdef CONFIG_QUOTA=0A=
>  	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 0fe76f376dee..e09810311162 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -1104,7 +1104,6 @@ static int zonefs_statfs(struct dentry *dentry, str=
uct kstatfs *buf)=0A=
>  	struct super_block *sb =3D dentry->d_sb;=0A=
>  	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>  	enum zonefs_ztype t;=0A=
> -	u64 fsid;=0A=
>  =0A=
>  	buf->f_type =3D ZONEFS_MAGIC;=0A=
>  	buf->f_bsize =3D sb->s_blocksize;=0A=
> @@ -1127,9 +1126,7 @@ static int zonefs_statfs(struct dentry *dentry, str=
uct kstatfs *buf)=0A=
>  =0A=
>  	spin_unlock(&sbi->s_lock);=0A=
>  =0A=
> -	fsid =3D le64_to_cpup((void *)sbi->s_uuid.b) ^=0A=
> -		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));=0A=
> -	buf->f_fsid =3D u64_to_fsid(fsid);=0A=
> +	buf->f_fsid =3D uuid_to_fsid(sbi->s_uuid.b);=0A=
>  =0A=
>  	return 0;=0A=
>  }=0A=
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h=0A=
> index 20f695b90aab..ed86ac090a1b 100644=0A=
> --- a/include/linux/statfs.h=0A=
> +++ b/include/linux/statfs.h=0A=
> @@ -50,4 +50,11 @@ static inline __kernel_fsid_t u64_to_fsid(u64 v)=0A=
>  	return (__kernel_fsid_t){.val =3D {(u32)v, (u32)(v>>32)}};=0A=
>  }=0A=
>  =0A=
> +/* Fold 16 bytes uuid to 64 bit fsid */=0A=
> +static inline __kernel_fsid_t uuid_to_fsid(__u8 *uuid)=0A=
> +{=0A=
> +	return u64_to_fsid(le64_to_cpup((void *)uuid) ^=0A=
> +		le64_to_cpup((void *)(uuid + sizeof(u64))));=0A=
> +}=0A=
> +=0A=
>  #endif=0A=
> =0A=
=0A=
For the zonefs bits, looks good to me.=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
