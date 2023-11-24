Return-Path: <linux-fsdevel+bounces-3674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84337F7773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E29F1F20F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3507F2E82E;
	Fri, 24 Nov 2023 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjYhRRjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0919A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700839015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qu5XgvxXAyH+ZZ5B41lPzFlUvRTTIlHyTD7FWxrfkec=;
	b=YjYhRRjMOWR92Uo3+TqCKW2HWc1xSAUwjzOecxAJabQ1blPCKTeef6bm+wsFsrqxyPXpq0
	mZ9ut62hKhZvJUphXizDPs9vTOBFspxnF9e+yP4ucl6aW7ftcsydgqA4P2eedLos++eMy8
	P1Op/yjAODmQ8i0ElHqEMOk8ZF5XjKE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-nInPQSS3Oz6aaWLlmYosJA-1; Fri, 24 Nov 2023 10:16:54 -0500
X-MC-Unique: nInPQSS3Oz6aaWLlmYosJA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77d7daa3d77so8198485a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839014; x=1701443814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qu5XgvxXAyH+ZZ5B41lPzFlUvRTTIlHyTD7FWxrfkec=;
        b=GLsj16a+Ih7Ij/MCOqoV3xfH0KZWgrnwXUvFamg7R39p52Jgb6haE1ZcnUMb/GbjPE
         fZDvzIiUuiNpUwzRVAvk/epx70kaXT2nMXrEAkr7zxuoo1gvu4NRNN7CFn2RxShzkEvw
         eqUB7Vx1uXM3/K7+9DJB/z78Jm/+MbOWkNx5yFQgFo8ym+pSuVHSbC4nTt+syBrvtHOA
         MyxO0v7fn4EUD1P48WSBRjz8wpiXwHaw3NHDPhIeY+AMal2hqA2XhjlwSlFuj7StyHmB
         IsbZdz3TFfIPvb/+jgMJ1/vhLlMT6Oc73w5jJi8Z8JWXRjKMjdi5Q39TtJV1TcP1SFhS
         aGbA==
X-Gm-Message-State: AOJu0Yya8Zxrh++O8ddRLYQ8HTo+HHu+XqSgn26l9LijM5ncAw3PiqTZ
	YC0JMUQLmooWQAW5M531exf+2gdafaluPANdIxzswovR2J1bU/Em8xyV4Z03Ucv0qKr0tS2sWrg
	msXJqjGb8MnmX3fYdKJaKyAYydA==
X-Received: by 2002:a05:620a:294b:b0:77d:6a8f:abe with SMTP id n11-20020a05620a294b00b0077d6a8f0abemr3730030qkp.2.1700839014238;
        Fri, 24 Nov 2023 07:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiV7RVK5n3/J6Z2BUdBRcsJkNG7QL8NPXj8wfk67EQSwKUHdH0oqC8FQJ6z1t7hbeF9gdeaA==
X-Received: by 2002:a05:620a:294b:b0:77d:6a8f:abe with SMTP id n11-20020a05620a294b00b0077d6a8f0abemr3729999qkp.2.1700839013922;
        Fri, 24 Nov 2023 07:16:53 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077d71262d38sm1283844qkg.60.2023.11.24.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:16:53 -0800 (PST)
Date: Fri, 24 Nov 2023 10:16:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
Message-ID: <ZWC-YwFlifVFsUOa@x1n>
References: <20231123223929.1059375-1-peterx@redhat.com>
 <de256121-f613-42d3-b267-9cd9fbfc8946@infradead.org>
 <7830CCC4-B1E4-4CCD-B96B-61744FAF2C79@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7830CCC4-B1E4-4CCD-B96B-61744FAF2C79@linux.dev>

On Fri, Nov 24, 2023 at 10:37:06AM +0800, Muchun Song wrote:
> >> +if HUGETLBFS
> >> config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> >> bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
> >> default n
> >> @@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> >>  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
> > 
> > Is this small 'v'            ^ a typo?
> 
> Yes. Thanks for pointing it out. Although it is not related to this
> patch, but it will be nice for me to carry this tiny typo fix. Hi,
> Peter, would you like help me do this?

Sure, this patch is indeed more or less moving that around; I can touch
that up.  I'll resend.

Thanks,

-- 
Peter Xu


