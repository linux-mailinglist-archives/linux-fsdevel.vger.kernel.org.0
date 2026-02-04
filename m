Return-Path: <linux-fsdevel+bounces-76350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ4hG7uxg2n9swMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:53:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A0EC999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB05E30209C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59643C06C;
	Wed,  4 Feb 2026 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="y5ZUgxCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95C43C04D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238373; cv=none; b=shQ+KigPUx4xWTqD/5DMSUY3CnrcLqgmo29HMTFiB+lsih63WMAvLFKHYIW0C43WkIwRzysFc1RqaD5UIdthXru5Th2C5IMCvuAY5rv9DINJXDQ+gMSzgkbefUdQqvkcAmPdTgOndVagP0ynqjYYGsdXoLxrKkmRU6ebzHkRe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238373; c=relaxed/simple;
	bh=alGhJXGGY6Iz2Si5V/0nyHNmqevF+XB3BsJv8FreziA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ971RB2hhdfSR+9ILIngIOKzCPSY68eC1lVQ2OPOY4Zp/ADzMb/SzzZEERW0sCfh2gzGJGyO4KhsDRevamXN2/4tnZBxLgFVG41snpqzp0pPA2ZTiZsgiy79yzGw3pbduQWiI5YM3ceALMbiKGHU+umNPi5Oy+sTLe/BRomNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=y5ZUgxCl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794ed669269so5041887b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770238372; x=1770843172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElXV7L8yNNTd3x7ycBpeFNQKlfvA3rXKb0tVCq9jgFY=;
        b=y5ZUgxClAlXy8dc8TL9f055hHbxvqR+td3WAu94ThLhTwJ8kDSC2Oqyd+VBSAA6iH6
         EneKrGpKfu5+qQ7j8bQIMTj4tcUSYIgmShSkwbG/XIMQ48ZCxrP3By5Yout6oL6E+Ybw
         /cja7Q5aFk38h0zf9RTQICRgX6zDYgrOjhlVP2REm8wuBkVl0v2WLtagCtU9Hd0MKZOZ
         8wXmis7p7+6XL/tivmMWxdWL/yc6XL8yZda23HHx0/ttgETuMwZ3xBwLu+3Hg+eNAEG4
         BHas/JpMNY12Qud7gSbFHtVbWREPoaGkAq4YcMqXPb82kNJxbX8VqvG0Gs6eYLAt7sVJ
         5LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770238372; x=1770843172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElXV7L8yNNTd3x7ycBpeFNQKlfvA3rXKb0tVCq9jgFY=;
        b=fzpTsEzAzsTeiMKBkPrbDbePUd+w4snOnvYmTVz/Lw8ZcwDUT8swGw191ZKtFFHqnd
         WYrjpmUlZNZzmfAyPw8j8MSL//nZRbJ66iCBw173OP9ghP4oMozzavD6cgnz7NvRCLNZ
         BGWxDsayWtowFAMW/bBhY3f7X05ph0g3/nT2oQFMlrozXqpVbxHZGQkpymSO8NfvjSxu
         1WvQGiACEO8OknE/teVuTHhws1182k/gfhpWRBW/lx5lY8uK2pNNFvvGtl2V1aAsKhj4
         vBQlOCFYw8hn6u4pdaktMXAaXUTJyjJtvkJpPcieTaryg09jXKIDJjkyt/ni3oWw33hf
         M0hw==
X-Gm-Message-State: AOJu0YwXe/nM0ZyjePTxdJMnjHJBg+IOSEx+0DPc+P1UxJJoWB9n6JD7
	EcCMakjK2uSalIiZ25O5PieIOQ+GQOBzXD7cLUJOkRdWJ/jJ1yys50UoY893ncWrWv0=
X-Gm-Gg: AZuq6aKqvhvLSImFp2ZPv0kaLFc7Vtzycm1VlAZLlFQykVT463NIWf6gO2dnF0RmuIW
	lWOXJON6bWCi3FHq/p67io3Q/hB95ous736DIK4Uzt/LY67jc9bUxot96HHfmUH6jbUsXzjOxsd
	Xdp5DsRLai/Mw+mhp5OaQlR8sc6AVBGYA4cuztd7TPQkCsT7c7ATwzQCKA6F90xmgPlnpfQLMTX
	piiDajpLc4n6KKl632QNby0Cahw/jQYpp2uJo/UfLo5q3nd/DulZv0bnl7nNDN3x1QL7njVL6k0
	O/CILJJCnUY8HfcfGpHWipCzgWRpD7gWbyHOoigAdhZyJ1eycKcREpdws/b3khApaAc+esnmnub
	hRLPQ6LUu5O0Xos8NwPnmqFQxJIyZMOyi5AK9QE9VRAS5gSE7jkGqOM9T/m2lldm5xVSfkUqROb
	1ZBDUENdrIyJ4S9OzH74iOdwGR9Cmn59SQlb24OsWvOpItSPh2Dbks5EoVC+0uewx2diRQVbw3m
	NWGr3O2FlPKqKZnGs0=
X-Received: by 2002:a05:690c:399:b0:78f:cd29:51b9 with SMTP id 00721157ae682-7951539d963mr5990267b3.10.1770238372246;
        Wed, 04 Feb 2026 12:52:52 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:9097:bcaa:e172:33af])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794feed1a2dsm30349297b3.25.2026.02.04.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:52:51 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	pdonnell@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	khiremat@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH v7] ceph: fix kernel crash in ceph_open()
Date: Wed,  4 Feb 2026 12:51:59 -0800
Message-ID: <20260204205158.1521777-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-76350-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,redhat.com];
	DMARC_NA(0.00)[dubeyko.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,ceph.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C28A0EC999
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The CephFS kernel client has regression starting from 6.18-rc1.

sudo ./check -g quick
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAMIC Fri
Nov 14 11:26:14 PST 2025
MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch
/mnt/cephfs/scratch

Killed

Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
(2)192.168.1.213:3300 session established
Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
dereference, address: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read access in
kernel mode
Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) - not-
present page
Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SMP KASAN
NOPTI
Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 Comm:
xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Standard PC
(i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 90 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
cc cc 31
Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875c0
EFLAGS: 00010246
Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RBX:
ffff888116003200 RCX: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff88810126c900
Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R08:
0000000000000000 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R14:
0000000000000000 R15: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(0000)
GS:ffff8882401a4000(0000) knlGS:0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR3:
0000000110ebd001 CR4: 0000000000772ef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
ceph_mds_check_access+0x348/0x1760
Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
__kasan_check_write+0x14/0x30
Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x170
Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
__pfx_apparmor_file_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
__ceph_caps_issued_mask_metric+0xd6/0x180
Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x10e0
Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
__pfx_stack_trace_save+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
stack_depot_save_flags+0x28/0x8f0
Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x450
Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
__pfx__raw_spin_lock_irqsave+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0x2b0
Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
__check_object_size+0x453/0x600
Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x180
Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
__pfx_do_sys_openat2+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/0x240
Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
__pfx___x64_sys_openat+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
__pfx___handle_mm_fault+0x10/0x10
Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2350
Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd50
Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
fpregs_assert_state_consistent+0x5c/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0xd50
Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x11/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
count_memcg_events+0x25b/0x400
Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b/0x6a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x11/0x20
Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
fpregs_assert_state_consistent+0x5c/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
irqentry_exit_to_user_mode+0x2e/0x2a0
Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x50
Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0x100
Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d 00 00
41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff
b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48
2b 14 25
Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316d0
EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RBX:
0000000000000002 RCX: 000074a85bf145ab
Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RSI:
00007ffc77d32789 RDI: 00000000ffffff9c
Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R08:
00007ffc77d31980 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R14:
0000000000000180 R15: 0000000000000001
Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core
pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_intel
rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgastate
serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp
parport efi_pstore
Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000000000000
]---
Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x40
Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 90 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
cc cc 31
Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875c0
EFLAGS: 00010246
Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RBX:
ffff888116003200 RCX: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff88810126c900
Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R08:
0000000000000000 R09: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R14:
0000000000000000 R15: 0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(0000)
GS:ffff8882401a4000(0000) knlGS:0000000000000000
Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR3:
0000000110ebd001 CR4: 0000000000772ef0
Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554

We have issue here [1] if fs_name == NULL:

const char fs_name = mdsc->fsc->mount_options->mds_namespace;
    ...
    if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
            / fsname mismatch, try next one */
            return 0;
    }

v2
Patrick Donnelly suggested that: In summary, we should definitely start
decoding `fs_name` from the MDSMap and do strict authorizations checks
against it. Note that the `--mds_namespace` should only be used for
selecting the file system to mount and nothing else. It's possible
no mds_namespace is specified but the kernel will mount the only
file system that exists which may have name "foo".

v3
The namespace_equals() logic has been generalized into
__namespace_equals() with the goal of using it in
ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.

v4
The __namespace_equals() now supports wildcard check.

v5
Patrick Donnelly suggested to add the sanity check of
kstrdup() returned pointer in ceph_mdsmap_decode()
added logic. Also, he suggested much simpler logic of
namespace strings comparison in the form of
ceph_namespace_match() logic.

v6
Only ceph_namespace_match() compares the names
with CEPH_NAMESPACE_WILDCARD.

v7
Ilya Dryomov suggested cleanup in ceph_mdsmap_decode(),
ceph_namespace_match(), and rollback the logic of
namespace_equals().

This patch reworks ceph_mdsmap_decode() and namespace_equals() with
the goal of supporting the suggested concept. Now struct ceph_mdsmap
contains m_fs_name field that receives copy of extracted FS name
by ceph_extract_encoded_string(). For the case of "old" CephFS file systems,
it is used "cephfs" name. Also, namespace_equals() method has been
reworked with the goal of proper names comparison.

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.c#L5666
[2] https://tracker.ceph.com/issues/73886

Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c         | 11 +++++------
 fs/ceph/mdsmap.c             | 26 +++++++++++++++++++-------
 fs/ceph/mdsmap.h             |  1 +
 fs/ceph/super.h              | 16 ++++++++++++++--
 include/linux/ceph/ceph_fs.h |  6 ++++++
 5 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7e4eab824dae..a4b9254b74a5 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
 	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
 	struct ceph_client *cl = mdsc->fsc->client;
-	const char *fs_name = mdsc->fsc->mount_options->mds_namespace;
+	const char *fs_name = mdsc->mdsmap->m_fs_name;
 	const char *spath = mdsc->fsc->mount_options->server_path;
 	bool gid_matched = false;
 	u32 gid, tlen, len;
@@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "fsname check fs_name=%s  match.fs_name=%s\n",
 	      fs_name, auth->match.fs_name ? auth->match.fs_name : "");
-	if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
+
+	if (!ceph_namespace_match(auth->match.fs_name, fs_name)) {
 		/* fsname mismatch, try next one */
 		return 0;
 	}
@@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 {
 	struct ceph_fs_client *fsc = mdsc->fsc;
 	struct ceph_client *cl = fsc->client;
-	const char *mds_namespace = fsc->mount_options->mds_namespace;
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
 	u32 epoch;
@@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		namelen = ceph_decode_32(&info_p);
 		ceph_decode_need(&info_p, info_end, namelen, bad);
 
-		if (mds_namespace &&
-		    strlen(mds_namespace) == namelen &&
-		    !strncmp(mds_namespace, (char *)info_p, namelen)) {
+		if (namespace_equals(fsc->mount_options,
+				     (char *)info_p, namelen)) {
 			mount_fscid = fscid;
 			break;
 		}
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 2c7b151a7c95..b228e5ecfb92 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -353,22 +353,33 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		__decode_and_drop_type(p, end, u8, bad_ext);
 	}
 	if (mdsmap_ev >= 8) {
-		u32 fsname_len;
+		size_t fsname_len;
+
 		/* enabled */
 		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
+
 		/* fs_name */
-		ceph_decode_32_safe(p, end, fsname_len, bad_ext);
+		m->m_fs_name = ceph_extract_encoded_string(p, end,
+							   &fsname_len,
+							   GFP_NOFS);
+		if (IS_ERR(m->m_fs_name)) {
+			m->m_fs_name = NULL;
+			goto nomem;
+		}
 
 		/* validate fsname against mds_namespace */
-		if (!namespace_equals(mdsc->fsc->mount_options, *p,
+		if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs_name,
 				      fsname_len)) {
-			pr_warn_client(cl, "fsname %*pE doesn't match mds_namespace %s\n",
-				       (int)fsname_len, (char *)*p,
+			pr_warn_client(cl, "fsname %s doesn't match mds_namespace %s\n",
+				       m->m_fs_name,
 				       mdsc->fsc->mount_options->mds_namespace);
 			goto bad;
 		}
-		/* skip fsname after validation */
-		ceph_decode_skip_n(p, end, fsname_len, bad);
+	} else {
+		m->m_enabled = false;
+		m->m_fs_name = kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
+		if (!m->m_fs_name)
+			goto nomem;
 	}
 	/* damaged */
 	if (mdsmap_ev >= 9) {
@@ -430,6 +441,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
 		kfree(m->m_info);
 	}
 	kfree(m->m_data_pg_pools);
+	kfree(m->m_fs_name);
 	kfree(m);
 }
 
diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
index 1f2171dd01bf..d48d07c3516d 100644
--- a/fs/ceph/mdsmap.h
+++ b/fs/ceph/mdsmap.h
@@ -45,6 +45,7 @@ struct ceph_mdsmap {
 	bool m_enabled;
 	bool m_damaged;
 	int m_num_laggy;
+	char *m_fs_name;
 };
 
 static inline struct ceph_entity_addr *
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a1f781c46b41..29a980e22dc2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -104,14 +104,26 @@ struct ceph_mount_options {
 	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
+#define CEPH_NAMESPACE_WILDCARD		"*"
+
+static inline bool ceph_namespace_match(const char *pattern,
+					const char *target)
+{
+	if (!pattern || !pattern[0] ||
+	    !strcmp(pattern, CEPH_NAMESPACE_WILDCARD))
+		return true;
+
+	return !strcmp(pattern, target);
+}
+
 /*
  * Check if the mds namespace in ceph_mount_options matches
  * the passed in namespace string. First time match (when
  * ->mds_namespace is NULL) is treated specially, since
  * ->mds_namespace needs to be initialized by the caller.
  */
-static inline int namespace_equals(struct ceph_mount_options *fsopt,
-				   const char *namespace, size_t len)
+static inline bool namespace_equals(struct ceph_mount_options *fsopt,
+				    const char *namespace, size_t len)
 {
 	return !(fsopt->mds_namespace &&
 		 (strlen(fsopt->mds_namespace) != len ||
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index c7f2c63b3bc3..08e5dbe15ca4 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -31,6 +31,12 @@
 #define CEPH_INO_CEPH   2            /* hidden .ceph dir */
 #define CEPH_INO_GLOBAL_SNAPREALM  3 /* global dummy snaprealm */
 
+/*
+ * name for "old" CephFS file systems,
+ * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
+ */
+#define CEPH_OLD_FS_NAME	"cephfs"
+
 /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
 #define CEPH_MAX_MON   31
 
-- 
2.52.0


