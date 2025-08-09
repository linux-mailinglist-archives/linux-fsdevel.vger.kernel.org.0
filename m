Return-Path: <linux-fsdevel+bounces-57183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA9B1F6CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 23:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BF1621322
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F060277020;
	Sat,  9 Aug 2025 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1xPi0PY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88F225419
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Aug 2025 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754775307; cv=none; b=QpXuHys/4FVeUsdmAjJwkA7BIxsCur6ZeWK0JrxSfjIKLBn/3vWNWwyiY7CfcWKsTvplngO48rUYC0C6nISNx+KzJDG4XfWw7zNyxeDQ/xKciaL/EL85IyNHKTQST72s+jeMeKY4mGrt2znfGxrf/CSzD+l/p4mzrO+oQWBm3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754775307; c=relaxed/simple;
	bh=0U+2bvwtG3+Ixdx6wgI6eMv1jak/Ko5vKr/jWtgVvMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlHSmCfVoB5tZ7ACVXcB5IqwpLUyu8W/5t2a0Yp5IR5Q4DtL5HABD9bkZBgogrTDez9Nvf8VgsFB8KSB4WpqTY3rjYt+1HThPDefQoc34Ah30UMhonjcKjMRiOl2ae4Lnq/r9iLf5XyKTu6qtM+1dCXGzU+rRQUM/+m15OriK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1xPi0PY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 Aug 2025 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754775292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0U+2bvwtG3+Ixdx6wgI6eMv1jak/Ko5vKr/jWtgVvMI=;
	b=s1xPi0PYLSX/IuFioAucP59tJfJUn7c5MOdXTkVAgB4VxMI3c8B89R+UuAwcd0DNtfSSlm
	cOIip6cudiOQ0I0g7llrp9EDhTYzTlk/a9Hwttx9ThQ9DKARBf5rSJju/BRJz+Y4vTDmF0
	Vl7pvGCdK6qw6vZEXOqQkTUcbVXXg80=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Aquinas Admin <admin@aquinas.su>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <qivictc5jxyx62mqz6rlg6cix3tzaahqxbgk2ig3cq5d6esqyy@xydebz6gakxq>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 09, 2025 at 04:37:56PM -0400, Kent Overstreet wrote:
> At this point in the development and deployment in bcachefs I can say,
> with confidence, that bcachefs is changing that, and that in time we
> will deliver _better_ reliability than ext4/xfs.

I should add, based on the data I'm seeing - this isn't far off, but due
to the sheer amount of deployment and usage ext4/xfs have had it'll be
awhile (perhaps a year) before we have the data to make hard claims.

The data from users versus btrfs is much clearer, we're already
delivering much better reliability in terms of "will my data be safe" -
there are numerous failure modes that simply don't exist in bcachefs.
And where we've had significant bugs (I count ~2 that have made it all
the way to a mainline .0 release), good debugging tools and a clean
design have meant that we've been able to resolve them by about the
third report, and in every case with significant hardening done after
the fact and real support for affected users.

IOW: your data is safe on bcachefs, and that's priority #1 for a
filesystem.

