Return-Path: <linux-fsdevel+bounces-57573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3618B2398F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FA57A996B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099F2D061F;
	Tue, 12 Aug 2025 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKNOQ+Gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C32D0607
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029016; cv=none; b=XfGhjuQI8DK2qca5Ui0ELT9qlfoRvXFthkRZQQvaMJrQAjMUg8lzS4mT+DmkcrhYx3RLJc6HXKf5FVADA062HyyzGcvalO3BpL7OjsRmxB/9O+0ZNBwbvWuritZr9GAjjomXLPCrJZIoAbL1ID5PyD3WYm+NL3weFA7hk62d4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029016; c=relaxed/simple;
	bh=5vZWpZjwdID+s/bkQwTfXPHrTBqCqDOHo+Ktpq0sR9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2pcwVErJtuTgyC/cA02HarS6e4MXCpybVuoOVBkm+YAhTHc6kcwSj0DY4JeNNukdXvmIiiLIi5b06KRTx27KjaQXG0+qIiOO4Zix6zISVzKJ/iDiwQu0ymlZOk+b4bSbCZY1AH5QDzjqf21vg1R1U6hh+WO1NM74119LMTHKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKNOQ+Gp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 16:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755029002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjCWEAfVZ1JKE3cLBf7XFhGUauy6KegYe0SSPC8cFQg=;
	b=QKNOQ+GpjdEwl2Z6Z37GmXvXg68IzALo5+fFWAWWu+u96q1JdA3e1TLzbDWzAIEsB+Fmwo
	NLO7YTuzSJzzKnni81wpOksivQaxKlpnAHahvynW4CeCd/HA8Qdo48mGciOIBU7g5uF0Lo
	cQuEzo+3PorW+Zdq/uT92HdOF3qI1sI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJuXnOmDgnb_9ZPc@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 01:35:56PM -0600, Keith Busch wrote:
> On Mon, Aug 11, 2025 at 10:26:03AM -0400, Kent Overstreet wrote:
> > On the other hand, for the only incidences I can remotely refer to in
> > the past year and a half, there has been:
> ...
> 
> > - the block layer developer who went on a four email rant where he,
> >   charitably, misread the spec or the patchset or both; all this over a
> >   patch to simply bring a warning in line with the actual NVME and SCSI
> >   specs.
> 
> Are you talking about this thread?
> 
>   https://lore.kernel.org/linux-block/20250311201518.3573009-14-kent.overstreet@linux.dev/
> 
> I try to closely follow those lists, and that's the only thread I recall
> that even slightly rings a bell from your description, however it's not
> an accurate description (you were the one who misread the specs there; I
> tried to help bridge the gap). I recall the interaction was pretty tame
> though, so maybe you're talking about something else. Perhaps a link for
> context if I got it wrong?

I've since seen a lot of actual test data from SCSI hard drives - fua
reads are definitely not cached, without exception across manufacturers.

On NVME the situation is much murkier.

