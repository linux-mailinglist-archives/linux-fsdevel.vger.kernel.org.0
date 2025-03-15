Return-Path: <linux-fsdevel+bounces-44113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A76A62A26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 10:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA7B189663A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617B1F5828;
	Sat, 15 Mar 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPKjC0wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29921DAC81;
	Sat, 15 Mar 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031207; cv=none; b=W/RcllQOKgrmkEihj3HlvLqRkxIILG75DQPxw3+zBJ2nOnvr4T/3poUPEWl6wwEVYmXSc25PTxf1YFYclp+Pc8A8grx0+EVBEnOnNw6h147eOoJOglZKTvextX+qQyyHd/2bGcOIeLqBgvVjBjPUnl7hupG2VC9LJdjfJ20pJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031207; c=relaxed/simple;
	bh=hLe6wa9odyEnA3It722yJ8dVV+PjRiY+JFKH4DQLSBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6UYrqVvs1vp92E79greEDyd0OYWPlYqZdbGJoAHs7B8duj6PfeQyJLdVBHNUkaEyZkO4sZrFuICOd5hvnhwXgfuiIDFj4CtxTiCWhwddFZ+G01b2cMMr2VTNfVOuN9H4P5/js81ZFr6EOp11ui6SgcDxFWaM6WXP0P4ZM7uHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPKjC0wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7797C4CEE5;
	Sat, 15 Mar 2025 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742031207;
	bh=hLe6wa9odyEnA3It722yJ8dVV+PjRiY+JFKH4DQLSBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPKjC0wbTmpKraRwJqd3wvkMsebcccvQfR0nTf1KOtaU7TNHa+sMVOwVrPObPgQo0
	 7MHBNmljOBX0Vks2HXUZwAp5GWgJ/SAiEuu0uIFpBm2HJvJvRohq1rA4vzrVqjtcIe
	 nhSRHaBL3+xukaOGXzj1d0HT7eNX2hYDMovC8ZSs=
Date: Sat, 15 Mar 2025 10:32:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, tytso@mit.edu,
	ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org,
	sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com,
	willy@infradead.org, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <2025031554-agreeing-ammonium-58aa@gregkh>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <2025031529-greedless-jingle-1f3b@gregkh>
 <20250315-gruft-evidenz-d2054ba2f684@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315-gruft-evidenz-d2054ba2f684@brauner>

On Sat, Mar 15, 2025 at 10:18:23AM +0100, Christian Brauner wrote:
> > But I'll wait for an ACK from the filesystem developers before doing it
> > as having filesystem code in drivers/staging/ feels odd, and they kind
> > of need to know what's going on here for when they change api stuff.
> 
> Sorry, I don't want new filesystems going through the generic staging
> tree. Next week during LSFMM we can discuss a filesystem specific
> staging tree that is directly maintained as part of fs so it's tightly
> integrated. We're going to talk about two new filesystems anyway.

Great, then I'll not worry about this patch series at all, thanks!

greg k-h

