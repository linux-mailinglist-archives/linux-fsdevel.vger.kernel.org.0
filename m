Return-Path: <linux-fsdevel+bounces-27017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C113C95DB7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 06:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8211F24891
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0563CF6A;
	Sat, 24 Aug 2024 04:28:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154ED1E4B2;
	Sat, 24 Aug 2024 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724473690; cv=none; b=kwuc58i6wPWdDp8cGMG1lCFwutq1lMFHvfGpWXmk5/i2Kvr3fj3onfMqEqslYk8bR+i/EmTNhU443rFKnVtpJsNJNyfyYCxWjDceR+ZXRPekVaZ7lpIqPltps3LC3MLsJAjGdVjRCz0JWKDHY2lJuILsQpaZaNOij1mHa0GLS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724473690; c=relaxed/simple;
	bh=Hi71OaJteC/N9IfhmdoVU8bV7ZIddzlMy5w19qoPLcI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XLiAQR+SwR1UKMNpWrwRPJH+LE1CY3QCixlYTiJd6Bwn8G8dmI6+BU+Rw//FvwIYV64QgD5cpwEVkgJv0l+mTvMwWzb/1gyNW3/vxWeSOzjSDJeo+t770wa/v2ZjPcnynUpJGQ59qXIGgldBMFGXJY94JAeVLKMxhk9ma0GtP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 5869C100EB1D4;
	Fri, 23 Aug 2024 21:22:55 -0700 (PDT)
Date: Fri, 23 Aug 2024 21:22:55 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <1816164937.417.1724473375169@mail.carlthompson.net>
In-Reply-To: <ihakmznu2sei3wfx2kep3znt7ott5bkvdyip7gux35gplmnptp@3u26kssfae3z>
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
 <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
 <ihakmznu2sei3wfx2kep3znt7ott5bkvdyip7gux35gplmnptp@3u26kssfae3z>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev53
X-Originating-Client: open-xchange-appsuite

Kent, I'm not a kernel developer I'm just a user that is impressed with bcachefs, uses it on his personal systems, and eagerly waits for new features. I am one of the users who's been using bcachefs for years and has never lost any data using it.

However I am going to be blunt: as someone who designs and builds Linux-based storage servers (well, I used to) as part of their job I would never, ever consider using bcachefs professionally as it is now and the way it appears to be developed currently. It is simply too much changed too fast without any separation between what is currently stable and working for customers and new development. Your work is excellent but **process** is equally and sometimes even more important. Some of the other hats I've worn professionally include as a lead C/C++ developer and as a product release manager so I've learned from very painful experience that large projects absolutely **must** have strict rules for process. I'm sure you realize that. Linus is not being a jerk about this. Just a couple of months ago Linus had to tell you the exact same thing he's telling you again here. And that wasn't the first time. Is your plan to just continue to break the rules and do whatever the heck you want until
  Linus stops bothering you? I don't think that's a good plan.


Since I'm already being blunt I'm going to be even more blunt: you have a serious problem working with others. In the past and in this thread I've read where you seem to imply that other kernel developers are gatekeeping and resist some of your ideas because you've created something that (in your opinion) is already better in some ways than some of things they've created. But from where I'm sitting the problems you've experienced are 90% because of **you**. You're an adult and you need to understand that about yourself so you can do something about it.


I get that I've way overstepped my bounds here. If the kernel developers wish to ban me from the kernel lists I understand.

Carl


> On 2024-08-23 7:59 PM PDT Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
>  
> On Sat, Aug 24, 2024 at 10:40:33AM GMT, Linus Torvalds wrote:
> > On Sat, 24 Aug 2024 at 10:35, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > What is to be gained by having release rules and a stable development
> > > environment? I wonder.
> > 
> > But seriously - thinking that "I changed a thousand lines, there's no
> > way that introduces new bugs" is the kind of thinking that I DO NOT
> > WANT TO HEAR from a maintainer.
> > 
> > What planet ARE you from? Stop being obtuse.
> 
> Heh.
> 
> No, I can't write 1000 lines of bug free code (I think when I was
> younger I pulled it off a few times...).
> 
> But I do have really good automated testing (I put everything through
> lockdep, kasan, ubsan, and other variants now), and a bunch of testers
> willing to run my git branches on their crazy (and huge) filesystems.
> 
> And enough experience to know when code is likely to be solid and when I
> should hold back on it.
> 
> Are you seeing a ton of crazy last minute fixes for regressions in my
> pull requests? No, there's a few fixes for recent regressions here and
> there, but nothing that would cause major regrets. The worst in terms of
> needing last minute fixes was the member info btree bitmap stuff, and
> the superblock downgrade section... but those we did legitimately need.

