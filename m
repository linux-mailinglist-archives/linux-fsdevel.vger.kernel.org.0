Return-Path: <linux-fsdevel+bounces-52315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8FAE1B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771CE7A5105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7928B4EB;
	Fri, 20 Jun 2025 12:44:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8530E826
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423483; cv=none; b=BVEHqHSN5P4rpuTyctemyANqKLCb1qdQFj+RiG0Q9bk6mOFgUa107f9E3GnGm3ufaN/hBMyTbh7qFgtcfVABNoxwMLOkNLXM57HjTeOHMTfKQz/9qUF48OA/7aAcPW//6g+PAMDF6oSJanOlQ+0DdD5IhUe7pT8rSOYVauOCsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423483; c=relaxed/simple;
	bh=kT8qwNLgErIqGwBdFDitsulHRfVxvJjvNWCUlLlMzn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV4qWS9HrSSI3ldlmhYZG01xiSpH586Mc2DceUkfNSVwL6clGS6RzB1dCn/mFFZA7KtlAEl+hevR630WOvs5g0tejdI9Fy7YRzSPp7R6NBUjG3U+Ao1SyPEkFTag4YvTIJRdIiM90wGV69XjAqjsTkDEVz3cx6R5TDwceUdr7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55KChkf1014510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:44:00 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2AEA42E0011; Fri, 20 Jun 2025 08:43:46 -0400 (EDT)
Date: Fri, 20 Jun 2025 08:43:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Jani Partanen <jiipee@sotapeli.fi>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <20250620124346.GB3571269@mit.edu>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de>
 <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>

On Fri, Jun 20, 2025 at 04:14:24AM -0400, Kent Overstreet wrote:
> 
> There is a time and a place for rules, and there is a time and a place
> for using your head and exercising some common sense and judgement.
> 
> I'm the one who's responsible for making sure that bcachefs users have a
> working filesystem. That means reading and responding to every bug
> report and keeping track of what's working and what's not in
> fs/bcachefs/. Not you, and not Linus.

Kent, the risk as always of adding features after the merge window is
that you might introduce regressions.  This is especially true if you
are making changes to relatively sensitive portions of any file system
--- such as journalling.

The rules around the merge window is something which the vast majority
of the kernel developers have agreeded upon for well over a decade.
And it is Linus's responsibility to *enforce* those rules.

If, as you say, bcachefs is experimental, and no sane person should be
trusting their data on it, then perhaps this shouldn't be urgent.  On
the flip side, perhaps if you are claiming that people should be using
it for critical data, then perhaps your care for user's data safety
should be.... revisted.

Cheers,

						- Ted

