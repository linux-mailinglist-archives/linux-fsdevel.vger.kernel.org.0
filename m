Return-Path: <linux-fsdevel+bounces-791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFD7D0345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 22:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FCF2822D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF314F93;
	Thu, 19 Oct 2023 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtRY3/sN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AE6AB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 20:44:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E57116
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697748253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUmq71SFaV76lBrVYh6+KvqO/bkIhCdS1UYE4ErabTM=;
	b=XtRY3/sNR25OkWQu68+xty7cjbbBaBOEYH4UObjxkkceWo1km4Kj8aLVI5u4b0t0btyNzB
	MfJ8HRMxnXPrH3fFKrs0CvItqnI65J/Cb42aefxoMfQV0odUq95VKUMPnJQ4V80Fk2azJN
	p9cSEzANI1MCA6q+t1ErnNA63ZXtxPg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yEnNa_X9NfCJexOJWGvhnA-1; Thu, 19 Oct 2023 16:43:59 -0400
X-MC-Unique: yEnNa_X9NfCJexOJWGvhnA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-59bbd849b22so146887b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 13:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748239; x=1698353039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUmq71SFaV76lBrVYh6+KvqO/bkIhCdS1UYE4ErabTM=;
        b=TGwV6Wo7Y4AWlfwDsNwG/ULYObdVjUU39I736ySLgGVmUxUXDpfm5UN4jN7fxbqml4
         nBh/zAP45K5evLTD/oW9cd+K2d8RcQDq1bHx1WdfyyrT+Fe5U8R5IuPVbk465pF84yVl
         rjeCUkZYNwTv76ZuVzUY1i6Ovg7d8OEG+CerNw3o+oQpi/k65Pe46jZBXsVq42YGOP+c
         F4vsZonc2pqELxTAtelkRaf8BU6YVQYlEzkF9HzypENEvHe/hi4OVy0pw/s0jbADYh4g
         6iT9M89qYlRWNDbZuCx3wNh5vz8c0hWatg/jcaiTtXiEXmNVK/8Ht2H0OfGJqHh8CKi0
         Zt9A==
X-Gm-Message-State: AOJu0Yxi6WY1E9JikUHGe5oPqBJyFTr1D4rKaeVAoZj15WxaH58JVWOR
	1wYde7nFVXV5cJwlxmtUY3pTAP6uUYHXIMqgI585qte7xI7IihLJzKDWDY5DlLM6O8ejKgdciex
	pB825Q7e0YSxwLMVfiQcircU22w==
X-Received: by 2002:a05:690c:dc9:b0:5a7:b928:9e93 with SMTP id db9-20020a05690c0dc900b005a7b9289e93mr4048151ywb.5.1697748238859;
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh6w+8ZXZ57cfOnUfzaZAee9HlNSSE1wHtnL/nhH2FMh9qNnuc/g7W0l/g4crX2wbdluxT3Q==
X-Received: by 2002:a05:690c:dc9:b0:5a7:b928:9e93 with SMTP id db9-20020a05690c0dc900b005a7b9289e93mr4048123ywb.5.1697748238545;
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05620a318c00b00772662b7804sm82248qkb.100.2023.10.19.13.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:43:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTGVDF5lJPyDF+c1@x1n>
References: <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n>
 <CAJuCfpEVgLtc3iS_huxbr86bNwEix+M4iEqWeQYUbsP6KcxfQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEVgLtc3iS_huxbr86bNwEix+M4iEqWeQYUbsP6KcxfQQ@mail.gmail.com>

On Thu, Oct 19, 2023 at 01:02:39PM -0700, Suren Baghdasaryan wrote:
> Hi Folks,
> Sorry, I'm just catching up on all the comments in this thread after a

Not a problem.

> week-long absence. Will be addressing other questions separately but
> for cross-mm one, I think the best way forward would be for me to
> split this patch into two with the second one adding cross-mm support.
> That will clearly show how much additional code that requires and will
> make it easier for us to decide whether to support it or not.

Sounds good, thanks for that extra work.

> TBH, I don't see the need for an additional flag even if the initial
> version will be merged without cross-mm support. Once it's added the
> manpage can mention that starting with a specific Linux version
> cross-mm is supported, no?

It's about how an user app knows what the kernel supports.

On kernels that only support single-mm, UFFDIO_MOVE should fail if it found
ctx->mm != current->mm.

I think the best way to let the user app be clear of what happened is one
new feature bit if cross-mm will be supported separately.  Or the userapp
will need to rely on a specific failure code of UFFDIO_MOVE, and only until
the 1st MOVE being triggered.  Not as clear, IMHO.

> Also from my quick read, it sounds like we want to prevent movements
> of pinned pages regardless of cross-mm support. Is my understanding
> correct?

I prefer that, but that's only my 2 cents.  I just don't see how remap can
work with pin.  IIUC pin is about coherency of processor view and DMA view.
Then if so the VA is the only identifier of a "page" for an user app
because real pfn is hidden, and remap changes that VA.  So it doesn't make
sense to me to remap a pin in whatever form.

For check pinning: I think I used to mention that it may again require
proper locking over mm.write_protect_seq like fork() paths.  No, when
thinking again I think I was wrong..  write_protect_seq requires mmap write
lock, definitely not good.

We can do what David mentioned before, after ptep_clear_flush() (so pte is
cleared) we recheck page pinning, if pinned fail MOVE and put the page
back.  Note that we can't do that check after installing it into dest
pgtables, because then someone can start to pin it from dest mm already.

Thanks,

-- 
Peter Xu


