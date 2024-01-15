Return-Path: <linux-fsdevel+bounces-7999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5C82E15F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205751C221DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3A199B3;
	Mon, 15 Jan 2024 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="dRJZqrjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1/gDlIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F322199A2;
	Mon, 15 Jan 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id 34D172B0043D;
	Mon, 15 Jan 2024 15:13:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 15:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705349584; x=1705356784; bh=WdU1eULlnA
	Z4y1Psn2lr/4ciqsXjdF2H+kLwgj/RjG0=; b=dRJZqrjO/i4b/Hivwr6QNpxtLE
	hUNPzax1RlJ7jBwW8aApfBBSMZWZtyc8kfFPO2IbdvjhWAtPyp76fohB6oiWAdQq
	/cZnT2NKufW8KplzYy8MZg6LYJkwkTugMTqbFbMgyUIEcva7tOQgFQMyz3MenNcR
	8HkfnX4FmWJ5xPaQ46lTB3cVvxT9Kxc7/q8q0DpQSvxPBIKv8KM8zxqWZLhfSU6S
	9yFF3wZ+SNU7AzZ2GzkT8OwQBuP8Ozgc8jSOChd/YsxymuDnYjDyTJbRFISLKcvc
	TXiTttdllcP5+7wU3JV7hcni7qpgg0jLvUVQjJC0jG8wqVNNa/T6Mvu4K2QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705349584; x=1705356784; bh=WdU1eULlnAZ4y1Psn2lr/4ciqsXj
	dF2H+kLwgj/RjG0=; b=L1/gDlIKsedlGIAdpzy1JHG60lVIkwu8Ap2Ml1yrVwVt
	JCA/BFgyJseFU9qhETWfdrvaWRxcWELVfAcEO35NvtqfZbsJBHY+V0GG5aOwAScJ
	BU/IRB3IZpmFlgZllG3SD39zowPu1dtnIiSNEbmabe4YYUO2rVYuxFW43HqjF6iK
	6e1hj4OMri43lwqlqcHXwPNIfbFUjLp4lkiqRlkv9vuks+0ensu/7Id58KdKv3Ou
	Ty8fLe2ilf6IW+yAS1zCU/guCNx3f2AUPiM4csOucm7w9f9IXO2faDIJpFeTBeL6
	yfVzgU+lJXFGog2KnueGhS4d74P3PMxKNbrKGkrvxQ==
X-ME-Sender: <xms:0JGlZSKQtyfcOh8fqCXfdTdlIKeQPOCVEB8NEwYJxr7hGzDgXFLAzg>
    <xme:0JGlZaIG9XeFvl-zKp_uWpF9-1csJy-CLEWsdgIYcENas9Fahz99Va9aUTRpT0JaY
    QqyS34QZpOgyQ>
X-ME-Received: <xmr:0JGlZSu3AcjSAA64DJ-kShg4hO3RjVc5bNcBhThkbvOKov5sZVZrf5Tjmq1D9A5xE67zkViucNQzoz9NQwf69B1bg56-ZpXcmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:0JGlZXYL0x2rbE95X14jqQB2-G6QlgnbTYVHPfJKiqNalR9wERHRSg>
    <xmx:0JGlZZapM3COJ0C6MmMhEBCh-_TA4CyvAhO1pMqA8NtvBktg19NXQQ>
    <xmx:0JGlZTCVihtcg4okFMAPZU5K2cQeK0M_GeSiO3OhSjXdkKksxzn_Kg>
    <xmx:0JGlZWJjMSrqV4jfjDD2bxuZrQOfjv6B7YPuTRJYzoqCyGL38LpYdYRdgGw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 15:13:03 -0500 (EST)
Date: Mon, 15 Jan 2024 21:13:01 +0100
From: Greg KH <greg@kroah.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Philip Li <philip.li@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <2024011532-mortician-region-8302@gregkh>
References: <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>

On Mon, Jan 15, 2024 at 01:42:53PM -0500, Kent Overstreet wrote:
> > That sounds more like a "(reproducible) tests don't exist" complaint
> > which is a different thing again to people going off and NIHing fancy
> > frameworks.
> 
> No, it's a leadership/mentorship thing.
> 
> And this is something that's always been lacking in kernel culture.
> Witness the kind of general grousing that goes on at maintainer summits;
> maintainers complain about being overworked and people not stepping up
> to help with the grungy responsibilities, while simultaneously we still
> very much have a "fuck off if you haven't proven yourself" attitude
> towards newcomers. Understandable given the historical realities (this
> shit is hard and the penalties of fucking up are high, so there does
> need to be a barrier to entry), but it's left us with some real gaps.
> 
> We don't have enough a people in the senier engineer role who lay out
> designs and organise people to take on projects that are bigger than one
> single person can do, or that are necessary but not "fun".
> 
> Tests and test infrastructure fall into the necessary but not fun
> category, so they languish.

No, they fall into the "no company wants to pay someone to do the work"
category, so it doesn't get done.

It's not a "leadership" issue, what is the "leadership" supposed to do
here, refuse to take any new changes unless someone ponys up and does
the infrastructure and testing work first?  That's not going to fly, for
valid reasons.

And as proof of this, we have had many real features, that benefit
everyone, called out as "please, companies, pay for this to be done, you
all want it, and so do we!" and yet, no one does it.  One real example
is the RT work, it has a real roadmap, people to do the work, a tiny
price tag, yet almost no one sponsoring it.  Yes, for that specific
issue it's slowly getting there and better, but it is one example of how
you view of this might not be all that correct.

I have loads of things I would love to see done.  And I get interns at
times to chip away at them, but my track record with interns is that
almost all of them go off and get real jobs at companies doing kernel
work (and getting paid well), and my tasks don't get finished, so it's
back up to me to do them.  And that's fine, and wonderful, I want those
interns to get good jobs, that's why we do this.

> They are also things that you don't really learn the value of until
> you've been doing this stuff for a decade or so and you've learned by
> experience that yes, good tests really make life easier, as well as how
> to write effective tests, and that's knowledge that needs to be
> instilled.

And you will see that we now have the infrastructure in places for this.
The great kunit testing framework, the kselftest framework, and the
stuff tying it all together is there.  All it takes is people actually
using it to write their tests, which is slowly happening.

So maybe, the "leadership" here is working, but in a nice organic way of
"wouldn't it be nice if you cleaned that out-of-tree unit test framework
up and get it merged" type of leadership, not mandates-from-on-high that
just don't work.  So organic you might have missed it :)

Anyway, just my my 2c, what do I know...

greg k-h

