Return-Path: <linux-fsdevel+bounces-67859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455BC4C30B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A98E3B96BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F22EBDC0;
	Tue, 11 Nov 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8p0McGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A134D39F;
	Tue, 11 Nov 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847599; cv=none; b=UVfWh+hID1oMXG6ITJpTzxW4bu7HBwe+90T+LQzQYm9Ht8XJwVzMsQvHCclUu2ot7kv1hAGgZQRfSydFEeTZvHdDMq7PL7Ra0BGDpyvb+zqP/5B3/ildMjEk35JbAsNgP9Y3GN0NEDzG/tgWiD5VCfT6dKPjSxfSglgDp0NUK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847599; c=relaxed/simple;
	bh=7qxex0fb9sux6H6YiFyflQQ1fF27LToi81rAOC7nyJw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lTpg3aMoVowBQmm3doycj0FMjvpH+imPj/F5/lm/8Qj/ZevTLScD7gB6kRXtEytNxXGGJjyKHQh0nqN5qKixXvF0QwAIgA2DFoDGJjUtHFwafH6gxNV0TT8zsKzNAVea5HC8icCstY+ZzKpMmIa0YUnRbu78p0IM25/7OAlkPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8p0McGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73270C116B1;
	Tue, 11 Nov 2025 07:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847598;
	bh=7qxex0fb9sux6H6YiFyflQQ1fF27LToi81rAOC7nyJw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=o8p0McGbUBg/mt4W0NwniQY9deSF651afKOoP439t4jTJeKv5LTx9vea9SGEQP8si
	 Q+5a+sIU7/rr5zqsP+ur8SebApGAvWVYTCiHpEoBxnRS/ATLz92ZlOpzA+IPHvqxX7
	 dy4GVB4pVeP8wFW2h7PYHaYeO0gbrMbOZYKJPHlrur9uUuvNsp9xny9Zx+MXTS3GYV
	 cqyVrLtwlM6rSDu0Fgu90qu055/duQnw869B0CGPbEtwgor0ofWM7MG2wjg4jSiR0W
	 0z4Ylk8vrW16xqRUmM/x1Dj8l4LfK4kIc0/1RsgkaikoHSoF9wMUFwvk/QGdaVgMjc
	 CIoMYVMhdAYTw==
Content-Type: multipart/mixed; boundary="===============1170773288298516893=="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70d825699c6e0a7e6cb978fdefba5935d5a515702e22e732d5c2ad919cfe010b@mail.kernel.org>
In-Reply-To: <20251111065520.2847791-35-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-35-viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 34/50] selinuxfs: new helper for attaching files to tree
From: bot+bpf-ci@kernel.org
To: viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,brauner@kernel.org,jack@suse.cz,raven@themaw.net,miklos@szeredi.hu,neil@brown.name,a.hindborg@kernel.org,linux-mm@kvack.org,linux-efi@vger.kernel.org,ocfs2-devel@lists.linux.dev,kees@kernel.org,rostedt@goodmis.org,gregkh@linuxfoundation.org,linux-usb@vger.kernel.org,paul@paul-moore.com,casey@schaufler-ca.com,linuxppc-dev@lists.ozlabs.org,john.johansen@canonical.com,selinux@vger.kernel.org,borntraeger@linux.ibm.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 07:53:18 +0000 (UTC)

--===============1170773288298516893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index b39e919c2..f088776db 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c

[ ... ]

> @@ -1197,6 +1197,25 @@ static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
>  	return ret;
>  }
>
> +static struct dentry *sel_attach(struct dentry *parent, const char *name,
> +				 struct inode *inode)
> +{
> +	struct dentry *dentry = d_alloc_name(parent, name);
> +	if (unlikely(!dentry)) {
> +		iput(inode);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	d_add(dentry, inode);
> +	return dentry;
> +}
> +
> +static int sel_attach_file(struct dentry *parent, const char *name,
> +			   struct inode *inode)
> +{
> +	struct dentry *dentry = sel_attach(parent, name, inode);
> +	return PTR_ERR_OR_ZERO(dentry);
> +}

[ ... ]

> @@ -1887,31 +1887,23 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>  			unsigned long *ino)
>  {
> -	struct dentry *dentry = d_alloc_name(dir, name);
>  	struct inode *inode;
>
> -	if (!dentry)
> -		return ERR_PTR(-ENOMEM);
> -
>  	inode = sel_make_inode(dir->d_sb, S_IFDIR | S_IRUGO | S_IXUGO);
> -	if (!inode) {
> -		dput(dentry);
> +	if (!inode)
>  		return ERR_PTR(-ENOMEM);
> -	}
>
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
>  	inode->i_ino = ++(*ino);
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
> -	d_add(dentry, inode);
>  	/* bump link count on parent directory, too */
>  	inc_nlink(d_inode(dir));
> +
> +	return sel_attach(dir, name, inode);
>  }

Can this leak the parent directory's reference count? The parent inode's
link count is incremented with inc_nlink(d_inode(dir)) before calling
sel_attach(). When sel_attach()->d_alloc_name() fails and returns NULL,
sel_attach() correctly cleans up the child inode with iput() and returns
ERR_PTR(-ENOMEM). However, the parent directory's link count has already
been incremented and is never decremented on this error path.

In the original code, the parent link count increment happened after
d_add() succeeded, ensuring it only occurred when the full operation
completed successfully.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19257803162

--===============1170773288298516893==--

