Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADB2F257D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbhALBXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:23:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17675 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbhALBXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610414615; x=1641950615;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rPznXNMied2kJzlD1dnXL+6/qgNOBTRcdMM/CLhLd00=;
  b=W++bV/8eBmmA7EGxb0D5fargIt3FAILJsWYz+oDdOlY+QXYpe3u91FzE
   0Qx5IFk7NvIau2ZcbIpndNePPs2JAuq3vlgA7xkyVNENl5WrUW5Pwsgdg
   UjG4LM/jI9pHikk/nbRrkqgmToYOldOsejO8SlrX3ijfK1VMFToA1eEU9
   /8qavkc48Bf7YvyXoJdM7uBOMRzY9lj7jnUsd+IZMcbTcBho8kSTwelbQ
   L85CXg6XhCFU+SSUUIIJRClvXIcfjcNaVkF+U+LS7j1M7TxQNWWCFUpu7
   vbchTjRuboWkyzBVYx6GNd3XtXAASMgt7043laSmd5cdhJLQit7/Uqc6H
   Q==;
IronPort-SDR: f26kDHBvZetAFGbzPgzXM7JDQYBMu/s8+Ctlw8+6KwaAXttVw24eRMF3hltV4VP7qIVkFpSbB5
 h8tcI42J9VmzQY/gwVEKEO+VGAPOQTU9s+m3nba43TrOlh0HsUvenChvdWzOuBblcXSpJHUIe0
 CBT7oiw/MNlwfu9/pk6OATDFOe8v6c/DdlREHKkU5thG6tZqwCrf7Khc+IaBMMUnKw3e62vEub
 avHiXaPVNYmgxCdDj2VQARJG/s77yYVGhYfo7CQENaK7pyi5ErJAgOPurOVbMG/JW9w9bcn+Iq
 GAw=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="161636302"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 09:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR39ndt5rEvge4q2Dl5GJNV6dq8rxRQt/dORRIS/FtWIILA4GbmYk/ln1GkVt8GHA2g1PJSr1UQXNsJLyv3Bf3KQvAvPFgpozfsh7v8vUQnYIzPY98kWVJLSpG3wJo82ZUSuOQsK7rnkR+Uk+I/L8RQt6+6CP2msWXfVPEL+3By1ORLUy2Tg6UPttt0L/H7kkSqTtecfA+hm7w5+lc/ucstccyNzRrKhSKgwcI91XVJagLL2eh0qu4c+mtEZ0TKJzqYhFjFVYAL9+kJI4sUEg7aGUXZNzefKQbUz5Iij5/p4ZP2zhZaS10QJHie+DUenUX1jpwIw7xAexCdrhTFwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxlIPyb/VLbIHAkO74XlD0mRD4pTdiLNzekpiT+RkCo=;
 b=Y6n6Qe4RUQqcz2ZdvtCSlZ0fICfspR1DGrmyvdIGytvSLVY3Fn3g34dJxrNnbe6E/SmzeJ13Lpfg38XX0jbn4+KIFjCmaBE2UU3gFy+FRaAEPvf2hkAxcx7FMMDciP0I/cWupAIsiYwu4b3UFhrQqiK1cJV38LfI9IHzd8jDAdlVkZnxc/gmKCTpzy3seDRymPxEj3vROBeCugDaMuPpl+4P5XoT1UuWOue+AaRAX+Qv2WrXOOXqjdrFIp7SUoOuMWGp5d+RzuJ4GtSnkz8XIvJu+hp5plL6qAkLJW6P3SNGOpkBp7lsOliWQzowV93F5NRGHcXfQs54GoIn5bDefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxlIPyb/VLbIHAkO74XlD0mRD4pTdiLNzekpiT+RkCo=;
 b=FE08GplFKV7PCTeOZ8VgNj6PMT5nLRGinPivjO05l6k1PwsdtvGgk0/tpyTlhmg7CEfNDZC1c6S5h3Joq4CAAwLUZNU9rD6sJf5dqoDFgGC6THMfiGtTk5UrvvaKvjZqi/fNH1vB3d0HGtS0nGMC7fwyikr+6qMWAnTv/J/FxCc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 01:22:27 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 01:22:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "avi@scylladb.com" <avi@scylladb.com>,
        "andres@anarazel.de" <andres@anarazel.de>
Subject: Re: [PATCH 1/6] iomap: convert iomap_dio_rw() to an args structure
Thread-Topic: [PATCH 1/6] iomap: convert iomap_dio_rw() to an args structure
Thread-Index: AQHW6H9/lN8k1SXk5Ee7E9TAunwvZg==
Date:   Tue, 12 Jan 2021 01:22:27 +0000
Message-ID: <BL0PR04MB65142B5DF6D545A460633536E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-2-david@fromorbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f811e4b2-f329-430b-646a-08d8b6988653
x-ms-traffictypediagnostic: MN2PR04MB6479:
x-microsoft-antispam-prvs: <MN2PR04MB6479C1EB628BA7CB08F3BEF1E7AA0@MN2PR04MB6479.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONlFI5JXtfFiLAZIV1/YL65Evu+u5SO7bfdut/n4zBM/hnyOMwl+GH+jEw7IVEsHTycopzy1zeT7DAd4lyTMbnrpda/+mf3z3Hj/+uDFVIZxxAIEX+tMW8Y1szmrh9R/EMvakltlUfZltmKFakVcYaT3xtoifFCe6OoiaMKO5G8gq3O6ROie7srEplBsTBbeHuqpkw22GnVSLLQOpoomQPjEm7o8LGX+kVKYg47eu6gVEq2FQ4J4thEZUhb6OvNrQ9X4W7idhNumy/K7IHqJI4p/bVqQd+P7aGxbWX4WiRv8JbAi+Kt2dPT0lJD/m4OkIIU8+n++sQ32JPY1iVqDsh1SO6PSUlv69qGFGS0bMti7FdPY6ICWnrRdwiN8T0pi9xgnjJ8YcBYjHh6BwYYfMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(33656002)(478600001)(76116006)(64756008)(83380400001)(66446008)(91956017)(66556008)(186003)(4326008)(66476007)(66946007)(30864003)(7696005)(316002)(71200400001)(9686003)(86362001)(52536014)(55016002)(6506007)(53546011)(54906003)(5660300002)(110136005)(2906002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yC9SHisB8Ytt4ickwwtaAly6nht41lMMO9WW7Z4OSQ4J7WYIOPhDxeh1Ylxm?=
 =?us-ascii?Q?bzefk6+JMRQbdFG57ASPuXIqdOTURP7dJDtikbr3/BJGctgAd0wq0TL7Fl7b?=
 =?us-ascii?Q?+ebQAO7dpvSqy//lauu1pMyDP/SIuCDLxhM6/cSKJXgOzNrHPDndBXYepNUs?=
 =?us-ascii?Q?yhkGR/x4qirPtn3V572fL4BAYtgx/DCRpAbJNleGgLAjRE/OUfyP2EJtrX7I?=
 =?us-ascii?Q?2jU27ePMzh2+dmlwQyKpr+GGoPloqAexnHQlvBtCH4IEDpDWnOtS3Nd4xq8M?=
 =?us-ascii?Q?o1lnszD+ttPDeloH/TEnIRC3er87MWy1lpldCKm8LrI8PjQIrHhPVYbyYQ+V?=
 =?us-ascii?Q?LNaFmS4WhKQ/JIkswVcKu8zpVCUXvjjXyHdb8TAZA0Jk1X6kLkHeIvxvYl5d?=
 =?us-ascii?Q?IuSyYGvPS0hL+UvniQ6sXCq4dBfsZXRrDLkm/kq3vfAjdpEfa4BJr1rIQmU/?=
 =?us-ascii?Q?GzRN4CKi1AWvaT8iuubbIavn1nrIJUZzAP/yQOk1PL3OdklNcVaWT8ZSlmvf?=
 =?us-ascii?Q?4yfg8Z+8PD+smoBFOQ4cMpS3tzBImHsx4DwS1B35DZNPj6UOf16rdhy4Sqco?=
 =?us-ascii?Q?sK169a6jo3bGn8Yjadluylz3UtzDc987XU/BoVwYtIrJb9xmvaJ0qCevTFAI?=
 =?us-ascii?Q?yi/FlP+nmSdVR1bT5U3fcyJwFJNf1/Q1Kim1AifeGbUR1sDRoSCeTl2cUOoD?=
 =?us-ascii?Q?8B23bkqIcU31DQVNmSbWxlRPi5xdd9yrDpm1Gx+pQdrqa42Q6SXUhoa7JFRB?=
 =?us-ascii?Q?AEHXpfwlB4humAZjk0fLLA/Z+cqHFavL+bSLwL9p0Wy2aW9iigvWacWpqw0n?=
 =?us-ascii?Q?BDiu1M/1q4VqwAfdf4Y0iGtZYR2iV3Jbuu8qUmowaEj+G3N64T02Zjc6+9T3?=
 =?us-ascii?Q?5bA3FQv3iG0lFgvcme9RMAkkTXtpdTHEEK4shmSxgkh6WCgvlmAxOj13In+x?=
 =?us-ascii?Q?9VkLGplwURpZZvin5eiBVO0ji3r/Zv6YpZ625vbnsp5kYZAIdX2t9o4jlu2f?=
 =?us-ascii?Q?wVvn1nTwnYHRXFCjHyk5HSBc1iT8cStAVVTL+2tEegC/YpLhXwXZZ9BChg1Q?=
 =?us-ascii?Q?lh3TMsxA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f811e4b2-f329-430b-646a-08d8b6988653
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 01:22:27.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjvuTTL+8kEaQ8/GiiZW0ijAnUb1hvw86uJQwiBdXzt79273SXJ40gJweYdFWjVmowIhyi+zJM8UP2T/ZyuXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/12 10:08, Dave Chinner wrote:=0A=
> From: Dave Chinner <dchinner@redhat.com>=0A=
> =0A=
> Adding yet another parameter to the iomap_dio_rw() interface means=0A=
> changing lots of filesystems to add the parameter. Convert this=0A=
> interface to an args structure so in future we don't need to modify=0A=
> every caller to add a new parameter.=0A=
> =0A=
> Signed-off-by: Dave Chinner <dchinner@redhat.com>=0A=
> ---=0A=
>  fs/btrfs/file.c       | 21 ++++++++++++++++-----=0A=
>  fs/ext4/file.c        | 24 ++++++++++++++++++------=0A=
>  fs/gfs2/file.c        | 19 ++++++++++++++-----=0A=
>  fs/iomap/direct-io.c  | 30 ++++++++++++++----------------=0A=
>  fs/xfs/xfs_file.c     | 30 +++++++++++++++++++++---------=0A=
>  fs/zonefs/super.c     | 21 +++++++++++++++++----=0A=
>  include/linux/iomap.h | 16 ++++++++++------=0A=
>  7 files changed, 110 insertions(+), 51 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c=0A=
> index 0e41459b8de6..a49d9fa918d1 100644=0A=
> --- a/fs/btrfs/file.c=0A=
> +++ b/fs/btrfs/file.c=0A=
> @@ -1907,6 +1907,13 @@ static ssize_t btrfs_direct_write(struct kiocb *io=
cb, struct iov_iter *from)=0A=
>  	ssize_t err;=0A=
>  	unsigned int ilock_flags =3D 0;=0A=
>  	struct iomap_dio *dio =3D NULL;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D from,=0A=
> +		.ops			=3D &btrfs_dio_iomap_ops,=0A=
> +		.dops			=3D &btrfs_dio_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_NOWAIT)=0A=
>  		ilock_flags |=3D BTRFS_ILOCK_TRY;=0A=
> @@ -1949,9 +1956,7 @@ static ssize_t btrfs_direct_write(struct kiocb *ioc=
b, struct iov_iter *from)=0A=
>  		goto buffered;=0A=
>  	}=0A=
>  =0A=
> -	dio =3D __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,=0A=
> -			     &btrfs_dio_ops, is_sync_kiocb(iocb));=0A=
> -=0A=
> +	dio =3D __iomap_dio_rw(&args);=0A=
>  	btrfs_inode_unlock(inode, ilock_flags);=0A=
>  =0A=
>  	if (IS_ERR_OR_NULL(dio)) {=0A=
> @@ -3617,13 +3622,19 @@ static ssize_t btrfs_direct_read(struct kiocb *io=
cb, struct iov_iter *to)=0A=
>  {=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>  	ssize_t ret;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D to,=0A=
> +		.ops			=3D &btrfs_dio_iomap_ops,=0A=
> +		.dops			=3D &btrfs_dio_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))=0A=
>  		return 0;=0A=
>  =0A=
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);=0A=
> -	ret =3D iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,=0A=
> -			   is_sync_kiocb(iocb));=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);=0A=
>  	return ret;=0A=
>  }=0A=
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c=0A=
> index 3ed8c048fb12..436508be6d88 100644=0A=
> --- a/fs/ext4/file.c=0A=
> +++ b/fs/ext4/file.c=0A=
> @@ -53,6 +53,12 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, =
struct iov_iter *to)=0A=
>  {=0A=
>  	ssize_t ret;=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D to,=0A=
> +		.ops			=3D &ext4_iomap_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>  		if (!inode_trylock_shared(inode))=0A=
> @@ -74,8 +80,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, s=
truct iov_iter *to)=0A=
>  		return generic_file_read_iter(iocb, to);=0A=
>  	}=0A=
>  =0A=
> -	ret =3D iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,=0A=
> -			   is_sync_kiocb(iocb));=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	inode_unlock_shared(inode);=0A=
>  =0A=
>  	file_accessed(iocb->ki_filp);=0A=
> @@ -459,9 +464,15 @@ static ssize_t ext4_dio_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>  	loff_t offset =3D iocb->ki_pos;=0A=
>  	size_t count =3D iov_iter_count(from);=0A=
> -	const struct iomap_ops *iomap_ops =3D &ext4_iomap_ops;=0A=
>  	bool extend =3D false, unaligned_io =3D false;=0A=
>  	bool ilock_shared =3D true;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D from,=0A=
> +		.ops			=3D &ext4_iomap_ops,=0A=
> +		.dops			=3D &ext4_dio_write_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	/*=0A=
>  	 * We initially start with shared inode lock unless it is=0A=
> @@ -548,9 +559,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)=0A=
>  	}=0A=
>  =0A=
>  	if (ilock_shared)=0A=
> -		iomap_ops =3D &ext4_iomap_overwrite_ops;=0A=
> -	ret =3D iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,=0A=
> -			   is_sync_kiocb(iocb) || unaligned_io || extend);=0A=
> +		args.ops =3D &ext4_iomap_overwrite_ops;=0A=
> +	if (unaligned_io || extend)=0A=
> +		args.wait_for_completion =3D true;=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	if (ret =3D=3D -ENOTBLK)=0A=
>  		ret =3D 0;=0A=
>  =0A=
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c=0A=
> index b39b339feddc..d44a5f9c5f34 100644=0A=
> --- a/fs/gfs2/file.c=0A=
> +++ b/fs/gfs2/file.c=0A=
> @@ -788,6 +788,12 @@ static ssize_t gfs2_file_direct_read(struct kiocb *i=
ocb, struct iov_iter *to,=0A=
>  	struct gfs2_inode *ip =3D GFS2_I(file->f_mapping->host);=0A=
>  	size_t count =3D iov_iter_count(to);=0A=
>  	ssize_t ret;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D to,=0A=
> +		.ops			=3D &gfs2_iomap_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	if (!count)=0A=
>  		return 0; /* skip atime */=0A=
> @@ -797,9 +803,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *io=
cb, struct iov_iter *to,=0A=
>  	if (ret)=0A=
>  		goto out_uninit;=0A=
>  =0A=
> -	ret =3D iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,=0A=
> -			   is_sync_kiocb(iocb));=0A=
> -=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	gfs2_glock_dq(gh);=0A=
>  out_uninit:=0A=
>  	gfs2_holder_uninit(gh);=0A=
> @@ -815,6 +819,12 @@ static ssize_t gfs2_file_direct_write(struct kiocb *=
iocb, struct iov_iter *from,=0A=
>  	size_t len =3D iov_iter_count(from);=0A=
>  	loff_t offset =3D iocb->ki_pos;=0A=
>  	ssize_t ret;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D from,=0A=
> +		.ops			=3D &gfs2_iomap_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	/*=0A=
>  	 * Deferred lock, even if its a write, since we do no allocation on=0A=
> @@ -833,8 +843,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *i=
ocb, struct iov_iter *from,=0A=
>  	if (offset + len > i_size_read(&ip->i_inode))=0A=
>  		goto out;=0A=
>  =0A=
> -	ret =3D iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,=0A=
> -			   is_sync_kiocb(iocb));=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	if (ret =3D=3D -ENOTBLK)=0A=
>  		ret =3D 0;=0A=
>  out:=0A=
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
> index 933f234d5bec..05cacc27578c 100644=0A=
> --- a/fs/iomap/direct-io.c=0A=
> +++ b/fs/iomap/direct-io.c=0A=
> @@ -418,13 +418,13 @@ iomap_dio_actor(struct inode *inode, loff_t pos, lo=
ff_t length,=0A=
>   * writes.  The callers needs to fall back to buffered I/O in this case.=
=0A=
>   */=0A=
>  struct iomap_dio *=0A=
> -__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,=0A=
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,=0A=
> -		bool wait_for_completion)=0A=
> +__iomap_dio_rw(struct iomap_dio_rw_args *args)=0A=
>  {=0A=
> +	struct kiocb *iocb =3D args->iocb;=0A=
> +	struct iov_iter *iter =3D args->iter;=0A=
>  	struct address_space *mapping =3D iocb->ki_filp->f_mapping;=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
> -	size_t count =3D iov_iter_count(iter);=0A=
> +	size_t count =3D iov_iter_count(args->iter);=0A=
>  	loff_t pos =3D iocb->ki_pos;=0A=
>  	loff_t end =3D iocb->ki_pos + count - 1, ret =3D 0;=0A=
>  	unsigned int flags =3D IOMAP_DIRECT;=0A=
> @@ -434,7 +434,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  	if (!count)=0A=
>  		return NULL;=0A=
>  =0A=
> -	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))=0A=
> +	if (WARN_ON(is_sync_kiocb(iocb) && !args->wait_for_completion))=0A=
>  		return ERR_PTR(-EIO);=0A=
>  =0A=
>  	dio =3D kmalloc(sizeof(*dio), GFP_KERNEL);=0A=
> @@ -445,7 +445,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  	atomic_set(&dio->ref, 1);=0A=
>  	dio->size =3D 0;=0A=
>  	dio->i_size =3D i_size_read(inode);=0A=
> -	dio->dops =3D dops;=0A=
> +	dio->dops =3D args->dops;=0A=
>  	dio->error =3D 0;=0A=
>  	dio->flags =3D 0;=0A=
>  =0A=
> @@ -490,7 +490,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  	if (ret)=0A=
>  		goto out_free_dio;=0A=
>  =0A=
> -	if (iov_iter_rw(iter) =3D=3D WRITE) {=0A=
> +	if (iov_iter_rw(args->iter) =3D=3D WRITE) {=0A=
>  		/*=0A=
>  		 * Try to invalidate cache pages for the range we are writing.=0A=
>  		 * If this invalidation fails, let the caller fall back to=0A=
> @@ -503,7 +503,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  			goto out_free_dio;=0A=
>  		}=0A=
>  =0A=
> -		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {=0A=
> +		if (!args->wait_for_completion && !inode->i_sb->s_dio_done_wq) {=0A=
>  			ret =3D sb_init_dio_done_wq(inode->i_sb);=0A=
>  			if (ret < 0)=0A=
>  				goto out_free_dio;=0A=
> @@ -514,12 +514,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter =
*iter,=0A=
>  =0A=
>  	blk_start_plug(&plug);=0A=
>  	do {=0A=
> -		ret =3D iomap_apply(inode, pos, count, flags, ops, dio,=0A=
> +		ret =3D iomap_apply(inode, pos, count, flags, args->ops, dio,=0A=
>  				iomap_dio_actor);=0A=
>  		if (ret <=3D 0) {=0A=
>  			/* magic error code to fall back to buffered I/O */=0A=
>  			if (ret =3D=3D -ENOTBLK) {=0A=
> -				wait_for_completion =3D true;=0A=
> +				args->wait_for_completion =3D true;=0A=
>  				ret =3D 0;=0A=
>  			}=0A=
>  			break;=0A=
> @@ -566,9 +566,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  	 *	of the final reference, and we will complete and free it here=0A=
>  	 *	after we got woken by the I/O completion handler.=0A=
>  	 */=0A=
> -	dio->wait_for_completion =3D wait_for_completion;=0A=
> +	dio->wait_for_completion =3D args->wait_for_completion;=0A=
>  	if (!atomic_dec_and_test(&dio->ref)) {=0A=
> -		if (!wait_for_completion)=0A=
> +		if (!args->wait_for_completion)=0A=
>  			return ERR_PTR(-EIOCBQUEUED);=0A=
>  =0A=
>  		for (;;) {=0A=
> @@ -596,13 +596,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter =
*iter,=0A=
>  EXPORT_SYMBOL_GPL(__iomap_dio_rw);=0A=
>  =0A=
>  ssize_t=0A=
> -iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,=0A=
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,=0A=
> -		bool wait_for_completion)=0A=
> +iomap_dio_rw(struct iomap_dio_rw_args *args)=0A=
>  {=0A=
>  	struct iomap_dio *dio;=0A=
>  =0A=
> -	dio =3D __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);=0A=
> +	dio =3D __iomap_dio_rw(args);=0A=
>  	if (IS_ERR_OR_NULL(dio))=0A=
>  		return PTR_ERR_OR_ZERO(dio);=0A=
>  	return iomap_dio_complete(dio);=0A=
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c=0A=
> index 5b0f93f73837..29f4204e551f 100644=0A=
> --- a/fs/xfs/xfs_file.c=0A=
> +++ b/fs/xfs/xfs_file.c=0A=
> @@ -205,6 +205,12 @@ xfs_file_dio_aio_read(=0A=
>  	struct xfs_inode	*ip =3D XFS_I(file_inode(iocb->ki_filp));=0A=
>  	size_t			count =3D iov_iter_count(to);=0A=
>  	ssize_t			ret;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D to,=0A=
> +		.ops			=3D &xfs_read_iomap_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);=0A=
>  =0A=
> @@ -219,8 +225,7 @@ xfs_file_dio_aio_read(=0A=
>  	} else {=0A=
>  		xfs_ilock(ip, XFS_IOLOCK_SHARED);=0A=
>  	}=0A=
> -	ret =3D iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,=0A=
> -			is_sync_kiocb(iocb));=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);=0A=
>  =0A=
>  	return ret;=0A=
> @@ -519,6 +524,13 @@ xfs_file_dio_aio_write(=0A=
>  	int			iolock;=0A=
>  	size_t			count =3D iov_iter_count(from);=0A=
>  	struct xfs_buftarg      *target =3D xfs_inode_buftarg(ip);=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D from,=0A=
> +		.ops			=3D &xfs_direct_write_iomap_ops,=0A=
> +		.dops			=3D &xfs_dio_write_ops,=0A=
> +		.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +	};=0A=
>  =0A=
>  	/* DIO must be aligned to device logical sector size */=0A=
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)=0A=
> @@ -535,6 +547,12 @@ xfs_file_dio_aio_write(=0A=
>  	    ((iocb->ki_pos + count) & mp->m_blockmask)) {=0A=
>  		unaligned_io =3D 1;=0A=
>  =0A=
> +		/*=0A=
> +		 * This must be the only IO in-flight. Wait on it before we=0A=
> +		 * release the iolock to prevent subsequent overlapping IO.=0A=
> +		 */=0A=
> +		args.wait_for_completion =3D true;=0A=
> +=0A=
>  		/*=0A=
>  		 * We can't properly handle unaligned direct I/O to reflink=0A=
>  		 * files yet, as we can't unshare a partial block.=0A=
> @@ -578,13 +596,7 @@ xfs_file_dio_aio_write(=0A=
>  	}=0A=
>  =0A=
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);=0A=
> -	/*=0A=
> -	 * If unaligned, this is the only IO in-flight. Wait on it before we=0A=
> -	 * release the iolock to prevent subsequent overlapping IO.=0A=
> -	 */=0A=
> -	ret =3D iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,=0A=
> -			   &xfs_dio_write_ops,=0A=
> -			   is_sync_kiocb(iocb) || unaligned_io);=0A=
> +	ret =3D iomap_dio_rw(&args);=0A=
>  out:=0A=
>  	xfs_iunlock(ip, iolock);=0A=
>  =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index bec47f2d074b..edf353ad1edc 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -735,6 +735,13 @@ static ssize_t zonefs_file_dio_write(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  	bool append =3D false;=0A=
>  	size_t count;=0A=
>  	ssize_t ret;=0A=
> +	struct iomap_dio_rw_args args =3D {=0A=
> +		.iocb			=3D iocb,=0A=
> +		.iter			=3D from,=0A=
> +		.ops			=3D &zonefs_iomap_ops,=0A=
> +		.dops			=3D &zonefs_write_dio_ops,=0A=
> +		.wait_for_completion	=3D sync,=0A=
> +	};=0A=
>  =0A=
>  	/*=0A=
>  	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT=0A=
> @@ -779,8 +786,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)=0A=
>  	if (append)=0A=
>  		ret =3D zonefs_file_dio_append(iocb, from);=0A=
>  	else=0A=
> -		ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
> -				   &zonefs_write_dio_ops, sync);=0A=
> +		ret =3D iomap_dio_rw(&args);=0A=
> +=0A=
>  	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>  	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>  		if (ret > 0)=0A=
> @@ -909,6 +916,13 @@ static ssize_t zonefs_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)=0A=
>  	mutex_unlock(&zi->i_truncate_mutex);=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
> +		struct iomap_dio_rw_args args =3D {=0A=
> +			.iocb			=3D iocb,=0A=
> +			.iter			=3D to,=0A=
> +			.ops			=3D &zonefs_iomap_ops,=0A=
> +			.dops			=3D &zonefs_read_dio_ops,=0A=
> +			.wait_for_completion	=3D is_sync_kiocb(iocb),=0A=
> +		};=0A=
>  		size_t count =3D iov_iter_count(to);=0A=
>  =0A=
>  		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {=0A=
> @@ -916,8 +930,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)=0A=
>  			goto inode_unlock;=0A=
>  		}=0A=
>  		file_accessed(iocb->ki_filp);=0A=
> -		ret =3D iomap_dio_rw(iocb, to, &zonefs_iomap_ops,=0A=
> -				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));=0A=
> +		ret =3D iomap_dio_rw(&args);=0A=
>  	} else {=0A=
>  		ret =3D generic_file_read_iter(iocb, to);=0A=
>  		if (ret =3D=3D -EIO)=0A=
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h=0A=
> index 5bd3cac4df9c..16d20c01b5bb 100644=0A=
> --- a/include/linux/iomap.h=0A=
> +++ b/include/linux/iomap.h=0A=
> @@ -256,12 +256,16 @@ struct iomap_dio_ops {=0A=
>  			struct bio *bio, loff_t file_offset);=0A=
>  };=0A=
>  =0A=
> -ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,=0A=
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,=0A=
> -		bool wait_for_completion);=0A=
> -struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
er,=0A=
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,=0A=
> -		bool wait_for_completion);=0A=
> +struct iomap_dio_rw_args {=0A=
> +	struct kiocb		*iocb;=0A=
> +	struct iov_iter		*iter;=0A=
> +	const struct iomap_ops	*ops;=0A=
> +	const struct iomap_dio_ops *dops;=0A=
> +	bool			wait_for_completion;=0A=
> +};=0A=
> +=0A=
> +ssize_t iomap_dio_rw(struct iomap_dio_rw_args *args);=0A=
> +struct iomap_dio *__iomap_dio_rw(struct iomap_dio_rw_args *args);=0A=
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);=0A=
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);=0A=
=0A=
Looks all good to me.=0A=
=0A=
For the zonefs part:=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
