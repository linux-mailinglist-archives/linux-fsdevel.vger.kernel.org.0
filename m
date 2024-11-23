Return-Path: <linux-fsdevel+bounces-35652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DF9D6ADD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A25161AF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C03FC7;
	Sat, 23 Nov 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrMgvjTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EB22301;
	Sat, 23 Nov 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387649; cv=none; b=cp+0zWKpcF6ivC3YsYXHe6bNrC5MvnUPxBMZlQue5KyklohHgmFlxFrNt8JuaMtV+rI+s69BRCrA3mER1x+CD8sIT7nI8u+u82owqoWbERRKWPAlpFva6YTuPeVmrs/eJUfyI2OnduXCtvNQkH2SsveLQ+Go6H3UlN2a5a9/ySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387649; c=relaxed/simple;
	bh=BSv4aD9d5H9bVWz+JcZvftPNCXHFcxmKlQmYiEoonkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDJ8FmSboEp3C1YNMISd1JdR5V4WSR0y5NgLPBlxTPZC8AlYQtQtdbYrgUmZUIxf+hM8nyuzzkFVQ5hx70GD7aL7WRAhK2vQ/n0lQ5lt6tMxvMs28Qm+Id7UE8rsxGBJ108Mu33rAF56R1VfDxZpy6BsI4nbwHOclZYtbjITvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrMgvjTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EDC4CED0;
	Sat, 23 Nov 2024 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732387649;
	bh=BSv4aD9d5H9bVWz+JcZvftPNCXHFcxmKlQmYiEoonkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrMgvjTQiW24jgTEn9nVCrQBKcdxUNzOADK7GdxSDy3abNOQ+r2W/3iiVPmu50xze
	 HHlzBXLn5gI3V0o9TuUOhAHF0bqs42FA6vr5ylJnuIsneueM7MA13nr6fSW6euaPIP
	 o4Y9OF7Cw2PC0UJikWim7xnga0PXhhZWnbu0vTVFQ9RSiopZDpAZR2JKZLPTmdK0eu
	 iqDFnkEjBHfXhLuDm7NWX43SdCqrytkRDYxjHRM3wy4gZO+yOGnwFeE0fGj3aS31Js
	 Dg9nwAoOIp/m7nYpu/wFMGgGcJqE3+d4tHtT53+qBEELZ7jaPfmlYz33EdIF11HqAr
	 68HqgYYfRsc/w==
Date: Sat, 23 Nov 2024 19:47:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs updates for 6.13
Message-ID: <20241123-wortreich-eistee-542b69311fba@brauner>
References: <20241122095746.198762-1-amir73il@gmail.com>
 <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <20241123-bauhof-tischbein-579ff1db831a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241123-bauhof-tischbein-579ff1db831a@brauner>

On Sat, Nov 23, 2024 at 01:06:14PM +0100, Christian Brauner wrote:
> On Fri, Nov 22, 2024 at 09:21:58PM -0800, Linus Torvalds wrote:
> > On Fri, 22 Nov 2024 at 01:57, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > - Introduction and use of revert/override_creds_light() helpers, that were
> > >   suggested by Christian as a mitigation to cache line bouncing and false
> > >   sharing of fields in overlayfs creator_cred long lived struct cred copy.
> > 
> > So I don't actively hate this, but I do wonder if this shouldn't have
> > been done differently.
> > 
> > In particular, I suspect *most* users of override_creds() actually
> > wants this "light" version, because they all already hold a ref to the
> > cred that they want to use as the override.
> > 
> > We did it that safe way with the extra refcount not because most
> > people would need it, but it was expected to not be a big deal.
> > 
> > Now you found that it *is* a big deal, and instead of just fixing the
> > old interface, you create a whole new interface and the mental burden
> > of having to know the difference between the two.
> 
> > So may I ask that you look at perhaps just converting the (not very
> > many) users of the non-light cred override to the "light" version?
> 
> I think that could be a good idea in general.
> 
> But I have to say I'm feeling a bit defensive after having read your
> message even though I usually try not to. :) 

It was just pointed out to me that this was written like I'm not reading
you messages - which is obviously not the case. What I means it that I
usually try to not be defensive when valid criticism is brought up. :)

