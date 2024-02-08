Return-Path: <linux-fsdevel+bounces-10803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23AD84E789
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD0D1C21946
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42C85C67;
	Thu,  8 Feb 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFIO8uGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369984FCF
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416217; cv=none; b=CbKNM4gIknbplnN3Maiz7fYzYEB7hzIYR3NLL/MQpSc5QFMZmBZXZb02D70LiOFEp5DsJUCnvgi6NjHrsFlr7YaoA5acym49QJQJwUnQMw2QtsZT+WCJ19CDW5xlU1rx93Q8lZYk1dM0s8XTSqPsAWPDjHUq1JeErNLQ66HejJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416217; c=relaxed/simple;
	bh=rNIUCtETKvDI8Hv/odLDvKRUeV4HCM5UfBToRIWw2l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFhDA0N6M98GjAL0dRUevis0P4WrSxydy/jN5Qr/VMeahBFCTHVnEtxoMwKlxVBKmRTPkScj5GQYjFrggoQKxgd1TzoA0uFSU7PjMR541OLoK2Oqn+wOzdCyOcfc/bEtPsriZzwsCLazCWWehchFNCLRj4MGj7U/QwUN0MEI5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFIO8uGd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Feb 2024 13:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707416213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohRz5RiPMWtF4kQys3+fHCi2fJWaQsjPzFcmqjjn6uQ=;
	b=mFIO8uGdB89nmUic8AwkwN/N7++x061NZ24AL5tSHcH20Bn48dQ0aCv55vQ+DPZgSka/d/
	O97djDj+V69+bOVgngSYsLduPsvSQL+2wjDGJ+vSerWricoq3Dg4Cvs75I/gPLqF/zhGHQ
	eBOJfNpCxn0YhcEG9yW+iZxlh87LweM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <udx7fz67ooha5cv3hkphb5pyuoqefgqzrr27at76beixeofqgv@hfsqreh2ozlt>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240208-bachforelle-teilung-f5f2301e5acc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-bachforelle-teilung-f5f2301e5acc@brauner>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 08, 2024 at 10:48:31AM +0100, Christian Brauner wrote:
> > Christain, if nothing else comes up, are you ready to take this?
> 
> I'm amazed how consistently you mistype my name. Sorry, I just read
> that. Yep, I'm about to pick this up.

Gah, am I becoming dyslexic in my old age...

