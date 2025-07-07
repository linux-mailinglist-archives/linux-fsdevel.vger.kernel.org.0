Return-Path: <linux-fsdevel+bounces-54088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C12AFB246
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDA217F1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290326057F;
	Mon,  7 Jul 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFBNCAc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7AFBF0;
	Mon,  7 Jul 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887847; cv=none; b=BiC13wvhV6zlKffC4ocr6JqgBf0Kewvp6cxMngFG4gY4SbHDnPNhZ0q9tzRYIq9rGTVFOaGmdhVfFA49kXNSJExpnHkgkz4PgKXKLbmXUR+9jRx1Gsgkjn/0DVS2wBaKPXn+JEPfFvBl052UWYb6sH5ymLf3oRrolutbS96W9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887847; c=relaxed/simple;
	bh=7fhQZtbOSfOsXMJ/sYDNlqeB4XZRa22YZhTcIzEw9lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLCNHvCcy1FTuMP02ynYjECPle9ujfAyC5w5aPiubYOrIze/aIQ39BfIfsv2vyvbRpfqj9jZCK2azzcu6LlqqgrJSlCBFIp2XtEwbo7UNmqGEbmW+Xf61VHJ9wj2IW6ED65p4OpnGsGJ5TFnBrm3k0B1EYixCW6vBMdrZpCyUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFBNCAc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447C7C4CEE3;
	Mon,  7 Jul 2025 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751887845;
	bh=7fhQZtbOSfOsXMJ/sYDNlqeB4XZRa22YZhTcIzEw9lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFBNCAc8PbxAprVgpPkEtyJEeGjmqsA5IGnPX+DjBHfVvysUyc10BGLtKU25348hX
	 WYMRwOHQdzYk7qdinD/2slDZVN8DXEdFtUGubP6qD52pW7QyuLVEqdS4c2fYuPvlAN
	 oMTdVFxeGLn/u3bRE7tN2waxmQ8eIArDOmQNbPxXxTBeI3ZlxvB3zUSHRmSqF+cxCI
	 1LxeBK7ObhMBs/Y8kuL0luhjpood60XSL0fWWXzG9kgeW9kTnEUkeFpHlKWfjzq6Hd
	 gmyXFz6GRvNTpVr4G6V9HvIAmOH+XmfOqRpjrXk1Jv1UZ3kncBAWYq7nZu4TaaVewF
	 OMLX3lPfosa9A==
Date: Mon, 7 Jul 2025 13:30:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: jack@suse.cz, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [mm?] [fs?] WARNING in path_noexec
Message-ID: <20250707-tusche-umlaufen-6e96566552d6@brauner>
References: <686ba948.a00a0220.c7b3.0080.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <686ba948.a00a0220.c7b3.0080.GAE@google.com>

On Mon, Jul 07, 2025 at 04:02:32AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d6c58332c7a Add linux-next specific files for 20250703
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15788582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7dc16394230c170
> dashboard link: https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ecb3d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153af770580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ff731adf5dfa/disk-8d6c5833.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c7a3c57e0a1/vmlinux-8d6c5833.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2f90e7c18574/bzImage-8d6c5833.xz
> 
> The issue was bisected to:
> 
> commit df43ee1b368c791b7042504d2aa90893569b9034
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Jul 2 09:23:55 2025 +0000
> 
>     anon_inode: rework assertions
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b373d4580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b373d4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b373d4580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com
> Fixes: df43ee1b368c ("anon_inode: rework assertions")
> 
> ------------[ cut here ]------------
> WARNING: fs/exec.c:119 at path_noexec+0x1af/0x200 fs/exec.c:118, CPU#1: syz-executor260/5835
> Modules linked in:
> CPU: 1 UID: 0 PID: 5835 Comm: syz-executor260 Not tainted 6.16.0-rc4-next-20250703-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118

And already we have found one offender whose not raising SB_I_NOEXEC but
using anonymous inodes...

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes

