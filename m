Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C383191B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 21:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgCXUq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 16:46:29 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:38698 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgCXUqR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:46:17 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 40AFDC61B2C;
        Tue, 24 Mar 2020 20:46:14 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH RESEND v9 7/8] proc: move hidepid values to uapi as they are user interface to mount
Date:   Tue, 24 Mar 2020 21:44:48 +0100
Message-Id: <20200324204449.7263-8-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324204449.7263-1-gladkov.alexey@gmail.com>
References: <20200324204449.7263-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 include/linux/proc_fs.h      |  9 +--------
 include/uapi/linux/proc_fs.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/proc_fs.h

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index afd38cae2339..d259817ec913 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <uapi/linux/proc_fs.h>
 
 struct proc_dir_entry;
 struct seq_file;
@@ -27,14 +28,6 @@ struct proc_ops {
 	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 };
 
-/* definitions for hide_pid field */
-enum {
-	HIDEPID_OFF	  = 0,
-	HIDEPID_NO_ACCESS = 1,
-	HIDEPID_INVISIBLE = 2,
-	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
-};
-
 /* definitions for proc mount option pidonly */
 enum {
 	PROC_PIDONLY_OFF = 0,
diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
new file mode 100644
index 000000000000..dc6d717aa6ec
--- /dev/null
+++ b/include/uapi/linux/proc_fs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_PROC_FS_H
+#define _UAPI_PROC_FS_H
+
+/* definitions for hide_pid field */
+enum {
+	HIDEPID_OFF            = 0,
+	HIDEPID_NO_ACCESS      = 1,
+	HIDEPID_INVISIBLE      = 2,
+	HIDEPID_NOT_PTRACEABLE = 4,
+};
+
+#endif
-- 
2.25.2

