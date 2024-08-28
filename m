Return-Path: <linux-fsdevel+bounces-27569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE499626C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F8B22DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004EB176227;
	Wed, 28 Aug 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCHoh5hO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432A16C6B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847487; cv=none; b=Jsrh13zH1ndqvzK2ZuHelLqALEgK8bx/cz8k75D6YcQcqh1KzFfFlgRuoKrQqL8kDsIZrGFf2NaQoHT5VjGTSe5cKoB8J13nljrEodztJElZ/NrD8hWYwls9DquBxxMj05I6JDRYHx0y+e4p0Vw+wW92wjnRIAWyBg55RGRD8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847487; c=relaxed/simple;
	bh=LdapwuU/IGn724OeXM37e34/vZ9fGsDth+xWymHgzy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bellc36cWY6o4vGAOMlSknD2bW+s8FNXE4ZZWEgEe87067LMrdp7bWqBTWZ57PvDQKO7UQqIxBvTIxRfgYEjiAlf2kTfjuJiB6dqB9smXuIbajG5po53lLGHi+XZcuifRU/jW1Z6Qltof3xOLdGFju1Bcm2mSq4pFjBxU+k4AaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCHoh5hO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB5CC98ED6;
	Wed, 28 Aug 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724847486;
	bh=LdapwuU/IGn724OeXM37e34/vZ9fGsDth+xWymHgzy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCHoh5hOHJax6mEW8+cUr1HiR9bpuETutKyblt1hh+5tDSdU2za6yyKt02StT4nVx
	 jm3reh8W+9JsLVU234CGZi6FGF/+yU79zQP6axXOuP0G/0B4QcxFWKPblTZc8QNzAw
	 EK2kUxzEU4UZ4zOry9vt/u52rBhH96sTS8S8OY0K5HIzhMNx8iEAg6Pv07G9voh60P
	 gpg6xaQs4k7VpL13/FSLWJYXHgrEXtW+ntt7nWrb6eUCIVDRFMbI7WbUuJLaAFwjbw
	 dUTEOZhmOZwb0dwtNW3j1YQUa6CALMbA14L5rd4145Rlbcq+4IJlCWUQ0H3h3PWr3z
	 WKdHHq6t1qOYg==
Date: Wed, 28 Aug 2024 14:18:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs,mm: add kmem_cache_create_rcu()
Message-ID: <20240828-basen-verteidigen-327c7a299ee2@brauner>
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
 <20240827-lehrjahr-bezichtigen-ecb2da63d900@brauner>
 <96dd4a75-e83f-4807-b43e-bd5552f6aa6d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96dd4a75-e83f-4807-b43e-bd5552f6aa6d@suse.cz>

> > @Vlastimil, @Jens, @Linus what do you think?
> 
> In the other thread you said it's best to leave such refactoring to
> maintainers and I agree and don't ask you to do the cleanup in order to get
> what you need (and we don't need to rush it either).

I mainly didn't want to wait for that huge refactor to be done before we
get a workable solution for v6.12 since the patch isn't all that huge.

But I'm not shying away from cleanup work I'm the cause of.

So I'm happy to do it for v6.13 as a follow-up but I also don't want to
steal this away from you because it'll probably be a fun task to get to
port everything to struct kmem_cache_args and clean that all up.

