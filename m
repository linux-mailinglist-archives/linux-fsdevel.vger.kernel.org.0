Return-Path: <linux-fsdevel+bounces-57581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B03EB23A3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB5189F91A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FF2D47E5;
	Tue, 12 Aug 2025 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvQ+xnbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B923182D;
	Tue, 12 Aug 2025 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032064; cv=none; b=ueTmEc9nCAEnC3LSVT7kyK2DuzBSomaK2LTjsfJj1c0hat9C4q0KwzRV/WYbo0MPU/Tpp2BaDlK2DVXoyqdojL4jqJv8XmPmKUuVW5lmX1QpX4FasNniV90onI23TNZqXrznxOMDr9l+az1sEnVIbL/HbKP/kBNXWUba9GmJhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032064; c=relaxed/simple;
	bh=KgNWZ+pw8XzII7439MzptZB2qb8BPXZsxQzFoG3Hwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epwjbzN4kzkkOF1gfG2K1NWAdphhWSasiKCP/CrSdPu5owQlyIvisnH2GlMyA2AILCLQm7apf8WxpGIVqm/0MVAQnivKVqDbRJsFm1UYMjZwoellTN3B17Mkq1T7L6eP4jX42xnYF15LkKMDbM6+elex8mMtQ1YJZ0vOKgZG1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvQ+xnbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828C1C4CEF0;
	Tue, 12 Aug 2025 20:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755032064;
	bh=KgNWZ+pw8XzII7439MzptZB2qb8BPXZsxQzFoG3Hwus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvQ+xnbK+/qTrGhW7tJOpYLcoFJOhEtLPTkH/58f++IrXyUGb1S3oRrRZMDBKS5Eo
	 HfVaBJjnMs873NWs4srhubUdq3V6hvLHl5EL8yIjjwiZm00R0p6S3lv+tNzUAGe7UF
	 U6FnflJ4BXNkI2arHti0ZzqrUxI5qHNZ2SCQKIXRHGRZjE7VI4Rwb45TXwUfpFoaVU
	 EXjDbcotaGl9n4ndlnYaTgALed+OecKLNCR5ufucQ+igxX29KjyajLimUzFkH1JobE
	 G2emw8rLyc9LZqYqgQsZ95gXMO9un9CnNWF5TSwiUrM2ZPTJPP7/comJ1FeApAOBEE
	 Ljzhqfl0KJ5XA==
Date: Tue, 12 Aug 2025 14:54:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJup_fo6b6gNrGF0@kbusch-mbp>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
 <aJukdHj1CSzo6PmX@kbusch-mbp>
 <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>
 <aJumQp0Vwst6eVxK@kbusch-mbp>
 <ib4xuwrvye7niwgubxpsjyz7jqe2qnvg2kqn7ojossoby2klex@kuy5yxuqnjdf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ib4xuwrvye7niwgubxpsjyz7jqe2qnvg2kqn7ojossoby2klex@kuy5yxuqnjdf>

On Tue, Aug 12, 2025 at 04:45:48PM -0400, Kent Overstreet wrote:
> On Tue, Aug 12, 2025 at 02:38:26PM -0600, Keith Busch wrote:
> > On Tue, Aug 12, 2025 at 04:31:53PM -0400, Kent Overstreet wrote:
> > > If you're interested, is it time to do some spec quoting and language
> > > lawyering?
> > 
> > If you want to start or restart a thread on the block list specificaly
> > for that topic, then sure, happy to spec talk with you. But I don't want
> > to chat on this one. I just wanted to know what you were talking about
> > because the description seemed underhanded.
> 
> Not underhanded, just straightforward - I've seen the test data, and the
> spec seemed pretty clear to me...

  "the block layer developer who went on a four email rant where he,
   charitably, misread the spec or the patchset or both"

Please revisit the thread and let me know me if you still stand by that
description. I've no idea if you're talking about me or one of the other
block developers on it, but I frankly don't see anything resembling what
you're describing.

