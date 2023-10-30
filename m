Return-Path: <linux-fsdevel+bounces-1581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9486B7DC10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E550BB20BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE91B28B;
	Mon, 30 Oct 2023 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRLl0gyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C71B264
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:15:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5393FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698696939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+jRgWu4wq7HEdb6M9xaqIwEKJPe6YuGuA0xc3W8gBcA=;
	b=aRLl0gyhyXpgywC7Wa9xphNnpwMGiTlWd5Gh7QP2GHwoI8uBbzGAiQpogZ0RHBRqDw1Rg1
	aIcrFqstfSlBxadY03snnwmkfg4MjMg8gx2dp/IE8ZzX/xR732n/+z6+wjKkzrVdR+qFz3
	gAn9H79lGaRnYd5LjzZlLhkpX3jH+PM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-TyUhhGugNyik95o_mAAvsg-1; Mon, 30 Oct 2023 16:15:37 -0400
X-MC-Unique: TyUhhGugNyik95o_mAAvsg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cd4448294so6104351cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696937; x=1699301737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jRgWu4wq7HEdb6M9xaqIwEKJPe6YuGuA0xc3W8gBcA=;
        b=pLpXVnKV4VL1Vr4m+J81m7T8E+HjEjejO8euIVmc5xmzP2Jrochenya4HICc0L6wyA
         4ficUVthMj5sL4GsQhSCp/FWE1UwQ7MTxkEMRV23ERohNGhj8/r51doUF4jHprtNwREg
         baSaZiV6G1Ti578KIObTWAfRggrHSNkWbiCoQsERjKSrVZ9Frd4ZqpxQASvog8XgeTuO
         qXuuM4mji4WF8RVWgM6Pxeb3y40iuQfL2LoE7+ilpzyQAxu7PNAaA6GjsoNQ8KSaZDVb
         egRtD8BMo4MgwKgR9c+HiQob3Oe4TKLbfRm96mwy2pUd9gXao3XqiScKAKEtK9WiE1AO
         icvQ==
X-Gm-Message-State: AOJu0YxTHhfr/g24+jjsr0evh1arh7FbZCEvCG37SQ/1e0K1sfSjxrrp
	r0MdRPv45n1U6USPtSdaImlotrGQt/Ly1rEYH4vMiKGWBuFoBz4umLENiurC+0VTsvJnNHvUu4H
	phoJpXcB9Mt/3hiC92kc0IipXbw==
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id g1-20020ac87741000000b0041e49e9fb18mr9885703qtu.0.1698696936575;
        Mon, 30 Oct 2023 13:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs/cy69WMD8RMOzsYnwFgEjabUeRS+JD6QpbuLnR8oduRqMTqj5/ONfwGS8jweyifSfqP8yQ==
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id g1-20020ac87741000000b0041e49e9fb18mr9885676qtu.0.1698696936116;
        Mon, 30 Oct 2023 13:15:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j15-20020a05622a038f00b00410a9dd3d88sm3671836qtx.68.2023.10.30.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:15:35 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:15:13 -0400
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
Subject: Re: [PATCH v4 1/5] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
Message-ID: <ZUAO0RpbbXurwANo@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-2-surenb@google.com>

On Fri, Oct 27, 2023 at 05:38:11PM -0700, Suren Baghdasaryan wrote:
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

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


