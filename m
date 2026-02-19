Return-Path: <linux-fsdevel+bounces-77720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDOdKJI0l2kCvwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:04:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C51607B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D327E30137AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8615348465;
	Thu, 19 Feb 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsKtkf+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746921A444
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517069; cv=none; b=EOC/yP7oAF123iGWawnXYBRwhz61Up6sfsNI17BfghkfE8OJUpQTCGisXvM248vX8uwXye6HhlOwLJaGvWuQioNDkPp6de45SabfZVhG5LWIV1uX9Pibcc07fPlJpJgaw18WJ1cw5/ImLH8nRSfCGDKq1ASftvb++falWekcbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517069; c=relaxed/simple;
	bh=PzFTL48OwA5tmWr6xRQlqoPXbP+mZjv9UaKGo7pLMR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U32hU7QOCjZBKUQz8tKAT2suJ2dVFhnek9Z8nBtaRBBz1oyoe+sAGNDCsU1/qiKbvL9xWE3fvD5niA5X0ZXdfqMBnO9ApijL/UDfjYoUPGDNyVXekl7ti5ToMMYMgJs+EENW/LsBDjbnQx24LEjJ9KLnCzAtANfJzHnlOPmCoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsKtkf+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEB6C4CEF7;
	Thu, 19 Feb 2026 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771517069;
	bh=PzFTL48OwA5tmWr6xRQlqoPXbP+mZjv9UaKGo7pLMR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsKtkf+o5JL+OsNsDQXO6+J4YuhiWrn/2ZIJXYOtT7A6ETJdtwPmDqBOYL1H6gUbX
	 WxT+aaNZJ0qSG9+oF4MwWHVCiQEaPSLqnSdlmJFTH1IMY0uGllxLIIi5PMLOx0S4xU
	 LDvU+DBLr1xj3CcVF/EMnZgC+DJCA6CKSKDxmYD4gYGdjNw3cvR+nCTBOHFhw8/c9o
	 MqmHE1Ot8eEoU0459Et1notA7IxGf6ZCnYtCNWcSyTksyTqCsPy2Xbz5pIRmQjylcf
	 M3sjK+enAjnfI+AMvpK7nfYbSeDh1NX2awLYNFshFk4uXO7bmzNQZAsXCQBq60tkWb
	 x3TiYM8lgs2kw==
Date: Thu, 19 Feb 2026 08:04:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs: remove fsparam_path / fs_param_is_path
Message-ID: <20260219160428.GQ6467@frogsfrogsfrogs>
References: <20260219065014.3550402-1-hch@lst.de>
 <20260219065014.3550402-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219065014.3550402-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77720-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A5C51607B9
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 07:50:03AM +0100, Christoph Hellwig wrote:
> These are not used anywhere even after the fs_context conversion is
> finished, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/mount_api.rst | 2 --
>  fs/fs_parser.c                          | 7 -------
>  include/linux/fs_parser.h               | 3 +--
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> index b4a0f23914a6..e8b94357b4df 100644
> --- a/Documentation/filesystems/mount_api.rst
> +++ b/Documentation/filesystems/mount_api.rst
> @@ -648,7 +648,6 @@ The members are as follows:
>  	fs_param_is_enum	Enum value name 	result->uint_32
>  	fs_param_is_string	Arbitrary string	param->string
>  	fs_param_is_blockdev	Blockdev path		* Needs lookup

Unrelated: should xfs be using fsparam_bdev for its logdev/rtdev mount
options?

Or, more crazily, should it grow logfd/rtfd options that use fsparam_fd?

This patch looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> -	fs_param_is_path	Path			* Needs lookup
>  	fs_param_is_fd		File descriptor		result->int_32
>  	fs_param_is_uid		User ID (u32)           result->uid
>  	fs_param_is_gid		Group ID (u32)          result->gid
> @@ -681,7 +680,6 @@ The members are as follows:
>  	fsparam_enum()		fs_param_is_enum
>  	fsparam_string()	fs_param_is_string
>  	fsparam_bdev()		fs_param_is_blockdev
> -	fsparam_path()		fs_param_is_path
>  	fsparam_fd()		fs_param_is_fd
>  	fsparam_uid()		fs_param_is_uid
>  	fsparam_gid()		fs_param_is_gid
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 79e8fe9176fa..b4cc4cce518a 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -361,13 +361,6 @@ int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_blockdev);
>  
> -int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
> -		     struct fs_parameter *param, struct fs_parse_result *result)
> -{
> -	return 0;
> -}
> -EXPORT_SYMBOL(fs_param_is_path);
> -
>  #ifdef CONFIG_VALIDATE_FS_PARSER
>  /**
>   * fs_validate_description - Validate a parameter specification array
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 961562b101c5..98b83708f92b 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -28,7 +28,7 @@ typedef int fs_param_type(struct p_log *,
>   */
>  fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
>  	fs_param_is_enum, fs_param_is_string, fs_param_is_blockdev,
> -	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
> +	fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
>  	fs_param_is_file_or_string;
>  
>  /*
> @@ -126,7 +126,6 @@ static inline bool fs_validate_description(const char *name,
>  #define fsparam_string(NAME, OPT) \
>  				__fsparam(fs_param_is_string, NAME, OPT, 0, NULL)
>  #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
> -#define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
>  #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
>  #define fsparam_file_or_string(NAME, OPT) \
>  				__fsparam(fs_param_is_file_or_string, NAME, OPT, 0, NULL)
> -- 
> 2.47.3
> 
> 

