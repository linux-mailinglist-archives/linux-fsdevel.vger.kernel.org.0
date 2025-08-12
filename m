Return-Path: <linux-fsdevel+bounces-57580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA3B23A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D737B686F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84E279DC3;
	Tue, 12 Aug 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OjENRIV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE632F068A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031556; cv=none; b=cK2baEp40Fwy9g62/+jfJ7qOQ/xTPNr+UUpOmiTRartSeQ4YrD6tSq+aSuh9DjsbHKT3SshrYD4mJL5OaPsdfCFmklaayhXyoDxPZtKD7VtXlrOql+d3vpCcK9byTc4aGYGz2XdE3RIISqpeIH5tAPztPHWvc7v13/blTlgEoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031556; c=relaxed/simple;
	bh=8MqyDSFkEt7mg65mlywgZHiiIfjJoE2jx19BD89Xdcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwjM0oPsBRXS01P1NUhVqYzO9T8NQDWoCQza4yxlGrESkLvytgGfVyVfoR2uY0zZciumWrswa/0IvHru3C8E1xaFKaCBjaKfzHiT0V7Dgt6O9VIQH/CHES6AW7TWA0HmcQlw0gAGrm5DoQ7LJJIQgToXQwXy0RFN2pCo5VIAx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OjENRIV0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 16:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755031552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2pTVoQTLKjrUX6x4f/chQP3w0zfUdpPOksIUsGPHyY=;
	b=OjENRIV0cD0q9IY6SMPeUS7H+yAQihLzxd8eUX9LYiWDt3tQjf+6bV2/RTucjFKP7vAA9R
	8/6cWdZlvbz4Jyv92On38UMShtx8lO0UziLI/4dAvDZNo9kXU0S7NSg6sxFRONZen1jEZ7
	Xii4hzknFbivoFUBc8krSovxPmOPdio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <ib4xuwrvye7niwgubxpsjyz7jqe2qnvg2kqn7ojossoby2klex@kuy5yxuqnjdf>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
 <aJukdHj1CSzo6PmX@kbusch-mbp>
 <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>
 <aJumQp0Vwst6eVxK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJumQp0Vwst6eVxK@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 02:38:26PM -0600, Keith Busch wrote:
> On Tue, Aug 12, 2025 at 04:31:53PM -0400, Kent Overstreet wrote:
> > If you're interested, is it time to do some spec quoting and language
> > lawyering?
> 
> If you want to start or restart a thread on the block list specificaly
> for that topic, then sure, happy to spec talk with you. But I don't want
> to chat on this one. I just wanted to know what you were talking about
> because the description seemed underhanded.

Not underhanded, just straightforward - I've seen the test data, and the
spec seemed pretty clear to me...

