Return-Path: <linux-fsdevel+bounces-44103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9EA627BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9859319C0C38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C991C1D8DE0;
	Sat, 15 Mar 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="opHzxOTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CBEC0;
	Sat, 15 Mar 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742022058; cv=none; b=LkfNRHJOO1uHQkkeC7GMlpQ48oJgIhRWggwne0cl/rD82MsfBgpKwXfggG3mQZMgYur0UclHFceK6IpD513IT3a4RZSWDRky8ODr4m7jSrLwgFSoBITz4jGyJmvH0PXWFKZC44NBwLgFUUtVixJ+WTDNH7Jyl2GtLnGiB9ZbZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742022058; c=relaxed/simple;
	bh=OXgejY5JBAzMRJo+pZNPimlb3TBamxtnVr3yy3LxZBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piu8jqOUjBlY7V9yvfEo4qp8MOKnebS0RA2191FE/HgoV+0+AydAv9BEQuQ7n7IOLV0Fg240Zt/MOuhEKLISuD2+E6um9gliuTrrEIzM7sMS8u38Rr0CPWq8ZUJ1l8U7ShI2ohZXP7QOBdMb9QetOO/8YX3t/iup9zG+kJWMBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=opHzxOTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8EBC4CEE5;
	Sat, 15 Mar 2025 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742022057;
	bh=OXgejY5JBAzMRJo+pZNPimlb3TBamxtnVr3yy3LxZBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opHzxOTUzRsS7KJo73JxqDeTzxveLA07zrxsPHTTSPV92cd/hYgGWTuZU/c4HjPqn
	 nIovyOCR+uB8G8Y0cobhH3EHaFnjOQf20vAVgA/VwGhLCVi/S9XYcYo0Dgtx64zvFK
	 CMd+gmOfiAElA8mjApCPYbAbmHo7n1Q15TVg4uHk=
Date: Sat, 15 Mar 2025 08:00:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: tytso@mit.edu, ernesto.mnd.fernandez@gmail.com,
	dan.carpenter@linaro.org, sven@svenpeter.dev, ernesto@corellium.com,
	gargaditya08@live.com, willy@infradead.org, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <2025031529-greedless-jingle-1f3b@gregkh>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>

On Fri, Mar 14, 2025 at 05:57:46PM -0400, Ethan Carter Edwards wrote:
> Hello everyone,
> 
> This is a follow up patchset to the driver I sent an email about a few
> weeks ago [0]. I understand this patchset will probably get rejected, 
> but I wanted to report on what I have done thus far. I have got the 
> upstream module imported and building, and it passes some basic tests 
> so far (I have not tried getting XFS/FStests running yet). 
> 
> Like mentioned earlier, some of the files have been moved to folios, but
> a large majority of them still use bufferheads. I would like to have
> them completely removed before moved from staging/ into fs/.
> 
> I have split everything up into separate commits as best as I could.
> Most of the C files rely in functions from other C files, so I included
> them all in one patch/commit.
> 
> I am curious to hear everyone's thoughts on this and to start getting
> the ball rolling for the code-review process. Please feel free to
> include/CC anyone who may be interested in this driver/the review
> process. I have included a few people, but have certainly missed others.
> 
> [0]: https://lore.kernel.org/lkml/20250307165054.GA9774@eaf/
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

I don't mind adding this to staging from this series, thanks for
breaking it up!

But I'll wait for an ACK from the filesystem developers before doing it
as having filesystem code in drivers/staging/ feels odd, and they kind
of need to know what's going on here for when they change api stuff.

thanks,

greg k-h

