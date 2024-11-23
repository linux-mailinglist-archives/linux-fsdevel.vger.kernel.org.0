Return-Path: <linux-fsdevel+bounces-35634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD229D68F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B793281CEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B918A6AB;
	Sat, 23 Nov 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE+xtvoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05C14F9E9;
	Sat, 23 Nov 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732363579; cv=none; b=cd7mOFhaRWdJ7GVg5HsHgq1GBehmIh5VnvT9pt4wK0zdAwFvutpkaEatirNFiVEtv30/GmmDWQTvUKLBB9JJZWE+E8r/bVA3146z1nbMgYdt8JULs0ab3kLSukBd9pZtaIgyePBIn5ANpRxPThfCLMI1QfsWsTnwqIxpucCKK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732363579; c=relaxed/simple;
	bh=tBMvMn07vHvdrtKWdPHOHNiRzfkJYZW/11LSRAHpRsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fppxT6HtAy8mbl6ZHodHBE3v703jbGPr3b9gAXVjPQ5xSzynYftkGj1R+R5HechOh1N+5yvFxelwesiV264fThvmqhbjIU53zy2IshrzHyIbKOTAfeomnxKZQIKRnU3jt7u9K/MT8ZQ6w3e6wjcs+8QjLxGDYkfFQLn6hTj0kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE+xtvoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B846C4CECD;
	Sat, 23 Nov 2024 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732363578;
	bh=tBMvMn07vHvdrtKWdPHOHNiRzfkJYZW/11LSRAHpRsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RE+xtvoZbNTUdhqSJExq/hRlUT2grJTTODqlC62AvsoUuzMZbPZ6mHQnouB3R6d4c
	 HV6jmyNq9jgtsRMXgV3swxxDuwXvWjYnTLdYOG/IydAs2dp+OWOwEbRBV/p/WEEdTe
	 Wi66dO9bwrzQjL7Xt6ZOdIhuWrGUwv2/QcCSNsSODUTr9X64tcI1jqzaQzfwLcxn7z
	 h0uU99UGf01f6zO+PY22rlfMEf2SpGAejftGam0c7GW2Uqe3FvDn15wgkTc2YSa9Hn
	 S+aCJdbuU4ke9MyOlNBta/sK0wHZW43AxVQPiJI1I8DooBYOc+6jibLtM+G5hDqOR5
	 HWShpgq7yziUQ==
Date: Sat, 23 Nov 2024 13:06:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs updates for 6.13
Message-ID: <20241123-bauhof-tischbein-579ff1db831a@brauner>
References: <20241122095746.198762-1-amir73il@gmail.com>
 <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>

On Fri, Nov 22, 2024 at 09:21:58PM -0800, Linus Torvalds wrote:
> On Fri, 22 Nov 2024 at 01:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > - Introduction and use of revert/override_creds_light() helpers, that were
> >   suggested by Christian as a mitigation to cache line bouncing and false
> >   sharing of fields in overlayfs creator_cred long lived struct cred copy.
> 
> So I don't actively hate this, but I do wonder if this shouldn't have
> been done differently.
> 
> In particular, I suspect *most* users of override_creds() actually
> wants this "light" version, because they all already hold a ref to the
> cred that they want to use as the override.
> 
> We did it that safe way with the extra refcount not because most
> people would need it, but it was expected to not be a big deal.
> 
> Now you found that it *is* a big deal, and instead of just fixing the
> old interface, you create a whole new interface and the mental burden
> of having to know the difference between the two.

> So may I ask that you look at perhaps just converting the (not very
> many) users of the non-light cred override to the "light" version?

I think that could be a good idea in general.

But I have to say I'm feeling a bit defensive after having read your
message even though I usually try not to. :) 

So just to clarify when that issue was brought up I realized that the
cred bump was a big deal for overlayfs but from a quick grep I didn't
think for any of the other cases it really mattered that much.

Realistically, overlayfs is the prime example where that override cred
matters big time because it's called everywhere and in all core
operations one can think of. But so far I at least haven't heard
complaints outside of that and so the immediate focus was to bring about
a solution for overlayfs.

The reason the revert_creds_light() variant doesn't return the old creds
is so that callers don't put_cred() them blindly.

Because for overlayfs (and from a quick glance io_uring and nfs) the
refcount for the temporary creds is kept completely independent of the
callsites.

The lifetime is bound to the superblock and so the final put on the
temporary creds has nothing to do with the callers at all.

