Return-Path: <linux-fsdevel+bounces-45735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A025FA7B91C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFBB17A613
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6F1A0711;
	Fri,  4 Apr 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj96f99r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD9190462;
	Fri,  4 Apr 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756155; cv=none; b=pd8alwKpxj8ibO5YaUf/y7GNeVbi9/mBOMSp4qWRimhojkFGFrYnCzfb1ZhTzdD0eVWVXr/9YzXB5PX11B93+3b4vr1/43c+lxGov+B5xEksGV9h3yohKshYUCml6iVNCfIBhWFB+jIusW5BDK35LZFVfAfE31ktDOFdagHENHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756155; c=relaxed/simple;
	bh=RgJixkR04iKIsejh5yldwMV/SMTQE2HdrbwYhuj/Atk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueD76XEMT0tCZWOpe63jR15S3b7Narvfia5dFj8amj2IO9RbeCnRllQ0or9y7S/66NI8OqHaG4SL9fPPNuJZm+0J0e/4DJoIQ3236xdOazrBxfstQCT46/MrtUtKUOUKwkUB6DK5lbMURGgRUMDfYVcR5FoPLgniUAJaodq292U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj96f99r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221C9C4CEEA;
	Fri,  4 Apr 2025 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743756153;
	bh=RgJixkR04iKIsejh5yldwMV/SMTQE2HdrbwYhuj/Atk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dj96f99rwas08z2n+1In5u0cV1BW5ido3bSR9VEEdeCWTde7CfhH33Wxl5CeivJF+
	 CufSRBRy1AMA1otAtCLnnAWBWn25IKdNpPY+GeXWNUTWCsYP1Q3b3CXQ70//wyYDd/
	 SYisxlDsswDxdRQiQoLAk7AXeSCeAZiA+EGODzqQQDdMHAhRNCsGXcagGgHToWsSyh
	 yoPWJfzfAWOqfSJZVlM1q2PWQK4E3C4T4jdTrl8NTNFLstVU30bggJzsX1XtJpMQgP
	 DIe+rfd/CIh5lm9F9eyo6HALpI/mvgokTSWRv9aft+30TJAyeQTPenwLCJ7s8nQYgD
	 2Aie6oxZZAq0w==
Date: Fri, 4 Apr 2025 10:42:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
	Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Message-ID: <20250404-komodowaran-erspielen-cc2dcbcda3e3@brauner>
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
 <Z-aDV4ae3p8_C6k7@infradead.org>
 <87frix5dk3.fsf@kernel.org>
 <20250403-sauer-himmel-df90d0e9047c@brauner>
 <Z--Ae5-C8xlUeX8t@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z--Ae5-C8xlUeX8t@infradead.org>

On Thu, Apr 03, 2025 at 11:47:23PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 01:27:27PM +0200, Christian Brauner wrote:
> > There's no need to get upset. Several people pointed out that Joel
> > Becker retired and since he hasn't responded this felt like the right
> > thing to do. Just send a patch to add him back. I see no reason to not
> > have Andreas step up to maintain it.
> 
> Removing someone just because they have retired feels odd, but hey who
> am I to complain.  I did reach out to him when giving maintainership
> and he replied although it did indeed take a while.

I mean, we can surely put Joel back in. My take would be to remove
that person from the maintainer entry because people will get confused
when they don't receive a reply. But I'm totally fine if we should leave
Joel in.

