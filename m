Return-Path: <linux-fsdevel+bounces-18914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28BF8BE769
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7948328363A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64F1635DB;
	Tue,  7 May 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wszb102x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58F15E1E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095677; cv=none; b=iDqTkwxwlKjkAKieqm0LVg1BYgchz0ZRdKxD+Q198fhL0X746jvwtcP1njTBkp+rQpuGSSHO3VY42drIA8Rui/8OXddF06x5ckPTS9FriVzgoN+dxaBrK8ueLGpbnw5BMZL/nYkER9g+5EANr+g1mBU0uDx1dyDScYkANVI1Snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095677; c=relaxed/simple;
	bh=JWTCLRwTKdxklZuNp/Rib1ejNmFkuPCcRX13xVhfOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtH7fntZPG9d+1eb825H4U+TyG28RKEXvyB6IWw59eJHdti5Zy8aUXmEzkAsqjBLqMi1w0B9HKfruST/0gYGAZcDUUDWaRFb1tG9vG5OT657hSSixq9Y6mn5MqpazfYCYb533nQzlHXXsIaoXDdveaXViPTNk+h1lyN14VUn1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wszb102x; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 11:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715095674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQYetRaj2G06vixmhegXHGRS3pEXWJu8nVuWoNZuM7w=;
	b=Wszb102xULBhRSoFDVFMM3bZC8z1Blu4ylS4VJLjcwEZikXgHEFMfRByHU6iAzpDejSFPJ
	xm/HQKXRQEkqpcoRP1tvBVjSXMlNFGUYYsVmFxA5lfULtLBYzuv1pOWaQXGshgqQFKMG8x
	FmA/ieRp1nfcXtCdT66rwrJnEeKoS1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.9
Message-ID: <gqtaouixd7pmxyzttmyexwqzrziujo7ncqoc54vqhjqdnr326u@t5eolb2vdihp>
References: <3x4p5h5f4itasrdylf5cldow6anxie6ixop3o4iaqcucqi7ob4@7ewzp7azzj7i>
 <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 11:10:44AM -0400, Kent Overstreet wrote:
> On Tue, May 07, 2024 at 10:43:11AM -0400, Kent Overstreet wrote:
> > Hi Linus, another stack of fixes for you.
> 
> I have a report from a user that the sb-downgrade validation has an
> issue, so that's been yanked.

As a followup: the sb-downgrade patch was good, the user had at some
point been running an unreleased version (which adds new accounting for
amount of unstriped data in stripe buckets); and that version generated
a faulty downgrade entry (because it has custom logic for generating the
downgrade entry based on whether erasure coding is in use).

But I'm still holding that patch for now while I come up with something
for that user's filesystem - I'll probably add a flags parameter to that
validation code so that we only fail to validate if we're writing out
something new, like we already can for bkeys.

