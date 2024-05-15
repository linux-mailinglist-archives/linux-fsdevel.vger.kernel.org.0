Return-Path: <linux-fsdevel+bounces-19543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A08C6AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A509B213C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D213AF2;
	Wed, 15 May 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3cLrDZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70753182D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791176; cv=none; b=hjhtrep12t7UN8jihnJS9umfT0x3fwLhscs2uXWpwFb+fn8AlllBInd2DutMUK1gcUWPUTC3RXsAonewTButEMCVgUazxrMg2/dTy9E3g1kV4BLtUgtF4AskNfp7YL75HoD8ZULlEPfJ23OfUoAiZkjpZnF2Q9vdByyjlWj9Wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791176; c=relaxed/simple;
	bh=bnayU8m1sDLm6kdssSAK4LUwezHcTHIIDp7UzD0NHJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An+CZzsZhmijW7PEtEaUOZZyQyuaKkNQncqvWt/d4NGRA9KGE/1opdKVshTmCI1BY7HL75vHt5xonbbfKslotluczBAx7TGV7uaWfagj5BM/pGS/96VshufBzg9valDjEfrTtjSmqxmuvNm9Un6xvFY1PiRGzT4Fps+Tf8dFICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3cLrDZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796ADC116B1;
	Wed, 15 May 2024 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791176;
	bh=bnayU8m1sDLm6kdssSAK4LUwezHcTHIIDp7UzD0NHJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3cLrDZt1GFkbOfS2vkcFQjUewsUt8sa4v+t286jEVTnVLbhrPZs2LtP7PZ51E1sL
	 zp2PYCmKZw9m67g1ZMk5DGgPEGM8pEzb+D/GftBg79PJ6h/q82Dyf9ApMqONcFxkSF
	 YMC0xcdL7dx52iEd3C+tfn7V3m8fV+dksoLHUNhoS8DxdM5JnZA4UbmmJ/f+N2d14k
	 8vmR4bHwhJbO83CAVgBhAOqilFG/Ne0sx+jk6P3CqzJV8krUbCuagXDoFVzFyv6Z9w
	 Es8cxglE08Q3IIAEI8Lfiil/JdUAaGZmLJ02vOQHhvmvU87+1vqy5tY0aS5Pxt53cd
	 Ig7WPpkO6jO3g==
Date: Wed, 15 May 2024 18:39:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>

On Wed, May 15, 2024 at 01:10:49PM +0200, Jiri Slaby wrote:
> On 13. 02. 24, 17:45, Christian Brauner wrote:
> > This moves pidfds from the anonymous inode infrastructure to a tiny
> > pseudo filesystem. This has been on my todo for quite a while as it will
> > unblock further work that we weren't able to do simply because of the
> > very justified limitations of anonymous inodes. Moving pidfds to a tiny
> > pseudo filesystem allows:
> > 
> > * statx() on pidfds becomes useful for the first time.
> > * pidfds can be compared simply via statx() and then comparing inode
> >    numbers.
> > * pidfds have unique inode numbers for the system lifetime.
> > * struct pid is now stashed in inode->i_private instead of
> >    file->private_data. This means it is now possible to introduce
> >    concepts that operate on a process once all file descriptors have been
> >    closed. A concrete example is kill-on-last-close.
> > * file->private_data is freed up for per-file options for pidfds.
> > * Each struct pid will refer to a different inode but the same struct
> >    pid will refer to the same inode if it's opened multiple times. In
> >    contrast to now where each struct pid refers to the same inode. Even
> >    if we were to move to anon_inode_create_getfile() which creates new
> >    inodes we'd still be associating the same struct pid with multiple
> >    different inodes.
> > * Pidfds now go through the regular dentry_open() path which means that
> >    all security hooks are called unblocking proper LSM management for
> >    pidfds. In addition fsnotify hooks are called and allow for listening
> >    to open events on pidfds.
> > 
> > The tiny pseudo filesystem is not visible anywhere in userspace exactly
> > like e.g., pipefs and sockfs. There's no lookup, there's no complex
> > inode operations, nothing. Dentries and inodes are always deleted when
> > the last pidfd is closed.
> 
> This breaks lsof and util-linux.
> 
> Without the commit, lsof shows:
> systemd      ... 59 [pidfd:899]
> 
> 
> With the commit:
> systemd      ... 1187 pidfd
> 
> 
> And that user-visible change breaks a lot of stuff, incl. lsof tests.
> 
> For util-linux, its test fail with:
> 
> > [  125s] --- tests/expected/lsfd/column-name-pidfd	2024-05-06 07:20:54.655845940 +0000
> > [  125s] +++ tests/output/lsfd/column-name-pidfd	2024-05-15 01:04:15.406666666 +0000
> > [  125s] @@ -1,2 +1,2 @@
> > [  125s] -3 anon_inode:[pidfd] pid=1 comm= nspid=1
> > [  125s] +3 pidfd:[INODENUM] pidfd:[INODENUM]
> > [  125s]  pidfd:ASSOC,KNAME,NAME: 0
> > [  125s]          lsfd: NAME and KNAME column: [02] pidfd             ... FAILED (lsfd/column-name-pidfd)
> 
> And:
> > [  125s] --- tests/expected/lsfd/column-type-pidfd	2024-05-06 07:20:54.655845940 +0000
> > [  125s] +++ tests/output/lsfd/column-type-pidfd	2024-05-15 01:04:15.573333333 +0000
> > [  125s] @@ -1,2 +1,2 @@
> > [  125s] -3 UNKN pidfd
> > [  125s] +3 REG REG
> > [  125s]  pidfd:ASSOC,STTYPE,TYPE: 0
> > [  125s]          lsfd: TYPE and STTYPE column: [02] pidfd            ... FAILED (lsfd/column-type-pidfd)
> 
> Any ideas?

util-linux upstream is already handling that correctly now but it seems that
lsof is not. To fix this in the kernel we'll need something like. If you could
test this it'd be great as I'm currently traveling:

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a63d5d24aa02..3da848a8a95e 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -201,10 +201,8 @@ static const struct super_operations pidfs_sops = {

 static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-       struct inode *inode = d_inode(dentry);
-       struct pid *pid = inode->i_private;
-
-       return dynamic_dname(buffer, buflen, "pidfd:[%llu]", pid->ino);
+       /* Fake the old name as some userspace seems to rely on this. */
+       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
 }

 static const struct dentry_operations pidfs_dentry_operations = {


