Return-Path: <linux-fsdevel+bounces-6527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBB8193DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD43F1F269BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39C40BF4;
	Tue, 19 Dec 2023 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YGxadkup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96940BEC;
	Tue, 19 Dec 2023 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MAwg2J+eab2tticeU56XVYHeeqgeTkCX8ApI/spLR+o=; b=YGxadkupXV7DDfETbrj9rF0W8B
	xk9uC8o7meOixhvXtiPgfToiDkMsrxYnvumZaKOaMMlTdHkmpxY5wy+3T8p7RyiaMdSeOd7mb/XrG
	kvzgjcXk+mq/O/37+rMOaA0w5+33KWR8zKxocebBVam6BGiTNaSq7mdMybPuPisZjx/8of9U+n4ZL
	VvE30UdYIyg+it8RYSrs2S5RW3TcJ35R0UvJsLnFnJ5KlSos2ZEcb5CcdzrAsla0X/l1B8KUQyrfz
	PtWohRH4+LskpvatCBt3SGEoBtPy0PT706QrtrOsK61pydy5vOP8nZN0puaoe6sej/cKQYIjxVLxH
	w2fechRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFiwz-003PwK-M6; Tue, 19 Dec 2023 22:52:33 +0000
Date: Tue, 19 Dec 2023 22:52:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 15/50] kernel/numa.c: Move logging out of numa.h
Message-ID: <ZYIesYOHfpEi4QCr@casper.infradead.org>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216032651.3553101-5-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:26:14PM -0500, Kent Overstreet wrote:
> diff --git a/kernel/numa.c b/kernel/numa.c
> new file mode 100644
> index 000000000000..c24c72f45989
> --- /dev/null
> +++ b/kernel/numa.c

Should this be a new file or would these functions fit better in, eg,
mempolicy.c which is already built only if CONFIG_NUMA?

