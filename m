Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F43657F84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiL1QFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 11:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiL1QFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:05:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD8192BA
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 08:05:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg10so11507180wmb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 08:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PU9635POemxwDKmm5VBJNB22BtO90u5rPxeWqV5JJQM=;
        b=WFUoe+tyv2U/PyZBuUklrh1xgR9Rjo5FJBU6KjkrFuofVZgDqrPMdmmGaDsuCFQdbo
         fsSyXIsPFJ4ZNK7Dd365O8QbMWmRkYBmKxP9HxJnGK/GIdWjEqKDKaM7Safkp28mmDc5
         bfPgGa4dvMMQgUZEzWGX1gJH29ds9KfJK0CBPDt5q+j0VsKOdPWsd9pbMX2r7hmznDtN
         Wn1dzlZXz3bQNQUyfzT9dQOw6n/8eQgrh2ATVMBLK5EX/Afd+5DZ0rdjgCd0tUXlcXck
         GRGIkz+GTpL1ZN9EYaS/vlvDimosr9GRWsMaGY7IczC5G3hwxVnjntJ9j8p8+rwJvcKx
         Y9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU9635POemxwDKmm5VBJNB22BtO90u5rPxeWqV5JJQM=;
        b=AqGgQWLKp+N1Pu91suGuWTUzH4DuIvPVuP6iChtDta6J7maD4mexdlm6FwgYYcQf6v
         OzXPmVZznwzuIguImaoLn9Y2FHcIZlxy1BY2Q4lD9voz7IMrQGsm7nNyloDfLwzD/1Jv
         9XC4pV59IgI7klDV5cD6hfCIRKbmCWRpRYFwpyqjuDZZEhvgxTW5n40z/PdlcQqwptLB
         9vYn8zEGq0Tlo2JZnjjVOZT1/tVc87/cqRQZpCbzYR8ZubXz1cx2G5poq+Ps6zPM8g16
         ILjjQS7R5R/+BaizSpuwxp0gfOQuz4GlFamZF2aG5s83X1DxuNB3zeYS9/1jIC0+P2BW
         l2sA==
X-Gm-Message-State: AFqh2koO+SzrE0gamECLbSb1ujRqLLh02dDbgGzOqBG7NmnNHElNnVTm
        6iGc1lJGBYUfJAq1j7DDW4C7OWQvrcltoPCEoJYRiQ==
X-Google-Smtp-Source: AMrXdXsiCpYBueXRJXFRX5Npqbo8GYiSXFBdZ7NEkiKJe6SGRWdI1eLl7vTMaNi/wuqjd3b8KHIOOw==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr18597235wma.4.1672243537543;
        Wed, 28 Dec 2022 08:05:37 -0800 (PST)
Received: from localhost.localdomain ([2400:adc1:158:c700:5f84:8415:6e5a:7fea])
        by smtp.googlemail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm40491463wms.2.2022.12.28.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:05:36 -0800 (PST)
From:   Ameer Hamza <ahamza@ixsystems.com>
To:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        chuck.lever@oracle.com, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, f.fainelli@gmail.com, slark_xiao@163.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ahamza@ixsystems.com,
        awalker@ixsystems.com
Subject: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Date:   Wed, 28 Dec 2022 21:02:49 +0500
Message-Id: <20221228160249.428399-1-ahamza@ixsystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a new flag O_EMPTY_PATH that allows openat and open
system calls to open a file referenced by fd if the path is empty,
and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
beneficial in some cases since it would avoid having to grant /proc
access to things like samba containers for reopening files to change
flags in a race-free way.

Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
---
 fs/fcntl.c                             | 2 +-
 fs/namei.c                             | 4 ++--
 fs/open.c                              | 2 +-
 include/linux/fcntl.h                  | 2 +-
 include/uapi/asm-generic/fcntl.h       | 4 ++++
 tools/include/uapi/asm-generic/fcntl.h | 4 ++++
 6 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 146c9ab0cd4b..7aac650e16e2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1027,7 +1027,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 309ae6fc8c99..2b2735af6d03 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -192,7 +192,7 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	if (unlikely(!len)) {
 		if (empty)
 			*empty = 1;
-		if (!(flags & LOOKUP_EMPTY)) {
+		if (!(flags & (LOOKUP_EMPTY | O_EMPTY_PATH))) {
 			putname(result);
 			return ERR_PTR(-ENOENT);
 		}
@@ -2347,7 +2347,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
 		return ERR_PTR(-EAGAIN);
 
-	if (!*s)
+	if (!*s && unlikely(!(flags & O_EMPTY_PATH)))
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..b4ec054a418f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1301,7 +1301,7 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 	if (fd)
 		return fd;
 
-	tmp = getname(filename);
+	tmp = getname_flags(filename, how->flags & O_EMPTY_PATH, NULL);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..bf8467bb0bd2 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTY_PATH)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..a03f4275517b 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index b02c8e0f4057..f32a81604296 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.25.1

