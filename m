Return-Path: <linux-fsdevel+bounces-46033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7BA81ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 04:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3419E61D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D751925AF;
	Wed,  9 Apr 2025 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJRoggCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9A8F49;
	Wed,  9 Apr 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744164125; cv=none; b=jwTb5VKaD/aOomAhGXMavjFmfm2N2nXSlZkxciNXPlIRMP/29LXO2v8iVlUNky/MOZQem6TrWhSsXuPUGSd0jwbQyCRH0KAhRAP6V2Z4CArqPl85CGe9JpDWPnmgaPB8yxS9adG3qU7Ck/vjlpUDQWtp24gcNeqcYVOYX8c0qJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744164125; c=relaxed/simple;
	bh=Jrj5fZbgGabxF7m+FWjZuY30NsAWAz1JlNS6WxgVs+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibmXF2rTkHfih0l9mQWG5GKJXz3k6QNDBWnTnxfZxXLZRG7KL+PmJ9u7gEc3WMiQqI9HmB880KzuGmSPqHDCu7qI9WR93KErOlntWmGGdG0UoU6LntqrICIrNiuznkJfIduFmqAehRkwDoQ7aiijS3kDREVq/7saVGXV9hSq3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJRoggCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E535C4CEE5;
	Wed,  9 Apr 2025 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744164124;
	bh=Jrj5fZbgGabxF7m+FWjZuY30NsAWAz1JlNS6WxgVs+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJRoggCygojmuW8hLObxvCWXCt0t1n1lP70E2My1stQzAg0mZR4pFM1JmMdysqxWp
	 xiUc/iti5Ucdg561qHqJEyFhWTfDXxuPpXJVrNb8gFLXktNlxfvQZGR3UDf7yp3GjF
	 lUqfCfSsMAqIEz3Wv3pDoJgi5Dqwq7jC+NXiNNx2fCvg60VjTNdnupWEFPezvrNjM9
	 WEPRNsjvHWJkp8V1KpYjip+8ZlYjqTV5/cjLe46L/fCTzoQTEAslv8qS3Kf8+CPKhL
	 CSvTDnWqT5fyNbJtjLaaRRpoilLmDJsbzc+YOSkmWZ+HliR1rstzi7MU254m2vEPpN
	 AYn5N8jfvcyzg==
Date: Tue, 8 Apr 2025 19:02:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 03/12] xfs: rename xfs_inode_can_atomicwrite() ->
 xfs_inode_can_hw_atomicwrite()
Message-ID: <20250409020203.GI6283@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-4-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:42:00AM +0000, John Garry wrote:
> In future we will want to be able to check if specifically HW offload-based
> atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
> xfs_inode_can_hw_atomicwrite().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c  | 2 +-
>  fs/xfs/xfs_inode.h | 2 +-
>  fs/xfs/xfs_iops.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 84f08c976ac4..653e42ccc0c3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1488,7 +1488,7 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> -	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
> +	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
>  		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index eae0159983ca..cff643cd03fc 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
>  		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
>  
>  static inline bool
> -xfs_inode_can_atomicwrite(
> +xfs_inode_can_hw_atomicwrite(
>  	struct xfs_inode	*ip)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index f0e5d83195df..d324044a2225 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -608,7 +608,7 @@ xfs_report_atomic_write(
>  {
>  	unsigned int		unit_min = 0, unit_max = 0;
>  
> -	if (xfs_inode_can_atomicwrite(ip))
> +	if (xfs_inode_can_hw_atomicwrite(ip))
>  		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
>  	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
>  }
> -- 
> 2.31.1
> 
> 

