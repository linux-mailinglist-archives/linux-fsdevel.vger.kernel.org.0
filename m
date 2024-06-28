Return-Path: <linux-fsdevel+bounces-22793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902191C276
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96A2285F19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5AB1C68AE;
	Fri, 28 Jun 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dD3VAU13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6231C6888;
	Fri, 28 Jun 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587893; cv=none; b=ADSaIBoDslhRhXUI2OTwPgaC+ynCaqw+DyXKfYhA/HZnOn6lQP3+myp7k3lHp621TBy1wF/8n8L2ed4NqWFK14dT5dBzyrSs7u/zLXdlA/8qjn3+kNyHunz3EQEfv4zHAw1TO/1DmG4NWj0bc4VJAIMTOo49zc73DkbmvzU3HTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587893; c=relaxed/simple;
	bh=PbzxlPrRdmckMGKWQRHfrRw5WLZFxT7B4DKHijlX60k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqVzyXlG6UhXD/ZzMCkTSRTetMGRvzwUHI5F4L7gASvZ5gzLmCgYLym56KQMYiNm+eIhOoRRwGpqVb7fKbsg5i9Fpaew2uNnA1i8rc4XAsC32HmDAB1V+4cGfnCgllSh/kmZ9G19K/d5GW2yssWosp+EM5JQ4QB34/Jw27AHf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dD3VAU13; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9fFk56npz9sWH;
	Fri, 28 Jun 2024 17:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719587882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE8MPMh7ZRoMezyVGglAVro2cNUnn76DWfqVFwiAbEo=;
	b=dD3VAU13/ewtGUISLqt/dbf1lv5Hx7mupe7mEhCb+epNxln83HFSZU2l3SuhzQQcNe88rf
	eFG0BKw23IJTApTs6QhdAfl7Pp4yJ/0MPNVk0U9LWxjiQh3kyJdpPpjkUBEcSk+f935iCV
	xza0oODDv8PnziBWeqyUt1kqCbDVZz68Fskx/P+E28QIuwQfdKFmsyQNCf8YjkRkEeqTgr
	vDtAXLqXXygyc4eMIADmBUAkC3dy5Vws/x/migUmUxdlzij/dVZOsCREMpd5HCFsSzx96W
	8D+7ADveiYBhm2xahqeW+YcoNRutfbCVvAkPVPR1yIesDu1EozoeJkAX2Ye2lw==
Date: Fri, 28 Jun 2024 15:18:00 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 3/5] rosebush: Add test suite
Message-ID: <20240628151800.bokef4i6n7s4ds42@quentin>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625211803.2750563-4-willy@infradead.org>
X-Rspamd-Queue-Id: 4W9fFk56npz9sWH

On Tue, Jun 25, 2024 at 10:17:58PM +0100, Matthew Wilcox (Oracle) wrote:
> This is not a very sophisticated test suite yet, but it helped find
> a few bugs and provides a framework for adding more tests as more
> bugs are found.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  lib/Kconfig.debug   |   3 +
>  lib/Makefile        |   1 +
>  lib/test_rosebush.c | 140 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 lib/test_rosebush.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..f3cfd79d8dbd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2447,6 +2447,9 @@ config TEST_RHASHTABLE
>  
>  	  If unsure, say N.
>  
> +config TEST_ROSEBUSH
> +	tristate "Test the Rosebush data structure"
> +

This needs a `depends on KUNIT`.

And compiling this test as module results in rbh_destroy not found. I
think you missed EXPORT_SYMBOL of rbh_destroy in the previous patch.

>  config TEST_IDA
>  	tristate "Perform selftest on IDA functions"
>  
> +
> +static void check_empty_rbh(struct kunit *test, struct rbh *rbh)
> +{
> +	iter_rbh(test, rbh, 0, NULL);
> +	iter_rbh(test, rbh, 1, NULL);
> +	iter_rbh(test, rbh, 17, NULL);
> +	iter_rbh(test, rbh, 42, NULL);
> +}

Do these hashes hold any significance that you test them often after an
insert?

--
Pankaj

