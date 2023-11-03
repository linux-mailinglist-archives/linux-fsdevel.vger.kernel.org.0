Return-Path: <linux-fsdevel+bounces-1934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1EE7E05DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051F11C2108E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79D1C6BB;
	Fri,  3 Nov 2023 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M422NdXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D81C69C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:57:41 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A956D42
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:57:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cc433782so29310807b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027058; x=1699631858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzeG8MD6N/WIiNo2un1jd4u7MnqtipFegLOFtiVvH70=;
        b=M422NdXZUgiqxdSg2ta+a1RKvJW+n1b+/kqXn0ur6hRIAeSgtyUD/p5LM/1YI1nEtE
         K6PkPVQXOOsU32+qWAkTWlWTO/fJCpo6vkmeifCZ0wCl5qBHs3OunBYWHGlrlEgeOMPd
         4J+QHppvXgDVN3W/j6FPNGbRCuL/rJ+7/3UfBQXxVnn7hKFz+15G19TobVSYjet4MUXm
         svKp+WiyJ16hddh+jT/RYT6a5xi0E9BtybBZeiCqXUXN/F5r74g9mDhh7TtrTZGNUeif
         2vNsYQrDK1E44Ak1ou9p7L13hNho50dsUR0MiakEpX6B2QiJ5g6pzEZp2/ePDmgejrKW
         e/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027058; x=1699631858;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzeG8MD6N/WIiNo2un1jd4u7MnqtipFegLOFtiVvH70=;
        b=B/nEwnpNUso90P82x5GDNbU6YHN/LOQN/VRl4qu2dN81wPzBJXN+/VyCl4jJjvWBYg
         NO2UZ7F63eZfo4/mPA76to2ZnnvFZJY5LkworXpb/pgT5eRLnso8sWonF0qmsnIp+3DS
         QLQmyVxQa9YHn0SqPLUE8aENRoeBbPT9TxceXO2IXWQ+oQl9tnHx+CgxA80zuRt+Pg3u
         557urZNPdpkVAYchoMT1d3B/IqZwqhG5b6yr05BTj+pqKT4jHKdiZAX1JUsw8ouFIT33
         ahOaRKOOAcjHnhiyrI+eM2X226WcAW/T6N3lPgXwn8YCsmxAHTzwoWeXe2SEddf/1Coc
         v8bw==
X-Gm-Message-State: AOJu0YwMwGUB599wxXOQ0C4p93d3MaRzRkaap6gtRRwpXr/OB7V742/v
	6Syst9WRNXhE94vXY9Z1wZgT+ikk1Ds=
X-Google-Smtp-Source: AGHT+IHatHk6FCkLf0/gKhX7MmgaJIXF9vcEUQCbXwS3+kxJowRhTAmJrZ4arZPoE7gD35Im8qCFMLJy8xE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:a81:5215:0:b0:5a7:acc1:5142 with SMTP id
 g21-20020a815215000000b005a7acc15142mr61937ywb.8.1699027058095; Fri, 03 Nov
 2023 08:57:38 -0700 (PDT)
Date: Fri,  3 Nov 2023 16:57:12 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 2/7] landlock: Add IOCTL access right
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
and increments the Landlock ABI version to 5.

Like the truncate right, these rights are associated with a file
descriptor at the time of open(2), and get respected even when the
file descriptor is used outside of the thread which it was originally
opened in.

A newly enabled Landlock policy therefore does not apply to file
descriptors which are already open.

If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
of safe IOCTL commands will be permitted on newly opened files.  The
permitted IOCTLs can be configured through the ruleset in limited ways
now.  (See documentation for details.)

Noteworthy scenarios which require special attention:

TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
used to control shell processes on the same terminal which run at
different privilege levels, which may make it possible to escape a
sandbox.  Because stdin, stdout and stderr are normally inherited
rather than newly opened, IOCTLs are usually permitted on them even
after the Landlock policy is enforced.

Some legitimate file system features, like setting up fscrypt, are
exposed as IOCTL commands on regular files and directories -- users of
Landlock are advised to double check that the sandboxed process does
not need to invoke these IOCTLs.

Known limitations:

The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
over IOCTL commands.  Future work will enable a more fine-grained
access control for IOCTLs.

In the meantime, Landlock users may use path-based restrictions in
combination with their knowledge about the file system layout to
control what IOCTLs can be done.  Mounting file systems with the nodev
option can help to distinguish regular files and devices, and give
guarantees about the affected files, which Landlock alone can not give
yet.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                | 31 +++++---
 security/landlock/fs.c                       | 74 ++++++++++++++++++--
 security/landlock/limits.h                   | 10 ++-
 security/landlock/ruleset.h                  | 53 +++++++++++++-
 security/landlock/syscalls.c                 |  6 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 +-
 7 files changed, 161 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..6d41c059e910 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -128,7 +128,7 @@ struct landlock_net_port_attr {
  * files and directories.  Files or directories opened before the sandboxi=
ng
  * are not subject to these restrictions.
  *
- * A file can only receive these access rights:
+ * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
@@ -138,12 +138,13 @@ struct landlock_net_port_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -198,13 +199,26 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
+ * The following access right applies both to files and directories:
+ *
+ * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` commands on an =
opened
+ *   file or directory.
+ *
+ *   This access right applies to all :manpage:`ioctl(2)` commands, except=
 of
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC`` and ``FIONREAD``=
.
+ *   These commands continue to be invokable independent of the
+ *   %LANDLOCK_ACCESS_FS_IOCTL access right.
+ *
+ *   This access right is available since the fourth version of the Landlo=
ck
+ *   ABI.
+ *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -223,6 +237,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bc7c126deea2..aa54970c235f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -7,12 +7,14 @@
  * Copyright =C2=A9 2021-2022 Microsoft Corporation
  */
=20
+#include <asm/ioctls.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/compiler_types.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -28,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
=20
 #include "common.h"
@@ -147,7 +150,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 /* clang-format on */
=20
 /*
@@ -157,6 +161,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *co=
nst ruleset,
 			    const struct path *const path,
 			    access_mask_t access_rights)
 {
+	access_mask_t handled;
 	int err;
 	struct landlock_id id =3D {
 		.type =3D LANDLOCK_KEY_INODE,
@@ -169,9 +174,11 @@ int landlock_append_fs_rule(struct landlock_ruleset *c=
onst ruleset,
 	if (WARN_ON_ONCE(ruleset->num_layers !=3D 1))
 		return -EINVAL;
=20
+	handled =3D landlock_get_fs_access_mask(ruleset, 0);
+	/* Expands the synthetic IOCTL groups. */
+	access_rights |=3D expand_all_ioctl(handled, access_rights);
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |=3D LANDLOCK_MASK_ACCESS_FS &
-			 ~landlock_get_fs_access_mask(ruleset, 0);
+	access_rights |=3D LANDLOCK_MASK_ACCESS_FS & ~handled;
 	id.key.object =3D get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
@@ -1123,7 +1130,9 @@ static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
 	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	const access_mask_t optional_access =3D
+		LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL |
+		IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3 | IOCTL_CMD_G4;
 	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
=20
 	if (!dom)
@@ -1196,6 +1205,62 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static access_mask_t required_ioctl_access(unsigned int cmd)
+{
+	switch (cmd) {
+	case FIOQSIZE:
+		return IOCTL_CMD_G1;
+	case FS_IOC_FIEMAP:
+	case FIBMAP:
+	case FIGETBSZ:
+		return IOCTL_CMD_G2;
+	case FIONREAD:
+	case FIDEDUPERANGE:
+		return IOCTL_CMD_G3;
+	case FICLONE:
+	case FICLONERANGE:
+	case FS_IOC_RESVSP:
+	case FS_IOC_RESVSP64:
+	case FS_IOC_UNRESVSP:
+	case FS_IOC_UNRESVSP64:
+	case FS_IOC_ZERO_RANGE:
+		return IOCTL_CMD_G4;
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+		/*
+		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
+		 * close-on-exec and the file's buffered-IO and async flags.
+		 * These operations are also available through fcntl(2),
+		 * and are unconditionally permitted in Landlock.
+		 */
+		return 0;
+	default:
+		/*
+		 * Other commands are guarded by the catch-all access right.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL;
+	}
+}
+
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	access_mask_t required_access =3D required_ioctl_access(cmd);
+	access_mask_t allowed_access =3D landlock_file(file)->allowed_access;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether ioctl can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	if ((allowed_access & required_access) =3D=3D required_access)
+		return 0;
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1218,6 +1283,7 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 93c9c6f91556..d0a95169ba3f 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,15 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_PUBLIC_ACCESS_FS	LANDLOCK_ACCESS_FS_IOCTL
+#define LANDLOCK_MASK_PUBLIC_ACCESS_FS	((LANDLOCK_LAST_PUBLIC_ACCESS_FS <<=
 1) - 1)
+
+#define IOCTL_CMD_G1			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
+#define IOCTL_CMD_G2			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
+#define IOCTL_CMD_G3			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
+#define IOCTL_CMD_G4			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)
+
+#define LANDLOCK_LAST_ACCESS_FS		IOCTL_CMD_G4
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 #define LANDLOCK_SHIFT_ACCESS_FS	0
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c7f1526784fd..58d96aff3980 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -30,7 +30,7 @@
 	LANDLOCK_ACCESS_FS_REFER)
 /* clang-format on */
=20
-typedef u16 access_mask_t;
+typedef u32 access_mask_t;
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
@@ -256,6 +256,54 @@ static inline void landlock_get_ruleset(struct landloc=
k_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
=20
+/**
+ * expand_ioctl - return the dst flags from either the src flag or the
+ * LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
+ * LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
+ *
+ * @handled: Handled access rights
+ * @access:  The access mask to copy values from
+ * @src:     A single access right to copy from in @access.
+ * @dst:     One or more access rights to copy to
+ *
+ * Returns:
+ * @dst, or 0
+ */
+static inline access_mask_t expand_ioctl(access_mask_t handled,
+					 access_mask_t access,
+					 access_mask_t src, access_mask_t dst)
+{
+	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
+		return 0;
+
+	access_mask_t copy_from =3D (handled & src) ? src :
+						    LANDLOCK_ACCESS_FS_IOCTL;
+	if (access & copy_from)
+		return dst;
+	return 0;
+}
+
+/**
+ * Returns @access with the synthetic IOCTL group flags enabled if necessa=
ry.
+ *
+ * @handled: Handled FS access rights.
+ * @access:  FS access rights to expand.
+ *
+ * Returns:
+ * @access expanded by the necessary flags for the synthetic IOCTL access =
rights.
+ */
+static inline access_mask_t expand_all_ioctl(access_mask_t handled,
+					     access_mask_t access)
+{
+	return access |
+	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
+			    IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4) |
+	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
+			    IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3) |
+	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
+			    IOCTL_CMD_G1);
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -265,6 +313,9 @@ landlock_add_fs_access_mask(struct landlock_ruleset *co=
nst ruleset,
=20
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(fs_access_mask !=3D fs_mask);
+
+	fs_mask =3D expand_all_ioctl(fs_mask, fs_mask);
+
 	ruleset->access_masks[layer_level] |=3D
 		(fs_mask << LANDLOCK_SHIFT_ACCESS_FS);
 }
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 898358f57fa0..67121cf7165d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -137,7 +137,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 4
+#define LANDLOCK_ABI_VERSION 5
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -192,8 +192,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return err;
=20
 	/* Checks content (and 32-bits cast). */
-	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=3D
-	    LANDLOCK_MASK_ACCESS_FS)
+	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS) !=
=3D
+	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)
 		return -EINVAL;
=20
 	/* Checks network content (and 32-bits cast). */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 646f778dfb1e..d292b419ccba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 18e1f86a6234..256cd9a96eb7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -525,9 +525,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.42.0.869.gea05f2083d-goog


