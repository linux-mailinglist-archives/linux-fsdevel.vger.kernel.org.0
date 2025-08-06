Return-Path: <linux-fsdevel+bounces-56859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E0B1CB36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F85562DAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C28A29CB2A;
	Wed,  6 Aug 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="iHBRD9Ma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E428AAE9;
	Wed,  6 Aug 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502300; cv=none; b=uaTXr0fTT6Gn0GOIrV0FnH3+HVJTyl09oosxIuaKD2WiQi0683kNxanjplm3HyKPnIMwLb644eqrfUV1ccJ3C9WwQK8rAZiHlUb/1YWHQbr0YPTGd7+aT2oGHmxmwyoe0d3/hx74krn5zdyjp8z3RoeFn1/49DXZjQNzyWMMUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502300; c=relaxed/simple;
	bh=U2/2UCTKfdzYU7Vs2Xj+qWBuAQMgG6FdCzWdcxQCboI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VCKXCelLhnr8Xw6Y4f81N+ul1GdhY1V8jIm760sQQxwjdb3EK3opJ98QCriCZ54RTtwD/ClOvN06osQzkgwkVGOu0URdtA7JK2Ai5UW1++r8fehpSdgh9PkUDznUJakEafPnYJz6E5h7mLNePhPsCfn0iLouClEGe6NvYt8fbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=iHBRD9Ma; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxyNc5j5jz9snx;
	Wed,  6 Aug 2025 19:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=unovipNBV+SHJmYU0KEMKrMHFAnD9x3er82aqfKIVuI=;
	b=iHBRD9MaRYpISA6JNREFryNHn4dqIbi7XTU0+EWo65nQ5lLwPGHSmhavwxMKTbMIue0j89
	9LieVEBmcWs0LyGRIm8VEuVD8tB6NtwjB5Az0XIQPOuvZPJZ1UUETdkaLQE8VksUpXccY9
	SFssOR12QsoTL27t1mFWbP4RZ2L7qgR7PwbvoF9l8bXulHAserIXasTLtjeUQGpc4wWtCy
	v5dHEJyxQBD5cLvul1hZcQzhEHWQiG2RpHVtXUpPPnP7ZjYy/4U/EqpHu0V2vrlMnTZSDR
	3AGjwVY1UyV20wh7XIls8G9EDU63vGkWiFS6O3uwRLXiAlsNKHzAYjb5Tca5pg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 00/11] man2: add man pages for 'new' mount API
Date: Thu, 07 Aug 2025 03:44:34 +1000
Message-Id: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKUk2gC/13MQQ6CMBCF4auQWTumFKjVlfcwLGqZyixoSYsoI
 dzdSuLG5f+S962QKDIluBQrRJo5cfA55KEA2xv/IOQuN0ghG6GFRE8vHMLTT2hGxrpS3f2sa1d
 XEvJnjOT4vXu3NnfPaQpx2fm5/K4/Sf1Jc4kCtTpp1yiriMTVLmNv4tGGAdpt2z5UHm78qwAAA
 A==
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=U2/2UCTKfdzYU7Vs2Xj+qWBuAQMgG6FdCzWdcxQCboI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntJacvLEtzLv1VGKHo8kZK/trz+14m9fYfnXkqdCa
 4L7pTybOkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBExBsZ/ueaymoZt0SoXBKb
 cMvu14apOxe/7WjsfbDFxt78ukH21AqG//XxMYvFv3C5n1xXIbDna8Ss3R+u7F3P9v1Awhr5xjP
 Ck/kB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyNc5j5jz9snx

Back in 2019, the new mount API was merged into mainline[1]. David Howells
then set about writing man pages for these new APIs, and sent some
patches back in 2020[2]. Unfortunately, these patches were never merged,
which meant that these APIs were practically undocumented for many
years -- arguably this may have been a contributing factor to the
relatively slow adoption of these new (far better) APIs. I have often
discovered that many folks are unaware of the read(2)-based message
retrieval interface provided by filesystem context file descriptors.

In 2024, Christian Brauner set aside some time to provide some
documentation of these new APIs and so adapted David Howell's original
man pages into the easier-to-edit Markdown format and published them on
GitHub[3]. These have been maintained since, including updated
information on new features added since David Howells's 2020 draft pages
(such as MOVE_MOUNT_BENEATH).

While this was a welcome improvement to the previous status quo (that
had lasted over 6 years), speaking personally my experience is that not
having access to these man pages from the terminal has been a fairly
common painpoint.

So, this is a modern version of the man pages for these APIs, in the hopes
that we can finally (7 years later) get proper documentation for these
APIs in the man-pages project.

One important thing to note is that most of these were re-written by me,
with very minimal copying from the versions available from Christian[2].
The reasons for this are two-fold:

 * Both Howells's original version and Christian's maintained versions
   contain crucial mistakes that I have been bitten by in the past (the
   most obvious being that all of these APIs were merged in Linux 5.2,
   but the man pages all claim they were merged in different versions.)

 * As the man pages appear to have been written from Howells's
   perspective while implementing them, some of the wording is a little
   too tied to the implementation (or appears to describe features that
   don't really exist in the merged versions of these APIs).

I decided that the best way to resolve these issues is to rewrite them
from the perspective of an actual user of these APIs (me), and check
that we do not repeat the mistakes I found in the originals.

I have also done my best to resolve the issues raised by Michael Kerrisk
on the original patchset sent by Howells[1].

In addition, I have also included a man page for open_tree_attr(2) (as a
subsection of the new open_tree(2) man page), which was merged in Linux
6.15.

[1]: https://lore.kernel.org/all/20190507204921.GL23075@ZenIV.linux.org.uk/
[2]: https://lore.kernel.org/linux-man/159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk/
[3]: https://github.com/brauner/man-pages-md

Co-developed-by: David Howells <dhowells@redhat.com>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- `make -R lint-man`. [Alejandro Colomar]
- `sed -i s|Glibc|glibc|g`. [Alejandro Colomar]
- `sed -i s|pathname|path|g` [Alejandro Colomar]
- Clean up macro usage, example code, and synopsis. [Alejandro Colomar]
- Try to use semantic newlines. [Alejandro Colomar]
- Make sure the usage of "filesystem context", "filesystem instance",
  and "mount object" are consistent. [Askar Safin]
- Avoid referring to these syscalls without an "at" suffix as "*at()
  syscalls". [Askar Safin]
- Use \% to avoid hyphenation of constants. [Askar Safin, G. Branden Robinson]
- Add a new subsection to mount_setattr(2) to describe the distinction
  between mount attributes and filesystem parameters.
- (Under protest) double-space-after-period formatted commit messages.
- v1: <https://lore.kernel.org/r/20250806-new-mount-api-v1-0-8678f56c6ee0@cyphar.com>

---
Aleksa Sarai (11):
      mount_setattr.2: document glibc >= 2.36 syscall wrappers
      mount_setattr.2: move mount_attr struct to mount_attr.2type
      fsopen.2: document 'new' mount api
      fspick.2: document 'new' mount api
      fsconfig.2: document 'new' mount api
      fsmount.2: document 'new' mount api
      move_mount.2: document 'new' mount api
      open_tree.2: document 'new' mount api
      mount_setattr.2: mirror opening sentence from fsopen(2)
      open_tree_attr.2, open_tree.2: document new open_tree_attr() api
      fsconfig.2, mount_setattr.2: add note about attribute-parameter distinction

 man/man2/fsconfig.2           | 566 +++++++++++++++++++++++++++++++++++++++
 man/man2/fsmount.2            | 209 +++++++++++++++
 man/man2/fsopen.2             | 319 ++++++++++++++++++++++
 man/man2/fspick.2             | 305 +++++++++++++++++++++
 man/man2/mount_setattr.2      | 105 ++++----
 man/man2/move_mount.2         | 609 ++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree.2          | 479 +++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2     |   1 +
 man/man2type/mount_attr.2type |  58 ++++
 9 files changed, 2600 insertions(+), 51 deletions(-)
---
base-commit: f23e8249a6dcf695d38055483802779c36aedbba
change-id: 20250802-new-mount-api-436db984f432

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


