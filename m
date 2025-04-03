Return-Path: <linux-fsdevel+bounces-45696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB498A7AFFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB2517C240
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075725A33C;
	Thu,  3 Apr 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaZE1+04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9F224FA;
	Thu,  3 Apr 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710153; cv=none; b=bHct7oeaeN5II/gq0sDtvmzjyrL72eVCBL9LPqkUysoV8ssdrq56P2njPyUoMl15Bel8/QMm4ogThmEl+dWcISM5MPJYM7fmjA0qc9WxzBXzHYYJ1d6VzTduEPZi0jnI0JLH4Nh+k+7+7xKspgVC7WDhsUMw9mPt93XcBlFLaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710153; c=relaxed/simple;
	bh=LF7TzE/Bxhpspv9YgQFYoPUl5oZLC86gC94zHFiqbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFOR6i5ZLFpU3JvGjF8yZ7ZhsZp8gJWtT9aOk9Mfs0hpVJnlFi4KJ6hzsH7vwRK0oPyWeYc7NAkK3kf0uNcmX9lRaeKcz15ZoK/JVUBHMUzbuPO9G1jvLkhVum802CIvYjlcPKeyYygVCdjZ2x7lMRa232YC9E5M6JFNUwzKpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaZE1+04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750C1C4CEE3;
	Thu,  3 Apr 2025 19:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743710152;
	bh=LF7TzE/Bxhpspv9YgQFYoPUl5oZLC86gC94zHFiqbFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaZE1+04G9aV5fRRsPoN3pSTnjBGbnbRhZcy8seklH/YwCw9wCdGbFlNQv6lONl7n
	 1mBPYdm+w9Lh8jFedyvmh5qZfOiXx1+cy9hKQA5Z4oleUGBxNrAYR9iAq/VpXiUoM+
	 Cw+yr/VaMvSUCoN+yfRI+3O1p+6ztGeJxdzGnu6dFIQW6EY8R829SBJxDHBaKcEWJn
	 bl27VsZh8PhsPsSHjaKBkcN+IivxIWnz/4W2VfccCig+1YLwkVFMFBnHBAMgICT3Ot
	 WxMHcKVsl2BUgrFQ5IGNwhF+sEl3sd/WBj6vjn6zkZhkVA8FNBBgw/nwapdQL8qnDu
	 LdQ3wZpi6IePw==
Date: Thu, 3 Apr 2025 21:55:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250403-kaufanreiz-leber-c7c878cc833e@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <20250403182455.GI84568@unreal>
 <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>
 <20250403-auferlegen-erzwang-a7ee009ea96d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pdx2hxwawfdibqzb"
Content-Disposition: inline
In-Reply-To: <20250403-auferlegen-erzwang-a7ee009ea96d@brauner>


--pdx2hxwawfdibqzb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Apr 03, 2025 at 09:45:59PM +0200, Christian Brauner wrote:
> On Thu, Apr 03, 2025 at 12:18:45PM -0700, Linus Torvalds wrote:
> > On Thu, 3 Apr 2025 at 11:25, Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > -     scoped_guard(rwsem_read, &namespace_sem)
> > > > +     guard(rwsem_read, &namespace_sem);
> > >
> > > I'm looking at Linus's master commit a2cc6ff5ec8f ("Merge tag
> > > 'firewire-updates-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394")
> > > and guard is declared as macro which gets only one argument: include/linux/cleanup.h
> > >   318 #define guard(_name) \
> > >   319         CLASS(_name, __UNIQUE_ID(guard))
> > 
> > Christian didn't test his patch, obviously.
> 
> Yes, I just sent this out as "I get why this happens." after my
> screaming "dammit" moment. Sorry that I didn't make this clear. I had a
> pretty strong "ffs" 10 minutes after I had waded through the overlayfs
> code I added without being able to figure out how the fsck this could've
> happened. In any case, there's the obviously correct version now sitting
> in the tree and it's seen testing obviously.

I'll also append it here just in case you want to apply it right now.

--pdx2hxwawfdibqzb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="v2-0001-fs-actually-hold-the-namespace-semaphore.patch"

From f5ff87a84a8803eeb4b344b9a496e7060787b42a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 3 Apr 2025 16:43:50 +0200
Subject: [PATCH v2] fs: actually hold the namespace semaphore

Don't use a scoped guard use a regular guard to make sure that the
namespace semaphore is held across the whole function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 16292ff760c9..14935a0500a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2478,7 +2478,8 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	struct mount *old_mnt = real_mount(path->mnt);
 	struct mount *new_mnt;
 
-	scoped_guard(rwsem_read, &namespace_sem)
+	guard(rwsem_read)(&namespace_sem);
+
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
 
-- 
2.47.2


--pdx2hxwawfdibqzb--

