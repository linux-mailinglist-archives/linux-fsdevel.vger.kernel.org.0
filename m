Return-Path: <linux-fsdevel+bounces-1868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258097DF90A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEF1C20F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918C208AF;
	Thu,  2 Nov 2023 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lm2J+a7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB09200AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 17:43:47 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCD111
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kx/yYrfCSkZc6Gji/dh/U6o90FM5O8kFUvoRwcaDUfo=; b=Lm2J+a7oPnDGf4YZO968Uy8zyo
	gHgvc8mBhl96hXjqUuj+YVQpusDwJQq7bYvCYNaS0MZvRqLfEezH2K6NSwsXCbbZtiUbJRv7itTKU
	JuXHXKljW1D1STrHAAcf40nIYQ5jehSNNiBxz+aB4mumF5FmpXMgkNPU+eQoepy1D1/lpjhHlecgk
	+C9UrGp+iNrTcI/8rkXQ/SOofz+VG85B5zQutrH2w3mL8v7rwCJQLTCp/h0SRF1LaTVGssE2LRE0G
	u0+K89DAkgPgF0FOPQalppjtSht6dskj3TB3Gi6UuEIkzjMWJ8X1EW1DLJPEaSgFKiLcE6RD73AlQ
	NCGnuMMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qybjJ-000eR3-0B; Thu, 02 Nov 2023 17:43:41 +0000
Date: Thu, 2 Nov 2023 17:43:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ida: Add kunit based tests for new IDA functions
Message-ID: <ZUPfzKMIToSe+X5q@casper.infradead.org>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-4-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102153455.1252-4-michal.wajdeczko@intel.com>

On Thu, Nov 02, 2023 at 04:34:55PM +0100, Michal Wajdeczko wrote:
> New functionality of the IDA (contiguous IDs allocations) requires
> some validation coverage.  Add KUnit tests for simple scenarios:
>  - counting single ID at different locations
>  - counting different sets of IDs
>  - ID allocation start at requested position
>  - different contiguous ID allocations are supported
> 
> More advanced tests for subtle corner cases may come later.

Why are you using kunit instead of extending the existing test-cases?

