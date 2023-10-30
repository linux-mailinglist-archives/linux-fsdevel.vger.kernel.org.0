Return-Path: <linux-fsdevel+bounces-1579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC17DC105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F288281649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC791B264;
	Mon, 30 Oct 2023 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0l0Mzrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855921A73B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:14:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF56D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698696876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asnx9CEzoFGwj1+7ZCvfWv++NHlGBEeGv3uTjA7pOPs=;
	b=Z0l0MzrqdWyjXhoVpURMvgKcG9NXok1IsCDt6N5sC3jxjXplZLBh4ZKcQBIfBp8J31Rkie
	s9wdbB9kN6KLfAk0CG8lTGk/I5f+ACnIf/3KeaoasYBAJYDKNI2Hg3YeytZBRzeFE72pZK
	Fb/s8CDN3uOS9B5W20HGCQJt/pvCtck=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-rgtFEOXuNc63oOWgzfhLVg-1; Mon, 30 Oct 2023 16:14:35 -0400
X-MC-Unique: rgtFEOXuNc63oOWgzfhLVg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-778b5c628f4so107997185a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696875; x=1699301675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asnx9CEzoFGwj1+7ZCvfWv++NHlGBEeGv3uTjA7pOPs=;
        b=oJoiCMlH2mLKkoEAXq2BvbOvhY7waZF4EGehy389UHIuMqM7yU3NjiGcFGfaFX2bww
         c38QhlVZhLQrz/sqxlFUHKwdmfPhs+UpQqkwNk4a7FolGtv7vJ7swgzcEupQqdm28b9i
         /ps5+4HNXJGh9fb/cXhEVyTJe54CGg+wfEqMcn/O7BvUmjjOgg02fRgXVHep10fYYWHF
         3/q+uCLdFzNcwibwYp/V6rWtiFBB7omvE0ry2qoZTCALKslk11YOZ6WalfdeIsx+IjxG
         C7lAWtAiauZprijd6BPnRH3HaJk0/DCRuk4ozc6EwfD1bJERBeJsZ5A0Zf8RxJZHaYRO
         jOvw==
X-Gm-Message-State: AOJu0YzIzUJq1EBmFRco5jnGzCQ8kOgS9mWfaQI47eKRVYRxc6y7PNW+
	jyQetFjuZebSD4fNWbxgj5qlOsQOmXa+PrMcwgGE0EBewaZvlPJBj0w8887OEyqvdNxCzDbu5j7
	Nv6PPmWiVVkfy2PBv/oung1wChQ==
X-Received: by 2002:a05:620a:2711:b0:778:9b9f:ccbb with SMTP id b17-20020a05620a271100b007789b9fccbbmr10786811qkp.0.1698696874712;
        Mon, 30 Oct 2023 13:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm+l4O5xPyFHZN599pI4y/UvLTXRLRuSpjLW8jsASedoJRQ/T+4FgyVXsYFWI6R7KKPLaWdg==
X-Received: by 2002:a05:620a:2711:b0:778:9b9f:ccbb with SMTP id b17-20020a05620a271100b007789b9fccbbmr10786779qkp.0.1698696874331;
        Mon, 30 Oct 2023 13:14:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z22-20020ae9c116000000b007677347e20asm3601178qki.129.2023.10.30.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:14:34 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:14:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZUAOpmVO3LMmge3S@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-6-surenb@google.com>

On Fri, Oct 27, 2023 at 05:38:15PM -0700, Suren Baghdasaryan wrote:
> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> into destination buffer while checking the contents of both after
> the move. After the operation the content of the destination buffer
> should match the original source buffer's content while the source
> buffer should be zeroed. Separate tests are designed for PMD aligned and
> unaligned cases because they utilize different code paths in the kernel.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c     |  24 ++++
>  tools/testing/selftests/mm/uffd-common.h     |   1 +
>  tools/testing/selftests/mm/uffd-unit-tests.c | 141 +++++++++++++++++++
>  3 files changed, 166 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 69e6653ad255..98957fd788d8 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -643,6 +643,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>  	return __copy_page(ufd, offset, false, wp);
>  }
>  
> +int move_page(int ufd, unsigned long offset)
> +{
> +	struct uffdio_move uffdio_move;
> +
> +	if (offset >= nr_pages * page_size)
> +		err("unexpected offset %lu\n", offset);
> +	uffdio_move.dst = (unsigned long) area_dst + offset;
> +	uffdio_move.src = (unsigned long) area_src + offset;
> +	uffdio_move.len = page_size;
> +	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> +	uffdio_move.move = 0;
> +	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> +		/* real retval in uffdio_move.move */
> +		if (uffdio_move.move != -EEXIST)
> +			err("UFFDIO_MOVE error: %"PRId64,
> +			    (int64_t)uffdio_move.move);
> +		wake_range(ufd, uffdio_move.dst, page_size);
> +	} else if (uffdio_move.move != page_size) {
> +		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
> +	} else
> +		return 1;
> +	return 0;
> +}
> +
>  int uffd_open_dev(unsigned int flags)
>  {
>  	int fd, uffd;
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 19930fd6682b..c9526b2cb6b3 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -121,6 +121,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
>  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
>  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
>  int copy_page(int ufd, unsigned long offset, bool wp);
> +int move_page(int ufd, unsigned long offset);
>  void *uffd_poll_thread(void *arg);
>  
>  int uffd_open_dev(unsigned int flags);
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index debc423bdbf4..89e9529ce941 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1064,6 +1064,133 @@ static void uffd_poison_test(uffd_test_args_t *targs)
>  	uffd_test_pass();
>  }
>  
> +static void uffd_move_handle_fault(
> +	struct uffd_msg *msg, struct uffd_args *args)
> +{
> +	unsigned long offset;
> +
> +	if (msg->event != UFFD_EVENT_PAGEFAULT)
> +		err("unexpected msg event %u", msg->event);
> +
> +	if (msg->arg.pagefault.flags &
> +	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
> +		err("unexpected fault type %llu", msg->arg.pagefault.flags);
> +
> +	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
> +	offset &= ~(page_size-1);
> +
> +	if (move_page(uffd, offset))
> +		args->missing_faults++;
> +}
> +
> +static void uffd_move_test(uffd_test_args_t *targs)
> +{
> +	unsigned long nr;
> +	pthread_t uffd_mon;
> +	char c;
> +	unsigned long long count;
> +	struct uffd_args args = { 0 };
> +
> +	/* Prevent source pages from being mapped more than once */
> +	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> +		err("madvise(MADV_DONTFORK) failure");
> +
> +	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +			  true, false, false))
> +		err("register failure");
> +
> +	args.handle_fault = uffd_move_handle_fault;
> +	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> +		err("uffd_poll_thread create");
> +
> +	/*
> +	 * Read each of the pages back using the UFFD-registered mapping. We
> +	 * expect that the first time we touch a page, it will result in a missing
> +	 * fault. uffd_poll_thread will resolve the fault by moving source
> +	 * page to destination.
> +	 */
> +	for (nr = 0; nr < nr_pages; nr++) {
> +		/* Check area_src content */
> +		count = *area_count(area_src, nr);
> +		if (count != count_verify[nr])
> +			err("nr %lu source memory invalid %llu %llu\n",
> +			    nr, count, count_verify[nr]);
> +
> +		/* Faulting into area_dst should move the page */
> +		count = *area_count(area_dst, nr);
> +		if (count != count_verify[nr])
> +			err("nr %lu memory corruption %llu %llu\n",
> +			    nr, count, count_verify[nr]);
> +
> +		/* Re-check area_src content which should be empty */
> +		count = *area_count(area_src, nr);
> +		if (count != 0)
> +			err("nr %lu move failed %llu %llu\n",
> +			    nr, count, count_verify[nr]);
> +	}
> +
> +	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +		err("pipe write");
> +	if (pthread_join(uffd_mon, NULL))
> +		err("join() failed");
> +
> +	if (args.missing_faults != nr_pages || args.minor_faults != 0)
> +		uffd_test_fail("stats check error");
> +	else
> +		uffd_test_pass();
> +}
> +
> +static int prevent_hugepages(void)
> +{
> +	/* This should be done before source area is populated */
> +	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
> +		/* Ignore if CONFIG_TRANSPARENT_HUGEPAGE=n */
> +		if (errno != EINVAL)
> +			return -errno;
> +	}
> +	return 0;
> +}
> +
> +struct uffd_test_case_ops uffd_move_test_case_ops = {
> +	.post_alloc = prevent_hugepages,
> +};
> +
> +#define ALIGN_UP(x, align_to) \
> +	(__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1))
> +
> +static char *orig_area_src, *orig_area_dst;
> +static int pmd_align_areas(void)
> +{
> +	orig_area_src = area_src;
> +	orig_area_dst = area_dst;
> +	area_src = ALIGN_UP(area_src, page_size);
> +	area_dst = ALIGN_UP(area_dst, page_size);
> +	nr_pages--;
> +
> +	return 0;
> +}
> +
> +static void pmd_restore_areas(void)
> +{
> +	area_src = orig_area_src;
> +	area_dst = orig_area_dst;
> +	nr_pages++;
> +}

Please stop using more global variables.. uffd tests are even less
maintainable.

Maybe you can consider add a flag for uffd_test_ctx_init()?  For allocating
either small/thp/default?

> +
> +static int adjust_page_size(void)
> +{
> +	page_size = default_huge_page_size();

This is hacky too, currently page_size is the real page_size backing the
memory.

To make thp test simple, maybe just add one more test to MOVE a large chunk
to replace the thp test, which may contain a few thps?  It also doesn't
need to be fault based.

> +	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
> +
> +	return 0;
> +}
> +
> +struct uffd_test_case_ops uffd_move_pmd_test_case_ops = {
> +	.pre_alloc = adjust_page_size,
> +	.post_alloc = pmd_align_areas,
> +	.pre_release = pmd_restore_areas,
> +};
> +
>  /*
>   * Test the returned uffdio_register.ioctls with different register modes.
>   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
> @@ -1141,6 +1268,20 @@ uffd_test_case_t uffd_tests[] = {
>  		.mem_targets = MEM_ALL,
>  		.uffd_feature_required = 0,
>  	},
> +	{
> +		.name = "move",
> +		.uffd_fn = uffd_move_test,
> +		.mem_targets = MEM_ANON,
> +		.uffd_feature_required = UFFD_FEATURE_MOVE,
> +		.test_case_ops = &uffd_move_test_case_ops,
> +	},
> +	{
> +		.name = "move-pmd",
> +		.uffd_fn = uffd_move_test,
> +		.mem_targets = MEM_ANON,
> +		.uffd_feature_required = UFFD_FEATURE_MOVE,
> +		.test_case_ops = &uffd_move_pmd_test_case_ops,
> +	},
>  	{
>  		.name = "wp-fork",
>  		.uffd_fn = uffd_wp_fork_test,
> -- 
> 2.42.0.820.g83a721a137-goog
> 

-- 
Peter Xu


