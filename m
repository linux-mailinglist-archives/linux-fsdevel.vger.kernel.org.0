Return-Path: <linux-fsdevel+bounces-65866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234DC1282E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40769462E52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E821FF33;
	Tue, 28 Oct 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6YozAOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAFC8E6;
	Tue, 28 Oct 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614141; cv=none; b=ptdNDJQTmYVaQ3q/XfCTyGQpAQVV7q29S26dlqyKrL1UW3AjMFtIRHQS2awGAkbLA4bTk/hQiOZZ6UsVLj6dTb8gm+bLgTfRhqE8lxPHb0mFAxCjaoasPCf8Nm5NuuB3HDlZvFv5pCYjqGZOkfW9q8OTsDOeMByM2/9e9B6YmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614141; c=relaxed/simple;
	bh=hZMNoT84NWTUnJ7xeU4dTqY3HFxtGS2LILZkNTb0rRQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SuaAJlU+8+wtlv2cYir/XSrDKdSFNWmlRLNZ04BIK5Ho1rnDONZUXZdA3YL72tGI8uElRwq0NdypU4wJPrtUWhVg71rwrQkguPq2wIvwVG+V1XxzHab9CDZkxbQxWFPvbCDRsBvlizXxiYtP05ZTgQ+/n8xHeVOKevJcbp+rblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6YozAOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D295C4CEF1;
	Tue, 28 Oct 2025 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614140;
	bh=hZMNoT84NWTUnJ7xeU4dTqY3HFxtGS2LILZkNTb0rRQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=D6YozAOSL4ftkP1327QSAIyotS32B0Q61n32u8VQuijuZFU6ZGCDkPw9rpPPx2X/d
	 jPdBfxTrUvESTVDaPBpKoau0kghcyTvqfhAUE3k343cWjmoS8FFpTh9ENMdhx9nay3
	 DpIjPkZUoV0H561FWIL4G9bQoY03UPf13yRixAe5Zt9eMV8Gg9vBvvlEJs3R6mVNCO
	 cVvt8FKZ0wSlX84xMC2Q/FN0g9SoZSGxUOEDkrBpSJf4YjLIn2OLuu/+O+RjNnQS67
	 Nrcaqwl12T0AYIYui6OyoRJCoaCd+Bb4jdUMSvGLZiwMDSCkJ2jeFyQBv/NGmnACJ0
	 z5mJ/sXQZgy2A==
Content-Type: multipart/mixed; boundary="===============3821749126373374714=="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <022fbcc8127b3bcf15731de7956ca892619da224487161febb9ef1ed4c71597a@mail.kernel.org>
In-Reply-To: <20251028004614.393374-24-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-24-viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 23/50] convert spufs
From: bot+bpf-ci@kernel.org
To: viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,brauner@kernel.org,jack@suse.cz,raven@themaw.net,miklos@szeredi.hu,neil@brown.name,a.hindborg@kernel.org,linux-mm@kvack.org,linux-efi@vger.kernel.org,ocfs2-devel@lists.linux.dev,kees@kernel.org,rostedt@goodmis.org,gregkh@linuxfoundation.org,linux-usb@vger.kernel.org,paul@paul-moore.com,casey@schaufler-ca.com,linuxppc-dev@lists.ozlabs.org,john.johansen@canonical.com,selinux@vger.kernel.org,borntraeger@linux.ibm.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 01:15:38 +0000 (UTC)

--===============3821749126373374714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 0e359e5d712e3abcf8056b43da12f092c37e9f21
Author: Al Viro <viro@zeniv.linux.org.uk>

convert spufs

This commit converts spufs to use d_make_persistent() instead of d_add()
and d_instantiate(). The conversion includes making dput() unconditional
in callers and changing from kill_litter_super to kill_anon_super.

> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> index 7ec60290a..f21f7a76e 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c

[ ... ]

> @@ -241,11 +240,10 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
>
>  	inode_lock(inode);
>
> -	dget(dentry);
>  	inc_nlink(dir);
>  	inc_nlink(inode);
>
> -	d_instantiate(dentry, inode);
> +	d_make_persistent(dentry, inode);

[ ... ]

> @@ -479,10 +477,9 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
>
> -	d_instantiate(dentry, inode);
> -	dget(dentry);
>  	inc_nlink(dir);
>  	inc_nlink(d_inode(dentry));
> +	d_make_persistent(dentry, inode);
>  	return ret;

In spufs_mkgang(), can this call inc_nlink(d_inode(dentry)) before
d_make_persistent() instantiates the dentry? The dentry is not
instantiated until d_make_persistent() is called, so d_inode(dentry)
returns NULL here.

In the old code, d_instantiate() was called first, then
inc_nlink(d_inode(dentry)). For comparison, spufs_mkdir() uses
inc_nlink(inode) directly instead of inc_nlink(d_inode(dentry)).

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `convert spufs`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18860600716

--===============3821749126373374714==--

