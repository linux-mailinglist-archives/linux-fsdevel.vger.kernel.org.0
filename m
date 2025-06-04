Return-Path: <linux-fsdevel+bounces-50602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E4ACDA31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE573A3AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41F242D66;
	Wed,  4 Jun 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0cnz8do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97471805A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026739; cv=none; b=SauHswe0i2Buo8kFP3SGeU/pBRIMBll2yc4/eMUdJHI/4cvCLt8m0yoEG90TRbvirqeJfdVPDmuKMiChEFXoEgVAJIBw7zCSfV7VghqBlbkGn+XIXG99X0X4u4p76EeBYIkkzEjeUPaFk7cGXs4CKTeM9nOEIzS7IPkzPUQYQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026739; c=relaxed/simple;
	bh=qYK5dtPc3XIdYq4jXhgK1Rrv8wKPijw3smU9opc8qqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs4ZWfhoiJ1txWn1Uzuw9LzZUsqchW1hL+IVzw9bo2lG8qZKK5rLEP6MukaOXMpw9Zb6LYxNMrRvD/WYXPWKyFOswOSqqsYObxGMFN7CWtSHG5l8/VyUySO8DD61FqZO/Usr2equAbgQ7AY8Jqg8wMu6L+wNzQ5WuDy6QN4zHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0cnz8do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C2BC4CEF0;
	Wed,  4 Jun 2025 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749026739;
	bh=qYK5dtPc3XIdYq4jXhgK1Rrv8wKPijw3smU9opc8qqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0cnz8dozH1cG0ddob4QH23Sv4G2mJVNScydmUd8RsvjG6yDTdpGR9va4RJOwNjrF
	 rgwDjcid6Ci/p/Zw9YcIgtzJ/PLXppdJLmDDcKQZRnlraHbRy5WU7WmsuvunBwr6N2
	 kv15lDEPKkpzviROvxk+yWY29JOJAlZVlM5Yv2bY=
Date: Wed, 4 Jun 2025 10:45:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: important orangefs merge conflict request...
Message-ID: <2025060408-oblivious-powdery-a27a@gregkh>
References: <CAOg9mSTuYsfCEi458Nt-X2==JOe9doLnzhoHEdqr9g_enSZLiQ@mail.gmail.com>
 <2025060303-handrail-prologue-3b3b@gregkh>
 <CAOg9mSS3NAxisK8b7mTkpW88btaQgAvW2umh5y6vhjbh6kVawQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSS3NAxisK8b7mTkpW88btaQgAvW2umh5y6vhjbh6kVawQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 07:02:09AM -0400, Mike Marshall wrote:
> Hi Greg...
> 
> >> Sure, what is the upstream git commit id of the patch?
> 
> b36ddb9210 is the commit where Linus pulled my fix into 6.15.
> 
> Some of Matthew Wilcox's folio work also landed in orangefs in 6.15,
> causing b36ddb9210 to have a merge conflict with 6.14.
> 
> I tested during 6.14-rc7 and Commit 665575cf was pulled into
> 6.14-rc7 after I tested, causing orangefs to be broken in 6.14.
> 
> So... there is not an upstream commit id for my patch that works
> with 6.14.
> 
> Pulling 665575cf so late into rc7, even though it was known to
> have caused deadlock problems with ext4 and (?) seems like
> an "unlinuxy" thing to have done. I was just hoping there was
> some way to get my un-committed 6.14 flavored patch
> backported to 6.14... I figured if it was possible, you'd
> know how...

Just submit it to us at stable@vger.kernel.org as a backport of the
commit like any other normal stable backport?

thanks,

greg k-h

