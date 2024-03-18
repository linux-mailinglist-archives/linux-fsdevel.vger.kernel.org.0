Return-Path: <linux-fsdevel+bounces-14726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8287E678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA9281B83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714D2D605;
	Mon, 18 Mar 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xnoeNPEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F292E40F;
	Mon, 18 Mar 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755649; cv=none; b=nGdidq5Z00vL+d1CBeTKL1bbpzLpgUjgxYQ69B6AhaO/tZrvZs8pBx5e0RcBXcrFONik/CkxHcBd71NquxztaWEGB4GzCC96J6qNhB/A0ue2eEVI+YruT508PwoQKvvUaHmHPsu4c/wkLM0RcG2mYO3KG1SIaO72kb7v4xYoDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755649; c=relaxed/simple;
	bh=SRglM2PBHV4RNTf7tLETeShVgLn5d55vx8MZNE7zvQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5FMdwDqAMFbnBrZxbDdBTCM75MYS4iiG6pkpzXbs4zKeKTEdp+d7gabsNc0OmVjqgc+dgdtHvlhoc041NZZnR8VdxNN64gXAzo45mvs7Py4xltiRhOjhJb+Bhib+yQAFlE+cSmowV66mB+S8CXekrghfIiPULL7yxinDqVaaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xnoeNPEI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710755639;
	bh=SRglM2PBHV4RNTf7tLETeShVgLn5d55vx8MZNE7zvQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xnoeNPEIL9MQK915O+a9dDj7qJx/fLSrZ0SOsAvnWDzUhpWc8UCi40xfYEcf0LVG2
	 6vlBOS0Z/YqF1rF1Y09Xdo0H/gh3g1uWK7V71J4vFxSjA0EX9QqWiXvh2/3WpwebR6
	 RsBPA4Yyf9xDs8OvWY1zDRVqMd44wEnA9B3JPjOrRGpn/Mf2/cIKmXa19mZ6BGV6Gn
	 twwXb7PzK1M1Nr/NLReSq9LxKBAliuCpog5EII/vqfh6F6GKT4icAzBPHCMIIalpJM
	 KFN0l6U++DWCcb/OkM+qDuj/c05daFoyxiXDIxMEykKVRfs2M/76AJW2lNLOOm81z3
	 KyiNZIQBt17Yw==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9BA15378203E;
	Mon, 18 Mar 2024 09:53:56 +0000 (UTC)
Message-ID: <cea072bf-0ae5-4d0d-b0db-cd2ac772f463@collabora.com>
Date: Mon, 18 Mar 2024 11:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/9] f2fs: Simplify the handling of cached insensitive
 names
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
 <20240305101608.67943-3-eugen.hristev@collabora.com>
 <87edcdk8li.fsf@mailhost.krisman.be>
 <aaa4561e-fd23-4b21-8963-7ba4cc99eed3@collabora.com>
 <8734sskha1.fsf@mailhost.krisman.be>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <8734sskha1.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 16:41, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>>> Please, make sure you actually stress test this patchset with fstests
>>> against both f2fs and ext4 before sending each new version.
>>
>> I did run the xfstests, however, maybe I did not run the full suite, or maybe I am
>> running it in a wrong way ?
> 
> No worries.  Did you manage to reproduce it?

Yes, thank you, using qemu on the x86_64 with your commands below.

While the oops was caused by that wrong kfree call, fixing it and moving further
got me into further problems.
I am unsure though how these patches cause it.

Here is a snippet of the problem that occurs now :

generic/417 12s ... [  616.265444] run fstests generic/417 at 2024-03-18 09:22:48
[  616.768435] ------------[ cut here ]------------
[  616.769493] WARNING: CPU: 4 PID: 133 at block/blk-merge.c:580
__blk_rq_map_sg+0x46a/0x480
[  616.771253] Modules linked in:
[  616.771873] CPU: 4 PID: 133 Comm: kworker/4:1H Not tainted
6.7.0-09941-g554c4640dff5 #18
[  616.773660] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
04/01/2014
[  616.775573] Workqueue: kblockd blk_mq_run_work_fn
[  616.776570] RIP: 0010:__blk_rq_map_sg+0x46a/0x480
[  616.777547] Code: 17 fe ff ff 44 89 58 0c 48 8b 01 e9 ec fc ff ff 43 8d 3c 06 48
8b 14 24 81 ff 00 10 00 00 0f 86 af fc ff ff e9 02 fe ff ff 90 <0f> 0b 90 e9 76 fd
ff ff 90 0f 0b 90 0f 0b 0f 1f 84 00 00 00 00 00
[  616.781245] RSP: 0018:ffff97e4804f3b98 EFLAGS: 00010216
[  616.782322] RAX: 000000000000005e RBX: 0000000000000f10 RCX: ffff8f5701eed000
[  616.783929] RDX: ffffdc0c4052df82 RSI: 0000000000001000 RDI: 00000000fffffffc
[  616.785426] RBP: 000000000000005e R08: 0000000000000000 R09: ffff8f5702120000
[  616.787065] R10: ffffdc0c4052df80 R11: 0000000000000000 R12: ffff8f5702118000
[  616.788650] R13: 0000000000000000 R14: 0000000000001000 R15: ffffdc0c4052df80
[  616.790129] FS:  0000000000000000(0000) GS:ffff8f577db00000(0000)
knlGS:0000000000000000
[  616.791826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  616.793069] CR2: 00007fbe596adc98 CR3: 000000001162e000 CR4: 0000000000350ef0
[  616.794528] Call Trace:
[  616.795093]  <TASK>
[  616.795541]  ? __warn+0x7f/0x130
[  616.796242]  ? __blk_rq_map_sg+0x46a/0x480
[  616.797101]  ? report_bug+0x199/0x1b0
[  616.797843]  ? handle_bug+0x3d/0x70
[  616.798656]  ? exc_invalid_op+0x18/0x70
[  616.799461]  ? asm_exc_invalid_op+0x1a/0x20
[  616.800313]  ? __blk_rq_map_sg+0x46a/0x480
[  616.801207]  ? __blk_rq_map_sg+0xfc/0x480
[  616.802213]  scsi_alloc_sgtables+0xae/0x2b0
[  616.803258]  sd_init_command+0x181/0x860
[  616.804111]  scsi_queue_rq+0x7c3/0xae0
[  616.804910]  blk_mq_dispatch_rq_list+0x2bf/0x7c0
[  616.805962]  __blk_mq_sched_dispatch_requests+0x40a/0x5c0
[  616.807226]  blk_mq_sched_dispatch_requests+0x34/0x60
[  616.808389]  blk_mq_run_work_fn+0x5f/0x70
[  616.809332]  process_one_work+0x136/0x2f0
[  616.810268]  ? __pfx_worker_thread+0x10/0x10
[  616.811320]  worker_thread+0x2ef/0x400
[  616.812215]  ? __pfx_worker_thread+0x10/0x10
[  616.813205]  kthread+0xd5/0x100
[  616.813907]  ? __pfx_kthread+0x10/0x10
[  616.814787]  ret_from_fork+0x2f/0x50
[  616.815598]  ? __pfx_kthread+0x10/0x10
[  616.816394]  ret_from_fork_asm+0x1b/0x30
[  616.817210]  </TASK>
[  616.817658] ---[ end trace 0000000000000000 ]---
[  616.818687] ------------[ cut here ]------------
[  616.819697] kernel BUG at drivers/scsi/scsi_lib.c:1068!


Do you have any ideas ?

Thanks !
Eugen

> 
>> How are you running the kvm-xfstests with qemu ? Can you share your command
>> arguments please ?
> 
> I don't use kvm-xfstests.  I run ./check directly:
> 
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=$BASEMNT/scratch
> export TEST_DEV=/dev/loop0
> export TEST_DIR=$BASEMNT/test
> export RESULT_BASE=${BASEMNT}/results
> export REPORT_DIR=${BASEMNT}/report
> export FSTYP=f2fs
> 
> mkfs.f2fs -f -C utf8 -O casefold ${TEST_DEV}
> 
> ./check -g encrypt,quick
> 


