Return-Path: <linux-fsdevel+bounces-1022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F37D4F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BC61C20AD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4026E21;
	Tue, 24 Oct 2023 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHo0uJ5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D7266C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:09:54 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F506120;
	Tue, 24 Oct 2023 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cirv4ndqjxPdzRBdPJic5vaz9dOLi3WYy0YXH6TCVi0=; b=pHo0uJ5Ga4SZ4iq+fNOeCu2Fuh
	kthT3tF81ELkOCP0cRABWYjp+7x9icLmh+tcYokQOrc2tb3XPY7GH+8w599Uuc/GzeRvIcaZ3VM4g
	EH5WfRUincNOpQJxLwS9NOEU2iHloEIZOHUhM2nEhA0tbrfpaI2uAEKLVDUozd94I62JSggGGEYjO
	VSqWBbQM9pAKg7TudzHnun+nukAl5X72P1I+1Y9ejtnB4zHugb8fBDK572NqOaI26VX7AFOKOKX4a
	urmWo//FZWKNBUxXHmnbzBtV0bnaSZZEtyLiCVe0x3zUAC/9ArBKn2OSYq4bDHKihn2XrctpfTa3R
	dEBVHitg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvGEF-002M4u-QL; Tue, 24 Oct 2023 12:09:48 +0000
Date: Tue, 24 Oct 2023 13:09:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
Message-ID: <ZTe0C90lRfp7nnlz@casper.infradead.org>
References: <20231024064416.897956-1-hch@lst.de>
 <20231024064416.897956-2-hch@lst.de>
 <CAOi1vP_mF_A6OmNvYPvmBcS-CHQkwOHqsZ1oAZCJXQmow3QUMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP_mF_A6OmNvYPvmBcS-CHQkwOHqsZ1oAZCJXQmow3QUMw@mail.gmail.com>

On Tue, Oct 24, 2023 at 02:03:36PM +0200, Ilya Dryomov wrote:
> > +static inline void mapping_clear_stable_writes(struct address_space *mapping)
> 
> Hi Christoph,
> 
> Nit: mapping_clear_stable_writes() is unused.

It's used in patch 3

