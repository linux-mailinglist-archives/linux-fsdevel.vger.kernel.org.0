Return-Path: <linux-fsdevel+bounces-77203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA+ULW9pkGllZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:24:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE613BD66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD48430221F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853730BB8C;
	Sat, 14 Feb 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWMmdqkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1917D2;
	Sat, 14 Feb 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071845; cv=none; b=gZnTWNLV3P2Mok9pKYMfA/g2dIJtsquZl2lDOK2nnOJeUAc4nnU6JusnIpgwlFpoCPuYPoZ5jivWFnd2glnZVrwwBvI07dNnAwVVK/1oO+mXpxFHZ8T3Xh1PyBhv+NBSGHLAqEXDjMBtVSkEuAduqTiNjJx7Ppim1p7JnZvX9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071845; c=relaxed/simple;
	bh=30f27v+mHS60nppfktd31AaQvXVA9o6eescZJPxBXZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSfrpBLIFgfUBMs1AA1IE2aWAdOoyM6HzxRdPTrSqhrbNozAxoCOcpbinj2fURpxqHbjGX/kVwcrJCCDzge5goyqkP3UD1kS8W4JP1PFiDV0iIxS9KJw9XYOtMgEBVUdNRrZTTDR07iEt6WlMRwM+H0r/xysAGfmcW3dYtetQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWMmdqkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE63C16AAE;
	Sat, 14 Feb 2026 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771071845;
	bh=30f27v+mHS60nppfktd31AaQvXVA9o6eescZJPxBXZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWMmdqkDhmfOZr3aXjc9BVKN2U14OO46QgfaGYtdndCZlh5NYvxVQI10lZs7vaWUp
	 aRRl95KcLhc7Qx1JJXqbsmhc1cYuOt2FCHwi7jkmeOwwDwbOupmohcShLqUQNJfHTL
	 pXYKKJkjzX00z3p8JOgvsqMQfnxIofD3Rb9rs3orEYfvPw4XgrysVW9xtyjJ3QUwl6
	 EqS6jP5ptpDd2e1Hsn4SnaK5odM0TR2XcH0I/+6XFhPIT90bYJhbXzFLNKDZPun7zC
	 So3qZvtY4wLzYRkqJHI2pU2arunRu0zDbT22E9Ai2CeFKMFya3OzpoqOkA1P0lVMKg
	 cDZO0imesPO7g==
Date: Sat, 14 Feb 2026 13:24:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>, Mark Brown <broonie@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, oe-lkp@lists.linux.dev, 
	ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [mount]  4f5ba37ddc: ltp.fsmount02.fail
Message-ID: <20260214-ausformuliert-aufgearbeitet-7b45890e036a@brauner>
References: <202602122354.412c5e65-lkp@intel.com>
 <aY7wZwHXH2zS_Sj-@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aY7wZwHXH2zS_Sj-@yuki.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77203-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16CE613BD66
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 10:35:35AM +0100, Cyril Hrubis wrote:
> Hi!
> > commit: 4f5ba37ddcdf5eaac2408178050183345d56b2d3 ("mount: add FSMOUNT_NAMESPACE")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> The relevant part of the log is:
> 
> fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)
> 
> This is another case where new flag was added so the invalid flag value
> is not invalid anymore. The test needs to be adjusted if/once the patch
> hits mainline.

Ah, very good to know. Adding Mark so he's aware that this is an
expected failure.

