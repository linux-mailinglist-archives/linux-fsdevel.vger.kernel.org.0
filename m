Return-Path: <linux-fsdevel+bounces-76271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN7DLGD/gmnJgQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:12:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F72E2FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0289E302DF4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FAC38F935;
	Wed,  4 Feb 2026 08:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73436A027
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770192682; cv=none; b=M51qObzi0Vl6JaUcYWmyt3gf4h5AQKTAV8NyaggFkju4Z9i3ueJjaGg5JTv0s5E7hHI9mUTGCR/7mviVG13RYBs9Erdp7Yip7H+LeAS/SQdDe2eGFqXHOgZmLLENIdOQOntekJTrc/oKFlvm9wGpfAWJR77yHSRBlzwDp95qzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770192682; c=relaxed/simple;
	bh=ABqpm92OD3lEo0c3q6BtDa7poVieoTG+ZeVNg26XBWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp91WA+R2Tri2snakFAz34tHuOZBf3s8R++4804F7RHQhwFH4KwziV0sZDBFne1QdmZqH3ta9rnJtHVsN3PwN5npOmdShyIDuc4+PDbDKELz96eezQRb/QD++/Ook797jVnD8ZaLF4IJRoOXkoSNpIR9CrP4ekWeWRaX9V2txiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a09d981507so4979185ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770192682; x=1770797482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7vLKFQBW4UE6h3h/wPYkOdCPiFa+msaz2jA5YP1ydQ=;
        b=ndHuHG1zi9jZIEmdusxZ+R8dFciCoqfbkjAGB0gqNMYilanFdFtV2jsqeLqG2rB4AF
         ofVgGo9i3svbOfDbbKp/eDF2HGaBt5xIvD+6Ztz9vYeL3LWqp7IfEXn1paY28MzxA0xn
         wY6JzZmmv6S4X9shldBJor96ECNzz7D9b1b3MOloj55PmZVNnwMcv0xPteFH1e5C7POk
         +xLY+y3nyKBSJhM0+SicuwWBYmuLVzNOT9vHlXJvXT/uOAjdDZ5/nSLDEUnw5MPKNse7
         k1noXqqTLmr9jUxrKxCqnoqVuqSajqc6bqOakZmhRMHK6YE75eu+V9KoQfqapzt8uaeJ
         HcbA==
X-Gm-Message-State: AOJu0YykyuQcJymszr8D/HJC0jjVWlGEexQsSlzMjOymYUqbhf53sxDp
	MZX1TpcrficflH9uxElkFVJFcIt38WwSD+55yhUSZuyA9vKxE9xCyh5q
X-Gm-Gg: AZuq6aL4ut0yE+gg8a9jyGEbOZ3QAISf1ZslRkWiNn28mt8jG32annCZU6UGVf46r1a
	6PBTzPtBb4lFd1vbO0dYbLIzXXIx+phUnJ/T4wt24izACFUjElVRAUlyWATnJseRGFLk/PCKE4Q
	dEHR9pSGhLYv//bnA+0ZSXA/AEBycXs8fTTocesYPFMvZ4RYqlMABpKTKbtiT1zkQNlkvfhn5Eg
	RnMEfmd+IUfgvrOBX2bjJ2FPdiS/VifefPOiOMoGjj9ug1pqP3eDV8OZd2hh60eI/lA6MH8+1Vu
	yc43K/gB1OE5DeKIpkf27QeIiiG62h40jvYLF5gvssEL2uqBEu7rUESaydW8yeT7eiyaX8HINgr
	BpuhQU9+j0y1/XScnEhGL+Q3eLlgR9dabEb+cwBJVx0KjuSAyL+zOFrAyQaB7g8+IAAn/NFKvov
	h4g8bydgxRYU4GCc7T5504nZmH1Q==
X-Received: by 2002:a17:902:e783:b0:2a0:fb1c:144e with SMTP id d9443c01a7336-2a9245a8ee6mr51008255ad.7.1770192681980;
        Wed, 04 Feb 2026 00:11:21 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933967771sm14554875ad.82.2026.02.04.00.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:11:21 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v7 15/17] ntfs: add Kconfig and Makefile
Date: Wed,  4 Feb 2026 16:47:53 +0900
Message-Id: <20260204074755.9058-16-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204074755.9058-1-linkinjeon@kernel.org>
References: <20260204074755.9058-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76271-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17F72E2FE2
X-Rspamd-Action: no action

Introduce Kconfig and Makefile for remade ntfs.
And this patch make ntfs and ntfs3 mutually exclusive so only one can be
built-in(y), while both can still be built as modules(m).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig       |  1 +
 fs/Makefile      |  1 +
 fs/ntfs/Kconfig  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/Makefile | 10 ++++++++++
 fs/ntfs3/Kconfig |  1 +
 5 files changed, 60 insertions(+)
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..43cb06de297f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -152,6 +152,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
+source "fs/ntfs/Kconfig"
 source "fs/ntfs3/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c854..6893496697c4 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-y				+= unicode/
 obj-$(CONFIG_SMBFS)		+= smb/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
+obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
new file mode 100644
index 000000000000..e5fd1378fbbf
--- /dev/null
+++ b/fs/ntfs/Kconfig
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFS_FS
+	tristate "NTFS file system support"
+	select NLS
+	help
+	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
+	  This allows you to mount devices formatted with the ntfs file system.
+
+	  To compile this as a module, choose M here: the module will be called
+	  ntfs.
+
+config NTFS_DEBUG
+	bool "NTFS debugging support"
+	depends on NTFS_FS
+	help
+	  If you are experiencing any problems with the NTFS file system, say
+	  Y here.  This will result in additional consistency checks to be
+	  performed by the driver as well as additional debugging messages to
+	  be written to the system log.  Note that debugging messages are
+	  disabled by default.  To enable them, supply the option debug_msgs=1
+	  at the kernel command line when booting the kernel or as an option
+	  to insmod when loading the ntfs module.  Once the driver is active,
+	  you can enable debugging messages by doing (as root):
+	  echo 1 > /proc/sys/fs/ntfs-debug
+	  Replacing the "1" with "0" would disable debug messages.
+
+	  If you leave debugging messages disabled, this results in little
+	  overhead, but enabling debug messages results in very significant
+	  slowdown of the system.
+
+	  When reporting bugs, please try to have available a full dump of
+	  debugging messages while the misbehaviour was occurring.
+
+config NTFS_FS_POSIX_ACL
+	bool "NTFS POSIX Access Control Lists"
+	depends on NTFS_FS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support additional access rights
+	  for users and groups beyond the standard owner/group/world scheme.
+
+	  This option enables ACL support for ntfs, providing functional parity
+	  with ntfs3 drivier.
+
+	  NOTE: this is linux only feature. Windows will ignore these ACLs.
+
+	  If you don't know what Access Control Lists are, say N.
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
new file mode 100644
index 000000000000..0ce4d9a9388a
--- /dev/null
+++ b/fs/ntfs/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NTFS_FS) += ntfs.o
+
+ntfs-y := aops.o attrib.o collate.o dir.o file.o index.o inode.o \
+	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
+	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
+	  iomap.o debug.o sysctl.o quota.o object_id.o bdev-io.o
+
+ccflags-$(CONFIG_NTFS_DEBUG) += -DDEBUG
diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index cdfdf51e55d7..876dbc613ae6 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NTFS3_FS
 	tristate "NTFS Read-Write file system support"
+	depends on !NTFS_FS || m
 	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
-- 
2.25.1


