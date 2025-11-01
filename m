Return-Path: <linux-fsdevel+bounces-66665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0BCC27EE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2631A1A21FA6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25C2222C0;
	Sat,  1 Nov 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjT/Z/op"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1F1B86C7;
	Sat,  1 Nov 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762002647; cv=none; b=mWErflsGKYUlDv0g3GJOLxOTpbun+mHx5OE/lofoMk4nK6R/Hj0LHqVIQJQxm3C7JIRuIK5guHhGFJTuxD1iH9SsAphQ8b5qebfpRNkvuqPduQdL+XXNx/3jTcd0f8MZufL2WQqzuYTSL3Ct7HROck2PbD6sO9cvZ3hIhjB+pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762002647; c=relaxed/simple;
	bh=E344S8+1QRn521QovyCsMxpgRFO6Ptgyc0Tz/4QqK8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRcAW6y7KrIHQa1q5J0sZC1zRRciTZbNe0MDF27HN3E+9TTRjpdo4XhwNDyHwTIWdowNOMje0Cf+V3NIAKfec26oTQdH0med6VVERQwKZEqDs5krjlAivkIE686ehP0MWcJeKgzX8ueC6kcgFD8O0LJO84ULLws0gE65YcjABA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjT/Z/op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ED4C4CEF1;
	Sat,  1 Nov 2025 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762002646;
	bh=E344S8+1QRn521QovyCsMxpgRFO6Ptgyc0Tz/4QqK8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjT/Z/opVGfVr4F4Wclj1iqAhu4ykoa4Yaaxd7zIFjwL1SYIT5QzSnscf/EJdd8Rj
	 YN8rXYZhn/6r0H0w/aXVE295papxyNTLWdwtdTcnukL+4CNroA8Y0Ppij/9Q5k7txo
	 CIVZCKb5j2j7/QQWG11fIIsUnlyX3yOsZWN/DUEbk9PJNnX0gPCKt+imp1MezAOMax
	 lw68wPqHGmCex+hMbsKuXecKlMl658L6dXuDjFndhJtHN+vZ8r4bKN79nLpV6Jqq78
	 1922RHwU1LmLYS4fDaVoU/kciVgf5qok0gA/i8KuVKD+aZg2ax6IAHq7pj5nm7ZiWD
	 4pjudhk5R/32w==
Date: Sat, 1 Nov 2025 14:10:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251101-bugsieren-gemocht-0e6115014a45@brauner>
References: <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
 <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
 <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
 <20251030172918.GA417112@ax162>
 <20251030-zukunft-reduzieren-323e5f33dca6@brauner>
 <20251031013457.GA2650519@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031013457.GA2650519@ax162>

On Thu, Oct 30, 2025 at 09:34:57PM -0400, Nathan Chancellor wrote:
> On Thu, Oct 30, 2025 at 09:16:02PM +0100, Christian Brauner wrote:
> > On Thu, Oct 30, 2025 at 10:29:18AM -0700, Nathan Chancellor wrote:
> > > There are several other places in the kernel that blow away
> > > KBUILD_CFLAGS like this that will need the same fix (I went off of
> > > searching for -std=gnu11, as that was needed in many places to fix GCC
> > > 15). It is possible that we might want to take the opportunity to unify
> > > these flags into something like KBUILD_DIALECT_CFLAGS but for now, I
> > > just bothered with adding the flags in the existing places.
> > 
> > That should hopefully do it. Can you update the shared branch with that
> > and then tell me when I can repull?
> 
> I have applied this as commit e066b73bd881 ("kbuild: Add
> '-fms-extensions' to areas with dedicated CFLAGS") in the
> kbuild-ms-extensions branch. I may solicit acks from architecture
> maintainers but I would like to make sure there are no other surprises
> before then.

I'd like a stable branch before -rc5, please.

