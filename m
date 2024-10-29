Return-Path: <linux-fsdevel+bounces-33118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA969B4A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 13:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8188F1F236C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6161EB9E6;
	Tue, 29 Oct 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eA3qqQ29";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5aM1LpuW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eA3qqQ29";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5aM1LpuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26360BA50
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206158; cv=none; b=mAGqq6vlGljZDe1QUhR6ttTr2vo+0cTyihG7wSp+kPbDs3uUZ7SkavUCHLua2lVgbol+97mJOTah/W3DNM0fv2cQPvSC2+/I7emUlc1M3Ok+1q8Wx9jzpsx1d7vty/6YEMnO/lkQRXu7LeUR+dfaE7QbHCvSAXCtd8spEkylaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206158; c=relaxed/simple;
	bh=sFG9RXQRMpfZngRYM2LXnrNQl4gVBjgy+d2bhqfOz04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpq5GTQDTrTJEBm5PEP7unu72qdhgsdzEP0ygQX9Y7UhZmB6MMiS1GJZrdToRPpx2j7oyf3O7PMzL3F49PseZFtRm+TsKGks5qn9JtN5QvulbZCmMlcC1wTBk+vdjWqrAGLYz9Y5hX2V69ydouEal7qlRXB4SYRu5QlUmO0KgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eA3qqQ29; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5aM1LpuW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eA3qqQ29; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5aM1LpuW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5698E1F445;
	Tue, 29 Oct 2024 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730206154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2hBgJ5pz2LVY2K9gTZXQbC7Sjn0M7hCv/cU4kC+BUaQ=;
	b=eA3qqQ29ylmr+NDhO/TZhgEokAaBLpcpT0ExdT77I2hWHEjOSB1dx+qhxEwoie8Yxz2qvQ
	rtrEfxJ709vKgN4nxY8V2h1grt613dNuhE3y11oaLpxuG/FzDZRZEmpUhY3lDpKSMX6v8U
	EiPVagZS6pYy2Yoqz7hylu3Yt7A/JpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730206154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2hBgJ5pz2LVY2K9gTZXQbC7Sjn0M7hCv/cU4kC+BUaQ=;
	b=5aM1LpuWu+z5XbHif7hrv8ZpK8eRUhOsuelPOsfPCLILdbzCP4PBVH3u9qhgBb2Vsjp7lZ
	6RpQHsRRVI+NtDAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730206154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2hBgJ5pz2LVY2K9gTZXQbC7Sjn0M7hCv/cU4kC+BUaQ=;
	b=eA3qqQ29ylmr+NDhO/TZhgEokAaBLpcpT0ExdT77I2hWHEjOSB1dx+qhxEwoie8Yxz2qvQ
	rtrEfxJ709vKgN4nxY8V2h1grt613dNuhE3y11oaLpxuG/FzDZRZEmpUhY3lDpKSMX6v8U
	EiPVagZS6pYy2Yoqz7hylu3Yt7A/JpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730206154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2hBgJ5pz2LVY2K9gTZXQbC7Sjn0M7hCv/cU4kC+BUaQ=;
	b=5aM1LpuWu+z5XbHif7hrv8ZpK8eRUhOsuelPOsfPCLILdbzCP4PBVH3u9qhgBb2Vsjp7lZ
	6RpQHsRRVI+NtDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D6B2136A5;
	Tue, 29 Oct 2024 12:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bTmQEcjZIGdoXgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 29 Oct 2024 12:49:12 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] initramfs: avoid filename buffer overrun
Date: Tue, 29 Oct 2024 12:48:37 +0000
Message-ID: <20241029124837.30673-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The initramfs filename field is defined in
Documentation/driver-api/early-userspace/buffer-format.rst as:

 37 cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
...
 55 ============= ================== =========================
 56 Field name    Field size         Meaning
 57 ============= ================== =========================
...
 70 c_namesize    8 bytes            Length of filename, including final \0

When extracting an initramfs cpio archive, the kernel's do_name() path
handler assumes a zero-terminated path at @collected, passing it
directly to filp_open() / init_mkdir() / init_mknod().

If a specially crafted cpio entry carries a non-zero-terminated filename
and is followed by uninitialized memory, then a file may be created with
trailing characters that represent the uninitialized memory. Symlink
filename fields handled in do_symlink() won't overrun past the data
segment, due to the explicit zero-termination of the symlink target.

Append the output of the following bash script to an existing initramfs
and observe any created /initramfs_test_fname_overrunAA* path. E.g.
  ./reproducer.sh | gzip >> /myinitramfs

It's easiest to observe non-zero uninitialized memory when the output is
gzipped, as it'll overflow the heap allocated @out_buf in __gunzip(),
rather than the initrd_start+initrd_size block.

---- reproducer.sh ----
nilchar="A"	# change to "\0" to properly zero terminate / pad
magic="070701"
ino=1
mode=$(( 0100777 ))
uid=0
gid=0
nlink=1
mtime=1
filesize=0
devmajor=0
devminor=1
rdevmajor=0
rdevminor=0
csum=0
fname="initramfs_test_fname_overrun"
namelen=$(( ${#fname} + 1 ))	# plus one to account for terminator

printf "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s" \
	$magic $ino $mode $uid $gid $nlink $mtime $filesize \
	$devmajor $devminor $rdevmajor $rdevminor $namelen $csum $fname

termpadlen=$(( 1 + ((4 - ((110 + $namelen) & 3)) % 4) ))
printf "%.s${nilchar}" $(seq 1 $termpadlen)
---- reproducer.sh ----

Fix filename buffer overrun by skipping over any cpio entries where the
field doesn't carry a zero-terminator at the expected (name_len - 1)
offset.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index bc911e466d5bb..a44386bcbb566 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -360,6 +360,14 @@ static int __init do_name(void)
 {
 	state = SkipIt;
 	next_state = Reset;
+
+	/* name_len > 0 && name_len <= PATH_MAX checked in do_header */
+	if (collected[name_len - 1] != '\0') {
+		pr_err("Skipping name without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		return 0;
+	}
+
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -424,13 +432,19 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
+	state = SkipIt;
+	next_state = Reset;
+
+	if (collected[name_len - 1] != '\0') {
+		pr_err("Skipping symlink without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		return 0;
+	}
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	init_symlink(collected + N_ALIGN(name_len), collected);
 	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(collected, mtime);
-	state = SkipIt;
-	next_state = Reset;
 	return 0;
 }
 
-- 
2.43.0


