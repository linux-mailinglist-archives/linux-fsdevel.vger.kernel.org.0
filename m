Return-Path: <linux-fsdevel+bounces-60122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA1B4146D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 07:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E43B7B0C04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A72D663D;
	Wed,  3 Sep 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EcviD4KS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920482D640A;
	Wed,  3 Sep 2025 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878100; cv=none; b=m5PG+QI4ahr61DfxrAajyeNvNOFR51IS0StzDOyN9ohfOx2y+NTmm1zqT7JjH8UlEHu7QyvKC73lgg7ndBdG582NMAssaxG6xNVtdxQX4VBoYR5K9UqxsyttfSE0ZZ2gjKa28LV5DkqE5DomHpNytYCuJWBpypUbMwNmWwqYVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878100; c=relaxed/simple;
	bh=NSaj6VlO7J8PEM3R1vuFpKryRPkP9P011wi2Xxzh81o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIbYtSxs0K6UiuMc7640Gmc/oq47lwph+NCDrGUpqDSwxymEonNZn3HgyJDpW9ItFceSHjHiF8/JyoVM6b6aI0d7VR4KPOKKPRfLJIFtpPV8DcFo1lKJKHNkhsEgRAssvnaHQF8CM7FQTTvjC0mp9XBb2yBr5pIcycnlgZFuVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EcviD4KS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zNYCBYWwErXs15fhlnCMw4jcEYLwPWqapKYvTHn0mAI=; b=EcviD4KSuwWPVJXCn1UdiFG8A7
	HFGpVd5ITIkb6+N+7zza9rA/vl1XkoLzxC6EGorbU97KZvnTN0yn+WxYJsBDQZdq7hUKqoBEFS53j
	BGqWe99LnuiFf4tjAOmArxZlRLPIkVxiZt+ElAqkjqfUqNn/UPNT0lF7CcO1irha2OKXerRomt/E0
	6McDEAgtTCfQ1g62wQQuIlVsf5ARw+cahuOGlP03V54+xLHnKYzlu1hebiv6cxkMl5wY53qy8q8RH
	mMOvhV25KjlqoiRHlTsiEfPdQdogjmO3wPOZ1OOs7dBj+lPoQ/DYPyRxV4d1pjfrvcu2jwmRcAOdZ
	KYOaXkvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utgFU-0000000BV6f-2yjr;
	Wed, 03 Sep 2025 05:41:36 +0000
Date: Wed, 3 Sep 2025 06:41:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mattia Massarenti <mattiamassarenti.mm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] add documentation for function parameter
Message-ID: <20250903054136.GJ39973@ZenIV>
References: <20250831165304.18435-1-mattiamassarenti.mm@gmail.com>
 <CAEMaYNJP_QWV9NkD9stdODfGgvZQX_yUBzqZQ5cr5-u_g9Tg2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMaYNJP_QWV9NkD9stdODfGgvZQX_yUBzqZQ5cr5-u_g9Tg2g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 31, 2025 at 06:59:47PM +0200, Mattia Massarenti wrote:
> Please, ignore this patch, I did a mistake including in the commit also my
> log file. Should I send a new email with the correct patch?

What you probably should do is
	* check if (and how many times) had such a patch been posted
	* check if one of the earlier patches got applied, and when had that
happened.  Check linux-next...

