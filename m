Return-Path: <linux-fsdevel+bounces-7419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CA8249CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CD91C229EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CF28E03;
	Thu,  4 Jan 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MCTW69+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29401E516
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Jan 2024 15:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704401531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzI/Xr56gasgakS2cGy5UqcYQGUMuAr5ihmMpPGJ9TU=;
	b=MCTW69+I7VIBBwwIy9bILW1IpWe5T8xRRm6gNkTdoc9Rme/e3dvuzKwIjOakTDS+DSKBif
	CnptzV1NRw2UBY62hDcFYPwH0kMyzls/Ox0wMVOGB5TqFJS1pjey+9oubQ1J8V6PRrQNSV
	CxpjA61tQoJMciOPDJZrAo2TF3CIilk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs new years fixes for 6.7
Message-ID: <7pnbw4c5xvek3d3ina4etosspqjtluhbsfb67nwu7zgn4tzgfm@aeof65j2iaof>
References: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
 <6008735.lOV4Wx5bFT@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6008735.lOV4Wx5bFT@lichtvoll.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 04, 2024 at 07:13:31PM +0100, Martin Steigerwald wrote:
> Hi Kent.
> 
> Kent Overstreet - 01.01.24, 17:57:04 CET:
> > Hi Linus, some more fixes for you, and some compatibility work so that
> > 6.7 will be able to handle the disk space accounting rewrite when it
> > rolls out.
> 
> Is it required to recreate BCacheFS with updated BCacheFS tools from Git 
> in order to benefit from that compatibility work or does BCacheFS 
> automatically update the super block?

Automatically updated as soon as a new version writes to it, and the old
versions just ignore the sections they don't know about.

