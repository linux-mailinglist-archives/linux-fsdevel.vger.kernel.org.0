Return-Path: <linux-fsdevel+bounces-27541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D849624C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9761E1C23B6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42016BE22;
	Wed, 28 Aug 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZfrkwV2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B316B72B;
	Wed, 28 Aug 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840604; cv=none; b=N0AcIjVSkr0+hWinB1vZ5wDnda8KPJfSKV6iQXVD9OR+L9M8ufhRSptOMLYKaF/KjgiPuaChEurA0N9xZjE3ey3bETYL7MKDFjp9FKRnmahQv4iquubyC42DiZtxsHghK1K/i5zLnAcBV3iCcG+1vs4NsxGLyP+lvLO9Jdl2FZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840604; c=relaxed/simple;
	bh=jZulvSwUvL0RBD5tR1dzs5oCNHfaZeIqBH36bEpr12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSLwe8t6QmwXRpSLSEgdP0kkEcGMuXyw916C2V0V/JEYhY06+roIKR+BPvQP6+l2Yig7JF+nS+O5pltcJ5sQk092y5VBLf7XKjGeSEYk7r43+BD/TEVKidW+fmWD3eMRfWrpUQ2CfxmnPgnTo/QMoGhIADYOoNMrcPxjIxCtvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZfrkwV2m; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wv0qV4XrYz9tN7;
	Wed, 28 Aug 2024 12:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724840598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWlKvbs4DhzdX31c5CJtR5Iz/yyoG8dSGXOKM5gJUNg=;
	b=ZfrkwV2mXn+V6sCuyjaxrlW2tbKWDXcdLWdn4EU/gPxOES6wcS4bRJqKAfe/Q8elUMIZXu
	Pen35QPjeev1L4FIOhcWpmGP5xd9nR/l41+ECQ3CVFompdCq4KoKgrVgRt1btPvMTeKtzW
	/V6KYy2RQjYbJe6eoHhcIMTisMrUZWX4uC+U8hEFX3X6lJ1OAFr+GKFv7Sqn7uNxJPE/e6
	Cqr07VcqqS1BH43K0dVY3fvTDtdTJ/kyV91W9OL2UgjVkHgbIQGWMrzYlX4h/VM5qtXcU+
	For/z/L9mkbRY54OppPyVBic2gu9Km4S5SX7QUMiUkVOy3cZ3S193Dn1LelAwg==
Date: Wed, 28 Aug 2024 10:23:15 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <20240828102315.hagdq75c6wkmfuy2@quentin>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>

On Tue, Aug 27, 2024 at 04:15:05PM -0700, Nathan Chancellor wrote:
> When building for a 32-bit architecture, where 'size_t' is 'unsigned
> int', there is a warning due to use of '%ld', the specifier for a 'long
> int':
> 
>   In file included from fs/xfs/xfs_linux.h:82,
>                    from fs/xfs/xfs.h:26,
>                    from fs/xfs/xfs_super.c:7:
>   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
>   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
>         |                                                        ~~~~~~~~~~~~~~
>         |                                                        |
>         |                                                        size_t {aka unsigned int}
>   ...
>   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         |                                                        ~~^
>         |                                                          |
>         |                                                          long int
>         |                                                        %d
> 
> Use the proper 'size_t' specifier, '%zu', to resolve the warning.
> 
> Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 242271298a33..e8cc7900911e 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1651,7 +1651,7 @@ xfs_fs_fill_super(
>  
>  		if (mp->m_sb.sb_blocksize > max_folio_size) {
>  			xfs_warn(mp,
> -"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> +"block size (%u bytes) not supported; Only block size (%zu) or less is supported",
>  				mp->m_sb.sb_blocksize, max_folio_size);
>  			error = -ENOSYS;
>  			goto out_free_sb;
> 
> ---
> base-commit: f143d1a48d6ecce12f5bced0d18a10a0294726b5
> change-id: 20240827-xfs-fix-wformat-bs-gt-ps-967f3aa1c142
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

-- 
Pankaj Raghav

