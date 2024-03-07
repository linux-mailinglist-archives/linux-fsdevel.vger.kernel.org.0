Return-Path: <linux-fsdevel+bounces-13943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F2875A13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DBA1F22CBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F713E7C9;
	Thu,  7 Mar 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ//6vhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803E13B795;
	Thu,  7 Mar 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849775; cv=none; b=TAy3eU9xb7Fn/+KF80L08I00KoXySu8ohju0noseJpf+BvR+dn2ddLdAwL/NRPbN6C5MyltYo3Dodj3BteCv2BMb3SN7VCdt/AWmZinKIzahIN9c7B8MX2m7EKTlOCmspsglJgpS8qY5ReeK6IEZJGt4PKkETYYwCBQ1ClKcCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849775; c=relaxed/simple;
	bh=LV4pi5ajwYL5ReY7L2XmcwO6GeLKkayNVMhEwFUWqG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsMK76KZyhdg7gyWgegTFkfEENrJnqGhCkrVD371UM5xNNeiuiMXKzBbnccQkxlZRZMyd/2A3Ar9hZE/w8Y/pxg4XfgSH+yl9z1nFLSoTZMI/s7RZfqD7Bko+hDh9V40lSgA7SLdGtFKcgHGEDM4HpfSIAJSJ3vVEcop3rR0umY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ//6vhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ED4C433C7;
	Thu,  7 Mar 2024 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849774;
	bh=LV4pi5ajwYL5ReY7L2XmcwO6GeLKkayNVMhEwFUWqG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ//6vhKRx2ySYUoq21k+jqZu0UhNLorzpTZO4wYqsDAMYEuD8MLW7OpUYNVMPQAM
	 YojJhgKjy+SI9NOoq0zFHev8WsAaGUJZ2ArweeWkyGCZwbXX3HQ3sD1UFIw3ajAFWA
	 1Ag3mXZzYET0ykGs4432Dxe9tzw/s2UutpW4wfGhBdzZQE7pb/IVjIzIzNbAhIJKlD
	 9TkYMIwX6E8xExWuel60n/BerVTjK/b0EJLsA6lOQmvK7H2nx3xU2mtymBuHcB61oq
	 Gm6XiNq0yQ5Vq0ibfedJCplZhhe5dXtarQp8PNCAP54bc9m/QKfVAnJeG0FwfKTyOz
	 6yU2zrMvJVJDQ==
Date: Thu, 7 Mar 2024 14:16:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 24/24] xfs: enable ro-compat fs-verity flag
Message-ID: <20240307221614.GZ1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-26-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-26-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:47PM +0100, Andrey Albershteyn wrote:
> Finalize fs-verity integration in XFS by making kernel fs-verity
> aware with ro-compat flag.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_format.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 3ce2902101bc..be66f0ab20cb 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -355,10 +355,11 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>  #define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
> -		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
> -		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> -		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
> -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> +		(XFS_SB_FEAT_RO_COMPAT_FINOBT  | \
> +		 XFS_SB_FEAT_RO_COMPAT_RMAPBT  | \
> +		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
> +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \

You might as well add a few more spaces here  ^^ for future expansion
if you're going to reflow the whole macro definition.

(or just leave it alone which is what I would've done)

Up to you; the rest is
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		 XFS_SB_FEAT_RO_COMPAT_VERITY)
>  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>  static inline bool
>  xfs_sb_has_ro_compat_feature(
> -- 
> 2.42.0
> 
> 

