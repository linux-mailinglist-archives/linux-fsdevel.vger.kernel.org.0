Return-Path: <linux-fsdevel+bounces-78652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADL8IaLJoGmDmgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:30:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F153D1B06C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99A5E300AED1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCD2D837C;
	Thu, 26 Feb 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="uu394tH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936732B994
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145052; cv=none; b=DrLg3X1QR2h7ZT2/To9pEvT9yklMbgQn9vghQ+d9vePtSQNOaCyWw1j8eD5N3FfI1ww4sWqkJ/RZtW8Ny917nRzqGyxC6ph5u/Y/ayyvrcL4RsP1fISC/xZ5D3o2+fQTTW3aF7izYkPpyeGUshU3ucWVtDYXJuNZE0ildbPK3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145052; c=relaxed/simple;
	bh=FxYMhvBjBM0BHSdizfT2WVLFD3pWp6rf+jYF6FWVUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gy1Iqr1sbje+GCgFD4XrogdCW2TFedTcdSHc+Jndi47hDb6mk4FmapzJHvQ90qOWiX9NcAqkEuijUs5VuoNYKWIUVTW6jJjzmASxvM8F9MSEfHea6tiXllfRouKjANr/V2NMY44AMwcBKuRb6FCJjPxpZ3Km0VASpHkch5bNqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=uu394tH/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c65d772cso713524a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1772145049; x=1772749849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCx770OdU9e2p7LOpVy++ngxzkOfJorbuzrGjVrYCJM=;
        b=uu394tH/HPOBxJ4SG8Lb7w0HARpIA8C+Sgj8I+pKrtZ7d0EF/wz6OoHH43qjQ3r7DK
         QoNgFy1JoNn2qPtgHQe/M5NxGYj9Rh8YtmJfK8vglIeoifPa4EXA1EpuT0bScPgmhaRU
         l0Cma5zSoHPiZ4gGsAliaCIcKA/bWZ82zylQDs4ZUrsXKd79NE5QMFzNgtD/8q6WYXJr
         /cgOQM5TQ242uZVqORAriQ2njmJugEbnHhBUdvu0n2kvdVGPB/ySQwYxtyIkGo1LKMW6
         pzLUFE0LXFT/bbu0SnQM7lpd+KMcljzscDzL68t5Y2z0kihrilAQzk++FbguhLJDJqa0
         lpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145049; x=1772749849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCx770OdU9e2p7LOpVy++ngxzkOfJorbuzrGjVrYCJM=;
        b=PssBQ2zwNtgAyMK/zkOI/EpdLDp/0EIRmwpRM0dxEOsZLPJXcXMvvO8857rOHmAGuC
         RcfuzJZQLMEQ/JiJo3niqnxlwXp7KdvdMh5O0t06D1u0+ILulDItIOQcrsFZOe1Mt6Ih
         XOX9Zy/47Tox7Fkwa5MD14u8SdIIaZQX4GEIM0GXw7kMkUUiC6FbuTYMPoWVYBOGy9oi
         SxxLZozWOX9z+GhXILo091dOBPkJaf/XH1pJW6+KiHyyWk8Hw4hPkNdT0GD4OXlcOaPo
         0Cik5Z0xwyyER2K97pehmDtHMEqiEpNP9g8LrLR9aSevK8mERH0LLXpCVh6jsSwOtsJF
         +hlg==
X-Forwarded-Encrypted: i=1; AJvYcCXH0cMEZ6tXei3ssGRfG9k6vmVR+w5Gdrpl9JNFPT81UL+cr3g5cDklqrVSTSeep3T2/CYoqEbwB0ntAEDe@vger.kernel.org
X-Gm-Message-State: AOJu0YySOI7l3gdTl9IuxIrSRzhXOgqczqqHdGcGIr1FLiCVcNCCH1fY
	luETA+vArUxKKigSWKu+a57zYHROenwLX5R4PixiUBXwLumN5XSJBackpyVOKjLyXVc=
X-Gm-Gg: ATEYQzx6jeLP4NPt4QiVZ9T04TQ86467FC9LUTlkS8ZARuDZZ6spemuQVaCJZmgGmpw
	8RaGMJ1vFAln9kVSYHJZkzIpoTqdbwqNwlxMRtLy4OXPoujq6dTS87fsZtj/MPZ/WTp2cKX4TsR
	OYKrYuob1Jia8hZkWDlY5W1gAYVEeNvfi3+IMzua2lFLVo4GWkRsOvc4npENQ2npmSh7007rLkO
	BxoLZ2it8EqvU1TkBlTRtFHK96R8VjQif0Ga+mGPeoKaqEcp9NsEtQwFL0qmoltr43qbXZVkjZR
	cdpJ8E/qSRabGJU1Yml3qhioHHgC9y6t80z7ENK+knERb3Qp3bLq2NA4gqYFv/N6Zi67O6ixtJt
	vTX6WaAA7/5wgKPCQti2BD+bfdTVINxVPSkJqb7FiYl6ff1zdL6B4nWr8sM+7icdlPZbY1zqmfn
	1qBDf2Jx2etjK9ScJW0LQnMQUWRHKktxIvJOA4c6KkgjoG7pcgjogPxb434T7dyWP/xIC1OYx+W
	KLjdYq1eB9qGpZwGthJymVFlbpwQHk=
X-Received: by 2002:a05:6870:55d0:b0:3e8:9bbb:36b7 with SMTP id 586e51a60fabf-41626e284demr542911fac.22.1772145049039;
        Thu, 26 Feb 2026 14:30:49 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:7abb:4dac:fae4:4e2d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d9absm3190276fac.16.2026.02.26.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 14:30:48 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH] ceph: fix kernel memory exposure issue in ceph_netfs_issue_op_inline()
Date: Thu, 26 Feb 2026 14:30:42 -0800
Message-ID: <20260226223042.2027550-1-slava@dubeyko.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78652-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,ibm.com,dubeyko.com];
	DMARC_NA(0.00)[dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F153D1B06C4
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Repeatable running of generic/013 test has revealed
the kernel memory exposure attempt for 6.19.0-rc8+ in
ceph_netfs_issue_op_inline():

while true; do
  sudo ./check generic/013
done

[17660.888303] ceph: ceph_netfs_issue_op_inline():317 iinfo->inline_data ffff8881000b0112,
iinfo->inline_len 0, subreq->start 328187904, subreq->len 4096, len 0
[17660.891728] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmemleak_object' (offset 274, size 4096)!
[17660.893370] ------------[ cut here ]------------
[17660.893377] kernel BUG at mm/usercopy.c:102!
[17660.894426] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[17660.895749] CPU: 1 UID: 0 PID: 150873 Comm: fsstress Not tainted 6.19.0-rc8+ #13 PREEMPT(voluntary)
[17660.896823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[17660.897891] RIP: 0010:usercopy_abort+0x7a/0x7c
[17660.898575] Code: 48 c7 c6 80 bb 3e 8c eb 0e 48 c7 c7 c0 bb 3e 8c 48 c7 c6 00 bc 3e 8c 52
48 89 fa 48 c7 c7 40 bc 3e 8c 50 41 52 e8 e6 00 fb ff <0f> 0b e8 ef 0e fb 00 4d 89 e0 31 c9 44 89 f2 48 c7 c6 c0 bd 3e 8c
[17660.901225] RSP: 0018:ffff888179fbf340 EFLAGS: 00010246
[17660.901762] RAX: 000000000000006d RBX: ffff8881139ac112 RCX: 0000000000000000
[17660.902295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[17660.902813] RBP: ffff888179fbf358 R08: 0000000000000000 R09: 0000000000000000
[17660.903317] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
[17660.903820] R13: ffff8881139ad112 R14: 0000000000000001 R15: ffff888119da8bb0
[17660.904283] FS:  0000747714d62740(0000) GS:ffff888266112000(0000) knlGS:0000000000000000
[17660.904719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17660.905122] CR2: 00007477143ffff0 CR3: 00000001014f9005 CR4: 0000000000772ef0
[17660.905555] PKRU: 55555554
[17660.905743] Call Trace:
[17660.905902]  <TASK>
[17660.906042]  __check_heap_object+0xf1/0x130
[17660.906372]  ? __virt_addr_valid+0x26b/0x510
[17660.906667]  __check_object_size+0x401/0x700
[17660.906959]  ceph_netfs_issue_read.cold+0x295/0x2f1
[17660.907322]  ? __pfx_ceph_netfs_issue_read+0x10/0x10
[17660.907657]  ? __kasan_check_write+0x14/0x30
[17660.907940]  ? kvm_sched_clock_read+0x11/0x20
[17660.908268]  ? sched_clock_noinstr+0x9/0x10
[17660.908531]  ? local_clock_noinstr+0xf/0x120
[17660.908817]  netfs_read_to_pagecache+0x45a/0x10f0
[17660.909168]  ? netfs_read_to_pagecache+0x45a/0x10f0
[17660.909482]  netfs_write_begin+0x589/0xfc0
[17660.909761]  ? __kasan_check_read+0x11/0x20
[17660.910019]  ? __pfx_netfs_write_begin+0x10/0x10
[17660.910340]  ? mark_held_locks+0x46/0x90
[17660.910629]  ? inode_set_ctime_current+0x3d0/0x520
[17660.910965]  ceph_write_begin+0x8c/0x1c0
[17660.911237]  generic_perform_write+0x391/0x8f0

The reason of the issue is located in this code:

err = copy_to_iter(iinfo->inline_data + subreq->start,
                   len, &subreq->io_iter);

We have valid pointer iinfo->inline_data ffff8881000b0112.
The iinfo->inline_len has 0 size in bytes. However, subreq->start
has really big value 328187904. Finally, the sum of iinfo->inline_data
and subreq->start results in the pointer that is out of available
memory area.

This patch checks the iinfo->inline_len value. If it has zero value,
then -EFAULT code error will be return. Otherwise, the copy_to_iter()
logic will be executed.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/addr.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..426121e38f3f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -314,14 +314,18 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		return false;
 	}
 
-	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
-	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
-	if (err == 0) {
+	if (iinfo->inline_len > 0) {
+		len = min_t(size_t, iinfo->inline_len, subreq->len);
+
+		err = copy_to_iter(iinfo->inline_data, len, &subreq->io_iter);
+		if (err == 0) {
+			err = -EFAULT;
+		} else {
+			subreq->transferred += err;
+			err = 0;
+		}
+	} else
 		err = -EFAULT;
-	} else {
-		subreq->transferred += err;
-		err = 0;
-	}
 
 	ceph_mdsc_put_request(req);
 out:
-- 
2.53.0


