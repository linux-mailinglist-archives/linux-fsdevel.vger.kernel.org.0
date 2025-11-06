Return-Path: <linux-fsdevel+bounces-67386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553EC3D8BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 23:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BF3BAA51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56530BB87;
	Thu,  6 Nov 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjNah95k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8542E543B;
	Thu,  6 Nov 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466971; cv=none; b=Fc6Z1PZUb8KygV04qBKypTeaxl8+V/Sk5R/6xZjaT+jEDgAqVSL47cusNOPODzRiUUVCzhJSaUoB2Z12h/RjSGYG6F6Rym2gIRyYaO41vPmVaxvDK8NKespHplR/9WehwgPOW+yfOwYCupCKsdJbJgRXg+JIUGmCJb79a3mA7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466971; c=relaxed/simple;
	bh=6nUtpfUvSVYLNR95cAiF2JZ+F5KYkzShMbZ84soSRgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHup5RKSURMjQZrIRRJTaDlU8IatryS4GOGRKXhZW+RNtecfZYkWQVU5O3KURadwdixKI6b6YMwsoP/PwNDIeP+j11KxnYajo1OpmHq5YAnIQEwCb91Q7kSM0/IqEbYpl6HI5mo8JvOwhI3KdQcQwR8EgnErC8Bh85z2OUslg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjNah95k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844AAC116C6;
	Thu,  6 Nov 2025 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762466970;
	bh=6nUtpfUvSVYLNR95cAiF2JZ+F5KYkzShMbZ84soSRgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjNah95kMLVjAIF4yYAjthcBh6Vxi0dQOOY+UJhpeafwWjYvkwXAgQX0QjR3Q1Yo7
	 o6nXXgLY+kMLz2P55ogReaa5yzJVXNceazBP3IeZQoS2qc3XUmy9roCV+ExPnSOBhB
	 EeJ+wAjNX1WnzTxTdolCGk6MkQCG58MQkHMvrvgVXinrk8sVVTPaoozdwyfXs+0qKd
	 CA7rqEvHuYK/wW4W2/kGxTyfjWUZh3z0E4djEc3ZN1Alr2h+fCgWynbamAz/O4aJZ2
	 4Ovl7siGO7ry8UcqzIon1QbX0EogGTF+CSWIMgQRJRd8zxFaDTQeU8CV3dnU5K4XCi
	 ZJGIasVV69rYg==
Date: Thu, 6 Nov 2025 23:09:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251106-kabarett-auszuarbeiten-f8c855a4ff4c@brauner>
References: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
 <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
 <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
 <20251030172918.GA417112@ax162>
 <20251030-zukunft-reduzieren-323e5f33dca6@brauner>
 <20251031013457.GA2650519@ax162>
 <20251101-bugsieren-gemocht-0e6115014a45@brauner>
 <20251101163828.GA3243548@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101163828.GA3243548@ax162>

On Sat, Nov 01, 2025 at 12:38:28PM -0400, Nathan Chancellor wrote:
> On Sat, Nov 01, 2025 at 02:10:42PM +0100, Christian Brauner wrote:
> > I'd like a stable branch before -rc5, please.
> 
> Sure thing. I have sent the change out for Acks now:
> 
>   https://lore.kernel.org/20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org/
> 
> I will finalize the branch by Thursday at the latest and ping you when
> it is ready.

Hey Nathan!

Any status update on this?

