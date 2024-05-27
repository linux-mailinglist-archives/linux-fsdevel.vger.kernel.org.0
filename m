Return-Path: <linux-fsdevel+bounces-20263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860A8D08DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E3A1C217E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1B15A84D;
	Mon, 27 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OlL25Yit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852573460;
	Mon, 27 May 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828031; cv=none; b=KYUS0DuqLLQpGVc5MDNlWTndDZZnIf+keQcyQWmpKccX3gF/ryWx0O/7p1V249YEBpQgAkg6q2NjZhJ3bJcPYdSliWauSIpoX5VI52kD5A4bMWtmsch/qW8FXhlR/94HY3KKhoR5PtbGF0DtTL3mDtvWkl/TmycdCzcYoUeT9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828031; c=relaxed/simple;
	bh=Y3vGyr2vK5IG2TkK9KPklsBR/1F7GPtB/P0U+1sIMrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0SXRY+9BbDo1+/ZqFcOdOGPLWQ8Asi+R2R0MG4w2hD8dUi5j8w6hqEOuzHER3MByTBdprwM/6oecyb5byLeGXNS6Y2t5TBAFVed9elbDUWXMSSLHDmRVo3hidshqxypV8eDbbATSvdXUI8ovKwTMcizALOWiL3ggJVb175Ejws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OlL25Yit; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z12lgDOLiDKrQA+yDtMKt0dB9MAdd+J3m/YUsfJBCAY=; b=OlL25Yitp1tNmKHCjlaNT3EPCL
	TFNE5lifw++0CPK0tQJqDcHoCPP5CGAYd5eMZlKeDHFMqH/+mfjnvCHGb34nqhf/mo5tJIPtHQfg7
	bAQmyTQWkbAep1kqr57dBv1icF5+n17oPMgFtx9x/KuBRVW3De9LuS/oKo2P/vrnOeLoM0vpChuRc
	XgTAuxqR79YF9vpaO1g8ALfURe5smQ3UrlEAKdLyvSj3J5kUlZRYUes8ws1H6UA016C6I76QrgcKL
	KH6KZvnvVitJI0gvwL9e9fou/xJ1VgT0tQkGbTOmGK5Wl+2YSYqmMJT7cULsyEmUQXKjln+cdNjcL
	72oGCpfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sBdOY-00Dpro-1a;
	Mon, 27 May 2024 16:40:22 +0000
Date: Mon, 27 May 2024 17:40:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/adfs: add MODULE_DESCRIPTION
Message-ID: <20240527164022.GE2118490@ZenIV>
References: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
 <20240524-zumal-butterbrot-015b2a21efd5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-zumal-butterbrot-015b2a21efd5@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 24, 2024 at 03:13:04PM +0200, Christian Brauner wrote:
> On Thu, 23 May 2024 06:58:01 -0700, Jeff Johnson wrote:
> > Fix the 'make W=1' issue:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
> > 
> > 
> 
> Sure, why not.

Might make sense to move those into a separate branch, IMO (and feel
free to slap ACKed-by: Al Viro <viro@zeniv.linux.org.uk> on those -
AFAICS all of them look reasonable).

