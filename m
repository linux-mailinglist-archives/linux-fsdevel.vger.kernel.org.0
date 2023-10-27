Return-Path: <linux-fsdevel+bounces-1456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630E7DA325
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C762D1C2116A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A2405D1;
	Fri, 27 Oct 2023 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0vGQNZSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A63FE5C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:07:39 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2201BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:07:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc30cfec53so1826965ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698444457; x=1699049257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSkhrI7nWDk/cd0VRIx08JbYbMRlcEfhCG/4HMHEAVE=;
        b=0vGQNZSfx3SLQNe3af/Sw4CKFZNYocReUuRjJorWbgMaaMqckwaEYaA4YwskUZePu8
         r2cYGBwgz4WR3aDN8z/Ah14j1xU3EzU41AvPQzWE7PKAy4R2MXErH3H+bb95qxVF1EOk
         jy0CchZDonOmq6bwkr82NuObQEeTcs6qgnjOSil6L5qdU+oz8aMqZmRGQ++oFmgAUwwN
         x7OHSA/jpyiyx/zz2nLRVAR9xeyAR20sxX3N1QRaSNPG8Q7jkCZTp/tA8yyrjGUPAkdX
         uflsA+RPjXQ9Md3SJU/KVBxiovq/pEdsdXjXeGImX4tc3eLpZBUzGbo371Ag1ExB3hat
         ILCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444457; x=1699049257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSkhrI7nWDk/cd0VRIx08JbYbMRlcEfhCG/4HMHEAVE=;
        b=XrmlJ8b/fpDqZ+pwn82MaUpyEKVwvOKu/atvp5riZ3Ng2s1L09fQSf9ycdItfWXUi/
         eAStOBAP/1l4yo0/yAaLjRqoynmE8yFr3lqWTUyhrX0d0Ns0oQOzHMf/E/Kmfs8eLpv0
         I1Pd3Jg0KHFPP17H5C+5is3i8Lk7tUkdL8svGCkSCwqCnVpylpRCgO6xeKrvhRyoW5H7
         aiFT6RZpwO9LcFn17v2vSW6dv8s2HBjnNTLQ7vqO3+n/xM48j7qP0WwbXJz4ddGQ6USH
         hIBQchl/qV0FJ8CN9GQS0M5DlkgGRB1OTEvBwWKreQ00Ujml1jAgDwhFcvSBN6mOXYD4
         hP4Q==
X-Gm-Message-State: AOJu0YwTX4P6qB2v0sbf7BM46Gj/wBrENk6Jd+AC80NyTxvIbMh94Vqt
	BqckITiRIbf+RmRfLL1d9mURKA==
X-Google-Smtp-Source: AGHT+IEIp/M/QisxI0STJIMWbEY6wYIGSWm6KUjg8x+a/LvX7GZIFq4xR4ecaDu0a7xWONNWBYAJrw==
X-Received: by 2002:a17:902:6b07:b0:1ca:8b74:17ff with SMTP id o7-20020a1709026b0700b001ca8b7417ffmr3757646plk.26.1698444456437;
        Fri, 27 Oct 2023 15:07:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902724c00b001b8b2b95068sm2020996pll.204.2023.10.27.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:07:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qwUzM-004n7S-2s;
	Sat, 28 Oct 2023 09:07:32 +1100
Date: Sat, 28 Oct 2023 09:07:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	djwong@kernel.org, mcgrof@kernel.org, hch@lst.de,
	da.gomez@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Message-ID: <ZTw0pBFKaIJs2zFl@dread.disaster.area>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
 <CGME20231026221014eucas1p1b3513d4b9e978232491c3350bc868974@eucas1p1.samsung.com>
 <ZTrjv11yeQPaC6hO@dread.disaster.area>
 <7ad225ac-721f-4c99-8d99-c90992609267@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad225ac-721f-4c99-8d99-c90992609267@samsung.com>

On Fri, Oct 27, 2023 at 09:53:19AM +0200, Pankaj Raghav wrote:
> >> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> >> +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> > 
> > How can that happen here? Max fsb size will be 64kB for the
> > foreseeable future, the bio can hold 256 pages so it will have a
> > minimum size capability of 1MB.
> > 
> 
> I just added it as a pathological check. This will not trigger
> anytime in the near future.

Yeah, exactly my point - it should never happen, it's a fundamental
developer stuff-up bug, not a runtime bug, and so shouldn't be
checked at runtime on every bio....

> > FWIW, as a general observation, I think this is the wrong place to
> > be checking that a filesystem block is larger than can be fit in a
> > single bio. There's going to be problems all over the place if we
> > can't do fsb sized IO in a single bio. i.e. I think this sort of
> > validation should be performed during filesystem mount, not
> > sporadically checked with WARN_ON() checks in random places in the
> > IO path...
> > 
> 
> I agree that it should be a check at a higher level.
> 
> As iomap can be used by any filesystem, the check on FSB limitation
> should be a part iomap right? I don't see any explicit document/comment
> that states the iomap limitations on FSB, etc.

No, it should be part of the filesystem that *uses the bio
infrastrucure*.

We already do that with the page cache - filesystems check at mount
time that the FSB is <= PAGE_SIZE and reject the mount if this check
fails because the page cache simply cannot handle this situation.

This is no different: if we are going to allow FSB > PAGE_SIZE, then
we need to ensure somewhere, even as a BUILD_BUG_ON(), that the max
support FSB the filesystem has is smaller than what we can pack in a
bio.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

