Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760792F3E4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393885AbhALWDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:03:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbhALWDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:03:39 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRkd-0003bd-8g; Tue, 12 Jan 2021 22:02:55 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/42] fs: add attr_flags_to_mnt_flags helper
Date:   Tue, 12 Jan 2021 23:00:47 +0100
Message-Id: <20210112220124.837960-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=e2Flmg4jYrA1/8xjvTMZVbDsoqOcpDdlFS5OCvIgQko=; m=j8IYdqF5TyXvVdakkdM1Yy728RCVQaFxu74H75eIEr4=; p=ookErxTPvXKLHiKI8N1UF+F7LAbqJ0lYoRIToMAm7ho=; g=f364f419030f1b33d11154114b1ba3e23cb27139
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtQAKCRCRxhvAZXjcorDrAQCEJk/ yRc+oltxarCyNyLv2069AFVsG/aLvco1LfYiPaQD+N9dUDwte64sa/Qg/9sztLw1Cd3AaxMsQxSED 5kFOGgM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to translate uapi MOUNT_ATTR_* flags to MNT_* flags
which we will use in follow-up patches too.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch not present

/* v4 */
patch introduced

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Align "\" in defines further in.
---
 fs/namespace.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4aab396e5f21..a1cfcab217e1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3453,6 +3453,28 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
+#define FSMOUNT_VALID_FLAGS \
+	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | \
+	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)
+
+static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
+{
+	unsigned int mnt_flags = 0;
+
+	if (attr_flags & MOUNT_ATTR_RDONLY)
+		mnt_flags |= MNT_READONLY;
+	if (attr_flags & MOUNT_ATTR_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (attr_flags & MOUNT_ATTR_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (attr_flags & MOUNT_ATTR_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	if (attr_flags & MOUNT_ATTR_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+
+	return mnt_flags;
+}
+
 /*
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
@@ -3475,24 +3497,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
 		return -EINVAL;
 
-	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
-			   MOUNT_ATTR_NOSUID |
-			   MOUNT_ATTR_NODEV |
-			   MOUNT_ATTR_NOEXEC |
-			   MOUNT_ATTR__ATIME |
-			   MOUNT_ATTR_NODIRATIME))
+	if (attr_flags & ~FSMOUNT_VALID_FLAGS)
 		return -EINVAL;
 
-	if (attr_flags & MOUNT_ATTR_RDONLY)
-		mnt_flags |= MNT_READONLY;
-	if (attr_flags & MOUNT_ATTR_NOSUID)
-		mnt_flags |= MNT_NOSUID;
-	if (attr_flags & MOUNT_ATTR_NODEV)
-		mnt_flags |= MNT_NODEV;
-	if (attr_flags & MOUNT_ATTR_NOEXEC)
-		mnt_flags |= MNT_NOEXEC;
-	if (attr_flags & MOUNT_ATTR_NODIRATIME)
-		mnt_flags |= MNT_NODIRATIME;
+	mnt_flags = attr_flags_to_mnt_flags(attr_flags);
 
 	switch (attr_flags & MOUNT_ATTR__ATIME) {
 	case MOUNT_ATTR_STRICTATIME:
-- 
2.30.0

