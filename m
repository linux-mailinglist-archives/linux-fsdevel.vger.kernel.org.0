Return-Path: <linux-fsdevel+bounces-28141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785796745F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 05:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD669B21A73
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1B2D058;
	Sun,  1 Sep 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZdsiKNQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361833D8
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160800; cv=none; b=KNextCNRwsg8MzAlB65qrT7Woc6yBvBdhCuL7qFc9mDBjKFWby1G5UwRBUHUFgeVjnoS/jeqSf4EFToeITwOzGMECW7Sw5Qcy2BFfjQnWjK0GvKOxLekWplTQGM8hgD/iLkHFk5zKmbv2pqLGQI/kFzHlovNTNkJmZ5vEOlMjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160800; c=relaxed/simple;
	bh=eEKGFPZn+mcvIGbGPKW//84loGAn38n7uJhvNjUO5ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q10i+b8dSf/eqtInislLaGX6m8TLKDOsoqJlc3W0Kitl3LsP2JPhSWRJPWo9woChclKLbco2fT5nNygz6NcR+xdhhF231kDuJNXdM2V2sJTuJu/K91eNEQG/Yt4dUiKDuBlYar2TpPNpu70uZsniECIgCeXkYitX+Fsw0XQ/bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZdsiKNQD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 23:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725160795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onyCyY/fDcRq738DRxbYc5Iqor6psTXLWoZNQ3KP0j8=;
	b=ZdsiKNQDQATjq/p7UZIVTAOBXfBujpGNstsWH+vp3D0GdmtgbEA9ElTAvslot63NBBkA1D
	tvaagau6Y1uwH1ksnhrl0veB4T3jC2mb3QLbux5gXj2eSdLhFy9I7kKG7Edx9gL8nYRjsT
	bWTyJ0rxB58incJVq+VHO2SzVcPOnOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
Message-ID: <5q6h447wzxlskkvgygm3xb2tasbbgmmtxsxd6m4jtygpwsf47b@hxdqfn3nxqzo>
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 01, 2024 at 03:13:39PM GMT, Linus Torvalds wrote:
> On Sun, 1 Sept 2024 at 14:44, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> >   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21
> 
> Hmm. Your git host is often slow, but now it seems to be even worse than usual.
> 
> I blamed my phone hotspot at first, but everything else is fine.
> 
> evilpiepirate.org takes a few minutes, and then I get a "Connection
> reset by peer" error.
> 
> Maybe kick that machine? Or even just use something like a github mirror?

odd, everything looks quiet on it, but it was acting funny earlier today

I do have a github mirror though: 
https://github.com/koverstreet/bcachefs/ tags/bcachefs-2024-08-21

