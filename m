Return-Path: <linux-fsdevel+bounces-57462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4AB21EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71D91AA3307
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE8270EC3;
	Tue, 12 Aug 2025 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfN/qdiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EB2D4809
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982279; cv=none; b=IIs46mobGmTUWjD4MMFbwbxRuhQxSaFU5TdZ2RG9OcWI5urN71X913PrUr1p6FfY1/Hyt55LAmgQQxVXayTzHQ5OlIx3HwTmazWi0m/moUmvWUijniBgwTVc4yGg8Bwh4KtoP3FELOBey8JAEYpvDvSMge0Gz38pUx+/vybUn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982279; c=relaxed/simple;
	bh=7OwopZDjafbGIAuqdOR2s+/ndrmAQpS2pKrDCZKHuJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEvpQXBSPteuKN6mPDsPvcoh28ZAj+N5GrKLSx87EkpFybMaLMUXDaDVmJFllYZidt5AA6w/bRCdk+Mg6UzhqJG4V3NRiB2spIAk1TwWlO2LqpMwhwIbFKzTV+HCkVrY1hHgAUS/+ZkM8v9vyGWYtFD7W/oZYA3m3oBQ4F+/GYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfN/qdiv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 03:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754982264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klMyt9KRv+i97U0vE/OfVe3JfvDcHXg6Dz1tOxXGm4c=;
	b=vfN/qdivVKvNREefLMM5HmykabVkWzmp6N0dSs2LdMz9laxqfGEVbYQJahVuX3l5Id1ZmA
	IKpfanqV6j+S+8wJI1qSATMhbaQuRjxLnLlCKQbVrJYMqjcM+aCieFmqtRRCvVYL96edSt
	BR44U3UeRcGze/2lkG69CTGFDLxEIyE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: asdx <asdx52@cock.li>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <rabpjlpydnsnlkrgqmolvgg5tyo2kk5v45evwdt6ffetsqynfy@dt2r3cxio5my>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <c1516337-a681-40be-b3f1-4d1e5290cbff@cock.li>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1516337-a681-40be-b3f1-4d1e5290cbff@cock.li>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 03:52:39AM -0300, asdx wrote:
> 
> On 8/11/25 11:26 AM, Kent Overstreet wrote:
> > On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
> > > >   Yes, this is accurate. I've been getting entirely too many emails from Linus about
> > > > how pissed off everyone is, completely absent of details - or anything engineering
> > > > related, for that matter.
> > > That's because this is not an engineering problem, it's a communication problem. You just piss
> > > people off for no good reason. Then people get tired of dealing with you and now we're here,
> > > with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
> > > Will your sponsors be happy? Probably not either. Then why are you keep doing this?
> > > 
> > > If you really want to change the way things work go see a therapist. A competent enough doctor
> > > probably can fix all that in a couple of months.
> > Konstantin, please tell me what you're basing this on.
> > 
> > The claims I've been hearing have simply lacked any kind of specifics;
> > if there's people I'd pissed off for no reason, I would've been happy to
> > apologize, but I'm not aware of the incidences you're claiming - not
> > within a year or more; I have made real efforts to tone things down.
> > 
> You keep lying. How can you be so cynical? Just two days ago you were
> complaining on #bcache about how much control Linus has over Linux and there
> was a lot of talk about getting him removed from Linux via CoC action.

Are you the same guy who was just posting this on Phoronix? Either
you're trolling, or you misread something.

For the record, I'm one of the more anti CoC people out there - I agree
with the spirit of their goals, not so much the approach. I would never
invoke them on anyone; I prefer to talk things out (and I don't mind
getting flamed, so long as it doesn't get in the way of the work).

