Return-Path: <linux-fsdevel+bounces-43515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51535A57A0E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3091893869
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9025D1B422A;
	Sat,  8 Mar 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stjyj3ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB18462
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741435796; cv=none; b=fQgScAOKsK/glaeXYMZGPjzFLe6FBUwo88fZZpKNTnzS4AalO0xazyXPh6yI4KDaY4bWgiospJHmbtfr8553sduH60v/vNrML53arobJZq4fYwT8Q16JscyaBoOq2xaGAQZG7f+XUNUZCsoYtQ1295PzKrXGAG0NjLIIcVJYxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741435796; c=relaxed/simple;
	bh=QsVi6stM8xyqxUX6BWE5DY4YNhSrg9mwMOouP/7xqIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXFFxwB0IrCG+Jz7iEH/l/PtKQLYoFDi38A4r7NQKbyqcSbZSg3rg2Jd2NcKY340OmAQxviDgkDnARzne+siwVFjNE/d0StZGh/fLAXlB36UkIOtKn/PeNn0/6sMmTPvHaQMu+bBMUpT3BejrS2nJaoPPfMRd9aVZlcHxjPc6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stjyj3ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D342C4CEE0;
	Sat,  8 Mar 2025 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741435795;
	bh=QsVi6stM8xyqxUX6BWE5DY4YNhSrg9mwMOouP/7xqIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stjyj3eaiqAwfdlOJSi82vpa0TB27IX0PWP1FYtoT5M+4854JzNTG86CE3MQWYoK8
	 uY3Ob6UXOnPObru/0d0mXGk017hr2WlFshWR2+x8UoyKs3tO6nJQuJEh4aLVi+jPM6
	 zCEpFLFqC7dC/bZAwdSNnFucR5Y+z4yUAh1eLyOMn05WBX0NtF5Sr08S26jxs5h7XU
	 gK3M/g5ianl+vQObvA6LqilreJxrZhgBVqjvspuVkWOd4it1JQDgNrKdC8vDy+pj7U
	 ZPlNnTsCsC/jEULV59Ocd3vKrYjJCyyVFCG9nCF+s7atVa/GTD8h0+ejlzaBUGTVab
	 RtsGmNPdkrHGg==
Date: Sat, 8 Mar 2025 13:09:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] selftests: add tests for mount notification
Message-ID: <20250308-preis-skandal-1631e95a883c@brauner>
References: <20250307204046.322691-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lau2ipzl2zmqyyvs"
Content-Disposition: inline
In-Reply-To: <20250307204046.322691-1-mszeredi@redhat.com>


--lau2ipzl2zmqyyvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 07, 2025 at 09:40:45PM +0100, Miklos Szeredi wrote:
> Provide coverage for all mnt_notify_add() instances.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Thank you! Tests are most excellent!

>  tools/testing/selftests/Makefile              |   1 +
>  .../filesystems/mount-notify/.gitignore       |   2 +
>  .../filesystems/mount-notify/Makefile         |   6 +
>  .../mount-notify/mount-notify_test.c          | 586 ++++++++++++++++++
>  .../filesystems/statmount/statmount.h         |   2 +-
>  5 files changed, 596 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/filesystems/mount-notify/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/mount-notify/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 8daac70c2f9d..2ebaf5e6942e 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -35,6 +35,7 @@ TARGETS += filesystems/epoll
>  TARGETS += filesystems/fat
>  TARGETS += filesystems/overlayfs
>  TARGETS += filesystems/statmount
> +TARGETS += filesystems/mount-notify
>  TARGETS += firmware
>  TARGETS += fpu
>  TARGETS += ftrace
> diff --git a/tools/testing/selftests/filesystems/mount-notify/.gitignore b/tools/testing/selftests/filesystems/mount-notify/.gitignore
> new file mode 100644
> index 000000000000..82a4846cbc4b
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/mount-notify/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/*_test
> diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
> new file mode 100644
> index 000000000000..10be0227b5ae
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> +TEST_GEN_PROGS := mount-notify_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> new file mode 100644
> index 000000000000..d39ff57bf163
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -0,0 +1,586 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +#include <linux/fanotify.h>
> +#include <unistd.h>
> +#include <sys/fanotify.h>
> +#include <sys/syscall.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "../statmount/statmount.h"
> +
> +static char root_mntpoint[] = "/tmp/mount-notify_test_root.XXXXXX";
> +static int orig_root, ns_fd;
> +static uint64_t root_id;
> +
> +static uint64_t get_mnt_id(const char *path)
> +{
> +	struct statx sx;
> +	int ret;
> +
> +	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("retrieving mount ID");
> +
> +	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE))
> +		ksft_exit_fail_msg("no mount ID available\n");
> +
> +	return sx.stx_mnt_id;
> +}
> +
> +static void cleanup_namespace(void)
> +{
> +	int ret;
> +
> +	ret = fchdir(orig_root);
> +	if (ret == -1)
> +		ksft_perror("fchdir to original root");
> +
> +	ret = chroot(".");
> +	if (ret == -1)
> +		ksft_perror("chroot to original root");
> +
> +	umount2(root_mntpoint, MNT_DETACH);
> +	chdir(root_mntpoint);
> +	rmdir("a");
> +	rmdir("b");
> +	chdir("/");
> +	rmdir(root_mntpoint);
> +}
> +
> +static void setup_namespace(void)
> +{
> +	int ret;
> +
> +	ret = unshare(CLONE_NEWNS);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("unsharing mountns and userns");
> +
> +	ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
> +	if (ns_fd == -1)
> +		ksft_exit_fail_perror("opening /proc/self/ns/mnt");
> +
> +	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("making mount tree private");
> +
> +	if (!mkdtemp(root_mntpoint))
> +		ksft_exit_fail_perror("creating temporary directory");
> +
> +	orig_root = open("/", O_PATH);
> +	if (orig_root == -1)
> +		ksft_exit_fail_perror("opening root directory");
> +
> +	atexit(cleanup_namespace);
> +
> +	ret = mount(root_mntpoint, root_mntpoint, NULL, MS_BIND, NULL);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("mounting temp root");
> +
> +	ret = chroot(root_mntpoint);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("chroot to temp root");
> +
> +	ret = chdir("/");
> +	if (ret == -1)
> +		ksft_exit_fail_perror("chdir to root");
> +
> +	ret = mkdir("a", 0700);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("mkdir(a)");
> +
> +	ret = mkdir("b", 0700);
> +	if (ret == -1)
> +		ksft_exit_fail_perror("mkdir(b)");
> +
> +	root_id = get_mnt_id("/");
> +}
> +
> +FIXTURE(fanotify) {
> +	int fan_fd;
> +	char buf[256];
> +	unsigned int rem;
> +	void *next;
> +};
> +
> +#define MAX_MNTS 256
> +#define MAX_PATH 256
> +
> +FIXTURE_SETUP(fanotify)
> +{
> +	uint64_t list[MAX_MNTS];
> +	ssize_t num;
> +	size_t bufsize = sizeof(struct statmount) + MAX_PATH;
> +	struct statmount *buf = alloca(bufsize);
> +	unsigned int i;
> +	int ret;
> +
> +	// Clean up mount tree
> +	ret = mount("", "/", NULL, MS_PRIVATE, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	num = listmount(LSMT_ROOT, 0, 0, list, MAX_MNTS, 0);
> +	ASSERT_GE(num, 1);
> +	ASSERT_LT(num, MAX_MNTS);
> +
> +	for (i = 0; i < num; i++) {
> +		if (list[i] == root_id)
> +			continue;
> +		ret = statmount(list[i], 0, STATMOUNT_MNT_POINT, buf, bufsize, 0);
> +		if (ret == 0 && buf->mask & STATMOUNT_MNT_POINT)
> +			umount2(buf->str + buf->mnt_point, MNT_DETACH);
> +	}
> +	num = listmount(LSMT_ROOT, 0, 0, list, 2, 0);
> +	ASSERT_EQ(num, 1);
> +	ASSERT_EQ(list[0], root_id);
> +
> +	mkdir("/a", 0700);
> +	mkdir("/b", 0700);
> +
> +	self->fan_fd = fanotify_init(FAN_REPORT_MNT, 0);
> +	ASSERT_GE(self->fan_fd, 0);
> +
> +	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS,
> +			    FAN_MNT_ATTACH | FAN_MNT_DETACH, ns_fd, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	self->rem = 0;
> +}
> +
> +FIXTURE_TEARDOWN(fanotify)
> +{
> +	ASSERT_EQ(self->rem, 0);
> +	close(self->fan_fd);
> +}
> +
> +static uint64_t expect_notify(struct __test_metadata *const _metadata,
> +			      FIXTURE_DATA(fanotify) *self,
> +			      uint64_t *mask)
> +{
> +	struct fanotify_event_metadata *meta;
> +	struct fanotify_event_info_mnt *mnt;
> +	unsigned int thislen;
> +
> +	if (!self->rem) {
> +		ssize_t len = read(self->fan_fd, self->buf, sizeof(self->buf));
> +		ASSERT_GT(len, 0);
> +
> +		self->rem = len;
> +		self->next = (void *) self->buf;
> +	}
> +
> +	meta = self->next;
> +	ASSERT_TRUE(FAN_EVENT_OK(meta, self->rem));
> +
> +	thislen = meta->event_len;
> +	self->rem -= thislen;
> +	self->next += thislen;
> +
> +	*mask = meta->mask;
> +	thislen -= sizeof(*meta);
> +
> +	mnt = ((void *) meta) + meta->event_len - thislen;
> +
> +	ASSERT_EQ(thislen, sizeof(*mnt));
> +
> +	return mnt->mnt_id;
> +}
> +
> +static void expect_notify_n(struct __test_metadata *const _metadata,
> +				 FIXTURE_DATA(fanotify) *self,
> +				 unsigned int n, uint64_t mask[], uint64_t mnts[])
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < n; i++)
> +		mnts[i] = expect_notify(_metadata, self, &mask[i]);
> +}
> +
> +static uint64_t expect_notify_mask(struct __test_metadata *const _metadata,
> +				   FIXTURE_DATA(fanotify) *self,
> +				   uint64_t expect_mask)
> +{
> +	uint64_t mntid, mask;
> +
> +	mntid = expect_notify(_metadata, self, &mask);
> +	ASSERT_EQ(expect_mask, mask);
> +
> +	return mntid;
> +}
> +
> +
> +static void expect_notify_mask_n(struct __test_metadata *const _metadata,
> +				 FIXTURE_DATA(fanotify) *self,
> +				 uint64_t mask, unsigned int n, uint64_t mnts[])
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < n; i++)
> +		mnts[i] = expect_notify_mask(_metadata, self, mask);
> +}
> +
> +
> +static void verify_mount_ids(struct __test_metadata *const _metadata,
> +			     const uint64_t list1[], const uint64_t list2[],
> +			     size_t num)
> +{
> +	unsigned int i, j;
> +
> +	// Check that neither list has any duplicates
> +	for (i = 0; i < num; i++) {
> +		for (j = 0; j < num; j++) {
> +			if (i != j) {
> +				ASSERT_NE(list1[i], list1[j]);
> +				ASSERT_NE(list2[i], list2[j]);
> +			}
> +		}
> +	}
> +	// Check that all list1 memebers can be found in list2. Together with
> +	// the above it means that the list1 and list2 represent the same sets.
> +	for (i = 0; i < num; i++) {
> +		for (j = 0; j < num; j++) {
> +			if (list1[i] == list2[j])
> +				break;
> +		}
> +		ASSERT_NE(j, num);
> +	}
> +}
> +
> +static void check_mounted(struct __test_metadata *const _metadata,
> +			  const uint64_t mnts[], size_t num)
> +{
> +	ssize_t ret;
> +	uint64_t *list;
> +
> +	list = malloc((num + 1) * sizeof(list[0]));
> +	ASSERT_NE(list, NULL);
> +
> +	ret = listmount(LSMT_ROOT, 0, 0, list, num + 1, 0);
> +	ASSERT_EQ(ret, num);
> +
> +	verify_mount_ids(_metadata, mnts, list, num);
> +
> +	free(list);
> +}
> +
> +static void setup_mount_tree(struct __test_metadata *const _metadata,
> +			    int log2_num)
> +{
> +	int ret, i;
> +
> +	ret = mount("", "/", NULL, MS_SHARED, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	for (i = 0; i < log2_num; i++) {
> +		ret = mount("/", "/", NULL, MS_BIND, NULL);
> +		ASSERT_EQ(ret, 0);
> +	}
> +}
> +
> +TEST_F(fanotify, bind)
> +{
> +	int ret;
> +	uint64_t mnts[2] = { root_id };
> +
> +	ret = mount("/", "/", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +	ASSERT_NE(mnts[0], mnts[1]);
> +
> +	check_mounted(_metadata, mnts, 2);
> +
> +	// Cleanup
> +	uint64_t detach_id;
> +	ret = umount("/");
> +	ASSERT_EQ(ret, 0);
> +
> +	detach_id = expect_notify_mask(_metadata, self, FAN_MNT_DETACH);
> +	ASSERT_EQ(detach_id, mnts[1]);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +TEST_F(fanotify, move)
> +{
> +	int ret;
> +	uint64_t mnts[2] = { root_id };
> +	uint64_t move_id;
> +
> +	ret = mount("/", "/a", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +	ASSERT_NE(mnts[0], mnts[1]);
> +
> +	check_mounted(_metadata, mnts, 2);
> +
> +	ret = move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	move_id = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +	ASSERT_EQ(move_id, mnts[1]);
> +
> +	// Cleanup
> +	ret = umount("/b");
> +	ASSERT_EQ(ret, 0);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +TEST_F(fanotify, propagate)
> +{
> +	const unsigned int log2_num = 4;
> +	const unsigned int num = (1 << log2_num);
> +	uint64_t mnts[num];
> +
> +	setup_mount_tree(_metadata, log2_num);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, num - 1, mnts + 1);
> +
> +	mnts[0] = root_id;
> +	check_mounted(_metadata, mnts, num);
> +
> +	// Cleanup
> +	int ret;
> +	uint64_t mnts2[num];
> +	ret = umount2("/", MNT_DETACH);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("", "/", NULL, MS_PRIVATE, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts2[0] = root_id;
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, num - 1, mnts2 + 1);
> +	verify_mount_ids(_metadata, mnts, mnts2, num);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +TEST_F(fanotify, fsmount)
> +{
> +	int ret, fs, mnt;
> +	uint64_t mnts[2] = { root_id };
> +
> +	fs = fsopen("tmpfs", 0);
> +	ASSERT_GE(fs, 0);
> +
> +        ret = fsconfig(fs, FSCONFIG_CMD_CREATE, 0, 0, 0);
> +	ASSERT_EQ(ret, 0);
> +
> +        mnt = fsmount(fs, 0, 0);
> +	ASSERT_GE(mnt, 0);
> +
> +        close(fs);
> +
> +	ret = move_mount(mnt, "", AT_FDCWD, "/a", MOVE_MOUNT_F_EMPTY_PATH);
> +	ASSERT_EQ(ret, 0);
> +
> +        close(mnt);
> +
> +	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +	ASSERT_NE(mnts[0], mnts[1]);
> +
> +	check_mounted(_metadata, mnts, 2);
> +
> +	// Cleanup
> +	uint64_t detach_id;
> +	ret = umount("/a");
> +	ASSERT_EQ(ret, 0);
> +
> +	detach_id = expect_notify_mask(_metadata, self, FAN_MNT_DETACH);
> +	ASSERT_EQ(detach_id, mnts[1]);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +TEST_F(fanotify, reparent)
> +{
> +	uint64_t mnts[6] = { root_id };
> +	uint64_t dmnts[3];
> +	uint64_t masks[3];
> +	unsigned int i;
> +	int ret;
> +
> +	// Create setup with a[1] -> b[2] propagation
> +	ret = mount("/", "/a", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("", "/a", NULL, MS_SHARED, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("/a", "/b", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("", "/b", NULL, MS_SLAVE, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 1);
> +
> +	check_mounted(_metadata, mnts, 3);
> +
> +	// Mount on a[3], which is propagated to b[4]
> +	ret = mount("/", "/a", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 3);
> +
> +	check_mounted(_metadata, mnts, 5);
> +
> +	// Mount on b[5], not propagated
> +	ret = mount("/", "/b", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts[5] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +
> +	check_mounted(_metadata, mnts, 6);
> +
> +	// Umount a[3], which is propagated to b[4], but not b[5]
> +	// This will result in b[5] "falling" on b[2]
> +	ret = umount("/a");
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_n(_metadata, self, 3, masks, dmnts);
> +	verify_mount_ids(_metadata, mnts + 3, dmnts, 3);
> +
> +	for (i = 0; i < 3; i++) {
> +		if (dmnts[i] == mnts[5]) {
> +			ASSERT_EQ(masks[i], FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +		} else {
> +			ASSERT_EQ(masks[i], FAN_MNT_DETACH);
> +		}
> +	}
> +
> +	mnts[3] = mnts[5];
> +	check_mounted(_metadata, mnts, 4);
> +
> +	// Cleanup
> +	ret = umount("/b");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = umount("/a");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = umount("/b");
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, 3, dmnts);
> +	verify_mount_ids(_metadata, mnts + 1, dmnts, 3);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +TEST_F(fanotify, rmdir)
> +{
> +	uint64_t mnts[3] = { root_id };
> +	int ret;
> +
> +	ret = mount("/", "/a", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("/", "/a/b", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 1);
> +
> +	check_mounted(_metadata, mnts, 3);
> +
> +	ret = chdir("/a");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fork();
> +	ASSERT_GE(ret, 0);
> +
> +	if (ret == 0) {
> +		chdir("/");
> +		unshare(CLONE_NEWNS);
> +		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> +		umount2("/a", MNT_DETACH);
> +		// This triggers a detach in the other namespace
> +		rmdir("/a");
> +		exit(0);
> +	}
> +	wait(NULL);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, 2, mnts + 1);
> +	check_mounted(_metadata, mnts, 1);
> +
> +	// Cleanup
> +	ret = chdir("/");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mkdir("a", 0700);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_F(fanotify, pivot_root)
> +{
> +	uint64_t mnts[3] = { root_id };
> +	uint64_t mnts2[3];
> +	int ret;
> +
> +	ret = mount("tmpfs", "/a", "tmpfs", 0, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts[2] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +
> +	ret = mkdir("/a/new", 0700);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mkdir("/a/old", 0700);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = mount("/a", "/a/new", NULL, MS_BIND, NULL);
> +	ASSERT_EQ(ret, 0);
> +
> +	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
> +	check_mounted(_metadata, mnts, 3);
> +
> +	ret = syscall(SYS_pivot_root, "/a/new", "/a/new/old");
> +	ASSERT_EQ(ret, 0);
> +
> +	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH | FAN_MNT_DETACH, 2, mnts2);
> +	verify_mount_ids(_metadata, mnts, mnts2, 2);
> +	check_mounted(_metadata, mnts, 3);
> +
> +	// Cleanup
> +	ret = syscall(SYS_pivot_root, "/old", "/old/a/new");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = umount("/a/new");
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = umount("/a");
> +	ASSERT_EQ(ret, 0);
> +
> +	check_mounted(_metadata, mnts, 1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int ret;
> +
> +	ksft_print_header();
> +
> +	if (geteuid())
> +		ksft_exit_skip("mount notify requires root privileges\n");
> +
> +	ret = fanotify_init(FAN_REPORT_MNT, 0);
> +	if (ret == -1) {
> +		if (errno == EINVAL)
> +			ksft_exit_skip("FAN_REPORT_MNT not supported\n");
> +		ksft_exit_fail_perror("fanotify_init(FAN_REPORT_MNT, 0)");
> +	}
> +	close(ret);
> +
> +	setup_namespace();
> +
> +	return test_harness_run(argc, argv);
> +}

Thanks for using the TEST_* framework instead of the old one! It's way
easier to extend and has better behavior! But you don't need a main
function. You can just use:

TEST_HARNESS_MAIN

setup_namespace() can just be called on each FIXTURE_SETUP() invocation
and cleanup_namespace() on each FIXTURE_TEARDOWN(). They will always
start with a clean slate this way.

There's some build errors with missing defines when the kheaders aren't
installed. I don't like making this a test-run prerequisite so I'm
adding defines when FAN_MNT_ATTACH etc aren't defined.

I've fixed that all up. I'm appending the changes I folded in.
Afterwards I get:

user1@localhost:~/data/kernel/linux/tools/testing/selftests/filesystems/mount-notify$ sudo ./mount-notify_test
TAP version 13
1..7
# Starting 7 tests from 1 test cases.
#  RUN           fanotify.bind ...
#            OK  fanotify.bind
ok 1 fanotify.bind
#  RUN           fanotify.move ...
#            OK  fanotify.move
ok 2 fanotify.move
#  RUN           fanotify.propagate ...
#            OK  fanotify.propagate
ok 3 fanotify.propagate
#  RUN           fanotify.fsmount ...
#            OK  fanotify.fsmount
ok 4 fanotify.fsmount
#  RUN           fanotify.reparent ...
#            OK  fanotify.reparent
ok 5 fanotify.reparent
#  RUN           fanotify.rmdir ...
#            OK  fanotify.rmdir
ok 6 fanotify.rmdir
#  RUN           fanotify.pivot_root ...
#            OK  fanotify.pivot_root
ok 7 fanotify.pivot_root
# PASSED: 7 / 7 tests passed.
# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

> diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
> index f4294bab9d73..a7a5289ddae9 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> @@ -25,7 +25,7 @@ static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
>  	return syscall(__NR_statmount, &req, buf, bufsize, flags);
>  }
>  
> -static ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
> +static inline ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
>  			 uint64_t last_mnt_id, uint64_t list[], size_t num,
>  			 unsigned int flags)
>  {
> -- 
> 2.48.1
> 

--lau2ipzl2zmqyyvs
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="folded_changes.diff"

commit d67dff33e14af26f37114d0cd3c846816360f809
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Sat Mar 8 12:47:29 2025 +0100
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Sat Mar 8 13:07:26 2025 +0100

    folded changes
    
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 7fa2e376e516..2f0bd360166d 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -16,11 +16,11 @@
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 
-#ifndef FAN_PRE_ACCESS
-#define FAN_PRE_ACCESS 0x00100000 /* Pre-content access hook */
-#endif
-
 #ifndef FAN_MNT_ATTACH
+struct fanotify_event_info_mnt {
+	struct fanotify_event_info_header hdr;
+	__u64 mnt_id;
+};
 #define FAN_MNT_ATTACH 0x01000000 /* Mount was attached */
 #endif
 
@@ -32,91 +32,64 @@
 #define FAN_REPORT_MNT 0x00004000 /* Report mount events */
 #endif
 
+#ifndef FAN_MARK_MNTNS
+#define FAN_MARK_MNTNS 0x00000110
+#endif
+
 static char root_mntpoint[] = "/tmp/mount-notify_test_root.XXXXXX";
 static int orig_root, ns_fd;
 static uint64_t root_id;
 
-static uint64_t get_mnt_id(const char *path)
+static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
+			   const char *path)
 {
 	struct statx sx;
-	int ret;
-
-	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
-	if (ret == -1)
-		ksft_exit_fail_perror("retrieving mount ID");
-
-	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE))
-		ksft_exit_fail_msg("no mount ID available\n");
 
+	ASSERT_EQ(statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx), 0);
+	ASSERT_TRUE(!!(sx.stx_mask & STATX_MNT_ID_UNIQUE));
 	return sx.stx_mnt_id;
 }
 
-static void cleanup_namespace(void)
+static void cleanup_namespace(struct __test_metadata *const _metadata)
 {
-	int ret;
-
-	ret = fchdir(orig_root);
-	if (ret == -1)
-		ksft_perror("fchdir to original root");
+	ASSERT_EQ(fchdir(orig_root), 0);
 
-	ret = chroot(".");
-	if (ret == -1)
-		ksft_perror("chroot to original root");
+	ASSERT_EQ(chroot("."), 0);
 
-	umount2(root_mntpoint, MNT_DETACH);
-	chdir(root_mntpoint);
-	rmdir("a");
-	rmdir("b");
-	chdir("/");
-	rmdir(root_mntpoint);
+	EXPECT_EQ(umount2(root_mntpoint, MNT_DETACH), 0);
+	EXPECT_EQ(chdir(root_mntpoint), 0);
+	EXPECT_EQ(rmdir("a"), 0);
+	EXPECT_EQ(rmdir("b"), 0);
+	EXPECT_EQ(chdir("/"), 0);
+	EXPECT_EQ(rmdir(root_mntpoint), 0);
 }
 
-static void setup_namespace(void)
+static void setup_namespace(struct __test_metadata *const _metadata)
 {
-	int ret;
-
-	ret = unshare(CLONE_NEWNS);
-	if (ret == -1)
-		ksft_exit_fail_perror("unsharing mountns and userns");
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 
 	ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
-	if (ns_fd == -1)
-		ksft_exit_fail_perror("opening /proc/self/ns/mnt");
+	ASSERT_GE(ns_fd, 0);
 
-	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-	if (ret == -1)
-		ksft_exit_fail_perror("making mount tree private");
+	ASSERT_EQ(mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL), 0);
 
-	if (!mkdtemp(root_mntpoint))
-		ksft_exit_fail_perror("creating temporary directory");
+	ASSERT_NE(mkdtemp(root_mntpoint), NULL);
 
-	orig_root = open("/", O_PATH);
-	if (orig_root == -1)
-		ksft_exit_fail_perror("opening root directory");
+	orig_root = open("/", O_PATH | O_CLOEXEC);
+	ASSERT_GE(orig_root, 0);
 
-	atexit(cleanup_namespace);
+	ASSERT_EQ(mount(root_mntpoint, root_mntpoint, NULL, MS_BIND, NULL), 0);
 
-	ret = mount(root_mntpoint, root_mntpoint, NULL, MS_BIND, NULL);
-	if (ret == -1)
-		ksft_exit_fail_perror("mounting temp root");
+	ASSERT_EQ(chroot(root_mntpoint), 0);
 
-	ret = chroot(root_mntpoint);
-	if (ret == -1)
-		ksft_exit_fail_perror("chroot to temp root");
+	ASSERT_EQ(chdir("/"), 0);
 
-	ret = chdir("/");
-	if (ret == -1)
-		ksft_exit_fail_perror("chdir to root");
+	ASSERT_EQ(mkdir("a", 0700), 0);
 
-	ret = mkdir("a", 0700);
-	if (ret == -1)
-		ksft_exit_fail_perror("mkdir(a)");
-
-	ret = mkdir("b", 0700);
-	if (ret == -1)
-		ksft_exit_fail_perror("mkdir(b)");
+	ASSERT_EQ(mkdir("b", 0700), 0);
 
-	root_id = get_mnt_id("/");
+	root_id = get_mnt_id(_metadata, "/");
+	ASSERT_NE(root_id, 0);
 }
 
 FIXTURE(fanotify) {
@@ -138,6 +111,8 @@ FIXTURE_SETUP(fanotify)
 	unsigned int i;
 	int ret;
 
+	setup_namespace(_metadata);
+
 	// Clean up mount tree
 	ret = mount("", "/", NULL, MS_PRIVATE, NULL);
 	ASSERT_EQ(ret, 0);
@@ -172,6 +147,7 @@ FIXTURE_SETUP(fanotify)
 
 FIXTURE_TEARDOWN(fanotify)
 {
+	cleanup_namespace(_metadata);
 	ASSERT_EQ(self->rem, 0);
 	close(self->fan_fd);
 }
@@ -579,24 +555,4 @@ TEST_F(fanotify, pivot_root)
 	check_mounted(_metadata, mnts, 1);
 }
 
-int main(int argc, char *argv[])
-{
-	int ret;
-
-	ksft_print_header();
-
-	if (geteuid())
-		ksft_exit_skip("mount notify requires root privileges\n");
-
-	ret = fanotify_init(FAN_REPORT_MNT, 0);
-	if (ret == -1) {
-		if (errno == EINVAL)
-			ksft_exit_skip("FAN_REPORT_MNT not supported\n");
-		ksft_exit_fail_perror("fanotify_init(FAN_REPORT_MNT, 0)");
-	}
-	close(ret);
-
-	setup_namespace();
-
-	return test_harness_run(argc, argv);
-}
+TEST_HARNESS_MAIN

--lau2ipzl2zmqyyvs--

