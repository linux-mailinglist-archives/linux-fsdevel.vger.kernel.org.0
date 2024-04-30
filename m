Return-Path: <linux-fsdevel+bounces-18386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B588D8B82FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93C8B21E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045D1C0DD7;
	Tue, 30 Apr 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zgxhCvCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC981BF6F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519372; cv=none; b=dx2p+Q2t1lwTGi4dnTQTjcUfN2IKj+WQNt+UVyoHCN8Eqr8AZuVNZNS8BSvyHOf90TM6m9wAg7x2njKyA7k6v2/BIb6yvxBlxl5NgIL+Z2anRH0aVO1fqAuKLSGi1Se2j3LPJf3jctZeXyy4mhjAqjRJ63LAjjJePIyymF0QkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519372; c=relaxed/simple;
	bh=3+J5SEcT8dHVls6g1jK8kLR4OGwC8NHQ4PQHZnLnOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0UsXb7/azgPJfRvEQ2tc3xdLyCVh1nC2obBnPw73HWhsBdRDQO7fWPmKoiiQr5tXg8R0JCv1EJQadqyDKBp7CEO3viR+xacaHHcewwyR6GbSCE7A9LZvgt0WaM7M6jKIoZgIaqaRNJ2ijl5xpAMgV7Fg6gXCvgOLS6gDE5RmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zgxhCvCb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so2291770a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714519369; x=1715124169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBEwuZOf8/9Uojdx5GOkjRwNcM8rLA4lPKNBWxieWU0=;
        b=zgxhCvCbZ1BolknuVXh99we1MW1ea4vG2nqtg/SvQx0usmY/t1wPi8sUBXSQTEh4gH
         KYzYOGinV46phAvYNx8mfFRiXyuquG3m9n4q19m3iO7Ge0zYEiaUZvebzKnt8JABI5Tk
         aPb3RzXSx3/ULiQn9XtBE/jFm9TX3VpjeVSXNw7Z7u+YVRmt4xkr3lcvBJL/wzwnx0I1
         QlY6uF2th+PmeKU1/11OZRF2aervdRr2AqD8sc5r5dhBqtOg8bf3WznoAsK1mzqgoSSj
         p/Zk2zSjpHu9+gK9+Ct/DM2RmXaWTPQ/95ClC1uBXwH6yB8/kbiO0IqbayeegitnZLQ8
         4Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714519369; x=1715124169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBEwuZOf8/9Uojdx5GOkjRwNcM8rLA4lPKNBWxieWU0=;
        b=mQOp+pyZcf9+MiiNuPENuyf1jlr0eG4LcRF9x8vLIC4n4mYevllsYIHMHXEsD1S0va
         4Aj1ksXIsNUwudaUxjMi55HCT3+Km/EfqVJGa7fHBE5fLrHx8BZuIHmDtK2WVNLaoj6K
         kqXhee1/K+Ez+E9wLmAEPA/GODG0LSGyVmmmHmBhyedSQjimxo1xnp8s+pJX4sbvwhQS
         GYG/lb5BeRw/1YUqOg5yp+GdGp8jowOx9OiRK2FuQwhiAEpckIOpaDKR1EceI+davXAI
         +aB0eVZE1ZEZsfyAz+Vn5JeoR53cYOveOf3zeANswcw4+LJCYXrhefpSRfbr/IO2BRCu
         1SZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZX4zmNx22PrIvmyQyJos2h18epYSWVQ22VdPkZ4Cg2LBU3xnAGDx2+xAMqVn++FCwrhf2meqUAUgwgAKCgOu4NrtqlYfkd+OIE2HGuw==
X-Gm-Message-State: AOJu0YyCvm6FH80/hMqQkaZ6zAbL8jJVhr77Wm8iLYyBuPYDAjwckl2M
	ar3WH6q878HqgXA84poTiHhc7nFyb/y18MDbGA06c/PPUG/V2Ti5+7FN7Ct2Ai0=
X-Google-Smtp-Source: AGHT+IGm1qFmLvBxg4LsZyADWtZeMg00JHydgEujmJ7+LPBggPxSY+4NBjiVSvco0Bs5XeNkzytUHA==
X-Received: by 2002:a17:90a:3048:b0:2b2:6339:b1a3 with SMTP id q8-20020a17090a304800b002b26339b1a3mr1108659pjl.37.1714519369036;
        Tue, 30 Apr 2024 16:22:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id oe7-20020a17090b394700b002a78c2e21b3sm152478pjb.20.2024.04.30.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:22:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1wo9-00Giue-2p;
	Wed, 01 May 2024 09:22:45 +1000
Date: Wed, 1 May 2024 09:22:45 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Message-ID: <ZjF9RVetf+Xt70BX@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-9-john.g.garry@oracle.com>

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

....

> @@ -783,3 +791,45 @@ xfs_inode_validate_cowextsize(
>  
>  	return NULL;
>  }
> +
> +/* Validate the forcealign inode flag */
> +xfs_failaddr_t
> +xfs_inode_validate_forcealign(
> +	struct xfs_mount	*mp,
> +	uint16_t		mode,

	umode_t			mode,

> +	uint16_t		flags,
> +	uint32_t		extsize,
> +	uint32_t		cowextsize)

extent sizes are xfs_extlen_t types.

> +{
> +	/* superblock rocompat feature flag */
> +	if (!xfs_has_forcealign(mp))
> +		return __this_address;
> +
> +	/* Only regular files and directories */
> +	if (!S_ISDIR(mode) && !S_ISREG(mode))
> +		return __this_address;
> +
> +	/* Doesn't apply to realtime files */
> +	if (flags & XFS_DIFLAG_REALTIME)
> +		return __this_address;

Why not? A rt device with an extsize of 1 fsb could make use of
forced alignment just like the data device to allow larger atomic
writes to be done. I mean, just because we haven't written the code
to do this yet doesn't mean it is an illegal on-disk format state.

> +	/* Requires a non-zero power-of-2 extent size hint */
> +	if (extsize == 0 || !is_power_of_2(extsize) ||
> +	    (mp->m_sb.sb_agblocks % extsize))
> +		return __this_address;

Please do these as indiviual checks with their own fail address.
That way we can tell which check failed from the console output.
Also, the agblocks check is already split out below, so it's being
checked twice...

Also, why does force-align require a power-of-2 extent size? Why
does it require the extent size to be an exact divisor of the AG
size? Aren't these atomic write alignment restrictions? i.e.
shouldn't these only be enforced when the atomic writes inode flag
is set?

> +	/* Requires agsize be a multiple of extsize */
> +	if (mp->m_sb.sb_agblocks % extsize)
> +		return __this_address;
> +
> +	/* Requires stripe unit+width (if set) be a multiple of extsize */
> +	if ((mp->m_dalign && (mp->m_dalign % extsize)) ||
> +	    (mp->m_swidth && (mp->m_swidth % extsize)))
> +		return __this_address;

Again, this is an atomic write constraint, isn't it?

> +	/* Requires no cow extent size hint */
> +	if (cowextsize != 0)
> +		return __this_address;

What if it's a reflinked file?

.....

> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d0e2cec6210d..d1126509ceb9 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
>  		di_flags2 |= XFS_DIFLAG2_DAX;
>  	if (xflags & FS_XFLAG_COWEXTSIZE)
>  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> +	if (xflags & FS_XFLAG_FORCEALIGN)
> +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>  
>  	return di_flags2;
>  }
> @@ -1146,6 +1148,22 @@ xfs_ioctl_setattr_xflags(
>  	if (i_flags2 && !xfs_has_v3inodes(mp))
>  		return -EINVAL;
>  
> +	/*
> +	 * Force-align requires a nonzero extent size hint and a zero cow
> +	 * extent size hint.  It doesn't apply to realtime files.
> +	 */
> +	if (fa->fsx_xflags & FS_XFLAG_FORCEALIGN) {
> +		if (!xfs_has_forcealign(mp))
> +			return -EINVAL;
> +		if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
> +			return -EINVAL;
> +		if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> +					FS_XFLAG_EXTSZINHERIT)))
> +			return -EINVAL;
> +		if (fa->fsx_xflags & FS_XFLAG_REALTIME)
> +			return -EINVAL;
> +	}

What about if the file already has shared extents on it (i.e.
reflinked or deduped?)

Also, why is this getting checked here instead of in
xfs_ioctl_setattr_check_extsize()?


> @@ -1263,7 +1283,19 @@ xfs_ioctl_setattr_check_extsize(
>  	failaddr = xfs_inode_validate_extsize(ip->i_mount,
>  			XFS_B_TO_FSB(mp, fa->fsx_extsize),
>  			VFS_I(ip)->i_mode, new_diflags);
> -	return failaddr != NULL ? -EINVAL : 0;
> +	if (failaddr)
> +		return -EINVAL;
> +
> +	if (new_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
> +		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
> +				VFS_I(ip)->i_mode, new_diflags,
> +				XFS_B_TO_FSB(mp, fa->fsx_extsize),
> +				XFS_B_TO_FSB(mp, fa->fsx_cowextsize));
> +		if (failaddr)
> +			return -EINVAL;
> +	}

Oh, it's because you're trying to use on-disk format validation
routines for user API validation. That, IMO, is a bad idea because
the on-disk format and kernel/user APIs should not be tied
together as they have different constraints and error conditions.

That also explains why xfs_inode_validate_forcealign() doesn't just
get passed the inode to validate - it's because you want to pass
information from the user API to it. This results in sub-optimal
code for both on-disk format validation and user API validation.

Can you please separate these and put all the force align user API
validation checks in the one function?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

