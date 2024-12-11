Return-Path: <linux-fsdevel+bounces-37080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1FC9ED3D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE58188A0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61776209F4B;
	Wed, 11 Dec 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT+sjqve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F30207A1B;
	Wed, 11 Dec 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938830; cv=none; b=C2YqWeUmqrV70YBFEzFS/lmniYxfzuT/tsCBqVqOZxLsQTx9iaDXt08z6SVLhiS670eDokQPsaTUAx5huaxllvPcmlGjrMhv4P1nIVwVPxB31VcidamYtInb68A2KsJVnd9C0WlKP0vy5EynMmXVAk8PUbvpkhgmM6MrD8JuNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938830; c=relaxed/simple;
	bh=2+F/X1bbGIHQ/mssm4ic+1dPk7ifq8G4W/p2zLLRRpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn36fNkdfYrYf00u8uWPhy7j0NAiWUdhtOkTtXKYrkYnX1CjA1I4KwL1sJlCEQxo7Xc4EjOon8WZTTtZRGhido+DiA0b+D2/5HuEfGg17bMp34SLtTtvrmd98r+WT5s6bqJG41Wg1Pej7QZYBUFH2VHt8WV9Toq+pSGiV/LUM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT+sjqve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265AAC4CED4;
	Wed, 11 Dec 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733938830;
	bh=2+F/X1bbGIHQ/mssm4ic+1dPk7ifq8G4W/p2zLLRRpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VT+sjqveVKdK/NfGq4n5cyb2pqWjeE9nbhy4BqvoVAvd3BJ+S+Y7ekVeIz++JHo3H
	 9gk0J3lAkoB2xAlkUVp6X39V+/6170gRQNWynBhSltC/k0XBRY7X42pcIXnk4o5Gdr
	 Kxx9swpTtNz1/oIHcsX7+9VbE84QO6yqt8a1z7i39VsQnYBnzjpuzXWIgjJE8aieDK
	 z8mi+1JZanjpIeTKsyfU5JpKb/Ns0si0VbxtdBBZvcogq34A905nR77sH+/93gZNge
	 p2+EmWU6FIwxnykdMOxvlacAUCpz+wfbv56G6Pw9jYsk41IYJBJG8o/nFg83zyfShK
	 5qj57TQhY4ZSg==
Date: Wed, 11 Dec 2024 09:40:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bingwu Zhang <xtex@envs.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>,
	Bingwu Zhang <xtex@aosc.io>, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	~xtex/staging@lists.sr.ht
Subject: Re: [PATCH] Documentation: filesystems: fix two misspells
Message-ID: <20241211174029.GC6698@frogsfrogsfrogs>
References: <20241208035447.162465-2-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208035447.162465-2-xtex@envs.net>

On Sun, Dec 08, 2024 at 11:54:47AM +0800, Bingwu Zhang wrote:
> From: Bingwu Zhang <xtex@aosc.io>
> 
> This fixes two small misspells in the filesystems documentation.
> 
> Signed-off-by: Bingwu Zhang <xtex@aosc.io>

Yep, typoes happun, thanks for the patch.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> I found these typos when learning about OverlayFS recently.
> ---
>  Documentation/filesystems/iomap/operations.rst | 2 +-
>  Documentation/filesystems/overlayfs.rst        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index ef082e5a4e0c..2c7f5df9d8b0 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -104,7 +104,7 @@ iomap calls these functions:
>  
>      For the pagecache, races can happen if writeback doesn't take
>      ``i_rwsem`` or ``invalidate_lock`` and updates mapping information.
> -    Races can also happen if the filesytem allows concurrent writes.
> +    Races can also happen if the filesystem allows concurrent writes.
>      For such files, the mapping *must* be revalidated after the folio
>      lock has been taken so that iomap can manage the folio correctly.
>  
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 4c8387e1c880..d2a277e3976e 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -156,7 +156,7 @@ A directory is made opaque by setting the xattr "trusted.overlay.opaque"
>  to "y".  Where the upper filesystem contains an opaque directory, any
>  directory in the lower filesystem with the same name is ignored.
>  
> -An opaque directory should not conntain any whiteouts, because they do not
> +An opaque directory should not contain any whiteouts, because they do not
>  serve any purpose.  A merge directory containing regular files with the xattr
>  "trusted.overlay.whiteout", should be additionally marked by setting the xattr
>  "trusted.overlay.opaque" to "x" on the merge directory itself.
> 
> base-commit: 7503345ac5f5e82fd9a36d6e6b447c016376403a
> -- 
> 2.47.1
> 

