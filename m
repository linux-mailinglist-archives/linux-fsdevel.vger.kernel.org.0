Return-Path: <linux-fsdevel+bounces-45657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6DA7A611
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608B53B1BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F662505CD;
	Thu,  3 Apr 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqtUrlHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C924337D;
	Thu,  3 Apr 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693343; cv=none; b=J4mZjRvs4OFxL7fg87KFZW+sDKeEIdVYHnMC3YEg+PKN4+c9PAZzY6eVW8VXSxhrzIlh558wCyqU9wRoezu8AWANAXc0DQ8621g5NASZaBIL/i9nuO4kOA3U/1Nl5P7SFBxMnudN8pIwuBiaARJCjCi/v3UhCYWoHS/c8a5LI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693343; c=relaxed/simple;
	bh=B5uvcDMbEl7DdURG7JgwbLJJzfTN1liXGBxF4DMAC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEVbI+dAvvI4ihup3lWv7livDipDZWZMHahqqr61gNYnXuuw8fVBd8gfLOIGyRHogT4ojyp4Dox4nsB1dz5Lltovui3uG2v5Pem3wCtznPTam8frFLVm2JM80kURiVM1uZnfyCkEafYuOoD3BsUmde8StTdtkUqptzVfV0Pyzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqtUrlHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC4CC4CEE3;
	Thu,  3 Apr 2025 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743693343;
	bh=B5uvcDMbEl7DdURG7JgwbLJJzfTN1liXGBxF4DMAC4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqtUrlHNoWWUrpfvNHRn/HS3X2CJmUpf+b1fD0DjlH+GzUWFJYFjvByZZ6SRCFCWV
	 /50Xh/FJw6P59ZXKwOp+uAMpnTNaLJ9NlUpbCjhYOGoMrNC+YFVZG+zfmohlPpTRIX
	 FUmwr8nKQwcLCJm9yNtHzOHJELiJs/WlpMrsef2R1jhTGgGGKUFx2yYs3QRw/G/Ioh
	 ItAatKsmpOPVCN7/+VlmeCk7EVUzV/2MYyTj2I4jBOciqjhyctafORKzLGrI2lW/zC
	 bWw+vX+8QHQQfgEK3mcKC4ngx486wxoMwwTBQEs6pTN4JXgt7sMeMYD1HV+c8qVqED
	 hPrVIX69IkYwg==
Date: Thu, 3 Apr 2025 17:15:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: pr-tracker-bot@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250403-quartal-kaltstart-eb56df61e784@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ffv6b5tmhodr33bb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403-bankintern-unsympathisch-03272ab45229@brauner>


--ffv6b5tmhodr33bb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 03, 2025 at 10:29:37AM +0200, Christian Brauner wrote:
> On Tue, Apr 01, 2025 at 08:07:15PM +0300, Leon Romanovsky wrote:
> > On Mon, Mar 24, 2025 at 09:00:59PM +0000, pr-tracker-bot@kernel.org wrote:
> > > The pull request you sent on Sat, 22 Mar 2025 11:13:18 +0100:
> > > 
> > > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount
> > > 
> > > has been merged into torvalds/linux.git:
> > > https://git.kernel.org/torvalds/c/fd101da676362aaa051b4f5d8a941bd308603041
> > 
> > I didn't bisect, but this PR looks like the most relevant candidate.
> > The latest Linus's master generates the following slab-use-after-free:
> 
> Sorry, did just see this today. I'll take a look now.

So in light of "Liberation Day" and the bug that caused this splat it's
time to quote Max Liebermann:

"Ich kann nicht so viel fressen, wie ich kotzen möchte."

--ffv6b5tmhodr33bb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-actually-hold-the-namespace-semaphore.patch"

From 8822177b7a8a7315446b4227c7eb7a36916a6d6d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 3 Apr 2025 16:43:50 +0200
Subject: [PATCH] fs: actually hold the namespace semaphore

Don't use a scoped guard use a regular guard to make sure that the
namespace semaphore is held across the whole function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 16292ff760c9..348008b9683b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2478,7 +2478,8 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	struct mount *old_mnt = real_mount(path->mnt);
 	struct mount *new_mnt;
 
-	scoped_guard(rwsem_read, &namespace_sem)
+	guard(rwsem_read, &namespace_sem);
+
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
 
-- 
2.47.2


--ffv6b5tmhodr33bb--

