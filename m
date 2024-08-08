Return-Path: <linux-fsdevel+bounces-25423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B294C03B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB641C21DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F2BE68;
	Thu,  8 Aug 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhjTs1XV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665014A33
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128647; cv=none; b=IbS17rCEi0ry5ezn8s4Gem8YNJh7M89vs+9UxeG8wHbyCWScQpaII/NguPcoomJpLW1+Tv+Y7Kr+OJcEJXEtLVACIoOtS4N0sP6WHzXlmN3yOAffGzQUZcKoQnp9z7Z2pS70O0QyTItvdzHB2fdlzj+d9mg6wwHPIPsYSeJ5R94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128647; c=relaxed/simple;
	bh=zsX4FSm0wff47Ut+4fish5vP2KPfGbm+he1I5exMnP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taYZG+49XB/0mPkWFVbN2oO4peuE3D3RhJ3SA3NlUlwxr9r4u7WPh9T4TrpYF/XIf/D0Tk7h4cYydsxtY9LmARDkOetPFn9R83i1OFuwUXueKZfmnC1wTcHg9edAG7/P3lDsjyIVrgXVcltPe8/NIiGard6a5dkGuX+2TePLcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhjTs1XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453DEC32782;
	Thu,  8 Aug 2024 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128646;
	bh=zsX4FSm0wff47Ut+4fish5vP2KPfGbm+he1I5exMnP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhjTs1XV1XURUa37IVenwvFZVuZiZVxsEHgIM06OYPbu9q311LDRy09Ws1662ZNYY
	 7PYDE1RLipTgQvXmakLjjR1PGBKjEtkcvKSVW3b13RA2O+BDpw3PvUrgN5faHyl6EZ
	 MGUMV6Ny2vwvYb8cQeaTIOi++/ohABTAq5S1QpV7rvCx60HW+f6+RyxAiwx72zhDTu
	 3oQSdaVeWBYfZpz4vGoPbD6UWewdoksKpgpmItwwsSuWc2TgWKlNsLfOL78JVK71Sb
	 Qy1l2DGQKQLdLFJk6BROkhsd6SUkyLdvg/HryLu19ZVZbE44lyPx64vdR43YuvyPQr
	 Qiu/x9pfuoXmg==
Date: Thu, 8 Aug 2024 16:50:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 06/13] fs: Drop unnecessary underscore from _SB_I_
 constants
Message-ID: <20240808-gegolten-dehnen-3a19a0e67edf@brauner>
References: <20240807180706.30713-1-jack@suse.cz>
 <20240807183003.23562-6-jack@suse.cz>
 <CAOQ4uxhhzFZy-QBrwhRWubRm75Uw_sx92OZv3gp1bV-MTWwYPA@mail.gmail.com>
 <20240808143505.GB6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808143505.GB6043@frogsfrogsfrogs>

On Thu, Aug 08, 2024 at 07:35:05AM GMT, Darrick J. Wong wrote:
> On Thu, Aug 08, 2024 at 01:47:20PM +0200, Amir Goldstein wrote:
> > On Wed, Aug 7, 2024 at 8:31 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Now that old constants are gone, remove the unnecessary underscore from
> > > the new _SB_I_ constants. Pure mechanical replacement, no functional
> > > changes.
> > >
> > 
> > This is a potential backporting bomb.
> > It is true that code using the old constant names with new macros
> > will not build on stable kernels, but I think this is still asking for trouble.
> > 
> > Also, it is a bit strange that SB_* flags are bit masks and SB_I_*
> > flags are bit numbers.
> > How about leaving the underscore and using  sb_*_iflag() macros to add
> > the underscore?
> 
> Or append _BIT to the new names, as is sometimes done elsewhere in the
> kernel?
> 
> #define SB_I_VERSION_BIT	23

Yeah, that's better (Fwiw, SB_I_VERSION is confusingly not an
sb->i_flags. I complained about this when it was added.).

I don't want to end up with the same confusion that we have for
__I_NEW/I_NEW and __I_SYNC/I_SYNC which trips me up every so often when
I read that code.

So t probably wouldn't be the worst if we had:

#define SB_I_NODEV_BIT 3
#define SB_I_NODEV BIT(SB_I_NODEV_BIT)

so filesystems that raise that flag when they're initialized can do:

sb->i_flags |= SB_I_NODEV;

and not pointlessly make them do:

sb->i_flags |= 1 << SB_I_NODEV_BIT;

