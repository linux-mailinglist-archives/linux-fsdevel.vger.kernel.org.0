Return-Path: <linux-fsdevel+bounces-73199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD3D117C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90D930299E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B4348898;
	Mon, 12 Jan 2026 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiRzWUat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92F347FFE;
	Mon, 12 Jan 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210039; cv=none; b=dEOpAokJIBsFTuHQqbY+mFNz+IlMpa/Ou4DOs0CuIuIcsE4gX1EatxpJDbnmGfI945mkxWhq+teKjfSB1wpbw7TZ3X2hUzkEjDpbKFcHVtwiYlU59XrrW+7tywi3luaQbt5DEdQd2stG+HivZIt/1hHSwIYJIdVumseD1LTeYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210039; c=relaxed/simple;
	bh=mctfVPBq78mWbINSkzZmXaspK00w91wD6Td7M6QEXIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdLxyXCrRVwJLvT3wc8GcI1YRUwCiKaj7Cyfj7E1L7AlDZ7M/OZf3NExTenmIUQhAYYs31nWe6ixiAym9zbwT8UjBknJTWNe73hn86bXI1+VWQ0342w2S3BucRz2+xkrmfKBNYqATDn2Q9izFPxTVOjKq2h19XSX11h3UlJZrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiRzWUat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F2C116D0;
	Mon, 12 Jan 2026 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768210039;
	bh=mctfVPBq78mWbINSkzZmXaspK00w91wD6Td7M6QEXIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiRzWUatq1VLJ1xQrFyHJk5mbnx79ywxyf2zhy16joeLz+BIPkKGkgP09oQw0z+qV
	 bLOSjU0dc3VWB5bLdNemeA02X7QDyraiNKMi1ZoGNbvsvrIPK9r9X55HGC8Q76tLQr
	 vGwM6X2WhV0u2NdnFs8jLcBTMd7TOfQ0HfAPWKvdEaaCpfazqxnGfeqHtxnTfTt3Vb
	 AXraO61dXPUe0EcwE/oA9pS7a9VUxco8fs4McHHIYdM0YJ7ykk9TtHyMP/HrFYvdx1
	 P3PmXoru+AHi0UU43XEqjuNGUwo4X3x/RKc2ruMX83t2gfBzwGjm9rHo2fxLSNJciw
	 e3+Hcptiu6X/w==
Date: Mon, 12 Jan 2026 10:27:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [hfs?] kernel BUG in may_open (3)
Message-ID: <20260112-apokalypse-sachte-846a6175c176@brauner>
References: <6964b615.050a0220.eaf7.0093.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6964b615.050a0220.eaf7.0093.GAE@google.com>

On Mon, Jan 12, 2026 at 12:51:33AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b6151c4e60e5 Merge tag 'erofs-for-6.19-rc5-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d45922580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a7d19a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2f19a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6eb5179ada01/disk-b6151c4e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bc48d1a68ed0/vmlinux-b6151c4e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/061d4fb696a7/bzImage-b6151c4e.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/df739de73585/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 1024
> VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880384b01e0
> fs hfsplus mode 0 opflags 0x4 flags 0x0 state 0x70 count 2

This is hfsplus adding inodes with a non-valid mode.

