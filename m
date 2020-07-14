Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA221E545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGNBli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 21:41:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32588 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNBlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594690915; x=1626226915;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3djqRKAYL2w5RI8t/Ei2UImc/Zuq9JwSh7w0CztAQTc=;
  b=nxOESETUWyppGqzmP4QagS3+go/sTkqO1ISQ2Rv3x4spPLppF3n4Rq9s
   OjiOd1Y7UX23L3YU6KTaXCzdv/ZB89KzMd45nV7q/yFgBSDNxNpHTEl/f
   RtV763Iu7u6XxuPGTSfOGDdgke3GOkiRsIyAeFS2svafnSQW38tEmF4LM
   obEPeET0z/mOJE8f05ZSzHV44/ZkjcVGE/29qyVr18w3YS3EbPUfCpas4
   053x+qFky1zjnHYzlVd7W0qqH6paeyMFaP84NvdXJcK3QGV+E/CsLTaPv
   7TGAgkqcLrdohBUUQ+0cYLQfu4ThpkyIR9xzb9wP5nMTIieTFOyl6e3sQ
   w==;
IronPort-SDR: Sh83aetPksjIcpFmgqcyaWoxqrwab1xEOxSHEu2TIPiEmoZ+bP+AMtnhVVOoM+DjSfxmQAWRyU
 CP/5RyvKv+Vd106GPDoOvN+7eeHkJ0UgAwUpp+PChEIfG2IC03nH/xTbfMqMfBsZgyxaWOpR8i
 MhJXIyGfGMiqN+atOvp9FdElCgS4lnMxM5915kcGqLPev/MknpzXti0NZNfegfrjb0NOzNwbY4
 vu1I8LVXlC18UU1zf19AWbwtG0qRuzDm1waIM69uCYE1t0OTTg0LjzZXnQGU2mlm5GEx8njfWl
 Auw=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; 
   d="scan'208";a="245397286"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 09:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9XfBOrRV7ZbDHMV9Bqv0NYccfmvCRbsUyXvfrDaQLKAq/ja4G4i9M6CH7iG58xEuZT5y+bVE0tTNRMyfdqkU3iNTRDDPd1wojan3eiV7uQFI01RkqjIkSWM+6/tCoJ8v6ThiBUu7UsUhsfC6UC9v8InjF9KgwEeJnCPVrfnko8VQeXy/Dbk0dVtLUSHL7/j18JDINmZNV4T/o5DyZ+euK13q2SOIUf6dvMCEymd42wZpOlwrGMES4L0tz8MlMFxNU+VS4l6Iqb+pQW8vlUTjmbQf1p+B8NexP21Hi5BkThfvx12+Pc4iSuVXgg3bMPrEeF1VW33CJn5vTN7IytHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF4Dkm0a/Y+SQdIU8/JReEo/q2/huy4ItHa4364rV/g=;
 b=LoAb79qSjSSu5m86obZ+zvwUD+cRKfrvp3ruMBOfCH2r4DdA9iwYVVIwNA9f1DKoZcjHjAbk6mt9PKqjnIES74Ab5/FPXLmL7hl9sPh847vKyaMZfJtygADiYCAHY/JjwCigtB1C5L9E5+86CclVC+aYxRUfeZ6SPLWiGS11QADAN+BcsRYWntV0rLQJpSEb/e9Gt2Eq1jQ+RBCHhfCj3FxRTc4cyeWEi8XnTasUbnxiIKTo/u4CcN6p8FCnS4r3gkOtu/dN65FtvGwDViPAQxdcpRkEGsHMRtEeoB8/mlO5K9qkB8aYe4C3waluwlwrx/zCYsmMbxqp/EegEvwE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF4Dkm0a/Y+SQdIU8/JReEo/q2/huy4ItHa4364rV/g=;
 b=nCLWbl3ZhPlXoCduo7b4KFPHwLbnMdUaOyjJNuTPAM9eeG8gwFxtMxeeHyJBExtFT0rld8+LGmPhImfhMJEdNshxydJkBJqeipoYyGzPfonmoof8k8rWZtJHkPYps983QMLYEvQA4NKRDTtjWitmdifvL4mOhUlEaAD8A6Zk9Dc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0342.namprd04.prod.outlook.com (2603:10b6:903:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 01:41:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Tue, 14 Jul 2020
 01:41:35 +0000
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
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] iomap: fall back to buffered writes for invalidation
 failures
Thread-Topic: [PATCH 2/2] iomap: fall back to buffered writes for invalidation
 failures
Thread-Index: AQHWWOpfe2YKgQYiyEytHJaTXg3ezA==
Date:   Tue, 14 Jul 2020 01:41:34 +0000
Message-ID: <CY4PR04MB37512AD7FD85DEB3014D01D2E7610@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200713074633.875946-1-hch@lst.de>
 <20200713074633.875946-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7da51972-d886-464b-5637-08d827970af9
x-ms-traffictypediagnostic: CY4PR04MB0342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0342B06BA5D28B4830DDA918E7610@CY4PR04MB0342.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44qJN3uBpQHrUyTU3Vk+vIAbtGPTMbAewOZdrWONYjOohS/unQawwqRpn+Qd2LhjRlyvvrGmooKMfTlBtw20XUJhhW86kb75/evf7krNJrt9/kpWledMP033w7kiJnm3GQD9n6lPJpex5drlcWqFbFER4HHcQzWH+fEmUTGQP9fZUppdXzW0GPpwkBrE478VPMRvjnc9g2NoE8lZl8MyuyuAHLT7YT4Qfrfbsja78rosHgnIJODvw3TKE2nZgugj+W1chz+E2+fQvn4C1pNOt+WwoF16b1Xz3JfEN5ianhPtafIeOhGw/WWm7xmE+wM1gJwqRGHEIgkF24aJJA8boQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(7696005)(7416002)(71200400001)(110136005)(478600001)(186003)(76116006)(54906003)(26005)(9686003)(86362001)(83380400001)(6506007)(53546011)(64756008)(66556008)(8676002)(91956017)(66446008)(66476007)(66946007)(5660300002)(2906002)(316002)(4326008)(33656002)(8936002)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p1FWfACkzD9K2pmzKpRnzBAt48eaEXfHdbX2fHR8PUGxm2z38gEDH1nXbqlE0tvwtivhD0MRA0WDcnkeHlcNOqUUo9zkAxyYaYIgyuHaMZMlS7xgiCMAagrMDxisElyoNy0eTrEW+gpMVjNcmcTDx6cOOEeBPCFLDWj6Z1s08EmCniJLIpLZU5YW9lrQn+zabpkvQ8/+Ae+2V/8CY0YjYmaiiNzcAcXxWW3aflkElCQbZvTtU7jryQY4oJX8OEn2PCxFsao4OaTp2Kv+016fT8n9GX686nLrYAzBAtEIwrIhBmSCf2g77qlvO5xJF5L142dMXc5DOzQCB2ThCLr6ddMqBvQAiMHHn3jabv8nUO10UfJF/bGyc4d4DuIdg6ko2XePCZEhPIIRo4WfJt5erNW/tUNy/5Y1c77JMyxYS+gR8nHjqxQp9QwdPz9PAH+pSMceQ50nTdLvsTd96vnKceQkNgQWmgwudXA9CLmB01qUnxklrVgd5WrrTixvGOdh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da51972-d886-464b-5637-08d827970af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 01:41:34.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WLpGoX6VJbLuqE0K8+z+uqmLyM089kOJI2miSmcNmoMF+N8ibftosSLMiovIucEsKhBlp4L9XvauJJepyxZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0342
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/13 16:51, Christoph Hellwig wrote:=0A=
> Failing to invalid the page cache means data in incoherent, which is=0A=
=0A=
s/in incoherent/is incoherent=0A=
=0A=
> a very bad state for the system.  Always fall back to buffered I/O=0A=
> through the page cache if we can't invalidate mappings.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/ext4/file.c       |  2 ++=0A=
>  fs/gfs2/file.c       |  3 ++-=0A=
>  fs/iomap/direct-io.c | 13 ++++++++-----=0A=
>  fs/iomap/trace.h     |  1 +=0A=
>  fs/xfs/xfs_file.c    |  4 ++--=0A=
>  fs/zonefs/super.c    |  7 +++++--=0A=
>  6 files changed, 20 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c=0A=
> index 2a01e31a032c4c..0da6c2a2c32c1e 100644=0A=
> --- a/fs/ext4/file.c=0A=
> +++ b/fs/ext4/file.c=0A=
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb=
, struct iov_iter *from)=0A=
>  		iomap_ops =3D &ext4_iomap_overwrite_ops;=0A=
>  	ret =3D iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,=0A=
>  			   is_sync_kiocb(iocb) || unaligned_io || extend);=0A=
> +	if (ret =3D=3D -EREMCHG)=0A=
> +		ret =3D 0;=0A=
>  =0A=
>  	if (extend)=0A=
>  		ret =3D ext4_handle_inode_extension(inode, offset, ret, count);=0A=
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c=0A=
> index fe305e4bfd3734..c7907d40c61d17 100644=0A=
> --- a/fs/gfs2/file.c=0A=
> +++ b/fs/gfs2/file.c=0A=
> @@ -814,7 +814,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  =0A=
>  	ret =3D iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,=0A=
>  			   is_sync_kiocb(iocb));=0A=
> -=0A=
> +	if (ret =3D=3D -EREMCHG)=0A=
> +		ret =3D 0;=0A=
>  out:=0A=
>  	gfs2_glock_dq(&gh);=0A=
>  out_uninit:=0A=
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
> index 190967e87b69e4..62626235cdbe8d 100644=0A=
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
> @@ -478,13 +479,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
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
> +			ret =3D -EREMCHG;=0A=
=0A=
I am wondering if it is OK to unconditionally always return -EREMCHG here.=
=0A=
Shouldn't this depend on the return code of invalidate_inode_pages2_range()=
 ?=0A=
ret may be the value returned by mapping->a_ops->launder_page(page) instead=
 of=0A=
-EBUSY that invalidate_inode_pages2_range() otherwise returns for a failed=
=0A=
invalidation. Isn't their any error condition that would be better served b=
y not=0A=
forcing the fallback to buffered write ? E.g. -ENOMEM ?=0A=
=0A=
=0A=
=0A=
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
> index 00db81eac80d6c..551cca39fa3ba6 100644=0A=
> --- a/fs/xfs/xfs_file.c=0A=
> +++ b/fs/xfs/xfs_file.c=0A=
> @@ -553,8 +553,8 @@ xfs_file_dio_aio_write(=0A=
>  	xfs_iunlock(ip, iolock);=0A=
>  =0A=
>  	/*=0A=
> -	 * No fallback to buffered IO on errors for XFS, direct IO will either=
=0A=
> -	 * complete fully or fail.=0A=
> +	 * No partial fallback to buffered IO on errors for XFS, direct IO will=
=0A=
> +	 * either complete fully or fail.=0A=
>  	 */=0A=
>  	ASSERT(ret < 0 || ret =3D=3D count);=0A=
>  	return ret;=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 07bc42d62673ce..793850454b752f 100644=0A=
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
> +		ret =3D zonefs_file_dio_write(iocb, from);=0A=
> +		if (ret !=3D -EREMCHG)=0A=
> +			return ret;=0A=
> +	}=0A=
=0A=
This looks fine. This would happen only for conventional zone writes since=
=0A=
sequential zone writes cannot ever issue direct IOs on top of cached data a=
s=0A=
that would be a forbidden "overwrite" operation.=0A=
=0A=
>  =0A=
>  	return zonefs_file_buffered_write(iocb, from);=0A=
>  }=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
