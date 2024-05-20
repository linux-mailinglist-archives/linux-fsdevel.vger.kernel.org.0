Return-Path: <linux-fsdevel+bounces-19807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA78C9E30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2791A287B63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B413664E;
	Mon, 20 May 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="KngA7ggd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcQS+Dwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A411E87C;
	Mon, 20 May 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211822; cv=none; b=p0MPhX5oNiIQmb1+rjH0R3wHUc1fuOreiL6aWLaM1tHLEwS4HjkEmlxc4fTi2w/HYuN3hYmFi3YJWSdS5kkxIgTdHZtma6kEE2+QxPfikpX/BRyBku6MbFpOOwc9TpRGcmIYm3F7UD84LOgv+SoMHr/g5uMG4391l7LnQ33Se1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211822; c=relaxed/simple;
	bh=qfvNWKn/CQRVv/+cpmMCpprLiCzOA6G5IF/qyBsiOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gpk8NCBnmy1GBPYQRAc1znoPkHSW2KmH1tZLOc58kqa2YU6bVP4/2kw7ey2HgFm4DazYPXW1PcfcyA461AoJ0768c2h7fpx+r0/oqYpuwlb+u8RA933G+TcET83gV1rpXB9zzKds6malH8azet8lEpfVzywomU+erHRWimHDrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=KngA7ggd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcQS+Dwp; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1F8EC1800113;
	Mon, 20 May 2024 09:30:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 20 May 2024 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716211818; x=1716298218; bh=oa2W4qjwd3
	7BEc4YnG8uAq9YoHRdThoet19LMJypOJk=; b=KngA7ggdi0drYPof5o7hwmTHRG
	S1IU/jqt9f39+LLVVayq0jCaruRqJLTNA7Ks8icMsmbv0cfVRKGccFi1pljVa866
	SYJhvYcWV71/wPhdtsupKguUSphYy8FMJmGL+5CUUFDCMZuKdCPQj2IYpCuetuId
	Ng4rjvr5M8VMsDg73uJZbUx7uiSmEl3qt2cXtvH0vlyNJsSJNqzIt2nw6mWG3ueS
	S3bBtq351+HqbQaocyOy1b5Kkgu/XtWYxn0VotlTQg9VSZ25xjNw+EzqymjBmTTS
	5jPxtYWLB11th1PnC8tJJ65cUBo/TnEkX2taPHdxyflnBj/zCniAj+McRJxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716211818; x=1716298218; bh=oa2W4qjwd37BEc4YnG8uAq9YoHRd
	Thoet19LMJypOJk=; b=jcQS+DwpjR6VeZzuQ0pdwmbkcf2+ELvd20o2DZOzD9JW
	K1Ouc82eECZh2CUyAZmcpgiJ7Aj+RGF+radye4kAqANBgqeSFC5Kc2RS6r73Qq78
	wQavmUkdh4ZZyLtkeXSLaEfd/rnlxvhQ4uOL9a+JLfA5zqGV6o/L9jVXO/oK0LQx
	bcN0cQZ5j0UEtgvbU4c3Qm2USaSBWjT68DDFLctcd6yIURrxVx1cxwHiBjvS0/2V
	AXPv1wbwPmFkFQ8Xz7F5VxiJnuNqQrcN4kcGxKU6hstqC/KeJC34xetLKaWaTR8n
	0zOYgO/KgxUDu+2UCJP2h3fO5zWI+MJIk5LWg8D3Qw==
X-ME-Sender: <xms:aVBLZgSicgZjJPlIVVmqiGzabXmY7U6W-0cf6XlPPGb9FjAoRo3i3Q>
    <xme:aVBLZtyvBNjibT9OIXMtuxSODDNt60MW4Zx1rQGGupWpM5STLV47xJdGO5ceQHoNp
    Hn6WzBjyUeeWu9cDQM>
X-ME-Received: <xmr:aVBLZt3gLg6GCxVnil1t54Zgi9M7nf9iJDLZJfgCKaz2OGOO9cDYTRLuhNRlBinQj-htlu-2o_0zCBcSoxwySoI5og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepleevudetgefhheekueekhfduffethfehteeftdfhvefgteelvedvudev
    teeufeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:aVBLZkC4m14s5n4tEp3avfH807qvPwncZ2I4Y8fgrQLUIdPf_FIzKA>
    <xmx:aVBLZpi3GscB2ljoVCtHmBhYuWCIGQjJd8VIwqqSfz5mb8dIqOnIjg>
    <xmx:aVBLZgpYWVjDC5IVwGQHAI3G5RpzgHOfzQpd-FVNiarwtvRY71MrWQ>
    <xmx:aVBLZsgJ-Srgc7YF2SLDksEcZPHG5z1ImBm8SgQp1vv6jyTYTnoSJQ>
    <xmx:alBLZoT0XhJL2dv8tXkxE_p1f3DxUlYY4oWx8zECBUg_U-dVblg9I4z5>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 09:30:15 -0400 (EDT)
Date: Mon, 20 May 2024 07:30:14 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
Message-ID: <ZktQZi5iCwxcU0qs@tycho.pizza>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516092213.6799-4-jcalmels@3xx0.net>

Hi Jonathan,

On Thu, May 16, 2024 at 02:22:05AM -0700, Jonathan Calmels wrote:
> +int proc_cap_userns_handler(struct ctl_table *table, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos)
> +{

there is an ongoing effort (started at [0]) to constify the first arg
here, since you're not supposed to write to it. Your usage looks
correct to me, so I think all it needs is a literal "const" here.

[0]: https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/

> +	struct ctl_table t;
> +	unsigned long mask_array[2];
> +	kernel_cap_t new_mask, *mask;
> +	int err;
> +
> +	if (write && (!capable(CAP_SETPCAP) ||
> +		      !capable(CAP_SYS_ADMIN)))
> +		return -EPERM;

...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
explain why.

Tycho

