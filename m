Return-Path: <linux-fsdevel+bounces-68033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CFC5183A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2FE4FC9EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EE2FDC41;
	Wed, 12 Nov 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciEgfAtc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EB2DC76C;
	Wed, 12 Nov 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940679; cv=none; b=fj3UQMWPhciHyMZjS0DNiiUFMCoFxCrENquqRMdxGg0Udz4u3OfKE1gxN1d0lgFwMPwiqqGmyBy3TVsOwyhZNyEgIiZfgc/Z2saTOGXGbmUh6IEMfVqBa0uZ5zbFi9HCTWXt/yiHKRCuJEFwDN4bbDJ+9ROBkEBmVB702zCAP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940679; c=relaxed/simple;
	bh=YO+lSItDLHmwnBb8SxBfPq3IWMpinpalkNSa15NUcRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJvJogk49v5bwKXpPM1+9hOKmzjPpuXKr0RONEjN9uSdz21gNjf1/G81VphgcNVFT6wqN6LYZwRciACsTxSFLulL1dJLBrefD8fTIBSMUp/aY7Rt6qZVGb4qLPkZbxYCSrVGGgZNuqS8jcgld77yJbIzoDLPGDtPy1uefBhn9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciEgfAtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BBAC116B1;
	Wed, 12 Nov 2025 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940679;
	bh=YO+lSItDLHmwnBb8SxBfPq3IWMpinpalkNSa15NUcRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciEgfAtcUdMk7OJVcU3ZccexItmtw9Ux0p2Qc5FXcgtlBlWpmAUOTETksnLU5o7JF
	 0OQjnBh5pFtBnBiOMydSYF7PdoaZOa0dYrHNsRXtcZET5k0383huEAUjXLPxaTuQIU
	 q3PRwypKWshfCQBsCqAZOIHBFCDRD+E/InyfmaXj+wuwb6/8JJ18qZpUojfjUl0RsK
	 6W5Kt6fPNYanwqVNJU+06Q2p5hN0Ymi/mmbBEk5Ggqkjj4xm/lVM+9pSsuJJXRiPaI
	 zwXkWOvzwFkGoRn5Q/ZLzTZO26Psmzb3os+DfNfxZHzKAAuCtBG48sph789RlE/TLC
	 KqLieb0QmV4KQ==
Date: Wed, 12 Nov 2025 10:44:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
Message-ID: <20251112-ferien-trott-4d99d59d676d@brauner>
References: <20251111-komponente-verprellen-a5ba489f5830@brauner>
 <69133ffa.a70a0220.22f260.0139.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69133ffa.a70a0220.22f260.0139.GAE@google.com>

On Tue, Nov 11, 2025 at 05:54:02AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in __ns_ref_active_put
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6510 at kernel/nscommon.c:171 __ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
> Modules linked in:
> CPU: 0 UID: 0 PID: 6510 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:__ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
> Code: 4d 8b 3e e9 1b fd ff ff e8 76 62 32 00 90 0f 0b 90 e9 29 fd ff ff e8 68 62 32 00 90 0f 0b 90 e9 59 fd ff ff e8 5a 62 32 00 90 <0f> 0b 90 e9 72 ff ff ff e8 4c 62 32 00 90 0f 0b 90 e9 64 ff ff ff
> RSP: 0018:ffffc900038dfa60 EFLAGS: 00010293
> RAX: ffffffff818e5946 RBX: 00000000ffffffff RCX: ffff88802f641e40
> RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> RBP: ffffc900038dfc00 R08: ffff88807dbaac6b R09: 1ffff1100fb7558d
> R10: dffffc0000000000 R11: ffffed100fb7558e R12: dffffc0000000000
> R13: 1ffff1100fb7558c R14: ffff88807dbaac60 R15: ffff88807dbaac68
> FS:  0000000000000000(0000) GS:ffff888125cf3000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555674424a8 CR3: 000000000df38000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  nsproxy_ns_active_put+0x87/0x200 fs/nsfs.c:702
>  free_nsproxy kernel/nsproxy.c:80 [inline]
>  put_nsproxy include/linux/nsproxy.h:110 [inline]
>  switch_task_namespaces+0xc2/0x120 kernel/nsproxy.c:223
>  do_exit+0x6b0/0x2300 kernel/exit.c:966
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1108
>  get_signal+0x1285/0x1340 kernel/signal.c:3034
>  arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efc6318f6c9
> Code: Unable to access opcode bytes at 0x7efc6318f69f.
> RSP: 002b:00007efc63f910e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007efc633e5fa8 RCX: 00007efc6318f6c9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007efc633e5fa8
> RBP: 00007efc633e5fa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007efc633e6038 R14: 00007fff3109d6b0 R15: 00007fff3109d798
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         cc719c88 nsproxy: fix free_nsproxy() and simplify crea..
> git tree:       https://github.com/brauner/linux.git namespace-6.19
> console output: https://syzkaller.appspot.com/x/log.txt?x=147c8658580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Note: no patches were applied.

#syz test: https://github.com/brauner/linux.git namespace-6.19

