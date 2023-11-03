Return-Path: <linux-fsdevel+bounces-1928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A337E056F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D732C1C210B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7D1BDCC;
	Fri,  3 Nov 2023 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eo5HRjTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A51A5A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:19:36 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F231B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:19:32 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b566ee5f1dso1330356b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1699024771; x=1699629571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=liLeXSkpooaWOUPaSwHhbbjwtzRLYBJW04zYO+tuOmo=;
        b=eo5HRjTi09AnDl2eHY6t9MzZGSw4diEPGBBKUnl0ywju9f+kwsTvc5k4SL+uqH/JLF
         62UwlNbCk50u1itPbc4NtvUXu7wxZZg8Ao/T3dZ6zcyHd1sJHMpBddk/Iq7UPM5iyDMF
         jzMdxWd5DMCxG7HbR1pnU9vZ4kqQEBN0kbJlF1YtstuWX7CttkF2G4Cu5EksbxQ/HJ7u
         EGf1qOEXNxglfcCK2jIXOSYriUmcGBlF7ykVnYmsLSMXWMZDYCz4sQIz5IFCG5nUxY7l
         3H8dso//uiuq+POHmm74MdW7SJJ2FJ8B0sgprFO8EEQMGezcpPc3UqEA44RaLIxhLsxg
         vGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024771; x=1699629571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liLeXSkpooaWOUPaSwHhbbjwtzRLYBJW04zYO+tuOmo=;
        b=aDGbeitPEAkUDhkCGeKt9wtX9edrWnc+j3ivim9w12+oKVlUMjcKPUxOZsDDssaIpu
         4VCSJxb8Z21xqiANhpE/IOjPK2Rk442koDCxiGcXDwCqt7bNcdshmn6AjzqaimRtRWCT
         j71lRVyX21eV51mPM9aoIcYZuQq9OCK739WUpYMQbVz/+XtCZUabJAP8XIXRjvh+BXOQ
         bonw+o8PrKUbsOjmNM43Z45S6+mOClK74+hFtEupDR563KrBoXChs8ZetTnrqGnW4X0L
         HYfPgE8X5ymAaxTS1yGIZOn931XCbyivhWOVXb+Ptv8ehFw8siDzXkdRjMpKowyimPcJ
         /DrA==
X-Gm-Message-State: AOJu0YySME52LdRriItaxGYbG/xrTiGC+2T3TU/sD5mtTsrQhSvaCqdm
	PUW+TZ1zjCEyCu7ip39LmkmkulVJKkWtU02Q0jja9w==
X-Google-Smtp-Source: AGHT+IHPzOa9iAe+GlV7Tg9JGtkM0A7QgdUDBavOwv9+9DuGS+xM5/s6EzR1YL7nknthcj0uI8QJut9DydQ7Bvbd21w=
X-Received: by 2002:a05:6808:1986:b0:3ab:84f0:b49d with SMTP id
 bj6-20020a056808198600b003ab84f0b49dmr26946069oib.3.1699024770996; Fri, 03
 Nov 2023 08:19:30 -0700 (PDT)
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
 <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
 <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
 <CA+CK2bAv6okHVigjCyDODm5VELi7gtQHOUy9kH5J4jTBpnGPxw@mail.gmail.com> <CAAPL-u-nSLiObCC9Vbtdv1m8-87K-M6FcVcgnruGzRkAAucRTA@mail.gmail.com>
In-Reply-To: <CAAPL-u-nSLiObCC9Vbtdv1m8-87K-M6FcVcgnruGzRkAAucRTA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Nov 2023 11:18:53 -0400
Message-ID: <CA+CK2bAWbnapxXvOwHFXFJNqzKP-_=vroyLaeWBQ=d-ZJ4_R3w@mail.gmail.com>
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

> > Since we are going to use two independent interfaces
> > /proc/meminfo/PageMetadata and nodeN/page_metadata (in a separate file
> > as requested by Greg) How about if in /proc/meminfo we provide only
> > the buddy allocator part, and in nodeN/page_metadata we provide the
> > total per-page overhead in the given node that include memblock
> > reserves, and buddy allocator memory?
>
> What we want is the system-wide breakdown of kernel memory usage. It
> works for this use case with the new PageMetadata counter in
> /proc/meminfo to report only buddy-allocated per-page metadata.

We want to report all PageMetadata, otherwise this effort is going to
be useless for the majority of users.

As you noted, /proc/meminfo allows us to report only the part of
per-page metadata that was allocated by the buddy allocator because of
an existing MemTotal bug that does not include memblock reserves.
However, we do not have this limitation when we create a new
nodeN/page_metadata interface, and we can document that in the sysfs
ABI documentation: sum(nodeN/page_metadata)  contains all per-page
metadata and is superset of /proc/meminfo.

The only question is how to name PageMetadata in the /proc/meminfo
appropriately, so users can understand that not all page metadata is
included? (of course we will also document that only the MemTotal part
of page metadata is reported in /proc/meminfo)

Pasha

