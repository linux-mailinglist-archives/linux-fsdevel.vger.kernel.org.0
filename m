Return-Path: <linux-fsdevel+bounces-57394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015BB2116E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5223AEA2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2051296BC0;
	Mon, 11 Aug 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WtqCiMzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0A296BA2;
	Mon, 11 Aug 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928502; cv=none; b=PZ9K3ZgQNoZRkgFfuaV2CgnuPq6ITzvdrTPz9xMlS3xv7HkQFMEdxDTmxt/u96fmbG8nnetB5bKOqJsDQqPx39fkddVlMojlDNqcs2AtkIrA8YPxubhgWuQqhy2vBNBtPSdCUjs6zWGS0/vt7xI+vOl6HDKps6as9qc+/rrgDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928502; c=relaxed/simple;
	bh=gULV+9ocuXUCQKeLxStfFpyd+wgjqs5egYwZCe7mDlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPAxupd5qLrtYiDYiutp0zTzpaniBH/v8WxGjLVHg8wlCvRjpv8lzC960W2zGneMju/bVXyp/5WoJLlT5+L1lNr+CYRtpFgYmc+q0pD4u04Y2U1iD/yIyLIEqJEN+rfGWUbjeJc3YoiAxBaZryLvSI3vEdCMQKMm+i+Llw0uOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WtqCiMzP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Aug 2025 12:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754928497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ4kKog6D48XJVshhAwwLan60T01jfwSyzHyz06FY+0=;
	b=WtqCiMzPGG5EeBoBEN2M+z1hQlSqZ/kg6rD5v6vp3oOAAn59Pq5iszEbegA27aAASQocRt
	ngc6hdlxlmta6VoCFn894MlsgjfmWqxkv8ou6J+mtsIi0anIdKE3zee5PTceLMcI0HivOV
	XAczChxDKvxskCS6v7Bc0ekpRvjIY1A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Lawrence <jalexanderlawrence@gmail.com>
Cc: tytso@mit.edu, admin@aquinas.su, gbcox@bzb.us, josef@toxicpanda.com, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, sashal@kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: Peanut gallery 2c
Message-ID: <ct5pqur2cwn2gulxuu277uomoknflxae32zzpyf4yqbrxcxj4d@p5j77u6xks4l>
References: <20250810055955.GA984814@mit.edu>
 <20250811154826.509952-1-james@egdaemon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154826.509952-1-james@egdaemon.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 11, 2025 at 11:48:26AM -0400, James Lawrence wrote:
> And since other FS maintainers are not stepping up to the plate and
> improving or implementing new filesystems to address their own
> featureset and branding short comings, I'm not terribly interested in
> what they have tso say on the matter. And neither should you linus,
> let them be upset that *experimental* *opt in* systems can
> (and should) operate under different development processes. I
> certainly give my engineers/researchers a ton of leeway long as their
> work is opt in.

That one is unfair: btrfs has improved greatly, by most reports (but I
also still see reports of e.g. multi device issues). 

I think bcachefs has been a bit of a kick in the pants for them, they've
taken some stuff directly from bcachefs - e.g. I believe they took the
basic design of raid5 v2, the stripes tree, directly from bcachefs. A
btrfs engineer asked me and I explained the design at a conference some
years back, and I've seen other solutions show up in btrfs that look
cribbed from btrfs. Similarly, the basic user interface of subvolumes
and snapshots in bcachefs is lifted directly from btrfs - it looked
sane, so I stole it.

That's where we're at our best, spurring each other on in friendly
competition, stealing each other's good ideas...

