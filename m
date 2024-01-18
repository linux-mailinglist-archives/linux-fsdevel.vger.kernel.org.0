Return-Path: <linux-fsdevel+bounces-8229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CCB831277
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 06:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093EF284165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 05:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE628F63;
	Thu, 18 Jan 2024 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MNtkIGsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24B79D4;
	Thu, 18 Jan 2024 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705556131; cv=none; b=ETgKGW8SM+XoiZmDzxT+VPqqQncqoxj2/usSM3vxbsNWO3A0/WeX2oisfbe0do81BLIPO0aCzHD3bFyrWgyGVkCvrQyn7TZvYgewVV5LbrEFPSxy0J2H3vLbX7ZPn8tM3seGuGo1t3pBDtLh94U+t1u2QGxx1z0w49ew4sh5Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705556131; c=relaxed/simple;
	bh=LzhELx9h/U3h0sODMzPzGL+liQMJLMUOPLsau3AmHcA=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=gRfXID9QmgchD2MeuHft24U/x941xut7A7r18vQ696j/1oiaV4A3VtGByjrvcx7dz6W0Ud+X0lUfIMugtZXszRRaNdYnrbNQx/AwuRXFXKhVJFW2KcomhnhQGViY7X45UTbaiGhkIHJIiWjxsnv7xkESitLYGvO1mpRR40xhXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MNtkIGsz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dH6p9SMJNPi+ukFSRBSjYz3JqljL0xzAdUNPFPGLjN8=; b=MNtkIGszG0wjyKy69ZChUe34pJ
	I9qgJLnzNof+kFnP30VaWjvapB5VfCSGR4/ZqawI3a9cwUWnHBsZtoIagpZ4gBI/etsgnJPKy9+Z+
	24NfymFoezA1htxrNuWZiVSWhhcShszSc4bBaFEfoyAf2PdaYtOW0myN2BRnci8bpyqikpcrMyPy4
	o4JmwO+S6B78p6hGvGplNaift93ECgd59muZJ9qncEM4/94+iBVml1Y+fSKhD8KYx4vK2YbhHZHYV
	O5LIcd0nJtSn+VxI9hDufL4NGkV4im3AbZlqTM7ZEik1920mShuOQxa4m/XppLvv5rc3dd7cBIlN6
	r2CdE+0w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQL3c-001iKd-19;
	Thu, 18 Jan 2024 05:35:16 +0000
Message-ID: <34862fc1-1cd9-47e3-b8e1-3fcce6ff7cf7@infradead.org>
Date: Wed, 17 Jan 2024 21:35:15 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Theodore Ts'o <tytso@mit.edu>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Nikolai Kondrashov <spbnick@gmail.com>, Philip Li <philip.li@intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/17/24 05:03, James Bottomley wrote:
> Finally testing infrastructure is how OSDL (the precursor to the Linux
> foundation) got started and got its initial funding, so corporations
> have been putting money into it for decades with not much return (and
> pretty much nothing to show for a unified testing infrastructure ...
> ten points to the team who can actually name the test infrastructure
> OSDL produced) and have finally concluded it's not worth it, making it
> a 10x harder sell now.

What will ten points get me?  a weak cup of coffee?

Do I need a team to answer the question?

Anyway, Crucible.

-- 
#Randy

