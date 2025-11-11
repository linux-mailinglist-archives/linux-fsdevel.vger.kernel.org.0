Return-Path: <linux-fsdevel+bounces-67858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C317FC4C326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74FEA4F1BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772932D6E53;
	Tue, 11 Nov 2025 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT1YKP0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FA34D39F;
	Tue, 11 Nov 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847597; cv=none; b=QIEY2pLn1YWx4/YY2udHLE4jwFO8w1CGxOoaBpBdlAXj9F4r9OgqlTobXehWAJwo0AWNmn31tU96dLcSCGzS0o8+Xa+8HpMTcafLBkJ811LlTEW4E+H4S9kbpeWnVn6R1wYSTQj4uLd9zXWYO8HeYorZE+ylbWISPL0CwZCNnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847597; c=relaxed/simple;
	bh=6vLdCVtUOmwT2xBG2CthgZi9Ig8JOsV5A1e4sciMj58=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=olwwzqheRfvc4e9iUwdXTH5+JhjJP1JBC97xzxJ1xefQX7YegycUQqgR8J5soQDVcGoLsYROpBYjv6onSucpOkjt36PAMjg2Oxm2IWoLxATZEg3xXabYuMkBOEM0ipystBH36v11SimcXa5SwHIURGnuF7auSkb3fFzzvTuz8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT1YKP0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EFAC116D0;
	Tue, 11 Nov 2025 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847597;
	bh=6vLdCVtUOmwT2xBG2CthgZi9Ig8JOsV5A1e4sciMj58=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GT1YKP0Dqo8Ysx1f1jn1aJnzunt/m+vgmkHza86dvdju2EoOZI6rbkPd7I+ZcBeM+
	 sMRoB0c30MgD2v1Yb5EZikViuPNT9qU6D1zpwh1o3OD7j4ZzdXpPAIauOb57UMw4bv
	 I60wtyPt3IyQJygJ4dixY3dw68KJmjTTO1siXWRgIfdzeLxoIP8G2HrfqFcRWayLag
	 434bWzG4C5dIXX3cv0RlRRd1dhjWeDIx9KMPU1TowHWPucntp2dQsJT9/iu1QfqbYc
	 Y/H5S/PxMIu45+cpnJF56ZFcZiXa6QAttdqqbIZMPl+jb91U6hNFBKXExqdER7dwwx
	 ib+6wzq9EnUzA==
Content-Type: multipart/mixed; boundary="===============1014260008914052501=="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
In-Reply-To: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
From: bot+bpf-ci@kernel.org
To: viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,brauner@kernel.org,jack@suse.cz,raven@themaw.net,miklos@szeredi.hu,neil@brown.name,a.hindborg@kernel.org,linux-mm@kvack.org,linux-efi@vger.kernel.org,ocfs2-devel@lists.linux.dev,kees@kernel.org,rostedt@goodmis.org,gregkh@linuxfoundation.org,linux-usb@vger.kernel.org,paul@paul-moore.com,casey@schaufler-ca.com,linuxppc-dev@lists.ozlabs.org,john.johansen@canonical.com,selinux@vger.kernel.org,borntraeger@linux.ibm.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 07:53:16 +0000 (UTC)

--===============1014260008914052501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 47cfbe41f..43dcd39b7 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c

[ ... ]

> @@ -2323,6 +2316,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
>  {
>  	struct ffs_epfile *epfile, *epfiles;
>  	unsigned i, count;
> +	int err;
>
>  	count = ffs->eps_count;
>  	epfiles = kcalloc(count, sizeof(*epfiles), GFP_KERNEL);
> @@ -2339,12 +2333,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
>  			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
>  		else
>  			sprintf(epfile->name, "ep%u", i);
> -		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
> -						 epfile,
> -						 &ffs_epfile_operations);
> -		if (!epfile->dentry) {
> +		err = ffs_sb_create_file(ffs->sb, epfile->name,
> +					 epfile, &ffs_epfile_operations);
> +		if (err) {
>  			ffs_epfiles_destroy(epfiles, i - 1);
> -			return -ENOMEM;
> +			return err;
>  		}
>  	}
>
> @@ -2355,13 +2348,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
>  static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
>  {
>  	struct ffs_epfile *epfile = epfiles;
> +	struct dentry *root = epfile->ffs->sb->s_root;

Can this dereference uninitialized memory in ffs_epfiles_destroy()?

When ffs_epfiles_create() calls ffs_epfiles_destroy(epfiles, i - 1) after
the first ffs_sb_create_file() call fails (when i=1), it passes count=0.
The initialization loop starts at i=1, so epfiles[0].ffs is never
initialized. The kcalloc() zeros the memory, making epfiles[0].ffs NULL.

The new code unconditionally dereferences epfile->ffs->sb->s_root before
the loop, causing a NULL pointer dereference when count=0. The old code
was safe because the dereference only happened inside the loop.

>
>  	for (; count; --count, ++epfile) {
>  		BUG_ON(mutex_is_locked(&epfile->mutex));
> -		if (epfile->dentry) {
> -			simple_recursive_removal(epfile->dentry, NULL);
> -			epfile->dentry = NULL;
> -		}
> +		simple_remove_by_name(root, epfile->name, NULL);
>  	}
>
>  	kfree(epfiles);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19257803162

--===============1014260008914052501==--

