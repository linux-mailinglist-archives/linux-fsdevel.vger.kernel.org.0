Return-Path: <linux-fsdevel+bounces-32306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B679A3548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C681C23CFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316017E918;
	Fri, 18 Oct 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="uPBp/NBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92416173326;
	Fri, 18 Oct 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232635; cv=none; b=hwpLstV9MAsQ+upNcy7GKKO5OkLa6A50+nxxDN0JsMpI8Tktqw5Bzz76yoaP/7v3/Fi2i4LH7rEkaOofUmGot9IMi6d+xcTKTKSdv5U+eSkDNfeLhmp5cCsVSv6IZAjV43WKbjgy1D28bKldwJZIM8t/txzVMRVJPomBOXSMjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232635; c=relaxed/simple;
	bh=TB3b3fErQEwvXmtkIvw2KpYnveJWqbQNWnP3HYJHelo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+dsAfdTS+A/movnANRC093ytelbt5CC0r682uru0Nu3GI8Q2+F+G4K3vVBJH1z/7d4VdAderhsvGCLFonkQ87e7WuI32RtT0gwBSLNJH/cg2PXGTY1cRRl0e7U0zx/EjiJBORUpL4cmpUkNHsFqhFLvXGVnLiTXYIUqEfGspB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=uPBp/NBk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XVF5d6F5Fz9tSH;
	Fri, 18 Oct 2024 08:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729232629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5wbOPa7M9mkptkCjCK20z+xEfeEL5rJuDWhSGotFR8=;
	b=uPBp/NBkiuO0heas7jf1/E8xDiv6cNXq7tCxAOGbhGEw3zMHMMsP8/dtigccpqyE1LugsF
	ZJxiew8kTHEhLf5p4PJpVo5jnjnr+J/VR815JysHfWNLh9Xg6PNEtNSaK2Qt+eW/plDP0v
	uynDG0CJP5NYr5hIhpxX938KSdBvn2DhsZi/2Hhn1bBLeVqkLtTc3fYXhaRGPHiJdnFtMF
	CNmT8SRwxcYOKfv7SGrBXaMA7kEgkchPmst+W9mFswC1nj6kjZQ2YePEDjGZsQDXCBn/b3
	4owpa/uNbxoyePBQhSmCRFaCJBwJlqFzrjagTekcBwy8RA7H4hLWqVhbUNSc1g==
Date: Fri, 18 Oct 2024 11:53:41 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] ecryptfs: Convert ecryptfs_writepage() to
 ecryptfs_writepages()
Message-ID: <jcivwcsmvdckd36tfhxkmui5zc4gri2adq3szw7cibkyfxrdu7@y6n6g55qma4g>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-2-willy@infradead.org>
X-Rspamd-Queue-Id: 4XVF5d6F5Fz9tSH

On Thu, Oct 17, 2024 at 04:16:56PM +0100, Matthew Wilcox (Oracle) wrote:
> By adding a ->migrate_folio implementation, theree is no need to keep
> the ->writepage implementation.

Is this documented somewhere or is it common knowledge?

>  The new writepages removes the
> unnecessary call to SetPageUptodate(); the folio should already be
> uptodate at this point.
--
Pankaj

