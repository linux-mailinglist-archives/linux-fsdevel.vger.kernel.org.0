Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E292FEDC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbhAUO6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:58:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54948 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbhAUNaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:30:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zv5-0005g7-Up; Thu, 21 Jan 2021 13:22:40 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 33/40] fs: add attr_flags_to_mnt_flags helper
Date:   Thu, 21 Jan 2021 14:19:52 +0100
Message-Id: <20210121131959.646623-34-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=e2Flmg4jYrA1/8xjvTMZVbDsoqOcpDdlFS5OCvIgQko=; m=u2M4i3oMTrdlKn+85wXLpp6CTMaMeluzJmUp7YHjalg=; p=JfaZUhuTz6XFrBAP3FKbw5UfGeFYsRx1RlcZfKhbBn0=; g=f364f419030f1b33d11154114b1ba3e23cb27139
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pgAKCRCRxhvAZXjcouLeAQCwN0L UMzAc+b2wV9R/1ubGXmwbf3c4wOilRFaNYGjMKAD+MRD1HJobIaj05yjpH2QI+aqS5YhdQvfZFIk0 1fZgYQU=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to translate uapi MOUNT_ATTR_* flags to MNT_* flags
which we will use in follow-up patches too.

Link: https://lore.kernel.org/r/20210112220124.837960-6-christian.brauner@ubuntu.com
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
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
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 fs/namespace.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 774ae5f74716..00ed0d6cb2ee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3465,6 +3465,28 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
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
@@ -3487,24 +3509,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
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

