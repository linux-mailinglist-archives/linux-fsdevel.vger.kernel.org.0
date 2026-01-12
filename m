Return-Path: <linux-fsdevel+bounces-73318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BED15843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07EA30422BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A3342CAE;
	Mon, 12 Jan 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtwRpFOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A7308F28;
	Mon, 12 Jan 2026 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255521; cv=none; b=pg9R5DlrdiB5p9Y9XJzI/GsRqwek9enP17bYgOYjXbxjDfILfC/ulWOTHxWJV/QE9Stl+8Uw4AZ59XpacHrG3DUyot5KyH754qGVjMlsNMnAa/yEMRCYofoYOsJK4E2NrHfUZb0o8wwszU6BGwjbl5eijLOOAxJitMATEU3IRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255521; c=relaxed/simple;
	bh=u8s/u5Yhn9cE4AVpOugH7lDoHICJqPX+v7DtyaVGx24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzMWPItxst4ismn1tjWA1saud3WxckefNQ56nAC3PDusRskT3/sNrfvV4W5sX2iqpmwAqAqdW7x4RdCd0vCU/Ic+eibfzI0LE1G4kbSjY57OWhCbB5hHzbNfMLGwuFx3Ef9Rq2bLJAj8/xnxQ/izhHMTZ+/C3ZSu6FW0+Dg3qBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtwRpFOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE00C116D0;
	Mon, 12 Jan 2026 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768255520;
	bh=u8s/u5Yhn9cE4AVpOugH7lDoHICJqPX+v7DtyaVGx24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtwRpFOznw7xKecinuYXfPky1rja2K0wiCuD+C0mCffkLTJnv0FIwqhtdRJmvvzQB
	 geWtexc+VJCMX4Grrk4wQHfPvBvjHN3imJWYh+AbKZEiGIqMVietIVpGityUPWFWd7
	 sXvtj9M6kPBo/LLMKGrARY08qxxQhDsAi3OwINL3NM/1quNEhZDkH7xi2N5N3DZkW6
	 ZLYxbHX3zkd2ycqo8o356pXlzFdrDLFaFJzBPHQBvDB5cAEkviu4gmfP/EEtCQ41j8
	 SkPzx9us8KsaQF7fLRdzk1uSQsfU11bPdhdiwm976Va5StSM+mijT57681wjnikH5B
	 EmYcK1jCn0fYw==
Date: Mon, 12 Jan 2026 14:05:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 2/22] fsverity: expose ensure_fsverity_info()
Message-ID: <20260112220520.GH15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <unedx6vzej4wyd2ieani54tvvubox2epnl4eghv4caykbzinef@g72j7l2hcufp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <unedx6vzej4wyd2ieani54tvvubox2epnl4eghv4caykbzinef@g72j7l2hcufp>

On Mon, Jan 12, 2026 at 03:49:57PM +0100, Andrey Albershteyn wrote:
> This function will be used by XFS's scrub to force fsverity activation,
> therefore, to read fsverity context.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/open.c         | 4 ++--
>  include/linux/fsverity.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 77b1c977af..956ddaffbf 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -350,7 +350,7 @@
>  	return 0;
>  }
>  
> -static int ensure_verity_info(struct inode *inode)
> +int fsverity_ensure_verity_info(struct inode *inode)

Looks mostly fine to me, but does fsverity_ensure_verity_info needs its
own EXPORT_SYMBOL_GPL() for when xfs is built as an external module?

--D

>  {
>  	struct fsverity_info *vi = fsverity_get_info(inode);
>  	struct fsverity_descriptor *desc;
> @@ -380,7 +380,7 @@
>  {
>  	if (filp->f_mode & FMODE_WRITE)
>  		return -EPERM;
> -	return ensure_verity_info(inode);
> +	return fsverity_ensure_verity_info(inode);
>  }
>  EXPORT_SYMBOL_GPL(__fsverity_file_open);
>  
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index b75e232890..16a6e51705 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -196,6 +196,8 @@
>  int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
>  void __fsverity_cleanup_inode(struct inode *inode);
>  
> +int fsverity_ensure_verity_info(struct inode *inode);
> +
>  /**
>   * fsverity_cleanup_inode() - free the inode's verity info, if present
>   * @inode: an inode being evicted
> 
> -- 
> - Andrey
> 
> 

