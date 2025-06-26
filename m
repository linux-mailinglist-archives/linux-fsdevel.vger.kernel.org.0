Return-Path: <linux-fsdevel+bounces-53057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827EAE95F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B564A4677
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD54267B65;
	Thu, 26 Jun 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BICfK/d0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E95PjGVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEA25FA34;
	Thu, 26 Jun 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918231; cv=none; b=SMu+eVPhe4b9rxntUbXTblTJPfUsFB/fu0gDZNGgWLn8E6lXDeMrwClr6cupUsDH1c9dw9GYQRJ/wA8q6X3OJ6OuuwlnTs/Dgzc0+x9I2bmgoHeafXhD3v/o02cU+paBszq0SGb/EXwlLLZbJjfbl4BeS2jaaKBbbj+rpPPdXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918231; c=relaxed/simple;
	bh=Ez0O5tehZeTQJpNtECQ7NQ1Zh99cpPAEJsAxQEXoxtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=parwxByWWMbe3XFf5nXBcxizQUmSP47qr8dFTX+9QDpoJvaGvhCvyuf0vkLEkegDPq8990A5PWe4eIC2LFYiN9FXsWZ2gk/ul1On8q2VDcJTmO4AZgHVTwIRh4IMHSUiQkiM79L86nDxwjpbRSYzDCbhILur4cuBoBcMEf9cWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BICfK/d0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E95PjGVw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2WfdTt5zLz36UPr6FBV83XX1M+loHxB368/1Vhlmqc=;
	b=BICfK/d0z+5azVTK89BNiFXrpSOixHMPeOxE7bPONklaJEHobn/SRovAsV9tVTOdNsIFhd
	Qr+zF+VIr8lZM0JdhaZYC2ALl0TItEe6TLPnBm2Cm6mGNBoC173d4JJYaBo5nACDwwrV+h
	oFCKirkLIrECCPYTjV3XpYzPDUexC4xQTaHB/p90j/xQFOcEsa8qNw8G1UI0AME4OeGMrL
	bNdkDBk/by2XaUUVhdNRE4iAKGe9KQZJNpSorFT7xUbpR0B7jJ0WcqsEMPI7j0+rm4Wb5P
	0chIF1i72JT6qaXijUfC92HM6/D4xLI4iiA4CyhI9g+M1RWW36kMC59fB844Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2WfdTt5zLz36UPr6FBV83XX1M+loHxB368/1Vhlmqc=;
	b=E95PjGVwXua4YXVx16vuck7uu6Oftdl+zRcNn9PaSGPnZCi1dyToS61iu1HOuSXo1K+RyO
	oy267dUlk+mh5fDA==
Date: Thu, 26 Jun 2025 08:10:20 +0200
Subject: [PATCH v4 12/15] kunit: Introduce UAPI testing framework
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=15015;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ez0O5tehZeTQJpNtECQ7NQ1Zh99cpPAEJsAxQEXoxtk=;
 b=2kPvgAzvirkOOg8P+bYloREpabP8nhUOzEswtCo+WJOHfhmH7w+uxXJGfMCU3tU+37hd7LGeh
 nO9lg6GlnQVDwkLrZ1FJdnfkJYlRaiNP/5LAWBz8CiYX07mDnR1ede2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Enable running UAPI tests as part of kunit.
The selftests are embedded into the kernel image and their output is
forwarded to kunit for unified reporting.

The implementation reuses parts of usermode drivers and usermode
helpers. However these frameworks are not used directly as they make it
impossible to retrieve a thread's exit code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
To: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/dev-tools/kunit/api/index.rst |   5 +
 Documentation/dev-tools/kunit/api/uapi.rst  |  14 ++
 MAINTAINERS                                 |   6 +
 include/kunit/uapi.h                        |  77 +++++++
 lib/kunit/Kconfig                           |  14 ++
 lib/kunit/Makefile                          |   2 +
 lib/kunit/kunit-uapi.c                      | 300 ++++++++++++++++++++++++++++
 7 files changed, 418 insertions(+)

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 5cdb552a0808f25baeff5e47a9227b7b62c69e40..34d8fee9a97059d6da919a6fb1a7e359b5e0beef 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -9,6 +9,7 @@ API Reference
 	test
 	resource
 	functionredirection
+	uapi
 	clk
 	of
 	platformdevice
@@ -32,6 +33,10 @@ Documentation/dev-tools/kunit/api/functionredirection.rst
 
  - Documents the KUnit Function Redirection API
 
+Documentation/dev-tools/kunit/api/uapi.rst
+
+ - Documents the KUnit Userspace testing API
+
 Driver KUnit API
 ================
 
diff --git a/Documentation/dev-tools/kunit/api/uapi.rst b/Documentation/dev-tools/kunit/api/uapi.rst
new file mode 100644
index 0000000000000000000000000000000000000000..1f01b5c6c9db42f603f6507f2f33ef388f5b91d7
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/uapi.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Userspace Test API
+==================
+
+This file documents all of the userspace testing API.
+Userspace tests are built as :ref:`kbuild userprogs <kbuild_userprogs>`,
+linked statically and without any external dependencies.
+
+For the widest platform compatibility they should use nolibc, as provided by `init/Makefile.nolibc`.
+
+.. kernel-doc:: include/kunit/uapi.h
+   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index e806158cc6798cf97a4aab58c038fb5351d469aa..0f60501c6de570723123b24eb930d15f1bd956eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13540,6 +13540,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 F:	drivers/video/backlight/ktz8866.c
 
+KUNIT UAPI TESTING FRAMEWORK (in addition to KERNEL UNIT TESTING FRAMEWORK)
+M:	Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+S:	Maintained
+F:	include/kunit/uapi.h
+F:	lib/kunit/kunit-uapi.c
+
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
diff --git a/include/kunit/uapi.h b/include/kunit/uapi.h
new file mode 100644
index 0000000000000000000000000000000000000000..a5c923f5d82a91e0acd9dc17369f84f00b7d342f
--- /dev/null
+++ b/include/kunit/uapi.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _KUNIT_UAPI_H
+#define _KUNIT_UAPI_H
+
+#include <linux/types.h>
+
+struct kunit;
+
+/**
+ * struct kunit_uapi_blob - Blob embedded build artifact
+ * @path: Path of the embedded artifact.
+ * @data: Start of the embedded data in memory.
+ * @end: End of the embedded data in memory.
+ */
+struct kunit_uapi_blob {
+	const char *const path;
+	const u8 *data;
+	const u8 *end;
+};
+
+#if IS_ENABLED(CONFIG_KUNIT_UAPI)
+
+/**
+ * KUNIT_UAPI_EMBED_BLOB() - Embed another build artifact into the kernel
+ * @_name: The name of symbol under which the artifact is embedded.
+ * @_path: Path to the artifact on disk.
+ *
+ * Embeds a build artifact like a userspace executable into the kernel or current module.
+ * The build artifact is read from disk and needs to be already built.
+ */
+#define KUNIT_UAPI_EMBED_BLOB(_name, _path)					\
+	asm (									\
+	"	.pushsection .rodata, \"a\"				\n"	\
+	"	.global " __stringify(CONCATENATE(_name, _data)) "	\n"	\
+	__stringify(CONCATENATE(_name, _data)) ":			\n"	\
+	"	.incbin " __stringify(_path) "				\n"	\
+	"	.size " __stringify(CONCATENATE(_name, _data)) ", "		\
+			". - " __stringify(CONCATENATE(_name, _data)) "	\n"	\
+	"	.global " __stringify(CONCATENATE(_name, _end)) "	\n"	\
+	__stringify(CONCATENATE(_name, _end)) ":			\n"	\
+	"	.popsection						\n"	\
+	);									\
+										\
+	extern const char CONCATENATE(_name, _data)[];				\
+	extern const char CONCATENATE(_name, _end)[];				\
+										\
+	static const struct kunit_uapi_blob _name = {				\
+		.path	= _path,						\
+		.data	= CONCATENATE(_name, _data),				\
+		.end	= CONCATENATE(_name, _end),				\
+	}									\
+
+#else /* !CONFIG_KUNIT_UAPI */
+
+/* Unresolved external reference, to be optimized away */
+#define KUNIT_UAPI_EMBED_BLOB(_name, _path)					\
+	extern const struct kunit_uapi_blob _name
+
+#endif /* CONFIG_KUNIT_UAPI */
+
+/**
+ * kunit_uapi_run_kselftest() - Run a userspace kselftest as part of kunit
+ * @test: The test context object.
+ * @executable: kselftest executable to run
+ *
+ * Runs the kselftest and forwards its TAP output and exit status to kunit.
+ */
+void kunit_uapi_run_kselftest(struct kunit *test, const struct kunit_uapi_blob *executable);
+
+#endif /* _KUNIT_UAPI_H */
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..c88e6cf5610bc8246c94d16b9025461f0cd3b2d2 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,18 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_UAPI
+	tristate "KUnit UAPI testing framework"
+	depends on KUNIT
+	depends on CC_CAN_LINK_STATIC || ARCH_HAS_NOLIBC
+	depends on !LTO_CLANG # https://github.com/llvm/llvm-project/issues/112920
+	select HEADERS_INSTALL
+	default KUNIT
+	help
+	  Enables support for building and running userspace selftests as part of kunit.
+	  These tests should be statically linked and use kselftest.h or kselftest_harness.h
+	  for status reporting.
+
+	  In most cases this should be left as Y.
+
 endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc635e67d5b4cb1bc586b48415ac5..6059621a2d32c8e7384acda59793f05826af8c81 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -12,6 +12,8 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
+obj-$(CONFIG_KUNIT_UAPI) +=		kunit-uapi.o
+
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
diff --git a/lib/kunit/kunit-uapi.c b/lib/kunit/kunit-uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..cfe8440e16fde942a5f0fa7ac9d8ab90a737215b
--- /dev/null
+++ b/lib/kunit/kunit-uapi.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#include <linux/binfmts.h>
+#include <linux/export.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/pid.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/sched/task.h>
+#include <linux/types.h>
+
+#include <kunit/test.h>
+#include <kunit/uapi.h>
+
+#define KSFT_PASS	0
+#define KSFT_FAIL	1
+#define KSFT_XFAIL	2
+#define KSFT_XPASS	3
+#define KSFT_SKIP	4
+
+static struct vfsmount *kunit_uapi_mount_ramfs(void)
+{
+	struct file_system_type *type;
+	struct vfsmount *mnt;
+
+	type = get_fs_type("ramfs");
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	/* FIXME
+	 * The mount setup is supposed to look like this:
+	 * kunit_uapi_mount_ramfs() sets up a private mount,
+	 * with nothing visible except the new tmpfs.
+	 * Then each executable execution gets a new namespace on top of that
+	 * on which it can mount whatever it needs.
+	 * However I didn't manage to set this up, so keep everything simple
+	 * for now and let somebody familiar with the VFS figure this out.
+	 */
+
+	mnt = kern_mount(type);
+	put_filesystem(type);
+
+	return mnt;
+}
+
+static int kunit_uapi_write_file(struct vfsmount *mnt, const char *name, mode_t mode,
+				 const u8 *data, size_t size)
+{
+	struct file *file;
+	ssize_t written;
+
+	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, mode);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	written = kernel_write(file, data, size, NULL);
+	filp_close(file, NULL);
+	if (written != size) {
+		if (written >= 0)
+			return -ENOMEM;
+		return written;
+	}
+
+	/* Flush delayed fput so exec can open the file read-only */
+	flush_delayed_fput();
+
+	return 0;
+}
+
+static int kunit_uapi_write_executable(struct vfsmount *mnt,
+				       const struct kunit_uapi_blob *executable)
+{
+	return kunit_uapi_write_file(mnt, kbasename(executable->path), 0755,
+				     executable->data, executable->end - executable->data);
+}
+
+struct kunit_uapi_user_mode_thread_ctx {
+	const char *executable;
+
+	/* Signals mnt, out, pwd and tgid */
+	struct completion setup_done;
+	struct vfsmount *mnt;
+	struct file *out;
+	struct path pwd;
+	pid_t tgid;
+
+	/* Valid after wait(tgid) */
+	int exec_err;
+};
+
+static int kunit_uapi_user_mode_thread_init(void *data)
+{
+	struct kunit_uapi_user_mode_thread_ctx *ctx = data;
+	const char *const argv[] = {
+		ctx->executable,
+		NULL
+	};
+	struct file *out[2];
+	int err;
+
+	err = create_pipe_files(out, 0);
+	if (err)
+		return err;
+
+	/* stdin, use the *write* end to the pipe to have an unreadable input */
+	err = replace_fd(0, out[1], 0);
+	if (err < 0) {
+		fput(out[0]);
+		fput(out[1]);
+		return err;
+	}
+
+	/* stdout */
+	err = replace_fd(1, out[1], 0);
+	if (err < 0) {
+		replace_fd(0, NULL, 0);
+		fput(out[0]);
+		fput(out[1]);
+		return err;
+	}
+
+	/* stderr */
+	err = replace_fd(2, out[1], 0);
+	if (err < 0) {
+		replace_fd(0, NULL, 0);
+		replace_fd(1, NULL, 0);
+		fput(out[0]);
+		fput(out[1]);
+		return err;
+	}
+
+	fput(out[1]);
+
+	ctx->out = out[0];
+	ctx->tgid = current->tgid;
+
+	set_fs_pwd(current->fs, &ctx->pwd);
+	kernel_sigaction(SIGKILL, SIG_DFL);
+	kernel_sigaction(SIGABRT, SIG_DFL);
+
+	complete(&ctx->setup_done);
+	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	if (!ctx->exec_err)
+		return 0;
+	do_exit(0);
+}
+
+static size_t kunit_uapi_printk_subtest_lines(struct kunit *test, char *buf, size_t s)
+{
+	const char *ptr = buf, *newline;
+	size_t n;
+
+	while (s) {
+		newline = strnchr(ptr, s, '\n');
+		if (!newline)
+			break;
+
+		n = newline - ptr + 1;
+
+		kunit_log(KERN_INFO, test, KUNIT_SUBSUBTEST_INDENT "%.*s", (int)n, ptr);
+		ptr += n;
+		s -= n;
+	}
+
+	memmove(buf, ptr, s);
+
+	return s;
+}
+
+static int kunit_uapi_forward_to_printk(struct kunit *test, struct file *output)
+{
+	/*
+	 * printk() automatically adds a newline after each message.
+	 * Therefore only fully accumulated lines can be forwarded.
+	 * Each line needs to fit into the buffer below.
+	 */
+	char buf[512];
+	size_t s = 0;
+	ssize_t n;
+
+	while (1) {
+		n = kernel_read(output, buf + s, sizeof(buf) - s, NULL);
+		if (n <= 0)
+			return n;
+		s = kunit_uapi_printk_subtest_lines(test, buf, s + n);
+	}
+}
+
+static void kunit_uapi_kill_pid(pid_t pid)
+{
+	struct pid *p;
+
+	p = find_get_pid(pid);
+	kill_pid(p, SIGKILL, 1);
+	put_pid(p);
+}
+
+static int kunit_uapi_run_executable_in_mount(struct kunit *test, const char *executable,
+						   struct vfsmount *mnt)
+{
+	struct kunit_uapi_user_mode_thread_ctx ctx = {
+		.setup_done	= COMPLETION_INITIALIZER_ONSTACK(ctx.setup_done),
+		.executable	= executable,
+		.pwd		= {
+			.mnt	= mnt,
+			.dentry	= mnt->mnt_root,
+		},
+	};
+	int forward_err, wait_err, ret;
+	pid_t pid;
+
+	/* If SIGCHLD is ignored do_wait won't populate the status. */
+	kernel_sigaction(SIGCHLD, SIG_DFL);
+	pid = user_mode_thread(kunit_uapi_user_mode_thread_init, &ctx, SIGCHLD);
+	if (pid < 0) {
+		kernel_sigaction(SIGCHLD, SIG_IGN);
+		return pid;
+	}
+
+	wait_for_completion(&ctx.setup_done);
+
+	forward_err = kunit_uapi_forward_to_printk(test, ctx.out);
+	if (forward_err)
+		kunit_uapi_kill_pid(ctx.tgid);
+
+	wait_err = kernel_wait(ctx.tgid, &ret);
+
+	/* Restore default kernel sig handler */
+	kernel_sigaction(SIGCHLD, SIG_IGN);
+
+	if (ctx.exec_err)
+		return ctx.exec_err;
+	if (forward_err)
+		return forward_err;
+	if (wait_err < 0)
+		return wait_err;
+	return ret;
+}
+
+static int kunit_uapi_run_executable(struct kunit *test,
+				     const struct kunit_uapi_blob *executable)
+{
+	const char *exe_name = kbasename(executable->path);
+	struct vfsmount *mnt;
+	int err;
+
+	mnt = kunit_uapi_mount_ramfs();
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	err = kunit_uapi_write_executable(mnt, executable);
+
+	if (!err)
+		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);
+
+	kern_unmount(mnt);
+
+	return err;
+}
+
+void kunit_uapi_run_kselftest(struct kunit *test, const struct kunit_uapi_blob *executable)
+{
+	u8 exit_code, exit_signal;
+	int err;
+
+	err = kunit_uapi_run_executable(test, executable);
+	if (err < 0)
+		KUNIT_FAIL_AND_ABORT(test, "Could not run test executable: %pe\n", ERR_PTR(err));
+
+	exit_code = err >> 8;
+	exit_signal = err & 0xff;
+
+	if (exit_signal)
+		KUNIT_FAIL_AND_ABORT(test, "kselftest exited with signal: %d\n", exit_signal);
+	else if (exit_code == KSFT_PASS)
+		; /* Noop */
+	else if (exit_code == KSFT_FAIL)
+		KUNIT_FAIL_AND_ABORT(test, "kselftest exited with code KSFT_FAIL\n");
+	else if (exit_code == KSFT_XPASS)
+		KUNIT_FAIL_AND_ABORT(test, "kselftest exited with code KSFT_XPASS\n");
+	else if (exit_code == KSFT_XFAIL)
+		; /* Noop */
+	else if (exit_code == KSFT_SKIP)
+		kunit_mark_skipped(test, "kselftest exited with code KSFT_SKIP\n");
+	else
+		KUNIT_FAIL_AND_ABORT(test, "kselftest exited with unknown exit code: %d\n",
+				     exit_code);
+}
+EXPORT_SYMBOL_GPL(kunit_uapi_run_kselftest);
+
+MODULE_DESCRIPTION("KUnit UAPI testing framework");
+MODULE_AUTHOR("Thomas Weißschuh <thomas.weissschuh@linutronix.de");
+MODULE_LICENSE("GPL");

-- 
2.50.0


