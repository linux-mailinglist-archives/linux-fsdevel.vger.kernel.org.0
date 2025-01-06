Return-Path: <linux-fsdevel+bounces-38479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E054A03182
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 21:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018EA1886B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AB1DF97C;
	Mon,  6 Jan 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcvWch5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E087081E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196095; cv=none; b=aO5birLnp2ESw7rGFVLscVdtNXmfnCmaXjbsGh6PYeOg8mafNoPqCHMQzSSUegX5pXEAZ02hblXuZCd7KkaYCxBjSOmU/eTkfLHlz7OcaL3ihggzbL+lZe0q6rmFJFLregWLGF1wae3Kdt05tWpieJa7pFAIVQNGLZ6EduQ6GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196095; c=relaxed/simple;
	bh=305vkZmxK4c2jEiu/4TirzxpkS4Wa0GYovrOhrtLXUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6/q3nR7lMkWMxl+WJa588SZewG01GdlxXo4ccwpfsCBRhrI5s6EOloMNw80VMoGKukIo+TiNfZEq33F3ZVX/JvBdeWDPH3uQwc85sPQdAuebDcguB1przAvcdx8uWxGfqCduSuLQdw6QGXRf0tg2nhnMq6wpuFxpgiKuAcddR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bcvWch5m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iY4vHxkhsiWdKeNW4gC5DSoWtF0uIZoq+x60xGrmTSY=; b=bcvWch5m7UUdFkmOfXU0T35Vj1
	ikZ3Ci2vPep9LEOQwGG34XtUEsUVmsd4vU7rb8N7PKc/I21x49KSATEZ9psaql3eoW1x7CNXvacxQ
	7AQ9+g3CKP6TWIrGELOKXhAFvw2F1sGpX6iDYJV98HmmIzgY1/3fM3RYYdVivmGx0pRYh87ceLflo
	TbagqP+8g8VhyjjzhE557cgq25A0nM9bFlPcClct3KKWOkk8TG5s31ikxkMSh46HyCrd66mwYvEp6
	nI1nOOQ0trAwKjeoV7+o200gdPCqvMw9Zv/Ny2FV/UYSQjzKtfgv3jcIydH3i1hP7abp0nAMdk71N
	OjnTdw4w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUtul-00000000mpL-0BKC;
	Mon, 06 Jan 2025 20:41:31 +0000
Date: Mon, 6 Jan 2025 20:41:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <Z3w_-o4lSW4NXfvD@casper.infradead.org>
References: <20250106162401.21156-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106162401.21156-1-jack@suse.cz>

On Mon, Jan 06, 2025 at 05:24:01PM +0100, Jan Kara wrote:
> Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> rwlock") the sysv filesystem was doing IO under a rwlock in its
> get_block() function (yes, a non-sleepable lock hold over a function
> used to read inode metadata for all reads and writes).  Nobody noticed
> until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> Just drop it.
> 
> [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  What do people think about this? Or should we perhaps go through a (short)
>  deprecation period where we warn about removal?

The sooner we delete filesystems, the fewer syzbot bugs we get about
them.  Let's delete as many as we can.

