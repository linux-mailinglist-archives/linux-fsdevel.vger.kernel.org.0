Return-Path: <linux-fsdevel+bounces-53132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C555CAEAD58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661965628A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4E19D07A;
	Fri, 27 Jun 2025 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjQ7AYYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6A1946BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995268; cv=none; b=Y7skjud4flO6Z3payBQ3iSLx4ZcevobJWiw8Yp1muKKIL5zskAHxZlieQahz1Up/2GP0umRXVoOzkJiORdaupOySpOLggsaKYiCxweDvygZaMkf+DoEmC85L7oh2GqwyXgWT7ncHqz7tYz9BpXpV7jNiI5s7KMRO6yVjM6RB0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995268; c=relaxed/simple;
	bh=lXRZR/d6O9tEcFVYGrcUpjLKcSrBYWsy+lSFWL0ItJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQeguEFEz5qVkUVqyijkDplYmmrS9aqnU9k6MllP+4aSKTvLOcY0NJKMOI02ZglAUfq7Tf4M1ztOA0RmebDCIiRnuZaJhhhnZ8JO2w/gqwDld15sbvYYz+y966FYECSKl8qplt3gAJTKWKbbbgzkWCd6sC9G9T6AQGafrbIFWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjQ7AYYF; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 23:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750995254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2Dsq66WVPXbBaG0lBEK/iXNVNpmsvGbhJpB9H2vDdM=;
	b=mjQ7AYYF7Urcw2dMcvsLHyrz/9wVudnZA9/5pJFJgFjAdVpY1/yY45RZA3hZK4Dv23NrI4
	FdF1bxISpVpUbf2GU4eLZgMhhevJ+jG6gjAj7/ROe9zQ2WiwhUgUGBUbxhdmJ4yuz/TZWk
	U9RnZMqzP7wbGyAu083Qi09h0TpwaNA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kerenl@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 26, 2025 at 08:21:23PM -0700, Linus Torvalds wrote:
> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > per the maintainer thread discussion and precedent in xfs and btrfs
> > for repair code in RCs, journal_rewind is again included
> 
> I have pulled this, but also as per that discussion, I think we'll be
> parting ways in the 6.17 merge window.
> 
> You made it very clear that I can't even question any bug-fixes and I
> should just pull anything and everything.

Linus, I'm not trying to say you can't have any say in bcachefs. Not at
all.

I positively enjoy working with you - when you're not being a dick, but
you can be genuinely impossible sometimes. A lot of times...

When bcachefs was getting merged, I got comments from another filesystem
maintainer that were pretty much "great! we finally have a filesystem
maintainer who can stand up to Linus!".

And having been on the receiving end of a lot of venting from them about
what was going on... And more that I won't get into...

I don't want to be in that position.

I'm just not going to have any sense of humour where user data integrity
is concerned or making sure users have the bugfixes they need.

Like I said - all I've been wanting is for you to tone it down and stop
holding pull requests over my head as THE place to have that discussion. 

You have genuinely good ideas, and you're bloody sharp. It is FUN
getting shit done with you when we're not battling.

But you have to understand the constraints people are under. Not just
myself.

