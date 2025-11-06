Return-Path: <linux-fsdevel+bounces-67395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E4C3DCFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118F24EEBAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077B3559F9;
	Thu,  6 Nov 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6Iah58g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD4350A3A;
	Thu,  6 Nov 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471225; cv=none; b=OKiH+dETLcsZvl7D+OschKhlVHaIqTtp82YXeMMrJYDCHb8kyvHgAbP1Lf6UC48N9p8tAT4qMohhZzc3/c4MVSUiHM3L5GKbs+uE5ugq9qaWvFDTryP+wEBN1lSBGlAXC+z9t9r8rZ9oxg3Kl9mysyNDQX8eVaLbiGn9hCg6sRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471225; c=relaxed/simple;
	bh=si2FyGZi7I6QK+vTqadl0v27WKE++e4h/95VGkk7bmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQSIDYVeXVoC4MKAQXRWbTAgKiaankJrKzSi/GWJR6ipVLQU2NemGPwgvlF3boQ0TkwVMhJD0v7HJOcJLDCh/AuJYgkKH3Q80BThYbGojYggJXSCXcSKLU8aSQRwQhxmWXiCvPTAIJBadvZbLtOfGakhDEvKcyOW5l1hZmiQky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6Iah58g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60801C113D0;
	Thu,  6 Nov 2025 23:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762471224;
	bh=si2FyGZi7I6QK+vTqadl0v27WKE++e4h/95VGkk7bmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6Iah58gRrfZZjXrGmbBxiokjKbP2xsXvW0zIlsksJC+RFWZqcAC3YwY1SeEp3O70
	 Trbk3xKhs0JctrCl3TTEjo6fXTjEAVtmaoM5o+UmWLYz7dyRdMQ7ps07aCkWsPi9yZ
	 xIbH5PYWSoMPuIKkPEuVnF2JIbJOyjL6CS7RMN0LUayXGB+2RiAcx8w0OaqhvvlLdh
	 MHxRmElbgUjYxF/i0ppR3TEQOpbfPxTh/XmztN29y8ceVIVOKnRv2Fb9SVOewVN37Z
	 3w1+czAVmISwbPDPb1HL1Lc53YU4ydM6/m6iNPsj/bQ4PceNjVW/YBjMJcZ6dy6Bha
	 mw9AvYMge9FNg==
Date: Thu, 6 Nov 2025 16:20:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251106232019.GA4095629@ax162>
References: <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
 <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
 <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
 <20251030172918.GA417112@ax162>
 <20251030-zukunft-reduzieren-323e5f33dca6@brauner>
 <20251031013457.GA2650519@ax162>
 <20251101-bugsieren-gemocht-0e6115014a45@brauner>
 <20251101163828.GA3243548@ax162>
 <20251106-kabarett-auszuarbeiten-f8c855a4ff4c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-kabarett-auszuarbeiten-f8c855a4ff4c@brauner>

Hey Christian,

On Thu, Nov 06, 2025 at 11:09:25PM +0100, Christian Brauner wrote:
> On Sat, Nov 01, 2025 at 12:38:28PM -0400, Nathan Chancellor wrote:
> > On Sat, Nov 01, 2025 at 02:10:42PM +0100, Christian Brauner wrote:
> > > I'd like a stable branch before -rc5, please.
> > 
> > Sure thing. I have sent the change out for Acks now:
> > 
> >   https://lore.kernel.org/20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org/
> > 
> > I will finalize the branch by Thursday at the latest and ping you when
> > it is ready.
> 
> Any status update on this?

Did https://lore.kernel.org/20251106174752.GA2440428@ax162/ not make it
into your inbox?

Cheers,
Nathan

