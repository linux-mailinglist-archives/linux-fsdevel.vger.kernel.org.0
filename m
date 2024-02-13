Return-Path: <linux-fsdevel+bounces-11400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612A8536BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D652328ABA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE05FDD5;
	Tue, 13 Feb 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjmUU0Rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817265FDB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843738; cv=none; b=rfRMU/FFFS3dLGItB/96tczw13vmqJ07HxiFWXEJCPp5LiczweAxD6b++E/rN/3ppFG5MzVwOCaqikuBWGSUmvUdttaXKhyZoWHpzPc7RW3EwVq1kv+EhSYwD4NRELloMQI+zRBh95x1pFXFg5zYbTVY6XL47/yBfFzYmZsnO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843738; c=relaxed/simple;
	bh=TT7Zk2TAoQ2U/bfIyUAQK+tiaAfcVujoDsH0ScNP61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzFpno1AttqTWRwGkSFmkc0UZelW00kBUXmZ8HHBRSF+doW5F7+WElfdHv85WwHncZVDO5yWTQir0iP8ibHzMgAi3kKOnpH1uFfAk+LNZXMB9sawDoc/+KKUFgqPsjL+GBMMywAVgDr4W+lxMLmN8H7rj65zScvdbOnGJyMF6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjmUU0Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78845C433C7;
	Tue, 13 Feb 2024 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707843738;
	bh=TT7Zk2TAoQ2U/bfIyUAQK+tiaAfcVujoDsH0ScNP61k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjmUU0Rf+XMeNDKyKHHcPRK25km74LZXCjpZEgMYbUz5tqsUZ50s2pGHJe/Fy43bF
	 9V3kQFG4nrj54qu6sOqtH1K7xw6gQTn6GmWNUL0aXAFjs4WZWKFB4cLru6vTXd064C
	 EuqycLMpLoGS1JJoG/TwrzdDTCQMCSw5ZDVkpuSN6fpvqg/MSVfMxy7g3A/ws3rGeq
	 Ygl76fc8VMeNHdeMPshfPQ/vPmCTg4EsYadXcO+zx0arJTMYPrAgpkSQXojRz6+Zka
	 R9QMqz4QolE+iz46DZ8VN1RJrvsw2WjKOZubMd0kvMKtQyTb7BoLQjP+8ANfn3b/1U
	 SIB6yobrMqSgA==
Date: Tue, 13 Feb 2024 18:02:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 0/2] Move pidfd to tiny pseudo fs
Message-ID: <20240213-kippt-ambiente-9162a4f7b19b@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>

On Tue, Feb 13, 2024 at 05:45:45PM +0100, Christian Brauner wrote:
> Hey,
> 
> This moves pidfds from the anonymous inode infrastructure to a tiny
> pseudo filesystem. This has been on my todo for quite a while as it will
> unblock further work that we weren't able to do so far simply because of
> the very justified limitations of anonymous inodes. So yesterday I sat
> down and wrote it down.
> 
> Back when I added pidfds the concept was new (on Linux) and the
> limitations were acceptable but now it's starting to hurt us. And with
> the concept of pidfds having been around quite a while and being widely
> used this is worth doing. This makes it so that:
> 
> * statx() on pidfds becomes useful for the first time.
> * pidfds can be compared simply via statx() for equality.
> * pidfds have unique inode numbers for the system lifetime.
> * struct pid is now stashed in inode->i_private instead of
>   file->private_data. This means it is now possible to introduce
>   concepts that operate on a process once all file descriptors have been
>   closed. A concrete example is kill-on-last-close.
> * file->private_data is freed up for per-file options for pidfds.
> * Each struct pid will refer to a different inode but the same struct
>   pid will refer to the same inode if it's opened multiple times. In
>   contrast to now where each struct pid refers to the same inode. Even
>   if we were to move to anon_inode_create_getfile() which creates new
>   inodes we'd still be associating the same struct pid with multiple
>   different inodes.
> * Pidfds now go through the regular dentry_open() path which means that
>   all security hooks are called unblocking proper LSM management for
>   pidfds. In addition fsnotify hooks are called and allow for listening
>   to open events on pidfds.
> 
> The tiny pseudo filesystem is not visible anywhere in userspace exactly
> like e.g., pipefs and sockfs. There's no lookup, there's no inode
> operations in general, so nothing complex. It's hopefully the best kind
> of dumb there is. Dentries and inodes are always deleted when the last
> pidfd is closed.
> 
> I've made the new code optional and placed it under CONFIG_FS_PIDFD but
> I'm confident we can remove that very soon. This takes some inspiration
> from nsfs which uses a similar stashing mechanism.
> 
> Thanks!
> Christian
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ---
> base-commit: 3f643cd2351099e6b859533b6f984463e5315e5f
> change-id: 20240212-vfs-pidfd_fs-9a6e49283d80

I forgot to mention that pidfds are explicitly not simply directory
inodes in procfs for various reasons so this isn't an option I want to
pursue. Integrating them into procfs would be a nasty level of
complexity that makes for very ugly and convoluted code. Especially how
this would need to be integrated into copy_process() and other
locations. It also poses significant security and permission checking
challenges to userspace because it is generally not safe to send around
file descriptors for /proc/<pid> directories. It's a pretty big attack
vector and cause of security issues. So really this is not a path that I
want to go down. It defeats the whole purpose of pidfds as opaque, easy
delegatable handles.

Oh, and tree is vfs.pidfd at the usual location
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

