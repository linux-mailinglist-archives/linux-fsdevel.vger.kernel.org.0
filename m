Return-Path: <linux-fsdevel+bounces-63128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67ABAEA42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 00:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07831941FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C5286410;
	Tue, 30 Sep 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2EleeKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4319C540;
	Tue, 30 Sep 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269863; cv=none; b=ZUZ3xHnSbqD+d0KlBSCpY2hbLex9byB02HevyIO7Af6Uz17MD8EfqDizhKKUPesuBfnVJRIEDcwb6kB6TWax/k9zfsi8DquQ73fYISOSkbNXUE46c3CqcyzKNv1OPDMyptyr3+2scBE3YFFm0hWuKS1qVKZXkvM+4P3/loMxTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269863; c=relaxed/simple;
	bh=OpwwMbhJZ2rP3NRKllcR4zXPav8iTuPDNfNUf+Ss5qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpCqlimvQO7NhdRfVYZ1grp7x44WmL4GHy11w8LQJoiVf7/6IAm5Ijmh+uaG7xVxAdQ5le/CFXaesajCkXXVjcafFkHSSRP4vkutYBpJvY8M+M50BC1G9jBkLDAB1SG5qILzQ+33VzMsQ1ia5yp554O4O9rZGEhmBZsvmOMgkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2EleeKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A1C4CEF0;
	Tue, 30 Sep 2025 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759269863;
	bh=OpwwMbhJZ2rP3NRKllcR4zXPav8iTuPDNfNUf+Ss5qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2EleeKZjQ1Omw1IsbFLaA1ULnAEHgUFQgnUl1id/tS1ccvWAEhAfEnNi7wuhNvJS
	 tndXrzAEXbjsk53JF44IC6455DjclVyhDtDnS7O5w8Zn9sPgOdEsT8REZeUGoj0d7o
	 4kcn89dLbrR8nqcacTt0klC9XYLBxOsfFVLSAztvlmZNAa+S4DePAWjLOuBDkRjCxX
	 KX9yS5m4kto3HVylOWHFl/3pDxOrG73oRaWJ8er5QHSbzrgP/GO/TWlEeBHlQZtGml
	 oj0yOzEX0sfDfyB7AJ4A0oatNkNndFfdAYtSlJtLYTi25FKiVsqIn7lQoWUzDy9t2o
	 elJrTZ+EPYGMw==
Date: Tue, 30 Sep 2025 15:04:22 -0700
From: Kees Cook <kees@kernel.org>
To: syzbot <syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] [mm?] WARNING in path_noexec (2)
Message-ID: <202509301457.30490A014C@keescook>
References: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>

On Tue, Sep 30, 2025 at 01:17:34PM -0700, syzbot wrote:
> Reported-by: syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6000 at fs/exec.c:119 path_noexec+0x1af/0x200 fs/exec.c:118

Christian, this is:

bool path_noexec(const struct path *path)
{
        /* If it's an anonymous inode make sure that we catch any shenanigans. */
        VFS_WARN_ON_ONCE(IS_ANON_FILE(d_inode(path->dentry)) &&
                         !(path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC));
        return (path->mnt->mnt_flags & MNT_NOEXEC) ||
               (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
}

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e5fd6f980000

I think is from the created fd_dma_buf. I expect this would fix it:


diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..6e2ab1a4560d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -189,6 +189,8 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx;
 
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	ctx = init_pseudo(fc, DMA_BUF_MAGIC);
 	if (!ctx)
 		return -ENOMEM;


Which reminds me, this still isn't landed either for secretmem:
https://lore.kernel.org/all/20250707171735.GE1880847@ZenIV/

-- 
Kees Cook

