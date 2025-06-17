Return-Path: <linux-fsdevel+bounces-51893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D34ADC903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23FD3B4451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280D2BF3E4;
	Tue, 17 Jun 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YVrUHrlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63C1FC0F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158284; cv=none; b=IG322XyFeLKV3NGl/ZsZbLD6pEVQ83nPAfRWem3BjNkDSHA9qSdYCMj9/Q3SIKmVrxX4TUIX4mg6wjowm/5JHTi1/oTyt0L9FzGMVxsRE00yVaXY9tAjAJboChJD9MHUEKJdpDuhTx5mEjb2vnkoEkC3SwnHB7aFvyT3HcCI0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158284; c=relaxed/simple;
	bh=H3HVqApQgrFGM+kwZRmYyONDVW5UAAIvW92q4grLZd4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qK9XxEeJLM2tR29p1vG24Msyqb2T35/+1hrEBPHOVwCozNqBEVivs3mRy6oLDL/TUQZQRMZ9a/b3ASctQGsISHVCtRZttIH9dCFz9NdbtNimj9JtltcTelspxjb5G05Mvv1mMMhB58LC0C1euzvS68UuI2uNg4appbJFTk9pZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YVrUHrlm; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:832b:0:640:fda5:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 66797608CE;
	Tue, 17 Jun 2025 14:04:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b4K1t7ALia60-yNYhCcCW;
	Tue, 17 Jun 2025 14:04:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750158277; bh=CU7pgQqFSo0127PAN7ThHQzOVrDsZDrReYs0XETnYuo=;
	h=Subject:To:From:Cc:Date:Message-ID;
	b=YVrUHrlmqWBdY1PhZAE0/v7Nfitsz/iFDwvCKLwj2IVfyFgJMbbretMwVpomtFsgS
	 DnNzZteDn0dIPdNNGC68dRN1f6WlU2/5wDPE71rR2P5Hv5w0yFIEgQnoz/RVJk8+0C
	 HHLiDR8S2AXXpLbt3SEu2xvLraPEDC7ykO2lsrE8=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
Date: Tue, 17 Jun 2025 14:04:37 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: On possible data race in pollwake() / poll_schedule_timeout()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Running both syzbot reproducers and even during regular system boots,
KCSAN is likely to report the data race around using 'triggered' flag
of 'struct poll_wqueues'. Suspected race may be either read vs. write
(observed locally during system boot):

BUG: KCSAN: data-race in poll_schedule_timeout / pollwake

write to 0xffffc90004397b90 of 4 bytes by task 5619 on cpu 4:
  pollwake+0xd1/0x130
  __wake_up_common_lock+0x7f/0xd0
  sock_def_readable+0x20e/0x590
  unix_dgram_sendmsg+0xa3a/0x1050
  unix_seqpacket_sendmsg+0xdb/0x140
  __sock_sendmsg+0x151/0x190
  sock_write_iter+0x172/0x1c0
  vfs_write+0x66d/0x6f0
  ksys_write+0xe7/0x1b0
  __x64_sys_write+0x4a/0x60
  x64_sys_call+0x2f35/0x32b0
  do_syscall_64+0xfa/0x3b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffc90004397b90 of 4 bytes by task 5620 on cpu 2:
  poll_schedule_timeout+0x96/0x160
  do_sys_poll+0x966/0xb30
  __se_sys_ppoll+0x1c3/0x210
  __x64_sys_ppoll+0x71/0x90
  x64_sys_call+0x3079/0x32b0
  do_syscall_64+0xfa/0x3b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

or concurrent write (example taken from
https://syzkaller.appspot.com/bug?extid=4c7af974f816af4ede2a):

BUG: KCSAN: data-race in pollwake / pollwake

write to 0xffffc90000e539e0 of 4 bytes by task 3308 on cpu 1:
  __pollwake fs/select.c:195 [inline]
  pollwake+0xb6/0x100 fs/select.c:215
  __wake_up_common kernel/sched/wait.c:89 [inline]
  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
  __wake_up_sync_key+0x4f/0x80 kernel/sched/wait.c:173
  anon_pipe_write+0x8ba/0xaa0 fs/pipe.c:594
  new_sync_write fs/read_write.c:593 [inline]
  vfs_write+0x4a0/0x8e0 fs/read_write.c:686
  ksys_write+0xda/0x1a0 fs/read_write.c:738
  __do_sys_write fs/read_write.c:749 [inline]
  __se_sys_write fs/read_write.c:746 [inline]
  __x64_sys_write+0x40/0x50 fs/read_write.c:746
  x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffffc90000e539e0 of 4 bytes by task 4163 on cpu 0:
  __pollwake fs/select.c:195 [inline]
  pollwake+0xb6/0x100 fs/select.c:215
  __wake_up_common kernel/sched/wait.c:89 [inline]
  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
  __wake_up_sync_key+0x4f/0x80 kernel/sched/wait.c:173
  anon_pipe_write+0x8ba/0xaa0 fs/pipe.c:594
  new_sync_write fs/read_write.c:593 [inline]
  vfs_write+0x4a0/0x8e0 fs/read_write.c:686
  ksys_write+0xda/0x1a0 fs/read_write.c:738
  __do_sys_write fs/read_write.c:749 [inline]
  __se_sys_write fs/read_write.c:746 [inline]
  __x64_sys_write+0x40/0x50 fs/read_write.c:746
  x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

Using _ONCE() seems makes KCSAN quiet, i.e.:

diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..082cf60c7e23 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -192,7 +192,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
          * and is paired with smp_store_mb() in poll_schedule_timeout.
          */
         smp_wmb();
-       pwq->triggered = 1;
+       WRITE_ONCE(pwq->triggered, 1);

         /*
          * Perform the default wake up operation using a dummy
@@ -237,7 +237,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
         int rc = -EINTR;

         set_current_state(state);
-       if (!pwq->triggered)
+       if (!READ_ONCE(pwq->triggered))
                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
         __set_current_state(TASK_RUNNING);

but I'm curious whether this is a real fix for the real bug or
KCSAN is just unable to handle smp_wmb()/smp_store_mb() trick.

Dmitry





