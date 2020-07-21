Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AB228C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgGUXCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:02:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16877 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGUXCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595372522; x=1626908522;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GWSVryyAariA83dMxcg5lAiTMbwHdjLKESDz3R5d2q8=;
  b=Kutx54fgn153RXTVwYYDDhALDYzGu3PJUdWvVw9E42RgutHunNENyzhs
   UYBRivRTnjBWxaJ+53AgdhnIvAkCNPYw3PtPrmzmmIB5Kk8o7SBH03Myc
   yg2WTO6TzenpyOSUdm6MkCgicAWBmPPbFVRLxJ+/5wVe5Zs3NixRRshlv
   y8T1mmFanYXEikEIK+2dX5Ce9eJywbclHiX+RW9ZRJLX+jdNoAx3DIjY9
   WIzvw89hZgOcixjm2yyqE3CMDPioCi24t39nvsep1CuRmCeKbqGDNEEeC
   s+ZWDnbRPIA6zqtpoIqnXGl+QK00/2MlbEfzzyddsfv3zpanHiOMYtocy
   g==;
IronPort-SDR: 6zXZuTEtaDCKacFjATcPNS9nWGEVoFawZoz6bFVzvgcJOZrIpWghZIMkW+Oc6/PdIlWhEq0xWc
 dlzleMm/1/HfZ3UVtOH+Cyaa+7DIwLwrzaaT1dm1CR7WJdjRxxnvFkEiomsq5LGOPxLZ/5XBT0
 ltVxQihIb9/cpkQttY/9VjuE1VeuKg82FvrFB2/1/4ADw91WLmK0UpwbCyqL2iZj4K7hbJCkff
 oI3ZDfdTfDFGsDPRAvt3eTQfVyrsMYYNWSNetCv3Oq/K0GyOOsCJ9xAGib/CzbIZIgnF3eXNUj
 Edo=
X-IronPort-AV: E=Sophos;i="5.75,380,1589212800"; 
   d="scan'208";a="144323903"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 07:02:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvnPFUjjfa4MQl25UkYZzxbeh2hXQLIciCwhiXEWu0iHg8YrkhYC4/a+wl6tsY2F9MRMRVvlmLNA67D2CUuj+osskKdXq4bosIVnkMa7qfV+RpUSlCM6VGY+1aisqAhOGpR15gIG+NFVRhpzdMkI0nTzmwz9vnFmFa0Ngge6RobvEqor9jLM7ubwXQzDaCsLo9Rea2wUnwpKURxymOMd5TAtmf3ytfiZo8B+o4mXGmcYCsE5t//a4WlqvkGQqACr4txeNnHPlowqZYN4ceLuwTDpzTQ5r+0IxTe3ChanxoWFZKTRtXvlf1jU/LZYsi2n/DJ6zca7pGwsu/2YFom7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUzcgw8xRnU+IZNtIjaCV8Btm64eAgFtNhPA9n65QZY=;
 b=QNQTPKgXYCsm3SmR0+j+l2B7e2FBkQFFwf29MoSVR4QUV2CGr40cG4BZTwYOnAZOOyCQAu5a6Qc/WTx9akDKQ0HGT0G6fcqAIP/WS8vzJkEe0EZrnAwsza86JvVIQ4ScYs6zdmY3CqBnjLm5v1D9CGisJGndwwVz04sOZgtGsAmX5GYpyduIoC4gRXxmIbaUTlrxL5AeCXomx0c0BwyLcsxTJEm75mo4CMoXklmM4nEWYsIgM0WeMaYaJZcKppGMa4/wLJh6ZH+ng2lkEVMBSLx4SmQ6R2eQeXk0h5LSRjiEbMP1x3qovcqSYvk40bxzmwLAznc0hXny2yFqfmV1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUzcgw8xRnU+IZNtIjaCV8Btm64eAgFtNhPA9n65QZY=;
 b=CpBJFy1yRjmHTb0XpBTivbN4PtNoF0hoCi3mCyGMtBQwSYzv5A6eTGksBw0lkStwV1mchaaB2oKdYKjmlzfmbibmjo1ssdwIPJq4uQLaXB72IBSuhUwVVFwrFiWjC3ON3sd5q3y4SX2pLyQ12pI6e+SxyIugbxO56wA5uPBnOQc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0344.namprd04.prod.outlook.com (2603:10b6:903:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 23:02:00 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 23:01:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/3] iomap: fall back to buffered writes for invalidation
 failures
Thread-Topic: [PATCH 3/3] iomap: fall back to buffered writes for invalidation
 failures
Thread-Index: AQHWX41AZHgnsBRxxUOY+Qc2jgClZg==
Date:   Tue, 21 Jul 2020 23:01:59 +0000
Message-ID: <CY4PR04MB37517784D29AFC7CCBAD1A0AE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721183157.202276-1-hch@lst.de>
 <20200721183157.202276-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b05dc4bb-14de-47a2-0a6c-08d82dca12f6
x-ms-traffictypediagnostic: CY4PR04MB0344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB03449217CCEE6D26EF820502E7780@CY4PR04MB0344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyK5kY3yVzzbkszaDCMzLrHJ+c36n4Teb7fx2CAPm/C1vspwRudN/9qkOQIqKYLMvKMswUUx0ZcMnfzrmSWpV05zzS/f8YEfsq8ijzBN3R+gNyJTViTyNQa5u3gwytGRKpL6YS9vjmopt278TBPGNx9GxrKt2x9rJAJWugt27QO1PBJ6Sx8EFohNLlpfnE6z3Coo/i2vIRZ8XNoD4L8PEAQHOKAoLh6oA8/pNx94lnlQ7n+pO/5ea3nFWIWMEsnTnpurMLffZoTTt64l4v420XHvCHVXloEiNXlPh1MIFpVWHnwADVsh5br7GgxTLSCM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(316002)(5660300002)(64756008)(7696005)(8936002)(53546011)(8676002)(6506007)(186003)(66556008)(86362001)(66476007)(66946007)(26005)(76116006)(91956017)(66446008)(7416002)(2906002)(54906003)(110136005)(55016002)(52536014)(71200400001)(478600001)(4326008)(83380400001)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cYSFy/CjR18YkyZE8RC0GPQxCBpUmBcSTj6rUU4jEXkT8M3Hu7hy55t8YWAbFP4sR90mwJggBb75OmcCN1r52TlX3A8erHPS1IcjgkVfT3spXkMamwA1vJApBg9ly2pB1EuF2Wm1EL1oUctt/8UKNSA9155XhvJMKPUjVyw5diF9JruiybI7IljoJe3q32Cdqsgjdto/ZfrdV3G3MTi1tI4bInQQwNKAhKarOJTQHfg6FF6TrT/A6NdsT5Zz1yH9LLV9HphLX/MRt8shtbCGck3RQFez8Qo2DzX0YJM/VYY/S4B2EahewAdDnsMOVCMVGg3OemjsgDMIDM+0A02nNsaFNCaPdph1iTehD8EAE6zqgDzJUxxPmvzZybpXZ4MqA6k3FScNbMhfc2t+Es/rxlN9+7+sL5itkXTnV34CximVmTsQ9Lf/25tm0og8CE1WGMJIa26U74c5i5F+/f8sZ1FKFMf2mCSqGM/mPc7vlRtBzYcmje1BSMRLdPfE6Kpt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05dc4bb-14de-47a2-0a6c-08d82dca12f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 23:01:59.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owC04WxI1s1W7L02eeMwBeccs9mKHCJNIjDY7BiO1XGrp+rj8+i0LA3y+8OR9T39vWcz3ki9M+0FlCgM+z/aGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0344
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/22 3:32, Christoph Hellwig wrote:=0A=
> Failing to invalid the page cache means data in incoherent, which is=0A=
> a very bad state for the system.  Always fall back to buffered I/O=0A=
> through the page cache if we can't invalidate mappings.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> Acked-by: Dave Chinner <dchinner@redhat.com>=0A=
> Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>=0A=
> ---=0A=
>  fs/ext4/file.c       |  2 ++=0A=
>  fs/gfs2/file.c       |  3 ++-=0A=
>  fs/iomap/direct-io.c | 16 +++++++++++-----=0A=
>  fs/iomap/trace.h     |  1 +=0A=
>  fs/xfs/xfs_file.c    |  4 ++--=0A=
>  fs/zonefs/super.c    |  7 +++++--=0A=
>  6 files changed, 23 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c=0A=
> index 2a01e31a032c4c..129cc1dd6b7952 100644=0A=
> --- a/fs/ext4/file.c=0A=
> +++ b/fs/ext4/file.c=0A=
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb=
, struct iov_iter *from)=0A=
>  		iomap_ops =3D &ext4_iomap_overwrite_ops;=0A=
>  	ret =3D iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,=0A=
>  			   is_sync_kiocb(iocb) || unaligned_io || extend);=0A=
> +	if (ret =3D=3D -ENOTBLK)=0A=
> +		ret =3D 0;=0A=
>  =0A=
>  	if (extend)=0A=
>  		ret =3D ext4_handle_inode_extension(inode, offset, ret, count);=0A=
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c=0A=
> index bebde537ac8cf2..b085a3bea4f0fd 100644=0A=
> --- a/fs/gfs2/file.c=0A=
> +++ b/fs/gfs2/file.c=0A=
> @@ -835,7 +835,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  =0A=
>  	ret =3D iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,=0A=
>  			   is_sync_kiocb(iocb));=0A=
> -=0A=
> +	if (ret =3D=3D -ENOTBLK)=0A=
> +		ret =3D 0;=0A=
>  out:=0A=
>  	gfs2_glock_dq(&gh);=0A=
>  out_uninit:=0A=
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
> index 190967e87b69e4..c1aafb2ab99072 100644=0A=
> --- a/fs/iomap/direct-io.c=0A=
> +++ b/fs/iomap/direct-io.c=0A=
> @@ -10,6 +10,7 @@=0A=
>  #include <linux/backing-dev.h>=0A=
>  #include <linux/uio.h>=0A=
>  #include <linux/task_io_accounting_ops.h>=0A=
> +#include "trace.h"=0A=
>  =0A=
>  #include "../internal.h"=0A=
>  =0A=
> @@ -401,6 +402,9 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff=
_t length,=0A=
>   * can be mapped into multiple disjoint IOs and only a subset of the IOs=
 issued=0A=
>   * may be pure data writes. In that case, we still need to do a full dat=
a sync=0A=
>   * completion.=0A=
> + *=0A=
> + * Returns -ENOTBLK In case of a page invalidation invalidation failure =
for=0A=
> + * writes.  The callers needs to fall back to buffered I/O in this case.=
=0A=
>   */=0A=
>  ssize_t=0A=
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,=0A=
> @@ -478,13 +482,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>  	if (iov_iter_rw(iter) =3D=3D WRITE) {=0A=
>  		/*=0A=
>  		 * Try to invalidate cache pages for the range we are writing.=0A=
> -		 * If this invalidation fails, tough, the write will still work,=0A=
> -		 * but racing two incompatible write paths is a pretty crazy=0A=
> -		 * thing to do, so we don't support it 100%.=0A=
> +		 * If this invalidation fails, let the caller fall back to=0A=
> +		 * buffered I/O.=0A=
>  		 */=0A=
>  		if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,=0A=
> -				end >> PAGE_SHIFT))=0A=
> -			dio_warn_stale_pagecache(iocb->ki_filp);=0A=
> +				end >> PAGE_SHIFT)) {=0A=
> +			trace_iomap_dio_invalidate_fail(inode, pos, count);=0A=
> +			ret =3D -ENOTBLK;=0A=
> +			goto out_free_dio;=0A=
> +		}=0A=
>  =0A=
>  		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {=0A=
>  			ret =3D sb_init_dio_done_wq(inode->i_sb);=0A=
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h=0A=
> index 5693a39d52fb63..fdc7ae388476f5 100644=0A=
> --- a/fs/iomap/trace.h=0A=
> +++ b/fs/iomap/trace.h=0A=
> @@ -74,6 +74,7 @@ DEFINE_EVENT(iomap_range_class, name,	\=0A=
>  DEFINE_RANGE_EVENT(iomap_writepage);=0A=
>  DEFINE_RANGE_EVENT(iomap_releasepage);=0A=
>  DEFINE_RANGE_EVENT(iomap_invalidatepage);=0A=
> +DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);=0A=
>  =0A=
>  #define IOMAP_TYPE_STRINGS \=0A=
>  	{ IOMAP_HOLE,		"HOLE" }, \=0A=
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c=0A=
> index a6ef90457abf97..1b4517fc55f1b9 100644=0A=
> --- a/fs/xfs/xfs_file.c=0A=
> +++ b/fs/xfs/xfs_file.c=0A=
> @@ -553,8 +553,8 @@ xfs_file_dio_aio_write(=0A=
>  	xfs_iunlock(ip, iolock);=0A=
>  =0A=
>  	/*=0A=
> -	 * No fallback to buffered IO on errors for XFS, direct IO will either=
=0A=
> -	 * complete fully or fail.=0A=
> +	 * No fallback to buffered IO after short writes for XFS, direct I/O=0A=
> +	 * will either complete fully or return an error.=0A=
>  	 */=0A=
>  	ASSERT(ret < 0 || ret =3D=3D count);=0A=
>  	return ret;=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 07bc42d62673ce..d0a04528a7e18e 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -786,8 +786,11 @@ static ssize_t zonefs_file_write_iter(struct kiocb *=
iocb, struct iov_iter *from)=0A=
>  	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)=0A=
>  		return -EFBIG;=0A=
>  =0A=
> -	if (iocb->ki_flags & IOCB_DIRECT)=0A=
> -		return zonefs_file_dio_write(iocb, from);=0A=
> +	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
> +		ssize_t ret =3D zonefs_file_dio_write(iocb, from);=0A=
> +		if (ret !=3D -ENOTBLK)=0A=
> +			return ret;=0A=
> +	}=0A=
>  =0A=
>  	return zonefs_file_buffered_write(iocb, from);=0A=
>  }=0A=
> =0A=
=0A=
Looks fine. For zonefs:=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
