Return-Path: <linux-fsdevel+bounces-7902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9267082C91B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 03:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B7A1C2299E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231018EA9;
	Sat, 13 Jan 2024 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9eEllow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7418E03
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Jan 2024 21:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705112445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4BmKSgEj//6SJN4Mq1odyJx9fBqW4W1Nd/3t5TPmKw=;
	b=f9eEllowWHv07IwyE/Xq7H6dEStboZi+D9VFR5kkRS2TnJc1j0zrN90a4jiH8jYSPZWgR+
	33LZOPSWfD+u7qB0FEdAvBoz6P4z9H+dpg3QDWoNdGO+ogAHLB+sTKrI1pE/szqhffSc9u
	t2B0OWPtIktUs37DXFf4ZVR26PPhhNc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] bcachefs locking fix
Message-ID: <zrgooauqvxuw4zih77d7y3wbli2nwf5hssdzdzteujn44id3q5@5lmxsw7sgxvf>
References: <20240112072954.GC1674809@ZenIV>
 <degsfnsjxknfeizu7mow5vqwel27zdtfxa3p5yxt2l7cd74ndo@5z6424jtcra6>
 <20240112192540.GE1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112192540.GE1674809@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 12, 2024 at 07:25:40PM +0000, Al Viro wrote:
> On Fri, Jan 12, 2024 at 10:22:39AM -0500, Kent Overstreet wrote:
> > On Fri, Jan 12, 2024 at 07:29:54AM +0000, Al Viro wrote:
> > > Looks like Kent hadn't merged that into his branch for some reason;
> > > IIRC, he'd been OK with the fix and had no objections to that stuff
> > > sitting in -next, so...
> > 
> > I did, but then you said something about duplicate commit IDs? I thought
> > that meant they were going through your tree.
> 
> Huh?  Same patch applied in two trees => problem.  A tree pulling a branch
> from another => perfectly fine, as long as the branch pulled is not rebased
> in the first tree.  So something like "I have a patch your tree needs,
> but I might end up doing more stuff on top of it for my own work" can be
> solved by creating a never-rebased branch in my tree, with just the stuff
> that might need to be shared and telling you to pull from it.  After that each
> of us can ignore the other tree.  No conflicts in -next, no worries about
> the order of pull requests to mainline...

I'm confused about what rebasing has to do with this?

I was assuming the patches would take the same route into Linus's tree
as into -next, that just seemed simplest to me; I'm completely fine with
either taking them into my tree or you sending them directly, I'd
already looked at them.

Or was the issue that they were in your -next branch because you had
other stuff on top of them, but you still thought I was taking them?

