Return-Path: <linux-fsdevel+bounces-52712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB4AE5FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672CB165469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A36270ECF;
	Tue, 24 Jun 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFsby8Nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9A256C8A;
	Tue, 24 Jun 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754734; cv=none; b=GKozxaRYo0v5kBkDPTYlbL8ytG3GnM5cpUdsnHJmSqsXvnGtiB7VDUZSbPoq9yC9pciyHrNWOb28eWt0Cr1QN7uGSdfa0tCgn0J/wyDTFf0sxtiHuSODOcJef/3jJbKQl1gN55RXMJTQTFhrnzN/LZ1HRxqNNLdX0VmjYNIPMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754734; c=relaxed/simple;
	bh=34LmpEiX4TjPFhSnTIl7DsoNL2Ri1O8AUB1Br8IfKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0sIea5FjTCYwTUzcyXGtVYuJ0kkoeb70AYI0gVG2mZASF2oJ22sQIciv/l2P+RscT8CUf7bSDAiLj1YTvYqdbF5bwkDNI9/aAZZPvgdMdQayhHVaHOlXCFS8PLwqLrsR7MkP3thMcLlXqPHbrujvv0H5eRybiNyCw8o71WLL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFsby8Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C29C4CEE3;
	Tue, 24 Jun 2025 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750754733;
	bh=34LmpEiX4TjPFhSnTIl7DsoNL2Ri1O8AUB1Br8IfKwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFsby8NcSNY7Q0zk48avWQuVssIX8nwyWekcuL1XmxYZwW2SZshqkSPKQCi1IdYI0
	 jDZiAvRiJAnUXVDLKpahJM1fDFGgW3dVZK5oQOF2LG8wgRJAqo/B3pFTh2msOAbxPr
	 SP6NHN2dNImrpxH3i7euS6AXNI3bvrPW4v6AqmzRUediULbRlB46JEK2fWfCDfec6t
	 fWpjNUUR+9Gm+eYxTMhHuBYrTvvEz8HiEmuGgw5HCMTBwZLb9p+x3ytcrWo/N9V4ZG
	 0r4MyrBlt5oMJeXePLc0oWvvHmP+gzoWN0mbaYx7arlM6csnyW6hogE62CW9Po+Uk9
	 gvkXW7XIbFCVA==
Date: Tue, 24 Jun 2025 10:45:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
Message-ID: <20250624-serienweise-bezeugen-0f2a5ecd5d76@brauner>
References: <68599c8e.a00a0220.34b642.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68599c8e.a00a0220.34b642.000f.GAE@google.com>

On Mon, Jun 23, 2025 at 11:27:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=150ef30c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a5330c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c9f6bc580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/disk-5d4809e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlinux-5d4809e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/bzImage-5d4809e2.xz
> 
> The issue was bisected to:
> 
> commit fb0b3e2b2d7f213cb4fde623706f9ed6d748a373
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Jun 18 20:53:46 2025 +0000
> 
>     pidfs: support xattrs on pidfds
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a1b370580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a1b370580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a1b370580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
> Fixes: fb0b3e2b2d7f ("pidfs: support xattrs on pidfds")

#syz test: 

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs

