Return-Path: <linux-fsdevel+bounces-7583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020F827DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 05:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA58B2319E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00237A94A;
	Tue,  9 Jan 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0iXRusis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EB9444
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cedfc32250so907749a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 20:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704775662; x=1705380462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9d1a6daFwQBP+JMhfWhKWCeVA+a5Q2tDHFKvp5Evgc=;
        b=0iXRusist83Moo9bwd9PoKkbma1g2L4nRVA2VuJTa5FJTXOTV9UPrOZEMuf1nF+Hhd
         zQOno/vEr9TseqxG+98ltIM6Bxql5tDaH72DOCU8GoSqjncbCyCeuCDJDbCszzisYimr
         QUnC4sTLrvsreVRZDv9L3gLxJ2VCx8b/l3zcjDCMsK0UTGKc+VDG7QyG7EkV9vogQEjQ
         /3sLGfOyMIGmEmHavj2NDUbQLrw0kHfTI3NfJqMVSCtcK4deqfVLEslXnymuk5ykGs/6
         1oXX1kZgA15QVR45t9KAKXyN2ulUwxm/vIKAXi4nkPYrxO7u1kqSL+j5G1Fe3PYNG4gR
         /mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775662; x=1705380462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9d1a6daFwQBP+JMhfWhKWCeVA+a5Q2tDHFKvp5Evgc=;
        b=uALXD1xyzefA4JRSE+1sKpBHoUc1BZPTZhhWKbIFPB6PoZnWuTBpe0YGb5TSzqUNX2
         fRRARxaW7/SRbJAnR2B61NZFFY053c8wDmFlz+jr5H8CsRrRQgDV9ya7n+q5EdkI8WP1
         qOke3IgadqUqYqOSP+WyehBgnMYenGpGHTMTVMVmfCdZs4J1MOpMiTugE80713ULf9EI
         OruuYpP+D52hqJdmQtiOK2GpbZ5KYBceAvRFnPA1zDr4e+Ho8BKHdUdPuI+MvDfI50VR
         e2ReQx/gQYmXlBjvs08O1JZsXs1i3e6fDazXEHjmN667G8N7SVvZFriuclhj5zfcOvHd
         kK3Q==
X-Gm-Message-State: AOJu0YwG8VBH2wzkdAK+8Oo8spLIMYa93ntYm4L7/Y5jPNX0GZLrLYct
	ShDZR91/0cCoucUZ4bD4QQGVHPeJzgocMg==
X-Google-Smtp-Source: AGHT+IEXGWamsR7Yytcu+DAmr0p08k3oitSFEY8voIlETwQIHC6HU43wCVNAvJQUiECekKewVk/oIw==
X-Received: by 2002:a17:90a:4b8e:b0:28c:a5e2:1652 with SMTP id i14-20020a17090a4b8e00b0028ca5e21652mr1845080pjh.12.1704775662422;
        Mon, 08 Jan 2024 20:47:42 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090aa58600b0028cf59fea33sm812372pjq.42.2024.01.08.20.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 20:47:42 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rN41b-007vgb-0Q;
	Tue, 09 Jan 2024 15:47:39 +1100
Date: Tue, 9 Jan 2024 15:47:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZzP6731XwZQnz0o@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>

On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> been done on the MM side; the FS people need to do their part.  It could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
> 
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
> 
> The old way to solve this problem is to specify GFP_NOFS when allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of deadlock.
> 
> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.

So in rebasing the XFS kmem.[ch] removal patchset I've been working
on, there is a clear memory allocator function that we need to be
scoped: __GFP_NOFAIL.

All of the allocations done through the existing XFS kmem.[ch]
interfaces (i.e just about everything) have __GFP_NOFAIL semantics
added except in the explicit cases where we add KM_MAYFAIL to
indicate that the allocation can fail.

The result of this conversion to remove GFP_NOFS is that I'm also
adding *dozens* of __GFP_NOFAIL annotations because we effectively
scope that behaviour.

Hence I think this discussion needs to consider that __GFP_NOFAIL is
also widely used within critical filesystem code that cannot
gracefully recover from memory allocation failures, and that this
would also be useful to scope....

Yeah, I know, mm developers hate __GFP_NOFAIL. We've been using
these semantics NOFAIL in XFS for over 2 decades and the sky hasn't
fallen. So can we get memalloc_nofail_{save,restore}() so that we
can change the default allocation behaviour in certain contexts
(e.g. the same contexts we need NOFS allocations) to be NOFAIL
unless __GFP_RETRY_MAYFAIL or __GFP_NORETRY are set?

We already have memalloc_noreclaim_{save/restore}() for turning off
direct memory reclaim for a given context (i.e. equivalent of
clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
allocation contexts, then we should be going all in and providing
all the contexts that filesystems actually need....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

