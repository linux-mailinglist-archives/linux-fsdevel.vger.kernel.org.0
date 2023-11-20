Return-Path: <linux-fsdevel+bounces-3262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602197F1DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A531F234E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD17374C0;
	Mon, 20 Nov 2023 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oKX6neUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D831DC;
	Mon, 20 Nov 2023 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FkCCr9BHWLoh0RTrdjab9K+eEFFI+aH/zKFL0ziApPg=; b=oKX6neUTWZejGqYVq9QMuSW5XM
	cFJSm6r57pNkmVFYr/Y4EWkjXIqqSZnAmfXHxlymcjXs78w2ZvkVZ4NvIpJzq6B/5ABGOzP3Qck2b
	9DIvbQhBTu9JZ2gtCSSLHQoJ1tIWg2BayHlgJmTH2SRRq09G/kiKXzqU12/RRDIJfyMHj2vN9UaRS
	WfzljpCD22QUBtNE2LagaaZSzLejLM+hDcwHWJrnAWB1+N/NL+bdL8suUdjcCTkmlJylQRI3bh5OS
	NtkbZsOOS+135RkZWm65MBla91+Si9C1G7fp54Pf9k/8AOoz52LjK09LrqyZaYr+EofFsqLcu643P
	w3F01ubQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r5ARt-004wQB-Ju; Mon, 20 Nov 2023 20:00:49 +0000
Date: Mon, 20 Nov 2023 20:00:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 3/3] ext2: Enable large folio support
Message-ID: <ZVu68Sp1cdor5hxJ@casper.infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <3dd8b8bce2c29d5e87bbdc9e37fa11ba80f184b9.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd8b8bce2c29d5e87bbdc9e37fa11ba80f184b9.1700506526.git.ritesh.list@gmail.com>

On Tue, Nov 21, 2023 at 12:35:21AM +0530, Ritesh Harjani (IBM) wrote:
> Now that ext2 regular file buffered-io path is converted to use iomap,
> we can also enable large folio support for ext2.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

