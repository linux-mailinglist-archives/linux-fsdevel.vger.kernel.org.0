Return-Path: <linux-fsdevel+bounces-60772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D6B51975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB3E16EDBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F69324B39;
	Wed, 10 Sep 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIpS7Lvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655831AF06
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514863; cv=none; b=kW9A4VPyd/dfYi994YyNu9yfMTG2taCo2Z6qsMqud2eF1Uzqa0ohDrPPf97QsURS0i3Y9DeqZ/+4khOGhoOqw+J0iIBsWTZdCkIEg9s3TEhfhxrRVx5flryg8/hYaqtiA7BTqQPi7rKzZ7sqGm/EpXtJZD6K+y7XeO4qYJ6TmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514863; c=relaxed/simple;
	bh=kPzGLA4SZw5UAqzJ2RcglIRHA3YYBSdEJrmsnFRP0Hs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dRuDh5vsJxlLKaXfjPdHoOvKAmNsOIsRQsCFm7O93LzETpRUcVgGMZI4rXLBygWoDsf+ZpiMInfIUjg8LxyqwvjrEfjcpBfScnrHUm8awztzkgQkTnjQ55PQKrsDdBY0z3m1qP2Sj8qvTBFz5KV71+QVabKJfvpne17V8gwzp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIpS7Lvy; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757514859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPzGLA4SZw5UAqzJ2RcglIRHA3YYBSdEJrmsnFRP0Hs=;
	b=qIpS7LvyBAUfyvsbOTdcfzW2n/zeC1lqza3tt2crAHXwG/SYPtJHLAPkFZIizcAEPgNQ8q
	u4mXXAwWNK0I4O0PFkZ+QkcR371PFU3MktJSOaqXNczdP4NMIYmXjA2ev+wpJ2lNszPZJR
	SpUPuSNbGM3zyhdwD8vdd4lxBoHs/ZU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] initrd: Fix unused variable warning in rd_load_image() on
 s390
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250910095237.9573B41-hca@linux.ibm.com>
Date: Wed, 10 Sep 2025 16:34:07 +0200
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B3D03364-B03E-40C8-AC1A-A31C32263323@linux.dev>
References: <20250908121303.180886-2-thorsten.blum@linux.dev>
 <20250910095237.9573B41-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 10. Sep 2025, at 11:52, Heiko Carstens wrote:
> Instead of adding even more ifdefs, wouldn't it make more sense to get
> rid of them and leave it up to the compiler to optimize unused stuff
> away?

Yes, I'll submit a v2.

Thanks,
Thorsten


