Return-Path: <linux-fsdevel+bounces-30266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AB988923
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C0A1C21C5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01E18BBB4;
	Fri, 27 Sep 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la7zY3IE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C65234;
	Fri, 27 Sep 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454869; cv=none; b=qMdNWADtCN5kOc54wApC+6g3MDap1YUtd2F7p/c3xJQlREemWh1LWsqZed0kXrLxugAa5DdHi8eeOAeCzvqSKc4935GQWwAD8Gm60eLLtUVsezKmI9JNQeEUlQJ8/B1Z41+U3Na0P2sPWOfadLYylrSkww4k5S3ZJXzYztgbSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454869; c=relaxed/simple;
	bh=7DDTinGb7nmAWwbihCnhc6k+tp9wXuunS12NbGMRcLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Yml89leKvh6j5h0UqHEPf8eqRTuVQIHngYS9vkSb9uBqWXycn+cw4eTWx6CkPZE2KnOGXCgW/INMxWk7dGMV3ng6dIW3PlFITiT4G2uHdglaNjrDawvuW5xwzIkxZE4EmiAwRzYx/cy/zNT1gPuTVu8e0S6SD8ZVqfYRBRICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la7zY3IE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145CC4CEC4;
	Fri, 27 Sep 2024 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727454868;
	bh=7DDTinGb7nmAWwbihCnhc6k+tp9wXuunS12NbGMRcLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=la7zY3IElbh/7JA8V9X+L8G/dp26TrM145VxTO7lQKDljVBCqrzaJSw2HoNSRkPve
	 7VpeLnx/hXanwytR09kCJuY/7krhmDJLW+jFo4pmQ7DLI+16IqLY2gtqVVXWg1j1FA
	 pjUvhTkBAShB9gkk8UxNmS5LLwrvCrtJVbUq4xFmFgwNYWrTeU9uW4Z+pjXlICF4kM
	 VnvBD/j+G2gNkk0N7WC2fS73bCfIJWD9IKu0I0BxNfKtIqBKxidd0C88kpxmajMFlh
	 aOiFsxQyIZohMpQH30QL5xkt1EcujFRhhHVnkD9JigjLmmZXOGSSO4xL08CkjuOOXV
	 r15TyVgjbiwIA==
Date: Fri, 27 Sep 2024 19:34:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Message-ID: <20240927163423.GG967758@unreal>
References: <20240926174043.GA2166429@unreal>
 <20240913-vfs-netfs-39ef6f974061@brauner>
 <2238233.1727424079@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2238233.1727424079@warthog.procyon.org.uk>

On Fri, Sep 27, 2024 at 09:01:19AM +0100, David Howells wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > Do you have fixes for the following issues reported for series?
> > https://lore.kernel.org/all/20240923183432.1876750-1-chantr4@gmail.com/
> > https://lore.kernel.org/all/4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com/
> > https://lore.kernel.org/all/20240924094809.GA1182241@unreal/
> 
> I'm working on a fix for the third one at the moment, I think it's the read
> version of the write fix I posted previously:
> 
> 	https://lore.kernel.org/linux-fsdevel/2050099.1727359110@warthog.procyon.org.uk/
> 
> I'm looking to see if I can make a general solution that abstracts out the
> buffer handling for both as we're early in the cycle.

I hope that you mean that we have plenty of time before the merge window ends.
Otherwise, it will be very inconvenient to open official -next/-rc branches,
based on -rc1, remembering to revert so many commits.

It is better to have fast fixes and then work on improving them without
worrying about time frames.

Thanks

