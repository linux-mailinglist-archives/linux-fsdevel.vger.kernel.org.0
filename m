Return-Path: <linux-fsdevel+bounces-57204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760AB1F8AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D97518986BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588122A4E8;
	Sun, 10 Aug 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v6GKyG/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D151F949
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808703; cv=none; b=OCdr1eYsXCGpHQR7lIojLZFoo/ORqvSs6u+R+cQcoGN1875j/Z599b7y45HkuZNdx+rxPVc8j+NMzM33wuOQIuudjdObo7ofhYRdAWTLXucgUArTiQF6I6omrv6dSgGMbJDevZVx/dSofDZrvscKJCihVbZzOMCebLjPp9dj84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808703; c=relaxed/simple;
	bh=w4s6ef9QQuQTpsSCeAfALWWCxl+SH5jM25lC0VRVzBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY+S5iOd3Ho3Gh9+Zf20doArd26QPVFmkrUc04NBL0AgNvDyMlyuu8Rdl9gE828o80E2J54Sa4SSRmcOuWEziynF9IvI38eabeYJ/gSZGnyqEuLeBXTIwCeBJWDa7gZ/aULNghxdnlym7j3e3ZspMWtwu/cQ1Q287tRapYGiLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v6GKyG/R; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Aug 2025 02:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754808695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5opVV4qX373/TZHQ2Y1gR+gQdhGSWKpiSvpwpU6mgQ0=;
	b=v6GKyG/RSDO9WYfTaWi5TYOt+TQ05SVVoGDvQgBNkNrkOYFnnN7EjqP8JZ0vfBQLJiasNe
	VrdW40Fbg2tjBrKcgdH7eA5meOYM2a1PE6VXS6Z/oCwD/9DVCz2dQgj/I8ud6ERIGY++o+
	b9hSpMNDch8nXHdFyFAWY6cftHZHzdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Gerald B. Cox" <gbcox@bzb.us>, Sasha Levin <sashal@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <s3bemxtilqqkr4ncii23z2sjvwkkol5bab6ox5o76hifkzgqvk@uuiqgxzqhpnx>
References: <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy>
 <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
 <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
 <20250810055955.GA984814@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810055955.GA984814@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 10, 2025 at 01:59:55AM -0400, Theodore Ts'o wrote:
> If Kent hadn't spoken up, I would have remained quiet and waited for
> Linus to do what he was going to do --- but no, he decided to take
> this public, and started slamming Linux's engineering standards.  I
> will point out that a good engineer has to have good people skills[2].
> In fact, there are many who have claimed that engineers' soft skills
> are just as important, if not more important than their technical
> abilities.

If I had simply remained quiet until it happened, I think the entire
bcachefs userbase, and my funders, would have been absolutely furious
with me.

And yes, the kernel engineering processes and standards that got us to
the point are absolutely relevant to the discussion.

