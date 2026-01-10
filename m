Return-Path: <linux-fsdevel+bounces-73135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010FD0D8AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71234301D971
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FB347BBF;
	Sat, 10 Jan 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RLxqTbj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5IL6WtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E5346AE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768059094; cv=none; b=ZS+g4JC9YgmEHp9VGmDsSWZnAQCB/AAEHJlxGjbuD5FLg8OLpiRYRDv04iAUoQG7DVYCTfoHgXz/oX5NooH5jp+XATNzdplYZNhUF+rRJGKDCjKxcELcZUQIDJxgT7CZKZqJ+6L0jt7ZunkqehxksP9d+GOby6X9w+Ugk6L3NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768059094; c=relaxed/simple;
	bh=C269jfdK8QwCwMJ3ueG0LoAawbfi69wy0rUN7wMytXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uBbQ5NCpqczzj+iAYNQ7+h5ASXBfwaA5jU3Qapiqbj9CAPJ0Pub3i1pZQ5Oq2KVt+/RZmgiWyVAF/E8F52Ji0ab+oH67HjekH7J4c1Vv6zjiy6D56HQHyDsTt0i1zDs0qrS/9TANGSJSJVm1DSJQcOPh7h2Jw61P22iu7ieTZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RLxqTbj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5IL6WtD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B58B7A008E;
	Sat, 10 Jan 2026 10:31:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 10 Jan 2026 10:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768059091;
	 x=1768145491; bh=2xnPw8kDbk1FnC17fO636ah57YcMdXKnjMD8FyXDqDU=; b=
	RLxqTbj3JlBtQ5+lW+9o8DdlRmQ/Zqx0C/Tgt+zI02MIv1ZTBhAzDmavRNoy9DLG
	kb4aZsb3+K0iMcTEAnqg/yvFiUFF23v/Zklfgd42oA9LSrm78VUqxtMN9sxvY5by
	9oIoKxG62Iy5uFXt4ul71K/cWcdgYKdJegfni+d3pB0hXbOsKtQz6qJ5RGWWtEuW
	SCg2TAHJpmIGJu96sz/W3Q97J8hOjzT93Y82Gry/vWSU8iMMpAr59fG/cQopSYLn
	owFhBKy/lkhn4CrXst2bEt7Fx0KiljY3+4ozE7mChSkc8Y2s+Y+efN/b5K3K1X02
	IjKgQAD2Mfkg3HL8w/0xog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768059091; x=
	1768145491; bh=2xnPw8kDbk1FnC17fO636ah57YcMdXKnjMD8FyXDqDU=; b=q
	5IL6WtDmfh04neTlaIzT2RxE8oNm7SETDbRxy5JaYBS+ah0y2XuYu4PbkMeYbMCW
	CKYKCa1zwwae1f6EStwlGW3GR20n5dBtz9ZNayEPalgxrzFHXPRkZEMu0Y60QHHH
	RmlFPJJ2teYEiiPpnunKuBT3ZxYYm3jJtmp1iR4ON4ycfeB8s6r5grX4UD3xy4lE
	TdOTLfdQieKwMhr0LRFDaZGZHfBkNeBfiG4UqBR85YhLhW8yX/ohCZQbosdQCjKa
	Liq760yNaXZ4zbOqCKExwSZi/U7H54neaNQK4jGoGCf1fJ5U/L77sOCkDb5SNUUy
	fb3WWmRa5L8lOiW92zQhg==
X-ME-Sender: <xms:0nBiadOfjl1D8kGZmKw8b734EEvIjcG8LcVUsffXTQju4Q0lYK-ZQQ>
    <xme:0nBiafCZPtiAqB-BwbwIGEmqREyyI73Jp3si-P3nD7XmF2RGSvgai5EPfYwFOUa2m
    dG12H6G6xwEBjLOURGTx0k7ZdkAugP0RApejev5k6GTPBqJv9oZ>
X-ME-Received: <xmr:0nBiaSfpwe2RMy0auHYh4I8T5kRnqe5MQYLIFRb820nZG9nbzdM0Nkgk9GCV7VZSDaNQHnHGmiHjAH6ietvtAXQabJUoIc_KtutSXr8dN_5A9tMcDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeelleegudduueffuddvteegffehudeuieffledtudehkeehffegteegfeeh
    vedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    hhgsihhrthhhvghlmhgvrhesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdho
    rhhgpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0nBiaWNt5qm8FkukJb0OEphNK3P5UW0Fzwa0VGicN0392RAfqhN_3w>
    <xmx:0nBiaaIT5jZX0e1jTv1ZlweEsMOHkQYZX2lpDOwNTibyzdpTxpEfsw>
    <xmx:0nBiaeLlqYuA5mYVT1b9U4e5pJY56ZgwM9KLl1hxURkM_T-xsiPL7w>
    <xmx:0nBiac49-4bJd7CYrZ-BMz_IPyS70nuuZNhFKhPbgbqpEmw0EmirTA>
    <xmx:03BiaUYOknfCuYnHPT-zBoifes7Or69uFOQUrCyibILyD8xIVY4W50DL>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 10:31:29 -0500 (EST)
Message-ID: <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
Date: Sat, 10 Jan 2026 16:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: __folio_end_writeback() lockdep issue
From: Bernd Schubert <bernd@bsbernd.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Horst Birthelmer
 <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 15:05, Bernd Schubert wrote:
> Hi Joanne,
> 
> I run in lockdep issues on testing 6.19. And I think it is due to
> holding fi->lock in fuse_writepage_end() until fuse_writepage_finish() is
> complete
> 
> Proposed patch is
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..b2cd270c75d8 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2000,8 +2000,8 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
>         spin_lock(&fi->lock);
>         fi->writectr--;
> -       fuse_writepage_finish(wpa);
>         spin_unlock(&fi->lock);
> +       fuse_writepage_finish(wpa);
>         fuse_writepage_free(wpa);
>  }
>  
> 
> But then there is this comment in fuse_writepage_finish
> 
> 		/*
> 		 * Benchmarks showed that ending writeback within the
> 		 * scope of the fi->lock alleviates xarray lock
> 		 * contention and noticeably improves performance.
> 		 */
> 
> 


Hmm, actually the critical part is

[  872.499480]  Possible interrupt unsafe locking scenario:
[  872.499480] 
[  872.500326]        CPU0                    CPU1
[  872.500906]        ----                    ----
[  872.501464]   lock(&p->sequence);
[  872.501923]                                local_irq_disable();
[  872.502615]                                lock(&xa->xa_lock#4);
[  872.503327]                                lock(&p->sequence);
[  872.504116]   <Interrupt>
[  872.504513]     lock(&xa->xa_lock#4);


Which is introduced by commit 2841808f35ee for all file systems. 
The should be rather generic - I shouldn't be the only one seeing
it?

So this?

mm: fix HARDIRQ-safe -> HARDIRQ-unsafe lock order in __folio_end_writeback()

__wb_writeout_add() is called while holding xa_lock (HARDIRQ-safe),
but it eventually calls fprop_fraction_percpu() which acquires
p->sequence (HARDIRQ-unsafe via seqcount), creating a lock ordering
violation.

Call trace:
  __folio_end_writeback()
    xa_lock_irqsave(&mapping->i_pages)     <- HARDIRQ-safe
      __wb_writeout_add()
        wb_domain_writeout_add()
          __fprop_add_percpu_max()
            fprop_fraction_percpu()
              read_seqcount_begin(&p->sequence)  <- HARDIRQ-unsafe

Possible deadlock scenario:

       CPU0                    CPU1
       ----                    ----
  lock(p->sequence)
                               local_irq_disable()
                               lock(xa_lock)
                               lock(p->sequence)
  <hardirq>
    lock(xa_lock)

                   *** DEADLOCK ***

Fix by moving __wb_writeout_add() outside the xa_lock critical section.
It only accesses percpu counters and global writeback domain structures,
none of which require xa_lock protection.

Fixes: 2841808f35ee ("mm: remove BDI_CAP_WRITEBACK_ACCT")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ccdeb0e84d39..ab83e3cbbf94 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2994,7 +2994,6 @@ bool __folio_end_writeback(struct folio *folio)
 
                wb = inode_to_wb(inode);
                wb_stat_mod(wb, WB_WRITEBACK, -nr);
-               __wb_writeout_add(wb, nr);
                if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
                        wb_inode_writeback_end(wb);
                        if (mapping->host)
@@ -3002,6 +3001,7 @@ bool __folio_end_writeback(struct folio *folio)
                }
 
                xa_unlock_irqrestore(&mapping->i_pages, flags);
+               __wb_writeout_add(wb, nr);
        } else {
                ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
        }



Thanks,
Bernd




