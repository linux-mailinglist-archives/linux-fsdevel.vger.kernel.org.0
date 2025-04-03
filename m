Return-Path: <linux-fsdevel+bounces-45675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD0A7A94E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E68188C926
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DBB252901;
	Thu,  3 Apr 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHBOJkcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D229C8E0;
	Thu,  3 Apr 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704700; cv=none; b=pffqsiclpns7t9NHIgrq/17Ak26kZWo55Nhzl6PS5iv+QM4OTNIb5U7jrWdzUHE8of+kj4aZxRomWB4ZkUtLXuS3UJyXLfVABM/O9t3ZghOT19nctlObWos9FNRm7jSZJZuCCqy/GMQ3BZYfEwLKYotg1iZYsohd8TLxSnvjSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704700; c=relaxed/simple;
	bh=aiXxBo+XB+avNcnabNeMd/n9QGO6oulYrV99ZYreH/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY2NBcnpsGK0hmXNF2C0pi7Dobs2qbE6TrRnhJ8rhnloz4o3ib+FjxFgLONgOL2dZ0APiBXc75je5mZ7obNKi5pAsEJpJEPfHYo72++Lv2lgRIJUw1XFkimQeZyQ9+YU4iXPYzVeMix/R5Cx1htBSEfeyfvLx+w6Uw7O6rfWfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHBOJkcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D948C4CEE3;
	Thu,  3 Apr 2025 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743704700;
	bh=aiXxBo+XB+avNcnabNeMd/n9QGO6oulYrV99ZYreH/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHBOJkcMeA87g4A6QkAJ843PjhMKVKakEzbDaMebQPAdlOeGzKVvTPeOOMbzuYZmE
	 p0nZCh6N6uSeIPHvb6WK0kFW6kT7D4UjYIGJ+W/ZNrtIk0j9n3RPlFjeVbl03wJ2gd
	 FjPJg5n0pABMPhyCdg7vlmS475iZ6/979tmoDK8OcA5de+0AEPZt1M1tbsrOvrWxRk
	 BLtoR5lfAuzRgjFHSwWp+iGwvGeZyd0FUz/Xah/Uq7PDFjFh1521t9UNSeN7e0FPYr
	 ukDZ+VcTJBrB9EOUYCUIge8vklTztq3ytS/B8IqOar8m8iSrKcpr0MM/XTWBDAODJj
	 u1E7KU56PD5/A==
Date: Thu, 3 Apr 2025 21:24:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pr-tracker-bot@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250403182455.GI84568@unreal>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403-quartal-kaltstart-eb56df61e784@brauner>

On Thu, Apr 03, 2025 at 05:15:38PM +0200, Christian Brauner wrote:
> On Thu, Apr 03, 2025 at 10:29:37AM +0200, Christian Brauner wrote:
> > On Tue, Apr 01, 2025 at 08:07:15PM +0300, Leon Romanovsky wrote:
> > > On Mon, Mar 24, 2025 at 09:00:59PM +0000, pr-tracker-bot@kernel.org wrote:
> > > > The pull request you sent on Sat, 22 Mar 2025 11:13:18 +0100:
> > > > 
> > > > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount
> > > > 
> > > > has been merged into torvalds/linux.git:
> > > > https://git.kernel.org/torvalds/c/fd101da676362aaa051b4f5d8a941bd308603041
> > > 
> > > I didn't bisect, but this PR looks like the most relevant candidate.
> > > The latest Linus's master generates the following slab-use-after-free:
> > 
> > Sorry, did just see this today. I'll take a look now.
> 
> So in light of "Liberation Day" and the bug that caused this splat it's
> time to quote Max Liebermann:
> 
> "Ich kann nicht so viel fressen, wie ich kotzen möchte."

> From 8822177b7a8a7315446b4227c7eb7a36916a6d6d Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Thu, 3 Apr 2025 16:43:50 +0200
> Subject: [PATCH] fs: actually hold the namespace semaphore
> 
> Don't use a scoped guard use a regular guard to make sure that the
> namespace semaphore is held across the whole function.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 16292ff760c9..348008b9683b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2478,7 +2478,8 @@ struct vfsmount *clone_private_mount(const struct path *path)
>  	struct mount *old_mnt = real_mount(path->mnt);
>  	struct mount *new_mnt;
>  
> -	scoped_guard(rwsem_read, &namespace_sem)
> +	guard(rwsem_read, &namespace_sem);

I'm looking at Linus's master commit a2cc6ff5ec8f ("Merge tag
'firewire-updates-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394")
and guard is declared as macro which gets only one argument: include/linux/cleanup.h
  318 #define guard(_name) \
  319         CLASS(_name, __UNIQUE_ID(guard))



20:52:24  fs/namespace.c: In function 'clone_private_mount':
20:52:24  fs/namespace.c:2481:41: error: macro "guard" passed 2 arguments, but takes just 1
20:52:24   2481 |         guard(rwsem_read, &namespace_sem);
20:52:24        |                                         ^
20:52:24  In file included from ./include/linux/preempt.h:11,
20:52:24                   from ./include/linux/spinlock.h:56,
20:52:24                   from ./include/linux/wait.h:9,
20:52:24                   from ./include/linux/wait_bit.h:8,
20:52:24                   from ./include/linux/fs.h:7,
20:52:24                   from ./include/uapi/linux/aio_abi.h:31,
20:52:24                   from ./include/linux/syscalls.h:83,
20:52:24                   from fs/namespace.c:11:
20:52:24  ./include/linux/cleanup.h:318:9: note: macro "guard" defined here
20:52:24    318 | #define guard(_name) \
20:52:24        |         ^~~~~
20:52:24  fs/namespace.c:2481:9: error: 'guard' undeclared (first use in this function)
20:52:24   2481 |         guard(rwsem_read, &namespace_sem);
20:52:24        |         ^~~~~
20:52:24  fs/namespace.c:2481:9: note: each undeclared identifier is reported only once for each function it appears in

Do I need to apply extra patch?

Thanks

