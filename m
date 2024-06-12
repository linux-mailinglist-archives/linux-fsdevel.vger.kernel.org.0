Return-Path: <linux-fsdevel+bounces-21493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5D9048A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D560C28554C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506563D5;
	Wed, 12 Jun 2024 01:59:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A298F72;
	Wed, 12 Jun 2024 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157556; cv=none; b=MZaDZh8u8CUGUx2LY4Qg9It+MqnBAb89w04FwJeRiixpt8qXA75cmNhig5ypB75W68Gffy80dliWnvE4LH5vt0Y+ds8LiwKe053zQQP+gVtK4mV72IHlVfhTSxGMSTzR4mQFFdkjF9WaYnEKw2r8YVjuXTNHuUj1QDJfBiD3AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157556; c=relaxed/simple;
	bh=m/9CniaJyW8JNpE0fIuzwkYnQ2cyl64QD9V3J9ZowtY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRlH8qkf2q7OA+OGZ3aFLZAJckQuQ/eRAWcZ3cFBFkkcE9GEVpPxTwGSsLUruc4b2kwpEdDnoBZaqLQiD7xCnwPR/7ur6K8tcabUz9Q8ZFCg0IbD2+Fl1WC+KEMgXmStORs7SmaZRC5GWX9R0un7qIbGGHNoJn3dG1yi839hTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VzTC05tKxz2CkTM;
	Wed, 12 Jun 2024 09:55:24 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F1E140257;
	Wed, 12 Jun 2024 09:59:12 +0800 (CST)
Received: from localhost (10.175.127.227) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 09:59:11 +0800
Date: Wed, 12 Jun 2024 10:10:58 +0800
From: Long Li <leo.lilong@huawei.com>
To: John Garry <john.g.garry@oracle.com>, <david@fromorbit.com>,
	<djwong@kernel.org>, <hch@lst.de>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <chandan.babu@oracle.com>,
	<willy@infradead.org>
CC: <axboe@kernel.dk>, <martin.petersen@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <jbongio@google.com>, <ojaswin@linux.ibm.com>,
	<ritesh.list@gmail.com>, <mcgrof@kernel.org>, <p.raghav@samsung.com>,
	<linux-xfs@vger.kernel.org>, <catherine.hoang@oracle.com>
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240612021058.GA729527@ceph-admin>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-9-john.g.garry@oracle.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500009.china.huawei.com (7.221.188.199)

On Mon, Apr 29, 2024 at 05:47:33PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add a new inode flag to require that all file data extent mappings must
> be aligned (both the file offset range and the allocated space itself)
> to the extent size hint.  Having a separate COW extent size hint is no
> longer allowed.
> 
> The goal here is to enable sysadmins and users to mandate that all space
> mappings in a file must have a startoff/blockcount that are aligned to
> (say) a 2MB alignment and that the startblock/blockcount will follow the
> same alignment.
> 
> jpg: Enforce extsize is a power-of-2 and aligned with afgsize + stripe
>      alignment for forcealign
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_format.h    |  6 ++++-
>  fs/xfs/libxfs/xfs_inode_buf.c | 50 +++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
>  fs/xfs/libxfs/xfs_sb.c        |  2 ++
>  fs/xfs/xfs_inode.c            | 12 +++++++++
>  fs/xfs/xfs_inode.h            |  2 +-
>  fs/xfs/xfs_ioctl.c            | 34 +++++++++++++++++++++++-
>  fs/xfs/xfs_mount.h            |  2 ++
>  fs/xfs/xfs_super.c            |  4 +++
>  include/uapi/linux/fs.h       |  2 ++
>  10 files changed, 114 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 2b2f9050fbfb..4dd295b047f8 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 
Hi, John

You know I've been using and testing your atomic writes patch series recently,
and I'm particularly interested in the changes to the on-disk format. I noticed
that XFS_SB_FEAT_RO_COMPAT_FORCEALIGN uses bit 30 instead of bit 4, which would
be the next available bit in sequence.

I'm wondering if using bit 30 is just a temporary solution to avoid conflicts, 
and if the plan is to eventually use bits sequentially, for example, using bit 4?
I'm looking forward to your explanation.

Thanks,
Long Li

