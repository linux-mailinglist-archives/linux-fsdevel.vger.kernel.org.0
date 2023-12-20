Return-Path: <linux-fsdevel+bounces-6536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262B8195C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 01:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CA51C22793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17EEAC9;
	Wed, 20 Dec 2023 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qp+CTAGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B258C09
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Dec 2023 19:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703032633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHj95+SuuyuWE1aSF6Rh6UTwRm9YyyNdHIj34uMPRo8=;
	b=qp+CTAGiISYK5OsbFlrDsk0N5xl83cjPhbMYmtT2vDnenKXaqxLkePTl5h03mktfWBfvuP
	rfMH1mZLDvyVJHjM+56nLh741/Uty9ZOIEpBniIinPBJnKx4rmVZyMwPRbY6WWF2EqF2X8
	WAm1fqiuSAhO8ocVjhNby5s66oWfYyI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 15/50] kernel/numa.c: Move logging out of numa.h
Message-ID: <20231220003709.vayf4rcip7c3hjk7@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-5-kent.overstreet@linux.dev>
 <ZYIesYOHfpEi4QCr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYIesYOHfpEi4QCr@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 19, 2023 at 10:52:33PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 15, 2023 at 10:26:14PM -0500, Kent Overstreet wrote:
> > diff --git a/kernel/numa.c b/kernel/numa.c
> > new file mode 100644
> > index 000000000000..c24c72f45989
> > --- /dev/null
> > +++ b/kernel/numa.c
> 
> Should this be a new file or would these functions fit better in, eg,
> mempolicy.c which is already built only if CONFIG_NUMA?

that does look like a bit of a disorganized dumping ground though, I
wonder if anyone would want to start mm/numa/ and do a bit of
organizing?

