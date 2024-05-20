Return-Path: <linux-fsdevel+bounces-19830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44C8CA2A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3623281747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF281386B3;
	Mon, 20 May 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="PcnX9rzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLa1niyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow5-smtp.messagingengine.com (wflow5-smtp.messagingengine.com [64.147.123.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60911137935;
	Mon, 20 May 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232831; cv=none; b=fh2cOb0V47mT9I3m3QeKQPzcIHNkVD5nYeEMkendmCbQqwI+0EduAOLPyEOCEpKZSexFszt7KYfR5N6d/bSuk3+3YCviFFJC/6iz6fMqnasgUk2hNCNOssmuvyXcJKseK6AnGvmO0VUiUYHk2fQ3+uAAQLNGk/SJsbNFHwQEKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232831; c=relaxed/simple;
	bh=oBHEUgxuOy3Gb3SSjzvFEwOATEjDLoQFe4gPk/cU3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSmAmvDdteswSKSOZw5qrdGPXYv+u8lj6SEaimd2PUUR+e8/vq09dOjE4awjaypL3fnn0WbkpJh0qAkB/HQVd8gugkTj00GrdFUAEQ5JchS6xhv27pzAKsVqhOMx2Qa/6WV/H7Pajm+GbSNNEFJ7smPFs7a8aE8pHH9GIMv5czw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=PcnX9rzu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLa1niyU; arc=none smtp.client-ip=64.147.123.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 959502CC023E;
	Mon, 20 May 2024 15:20:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 May 2024 15:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716232828; x=1716236428; bh=mO0EedKpcd
	HIsso5KUGd6iDgcS2AGEPXGB8hV4/SyCk=; b=PcnX9rzubBrca97DZrsVgCICWa
	JuiSf1k6djT2sFikn6eAuRpbOZU5lv5Bj1KvcUQAFi1pKJ706kRS0yGwhnGaglUp
	Q5Gw9xY5u6i3SgySAUVERfFcr7KQzVCCo3GhWOhYJAF8EFACZssHggqNs6MXa75H
	jG8ybiPYenaaz/geBonOqtTnd3jpjaIn0DVcaX6hspR6jyHYNGzRop+7cJhJAKCF
	a/vnSlOb8M+GNxyhXHt7PqgSfRkwYay4QFdDh4YlRrxN8m4UGYHCTSBDH2BEw3Wz
	q9mhqOUE98+dEnicxF/AXmtYshKzNmHJ0c0YAF3A5gW2kjlTWEMG8shAepQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716232828; x=1716236428; bh=mO0EedKpcdHIsso5KUGd6iDgcS2A
	GEPXGB8hV4/SyCk=; b=RLa1niyUuqomipMH6wH8n5ZPTPzAUDg26M3+U8ZJ3gKk
	frG9wr7yyFYQhg92xcqHHOy2kb7yqd4GqpWgl2dxppyYmws07gtgS8aVCNNduP/4
	G6ep8zG3tGKUxab1vECr7uefbgvO1uX5Az/YEj+ocAXD7m0Dc4wcAs20tpuu6X/A
	eCGB401w53Y4ui+5MM5ciJLIKNmIeuT8pIGpnIgtiGkOMjlGWD/iDI5JKgmA9lF0
	yOKhDRxQYMBRl6QknG8izF2gsIwsiJpw0ehYT6ZdxPh2RubGF+ijT0MVSNAG8Nc4
	Wl0S9T9Y/XQ2iQobpRojjP5FRcV2DcMxUjGlZjpBHA==
X-ME-Sender: <xms:e6JLZqL3F3B2aRCJ4w1S9WRH9slbVS04Anuc3Mq4dVF0uFsSre9bwA>
    <xme:e6JLZiIY_k-ZDk7QL_-QBKTGCi4lkqtA31fORwgqNxil4r9Jp9Y3zvFfgVuzNJX-A
    3-wDoQWoF_ozipb2vQ>
X-ME-Received: <xmr:e6JLZqsqlwtMoI0P81WwiLaEuT2yOboTSj1LwLg-zsZgJgbT0qxMktr2CeY8-tPlWjQ3GnGl1Vy6_ap5KNOU8ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeekkeetgeefgfdvfefgfeffueefffejvdduieejheejheffkeej
    keelffeulefggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:e6JLZvY4OqRPmhLDbSoNBf9SaSnyJhxd3ipvV7YA-JVJX_8F5wtRbQ>
    <xmx:e6JLZhYJA0-Y4UiDfcKcdBM3JdCdCTyL5lAtnDmC8vj7X55i9IPQ4g>
    <xmx:e6JLZrA-o1NbLbBFxj_rl6jjY8fNsBfo-ozmgIL2il_amxjjZDfpUw>
    <xmx:e6JLZnZisSO1vb5NFiGJfxQHXjZLXuo3uRGN8amQ8DjLajlWAl-eKQ>
    <xmx:fKJLZlqTk4UcPirAK9O5Z2cBz4ms-BwgWtuD-EK2p5_O71z9bjoeav0X>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 15:20:25 -0400 (EDT)
Date: Mon, 20 May 2024 12:25:27 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
Message-ID: <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
 <ZktQZi5iCwxcU0qs@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZktQZi5iCwxcU0qs@tycho.pizza>

On Mon, May 20, 2024 at 07:30:14AM GMT, Tycho Andersen wrote:
> there is an ongoing effort (started at [0]) to constify the first arg
> here, since you're not supposed to write to it. Your usage looks
> correct to me, so I think all it needs is a literal "const" here.

Will do, along with the suggestions from Jarkko

> > +	struct ctl_table t;
> > +	unsigned long mask_array[2];
> > +	kernel_cap_t new_mask, *mask;
> > +	int err;
> > +
> > +	if (write && (!capable(CAP_SETPCAP) ||
> > +		      !capable(CAP_SYS_ADMIN)))
> > +		return -EPERM;
> 
> ...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
> explain why.

No reason really, I was hoping we could decide what we want here.
UMH uses CAP_SYS_MODULE, Serge mentioned adding a new cap maybe.

