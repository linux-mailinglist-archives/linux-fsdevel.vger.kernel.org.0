Return-Path: <linux-fsdevel+bounces-37826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB579F7FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CDB163CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238E226888;
	Thu, 19 Dec 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bfcdyczw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A6225790
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626122; cv=none; b=dZFgGfxGEScD9zJJ5pJ/FtCoNqO21srauWZrhChTbnUi7NiKinlTgykn9ZNzcAlYsLVH/aRUJpvqr+ORsRwgnXuKSEUECBQRva/POPtIiKBn7xbrQwZJb5ehDLv6P9rrpq5weK5XADR4FIdsDbqFx0rqLowH11Fnan1r5uQmZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626122; c=relaxed/simple;
	bh=VY2LhPE7qpJ+JS19W9F427RdYKWAi0StXFYID6wxOL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcDw0gAtl138gKGUGr+EvbwCW69fuz1a1zUaeTTJaPSPLC8ok04GIVIjPllcypA38JJu1J9EZk3g31sT/05USZRQsH/wxGwr8d35jRNt1Yz4QJoYPgt5v6RQ2C0GAsWfOrwnma9mjjBhBtDHJgBBpTD8KPBiRBA+m4gJNdkY3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bfcdyczw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d389258-ad08-4d28-a347-667909b0e190@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734626116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wE4woTuzO5Vn0u1/80asGZMkatsiSe7DQQ29k/o5eNg=;
	b=BfcdyczwxmRq/ZVq/xD0sGno/3/0z0YfutKqZVLTvuhjkJ+4K+V7xdKw/42Wu3cw15dAKX
	kK34zptABIKzyaHLYhwtImTstb7iBJvbWiFny61fyiwoX4c8KOiWfFsc4ku4Bjssgfg+oC
	tuwb06Vgol5AGpZsUJ0vq0UmJ6kjIfU=
Date: Thu, 19 Dec 2024 08:35:09 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
Content-Language: en-GB
To: Juntong Deng <juntong.deng@outlook.com>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508014EBAC89D14D0C3ADA6899042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <AM6PR03MB508014EBAC89D14D0C3ADA6899042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/17/24 3:37 PM, Juntong Deng wrote:
> This patch adds test cases for open-coded style process file iterator.
>
> Test cases related to process files are run in the newly created child
> process. Close all opened files inherited from the parent process in
> the child process to avoid the files opened by the parent process
> affecting the test results.
>
> In addition, this patch adds failure test cases where bpf programs
> cannot pass the verifier due to uninitialized or untrusted
> arguments, etc.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>   .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
>   .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
>   .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
>   4 files changed, 263 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index cd8ecd39c3f3..ce1520c56b55 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -588,4 +588,11 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
>   extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
>   extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
>   
> +struct bpf_iter_task_file;
> +struct bpf_iter_task_file_item;
> +extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task) __ksym;
> +extern struct bpf_iter_task_file_item *
> +bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
> +extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;

All the above declarations should be in vmlinux.h already and I see your below bpf prog already
included vmlinux.h, there is no need to put them here.

> +
>   #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
> index 3cea71f9c500..cfe5b56cc027 100644
> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>   
> +#define _GNU_SOURCE
> +#include <sys/socket.h>
>   #include <sys/syscall.h>
>   #include <sys/mman.h>
>   #include <sys/wait.h>
> @@ -16,11 +18,13 @@
>   #include "iters_num.skel.h"
>   #include "iters_testmod.skel.h"
>   #include "iters_testmod_seq.skel.h"
> +#include "iters_task_file.skel.h"
>   #include "iters_task_vma.skel.h"
>   #include "iters_task.skel.h"
>   #include "iters_css_task.skel.h"
>   #include "iters_css.skel.h"
>   #include "iters_task_failure.skel.h"
> +#include "iters_task_file_failure.skel.h"
>   
>   static void subtest_num_iters(void)
>   {
> @@ -291,6 +295,78 @@ static void subtest_css_iters(void)
>   	iters_css__destroy(skel);
>   }
>   
> +static int task_file_test_process(void *args)
> +{
> +	int pipefd[2], sockfd, err = 0;
> +
> +	/* Create a clean file descriptor table for the test process */
> +	close_range(0, ~0U, 0);
> +
> +	if (pipe(pipefd) < 0)
> +		return 1;
> +
> +	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +	if (sockfd < 0) {
> +		err = 2;
> +		goto cleanup_pipe;
> +	}
> +
> +	usleep(1);
> +
> +	close(sockfd);
> +cleanup_pipe:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +	return err;
> +}
> +
> +static void subtest_task_file_iters(void)
> +{
> +	const int stack_size = 1024 * 1024;
> +	struct iters_task_file *skel;
> +	int child_pid, wstatus, err;
> +	char *stack;
> +
> +	skel = iters_task_file__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
> +		goto cleanup_skel;
> +
> +	skel->bss->parent_pid = getpid();
> +	skel->bss->count = 0;
> +
> +	err = iters_task_file__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup_skel;
> +
> +	stack = (char *)malloc(stack_size);
> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
> +		goto cleanup_attach;
> +
> +	/* Note that there is no CLONE_FILES */
> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, NULL);
> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> +		goto cleanup_stack;
> +
> +	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
> +		goto cleanup_stack;
> +
> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
> +		goto cleanup_stack;
> +
> +	ASSERT_EQ(skel->bss->count, 1, "run_task_file_iters_test_count_err");
> +	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
> +
> +cleanup_stack:
> +	free(stack);
> +cleanup_attach:
> +	iters_task_file__detach(skel);
> +cleanup_skel:
> +	iters_task_file__destroy(skel);
> +}
> +
>   void test_iters(void)
>   {
>   	RUN_TESTS(iters_state_safety);
> @@ -315,5 +391,8 @@ void test_iters(void)
>   		subtest_css_task_iters();
>   	if (test__start_subtest("css"))
>   		subtest_css_iters();
> +	if (test__start_subtest("task_file"))
> +		subtest_task_file_iters();
>   	RUN_TESTS(iters_task_failure);
> +	RUN_TESTS(iters_task_file_failure);
>   }
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file.c b/tools/testing/selftests/bpf/progs/iters_task_file.c
> new file mode 100644
> index 000000000000..47941530e51b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +#include "task_kfunc_common.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int err, parent_pid, count;
> +
> +extern const void pipefifo_fops __ksym;
> +extern const void socket_file_ops __ksym;

There is no need to have 'const' in the above two extern declarations.

> +
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +int test_bpf_iter_task_file(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct bpf_iter_task_file_item *item;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf();
> +	if (task->parent->pid != parent_pid)
> +		return 0;
> +
> +	count++;
> +
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 1;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 0) {
> +		err = 2;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &pipefifo_fops) {
> +		err = 3;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 4;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 1) {
> +		err = 5;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &pipefifo_fops) {
> +		err = 6;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 7;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 2) {
> +		err = 8;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &socket_file_ops) {
> +		err = 9;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item != NULL)
> +		err = 10;
> +cleanup:
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	return 0;
> +}

[...]


