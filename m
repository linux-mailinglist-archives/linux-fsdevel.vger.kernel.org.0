Return-Path: <linux-fsdevel+bounces-63382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D6BB766F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE4324ED763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA76288C0E;
	Fri,  3 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYnpt0QV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C813AD05;
	Fri,  3 Oct 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506729; cv=none; b=M9cNa80t9J0/vE+V7M+HXgR0yeiRP0dA9ZNRYdCctNgb3tVIMba2+86FCGEGzaKjR3EIeoOxQm09dq/A+M5iiuNWP37GEcg1M6X5aGwUDwlD1M8zBr33bPcCazTrWT7kibX+jKM+gmHctLwBZ1hx/EFuFH8TUOkR6zryaTybLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506729; c=relaxed/simple;
	bh=3W/B7yr0TP3RVj4O6JgUMcihRtNr2fM0e+nfFmSLnXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQZ35FqAc0f+SHqEL9xr7Fm1NGWcLyX+7LfK1y0yWEdKLbEedbEOVFy/HVRVHzC7BIToh05e5FqkRtXvurFfQ1qm/4TP2qyXiVPk1TvpJ0RJbe98spifZFiCRyF9DOUxjpajdeKZ53aopqKL0jjzG4LEgZ1N2ibFmpYz1uMVJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYnpt0QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46554C4CEF5;
	Fri,  3 Oct 2025 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759506729;
	bh=3W/B7yr0TP3RVj4O6JgUMcihRtNr2fM0e+nfFmSLnXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYnpt0QV5dqgLdyy9PKpBnNSjoro13pjU+CPLy07ZjCKa3R8O/jTQRHcaIiYBSBVH
	 jD+vAmjrrSJHDPvCJbhWx+XG4yS83yJBkdsdTFgei9gjhk5LRo+UlOp8CumBhxqaWC
	 uQUugl61rwN9rRZewNfSfpTan81MgLGlTVlEUN1g3rgPVm+8zIY2ApNOvm9xkmdyql
	 /UPcVqcoaG6Vs1GKV5rzz0fCMiXyi076gtR6C72ocwe+PnQ802jREblO1zvHFWcQLg
	 oIN9jxxGqCNZv0wecr9ZkqvcYVDuKY7QbVzRHl+ZHpOq4Xl5T57PQYCLkMP4kRnVbf
	 o820Zofzfigtg==
Date: Fri, 3 Oct 2025 17:52:01 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH] fs: doc: Fix typos
Message-ID: <6t4scagcatuba7hjy4aib5hqfgyhc4wofegr2jrl34wwa7fsyq@5uwpzmpixm7o>
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
 <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
 <yms8llJZQiWYVxnbeWEQJ0B_S6JRxR0LQKB1FwVe0Tw66ezuA-H1qZVCyuCUDtsw7s7h4jHTwTh98XivLW3vvw==@protonmail.internalid>
 <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>

On Wed, Oct 01, 2025 at 07:19:13PM +0530, Bhanu Seshu Kumar Valluri wrote:
> On 01/10/25 17:32, Carlos Maiolino wrote:
> > On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
> >> Fix typos in doc comments
> >>
> >> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> >
> > Perhaps would be better to split this into subsystem-specific patches?
> >
> > This probably needs to be re-sent anyway as bcachefs was removed from
> > mainline.
> >
> I just did a google search and understood about frozen state of bcachefs
> in linux kernel since 6.17 release onward. It is going to be maintained
> externally.
> 
> Thanks for your comment. I will resend the patch excluding bcachefs.

It's not only bcachefs. But most of subsystems and documents you touch
have different maintainers, so beyond removing bcachefs bits, I'd
suggest looking at MAINTAINERS file and send specific patches targeting
each subsystem. It makes maintainer's lives easier, at least for me.


> 
> Thanks.
> 
> 

