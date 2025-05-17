Return-Path: <linux-fsdevel+bounces-49316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776EDABA78C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 03:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5976D3BBB1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B886323;
	Sat, 17 May 2025 01:27:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307792CA8;
	Sat, 17 May 2025 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747445223; cv=none; b=d01r0fjyC4Ssgyy5XrY4uTkk0RI1U9iaaHwl4GLR4C/kFHkcLvHV9OBEvYvz1IxwOeaifp1xLX5+NkUA3jynzL98/afLN7COIHnv6PIr/DW/bQrddQZfxYAC9X8HahM0/qnSFcPmDVuMNaWr1hwblbIzXRIiZL3VyNKGQVcpKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747445223; c=relaxed/simple;
	bh=+v9noRsWRXZVr1lGd8+wfUEZpOSFPTsR0HueRtd7ZN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEmLQsRUSTeNH/tYBsd1r6/CiETXsjvdNHMjlyvNOsKPLSaarXkJVq0UbLJdJ5HHdhjPG/zGWbdfVCKeNYmTfn+yD3SGmKcSS1DnhMux3h582xilqysOA2flX/SYZTD/H3gOCVCpsKagvxd2WafqugFPLSoMoEEXib9wui5rxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8b2682d61so13525446d6.0;
        Fri, 16 May 2025 18:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747445220; x=1748050020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSaQ0h48+oI+lI7LawDJGa6+0qQQUpD9OvN4IPPR+Ms=;
        b=IaX78qpvSvmGYPb8zwvJWe9z184tjCLB4sGzrF4uyiEPvhQn/2EgJCzBOTONCRI61B
         LJ8RimRZD21beBageObY3AYAQcd5MH7KaXyBAtuXZnyOz55Y6pT67gl/SH/f430XKj2z
         6BEbQ3HfQixsiezPl1PRreDEPJRmsf1ATa0hwBt7WaRHlhH3539LuSkZBEs3tFLuXGiq
         1zjXvpQJPP15Z+NWzrEz0rq7K62Fy5huvqxMQkhaFJafB2efysnbFK85Y0HPoCyJZAYy
         zpMcpPFbqggIiktdjTb6a2qek2f4T2tVm2L85HLaqCZ/y6iWIsB8mU3hjUL4C3gm9JHI
         ApeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNogw2QlrcgTHe30Bn7EO8ofScnHjuSM1p0DXZJvQkW5yWWl5YFbXi8ymr26XbXTYUc0c6a8nDPOLwsaHAcNti@vger.kernel.org, AJvYcCWjR3JubUupLTfiRMunlLfviVXUm4ec1JsGRf5sik+BxXuUYgsFm1Sw7HOleT3xZNr282/1cyRN+kVJy6B3@vger.kernel.org, AJvYcCXifsXs/ZB3rPsbmuh4qEOww1vq0ON9sAUOPG4Xw+IG6HD6xPwJISEvxu/K6N8GQLyIT/DOSea3RH++QPv8@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFWBTsifsEdBFsZKsAOcX0yf76G32wLvnQk8swJsWKmLHpo3H
	/ypiRTzETLzQvLYUL353E7KMn3EXq5fv3bZh3RAYhD9nPEfzKwWkw42B
X-Gm-Gg: ASbGncv5KZuYVvf8gzsdR1x0Ls1OxTMxpr6wnpaPYINxL3xEvFY1MkEz0I2vKLmvJQA
	dzR9nYtxa5002MOuj7/05Nm0IfQgKnpzPq7N8QEucCp21dT6Bf1QjJ1a5vf4jwNYfkcJU0VBD1/
	KkpUz/etcFwyE2j/GRNzPHJYjpgG2O5nuJblQkuVL/si/A5UI3e9jtsCw88R2UaJZCihFlYxYdn
	uDDIGoArajVjAnmkaMbApC+b9WmReSaDaJBAElI4ihJCdMGF2M0KwniMtkOcaPTTqxDRIABH5Uc
	i5p7/em+GU2GNtKmcmKIyMesMXuurtlkejrCasq/8frZ4KzxizwVZtC2YK5Kz+R82hKQf2d1dZF
	0x8ry+8VWRit24AQioNobOw==
X-Google-Smtp-Source: AGHT+IFwqfAXd2EoFKpIarYkKfQ4xBIsc1tEGohr0yxoIwLLVxnV0VgKGMcDjaxRmtfEw5Z/6M8ElA==
X-Received: by 2002:a05:6214:20ab:b0:6f4:f157:40ad with SMTP id 6a1803df08f44-6f8b123bf2dmr83190256d6.2.1747445219772;
        Fri, 16 May 2025 18:26:59 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0979851sm18837216d6.97.2025.05.16.18.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 18:26:59 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentao@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] selftests: Add functional test for the abort file in fusectl
Date: Sat, 17 May 2025 09:23:47 +0800
Message-ID: <20250517012350.10317-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add a simple functional test for the "abort" file
in fusectlfs (/sys/fs/fuse/connections/ID/about).

A simple fuse daemon is added for testing.

Related discussion can be found in the link below.

Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v2:
- Apply changes suggested by Amir Goldstein
  - Check errno 
- Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fusectl/.gitignore  |   3 +
 .../selftests/filesystems/fusectl/Makefile    |  21 +++
 .../selftests/filesystems/fusectl/fuse_mnt.c  | 146 ++++++++++++++++++
 .../filesystems/fusectl/fusectl_test.c        | 116 ++++++++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fusectl/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fusectl/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
 create mode 100644 tools/testing/selftests/filesystems/fusectl/fusectl_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3563492e4eba4..bee6f7d787a33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9740,6 +9740,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse.rst
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
+F:	tools/testing/selftests/filesystems/fusectl
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 80fb84fa3cfcb..a9bfefa961889 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,6 +36,7 @@ TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fusectl
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/fusectl/.gitignore b/tools/testing/selftests/filesystems/fusectl/.gitignore
new file mode 100644
index 0000000000000..3e72e742d08e8
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fuse_mnt
+fusectl_test
diff --git a/tools/testing/selftests/filesystems/fusectl/Makefile b/tools/testing/selftests/filesystems/fusectl/Makefile
new file mode 100644
index 0000000000000..612aad69a93aa
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := fusectl_test
+TEST_GEN_FILES := fuse_mnt
+
+include ../../lib.mk
+
+VAR_CFLAGS := $(shell pkg-config fuse --cflags 2>/dev/null)
+ifeq ($(VAR_CFLAGS),)
+VAR_CFLAGS := -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse
+endif
+
+VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lfuse -pthread
+endif
+
+$(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
+$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
diff --git a/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c b/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
new file mode 100644
index 0000000000000..d12b17f30fadc
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fusectl test file-system
+ * Creates a simple FUSE filesystem with a single read-write file (/test)
+ */
+
+#define FUSE_USE_VERSION 26
+
+#include <fuse.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+static char *content;
+static size_t content_size = 0;
+static const char test_path[] = "/test";
+
+static int test_getattr(const char *path, struct stat *st)
+{
+	memset(st, 0, sizeof(*st));
+
+	if (!strcmp(path, "/")) {
+		st->st_mode = S_IFDIR | 0755;
+		st->st_nlink = 2;
+		return 0;
+	}
+
+	if (!strcmp(path, test_path)) {
+		st->st_mode = S_IFREG | 0664;
+		st->st_nlink = 1;
+		st->st_size = content_size;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int test_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+			off_t offset, struct fuse_file_info *fi)
+{
+	if (strcmp(path, "/"))
+		return -ENOENT;
+
+	filler(buf, ".", NULL, 0);
+	filler(buf, "..", NULL, 0);
+	filler(buf, test_path + 1, NULL, 0);
+
+	return 0;
+}
+
+static int test_open(const char *path, struct fuse_file_info *fi)
+{
+	if (strcmp(path, test_path))
+		return -ENOENT;
+
+	return 0;
+}
+
+static int test_read(const char *path, char *buf, size_t size, off_t offset,
+		     struct fuse_file_info *fi)
+{
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if (!content || content_size == 0)
+		return 0;
+
+	if (offset >= content_size)
+		return 0;
+
+	if (offset + size > content_size)
+		size = content_size - offset;
+
+	memcpy(buf, content + offset, size);
+
+	return size;
+}
+
+static int test_write(const char *path, const char *buf, size_t size,
+		      off_t offset, struct fuse_file_info *fi)
+{
+	size_t new_size;
+
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if(offset > content_size)
+		return -EINVAL;
+
+	new_size = MAX(offset + size, content_size);
+
+	if (new_size > content_size)
+		content = realloc(content, new_size);
+
+	content_size = new_size;
+
+	if (!content)
+		return -ENOMEM;
+
+	memcpy(content + offset, buf, size);
+
+	return size;
+}
+
+static int test_truncate(const char *path, off_t size)
+{
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if (size == 0) {
+		free(content);
+		content = NULL;
+		content_size = 0;
+		return 0;
+	}
+
+	content = realloc(content, size);
+
+	if (!content)
+		return -ENOMEM;
+
+	if (size > content_size)
+		memset(content + content_size, 0, size - content_size);
+
+	content_size = size;
+	return 0;
+}
+
+static struct fuse_operations memfd_ops = {
+	.getattr = test_getattr,
+	.readdir = test_readdir,
+	.open = test_open,
+	.read = test_read,
+	.write = test_write,
+	.truncate = test_truncate,
+};
+
+int main(int argc, char *argv[])
+{
+	return fuse_main(argc, argv, &memfd_ops, NULL);
+}
diff --git a/tools/testing/selftests/filesystems/fusectl/fusectl_test.c b/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
new file mode 100644
index 0000000000000..7050fbe0970e7
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2025 Chen Linxuan <chenlinxuan@uniontech.com>
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <linux/limits.h>
+
+#include "../../kselftest_harness.h"
+
+#define FUSECTL_MOUNTPOINT "/sys/fs/fuse/connections"
+#define FUSE_MOUNTPOINT "/tmp/fuse_mnt_XXXXXX"
+#define FUSE_DEVICE "/dev/fuse"
+#define FUSECTL_TEST_VALUE "1"
+
+FIXTURE(fusectl){
+	char fuse_mountpoint[sizeof(FUSE_MOUNTPOINT)];
+	int connection;
+};
+
+FIXTURE_SETUP(fusectl)
+{
+	const char *fuse_mnt_prog = "./fuse_mnt";
+	int status, pid;
+	struct stat statbuf;
+
+	strcpy(self->fuse_mountpoint, FUSE_MOUNTPOINT);
+
+	if (!mkdtemp(self->fuse_mountpoint))
+		SKIP(return,
+		     "Failed to create FUSE mountpoint %s",
+		     strerror(errno));
+
+	if (access(FUSECTL_MOUNTPOINT, F_OK))
+		SKIP(return,
+		     "FUSE control filesystem not mounted");
+
+	pid = fork();
+	if (pid < 0)
+		SKIP(return,
+		     "Failed to fork FUSE daemon process: %s",
+		     strerror(errno));
+
+	if (pid == 0) {
+		execlp(fuse_mnt_prog, fuse_mnt_prog, self->fuse_mountpoint, NULL);
+		exit(errno);
+	}
+
+	waitpid(pid, &status, 0);
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		SKIP(return,
+		     "Failed to start FUSE daemon %s",
+		     strerror(WEXITSTATUS(status)));
+	}
+
+	if (stat(self->fuse_mountpoint, &statbuf))
+		SKIP(return,
+		     "Failed to stat FUSE mountpoint %s",
+		     strerror(errno));
+
+	self->connection = statbuf.st_dev;
+}
+
+FIXTURE_TEARDOWN(fusectl)
+{
+	umount(self->fuse_mountpoint);
+	rmdir(self->fuse_mountpoint);
+}
+
+TEST_F(fusectl, abort)
+{
+	char path_buf[PATH_MAX];
+	int abort_fd, test_fd, ret;
+
+	sprintf(path_buf, "/sys/fs/fuse/connections/%d/abort", self->connection);
+
+	ASSERT_EQ(0, access(path_buf, F_OK));
+
+	abort_fd = open(path_buf, O_WRONLY);
+	ASSERT_GE(abort_fd, 0);
+
+	sprintf(path_buf, "%s/test", self->fuse_mountpoint);
+
+	test_fd = open(path_buf, O_RDWR);
+	ASSERT_GE(test_fd, 0);
+
+	ret = read(test_fd, path_buf, sizeof(path_buf));
+	ASSERT_EQ(ret, 0);
+
+	ret = write(test_fd, "test", sizeof("test"));
+	ASSERT_EQ(ret, sizeof("test"));
+
+	ret = lseek(test_fd, 0, SEEK_SET);
+	ASSERT_GE(ret, 0);
+
+	ret = write(abort_fd, FUSECTL_TEST_VALUE, sizeof(FUSECTL_TEST_VALUE));
+	ASSERT_GT(ret, 0);
+
+	close(abort_fd);
+
+	ret = read(test_fd, path_buf, sizeof(path_buf));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOTCONN);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


