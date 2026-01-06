Return-Path: <linux-fsdevel+bounces-72553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A7CFB4A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AD48300461D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDB2EAB72;
	Tue,  6 Jan 2026 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAIKIyUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD17FBAC;
	Tue,  6 Jan 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739931; cv=none; b=YRofOJ5Exz1i0NEGSpvYsWrmjcJDv6gTrkkpztv8C7EB5rqXZgpTQMV2MxBIILbzEdgqvCYwvm82S2RA6ErKiNbMxsNAw5xB8imBIzvg3/h9YwUMvrLBkVo5SJ2AHhnTsH5DsvpoflzTUlnC67EpF73YBkuGbhLweotIZTMpqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739931; c=relaxed/simple;
	bh=e3fZ8JXWqrCcjLaQaU97c3jnYE1mnbJtwZY1HvWHTaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNjlWKg36OhXhYBeN4jkk9D0HxYVXV/ID3TItrg62iUxQ0+Bxa5hVOfS2kfV4PsZhe146qcYGNouzUZ4poRujJ2YSJy+MCWzs9vnTw891ltRA4IbDXhO8sxBUCGicgC+SpJ+Pq6tGY6w9V83i5k/VqJtGV+Vaub8rbeVlMIw3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAIKIyUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E3EC116C6;
	Tue,  6 Jan 2026 22:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739930;
	bh=e3fZ8JXWqrCcjLaQaU97c3jnYE1mnbJtwZY1HvWHTaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAIKIyUGZMCYGmy9Io/4Ei5e927lrZMmt5N5eaF8Ztebuh0PlOvwDW8MYRwDjDlw+
	 qS7xjju/0HYEvzF9Tv8t23h26sXRAXNToo8ktxpC6JBl3twL3FnnGwwnKgyoYOiB6t
	 t8poMp0wXMLrXc1CMywxr13mllF5Xb8Ckh3R1txONbmR00vRVLi9+Ydh2j5JlQZuzQ
	 ME+K7003IkTLehq4AeqVbOq0rSafBX4Ebptgv2WpO0TEREiMpdICRWGnm/e0qI3Qil
	 5x3mOe2GxfZgRg6Z7v+zStvm+H8OPgp7D67KW8FnLhnOAEIqjtrQFQNzHtPUD71USH
	 2YrBNDjKzquGg==
From: Christian Brauner <brauner@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/2] vfs kernel-doc fixes for 6.19
Date: Tue,  6 Jan 2026 23:51:47 +0100
Message-ID: <20260106-couch-deretwegen-f8a483af5a0e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219024620.22880-1-bagasdotme@gmail.com>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=brauner@kernel.org; h=from:subject:message-id; bh=e3fZ8JXWqrCcjLaQaU97c3jnYE1mnbJtwZY1HvWHTaw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTGTuKQCX6x4s2xs1Nul8cpmazvvyX59o1w5jTNSV+0G af4TrOW6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIfhsjw7+9wRuSzgTKsjx/ Hx57I2yB6abf80+bPU1jYHCck7Y/NZWRYVbK7FCpJ+U+/1o+zmu8NmejR6d0647jl6osOzbVbeV TYwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 09:46:18 +0700, Bagas Sanjaya wrote:
> Here are kernel-doc fixes for vfs subsystem targetting 6.19. This small
> series is split from much larger kernel-doc fixes series I posted a while
> ago [1].
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20251215113903.46555-1-bagasdotme@gmail.com/
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/2] fs: Describe @isnew parameter in ilookup5_nowait()
      https://git.kernel.org/vfs/vfs/c/b0f5804b4178
[2/2] VFS: fix __start_dirop() kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/ba4c74f80ef3

