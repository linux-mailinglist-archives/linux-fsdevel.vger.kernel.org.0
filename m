Return-Path: <linux-fsdevel+bounces-72976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF9D06D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D981D3040211
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC512F3C10;
	Fri,  9 Jan 2026 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1tk5u44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC62F99B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925049; cv=none; b=fQmO3qtSkcNOW8zsctjCxJ+BZaPupthIOUqr3aGKZa3um447aF/BFm9Fsv4O6PXI2idny/Hufeq/dnWuISGG7Ca2pHTWyGct6mQH5T5RijzxpVKxAxcxMel3MeZb54xJe7hDdCqfMzRTFfff/QzfXxVSr2TyH7s1qIuFDaItSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925049; c=relaxed/simple;
	bh=9uOQuUF5u+fGu0zEOSX42+5A9cqnhje8ckhUy9/3BZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ585Y2szdmcwcSoZ5UarzRsBEzRAP04AIllpqJyDEdYGlCu8jw0ABmzv4pgtF9ol9+yipA6rHj3XPvHhkjkPkZXshuIcQ808DeiCwqfmsgi9rNuRHvdjIPYpM7X9uDdF51SCW5ImlMzGfrzrMuLczzleNoncP4QzgCxOYk4WHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1tk5u44; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so2022159b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 18:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767925044; x=1768529844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwRw5BMh44S+CRA0S+aM2X056BQ3MKgakAszDLhEDMA=;
        b=c1tk5u44LF+WNwrYm+htTOnoRHMBrJri3gaW3avw5X/NK8Cq7gjU3YX9hj9frGNao4
         Jk9IWyA9p63y6WVAp0dDwjTKrJ9tekE3fYRbnhnfWRRi4o/Nk2BMprG5JEz+rWw5uAmI
         jdVOYxwU0cm4wQ4rKQpJDd5fQV+X1b/93M3xcd/gVnwg+K8TFfFWynwtfklK/5WHdYfQ
         9LrhY/p/GQ5DPyJfGAIuPwnoL0RTwS8s4nazlGwU+OUu8OEclr86m3jzdQJSV8UYWUMm
         Qizvada/ZrDGiSXfTfUXOozDFU0GNmtzKo2YICpe7psFBj4sa5amxphp54bSRhdbs5wX
         krGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767925044; x=1768529844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwRw5BMh44S+CRA0S+aM2X056BQ3MKgakAszDLhEDMA=;
        b=UWQcu+NRbm+YkWAdwQ0vnI/BrkcLwsUIItWi8+nc5Rz7DdCO0uhvTaCVnabQ0YQHO8
         cyRT2zldvAgHFltTnZuAh/wruPaHAGHZZjnw3JZD6Yf+RcFz8a11byD91vaPX2fKviVR
         gP8ySoFfWOO4kmmbCT23k/7D141eWnEO2LQxyMWKIl21eiK2DnZ8mvJhhexob3LFoCtv
         2RuAE5NNjIIw1glqnXMQI3pmUYokUfn1dOzlEQrFq68utnufIt8b8fDh46qcQKgCph2e
         GB9WirPabDXfJnj277BhqBNBaumqIR9IiL4A5EXEpz83VGivSqEiyPgH0tfZwjj8leB6
         ekqw==
X-Forwarded-Encrypted: i=1; AJvYcCUKeKnAg094z9x2pkaqI3NEon3jDQJx1NYw1FQRv+u4SiXa2vtMSpzOGtGcUi7IjAgKvpyUcnDFjsHZEZx0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dKGIjtxueKGynEGFhFVyG615FxWlgyMRwlJYfoMrye56CeKY
	Z6qE82YfAgDaT5EZDsM0qlm1fhzhU2Cpu/V13exeY3dUYhARZJWlEeAc
X-Gm-Gg: AY/fxX6mgm2YbZnFOtBxCZLiy3Q9gNZ3rJbGeBd3qyurO5vLo1c1QGJ2f+eRKDIECbE
	haJ/CVU6YI/HrWM6OLnNMhvZm4yiHKdOidKqZVaWlIBpHJ4H9RlsQdHCzxe+1xZYBiXYibFxcuO
	d1MIr0PN0TxWaldycV05ddAHPKALmHX2J+RzXa3kKzjVwiHaHQP5jzYggd8yPHbsSuO5wq4+TSf
	/fcniP6fMPJurzO8FuBocBV6Z89uMe1e/Udl/DnVKmiL0GkuTsTAJiexe306tjq1DRVT8FX6A5M
	BU6y1dxsxbsKjdmfRVdewdm6sRQYAL/FacGbBujy8+mWtWrBKr5IcA7YsG3/0CMQ7XnmV84IlXJ
	743jdGScbM8lm+cxkK6asGfbs2YGVmL/jOr+9QXwWnpJ4lM1/JOnnN+2OLfsdacRDGwxpvj7igM
	UddhM=
X-Google-Smtp-Source: AGHT+IGy2Z6iLGjL3DNp/CTf0kZT8VLqMc/3PkmnlEsgK70K/KkuQcvlpg+/MgjiWVU0E9PF5h/8+A==
X-Received: by 2002:a05:6a20:244a:b0:35b:b97f:7bd2 with SMTP id adf61e73a8af0-3898f8f5711mr7503947637.10.1767925044125;
        Thu, 08 Jan 2026 18:17:24 -0800 (PST)
Received: from localhost ([2a12:a304:100::205b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28ebe4sm9133374a12.4.2026.01.08.18.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 18:17:23 -0800 (PST)
Date: Fri, 9 Jan 2026 10:17:19 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] Fix an AB-BA deadlock in hugetlbfs_punch_hole()
 involving page migration.
Message-ID: <aWBlFhsivdK1rLTu@ndev>
References: <20260108123957.1123502-1-wangjinchao600@gmail.com>
 <20260108123957.1123502-2-wangjinchao600@gmail.com>
 <aV-6j97kTobFdYwE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-6j97kTobFdYwE@casper.infradead.org>

On Thu, Jan 08, 2026 at 02:09:19PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 08, 2026 at 08:39:25PM +0800, Jinchao Wang wrote:
> > The deadlock occurs due to the following lock ordering:
> > 
> > Task A (punch_hole):             Task B (migration):
> > --------------------             -------------------
> > 1. i_mmap_lock_write(mapping)    1. folio_lock(folio)
> > 2. folio_lock(folio)             2. i_mmap_lock_read(mapping)
> >    (blocks waiting for B)           (blocks waiting for A)
> > 
> > Task A is blocked in the punch-hole path:
> >   hugetlbfs_fallocate
> >     hugetlbfs_punch_hole
> >       hugetlbfs_zero_partial_page
> >         filemap_lock_hugetlb_folio
> >           filemap_lock_folio
> >             __filemap_get_folio
> >               folio_lock
> > 
> > Task B is blocked in the migration path:
> >   migrate_pages
> >     migrate_hugetlbs
> >       unmap_and_move_huge_page
> >         remove_migration_ptes
> >           __rmap_walk_file
> >             i_mmap_lock_read
> > 
> > To break this circular dependency, use filemap_lock_folio_nowait() in
> > the punch-hole path. If the folio is already locked, Task A drops the
> > i_mmap_rwsem and retries. This allows Task B to finish its rmap walk
> > and release the folio lock.
> 
> It looks like you didn't read the lock ordering at the top of mm/rmap.c
> carefully enough:
> 
>  * hugetlbfs PageHuge() take locks in this order:
>  *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>  *     vma_lock (hugetlb specific lock for pmd_sharing)
>  *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
>  *         folio_lock
> 
Thanks for the correction, Matthew.

> So page migration is the one taking locks in the wrong order, not
> holepunch.  Maybe something like this instead?
> 
I will test your suggested change and resend the fix.

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5169f9717f60..4688b9e38cd2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1458,6 +1458,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
> +	enum ttu_flags ttu = 0;
>  
>  	if (folio_ref_count(src) == 1) {
>  		/* page was freed from under us. So we are done. */
> @@ -1498,8 +1499,6 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>  		goto put_anon;
>  
>  	if (folio_mapped(src)) {
> -		enum ttu_flags ttu = 0;
> -
>  		if (!folio_test_anon(src)) {
>  			/*
>  			 * In shared mappings, try_to_unmap could potentially
> @@ -1516,16 +1515,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>  
>  		try_to_migrate(src, ttu);
>  		page_was_mapped = 1;
> -
> -		if (ttu & TTU_RMAP_LOCKED)
> -			i_mmap_unlock_write(mapping);
>  	}
>  
>  	if (!folio_mapped(src))
>  		rc = move_to_new_folio(dst, src, mode);
>  
>  	if (page_was_mapped)
> -		remove_migration_ptes(src, !rc ? dst : src, 0);
> +		remove_migration_ptes(src, !rc ? dst : src,
> +				ttu ? RMP_LOCKED : 0);
> +
> +	if (ttu & TTU_RMAP_LOCKED)
> +		i_mmap_unlock_write(mapping);
>  
>  unlock_put_anon:
>  	folio_unlock(dst);

