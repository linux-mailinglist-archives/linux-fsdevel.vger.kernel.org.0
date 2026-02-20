Return-Path: <linux-fsdevel+bounces-77795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK9hM7t5mGlrJAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:11:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39723168C81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78C053026A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3B31D390;
	Fri, 20 Feb 2026 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="pEssDuhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CD24A069
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600309; cv=none; b=CxHo3WXNdFScoR2gDUGs5bBFTvQ2Va5877K3fufdu4glQwOju3h52PhWX7Q4/Ov6fxzFKepSWUiUKc7JsdB7HC87h7xgT72guUSsbk4zwsIp5VbNFk+2dK6y00Q+GkYcs/ko56P023RQV1vYYj4h0Ca9ovIci04z8pktuEGfECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600309; c=relaxed/simple;
	bh=AFCwsQchniq5Ct/0zSHxCNporRW4LFINkHnHbWVgKns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLsVu/9gjnrv1c8TwHKnoT5paAyoIoWqTAGvB/JrW5PKCe2LhmM5P4+ZxQaVL9dLS4UPyCdZ//X3qq97kK5vKaaI/3qsrN+dXEmHCAttS7KScYWMEriy9lckR3C7KtAAFnQ3BtpjlGXM5XuOuArI7VpMs9T4HrzLlpuz3tKah7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=pEssDuhy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id D970143B7F;
	Fri, 20 Feb 2026 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1771600305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAiWFyJtoTkxycY/okFAt+8IZwUDqvdCNobzVb9agLM=;
	b=pEssDuhyMYtr7MqnrSB7pkqy5IoF0yEaNeTFV5DJaT8/mXK9bKTIQEfEe73nuQpwWMRNVn
	yOV54M0ln2z8a0HfNxK1X/+oUkbMEugu++fj4fubPgeNjvEYlzgsvy4JwBvG5dFGaLjoS3
	7ARP9/zkSxpEH0eLCCgoQ4In97uE6InUbAOTdCSHZvwsBiP26WrJNL5jCrC4NM6Fu9EXTM
	Q5ROsd+JLM2ZBv0gZ7mBDffhFCcPtllIHPKosswxbNd6C9XnyXVleE6bfWkldJGj4KEdFC
	9xjS0X1wLmYaK1gBLJtidhFjfWG2+q5Ea9VpJiQ5/y8w7bPVHW08DnwBIX/Leg==
Message-ID: <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
Date: Fri, 20 Feb 2026 16:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
Content-Language: en-GB
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhohgjtgfgsehtjeertddtvdejnecuhfhrohhmpefiuhhilhhlrghumhgvucfvuhgtkhgvrhcuoehgthhutghkvghrsehgthhutghkvghrrdhioheqnecuggftrfgrthhtvghrnhepfeetteevvedtudduveevgeffhfegheffvefhlefggfegtdeljeevveeggefhgfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinhhkpdhgihhtlhgrsgdrtghomhdpughotghkvghrrdhiohenucfkphepvddttddumeekiedumeegrgegtdemkeeivddtmeeivgehheemrggvrgehmeduuggsleemtghfvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeegrgegtdemkeeivddtmeeivgehheemrggvrgehmeduuggsleemtghfvddtpdhhvghloheplgfkrfggieemvddttddumeekiedumeegrgegtdemkeeivddtmeeivgehheemrggvrgehmeduuggsleemtghfvddtngdpmhgrihhlfhhrohhmpehgthhutghkvghrsehgthhutghkvghrrdhiohdpqhhiugepffeljedtudegfeeujefhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpt
 hhtohepkedprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmjhhguhiiihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gtucker.io:s=gm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77795-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[gtucker.io];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[gtucker.io:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gtucker@gtucker.io,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 39723168C81
X-Rspamd-Action: no action

Hi Christian et al,

On 20/01/2026 15:52, Christian Brauner wrote:
> Mateusz reported performance penalties [1] during task creation because
> pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> rhashtable to have separate fine-grained locking and to decouple from
> pidmap_lock moving all heavy manipulations outside of it.
> 
> Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> protection to an rhashtable. This removes the global pidmap_lock
> contention from pidfs_ino_get_pid() lookups and allows the hashtable
> insert to happen outside the pidmap_lock.
> 
> pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> into the rhashtable can fail and memory allocation may happen so we need
> to drop the spinlock.
> 
> To guard against accidently opening an already reaped task
> pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> it already went through pidfs_exit() aka the process as already reaped.
> If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> the task has exited.
> 
> This slightly changes visibility semantics: pidfd creation is denied
> after pidfs_exit() runs, which is just before the pid number is removed
> from the via free_pid(). That should not be an issue though.
> 
> Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v2:
> - Ensure that pid is removed before call_rcu() from pidfs.
> - Don't drop and reacquire spinlock.
> - Link to v1: https://patch.msgid.link/20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org
> ---
>  fs/pidfs.c            | 81 +++++++++++++++++++++------------------------------
>  include/linux/pid.h   |  4 +--
>  include/linux/pidfs.h |  3 +-
>  kernel/pid.c          | 13 ++++++---
>  4 files changed, 46 insertions(+), 55 deletions(-)

[...]

> diff --git a/kernel/pid.c b/kernel/pid.c
> index ad4400a9f15f..6077da774652 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -43,7 +43,6 @@
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  #include <linux/pidfs.h>
> -#include <linux/seqlock.h>
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  
> @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
>  EXPORT_SYMBOL_GPL(init_pid_ns);
>  
>  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> -seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
>  
>  void put_pid(struct pid *pid)
>  {
> @@ -141,9 +139,9 @@ void free_pid(struct pid *pid)
>  
>  		idr_remove(&ns->idr, upid->nr);
>  	}
> -	pidfs_remove_pid(pid);
>  	spin_unlock(&pidmap_lock);
>  
> +	pidfs_remove_pid(pid);
>  	call_rcu(&pid->rcu, delayed_put_pid);
>  }

There appears to be a reproducible panic in rcu since next-20260216
at least while running KUnit.  After running a bisection I found that
it was visible at a merge commit adding this patch 44e59e62b2a2
("Merge branch 'kernel-7.0.misc' into vfs.all").  I then narrowed it
down further on a test branch by rebasing the pidfs series on top of
the last known working commit:

    https://gitlab.com/gtucker/linux/-/commits/kunit-rcu-debug-rebased

I also did some initial investigation with basic printk debugging and
haven't found anything obviously wrong in this patch itself, although
I'm no expert in pidfs...  One symptom is that the kernel panic
always happens because the function pointer to delayed_put_pid()
becomes corrupt.  As a quick hack, if I just call put_pid() in
free_pid() rather than go through rcu then there's no panic - see the
last commit on the test branch from the link above.  The issue is
still in next-20260219 as far as I can tell.

Here's how to reproduce this, using the new container script and a
plain container image to run KUnit vith QEMU on x86:

scripts/container -s -i docker.io/gtucker/korg-gcc:kunit -- \
    tools/testing/kunit/kunit.py \
    run \
    --arch=x86_64 \
    --cross_compile=x86_64-linux-

The panic can be seen in .kunit/test.log:

    [gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40
    Oops: invalid opcode: 0000 [#2] SMP NOPTI
    CPU: 0 UID: 0 PID: 197 Comm: kunit_try_catch Tainted: G      D          N  6.19.0-09950-gc33cbc7ffae4 #77 PREEMPT(lazy)
    Tainted: [D]=DIE, [N]=TEST
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.1 11/11/2019
    RIP: 0010:0xffffffff99026d42

Looking at the last rcu callbacks that were enqueued with my extra
printk messages:

$ grep call_rcu .kunit/test.log | tail -n16
[gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
[gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
[gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
[gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
[gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
[gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
[gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
[gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
[gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
[gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
[gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
[gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
[gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
[gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
[gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
[gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0

and then the ones that were called:

$ grep rcu_do_batch .kunit/test.log | tail
[gtucker] rcu_do_batch:2609 count=7 func=ffffffff98887ae0
[gtucker] rcu_do_batch:2609 count=8 func=ffffffff98887ae0
[gtucker] rcu_do_batch:2609 count=9 func=ffffffff98887ae0
[gtucker] rcu_do_batch:2609 count=1 func=ffffffff98ccc1a0
[gtucker] rcu_do_batch:2609 count=2 func=ffffffff98887ae0
[gtucker] rcu_do_batch:2609 count=3 func=ffffffff988b7cd0
[gtucker] rcu_do_batch:2609 count=4 func=ffffffff988b7cd0
[gtucker] rcu_do_batch:2609 count=5 func=ffffffff988b7cd0
[gtucker] rcu_do_batch:2609 count=6 func=ffffffff98ccc1a0
[gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40

we can see that the last pointer ffffffff99026d40 was never enqueued,
and the one from free_pid() ffffffff988adaf0 was never dequeued.
This is where I stopped investigating as it looked legit and someone
else might have more clues as to what's going on here.  I've only
seen the problem with this callback but again, KUnit is a very narrow
kind of workload so the root cause may well be lying elsewhere.

Please let me know if you need any more debugging details or if I can
help test a fix.  Hope this helps!

Cheers,
Guillaume


