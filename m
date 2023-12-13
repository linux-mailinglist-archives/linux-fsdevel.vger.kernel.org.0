Return-Path: <linux-fsdevel+bounces-6025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEF812360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808721F212B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D979492;
	Wed, 13 Dec 2023 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aySwLGq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dD//Th6/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aySwLGq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dD//Th6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C673248;
	Wed, 13 Dec 2023 15:41:00 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 005011FD84;
	Wed, 13 Dec 2023 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=aySwLGq5JcjHCtbu1XYMI8xbwV1vIWPidIaoyTRV9EaPfVJp5SGgOOvd5yOvoMq3UsL1hQ
	ppce/t1WR2Dr58Fv0NCss8aFxiBk8HMb6PRQqY24ugpWQrOM4tPxrMmSKRhvmB2eCqTDlC
	i3UcMN4r1S2Cx2k4dMazBN34th9yACs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=dD//Th6/Zj4msP9PIJkP4il3qWy6su9Qw5vYeqwfSLw9y2yPwYjyV1FxGhFwzGoVNLDgaJ
	hlRylM2j3tRpr5Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=aySwLGq5JcjHCtbu1XYMI8xbwV1vIWPidIaoyTRV9EaPfVJp5SGgOOvd5yOvoMq3UsL1hQ
	ppce/t1WR2Dr58Fv0NCss8aFxiBk8HMb6PRQqY24ugpWQrOM4tPxrMmSKRhvmB2eCqTDlC
	i3UcMN4r1S2Cx2k4dMazBN34th9yACs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=dD//Th6/Zj4msP9PIJkP4il3qWy6su9Qw5vYeqwfSLw9y2yPwYjyV1FxGhFwzGoVNLDgaJ
	hlRylM2j3tRpr5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C8F1377F;
	Wed, 13 Dec 2023 23:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wiJRJf1AemVrPgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:45 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 4/8] libfs: Expose generic_ci_dentry_ops outside of libfs
Date: Wed, 13 Dec 2023 18:40:27 -0500
Message-ID: <20231213234031.1081-5-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213234031.1081-1-krisman@suse.de>
References: <20231213234031.1081-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.92%]

In preparation to allow filesystems to set this through sb->s_d_op,
expose the symbol directly to the filesystems.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 2 +-
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 52c944173e57..b8ecada3a5b2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1765,7 +1765,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
-static const struct dentry_operations generic_ci_dentry_ops = {
+const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 #if defined(CONFIG_FS_ENCRYPTION)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..887a27d07f96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,7 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern const struct dentry_operations generic_ci_dentry_ops;
 
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
-- 
2.43.0


