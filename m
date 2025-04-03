Return-Path: <linux-fsdevel+bounces-45632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9949A7A1D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A39175FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1B746E;
	Thu,  3 Apr 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcWqeI5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F443161320;
	Thu,  3 Apr 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679653; cv=none; b=sg43c/vUDDz1flwvj2QTpgNW7D2jxDRiCfPXempVGDXM3utVPHbdaaNmH5lTTqXGOum+kjSznW2Ix9JxxY6oUiHn8aeexihJ0Jxr2SyK80L13reHry4uJ55QyYGXksnxcGEBjm1fC5JezK0YohvmuRiRvxyQOoFVPuyMCLHsQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679653; c=relaxed/simple;
	bh=9H/RuHZhkwwqX0QP7nKfLhISSU6qrdULzbXx5qh9w10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJoznmS3M4/N+js0nmCPs7HvAwM7XRggnK8/AiSQNWsW3bxmQYhWk78vSdpgSeUPgsc/iVmMKmLP9+dMEpVtgR1uJPsKlPB/ko3eL5hVuiPgPWrhSAQUgBs8Xca1GcQ/JT0RtzwyJyyZdUk9R7DsJsXc6mzL/K/j7J7+NO76+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcWqeI5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71BBC4CEE3;
	Thu,  3 Apr 2025 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743679651;
	bh=9H/RuHZhkwwqX0QP7nKfLhISSU6qrdULzbXx5qh9w10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcWqeI5ok6kpIQF+b327W2fB6lk/09Gko6u7VHIU8DwiRdNK0IT/CsH2XK3FOavoh
	 8ikYIJp89usEeRxfvlNCHq2tjuCobchiy4innF2xjadreOgP0ajAiAQTnNyWVdyzkc
	 r2NocFdS6hgZx4YTEWULpsH/5SbjRoHO1qe7eMeA6vgtLmTcHdjW0F+20O8emLjtEo
	 VKQax2C/Rg9FfiLdrmNgncYRzIJ+CtBOS1F3GgZqjZ0OSkpS2ocAIVO2br+jkQK1Un
	 ZTG4GQTkn3zSDvsj2kPJcg9iAE/OotHyqozxTofVLqr0YFP5UNIxOBd1R0RVW/8zIk
	 9aoN91j/jzRyg==
Date: Thu, 3 Apr 2025 13:27:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Message-ID: <20250403-sauer-himmel-df90d0e9047c@brauner>
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
 <Z-aDV4ae3p8_C6k7@infradead.org>
 <87frix5dk3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frix5dk3.fsf@kernel.org>

On Fri, Mar 28, 2025 at 05:23:56PM +0100, Andreas Hindborg wrote:
> Hi Christoph,
> 
> "Christoph Hellwig" <hch@infradead.org> writes:
> 
> > On Wed, Mar 26, 2025 at 05:45:30PM +0100, Andreas Hindborg wrote:
> >> As recommended in plenary session at LSF/MM plenary session on March 25 2025.
> >> Joel is no longer active in the community.
> >
> > I'm not sure who decided that, but that's an exceptionally offensive move.
> 
> It was a recommendation given by several people in the plenary session I
> had 10 AM local time on March 25 at LSF. There was agreement in the
> sense that several people recommended this course action and nobody
> objected.
> 
> > Joel has helped actually reviewing configfs patches even when I as running
> > the tree, and I explicitly confirmed with him that he is willing to
> > maintain it alone when I dropped the maintainership.  You've not even
> > Ced him to tell him about how you force him out of the subsystem he
> > created.
> 
> I am deeply sorry for not Cc'ing Joel, that is a mistake. I did not do
> it out of disrespect or ill intent, I simply did not think about it.
> Thank you for correcting this, I appreciate that.
> 
> I have sent emails to Joel at least 4 times since the first rust
> configfs series was sent, and I have offered my assistance in
> maintaining configfs if that is the reason of no response.

There's no need to get upset. Several people pointed out that Joel
Becker retired and since he hasn't responded this felt like the right
thing to do. Just send a patch to add him back. I see no reason to not
have Andreas step up to maintain it.

