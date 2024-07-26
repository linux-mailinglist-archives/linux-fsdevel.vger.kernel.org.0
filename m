Return-Path: <linux-fsdevel+bounces-24293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAF93CE81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4150B282260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B9176AC3;
	Fri, 26 Jul 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ankJusx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F476176AB3;
	Fri, 26 Jul 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977591; cv=none; b=PqABZ06BOa/1Ub9w5p4DThn1wfnD1ba9SGQ+ccEa0mLd11iVil1P+Cph5YNWztXSmunRfRMsWEPoKWMGIuRTlHVrc9lIwRXYGTeeYiqQp9a4zFG2xT3Wr4HLQFHM7AC/TAd0p0UTUh+BIKgzcuD+DIgA8NQE3Syq+VKpR8LSBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977591; c=relaxed/simple;
	bh=Lqwb1i+CfA5gQOKZlWuGAXY2HlWpGXs6UaBh25IZNvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3ycOdotuSbihcTaG6+mt9lGNryj8xRmS1a1EjPnzq0F7XKgWCNFwyIcvFnOG7dnXTFMgg6ieI6snlsU6+4Xdqrsq2bGNeV4KTRngu3MiqjygmEOBNY959t+bVwtnFwE1qkfoYuLZDrsur+YV4YdNFrw0qQxhIIkZ3n9UxBukpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ankJusx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A10C32782;
	Fri, 26 Jul 2024 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721977591;
	bh=Lqwb1i+CfA5gQOKZlWuGAXY2HlWpGXs6UaBh25IZNvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ankJusx48S/pXsosZ/6RjBcJsjPytR6GtltxAVReLRwHkwonqju6FYbv/5PL6ZgSo
	 KNnYpod3Gn3YtnVtGy9cqzKt6WhNCT4pY5IskfrnBkrsU7pFq0Gnz8r/m7onkYO6bR
	 7+yt0d+L610eHfLI9BVyCmX8r1HoDIOytOmyxidKWTrQSVa7eBRaqeNTFNUDutByNs
	 m8AFCiQbMUuVaB9yprLlGB1wrOVRD83J73z1m4QAH1lhTwDR6AG9yp/m7zOvSGVpc7
	 jqreQfFvu8/qnQvnMip0nlwfial/zWCrpHanvLIRj6z4jACrkCFQ8CXAba3E3QHbIQ
	 MdpKMNZwkp3kw==
Date: Fri, 26 Jul 2024 09:06:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240726-frequentieren-undenkbar-5b816a3b8876@brauner>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240725234706.655613-3-song@kernel.org>

On Thu, Jul 25, 2024 at 04:47:06PM GMT, Song Liu wrote:
> 1. Rename fs_kfuncs/xattr to fs_kfuncs/file_xattr and add a call of
>    bpf_get_dentry_xattr() to the test.
> 2. Add a new sub test fs_kfuncs/dentry_xattr, which checks 3 levels of
>    parent directories for xattr. This demonstrate the use case that
>    a xattr on a directory is used to tag all files in the directory and
>    sub directories.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      | 61 +++++++++++++++++--
>  .../selftests/bpf/progs/test_dentry_xattr.c   | 46 ++++++++++++++
>  .../selftests/bpf/progs/test_get_xattr.c      | 16 ++++-
>  3 files changed, 117 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_dentry_xattr.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> index 37056ba73847..a960cfbe8907 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> @@ -2,17 +2,19 @@
>  /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>  
>  #include <stdlib.h>
> +#include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/xattr.h>
>  #include <linux/fsverity.h>
>  #include <unistd.h>
>  #include <test_progs.h>
>  #include "test_get_xattr.skel.h"
> +#include "test_dentry_xattr.skel.h"
>  #include "test_fsverity.skel.h"
>  
>  static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
>  
> -static void test_xattr(void)
> +static void test_file_xattr(void)
>  {
>  	struct test_get_xattr *skel = NULL;
>  	int fd = -1, err;
> @@ -50,7 +52,8 @@ static void test_xattr(void)
>  	if (!ASSERT_GE(fd, 0, "open_file"))
>  		goto out;
>  
> -	ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
> +	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
> +	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
>  
>  out:
>  	close(fd);
> @@ -58,6 +61,53 @@ static void test_xattr(void)
>  	remove(testfile);
>  }
>  
> +static void test_directory_xattr(void)
> +{
> +	struct test_dentry_xattr *skel = NULL;
> +	static const char * const paths[] = {
> +		"/tmp/a",
> +		"/tmp/a/b",
> +		"/tmp/a/b/c",
> +	};
> +	const char *file = "/tmp/a/b/c/d";
> +	int i, j, err, fd;
> +
> +	for (i = 0; i < sizeof(paths) / sizeof(char *); i++) {
> +		err = mkdir(paths[i], 0755);
> +		if (!ASSERT_OK(err, "mkdir"))
> +			goto out;
> +		err = setxattr(paths[i], "user.kfunc", "hello", sizeof("hello"), 0);
> +		if (!ASSERT_OK(err, "setxattr")) {
> +			i++;
> +			goto out;
> +		}
> +	}
> +
> +	skel = test_dentry_xattr__open_and_load();
> +
> +	if (!ASSERT_OK_PTR(skel, "test_dentry_xattr__open_and_load"))
> +		goto out;
> +
> +	skel->bss->monitored_pid = getpid();
> +	err = test_dentry_xattr__attach(skel);
> +
> +	if (!ASSERT_OK(err, "test_dentry__xattr__attach"))
> +		goto out;
> +
> +	fd = open(file, O_CREAT | O_RDONLY, 0644);
> +	if (!ASSERT_GE(fd, 0, "open_file"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->bss->number_of_xattr_found, 3, "number_of_xattr_found");
> +	close(fd);
> +out:
> +	test_dentry_xattr__destroy(skel);
> +	remove(file);
> +	for (j = i - 1; j >= 0; j--)
> +		rmdir(paths[j]);
> +}
> +
> +
>  #ifndef SHA256_DIGEST_SIZE
>  #define SHA256_DIGEST_SIZE      32
>  #endif
> @@ -134,8 +184,11 @@ static void test_fsverity(void)
>  
>  void test_fs_kfuncs(void)
>  {
> -	if (test__start_subtest("xattr"))
> -		test_xattr();
> +	if (test__start_subtest("file_xattr"))
> +		test_file_xattr();
> +
> +	if (test__start_subtest("dentry_xattr"))
> +		test_directory_xattr();
>  
>  	if (test__start_subtest("fsverity"))
>  		test_fsverity();
> diff --git a/tools/testing/selftests/bpf/progs/test_dentry_xattr.c b/tools/testing/selftests/bpf/progs/test_dentry_xattr.c
> new file mode 100644
> index 000000000000..d2e378b2e2d5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_dentry_xattr.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_kfuncs.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u32 monitored_pid;
> +__u32 number_of_xattr_found;
> +
> +static const char expected_value[] = "hello";
> +char value[32];
> +
> +SEC("lsm.s/file_open")
> +int BPF_PROG(test_file_open, struct file *f)
> +{
> +	struct bpf_dynptr value_ptr;
> +	struct dentry *dentry, *prev_dentry;
> +	__u32 pid, matches = 0;
> +	int i, ret;
> +
> +	pid = bpf_get_current_pid_tgid() >> 32;
> +	if (pid != monitored_pid)
> +		return 0;
> +
> +	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> +
> +	dentry = bpf_file_dentry(f);
> +
> +	for (i = 0; i < 10; i++) {
> +		ret = bpf_get_dentry_xattr(dentry, "user.kfunc", &value_ptr);
> +		if (ret == sizeof(expected_value) &&
> +		    !bpf_strncmp(value, ret, expected_value))
> +			matches++;
> +
> +		prev_dentry = dentry;
> +		dentry = bpf_dget_parent(prev_dentry);

Why do you need to walk upwards and instead of reading the xattr values
during security_inode_permission()?

> +		bpf_dput(prev_dentry);
> +	}
> +
> +	bpf_dput(dentry);
> +	number_of_xattr_found = matches;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> index 7eb2a4e5a3e5..3b0dc6106ca5 100644
> --- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> @@ -9,7 +9,8 @@
>  char _license[] SEC("license") = "GPL";
>  
>  __u32 monitored_pid;
> -__u32 found_xattr;
> +__u32 found_xattr_from_file;
> +__u32 found_xattr_from_dentry;
>  
>  static const char expected_value[] = "hello";
>  char value[32];
> @@ -18,6 +19,7 @@ SEC("lsm.s/file_open")
>  int BPF_PROG(test_file_open, struct file *f)
>  {
>  	struct bpf_dynptr value_ptr;
> +	struct dentry *dentry;
>  	__u32 pid;
>  	int ret;
>  
> @@ -32,6 +34,16 @@ int BPF_PROG(test_file_open, struct file *f)
>  		return 0;
>  	if (bpf_strncmp(value, ret, expected_value))
>  		return 0;
> -	found_xattr = 1;
> +	found_xattr_from_file = 1;
> +
> +	dentry = bpf_file_dentry(f);
> +	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
> +	bpf_dput(dentry);
> +	if (ret != sizeof(expected_value))
> +		return 0;
> +	if (bpf_strncmp(value, ret, expected_value))
> +		return 0;
> +	found_xattr_from_dentry = 1;
> +
>  	return 0;
>  }
> -- 
> 2.43.0
> 

