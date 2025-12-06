Return-Path: <linux-fsdevel+bounces-70933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D4CA9FEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86A6F3015101
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB325F797;
	Sat,  6 Dec 2025 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LnFcubO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252171E0B86;
	Sat,  6 Dec 2025 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764993227; cv=none; b=A41/ABT1bzt4kE/h6sL07+aH2L3e9kaFFlG+zz8RtvUBpZqgXRzC2tgg+i4USFNrZbiyqKjfMBCMxYHFsvBhepmkmxvpqN9asGMbvOeYHRjyQM4A1ZtFIzQVBa4rdUHHCDYHNAMLjpB9Oda+iLrOsw8S1gqsnQ6RvZLtlI220dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764993227; c=relaxed/simple;
	bh=DAAwJ7Rv8K3m9y7Uher65nqTrDv0cz3JtDTjf+4A/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1Q960Qx9V+nf4AWx3CDlR4G77kFE80pgDENDJbiM4nLB69/Qh8FxXBJVxGZScevcKo3eF9a+zs1HcQUNgSZVIx8epQ839vr61Hju3htlBAVkQ6tuODZ4thyp6KZqkFemAGzL7z1px9C1B3mRnsXlwFHkcTXSvALYLH0fv5XlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LnFcubO3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x0xkU5lvhClhqhKY6h2dAdizpBAF1efvRDEEQbdhUPc=; b=LnFcubO3G4XWvbWNfTVYrMzTqb
	Y1U1XAkbtNjVFWRyq6Yvzun5IC2lNIVPm0ElT9VgabrZEpvfTh9PUKaRzkl1lOa+lifvVNZhJH1y5
	jSv9gPC4ml8CHVw6FHhMKoDOnxUeFvjMflgzsDKDvFHWYUjWQOmQsfyvSX/VO9d62canWu5BH9BV5
	UJ9IYfmcu+fMFU/+Kl7ZLbsJ1vPbeLcZCs8EI7Gtq5+Dnt4FFNVzM8z0IU4w/S3G6OY0as+iJHlMk
	lq3Ltm+6kJUJSn+XgiPyAN4RvWjEQCw+4FaJSOJwg44miJohCqR/84VvbDGah0ye9T/uqnqH8P+i5
	ynZUl4fA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vRjMx-00000006SgJ-3KdK;
	Sat, 06 Dec 2025 03:54:03 +0000
Date: Sat, 6 Dec 2025 03:54:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20251206035403.GR1712166@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
 <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 05, 2025 at 07:29:13PM -0800, Linus Torvalds wrote:
> On Fri, 5 Dec 2025 at 18:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Sure, ->d_prune() would take it out of the rbtree, but what if it hits
> 
> Ahh.
> 
> Maybe increase the d_count before releasing that rbtree lock?
> 
> Or yeah, maybe moving it to d_release. Miklos?

Moving it to ->d_release() would be my preference, TBH.  Then
we could simply dget() the sucker under the lock and follow
that with existing dput_to_list() after dropping the lock...

