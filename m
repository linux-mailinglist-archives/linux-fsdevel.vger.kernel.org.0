Return-Path: <linux-fsdevel+bounces-53692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0377AF606F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31FD3B517B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A630B9A4;
	Wed,  2 Jul 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T/0X5JsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD28309A75
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478830; cv=none; b=ej+p7UsPQoaGTrrQCs1gb1Z6DuzTuiUXgjq7Bo2DHeA1JfZHTAu0VuyHCN0fkzCgmU+EYSHyEO50ZykTttkuEBg7ZnhhUEK/t64+yZdLO5/yAl6oRPXNa2gWJGyWQqtB2NemWRba1QnoJSbeSWU43SEPYRTLVjwDpqT1Y63phW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478830; c=relaxed/simple;
	bh=RG6kDLoXRwCf1N7Yaw0WU2DTaFH2ftCRrZV9+yZfpvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlKH+2ez9ljvX6lMkqWA7X0PI5LxmiNaGKwTtH4+M8xX5U6RJroFhbZFv2n9lzh8sYldvAnshcjv28IA8E5JGf0UBrJ77aOoaagIUZSg26fUrKZ8WuqxHFOmEGX6ABeNioyKcMTrdqRihXOCC4L3RKCgMdnvTo904ECxHlyottg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T/0X5JsO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Jul 2025 13:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751478815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RG6kDLoXRwCf1N7Yaw0WU2DTaFH2ftCRrZV9+yZfpvE=;
	b=T/0X5JsOzHMOSQHvnsWVjmw6jF1LKzaKBliLfCKf9goT0wnVGdHoInw2zAGeqkDsmTNMSD
	Zg93Btjybdls5dsEWzTbODd4Dh5/sPRo2UHejKv2Pb5Lqbn9lkFRcLXeYT4kfwu37vqro8
	5Z5NAaK09pcEO//ryWmkBcDcVtrvG7w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Carl E. Thompson" <cet@carlthompson.net>
Cc: John Stoffel <john@stoffel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <fomli5univuatcdc7syty56wffm4uvslocxkufks27otyix7fl@6c5i7w7g64qo>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
 <26723.62463.967566.748222@quad.stoffel.home>
 <gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
 <751434463.112.1751478094192@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751434463.112.1751478094192@mail.carlthompson.net>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 02, 2025 at 10:41:34AM -0700, Carl E. Thompson wrote:
> Kent, at this point in bcachefs' development you want complete control
> over your development processes and timetable that you simply can't
> get in the mainline kernel. It's in your own best interest for you to
> develop out-of-tree for now.

Carl, all I'm doing is stating up front what it's going to take to get
this done right.

I'm not particularly pushing one way or the other for bcachefs to stay
in; there are pros and cons either way. It'll be disruptive for it to be
out, but if the alternative is disrupting process too much and driving
Linus and I completely completely nuts, that's ok.

Everyone please be patient. This is a 10+ year process, no one thing is
make or break.

