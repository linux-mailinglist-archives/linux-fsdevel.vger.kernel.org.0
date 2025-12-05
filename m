Return-Path: <linux-fsdevel+bounces-70804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C47CA6C64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0603630FF003
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A2FF666;
	Fri,  5 Dec 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr7pLL0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E262FE59C;
	Fri,  5 Dec 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924936; cv=none; b=Uuz8+umk7EqsrVxPf3RXLJ5A46IZTCPVOOJIgSRkntrueQX05H68QJKydv5fMz4WqkiQIaxVegUc0rfaxnZgPy5pmR2/S1XVhiuI9DqroyWu7QkAyHJ1b7kVnvz4RjS/efjqH/EGAZTilHtXfV4OwHXHzTB0yg/aucafF4roZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924936; c=relaxed/simple;
	bh=DBbBFeQyI3w233SvS5QKGZSr9QyQc0B+PGjTYGRCGn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ4GTN7rWRD3UAJYj7POCq7iNfnkEBNr4tFIKqWsQCGMFsawnuQZXKk+6ELLWwGo9OA1pCdA9l1I3d7BweQes0UEdwXZyA1kUKXZ7381/dXKrG6tzukUHc+5b96uxE7ulZ4WK73ivgy5BnVnjY2YjOKfL9tRDD9s4dEb3veYE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr7pLL0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D78C4CEF1;
	Fri,  5 Dec 2025 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764924936;
	bh=DBbBFeQyI3w233SvS5QKGZSr9QyQc0B+PGjTYGRCGn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr7pLL0sZePa+Y8D4LMHQ53tIrjGKaF150rDvgIJ89ou1Jq+3qhlLWSXYvOsuH7Co
	 xfqRKlY42g2Un1ktea7NKMNjtIiPdMLhYC4U/WhjEHQT0x0gyBqdVNQyUK9o2gtleh
	 Tf6Tcr3aj04f7ggHwYpkZ+vdskdfAcMkjMQdgTa+4qDWvJY2x5OrccuBA8GeEouSx0
	 yNh8ofWT3DScIgxtuWvP+cWHVhSZqsTm7HEBzDDJPuOPqqqX4PTJLDTHB6RpgDPBCs
	 90X0Lpxpyl75I02bGLLaL9GICGcTbGEs+f5TjAfbW3rEvHIIkYOP3DE23nBtvZLAl3
	 pD/YXf0JcY+0Q==
From: Christian Brauner <brauner@kernel.org>
To: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] mqueue: correct the type of ro to int
Date: Fri,  5 Dec 2025 09:55:28 +0100
Message-ID: <20251205-abberufen-rabiat-4288544a76ad@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_369728EA76ED36CD98793A6D942C956C4C0A@qq.com>
References: <tencent_369728EA76ED36CD98793A6D942C956C4C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=brauner@kernel.org; h=from:subject:message-id; bh=DBbBFeQyI3w233SvS5QKGZSr9QyQc0B+PGjTYGRCGn0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQazWOqD3NvfXaz2u3Bxd0x6yQfO01jFFMuWe/McPLC/ L0F4vU/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyfTHD/3AG6VKh3kkmK3c3 Hvh1JmS5+z3d7N+f1yvOrS8peby9tZvhn1r33NXFXbP/G1a3MmQe23nEJ2TZfpnNvwy8ziVvn2P qyQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Dec 2025 21:16:22 +0800, Edward Adam Davis wrote:
> The ro variable, being of type bool, caused the -EROFS return value from
> mnt_want_write() to be implicitly converted to 1. This prevented the file
> from being correctly acquired, thus triggering the issue reported by
> syzbot [1].
> 
> Changing the type of ro to int allows the system to correctly identify
> the reason for the file open failure.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] mqueue: correct the type of ro to int
      https://git.kernel.org/vfs/vfs/c/1d98eeadbc10

