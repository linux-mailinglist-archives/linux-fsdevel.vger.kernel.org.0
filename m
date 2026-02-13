Return-Path: <linux-fsdevel+bounces-77109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHwQBxXjjmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:38:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EEE13421C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C513053AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E133C1B4;
	Fri, 13 Feb 2026 08:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2B33B6D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971903; cv=none; b=gtcNInVtk7STWziIw+v4vU2IWsqn0gr+oHnIh4DqjfCAYVjRAUY+vdGsDpFDHxpSn12cYF1szmVZA8ey39yQjPc8IguWp1ZH8/pnMLmLoW1qDpOFKi6YYdCy17sEopHxscLHRXmI07Fvq6CKGsoQ46+gu/tC06SFf4eaWKB/bvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971903; c=relaxed/simple;
	bh=rqCTJwzKn+pJ3DD2nIHyEpUxM+GSsFJLIy028CweCvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vj8oN2ut6M2pxmTrcq/YEJB+cDUEE9Nww02+HKbMljj2DpcJjWSD9Le/KjLg7aZZHLSXUdNNLYTH+BNBtfdTJcmLVdctdMSC/tD39DsL5Pe+d4AxsyZ8+SclXHaOOekO1fbjI3lFWZw9l2MUDm4tAm01tCYcwAEfaVa0WsnumMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7bced39cfso8196235ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770971902; x=1771576702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHJOhxvb6qJ+fM2rPAHuRPEgQxIBGWX2FRMCekhGl3g=;
        b=v6hxc5qkxlY3GKzrRuGEVMfurCC0So4ygqCcffKj2wXzdckUjoXM0P+zx00JGbySqY
         /5i4Om88KA6fQVcnKJMB+t9OjZKr67Q79QxtX4MQeYaZ9hrZrgANN4QqDTN4w8IzwKd3
         sLqKF/brcKzH+cUqgJA/q05MlmqjwI43JOVoDD0IApmy6ozACPkMBrVbRPjsihSdQs+o
         N+qR16GKM7keiZbiyvtxyTY8WWEJuWcxXv9OyQHeeRYxE9zS1EJdYYhHu3ptOwSJt2NZ
         ZE4EkeuNvDOfa+lLiaeU8/hmXmacPd+DLixMmnHWmnM7RoYVVALmJ6AYCPRGf3iprmla
         WN4A==
X-Gm-Message-State: AOJu0YzFgh9EO4bma9kCK17Zo3/XJRGR/oXlLK79xQy/DRnxQFTunic3
	es29JABchQd6xhaJ2CNe7YJpYE40QVBc9IoFjL/xMbAKL7BxkwOMTG9q
X-Gm-Gg: AZuq6aIAV8GaAEwriSFCtAkhJWyKzv1WAByH1no096GuirK+cyrt1AwgbeTkIG/oDAZ
	GpNYsvvh+2xdbibLjrvGR8tzcAvcY7A9ey3NPvbK7+7nnytC8jTMU9xggJTxc3Q56Eh3yWiXNbS
	7BokkJLzWmWSQ+03WUHCpyP1TaIq5MzkyIl+jVW7DQVaFXxOzTKYrkpCfphQuB4upAAxtUB3wJJ
	u3zDNgezx5LMATdVB6dZPRZ70X7wH6MoO/JRMiAy+8D0JYuju0RqrhLupjvibRY7QpGJIsevcdG
	ERt8qhPJ0ZtO2jAf5iDriUOCg/Vr6fFXlv4ykgXKQZrk2Wsl7QFpeIBCJCjdAOYIX3nBNsJL/aQ
	DHC68zACCQ47ona2aUlLHSKV28XITk3Sam5MDAGLNRdfpcHcmlk2R+1FX0O/fEsbW5YKC+A7Ft7
	Iv+sJwo6DpAxPNce5/rsXRTWnQXSrI8p8MK9SoOA==
X-Received: by 2002:a17:903:8c6:b0:2a8:dc87:6280 with SMTP id d9443c01a7336-2ab505c9b05mr12129535ad.45.1770971901962;
        Fri, 13 Feb 2026 00:38:21 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm75236495ad.6.2026.02.13.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:38:21 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	amir73il@gmail.com,
	xiang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v9 15/17] ntfs: add Kconfig and Makefile
Date: Fri, 13 Feb 2026 17:18:02 +0900
Message-Id: <20260213081804.13351-16-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213081804.13351-1-linkinjeon@kernel.org>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-77109-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74EEE13421C
X-Rspamd-Action: no action

Introduce Kconfig and Makefile for remade ntfs.
And this patch make ntfs and ntfs3 mutually exclusive so only one can be
built-in(y), while both can still be built as modules(m).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christoph Hellwig <hch@lst.de>
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
index cf4a745e9679..ae1b07f9c6a0 100644
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


