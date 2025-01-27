Return-Path: <linux-fsdevel+bounces-40160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4CA1FFF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1568B164CCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC41D8DE0;
	Mon, 27 Jan 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ka4dEF5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23A1D86E4;
	Mon, 27 Jan 2025 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013701; cv=none; b=ZE5MQZ4/4GNbXfC3/V7x/8QZ5b+1tYcZpcLDR7gQcQJJunij209VyUBjWuP+4FqX0sSzk46SqH0Cev2GqOFdN8zXP92zw4eTygkJNDe9w/abtvOlBrcMMOzeu4yXRaA5yU0uJJGs/UPtB6H08Kr+Jp8rUkn7ez7Elc2V9vW+udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013701; c=relaxed/simple;
	bh=bzf3eP/hx12Q/Oq7crlV3VD/Iv44XwJs0M5NNG4MXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al7n3Flcxw9cX/F8MguBuvJ2dosNELtGH89+AOW2b2Cr73ANJo8urcwavxUMTsD2YTmW5pEnHHG3uP6hgDp17AKoneA+hF3snmfAjhzU0i6c5gUzGOvwsbt2XMchMUlpoJl+hNcO/d3eRfqWw6bxArtkCjyAEs9IabXYTWe5rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ka4dEF5i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LOqGsxpfvMFfGSZWiUjA5lsBKHDYMh9CnwjENFtBomM=; b=ka4dEF5iaXBN9EgttmEQKLMIcd
	ln7ITZw91HlXdFQaJCDxpZi1NvW3flbtvy+McUybvAzFWF6zlNO14QW9GOj8FiLxksdxNWClfOo9o
	DJqVReb3/5hU5+DGpoZStQaS3APyuhmW56t2c4O7aCeKne12VbOpU8Su3keZdrz+bTUDzvhv6rwtX
	Bp54UTxEyTx3tQIFin+h+5lju1+jUrdcqkGuJhrtNLrlzzMhuY7k+Y6K+KYENXNwH3w2GBH60li/7
	Niht4FMc2Qpnf+EwnOlP54u1HwX6s65B2/b+0zDG3rEXNaYzjkQ3MrHoQZQBlbZruiVZiNQ/+NaIw
	cgQYw19A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcWky-0000000DhCH-3hNM;
	Mon, 27 Jan 2025 21:34:56 +0000
Date: Mon, 27 Jan 2025 21:34:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250127213456.GH1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5fyAPnvtNPPF5L3@lappy>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 03:52:16PM -0500, Sasha Levin wrote:
> On Mon, Jan 27, 2025 at 05:36:34PM +0000, Al Viro wrote:
> > On Mon, Jan 27, 2025 at 12:19:54PM -0500, Sasha Levin wrote:
> > 
> > > The full log is at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27028572/suite/log-parser-test/test/kfence-bug-kfence-out-of-bounds-read-in-d_same_name/log
> > > 
> > > LMK if I should attempt a bisection.
> > 
> > Could you try your setup on 58cf9c383c5c "dcache: back inline names
> > with a struct-wrapped array of unsigned long"?
> 
> It looks like we didn't trigger a warnings on that commit, but I'm not
> sure if the issue reproduces easily.
> 
> I'll start a bisection and see where it takes me...

Interesting...  The thing is, that's the only commit that goes anywhere
near ->d_name reassignments.  That access smells like access just one
byte past struct external_name...  wait a minute.

Could that be load_unaligned_zeropad() stepping just over the end of
external name?

If so, then
	a) it's a false positive (and IIRC, it's not the first time
kfence gets confused by that)
	b) your bisection will probably converge to bdd9951f60f9
"dissolve external_name.u into separate members" which is where we'd
ended up with offsetof(struct external_name, name) being 4 modulo 8.

As a quick test, try to flip the order of head and count in
struct external_name and see if that makes the warning go away.
If it does, I'm pretty certain that theory above is correct.

