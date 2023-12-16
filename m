Return-Path: <linux-fsdevel+bounces-6319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D155815B35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B729A2821B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A731744;
	Sat, 16 Dec 2023 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aBwkrMxh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E22D79D
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 14:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702753798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Jo4OhEjD0Gr3HR0mQmqnLOLQJfzNTqGMFbzQ8sCI58=;
	b=aBwkrMxhYp1Gh3yrZD+TnzIcXfKJ2M6qkWjg+iLI5SvesFaws5G/8umhhgX94FqR9Byi8q
	vJSS5lQihW3+1+YRLnOg/Fl6E5R34Egaz26tKoCFx+WK/gGR0vYsu9599liGo5FpGe6FHu
	1p6n7YkWtHn7GhIxJ8rA/FzqX1Wq3AU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 26/50] rslib: kill bogus dependency on list.h
Message-ID: <20231216190954.vjcgab7ttfrqk522@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-5-kent.overstreet@linux.dev>
 <5a5daf77-ba00-49db-a963-e343a0b2b8cf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5daf77-ba00-49db-a963-e343a0b2b8cf@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 16, 2023 at 11:05:08AM -0800, Randy Dunlap wrote:
> 
> 
> On 12/15/23 19:29, Kent Overstreet wrote:
> > list_head is defined in types.h, not list.h - this kills a sched.h
> > dependency.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  include/linux/rslib.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/rslib.h b/include/linux/rslib.h
> > index 238bb85243d3..a04dacbdc8ae 100644
> > --- a/include/linux/rslib.h
> > +++ b/include/linux/rslib.h
> > @@ -10,7 +10,6 @@
> >  #ifndef _RSLIB_H_
> >  #define _RSLIB_H_
> >  
> > -#include <linux/list.h>
> >  #include <linux/types.h>	/* for gfp_t */
> >  #include <linux/gfp.h>		/* for GFP_KERNEL */
> >  
> 
> What about line 47?
> 
>     47		struct list_head list;

It's in types.h.

