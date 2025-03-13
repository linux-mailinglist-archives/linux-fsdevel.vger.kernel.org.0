Return-Path: <linux-fsdevel+bounces-43904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3949A5F99C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C252D19C3E18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663022690C0;
	Thu, 13 Mar 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjQzFTK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823E268C7A;
	Thu, 13 Mar 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879186; cv=none; b=o4fFjKB4uI3BuuMIeUT1i71FeQxG+hK2sDNJGeHjOIpqel7uP/N41O5Hp997KUWeyyY+k7u70J2bMF7jYnqC52Q/SP8OO6H7eeIGWJjAMhETTV5bTga6L0AOaAfG3nC+eh4If3XhAR9dZVcnPwbjWbIE/2WABnh+/g9HrQcQCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879186; c=relaxed/simple;
	bh=UZl2eySzgvti4sdsWwp2Dk/0CKN1XppUcUujjzMHwNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl/CukD1TK81KdxhC01uFeco2Ic5WWG9P2lH25ONWxiNL3bkotBsNEUhlvEgMJSzFguYCCR8YvA4DVBfZLrOmUZwi+fqyxDUbz5dou+GTy1m02G/uecv/bdCLul2q+RZ11kLcCKbYdTwG2PwDmKRxeBaqkGwC4XTwwLN8VR3gGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjQzFTK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF1EC4CEE9;
	Thu, 13 Mar 2025 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879186;
	bh=UZl2eySzgvti4sdsWwp2Dk/0CKN1XppUcUujjzMHwNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjQzFTK3CGSGmVT3D0g6Eid4TfdOW4xp1sfycRsShneM2wAqc1EZD2HgLz8LIhASA
	 WhvKTbrTd5WtGKCD0tmzqToIGXYiXr0hiZu/EzvhFzURTx7mJWF1GFn94fzAnt2za0
	 7wqVoY3Mtv5brmZRMoVSPqJt/SWkpvjuFdOT7sPwCBBZB6FHxIFVp5RmzoqCt/qrYZ
	 WVBsxP2zuZj2DjXHmR5g0iwwfd6wdtxnpdQtWhNqmk20BW9BBFRBzFY26y/NGy29le
	 awxoUW+Qy/rxPwXHF8yPYo+IocHX46L+iYtlz6yw00aSi0j5hjN7T5/SAW0MgCZPr2
	 /SDUA2TwdVwPw==
Date: Thu, 13 Mar 2025 16:19:40 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ruiwu Chen <rwchen404@gmail.com>, corbet@lwn.net, 
	keescook@chromium.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <t3h7ciq4vn3uqwfgroisfkrh7xymgr6hlnsgyutwi2azkbuhcz@yu5c4xyzi32f>
References: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
 <20250308080549.14464-1-rwchen404@gmail.com>
 <zaiqpjvkekhgipcs7smqhbb7hqt5dcneyoyndycofjepitxznf@q22hsykugpme>
 <Z9IQ2jam9hkXnPhg@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9IQ2jam9hkXnPhg@bombadil.infradead.org>

On Wed, Mar 12, 2025 at 03:55:22PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 10, 2025 at 02:51:11PM +0100, Joel Granados wrote:
> > On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> > > >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> > > >> but there is no interface to enable the message, only by restarting
> > > >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> > > >> enabled the message again.
> > > >> 
> > > >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> > > >
> > > > You are overcomplicating things, if you just want to re-enable messages
> > > > you can just use:
> > > >
> > > > -		stfu |= sysctl_drop_caches & 4;
> > > > +		stfu = sysctl_drop_caches & 4;
> > > >
> > > > The bool is there as 4 is intended as a bit flag, you can can figure
> > > > out what values you want and just append 4 to it to get the expected
> > > > result.
> > > >
> > > >  Luis
> > > 
> > > Is that what you mean ?
> > > 
> > > -               stfu |= sysctl_drop_caches & 4;
> > > +               stfu ^= sysctl_drop_caches & 4;
> > > 
> > > 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> > > This is what I originally thought, but there is uncertainty that when different operators execute the command,
> > > It is not possible to determine whether this time is enabled or turned on unless you operate it twice.
> > 
> > So can you use ^= or not?
> 
> No,  ^= does not work, see a boolean truth table.
> 
> > And what does operate it twice mean?
> 
> I think the reporter meant an "sysadmin", say two folks admining a system.
> Since we this as a flag to enable disabling it easily we can just
> always check for the flag as I suggested:
> 
> stfu = sysctl_drop_caches & 4
Thx for the clarification.

I see what is happening:
Once you turn the message off, its off for ever because of the or.
Removing the "or" allows turning the message on off based on the 4th
bit.

I'll take your fix @Luis

Thx.

Best


> 
>   Luis

-- 

Joel Granados

