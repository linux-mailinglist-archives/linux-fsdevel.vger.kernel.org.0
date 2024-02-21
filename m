Return-Path: <linux-fsdevel+bounces-12284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A985E423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2191C22B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670D83A00;
	Wed, 21 Feb 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C/FYDG8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="getZPLcZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yY9LW29p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YLDWw3c/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E461DA32;
	Wed, 21 Feb 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535662; cv=none; b=PmzniIfJf6xIY96f1r3102Cjy8a/lue//boO9RVciQfQ3JBhIpseowwJ0D+l/FTmirYLPnehMw/LFWvqjkkTdInLyd5ijsJ+3ob++U+odDFnCklARW+8qpGMNaT2ruENpr3V5Wm0ZEvUXSM0t5tlIf4jQoBWmxoFG0toVuugE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535662; c=relaxed/simple;
	bh=guJLScCLvxtaoZOl384ywPHchQZ/gvw1ZVZ7vDIvPHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBjGaJxleZaIoMkFMINzlpZGwVG2sXNtRrFPNaaXy64a50kWkAarmuoKu3s41BrcltMsy5r8B2+yyYuGXhKGzN1KMjZGUgf3cMZjfQaVjpDd9LPxicRIwwgzf4kqjcKxO+WqKRs6qUqYJXIUyqeDXG1lN2qNXT9vE3WbAnEEqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C/FYDG8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=getZPLcZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yY9LW29p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YLDWw3c/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E832821D9F;
	Wed, 21 Feb 2024 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7eae49SHprcWxpvs+qCF2un7N9dhgOWtO833OFb7rKs=;
	b=C/FYDG8LuU9ru6c1Gh/fgGqHUUd7dkNpsn/7Xs9iRQKV5847oJspWAazV5mjC0hE6T2/ie
	WqzwICYOiOSEJ9QV7wflATotxxRQdvkR0jJbNCoG/8y+U3GwT6mxM5iyJ/m7tAwhPiZusx
	VgaHvTwOsLPu6gCaMpb0mGJ56pQ25Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7eae49SHprcWxpvs+qCF2un7N9dhgOWtO833OFb7rKs=;
	b=getZPLcZr7GW4DG+CgW1ZTgoyJQ+6ibA4qpAlko7QLcCTDSZPjsIAY6YLBa4Ld/5BgovyS
	G4ITzfzPrrJk9fCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7eae49SHprcWxpvs+qCF2un7N9dhgOWtO833OFb7rKs=;
	b=yY9LW29pOSOsZdEWb3SBDlSivGrrf4iJyRMYrontSu5lszEfjYbemQ75OMQJmmPeUOPYe2
	6ku30jCRQvrtzx8h9hOD8sLmuUmA6YivVbURMzHVB1TD6104BVoye3craSUcNGpvfB7lBN
	Gs6/UMNyZN+3XwvEEOTWaMkkxbMoffM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7eae49SHprcWxpvs+qCF2un7N9dhgOWtO833OFb7rKs=;
	b=YLDWw3c/v7f/QtBIRJ1OwlPZkrN7e7jx2cFg+Ze4ZurmWnX6CH8UJUjK+SY3LEjSvQ4ms4
	a3sSkvvYsgZvb0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A42FD139D0;
	Wed, 21 Feb 2024 17:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vKYKImov1mVMKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:18 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org
Cc: tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v7 00/10] Set casefold/fscrypt dentry operations through sb->s_d_op
Date: Wed, 21 Feb 2024 12:14:02 -0500
Message-ID: <20240221171412.10710-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,kernel.org,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi,

v7 of this patchset applying the comments from Eric. Thank you for your
feedback.  Details in changelog of individual patches.

As usual, this survived fstests on ext4 and f2fs.

Thank you,

---
original cover letter:

When case-insensitive and fscrypt were adapted to work together, we moved the
code that sets the dentry operations for case-insensitive dentries(d_hash and
d_compare) to happen from a helper inside ->lookup.  This is because fscrypt
wants to set d_revalidate only on some dentries, so it does it only for them in
d_revalidate.

But, case-insensitive hooks are actually set on all dentries in the filesystem,
so the natural place to do it is through s_d_op and let d_alloc handle it [1].
In addition, doing it inside the ->lookup is a problem for case-insensitive
dentries that are not created through ->lookup, like those coming
open-by-fhandle[2], which will not see the required d_ops.

This patchset therefore reverts to using sb->s_d_op to set the dentry operations
for case-insensitive filesystems.  In order to set case-insensitive hooks early
and not require every dentry to have d_revalidate in case-insensitive
filesystems, it introduces a patch suggested by Al Viro to disable d_revalidate
on some dentries on the fly.

It survives fstests encrypt and quick groups without regressions.  Based on
v6.7-rc1.

[1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
[2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/

Gabriel Krisman Bertazi (10):
  ovl: Always reject mounting over case-insensitive directories
  fscrypt: Factor out a helper to configure the lookup dentry
  fscrypt: Drop d_revalidate for valid dentries during lookup
  fscrypt: Drop d_revalidate once the key is added
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  libfs: Add helper to choose dentry operations at mount-time
  ext4: Configure dentry operations at dentry-creation time
  f2fs: Configure dentry operations at dentry-creation time
  ubifs: Configure dentry operations at dentry-creation time
  libfs: Drop generic_set_encrypted_ci_d_ops

 fs/crypto/hooks.c       | 15 ++++------
 fs/ext4/namei.c         |  1 -
 fs/ext4/super.c         |  1 +
 fs/f2fs/namei.c         |  1 -
 fs/f2fs/super.c         |  1 +
 fs/libfs.c              | 62 +++++++++++---------------------------
 fs/overlayfs/params.c   | 14 +++++++--
 fs/ubifs/dir.c          |  1 -
 fs/ubifs/super.c        |  1 +
 include/linux/fs.h      | 11 ++++++-
 include/linux/fscrypt.h | 66 ++++++++++++++++++++++++++++++++++++-----
 11 files changed, 105 insertions(+), 69 deletions(-)

-- 
2.43.0


