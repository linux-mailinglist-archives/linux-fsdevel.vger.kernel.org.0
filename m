Return-Path: <linux-fsdevel+bounces-46717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DB0A94364
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C0917528D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2D1D63DD;
	Sat, 19 Apr 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQXgIQJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83AEEB3
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745065439; cv=none; b=VmtEzkqTDbYNNqpdCdZn+fBHv19vvF+9Pbb08wH4jWwvm/TnZjb0WQmQoJaD0cbPY2ajSNEeCevDetQuaz7BPJRmWHCK8ywbj4nh4wrLuQ9XYLL0RCAjK5Idx++F5up/FqgXTInNp/ufGXQi9HC/LwPdkQg34rUkPgHLSRra2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745065439; c=relaxed/simple;
	bh=j8/MUr1MyygQOk8ubdVi1sJpGwQva+0NEJRupbdkZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OskQR+WmODht94ZodDjbz9CiMvo95Bwyybskb8icUcLV0tN+YmxBVr/xyxMICllEbbUCh+pdtD/ryvOhz9TqvDfYaIl2v5bic+5ZSh0AUaE20pFQ6RNfI7iOESnL7XLKUoGeo1tK/nVYqZG3yEWQSBReVZP455J0LLV1bNEKWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQXgIQJ9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Apr 2025 08:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745065434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tt+jF7G4CGjh2IXVN9sKaN3Nb29JLgTyUceQNQrrCX8=;
	b=TQXgIQJ97D1C9dP/4NY0UB4qmJTgcLLpoYsknXzQJd/JAYYNQuHjdpMSc8Fudtry8Zi2B2
	d6R21uS/tmxVXjsGLgOf/Iqzn3l5xZ8dTNnvEoGor0hBzJjepkUtXGIrV2bTEEHImk3dxs
	Ne8Fy1u7aY4D6O5Fzc91Ly0FULhtvzc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
Message-ID: <7mzjrydosm7fnkskvwjwvzpdverxidzfdqgjjyfmqljffen5ou@jy6c626sjrxr>
References: <68036084.050a0220.297747.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68036084.050a0220.297747.0018.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

I'm not sure which subsystem this is, but it's definitely not bcachefs -
we don't use buffer heads.

On Sat, Apr 19, 2025 at 01:36:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3088d26962e8 Merge tag 'x86-urgent-2025-04-18' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17aed470580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a31f7155996562
> dashboard link: https://syzkaller.appspot.com/bug?extid=4eb503ec2b8156835f24
> compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3088d269.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5ec84510bfc9/vmlinux-3088d269.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/af58d0bee0a4/bzImage-3088d269.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com
> 
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> CPU: 0 UID: 0 PID: 47 Comm: kworker/u4:3 Not tainted 6.15.0-rc2-syzkaller-00400-g3088d26962e8 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: loop0 loop_workfn
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  panic+0x349/0x880 kernel/panic.c:354
>  check_panic_on_warn+0x86/0xb0 kernel/panic.c:243
>  end_report+0x77/0x160 mm/kasan/report.c:227
>  kasan_report+0x154/0x180 mm/kasan/report.c:636
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x28f/0x2a0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
>  put_bh include/linux/buffer_head.h:301 [inline]
>  end_buffer_read_sync+0xc1/0xd0 fs/buffer.c:161
>  end_bio_bh_io_sync+0xbf/0x120 fs/buffer.c:2748
>  blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
>  blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
>  lo_rw_aio_do_completion drivers/block/loop.c:317 [inline]
>  lo_rw_aio_complete drivers/block/loop.c:325 [inline]
>  lo_rw_aio+0xdfd/0xf80 drivers/block/loop.c:398
>  do_req_filebacked drivers/block/loop.c:-1 [inline]
>  loop_handle_cmd drivers/block/loop.c:1866 [inline]
>  loop_process_work+0x8e3/0x11f0 drivers/block/loop.c:1901
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

