Return-Path: <linux-fsdevel+bounces-73195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FFFD116E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19DDE302015B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C42346FA7;
	Mon, 12 Jan 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8Tm0BOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4E3128A0;
	Mon, 12 Jan 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209258; cv=none; b=IpjKGd2Selx9ZYgazhI/WYiqkYZOaAOhKxjwILdNWyVT8G6+80HXXLLKRpybAt16EZPRAPoekcvpuk3Eae/jKffG4rkPPBnWZt88DmuSYI9E3wH2xWInD3nhK4W9rGlm1Sb60hE2h83gK7QyxqSbANDZjnhyaXVkDHkF1B9PIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209258; c=relaxed/simple;
	bh=El49wXngCxcDbS2huc5sjL1mwHbwLCRB8Y6q80OKsSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ65et+qoauCr2ddldh9O9W3a9iZJkkLmnnbZUpasTu5jGqmJMBeSEt7sPRxHGW4omMvMn+dwHssAvmhNckOou/cPSY2eLAmmV6Lyqjhj15E3NE4k22Z3syxurLYs8CHgnAo74fIvrzziSAH6MAylUM5hh7H5/Ts84ZuToB4+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8Tm0BOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F5C16AAE;
	Mon, 12 Jan 2026 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209258;
	bh=El49wXngCxcDbS2huc5sjL1mwHbwLCRB8Y6q80OKsSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8Tm0BOeJqBE3hppZd7gxOZWFXZ4XCv1Sr0iIxwDPxhJH3P42DdqLGuXWl95Ur5i1
	 wdIylCGI27w5e0wio9DZKETB6KHH1rhZCsMAWjAhqKQo+Eea0dMQvkrMwrscD6Gz/Z
	 mZWJJ1nYT40fDNqbU3T4bSHXzpi6FHuVbS3zN4nu+shuuAuWPVYhpY0mJAUPxKCDFw
	 QiWJOkq/nM/fqQP2hd0aogvbaMNeiQWQf2vPGny5pQqr7dwWNvA9s+N2nekhfLwhpd
	 ALrBl9wP0ezaTdINwdE4p86hki6gjakryn3aBVdSXAWAqVWz7drKmhVKx3ENLa/760
	 PVSXUML+OfCZQ==
Date: Mon, 12 Jan 2026 10:14:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, djwong@kernel.org, 
	amir73il@gmail.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Message-ID: <20260112-begreifbar-hasten-da396ac2759b@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>

On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
> Enabling page cahe sharing in container scenarios has become increasingly
> crucial, as it can significantly reduce memory usage. In previous efforts,
> Hongzhen has done substantial work to push this feature into the EROFS
> mainline. Due to other commitments, he hasn't been able to continue his
> work recently, and I'm very pleased to build upon his work and continue
> to refine this implementation.

I can't vouch for implementation details but I like the idea so +1 from me.

