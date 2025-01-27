Return-Path: <linux-fsdevel+bounces-40166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D72A2009A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC7162463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69F1DB548;
	Mon, 27 Jan 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEVKkmLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3394198851;
	Mon, 27 Jan 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017140; cv=none; b=Yn3WxZ8/kjXILh+zr7etYbNuGaBwFhvhi8G9+WP7b1r8UazfQv/Js49re5sNVyh9f9OE/akiiwu9HWr1WVzHMO3AmytLK3GPSDcoNt1E4F0sk706PNinY2dvbgGqYlMVIcu85mo+/7ScLFCtjhJnVO3Rl1znFq7boZW3vvHLFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017140; c=relaxed/simple;
	bh=rPz+oWiqCTa1Srd9iencBF/k85bBjy7ORTGTgsWncBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+73uSiF/p1GHn2RBIq3G5rbUqVwb1+Uola22byZOdlXimxSgu6SnKmF3ZjbJFiEID+4c5O8nf67oyNgHhCs5b85nnH9TqLDjU3Y/PHkMN16OtnbUkI02WerKu/Rz2mFlGRQD2odNneonmT2ffFrrUaEIrADlh1Pqvrol9AIz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEVKkmLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F241DC4CEE0;
	Mon, 27 Jan 2025 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017140;
	bh=rPz+oWiqCTa1Srd9iencBF/k85bBjy7ORTGTgsWncBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEVKkmLdjGW0DP1gROGGLc3nZ+sMW10l20k/qaB+ZR8ipFofSHpJqB6Sp1X+Hdj8p
	 1UnbJHu9UuSfGNhu215k+IFYDI+QoVqmhK6q0i692emQ3HYvgUCR9L+xHcEnVpbnet
	 dZr6q0tzMw9y7AdITRaRpC/7PjD+Iop33pnMN7uSw0bj6Xa1OJ5vdx4kkgEspxVyCz
	 0GlNrkVEzhXpFrClfaYP4mj7usfXsnF9AI1tRFlYHIP5siwL+accks1VLWHQ8RVXfh
	 0kKh2vsBdQCa4dRuzgyZCeL5GZTwpRhzLcVQ2Rk5FRtqPMJqJZ+/3trRnmj1ozeNlj
	 ZLqITpzeU+o8g==
Date: Mon, 27 Jan 2025 17:32:18 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kernelci@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkft@linaro.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <Z5gJcnAPTXMoKwEr@lappy>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>

[ Adding in the LKFT folks ]

On Mon, Jan 27, 2025 at 08:38:50PM +0000, Mark Brown wrote:
>On Mon, Jan 27, 2025 at 11:12:11AM -0800, Linus Torvalds wrote:
>> On Mon, 27 Jan 2025 at 09:19, Sasha Levin <sashal@kernel.org> wrote:
>
>> > With this pulled on top of Linus's tree, LKFT is managing to trigger
>> > kfence warnings:
>
>> > <3>[   62.180289] BUG: KFENCE: out-of-bounds read in d_same_name+0x4c/0xd0
>> > <3>[   62.180289]
>> > <3>[   62.182647] Out-of-bounds read at 0x00000000eedd4b55 (64B right of kfence-#174):
>> > <4>[   62.184178]  d_same_name+0x4c/0xd0
>
>> Bah. I've said this before, but I really wish LKFT would use debug
>> builds and run the warnings through scripts/decode_stacktrace.sh.
>
>> Getting filenames and line numbers (and inlining information!) for
>> stack traces can be really really useful.
>
>> I think you are using KernelCI builds (at least that was the case last
>> time), and apparently they are non-debug builds. And that's possibly
>> due to just resource issues (the debug info does take a lot more disk
>> space and makes link times much longer too). So it might not be easily
>> fixable.
>
>They're not, they're using their own builds done with their tuxsuite
>service which is a cloud front end for their tuxmake tool, that does
>have the ability to save the vmlinux.  Poking around the LKFT output it
>does look like they're doing that for the LKFT builds:
>
>   https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27027254/suite/build/test/gcc-13-tinyconfig/details/
>   https://storage.tuxsuite.com/public/linaro/lkft/builds/2sDW1jDhjHPNl1XNezFhsjSlvpI/
>
>so hopefully the information is all there and it's just a question of
>people doing the decode when reporting issues from LKFT.

My understanding was that becuase CONFIG_DEBUG_INFO_NONE=y is set, we
actually don't have enough info to resolve line numbers.

I've tried running decode_stacktrace.sh on the vmlinux image linked
above, and indeed we can't get line numbers.

-- 
Thanks,
Sasha

