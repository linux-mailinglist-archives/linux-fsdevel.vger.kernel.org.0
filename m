Return-Path: <linux-fsdevel+bounces-74875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJO0FgD4cGmgbAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:00:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0B59969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E20AAB222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14864C8FF6;
	Wed, 21 Jan 2026 15:19:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E254C8FE4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008748; cv=none; b=qaTDBw/QzYNMg0Jcn3xDcK0ng528+/gZNFkT/LEzWyrXfAbnPT2ChGciOrU+5l+mk41WeX8K6etcQsA39s42xWnH5pF4Fwx5+wS645IztXU0etTD2znOjIci6Qq+imxQznx88R1zghhwghGSFKtJV1oS1Qa/YxXkVHEqINTe/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008748; c=relaxed/simple;
	bh=YuXnJLYkLk2uKkBLXflQERqv7zm+hd95n3c3GCRo6gM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=angna1mLBbKQ+MWyC0Kc9PBvY4f7/mRRizEYIp5zXBMUMbebehY4JXwgXSm4Te9P+IVQ/XjO1P5IxK2M2IYqDvwSXw1jxVVrD5H+Joby2+rUYGepsap6l25yRi7mCsaE30BHEJyqwiyAkkWcmMJ+hdXpqmEB/cpUlSwlL9lxSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4044d3ff45eso6411815fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 07:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008742; x=1769613542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeQVUNuq6Jj805UQkuvBbP5+6wzVLu0wOcebiPPTiYY=;
        b=Wyggwpxvw+SlISZRgPWdZJkj0b/yrWwXIUvIUnXIvUN5J6CHCG3D8l7FeOBKmidzuq
         kL566WCJCSiVqGGXy8QZvzqJr9/ksJbBMdFZaOiT5rVjmcYSqcHIhSweVttsmhfg1ru7
         AbdXeBtZpOlGMiIrBM6Ai86DiO5FBIl6v+3ZCIerPjThz2v1NNHmzdVqLQJGE3hmS4Lb
         7XetX+ThGfGRiKtym3ejIqCFJfXSP6wbuCiDkWUr/s3X5mc+wdyZ6UonBWpatmD921IN
         MrmEF5pnw3HS4M1PWv1H7NMdUIHPby0hsql18RaYyNHg8WH+971uRv74RU2cvtWcIYym
         cAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVpbj+Ere81Yxy10cba4efScaRe1SEDERWc7eqtNBCPn3P1g7QK3DIVgbTfoxmmCYo4GtKRZJcaUUOGtrP0@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnvk1ynklRervTxj494Cp99p0Oen0fPxnb85trs9XeYOVWoKN
	CQwjpAh54JL/Qkr99Sn3lNV8Bv+d+yFkWon5S4RoTmlJIEv+P6YfhMXwun+5JNK49c/0NgxKvUO
	m/1kuq7YHsBfjv9FSaYRDDedaE4GsihUGMz1ZjqmwqL//5QB02AfMQpJhxlQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4df9:b0:662:c0e5:b70 with SMTP id
 006d021491bc7-662c0e50de5mr86282eaf.14.1769008742352; Wed, 21 Jan 2026
 07:19:02 -0800 (PST)
Date: Wed, 21 Jan 2026 07:19:02 -0800
In-Reply-To: <20260121150211.82216-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6970ee66.050a0220.706b.0011.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in __configfs_open_file
From: syzbot <syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74875-lists,linux-fsdevel=lfdr.de,f6e8174215573a84b797];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BAE0B59969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __configfs_open_file

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/6433 is trying to acquire lock:
ffff888027868d78 (&p->frag_sem_key){.+.+}-{4:4}, at: __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304

but task is already holding lock:
ffff888027868d78 (&p->frag_sem_key){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888027868d78 (&p->frag_sem_key){.+.+}-{4:4}, at: configfs_write_iter+0x219/0x4e0 fs/configfs/file.c:229

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&p->frag_sem_key);
  lock(&p->frag_sem_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz.0.17/6433:
 #0: ffff888063464478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1232
 #1: ffff88801efbc420 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #2: ffff8880760ba888 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x75/0x4e0 fs/configfs/file.c:226
 #3: ffff888027868d78 (&p->frag_sem_key){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff888027868d78 (&p->frag_sem_key){.+.+}-{4:4}, at: configfs_write_iter+0x219/0x4e0 fs/configfs/file.c:229
 #4: ffffffff8f409828 (target_devices_lock){+.+.}-{4:4}, at: target_core_item_dbroot_store+0x21/0x350 drivers/target/target_core_configfs.c:114

stack backtrace:
CPU: 0 UID: 0 PID: 6433 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x1106/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 down_read+0x9b/0x480 kernel/locking/rwsem.c:1537
 __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
 do_dentry_open+0x982/0x1530 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4134
 do_filp_open+0x20b/0x470 fs/namei.c:4161
 file_open_name+0x2a3/0x450 fs/open.c:1381
 filp_open+0x4b/0x80 fs/open.c:1401
 target_core_item_dbroot_store+0x108/0x350 drivers/target/target_core_configfs.c:134
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x306/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd76878eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7696dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd7689e5fa0 RCX: 00007fd76878eec9
RDX: 0000000000000fff RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fd768811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd7689e6038 R14: 00007fd7689e5fa0 R15: 00007ffe6bade968
 </TASK>
db_root: not a directory: /sys/kernel/config/target/dbroot


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c307fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5
dashboard link: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d7979a580000


