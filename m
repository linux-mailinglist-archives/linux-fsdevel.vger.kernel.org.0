Return-Path: <linux-fsdevel+bounces-14368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8687B449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F2F1F2293B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4859B7D;
	Wed, 13 Mar 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JayZT0gC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536659B4D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368604; cv=none; b=UBeFz//+TcMzlaV33VgAcE9ktfLxMhVqi5/gHj4N9RqfXLIbY7qze/++FkoYTdBbEjjmF+YnFgKIQqsY66u63CLeu1/eil8lpNdgv76lFOdAlpBzZObX1aWcz8aGYVYHryMt8+B5/SzSQnir852XqFMAuEvIm5n5Gt91cS8RCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368604; c=relaxed/simple;
	bh=PZG5cRX3qQhXu4dXkIQZpq03uK2kDc7kp9VzX1tWb98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkINoFfZM5IGMunAB4vTc7oA/YvcHIR+7Fjjav18bi1Oqv6K7ydG1T00Q2Yv/I/blj2PlXttbQzRpfb2GSSDfNn8jOw7e7ugxgDNOZQJUkG4FKkAB30prDqnw9nBp9ZRy0Br2nHWSS9+ppjlXaGOEXASweVlcVDdnu86TIYjN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JayZT0gC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 18:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710368601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ej/n2ekg+Kv/YAEOWW6eOfRdqaxPcS5Y8kZhD/22lus=;
	b=JayZT0gC61yuifMb6XpSXr3kHmjBmtpxNh0YLWPfhTIVudGk1ES92eYWfgu2kqyZ15EIb3
	EA0X6S1hTc3d7HPW+bJ+OBL3aNg8bnQl8zFBBCKWo92za96DrCcnOCZbikOZFPu0aHNMh5
	t501lEbDbQ08wq3lZC6Pt0KynKZgtGI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.9
Message-ID: <hbncybkxmlxqukxvfcxcnlc53nrna3hawykbovq3h3u5xpm7iy@6ay4wjnpuqs4>
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
 <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
 <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 02:51:38PM -0700, Linus Torvalds wrote:
> On Wed, 13 Mar 2024 at 14:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > I liked your MAD suggestion, but the catch was that we need an
> > exponentially weighted version,
> 
> The code for the weighted version literally doesn't change.

Well, no, and there's another problem I can't believe I missed until
now. MAD is defined as median of the absolute deviations, not mean, and
you can't compute a median incrementally.

So MAD doesn't work here at all.

