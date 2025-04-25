Return-Path: <linux-fsdevel+bounces-47319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A7A9BDB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 06:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5533D189F6A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 04:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126D1DFD96;
	Fri, 25 Apr 2025 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LsPf+i4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DB86334;
	Fri, 25 Apr 2025 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745556731; cv=none; b=OlvSTDHkrVvnF4tBJu0q3iv3n1wW84WJkQ42p7aZ5ZIxb88ECLzSm7DY3b8nUTa7ei3sgIMswdgWZKeW/cKSYVG8iYM2mk/MCtYGIoglUB9iEba0wk47/475QFKMH6t0A40fz9E7fbqo51/8fynDtn+QhL5UlDlwKu0CdhJ0RKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745556731; c=relaxed/simple;
	bh=sYpbK9ht9/+EDXXnMErkvMAB/r9ylzJSuaM229Rnp3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEqoFjQZXbnpAkcX9zRFC9Btwz7jQO2GW9ZaibvVA4jkWFygLmOhVzxt8IQZiGKgZ3BWcykRmKR+9qhh/6sVpXbqNMeLTDwhCcDwPqvbmLw6NmyfnJQtiUrYjJLGF7gP9GrH2fOnMMckC0PwM6PEJhHHVLhSHgZ5HqB0fCoJFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LsPf+i4G; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Apr 2025 00:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745556725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q8NOUHEi971EMKXsRnOzg3dz3vI2tFwykmu0M0uoKA=;
	b=LsPf+i4G8QvHupX136T612TWsf6jpIp+q54AOFN4oStCBrtj2DtcSl4T3urjMO0NE8omSi
	SOlnLt6/7IcQKsdHCveq62v4D9ShBGR6JaDtA4ZqT95/bQSVwvv1upY1q4vRr6KZQsjOW4
	eTiVqJJemlg2Pr6GdSd2KDx99x3UNgY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 09:20:53PM -0700, Linus Torvalds wrote:
> On Thu, 24 Apr 2025 at 19:46, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > There's a story behind the case insensitive directory fixes, and lessons
> > to be learned.
> 
> No.
> 
> The only lesson to be learned is that filesystem people never learn.
> 
> Case-insensitive names are horribly wrong, and you shouldn't have done
> them at all. The problem wasn't the lack of testing, the problem was
> implementing it in the first place.

While I agree with you in _principle_, on this specific subject -

This is all irrelevant given that the purpose of the operating system
and the filesystem is to support users and the applications they want to
run.

And the hacks for doing this in userspace don't work.

And the attitude of "I hate this, so I'm going to partition this off as
much as I can and spend as little time as I can on this" has all made
this even worse - the dcache stuff is all half baked. Stroll through the
ext4 and xfs code and find all the comments to the effect of "yeah, we
should really do this better _eventually_"...

And the security issues aren't even case insensitivy, it's just unicode.
But that ship has sailed too...

