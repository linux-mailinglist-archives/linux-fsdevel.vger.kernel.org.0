Return-Path: <linux-fsdevel+bounces-58800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF5B31914
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5467A7B9224
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD29303C93;
	Fri, 22 Aug 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUaE1OKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364F2FF14B;
	Fri, 22 Aug 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868564; cv=none; b=sDI+/i/yXGpcKM+GN1DJ7opD97eD4uJ/SpKQfZIItTbH6cuWomk5UJJBLIMRnhN3av6cGHnJ3cl7GBCwdJYhE4QqYXqkzgzuKi/98ogIkd7QxcquRY7DfrAnx124OR6pZVXuIYNPT6nkx5RLftysOAXsmIMB7YXfFBSLqUuNbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868564; c=relaxed/simple;
	bh=E9SWjDq2Dx9bluiQ3MsBtIywG3gBOC6POLtg9cN7FTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf5CZfEJ2hPskLop2w0F25gviaIS9WxE2RGCSO854guzws9R9lYUcEtVPOJwkCDsakzE5amdc9C+AxFeu2RJba7N49YhpQHyCiYxA576w/8/tVrNgRXOzJb2Py3bcbAd4iz8NsPvD1ISJUQVIZuRDGzHCnSfn7U9bZ0hR4aHTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZUaE1OKu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ET3se4OxnTeOD3IJ4EAKqjqV4x9bGpczObSPg39C6OQ=; b=ZUaE1OKuJMb58CtRgyJ+/M4i8P
	1Q34L849Z93rBZAAOpb+42MopP0GXeebRu+gcWMleTqhqU7Mp9kZgK/tSQErZ19CxGi9mjT2EkX5c
	c/WR07GEGU2djqbdlWa9M4Pah26/8OT6i86slmX4NCGuUGZgh8pj7spBhSdkAxHqJwZGDQkLifwVA
	I9Lj7nYk1fNHad80nT0tGxOL7DJxyvKn3TERYQ/yzozjwu+fc5pe1jl7BiQ6SfpAubsgPLHiBu41j
	Q+k90cesgjiKCAVYHiN+mBJtNH96rNeBWN5/BAwcYsaPE8vc2tNHrtWOBEnqTnRDhrLqG2+dK2zCn
	JfJjl4rA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRcW-00000008GU1-0iiF;
	Fri, 22 Aug 2025 13:15:52 +0000
Date: Fri, 22 Aug 2025 14:15:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <aKhth9DOKrhfnZwS@casper.infradead.org>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821122750.66a2b101@gandalf.local.home>
 <20250822133935.4e68d2d2@foz.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822133935.4e68d2d2@foz.lan>

On Fri, Aug 22, 2025 at 01:39:35PM +0200, Mauro Carvalho Chehab wrote:
> On a side note: I never used myself bcachefs, and I'm not aware of its
> current status and how much it depends on the current maintainer.
> 
> Yet, IMO, I don't like the idea that, if a maintainer leaves the
> project for whatever reason (including misbehavior), features would
> be excluded - even if they're experimental.
> 
> So, I'd say that, except if we would be willing to face legal issues, 
> or the feature is really bad, the best would be to give at least one
> or two kernel cycles to see if someone else steps up - and if the
> feature is experimental(*), perhaps move it to staging while nobody
> steps up.

Kent is bcachefs.  There's no team who might be able to step up, and
while the code is certainly clear enough, anyone who takes it over will
have to deal with Kent, an army of internet trolls and having to learn
an incredibly complex codebase.  I wouldn't wish that on anyone.

