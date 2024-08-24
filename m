Return-Path: <linux-fsdevel+bounces-27026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE095DD9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D21C212F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784501714A4;
	Sat, 24 Aug 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fiLzNgkT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C1156C4D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500116; cv=none; b=B/07XbJydWffSERrrMr+aJ+7slWEv3MpZogVLhgeHtSu1W0ndFK4Z751jb0iXd+jyhDrLbT4I7Fkj6EENMGPqPEQdOm8exum6ouwCgN98KJXrmzn1Y5f4QjFN30kJmyTUA+p7tvxFEYbsJQ1W4JuXAUUmvjnTvqTlKPXKoLw9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500116; c=relaxed/simple;
	bh=weh4v49Y8RDcsT98terEAy02b7b0x/RdxZoa+N/uwY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj0VzcL28vJbz7aHul7lLTIam+zh4aldNSqX7MyfdvMm8EXmcR0kd/hurg2EBp9OZsv1tAgxtfle1qzb11eMrcgDYb3QXUL+AYCqdZkTmp9xP8nEJO/dYHgNXOngsGLMxeDMNx8NlwAMrQbij5Cx+pqDAYh1mlWKBksDHqAytmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fiLzNgkT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Aug 2024 07:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724500112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weh4v49Y8RDcsT98terEAy02b7b0x/RdxZoa+N/uwY8=;
	b=fiLzNgkTkKmthEsPyMorc+MC3akPLmXVoObq0LCbhpe9U34oZQR8pEaDO3r6oH2JGrifBU
	vfxbcR+zD2lJmDZKW29Ii8UDAuJb5ImrOQT54s6UT94VrFmsDduVVDT2Gmi91oQ9NWjwo+
	SDX7c4/ePHnN4/YvF3tZ3NfqLkg0JmM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <7dwjsfnrxyxewrxsyznkl6kbgilnfisom7igpeyesmihktejqt@njz4xjtpcgw5>
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
 <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
 <ihakmznu2sei3wfx2kep3znt7ott5bkvdyip7gux35gplmnptp@3u26kssfae3z>
 <1816164937.417.1724473375169@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1816164937.417.1724473375169@mail.carlthompson.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 23, 2024 at 09:22:55PM GMT, Carl E. Thompson wrote:
> Kent, I'm not a kernel developer I'm just a user that is impressed with b=
cachefs, uses it on his personal systems, and eagerly waits for new feature=
s. I am one of the users who's been using bcachefs for years and has never =
lost any data using it.
>=20
> However I am going to be blunt: as someone who designs and builds Linux-b=
ased storage servers (well, I used to) as part of their job I would never, =
ever consider using bcachefs professionally as it is now and the way it app=
ears to be developed currently. It is simply too much changed too fast with=
out any separation between what is currently stable and working for custome=
rs and new development. Your work is excellent but **process** is equally a=
nd sometimes even more important. Some of the other hats I've worn professi=
onally include as a lead C/C++ developer and as a product release manager s=
o I've learned from very painful experience that large projects absolutely =
**must** have strict rules for process. I'm sure you realize that. Linus is=
 not being a jerk about this. Just a couple of months ago Linus had to tell=
 you the exact same thing he's telling you again here. And that wasn't the =
first time. Is your plan to just continue to break the rules and do whateve=
r the heck you want until

You guys are freaked out because I'm moving quickly and you don't have
visibility into my own internal process, that's all.

I've got a test clusture, a community testing my code before I send it
to Linus, and a codebase that I own and know like the back of my hand
that's stuffed with assertions. And, the changes in question are
algorithmically fairly simple and things that I have excellent test
coverage for. These are all factors that let me say, with confidence,
that there really aren't any bugs in this this pull request.

Look, there will always be a natural tension between "strict rules and
processes" vs. "weighing the situations and using your judgement". There
isn't a right or wrong answer as to where on the spectrum we should be,
we just all have to use our brains.

No one is being jerks here, Linus and I are just sitting in different
places with different perspectives. He has a resonsibility as someone
managing a huge project to enforce rules as he sees best, while I have a
responsibility to support users with working code, and to do that to the
best of my abilities.

