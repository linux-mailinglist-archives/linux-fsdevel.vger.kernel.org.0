Return-Path: <linux-fsdevel+bounces-206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B67C7935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330D11C21101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7B3FB1A;
	Thu, 12 Oct 2023 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZa6+yvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BD3B28A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:02:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13DC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697148118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jO+V0kCCN2H4fTh8SDF52Bqu9Ca+4ziotGTsqK4FPs0=;
	b=FZa6+yvd8lPAiY8/U++FYBnR3zhISHTB0qLZx6rFRc0d66TwgQ1y2Gm9m46GsSDuinhcd7
	wCuotVdhUBRieHQ6ehVhaZCvRz368Su8KDaR47c8gFMAhZlT45i6YTBbJvJ1tbo7HPD1j+
	3wx2iG1nCRGMwRDeFlXsNcNu6zsAMlE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Ti4S2pVnOmmbshrhn1DT3g-1; Thu, 12 Oct 2023 18:01:41 -0400
X-MC-Unique: Ti4S2pVnOmmbshrhn1DT3g-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae2377058bso292708b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148101; x=1697752901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO+V0kCCN2H4fTh8SDF52Bqu9Ca+4ziotGTsqK4FPs0=;
        b=OQU5FjcbIPY2lX0203G4OlgdfuHZn5EY6T97IPr98t3w+Zeqt36fVzh9XRAC9oXS+T
         jBI1y0fHbEs+mVgW7hFQouXpfpTen4jBTby1KdNKVNSTUGCXGi8CteY3WBDjh2S4T+LS
         IXMRYfNAGMu/okcLF5Lj5Cdh3xiH6ZiT4C4VkCrbru/fRkQoKNy1hprUqTTjbNVE47ae
         Q+HWYed9TMDjayorQJky4fT/JcvCddvyvBewtj+NIGfGn8k+Bimp+9cKslIy4GPj1H9r
         dKw1d4j7YHBwcv03WzRv/xQJgw+9Ok//6CPAzvFVjwSmh+pIaCR190+02Jl7BCGoOSK5
         WzhA==
X-Gm-Message-State: AOJu0Yx0mDMXUvMUtaWjg78s2xLz2XdFw4squxVIf/n6dSJjenhq+FKT
	D7xROg5OcrAt/valTeF8sG2gsPXl2ULMibgV7BaZ7IUylWm07QYJM/L5rOCzW4/laeGne4rBf1h
	zQoyPugcj6lJf0UUc/yi2/cqlUw==
X-Received: by 2002:a05:6808:2087:b0:3b2:9c2f:50e0 with SMTP id s7-20020a056808208700b003b29c2f50e0mr7037845oiw.5.1697148101010;
        Thu, 12 Oct 2023 15:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqOd0z9Rrm05kMUw7f1NwIqG2E5WysntGtAunm/GI19UXZNOiR7r13fJ46GNQ81YF0h/Yjg==
X-Received: by 2002:a05:6808:2087:b0:3b2:9c2f:50e0 with SMTP id s7-20020a056808208700b003b29c2f50e0mr7037819oiw.5.1697148100725;
        Thu, 12 Oct 2023 15:01:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p4-20020ac84604000000b004181234dd1dsm106401qtn.96.2023.10.12.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:01:40 -0700 (PDT)
Date: Thu, 12 Oct 2023 18:01:37 -0400
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
Subject: Re: [PATCH v3 1/3] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
Message-ID: <ZShswW2rkKTwnrV3@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009064230.2952396-2-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 08, 2023 at 11:42:26PM -0700, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> For now, folio_move_anon_rmap() was only used to move a folio to a
> different anon_vma after fork(), whereby the root anon_vma stayed
> unchanged. For that, it was sufficient to hold the folio lock when
> calling folio_move_anon_rmap().
> 
> However, we want to make use of folio_move_anon_rmap() to move folios
> between VMAs that have a different root anon_vma. As folio_referenced()
> performs an RMAP walk without holding the folio lock but only holding the
> anon_vma in read mode, holding the folio lock is insufficient.
> 
> When moving to an anon_vma with a different root anon_vma, we'll have to
> hold both, the folio lock and the anon_vma lock in write mode.
> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
> read-lock the anon_vma, we have to re-check if the mapping was changed
> in the meantime. If that was the case, we have to retry.
> 
> Note that folio_move_anon_rmap() must only be called if the anon page is
> exclusive to a process, and must not be called on KSM folios.
> 
> This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
> the anon_vma lock in write mode, and the mmap_lock in read mode.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/rmap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c1f11c9dbe61..f9ddc50269d2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -542,7 +542,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	struct anon_vma *root_anon_vma;
>  	unsigned long anon_mapping;
>  
> +retry:
>  	rcu_read_lock();
> +retry_under_rcu:
>  	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>  	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>  		goto out;
> @@ -552,6 +554,16 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
>  	root_anon_vma = READ_ONCE(anon_vma->root);
>  	if (down_read_trylock(&root_anon_vma->rwsem)) {
> +		/*
> +		 * folio_move_anon_rmap() might have changed the anon_vma as we
> +		 * might not hold the folio lock here.
> +		 */
> +		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
> +			     anon_mapping)) {
> +			up_read(&root_anon_vma->rwsem);
> +			goto retry_under_rcu;

Is adding this specific label worthwhile?  How about rcu unlock and goto
retry (then it'll also be clear that we won't hold rcu read lock for
unpredictable time)?

> +		}
> +
>  		/*
>  		 * If the folio is still mapped, then this anon_vma is still
>  		 * its anon_vma, and holding the mutex ensures that it will

-- 
Peter Xu


