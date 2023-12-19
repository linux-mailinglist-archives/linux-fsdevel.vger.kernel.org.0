Return-Path: <linux-fsdevel+bounces-6459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C007817F8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D94CB23817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3B3FDD;
	Tue, 19 Dec 2023 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QkmZ8UNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422901FB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 21:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gxdUBvlwxQF2m8mrc/z0BhgiW5ltZJenxbW07auf6E=;
	b=QkmZ8UNJFQJz5FOSc4pQewPIzXMG9bumpDEt0CcXb89ypvXLUGAPDF6vw1C47xd0MJNUz6
	r+1vrHXZFF4XCJhbSwZK4cFmVwqCQ17f+HnWT2NNvJhR0Cp1RFlVcgM6EsC8dKxSqIGZoC
	MgZeKIfuT+Tr8QfSxGT4eTg2k3P1Hdo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, X86-kernel <x86@kernel.org>,
	tglx@linutronix.de, tj@kernel.org, peterz@infradead.org,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org,
	keescook@chromium.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 02/50] x86/kernel/fpu/bugs.c: fix missing include
Message-ID: <20231219020507.cknqkwp2l5ivnrf7@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-3-kent.overstreet@linux.dev>
 <5ae9ba1f-07b9-423e-bf74-175e57dda031@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae9ba1f-07b9-423e-bf74-175e57dda031@intel.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 04:38:33PM +0530, Sohil Mehta wrote:
> For the x86 patches [2-5/50], should the patch subject be a bit more
> generic rather than having the full file name listed.
> 
> For example, this patch could be "x86/fpu: Fix missing include".

In the latest version of the patchset I've just rolled all of the
arch/x86 missing includes into one patch.

