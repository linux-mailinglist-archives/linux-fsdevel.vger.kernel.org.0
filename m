Return-Path: <linux-fsdevel+bounces-78934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCbZN7KypWlMEgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:54:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F41DC374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF8230A846B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84541162B;
	Mon,  2 Mar 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="AXDpSbGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74133413231
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466665; cv=none; b=Qua2zkPyHeB03Bmh7Pls93f54XxCr10/U24qJ1GtSZT+zK9It8abFMoavEqLXojbjDC+a0sojFnQfU+PlhHM235FclHe3ZCHZR1KokiBxj1CA135Is4aOZ4YtQTQtHVUcoOKuvic7QEA9JCoizK3JXvp8wApPvoSsT1EMbLJtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466665; c=relaxed/simple;
	bh=9btNLZk8U1UR9d6AEN3rPUFBMywkWOsT0Wm70l56Cms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwvUCB+kmcW26bwjJB1T0LU4sgw3RiZFMS2nHZYDOnnofZiASXd7rCuy8NbTXHDeWxPjjkuRIB5Z00Nt1skBfmyLoPkP094dYKd6G4b26BUtJLxwKzhXFR8K3fvvkiQNkoSzt+X7ZpBnbXVp2eWN7/j73i2hCdMdWOo5IGkgJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=AXDpSbGr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab39b111b9so22229855ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1772466662; x=1773071462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTP8GuicL4lDMlLNsmOlZZBi51EIqCGshrumwx1QleU=;
        b=AXDpSbGrQieDzXdRmV172mvN+mxXjTPn0NdEJtAS525EJs8fwCnx/d9pZkamn1ZECa
         hKUIYerBd/U/knnp0hXQTn5Vfv4GIbLprE7x3+IqiPRdX/vmk9dzUa9GoVj1V3jXSuiM
         rNE1Uk2+8I93Pq0++WV2dvaND6Z1EYYpHA5xjhNm+eZKqU2O6xjU/EhN2V5YPkVXlN0J
         /RW9sODsGoJGWL5JyKTdrbm2qTBji/LP/5AhrR4w4PqZoKtcOgtjrmdO5yfjdOXHyuVg
         qrLoV1lAx/wmDCdI9UMbhJIc3VPwScawQmlUGH3qQoyaK0IHlcL0NBGzcQql6EGxQkS/
         jPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466662; x=1773071462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTP8GuicL4lDMlLNsmOlZZBi51EIqCGshrumwx1QleU=;
        b=XPqRKEPePdygyO3BMg5N8gK7bGYfsk9LvSfzYakGURfaQbHECZNiCkgN0T/e2RNdP5
         4e74Ex88V577/D14xAKHJB0LpIeGNeaemR63iBx9Od2Y2Adq4buTV7qLmNrPtk0V/8vv
         M/U0UCB2n2qQoyYmwi8VHjHZE0jwiSFfmoxsQkUuQKb08BVid7PFqk8TNTSZrU11Cquk
         /yTFXMbu+DrI9LLAWU5PSGK9W1tfo415+zGKABTrwd9Gwom1fKnXCb44GAV9AcdRrBco
         A4KM0nxrj9z9BGSMnRqhur3FoT83Cp9zUh6tm2MxaxFWDpyIVUMdd7vdXQ4KI7pP7IWm
         sU5w==
X-Gm-Message-State: AOJu0YylxFlz8Xtc0/XppVc/kaM2IeV9nPbDl5aU+riQdP4enl67J5uy
	CweCLieqiGvKMXR8wFjBoYr90lVwmWX3Zpt8AWB9v1rPOfcWzyMYTHKm0cWVXiW5UwM=
X-Gm-Gg: ATEYQzwuFhBwEStoZrFt5x23E9yBM4zkNqVpdn9/LQtwmQ+c4LUnFiV/UuM6oPkUnAx
	r8HnGluwjKTX+WAUptnHnBxyvf7aDYYbRzYxNauifVLcCk0+TXm+2ANzZEpHIsOzsC6zck9kejc
	THhUcePMKYFfUt54fmRnQFkSX+vhyDZCTmRko3Y2KPpuq0VvJGdRST76F65OcfFdvPkGKmciTO9
	SHD6+CxgUXQRVg/R1o9bB7+W/oeLoLE7cvK5Af6g3LDkPhBfgfakZyj538sTYUE2dPTQ/ydHHJe
	QPxL9B5SZ+86AMQKnvS994TFX5QHLDy0hLVBlsWJqZl58lW+FSjHYe9ZE0yvegwdhHqQWm5jpbZ
	VH+E4aNIglfdbEaFYoMkjkRAp5C/z/V9JV1aHR/HDnPi4yJIS6bKHKYo9Ya9N7tgZEyYBoRlhUm
	9hRAdaJ2Gj
X-Received: by 2002:a17:903:3c6d:b0:2a9:47ff:1020 with SMTP id d9443c01a7336-2ae2e3e3c2emr111057265ad.8.1772466662493;
        Mon, 02 Mar 2026 07:51:02 -0800 (PST)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f244sm153611115ad.59.2026.03.02.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:51:02 -0800 (PST)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Mon,  2 Mar 2026 23:50:46 +0800
Message-ID: <20260302155046.286650-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 419F41DC374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hev-cc.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78934-lists,linux-fsdevel=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[hev.cc];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hev-cc.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[r@hev.cc,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hev.cc:mid,hev.cc:email]
X-Rspamd-Action: no action

When Transparent Huge Pages (THP) are enabled in "always" mode,
file-backed read-only mappings can be backed by PMD-sized huge pages
if they meet the alignment and size requirements.

For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
segments are normally aligned according to p_align, which is often
only page-sized. As a result, large read-only segments that are
otherwise eligible may fail to be mapped using PMD-sized THP.

Introduce a new Kconfig option, CONFIG_ELF_RO_LOAD_THP_ALIGNMENT,
to allow bumping the maximum alignment of eligible read-only PT_LOAD
segments to PMD_SIZE.

A segment is considered eligible if:

* THP is in "always" mode,
* it is not writable,
* both p_vaddr and p_offset are PMD-aligned,
* its file size is at least PMD_SIZE, and
* its existing p_align is smaller than PMD_SIZE.

To avoid excessive address space padding on systems with very large
PMD_SIZE values, this optimization is applied only when PMD_SIZE <= 32MB.

This increases the likelihood that large text segments of ELF
executables are backed by PMD-sized THP, reducing TLB pressure and
improving performance for large binaries.

This only affects ELF executables loaded directly by the kernel
binary loader. Shared libraries loaded by user space (e.g. via the
dynamic loader) are not affected.

The behavior is guarded by CONFIG_ELF_RO_LOAD_THP_ALIGNMENT and
depends on READ_ONLY_THP_FOR_FS, so existing systems remain
unchanged unless explicitly enabled.

Signed-off-by: WANG Rui <r@hev.cc>
---
 fs/Kconfig.binfmt | 12 ++++++++++++
 fs/binfmt_elf.c   |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..8d4271769e08 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -74,6 +74,18 @@ config ELFCORE
 	help
 	  This option enables kernel/elfcore.o.
 
+config ELF_RO_LOAD_THP_ALIGNMENT
+	bool "Align read-only ELF load segments for THP (EXPERIMENTAL)"
+	depends on READ_ONLY_THP_FOR_FS
+
+	help
+	  Align eligible read-only ELF PT_LOAD segments to PMD_SIZE so
+	  they can be mapped using PMD-sized Transparent Huge Pages
+	  when THP is enabled in "always" mode.
+
+	  This only affects ELF executables loaded by the kernel ELF
+	  binary loader.
+
 config CORE_DUMP_DEFAULT_ELF_HEADERS
 	bool "Write ELF core dumps with partial segments"
 	default y
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8e89cc5b2820..2c2ccb041938 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -28,6 +28,7 @@
 #include <linux/highuid.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/huge_mm.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
@@ -500,6 +501,14 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;
+
+#if defined(CONFIG_ELF_RO_LOAD_THP_ALIGNMENT) && PMD_SIZE <= SZ_32M
+			if (hugepage_global_always() && !(cmds[i].p_flags & PF_W)
+				&& IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset, PMD_SIZE)
+				&& cmds[i].p_filesz >= PMD_SIZE && p_align < PMD_SIZE)
+				p_align = PMD_SIZE;
+#endif
+
 			alignment = max(alignment, p_align);
 		}
 	}
-- 
2.53.0


