Return-Path: <linux-fsdevel+bounces-23703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B699317F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0FC1F21DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF2EAE9;
	Mon, 15 Jul 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/67uxuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF469D53C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059104; cv=none; b=FtioklDVFLDKBNh6TdiJxXh81pbBOkTBkDErCcWUu0gtoLjR4QGdtdI158Vnvh4kBzLX5nrF3hOns8VsiXld1LiJRIMyqbzNf7CXFo5SONHeqOCGeCMTqC8d/8xFk/SL3j+FZjULLSvZ93CCI3KWGXH9BtiJf0/4dl5tcLEQViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059104; c=relaxed/simple;
	bh=Tu+to5zYQIHYKWvraE0cfzPY9oXqsqd7bZrdSDIVhLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Uyqw63t4TouunA6VwX/kbBtzjC+6Difv7ccLxyuzSzy69+kBavnWXyGt4xjyX5LHwHtdx/wCLjnLtruSA4sI4QvKRDlNkumSBsGiXBz7fo1Y0pG5ygPEIXmforVb0e76tR3wFWmL4X7BmUxfYn6KD9UGFaJaK1mbyV6mcGce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/67uxuI; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hubcap@omnibond.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721059098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3CffOkFJ7FkGHUcL+zB8tDqzb9u9dlIZceHLCZh74o=;
	b=P/67uxuIDJZJvhbmiDO2cUzyG6wbXST49EAIf18ck45Rfs8kOQA3JOtw4ugdKPVJen+MAG
	E+aOBNQIId6y4p8Iimmk1sa24k0zJNVD7rUJrwRGkne85/TJbc30NZTycKMHZuhabMFddY
	vMNgzLGDS3pBGXezpDfFPjke0WudxCM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Date: Mon, 15 Jul 2024 11:58:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Shared test cluster for filesystem testing
Message-ID: <6nfkavemociye6oebi3fu7j2djj5u6bxswwasamt2l3rac2ogz@gjc7m5jo463k>
References: <o55vku65ruvtvst7ch4jalpiq4f5lbn3glmrlh7bwif6xh6hla@eajwg43srxoj>
 <CAOg9mSSJCzh6KtEh+EvP7mrbktSjch5tzDzLXYtnpOrCYPgU9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSSJCzh6KtEh+EvP7mrbktSjch5tzDzLXYtnpOrCYPgU9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 15, 2024 at 11:51:26AM GMT, Mike Marshall wrote:
> Hi Kent...
> 
> I think it would be cool if there was an orangefs filesystem tester
> in your cluster. It is easy to set up (I'd help if needed) and then
> maybe there'd  be more people running xfstests on orangefs and
> more eyes on its code... plus you have all those other tests
> besides xfstests...

Would love to have it :)

Have a glance at the existing tests, it's a pretty simple environment -
ask me if there's anything unclear, and send me a patch :)

