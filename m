Return-Path: <linux-fsdevel+bounces-76287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LS5OlkJg2lLgwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:54:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70499E35EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3CC3305B941
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F439A7EA;
	Wed,  4 Feb 2026 08:52:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A993939B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195154; cv=none; b=KvMCTRbd+ImymwJlEhtfBcJ9VF5x4P4xNIxmAiniLcqx8EHO5E6WdQoVO8eNQ5SwqiaaYrSVxu1wtJhpwt+94v47rWZN7nQCgLpCQGwIAFoD35jn9iaeUwNDevjdq6RdlVgLXXGKt2V/jrxgrt0iXzBZB5nCzjhqXzvyAdwboz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195154; c=relaxed/simple;
	bh=ABqpm92OD3lEo0c3q6BtDa7poVieoTG+ZeVNg26XBWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fB91RbuX3i+flj+IesK6fLffso8hhIRhrd3StiL6sqTrUcz9Nu1X4QrhQttPaa5Yhq6atwQN+FTXLHRacdh9kf+/+NeRMcbTzHM3qT9ayDL8QqpEMyZ/ID+WpFY2xrmQ9ysqaIrhGmbsks0QSYO9wQPZPp3jViDyDpgvRwQbmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a871c8b171so39139165ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195154; x=1770799954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7vLKFQBW4UE6h3h/wPYkOdCPiFa+msaz2jA5YP1ydQ=;
        b=lk6RM7BKCqNdKkwyaykdEVe4iIIAhhJsU/uA6adlee3o86djseDHVEb+H2lZbj3Dmm
         75dn/fSVIoHilastdE+a8+B2O6kvi+6HuodyS/5dmjw/DukovulnEav4vSkudAJ1lxzA
         adxG7alzfJ9I3E9D+sSzbLAHoTVvJvmdYHVPfC6hX3BtDlCsWoR7zNOpaD9oly0KasGH
         EJCNOKetLJYHIVHQefNLFH+NQcN34mZVadRva8HXy+VoKJFdfmGPB8ILTUNekYKqQzuw
         RS5AI5cBR1rCfbwZDQtS+yUsor56aWlBrVBc4rnZFCl3C7PEwNusicIBFEekVo6QfZM3
         5ysg==
X-Gm-Message-State: AOJu0YylZIWW7uy3ktMCzBFC3e2XV7VedEsJbaQQ6cWeajLMqqacDuAX
	noB4bPt8SS9B38d8XsFqyvaZ1+48OQZbs7Kj4A4hxh4luQ1QpgGJZmXx
X-Gm-Gg: AZuq6aLu7UBppAFE6dYIBnhJLp73kEE4l6auXPvttLaxPsDmVUJvUUlLLEQcXAYWSA2
	4eFcFkNf2eKK0GCe123mI+IeMI36Gyu3bwiaLTGyWY3nUr2yDJStw48OjNJnYZxpuGLWNhLqENp
	yk52A4nY6Uon+eqT7n3+7XZEIvUDC7tv//W3C04aARcISILSwScKzDHnLymAWdrWBiPTrRcl6Rx
	J+wz53vJBILoFvhUBKsbft7ntlPf5zUXrw+PsOBe+jGKOf9WidUt5uDE/HGC9Var4E9cshbpTwj
	a6gvQEy5FAdNe3kxN7/r45t1C+C85MjK0BcVJts8VRMAquW39XHRjNQ6RreYk+SPG+KAooW1pQJ
	pHbjsIRlv/QgCAXw3xs4YMtw5ODVW7bfe4hz7bOete/AqT1fB94rh/N9bTJOIwQ88G9mvGBgQlR
	hG/BCmAkDc5DCoqPaNXNTTwScL7Q==
X-Received: by 2002:a17:902:ced0:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2a93411169dmr24254605ad.53.1770195153721;
        Wed, 04 Feb 2026 00:52:33 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851270sm16847735ad.2.2026.02.04.00.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:52:32 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH RESEND v7 15/17] ntfs: add Kconfig and Makefile
Date: Wed,  4 Feb 2026 17:29:29 +0900
Message-Id: <20260204082931.13915-16-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-76287-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 70499E35EB
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


