Return-Path: <linux-fsdevel+bounces-76567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHnIMqeahWmUDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:39:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F4FB0E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A646D300BEB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE98318EE1;
	Fri,  6 Feb 2026 07:39:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C3318BBB
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363552; cv=none; b=rXJiEsJ8fLVnSvKfFmAD6JMuUmkzItPyStjJloeFU2dS3Ed3m+X6pXdjTkvnHvL31QX/hS7mTaZ7Bw+KEa/rUUh9J8n08zTEyS7lY/Q2fRmze24J8cXkVJq36cW+EWg3dbNjmIL2u+UGkkR9o1SJwv0SvKG2WfOGtl3EK2IYmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363552; c=relaxed/simple;
	bh=DU5nBjug+RoHFUzP1AJtDUCWFbe/rRBS/EngWIAV3fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOELeUAKxgvvvUaXcs789BbUe5cchpKse3cnGvLD+zZRjXs3vSqi1v2QjPkbwSDsHh1GuAYWu7CEPQ+XUntSbW+Di+qXd+7HYhd53Z+eBRF7EVkfiI/e3SES7b+hHmuv8lpSMG+jD67l0oYefAYmcw0wgZWgs7PlQoTJh8JnTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd0ec465aso147588a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 23:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363552; x=1770968352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BZzhuG+YFcQ1jYJ+o4osI6kDB/iI0cOTuEHSjHPzZE=;
        b=u8O6Ceg1sm9jV+MCyB1JG/pWkgG11oxzEQtRJ9Ug7+oVuiSZl0A/r+2yZ1UjMDlFvP
         wzmjRdNM/5E7NHoiyXolwy/DV+6/B8HonTO2prs+C8Xw75fxHWq5MiEBCtD1fyQwnIzQ
         VfDlX3sI3rxNO213OmbPOdMrpSPCNXb6q/3/HRAPA3ZVTipFultmXJk3L3vPBaN32/M/
         Zy0E5ddU5Hb1mq+msEpqrGFZn3K9QYG80N4Gtg8fyeLTkwzSSM/OuF3ihsoNNW1bO95H
         2HrTiO9HOWQx86PwSKlXBv8nDf4dZWswMSXOzrRUX1ci9Nrozc2p0XDuit+s4mZwo4lK
         WyNQ==
X-Gm-Message-State: AOJu0YzcEtvEgVlOVVDwKnio9dwXARIWBqYdTbMq/rbraHJhvz8KUeGb
	lcso5kInI7oiq7c1DP62/VoiapXp7hZnjXwr/P6QnnlM5kbWdDnuGwTr
X-Gm-Gg: AZuq6aKPNm6V9TYVl+Jhl7jQwUfkWaDgytZl/K+lsarE9+gjjQJs4zMHU8K+b6qgW1E
	vMyos7IKEuNjz+TUmjWQFyDcCQBjzDQQifajq8PLp5R3sajAUI3Ejj+AHZd67rYSu/CADrvOWJp
	e1m356B9nhxinV7k99bcEJnLikC93hcz1jYRjOmBdZ+tLBZAdUiEAf8yqHbiQtzz/smvFwD2fZJ
	cJuul4fki318jgWrMs+DaFo7JEuPp6up4h/A6lvXs0amlqg5+zhoS2alCyxe60kXItDDVsfx846
	mSQn8uE927+q6vn/HJzZSJgaOG+Yu28dJlHjtPpJ/OKlzW45lf77Jd0BfUA9lIiEKaqPl1GbF/a
	A8wTaJzSPZUd/h38brbklJiQcCNtMVFuFVLrQ/HlfTZ3WqIndB83qsMhwJ8KFtvAZ2XASUNNnoB
	mSh11D/QvYlrOSmfmjoAEDW0BAbQ==
X-Received: by 2002:a17:902:fc44:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2a9516cd921mr25618055ad.7.1770363551702;
        Thu, 05 Feb 2026 23:39:11 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7a047sm13575125ad.27.2026.02.05.23.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:39:11 -0800 (PST)
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
Subject: [PATCH v8 15/17] ntfs: add Kconfig and Makefile
Date: Fri,  6 Feb 2026 16:18:58 +0900
Message-Id: <20260206071900.6800-16-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260206071900.6800-1-linkinjeon@kernel.org>
References: <20260206071900.6800-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76567-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 189F4FB0E8
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


