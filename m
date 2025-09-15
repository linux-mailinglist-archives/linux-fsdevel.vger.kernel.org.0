Return-Path: <linux-fsdevel+bounces-61312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1CB57871
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB22204168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB003002DB;
	Mon, 15 Sep 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JYqVNs3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987D2FE582;
	Mon, 15 Sep 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935760; cv=none; b=HYhlgmui/+7p6qdxehJFAILdkRbLQweUkaZnNsQUzTZmWj9PkQrq4G3sOA4f5Tgv7TO9yZuVB3WVWQu1AFTG+ZEBG1YO8NUGT9W0c+sTsOfDj7PzQYyreQXQ9wyGnbTRfOIgj4w1TeXwABSq8ZKbtAr5svxK1KEmZzfO5C/1IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935760; c=relaxed/simple;
	bh=h8N5DQsluw63hpDiIfAsSv/f5j7+RX3YTW3a5dH8PwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bex0K9Te01Sxc0nDbog1og4mBOy3ltFLfl42v6aktnkXaS1WXYu92KHv+P6Y49ZOsrWSDRB+qVpiFJEieEy3Np2XTYErDmw/5zinkuBwZQhs0zGv9yrF+tiw6CdEkApJbG8OzPjBB9p8Ef/oXRRPfvklj4Z4vaA0WCUTWEQXH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JYqVNs3f; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cQN8p06m9z9t7F;
	Mon, 15 Sep 2025 13:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757935754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMB0PHuT4LD/TWJpWthgb5izCIfvxrdwUnTvG4F0jxQ=;
	b=JYqVNs3f0b/OOzvel1zfP5WBNuWsQJoLEbKXhsbzi+slKha16x86iG6q7jJc/HkOmzjZV/
	sUYEm82nIs6JtJDvsI2kgP6sGir8UYkKKVozLfoBE/A5HipOpCm8RwFU7MAdjbzv+tPsui
	yo/r6yKFWbo/ZBL89QtqmxrYkEwaSJKt9ics1dcAPdh5qvZ5v6pKwZbkKIyoOJkEvs82F9
	dTCmerOb4LMKJlHT8rQ7UJmJ0rIQTYE7qgHne6wAUE1XVcz4GjAqldw2wRzJwrkqis5yjv
	BDtaNPlOT+iYpimjVD4Zj4Jw7Bb0oiPDrF9d8Z8kaNGIEOXLSxlDEm75rOyIdw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 15 Sep 2025 13:29:10 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: alexjlzheng@tencent.com, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] iomap: don't abandon the whole copy when we have
 iomap_folio_state
Message-ID: <tcaz35lk5kwkmj74sv4fbf52fliha4uc2yv5fjee2qxsjamqr2@jkxk3vitf7lp>
References: <dhjvmhfpmyf5ncbutlev6mmtgxatnuorfiv7i4q55wpzl7jrvn@asxbr2hv3xfv>
 <20250915111228.4142222-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915111228.4142222-1-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 4cQN8p06m9z9t7F

On Mon, Sep 15, 2025 at 07:12:28PM +0800, Jinliang Zheng wrote:
> On Mon, 15 Sep 2025 12:50:54 +0200, kernel@pankajraghav.com wrote:
> > > +static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
> > > +		size_t copied, struct folio *folio)
> > > +{
> > > +	struct iomap_folio_state *ifs = folio->private;
> > > +	unsigned block_size, last_blk, last_blk_bytes;
> > > +
> > > +	if (!ifs || !copied)
> > > +		return 0;
> > > +
> > > +	block_size = 1 << inode->i_blkbits;
> > > +	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
> > > +	last_blk_bytes = (pos + copied) & (block_size - 1);
> > > +
> > > +	if (!ifs_block_is_uptodate(ifs, last_blk))
> > > +		copied -= min(copied, last_blk_bytes);
> > 
> > If pos is aligned to block_size, is there a scenario where 
> > copied < last_blk_bytes?
> 
> I believe there is no other scenario. The min() here is specifically to handle cases where
> pos is not aligned to block_size. But please note that the pos here is unrelated to the pos
> in iomap_adjust_read_range().

Ah, you are right. This is about write and not read. I got a bit
confused after reading both the patches back to back.

--
Pankaj

