Return-Path: <linux-fsdevel+bounces-5100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9D8080C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 07:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AB2B2079C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F801E48D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="26u94biI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF36DD5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 21:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b/RNsTcTyUOZ0sZCqymX50hoLR11vqsG8PU4jY+H9HY=; b=26u94biInhu/7gjQ2YjCQtcImK
	4HQ3QDEBz6iayH0JC+eqXtMvIfG57ZNDtLHUnMIYYdOzjfbeKxnGLzRJy4+VxGewLMGasWKdNxX6u
	+GSLFRNTF9S0N2xUms2b1gdJuVZvwENPND5oN5z6T3g796GQJSeg6IMVR1hE7cLWMmJCCvD/gMUeP
	VvEtnVmh5QfnbGe+XEho9UNaGVyym0Mmj6PI4Od06EQwLMAmmmLHi9asmilbaGQKfLahqy8Sn2I4z
	Uy7GzqEofdbYhmPxMfuH0Gf+f/PufzUSZAkuGjQBYIYmZUbf03gPnEYIZdA82u5GxZg2vKG6bvKnB
	Vt6AInTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB6rj-00BtP6-2h;
	Thu, 07 Dec 2023 05:24:03 +0000
Date: Wed, 6 Dec 2023 21:24:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: Convert vxfs_immed_read_folio to the new folio
 APIs
Message-ID: <ZXFW8yGT3uuGgObF@infradead.org>
References: <20231206204629.771797-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206204629.771797-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 06, 2023 at 08:46:29PM +0000, Matthew Wilcox (Oracle) wrote:
> Use folio_fill_tail() and folio_end_read() instead of open-coding them.
> Add a sanity check in case a folio is allocated above index 0.

Where do these helpers come from?  Can't find them in Linus' tree.


