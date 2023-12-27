Return-Path: <linux-fsdevel+bounces-6950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390C81EE1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 11:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0DE28385E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF22CCDC;
	Wed, 27 Dec 2023 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pU5STzj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E762C866;
	Wed, 27 Dec 2023 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wb87vj5TbXVcjrLud3m6t6FnLN5KHCZaLB6pA0oKcNI=; b=pU5STzj/eZVugBvNDEnuG+L5ft
	A1Fbs7V4YNj9EvGMxlftYxDOwqz2s0JdePzwD6LNRg3q7jOfSAi9jZr2EWq/h/pWkyK9vGY+LDdL5
	gaQQbyhqWm/8EJS5xsXhjedwNUG8m8JAleBoy7+jYp0xx6WAoknyT0eJ+uzMo1bV2BbQ8je7XWYMy
	UoSVGDNji4EwDzKX5ngkIM4Ezkz9KKEZoxWuZtB1rI5rfUTtGGasUywCt61tQ1LomgQWwe4jJi8ls
	YL3RPxi/KLeKMdYrdV75fCMTh8Ft9LTE1eXER1AHQlGY6MyzdPiHwGuHz8oJHdarsFs9Et889doDp
	i99fhsGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rIQyO-002cju-Rs; Wed, 27 Dec 2023 10:17:12 +0000
Date: Wed, 27 Dec 2023 10:17:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Zhenghan Wang <wzhmmmmm@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [ida]  af73483f4e: WARNING:at_lib/idr.c:#ida_free
Message-ID: <ZYv5qLaEMuJ8oTyw@casper.infradead.org>
References: <202312271025.7f350868-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312271025.7f350868-oliver.sang@intel.com>

On Wed, Dec 27, 2023 at 01:52:42PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "WARNING:at_lib/idr.c:#ida_free" on:
> 
> commit: af73483f4e8b6f5c68c9aa63257bdd929a9c194a ("ida: Fix crash in ida_free when the bitmap is empty")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Oh, ugh.  I didn't think about panic_on_warn.  Is there a way to
skip tests if panic_on_warn is set?

