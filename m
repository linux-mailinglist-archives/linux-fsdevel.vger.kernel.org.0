Return-Path: <linux-fsdevel+bounces-22949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591DB923FCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1393928993C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5831B5818;
	Tue,  2 Jul 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dkYKV11w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0A25601;
	Tue,  2 Jul 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928898; cv=none; b=is0nVpGMNIpbApyLvuY4TjVSylPbUqjyTJb2e5x7W+rLCdAOTAlmaSScv3fJB+h7sZO6QH/gOCt/2meDenBvXlwBkBhrQTPmTcvFPIPikR1lmnnjJ1u0X2eSZUfZVwhL9SESBQvxgD+TaNodMJVFUTTCbRxq2fVlmEIAahrFLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928898; c=relaxed/simple;
	bh=7MaRnJNNbK0yFj8reqUPokn1/QUzs447GBRZjWZumRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3fxK0IYuSWou+gZNyi0doQuDjivdmSXTKtcOH+JWdaJu72s0wYTpcDDn167bn97HK/nc0ZbIHJOJ0JZFfCayp3vootXRqFxpGLNH8Hr3Lw3QeEEpHvmEh1G1r9YrV34anZx/0NfUZBxB57zLbdlOhssNdxSArkrd77yMPhnH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dkYKV11w; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WD4MX5qJlz9scM;
	Tue,  2 Jul 2024 16:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719928888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6W5uuHM9ZW/rEky4ztQshWxBTdgHKyHpuUWE6Z27TI=;
	b=dkYKV11weiLwFZR7c/DrT5d2a6fAJRM81tYaaNbCabxi3EXwnG32NzShMiXaGpk8PFHZ7j
	1A+r2PDhFZKos+HXcuniuhlfbSi74LCBKFvW6a96siJGjAhy5jBd3D6XvqD7Tv0C8itl2c
	gD2P6mYzM7UoL5AhZ0uaMf0Itvldd/aFsUPi74ytaOuyzTfakrF6S6EYeKK7FH3o5Xlh9n
	7SginUHFUNydqIR79xCnQr69PFDY38TKf42c+XaAv+MWyf3YTOPmY13kH13mvBChvBWBVX
	L4f5JbCaoF5xoYAjmpTuXhlsMtZptSkOOYHN28ZAJgZTwE4Jk81+EsFj1jx4bw==
Date: Tue, 2 Jul 2024 14:01:23 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240702140123.emt2gz5kbigth2en@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
 <20240702120250.GA17373@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702120250.GA17373@lst.de>

> > > A WARN_ON without actually erroring out here is highly dangerous. 
> > 
> > I agree but I think we decided that we are safe with 64k for now as fs 
> > that uses iomap will not have a block size > 64k. 
> > 
> > But this function needs some changes when we decide to go beyond 64k
> > by returning error instead of not returning anything. 
> > Until then WARN_ON_ONCE would be a good stop gap for people developing
> > the feature to go beyond 64k block size[1]. 
> 
> Sure, but please make it return an error and return that instead of
> just warning and going beyond the allocated page.

Does this make sense?

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 61d09d2364f7..14be34703588 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,16 +240,19 @@ void iomap_dio_bio_end_io(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
-static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
                loff_t pos, unsigned len)
 {
        struct inode *inode = file_inode(dio->iocb->ki_filp);
        struct bio *bio;
 
+       if (!len)
+               return 0;
        /*
         * Max block size supported is 64k
         */
-       WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
+       if (len > ZERO_PAGE_64K_SIZE)
+               return -EINVAL;
 
        bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
@@ -260,6 +263,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 
        __bio_add_page(bio, zero_page_64k, len, 0);
        iomap_dio_submit_bio(iter, dio, bio, pos);
+       return 0;
 }
 
 /*
@@ -368,8 +372,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
        if (need_zeroout) {
                /* zero out from the start of the block to the write offset */
                pad = pos & (fs_block_size - 1);
-               if (pad)
-                       iomap_dio_zero(iter, dio, pos - pad, pad);
+
+               ret = iomap_dio_zero(iter, dio, pos - pad, pad);
+               if (ret)
+                       goto out;
        }
 
        /*
@@ -443,7 +449,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
                /* zero out from the end of the write to the end of the block */
                pad = pos & (fs_block_size - 1);
                if (pad)
-                       iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
+                       ret = iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
        }
 out:
        /* Undo iter limitation to current extent */

--
Pankaj

