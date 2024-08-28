Return-Path: <linux-fsdevel+bounces-27486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31B961C04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AE01F24294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E727481CD;
	Wed, 28 Aug 2024 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MspHzbro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67D42065
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811802; cv=none; b=n0ZGl58ROXuT2xcTxQnjj1VUVvxe91PaPzSqPkvvwBB9TLSevYPE79EdcO3muqqZOe6JYX9ygvq0NCc2pyAAcFoA9VarGQG1CVATHk9uXw5cMo7Kmtw4ZOS6Ic8K5VJ9dIR0hrQXwvybIhHvnmDPIuHKa9CA0LjEmGN649dFc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811802; c=relaxed/simple;
	bh=GpVL77/wQC8XFwBqOR8Ijyd8z/6wnws4dQVYPbhpOD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7jNXkz+lA3cVAaUAQ6GxXjCmqi+XB9aB7IXmNfvXufljbcElMkpvFWqSw556zAZUr9klu3AdFiPYO4R306zb3Zh78h6nPLo1w6HuEcznFbzQetTl4WjBDbNrDr/pLZmQEnJcSzWkCjCZ9+SlGNOJvtxPteg7TAEATWDamTtFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MspHzbro; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 22:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724811797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSbZj6mcZdBMGgsaki7D1+Lg/Lo1Q5717z2hfLufPhY=;
	b=MspHzbroBjMVubn+/ib4e7AdGpv+8zuK+BOMmea9bbfBijnD0bQtFPYUBcmIHqmOAhlH4s
	LwC3FH/YryIf06cWHPKT4UTrhbPUX+tmcirTmcrsCTQ8y2WU0ijzH2kb4/+1fBoC33Brbs
	cN3LltJ/9kK5c91r++S7uBPyx615VaY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] shrinker debugging, .to_text() report (resend)
Message-ID: <2zd3yfcglv3wf6vgjl4dxaeajrovoxeaca3gkyl6o6aj24syyd@5ghiokumyv4s>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <Zs6CpsYtsL4mtoSN@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6CpsYtsL4mtoSN@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 11:51:34AM GMT, Dave Chinner wrote:
> On Sat, Aug 24, 2024 at 03:10:07PM -0400, Kent Overstreet wrote:
> > recently new OOMs have been cropping up, and reclaim is implicated, so
> > I've had to dust off these patches.
> > 
> > nothing significant has changed since the last time I posted, and they
> > have been valuable - Dave, think we can get them in?
> 
> You need to describe what this does. What does the output look like?
> Where does it go (console, dmesg, etc). When is it called, etc.
> Links to previous review threads so people can get back up to speed
> on what was discussed last time and determine whether issues raised
> were solved. A changelog since the last posting is helpful, too...

Not much has changed since last posting, besides tweaking/improving
counters...

objects, requested to free, objects freed: so we can tell if a shrinker
isn't freeing as requested

last scanned and last freed are new - so we can tell if a shrinker's
gotten stuck (perhaps it requires a lock that it isn't able to get)

bcachefs shrinkers additionally have counters for every distinct reason
an object wasn't freed - this has been quite useful in the past:

BTW - the next thing I want to get done is adding an interface for
shrinkers to report the amount of memory they own in bytes. This will
greatly aid the show_mem report, so it can skip reporting on shrinkers
entirely if they don't control much memory or pick a number to show more
intelligently.

It'll also let us finally fix the free command.

root@moria-kvm:/sys/kernel/debug/shrinker$ cat 05baba83-05ef-4d71-be0e-121bdabfee36-btree_key_cache-43/report 
05baba83-05ef-4d71-be0e-121bdabfee36-btree_key_cache
objects:             122411
requested to free:   63
objects freed:       0
last scanned:        198 sec ago
last freed:          42949578 sec ago
ns per object freed: 0
keys:                         129119
dirty:                          6580
table size:                   262144

shrinker:
requested_to_free:                 0
freed:                             0
skipped_dirty:                    21
skipped_accessed:                 42
skipped_lock_fail:                 0

pending:                      114727

root@moria-kvm:/sys/kernel/debug/shrinker# cat sb-bcachefs-44/report 
sb-bcachefs
objects:             1
requested to free:   0
objects freed:       0
last scanned:        42949693 sec ago
last freed:          42949693 sec ago
ns per object freed: 0
inodes:   total 2 shrinkable 0
dentries: toal 2 shrinkbale 1

