Return-Path: <linux-fsdevel+bounces-789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF7A7D02D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 21:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF3A1C20F73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234A3CD1C;
	Thu, 19 Oct 2023 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWruexAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FB2EAFF
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 19:53:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55750E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697745185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsesIdim+wPTdU/RUNRWHqvYIZjYuIVW1UPJdK5PEjw=;
	b=ZWruexABPn1xnioa8tXDoYsxb+yBu8lLypHsouNe2F81i7AL0+1nNB5dIUTvZlou/rxl+Q
	pSdmg9+FQcpsd3UXD7fOWwnxWNHcWvwuL9yJgPKWgdfFMmh3x6hzNLgeKsYM5SJfYkYcfs
	G2tFFWKXHV0kExhHLT7foOAEhiuwob0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-y76_zfXtNj2iyMtV74BE6A-1; Thu, 19 Oct 2023 15:53:04 -0400
X-MC-Unique: y76_zfXtNj2iyMtV74BE6A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-775842dc945so914585a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745183; x=1698349983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsesIdim+wPTdU/RUNRWHqvYIZjYuIVW1UPJdK5PEjw=;
        b=LAwWn6Dh+SxvgL+aimw+5jQb25Yyn2Ls8z/WurholR5qr+q53PeYz01EFg9rVf2bbu
         FustG+C7Ijg3aYn+XelxQW67Yv3fjVmwYADoG7oplxXhThe5f3cx4dYk9FfNRd+er8aK
         Zx7Ce0eIjzuxvZ02AEsiSLNsk1dqAmvWYsg3A3bxuQwnmY17mVK9O1GQmyRpYimJKnih
         Gy0tMOqW4elbJvniRqA+81Kspnb/nlH2F5N/PciwNaoBprTNzbF2fdaN1IZbvXBdXVY3
         tXH0AYvNY5wjW53Y4QNQCILedKl/mD87qpjL+QjcRy8TjX4b7yaNVXigFo0PS+BU6JYQ
         WsbQ==
X-Gm-Message-State: AOJu0Yz8S5bto3xUNBCs09xPkJaWzqvZ+d+a5cgMG4SeHJV1qs/f1NtE
	i7/ZnBmYJXmqHK4/9n675NbVoGE+ilSngvZU1jyTzLjcTqxr7mCVJRKpYSYnmEb8sT/qTR0P8wW
	Je4gpOlBT2iHF86tJCzRs6vS+sA==
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id bl7-20020a05620a1a8700b0077896e890afmr3341448qkb.5.1697745183634;
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lM3hjpOvbZ85Uma0UlRsQCBxfq3qPNAwSumdJHciqDnKFJqXdgnennQ8IWt6btGoUMNwrQ==
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id bl7-20020a05620a1a8700b0077896e890afmr3341429qkb.5.1697745183351;
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a070200b0077413b342e9sm53812qkc.128.2023.10.19.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:53:01 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTGJHesvkV84c+l6@x1n>
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>

On Thu, Oct 19, 2023 at 05:41:01PM +0200, David Hildenbrand wrote:
> That's not my main point. It can easily become a maintenance burden without
> any real use cases yet that we are willing to support.

That's why I requested a few times that we can discuss the complexity of
cross-mm support already here, and I'm all ears if I missed something on
the "maintenance burden" part..

I started by listing what I think might be different, and we can easily
speedup single-mm with things like "if (ctx->mm != mm)" checks with
e.g. memcg, just like what this patch already did with pgtable depositions.

We keep saying "maintenance burden" but we refuse to discuss what is that..

I'll leave that to Suren and Lokesh to decide.  For me the worst case is
one more flag which might be confusing, which is not the end of the world..
Suren, you may need to work more thoroughly to remove cross-mm implications
if so, just like when renaming REMAP to MOVE.

Thanks,

-- 
Peter Xu


