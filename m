Return-Path: <linux-fsdevel+bounces-64645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45049BEF133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9053E3005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60FF2571DE;
	Mon, 20 Oct 2025 02:13:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8782367D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926410; cv=none; b=ngsdXUVbbosAuAh3g7YKhCC4R4bzAYJ9nh8AVnEaZztGzUS/OjvFMlEfqZNbjsH0oxG3KhXulklN0QIYHpGFl3GfpK2RQOD31ouXADfdne5+stnpVmuoHJflcXH7qjut6U1v8j/6osc3ONX8cJTiTyoDA752DkgWuDcdx6MYFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926410; c=relaxed/simple;
	bh=pKjAvPilpvYO7Jqc8Cja9FjPI9P4hoIdJDieFWm0WiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFhVFujBwl6UJ6V8BkuvJZqlb7Xnq1JwTu5kMOdpOzAWBNdfA/nnNZZqhHWIathEMaODRqKUZSj16rodfP/H7c5KjyZ83VHc+fwX91bDFgyKl/bGSqlMKNCJJlVJ7GqJfEsxpbYQ7gMJQhyaRFTf+nSxJPRe+WKhZ9yYPNHkAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so3329142b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926406; x=1761531206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmceufBWbFt/6jbFM7UlsShW+ci0E83Fk+RSbao9kcM=;
        b=U4HH64eYFchnR7TheFkp55y67opdmNOt9VKn/i0GXdtQonDHvGLdLSuO6I3C83rTSK
         mp7Dmk8vLLbrQNsvsBqHZ5N43dRpy2lyCsFfrU/w1dPAq561031D047v/UPKDQAoGJs2
         76rGyzNalvdMMfNc8xacfaRH/UQqsMC0rfDourtdbKFUEPLDQwXfCbQa6AEtGRtJbrlh
         ATl77pQNFmqJGRpWQBWE9/m/+k/lXr1nsge7RPpinUBfpj9dVAy9AcOtMpWY23aR2FxR
         3e7JEEyJBqtumJINIBowRtu9hK4YSuludLn1lU6nUDsWDbepZU4WCHv76w+wxIQfnoOv
         nFIA==
X-Gm-Message-State: AOJu0YySRsgxxtpyPtvVwKLARDMf26CbPYRErhUgtFV2gnbrhqM7jpMa
	lwLurxBRdA0lthz6mOrZ6cj5JhLjqA1pR3M5rh52aezrikkyyeMPB2Ok
X-Gm-Gg: ASbGnctG5ZT5inYqbJCY0fjMOcHbo3teyRWUYN040ttgNyb62RMeZ78/qgdo4cw6yYI
	VjOV0fALvUBWC2a5wOwtk9tDA5qCFUeAnbjBhQTuTNmI6+FR/ukHFPptkVQ8Mfaxe7uuSrFTfFb
	ARo5IZdU4QiuOw100r5DoRQOaa35wNb5IB5X7RLV9BqlRr5TS6fTUCxQ1IOEOtIxk7JkkcIVkw+
	5t4+iV64glnAUNyCZFw8m9/SKX2XI96mkLh0MeK3YNFY98IUA6fvtXdD3UeQ0pguJRWbAVSVfV8
	0NP9Aje/9KZYr4PHgjrB8MU0V/V0HzehvgLUMQx9aT3XMNereB4K1qqairldZr7ycIcDVerBigE
	DRcbvw/uo0TJm517orC8imHQepnpNZZqs+J5FhVaeNCk/fJ4RAmbPqEMV6QaFeimoxX/I94u4mV
	M98QKdwWZwVSeWbl4=
X-Google-Smtp-Source: AGHT+IH/VWP7TZWHKAiIfbLLsoIQAFhHFivlRyqDMDn9BcgY57BaQ6LySkAtHNmr6Ox+Cz0wR0h+3g==
X-Received: by 2002:a05:6a21:6da6:b0:263:b547:d0c3 with SMTP id adf61e73a8af0-334a85d9ef8mr14056890637.36.1760926406576;
        Sun, 19 Oct 2025 19:13:26 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm6406849a12.0.2025.10.19.19.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:13:25 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
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
Subject: [PATCH 11/11] ntfsplus: add Kconfig and Makefile
Date: Mon, 20 Oct 2025 11:12:27 +0900
Message-Id: <20251020021227.5965-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020021227.5965-1-linkinjeon@kernel.org>
References: <20251020021227.5965-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Kconfig and Makefile for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig           |  1 +
 fs/Makefile          |  1 +
 fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/Makefile | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 fs/ntfsplus/Kconfig
 create mode 100644 fs/ntfsplus/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..70d596b99c8b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
 source "fs/ntfs3/Kconfig"
+source "fs/ntfsplus/Kconfig"
 
 endmenu
 endif # BLOCK
diff --git a/fs/Makefile b/fs/Makefile
index e3523ab2e587..2e2473451508 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -91,6 +91,7 @@ obj-y				+= unicode/
 obj-$(CONFIG_SMBFS)		+= smb/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
+obj-$(CONFIG_NTFSPLUS_FS)	+= ntfsplus/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
new file mode 100644
index 000000000000..c13cd06720e7
--- /dev/null
+++ b/fs/ntfsplus/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFSPLUS_FS
+	tristate "NTFS+ file system support"
+	select NLS
+	help
+	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
+	  This allows you to mount devices formatted with the ntfs file system.
+
+	  To compile this as a module, choose M here: the module will be called
+	  ntfsplus.
+
+config NTFSPLUS_DEBUG
+	bool "NTFS+ debugging support"
+	depends on NTFSPLUS_FS
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
+config NTFSPLUS_FS_POSIX_ACL
+	bool "NTFS+ POSIX Access Control Lists"
+	depends on NTFSPLUS_FS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support additional access rights
+	  for users and groups beyond the standard owner/group/world scheme,
+	  and this option selects support for ACLs specifically for ntfs
+	  filesystems.
+	  NOTE: this is linux only feature. Windows will ignore these ACLs.
+
+	  If you don't know what Access Control Lists are, say N.
diff --git a/fs/ntfsplus/Makefile b/fs/ntfsplus/Makefile
new file mode 100644
index 000000000000..1e7e830dbeec
--- /dev/null
+++ b/fs/ntfsplus/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfsplus filesystem support.
+#
+
+# to check robot warnings
+ccflags-y += -Wint-to-pointer-cast \
+        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
+        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
+
+obj-$(CONFIG_NTFSPLUS_FS) += ntfsplus.o
+
+ntfsplus-y := aops.o attrib.o collate.o misc.o dir.o file.o index.o inode.o \
+	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
+	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
+	  ntfs_iomap.o
+
+ccflags-$(CONFIG_NTFSPLUS_DEBUG) += -DDEBUG
-- 
2.34.1


