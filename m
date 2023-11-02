Return-Path: <linux-fsdevel+bounces-1864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C157DF86E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AC91C2040F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F81DFCE;
	Thu,  2 Nov 2023 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FWvTot97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9801DFC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 17:12:21 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC301133
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:12:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cc535cd5cso6254971cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698945132; x=1699549932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hH8SjbUIXGq+UF4UxExRqQ+IVCN5t4ykfPIyUiPH38=;
        b=FWvTot97iNaUk34pLKY6RcPdDB6uB+6Nkxu/1gNnBoQMYWZhraEWEno08JMoD+icya
         /4sa8SzCHvQSVHuPDCv1gYrwugQh4kj1g6dkDloI2TLJFjvRWdXwtoSi7GKHcVriN6Dh
         zm5qbeTHTxZBfNmXW5ldlq1oHsjcNBXMgVUQSj9JzEXPRzeGOWggi7DYYJ4VlOnRDuXF
         P7kC0rjAZLAa4pmlnwK8hgJHJsXXRLB2NJDB6d8uQm8NcL8SJbGOsyk08OG0ElWfDzWd
         kINNf7HlpxAA2dVoCBf2cjxCM8zXjz2H7/PtWfCYyq9/u/sSeIrrFbqMVOjCE/oB1oDl
         cxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945132; x=1699549932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hH8SjbUIXGq+UF4UxExRqQ+IVCN5t4ykfPIyUiPH38=;
        b=r5bb1fJ5UEgUnWxhNtV8jX/b6Fl2qSpFOrSsSN5V5YQSY1MDZwO5UgfCXqu5x15I3B
         s3GKDWYXrd/FA9PFLmHFXgQzcC0eMhihvFf4+iTK//rfcG2hom7sFlnSRoziqhAZPduJ
         Vq1Qe/ZqskBTEaknWQ13fyMFgdI/IySZcwk2J2TCuoYUZGY/aauJaqzR0QPRqMsJfNFd
         FQc0gRJWatJtY8DjqVyKtUGk1kHotTPrC1z79TA+hyhUbY6n1WzYhm9HN7e8BKC96eZS
         VgGC9D1WlM/NVVHkyGtmpzzbp/cglhUPzIAS9ituXYJaVK9yA2FUVud4QJYrk75qDu8B
         yp6w==
X-Gm-Message-State: AOJu0YybwnPrXOyrVa3fBamOWtFjj9XUAcxuYmBa0b/mizyfGM4Dfs13
	vhSRnI0+GaBVWpzaX/4zxaUSrwVAaRdavlTfwK7QTg==
X-Google-Smtp-Source: AGHT+IHAJDw6t6f/1p5DCXhVNF5ZYBOAfpGF1Lzb87c+hYmXwYQhEflST5W0X8DLq3sBT2hMJLQQMPPBAaeVNc99U4k=
X-Received: by 2002:ac8:5bc6:0:b0:41e:2db3:a066 with SMTP id
 b6-20020ac85bc6000000b0041e2db3a066mr23182516qtb.45.1698945131763; Thu, 02
 Nov 2023 10:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com>
In-Reply-To: <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 13:11:34 -0400
Message-ID: <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: David Hildenbrand <david@redhat.com>
Cc: Wei Xu <weixugc@google.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

> > Wei, noticed that all other fields in /proc/meminfo are part of
> > MemTotal, but this new field may be not (depending where struct pages
>
> I could have sworn that I pointed that out in a previous version and
> requested to document that special case in the patch description. :)

Sounds, good we will document that parts of per-page may not be part
of MemTotal.

> > are allocated), so what would be the best way to export page metadata
> > without redefining MemTotal? Keep the new field in /proc/meminfo but
> > be ok that it is not part of MemTotal or do two counters? If we do two
> > counters, we will still need to keep one that is a buddy allocator in
> > /proc/meminfo and the other one somewhere outside?
>
> IMHO, we should just leave MemTotal alone ("memory managed by the buddy
> that could actually mostly get freed up and reused -- although that's
> not completely true") and have a new counter that includes any system
> memory (MemSystem? but as we learned, as separate files), including most
> memblock allocations/reservations as well (metadata, early pagetables,
> initrd, kernel, ...).
>
> The you would actually know how much memory the system is using
> (exclusing things like crashmem, mem=, ...).
>
> That part is tricky, though -- I recall there are memblock reservations
> that are similar to the crashkernel -- which is why the current state is
> to account memory when it's handed to the buddy under MemTotal -- which
> is straight forward and simply.

It may be simplified if we define MemSystem as all the usable memory
provided by firmware to Linux kernel.
For BIOS it would be the "usable" ranges in the original e820 memory
list before it's been modified by the kernel based on the parameters.

For device-tree architectures, it would be the memory binding provided
by the original device tree from the firmware.

Pasha

