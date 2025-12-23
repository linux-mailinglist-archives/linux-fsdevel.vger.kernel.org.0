Return-Path: <linux-fsdevel+bounces-71959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43FCD85E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6256C3001BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753B2E62C0;
	Tue, 23 Dec 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lb0uyb+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2C10F2;
	Tue, 23 Dec 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474535; cv=none; b=ivW1hdMihQf17M9+mfuRMVyOgySESdbRuu2QWnLuiD6OKlLnBJow8Y2dAP8OEgAybPLCbjfkPLZjB/I8EXO0BO3jeiRnOc5VhH9SHc6T5WRb5rdmaAN4uBlggfPuZuavsOZcqDJ8nLeYCuaXd5LNAqS+b2pnQ/UAyLA9m675f7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474535; c=relaxed/simple;
	bh=CZQcuaYsokH/S5rc821ek1zdKsbaU6zz6BezjrnjWKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvl5o2uURmYIcjvXCE1tdTcz+KmQIqo49BUknPCC1BEuurz/nIP9S8JyyhvtuqpNcCe3B6ColS+HiA02VamjXDu/JFs31g9ezipAu8sT0HFtwPJB4uc4kBXl4kKDPEYIltSE5LsMAko+sVr650vMk1bTkGF8mo25jhh/NbkUbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lb0uyb+X; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766474522; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WP4wbO8xxNf5sF6oDvztFbQjshgawGK2sKSXSVt1ggE=;
	b=Lb0uyb+X3CMKxZfX82HKyBNdwsTxax+Qc//QOIpZTm8QnLubIV4N0oqvqicfz6EIex7/5g3HrAr1EBkZ0VQq+gxIcYtasZD65ZtK9fYv75blB3hLXvfEgvUv2KZWg3eNk2QJRWP3N16OrwttL16Zq0qPdcdNUeBb6R5ZHcibMRs=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvWoF5M_1766474520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 15:22:01 +0800
Message-ID: <9f03647d-2996-4d16-8c64-5afecdc904a9@linux.alibaba.com>
Date: Tue, 23 Dec 2025 15:22:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/10] erofs: support user-defined fingerprint name
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/Kconfig    |  9 +++++++++
>   fs/erofs/erofs_fs.h |  5 +++--
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    |  3 +++
>   fs/erofs/xattr.c    | 13 +++++++++++++
>   5 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index d81f3318417d..c88b6d0714a4 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_PAGE_CACHE_SHARE
> +	bool "EROFS page cache share support (experimental)"
> +	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
> +	help
> +	  This enables page cache sharing among inodes with identical
> +	  content fingerprints on the same device.

`on the same device` seems ambiguous because of `device`.

maybe just `on the same machine`.

> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index e24268acdd62..20515d2462af 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,7 +17,7 @@
>   #define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
>   #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
>   #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
> -
> +#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS		0x00000020
>   
>   /*
>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> @@ -83,7 +83,8 @@ struct erofs_super_block {
>   	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
> -	__u8 reserved[3];
> +	__u8 ishare_xattr_prefix_id;	/* indexes the ishare key in prefix xattres */
> +	__u8 reserved[2];
>   	__le32 build_time;	/* seconds added to epoch for mkfs time */
>   	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
>   	__le64 reserved2;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 98fe652aea33..99e2857173c3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -134,6 +134,7 @@ struct erofs_sb_info {
>   	u32 xattr_blkaddr;
>   	u32 xattr_prefix_start;
>   	u8 xattr_prefix_count;
> +	u8 ishare_xattr_pfx;
>   	struct erofs_xattr_prefix_item *xattr_prefixes;
>   	unsigned int xattr_filter_reserved;
>   #endif
> @@ -238,6 +239,7 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
>   EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
> +EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
>   
>   static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
>   {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 2a44c4e5af4f..68480f10e69d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -298,6 +298,9 @@ static int erofs_read_superblock(struct super_block *sb)
>   		if (ret)
>   			goto out;
>   	}
> +	if (erofs_sb_has_ishare_xattrs(sbi))
> +		sbi->ishare_xattr_pfx =
> +			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;

Is it possible to move this one into erofs_xattr_prefixes_init()?

we could pass dsb into erofs_xattr_prefixes_init() too.

>   
>   	ret = -EINVAL;
>   	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 396536d9a862..969e77efd038 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -519,6 +519,19 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
>   	}
>   
>   	erofs_put_metabuf(&buf);
> +	if (!ret && erofs_sb_has_ishare_xattrs(sbi)) {
> +		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_pfx;
> +		struct erofs_xattr_long_prefix *newpfx;

then:
		sbi->ishare_xattr_pfx =
			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
...

Thanks,
Gao Xiang

