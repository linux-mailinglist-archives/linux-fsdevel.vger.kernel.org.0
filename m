Return-Path: <linux-fsdevel+bounces-1872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B47DF9FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10752811C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCC421360;
	Thu,  2 Nov 2023 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="keEIs5at"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498421359
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:34:27 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C5128
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:34:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc75c55f0so19378611cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698950062; x=1699554862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0vqehv1Of/uKbf/NHzSex+avddGRsxzOfkGwHtKkyg=;
        b=keEIs5atyxpQtTi3W81MbqQkrNpfNLwBg0KGH2gI44fi3hXGXBGDegv5+XmEZImGJu
         r1NDUTT8iwz+JGaQLXqmlu1cLBmxv5Rq0zViAp+j/rYeMvTou7vhUCHPK0UTLqmJQo2M
         nwN52bda7Fx2iQZBqR9SSXZHx0/egPzlBqgiRnWJlrnjpXYE7AznFqeEA1GlvIktrDAY
         4TnUfXMMfsX3vEMyerE3EltJYDrrzgOkVcJRw+UQQYSgWTkm03E/1/9cgpRcbka5x7/4
         utQVaGWax8FZUUP/C1fz5jGJl7q55zzLcMowZX4KwXGrPTclfIo4rBsthtVthcMpuF0t
         RriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698950062; x=1699554862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0vqehv1Of/uKbf/NHzSex+avddGRsxzOfkGwHtKkyg=;
        b=qzX2ZesK567p/2155EycpUsT9toUsOw+mwEC0G0xFAg9Xk/ZiZl2hwUJHKBBo5kFiu
         kkdaAXxsxPWfldjwIEqSHtc/OQwbpsln7QXYKcNBjJAiQ6hp9D+JHovhZeO8pkvtj9ZX
         /rCs1KTV2FsaerXegUXbWqqWa4ThsdB4QzM9kKSKTDdnH5kbo/a+pzmkREEiZBpGooJk
         BFBBl9YbFP6X3aLfinyh48DFaqrUIhIOCFmHKwQUzg1DUprYhqllTxy/8dk5eayQ8VAw
         6nqdCW1qeOp/DJvqTQbn/0vONnZrmC1rA+aNqo4K88cqSgqKSrIx/J/XIOVwUZ3A11pN
         yVVg==
X-Gm-Message-State: AOJu0Yxz2SEntIkIvOWn+ZY/+zKH67S6krMgUGMN+WMhh3KLSE+LzTOt
	kAHjHhPwbY5qOO9pzOzolO6l5pv3ZNImOuyZe1eyQw==
X-Google-Smtp-Source: AGHT+IHli5W9pg027z3X7N5yytmKodloxVZvhxda6fBntxwV8IV1XJcayCtmXiUfhXeuIvSC8E1lkCREGDZtsGgqt0g=
X-Received: by 2002:a05:622a:148c:b0:403:a662:a3c1 with SMTP id
 t12-20020a05622a148c00b00403a662a3c1mr489774qtx.29.1698950062459; Thu, 02 Nov
 2023 11:34:22 -0700 (PDT)
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
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
In-Reply-To: <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 14:33:45 -0400
Message-ID: <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Wei Xu <weixugc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
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

> > > I could have sworn that I pointed that out in a previous version and
> > > requested to document that special case in the patch description. :)
> >
> > Sounds, good we will document that parts of per-page may not be part
> > of MemTotal.
>
> But this still doesn't answer how we can use the new PageMetadata
> field to help break down the runtime kernel overhead within MemUsed
> (MemTotal - MemFree).

I am not sure it matters to the end users: they look at PageMetadata
with or without Page Owner, page_table_check, HugeTLB and it shows
exactly how much per-page overhead changed. Where the kernel allocated
that memory is not that important to the end user as long as that
memory became available to them.

In addition, it is still possible to estimate the actual memblock part
of Per-page metadata by looking at /proc/zoneinfo:

Memblock reserved per-page metadata: "present_pages - managed_pages"

If there is something big that we will allocate in that range, we
should probably also export it in some form.

If this field does not fit in /proc/meminfo due to not fully being
part of MemTotal, we could just keep it under nodeN/, as a separate
file, as suggested by Greg.

However, I think it is useful enough to have an easy system wide view
for Per-page metadata.

> > > > are allocated), so what would be the best way to export page metadata
> > > > without redefining MemTotal? Keep the new field in /proc/meminfo but
> > > > be ok that it is not part of MemTotal or do two counters? If we do two
> > > > counters, we will still need to keep one that is a buddy allocator in
> > > > /proc/meminfo and the other one somewhere outside?
> > >
>
> I think the simplest thing to do now is to only report the buddy
> allocations of per-page metadata in meminfo.  The meaning of the new

This will cause PageMetadata to be 0 on 99% of the systems, and
essentially become useless to the vast majority of users.

