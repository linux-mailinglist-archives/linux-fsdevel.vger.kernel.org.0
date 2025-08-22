Return-Path: <linux-fsdevel+bounces-58774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E2B31654
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E050D7B46CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6502F83B7;
	Fri, 22 Aug 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuFB6ivF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A162291C3F;
	Fri, 22 Aug 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862188; cv=none; b=D3WNR890uZxbjRL3R68pCudY8t+O3Jc5I7lr1RPr+4nW1tDlxikemO13/ZSlpY/nOVN1YLD+UBdACXmMwltfzUW9HS/xK5A+c7+1JouQ29+JlDbhD51PyP4Z8EgxCVYIB3C7eUQrsohJ6XKv1Uq+lavcAX2GJc9zetNk7ZDmsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862188; c=relaxed/simple;
	bh=bbC1YUgNLlBy5q2Utej8KQ1LJRsDhI7+Q/Jkxo3uDXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuMfTqRX9TH618bgHzksSYdtlDUKP2N+4idhnzxpMLmD7q7V9k+lOqyyYz9yrwwstKtt+l1X1LSVWe93ybYrr6G3d33BaxUFqC64A/zVDqJ4VK1DOFbsanI9jgSaxjI5Y2Plcal+SyUPoy93lXrB1+abf4RjMNSt0CX8kIKEjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuFB6ivF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC67C4CEED;
	Fri, 22 Aug 2025 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755862187;
	bh=bbC1YUgNLlBy5q2Utej8KQ1LJRsDhI7+Q/Jkxo3uDXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GuFB6ivF+/M5Oqce003YMkEhK6a3TME8O9Aztjv8iDW8HikUnT84GXV88NJSn90Gz
	 uliB2R+wGtK/9MCSnUZkv/nHMBFPpln1kUXos9JeC8wg7OzbVhiZg2gLhUUcnLPdlD
	 t6vvcgziZ1GM4W36WF6kcOfZJe3TGG+z/2rm18etBWL3kUvelnP6QA0Xca24UOvVv3
	 rIvDqfccJysDWF1duqPf1sHyLm8P+DIhS793WMZaMqVrLQ4g8MhSCbV4iKrgFqUFzV
	 N5Zel6LZcHkPsE5BS6169mumdF7VyOUuspFWgJDPM4A7CWtH2SaH8lWL4w2BoPgsEp
	 eq9xEGkEdfQTw==
Date: Fri, 22 Aug 2025 13:29:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250822132943.1ca76a8a@foz.lan>
In-Reply-To: <aKeb8vf2OsOI19NA@casper.infradead.org>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
	<20250821203407.GA1284215@mit.edu>
	<aKeb8vf2OsOI19NA@casper.infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 23:21:38 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Aug 21, 2025 at 04:34:07PM -0400, Theodore Ts'o wrote:
> > There is the saying that "bad facts make bad law", and the specifics
> > of this most recent controversy are especially challenging.  I would
> > urge caution before trying to create a complex set of policies and
> > mechanim when we've only had one such corner case in over 35 years.  
> 
> Well. we may have dodged a few bullets before now.  Just in filesystems,
> I can think of Hans Reiser, Jeff Merkey, Boaz Harrosh, Daniel Phillips
> (no, i'm not saying any of the others did anything as heinous as Hans,
> but they were all pretty disastrous in their own ways).

There are other cases as well: there was a media driver maintainer that
did pretty bad things, including physical threats against other
maintainers. I even got a report that he did threat to life another
maintainer who complained he would be violating GPL copyrights.

> I don't think we can necessarily generalise from these examples to,
> say, Lustre.  That has its own unique challenges, and I don't think that
> making them do more paperwork will be helpful.

Agreed. I don't think those few examples have much in common:
each had different types of issues. So, I don't think any text
would be enough to cover such cases, as they're punctual.

Probably the only thing that could be more effective would be to have
an e-signed CLA for the ones which become maintainers.


Thanks,
Mauro

