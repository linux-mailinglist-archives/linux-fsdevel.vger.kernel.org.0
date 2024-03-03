Return-Path: <linux-fsdevel+bounces-13407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490386F7D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 00:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BB41F21159
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425657AE68;
	Sun,  3 Mar 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b372F4b8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F96CBEE
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709507998; cv=none; b=Ij8bEJCRuuu3PAdISCGa50XM1R3kVV1oxvpqZ9CHr3WCTYcPlejwevxw4W8So6ippjG0QCi4qP7s4X9g7dHegjWOCMgREwWo0s1fKxoPpfi3nZaxI1lFv+YFRMHn/+uF13YlBzOVX0L0AyPAovX4wNVEWN+msKzScFVCTZkWEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709507998; c=relaxed/simple;
	bh=n1BS9H8d0z8l7HhXEOJsWbGABKdmonMD0uQ/QhY4MDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB/ifQ+BYikixUBymAvzrtPM7RlPPWWlcsI1JcP2/p8Jwpw+jGSW1lvNudwhi4W8XEsPMen+PrNV+MRClzTTpre36sIevxuiZCex1XBvueqJZGaKq5+Nl0gBtfN+MZBW+TEEDAyeBAchmQsbeI+zjz0LZswcELg3Oq/6Wag3gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b372F4b8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 3 Mar 2024 18:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709507994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OI+GOe2Oo/c68Iq3c54VoyfZBRdwf/FSYJi+SDPdeCo=;
	b=b372F4b8EuCUm417N3BAtjnQsKZtDQ8dSxQPlP/YlSeynVTeokI9wD3eT5n/7ymBdVJj8y
	8BVunMHzxgMNll+GauGM+MYKxQQVsB18rSWMjes2bNGAaQ6ReZ7+DlFuOJiLhMrJ/aDhkp
	BUGVYrfKNVWSoeCBYjoX6ScmRrqmZiw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
Message-ID: <tis2cx7vpb2qyywdwq6a74o2ryjmnn7skhsrcarix7v4sz7vad@7sf7bh2unloo>
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
 <26084.50716.415474.905903@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26084.50716.415474.905903@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 03, 2024 at 01:49:00PM -0500, John Stoffel wrote:
> Again, how does this help the end user?  What can they do to even
> change these values?  They're great for debugging and info on the
> filesystem, but for an end user that's just so much garbage and don't
> tell you what you need to know.

This is a recurring theme for you; information that you don't
understand, you think we can just delete... while you also say that you
haven't even gotten off your ass and played around with it.

So: these tools aren't for the lazy, I'm not a believer in the Gnome 3
philosophy of "get rid of anything that's not for the lowest common
denominator".

Rather - these tools will be used by people interested in learning more
about what their computers are doing under the hood, and they will
definitely be used when there's something to debug; I am a big believer
in tools that educate the user about how the system works, and tools
that make debugging easier.

'df -h' already exists if that's the level of detail you want :)

