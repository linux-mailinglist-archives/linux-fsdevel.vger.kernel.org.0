Return-Path: <linux-fsdevel+bounces-24592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F3940E3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC36B28180
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757AE197A7F;
	Tue, 30 Jul 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLshH0bW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF070196C9B;
	Tue, 30 Jul 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332982; cv=none; b=JaFW4n82vlbmqj8xCvB4/opWXnlz5GeTL3r+CU3bjiA/2yf/Ha3ldSe2tarohVqsVv3eACwnZDQn0j17F6Sah3KSuhiGz9L46oCzgc8M59C5fQ2kVcMQepP2kAvqwFTy8Vx4F6VcdQDjaq5vjFDkN/oTglaCjb5+jXyJuGhLQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332982; c=relaxed/simple;
	bh=K+iZkNmIViomAg24z3v6dg2ldSKrDHEShkDzsj4OSPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0INoybVzJdXKSQJEsiBHTwci1aAgZLeZ2BiJi1SZqeLaCXlCXs9Ude2pyENPFvzNGD23svTrj30pONNbXPAf8OqyHlupA7FfhMA3bvNnIk012hn6M/nhzBn4EjBFzR+E0h4xTJ5lJDJbvjn0hHnLv2p8XZqXvMK9HspBZRmMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLshH0bW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4623AC4AF0B;
	Tue, 30 Jul 2024 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722332982;
	bh=K+iZkNmIViomAg24z3v6dg2ldSKrDHEShkDzsj4OSPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLshH0bWGveXFScmbfagrf+5Rlbb6V9sI7oEJXqwXvDLnZ64gldWOq9MCDl5qZ0nD
	 b3YCQno4d3bZ1xQKYB+GUWMVDyxYbzToI5nARvkR+EkUIWmVaPkcIkajDaUPEkA9QM
	 ekBJ9xmTs3ARKeU7vkqfcKaGn3rR5UqqcgZbL1MB3qeTpbn+5IaIRKAssgJ9GByJc+
	 vT5yNfXH8/9uIGwNZLxw+ko9BY6+TvvvOBGQQDYReUQdsetQbRp34l0r7pxS+B1qF1
	 20UbWaCsOE0k3fClSdoiPblC9KDd41WYRMjNKLmohp4T3j/KG8UG7mi3Hu0fhjtR+6
	 yDQbbDzhCeN/Q==
Date: Tue, 30 Jul 2024 11:49:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Message-ID: <20240730-humpelt-deklamieren-eeefe1d623a9@brauner>
References: <20240730085856.32385-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730085856.32385-1-olaf@aepfle.de>

On Tue, Jul 30, 2024 at 10:58:13AM GMT, Olaf Hering wrote:
> If no page could be allocated, an error pointer was used as format
> string in pr_warn.
> 
> Rearrange the code to return early in case of OOM. Also add a check
> for the return value of d_path. The API of that function is not
> documented. It currently returns only ERR_PTR values, but may return
> also NULL in the future. Use PTR_ERR_OR_ZERO to cover both cases.
> 
> Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  fs/namespace.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 328087a4df8a..539d4f203a20 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2922,7 +2922,14 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>  	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
>  	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
>  		char *buf = (char *)__get_free_page(GFP_KERNEL);
> -		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> +		char *mntpath;
> +		
> +		if (!buf)
> +			return;
> +
> +		mntpath = d_path(mountpoint, buf, PAGE_SIZE);
> +		if (PTR_ERR_OR_ZERO(mntpath))

This needs to be IS_ERR_OR_NULL().

> +			goto err;

We should still warn when decoding the mountpoint fails. I'll just amend
your patch to something like:

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..0f2f140aaf05 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2921,16 +2921,21 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
        if (!__mnt_is_readonly(mnt) &&
           (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
           (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
-               char *buf = (char *)__get_free_page(GFP_KERNEL);
-               char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
+               char *buf, *mntpath = NULL;
+
+               buf = (char *)__get_free_page(GFP_KERNEL);
+               if (buf)
+                       mntpath = d_path(mountpoint, buf, PAGE_SIZE);
+               if (IS_ERR_OR_NULL(mntpath))
+                       mntpath = "(unknown)";

                pr_warn("%s filesystem being %s at %s supports timestamps until %ptTd (0x%llx)\n",
                        sb->s_type->name,
                        is_mounted(mnt) ? "remounted" : "mounted",
                        mntpath, &sb->s_time_max,
                        (unsigned long long)sb->s_time_max);
-
-               free_page((unsigned long)buf);
+               if (buf)
+                       free_page((unsigned long)buf);
                sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
        }
 }

