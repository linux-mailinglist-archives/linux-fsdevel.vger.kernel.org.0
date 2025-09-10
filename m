Return-Path: <linux-fsdevel+bounces-60769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DCB5187A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804C63B0865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEE247280;
	Wed, 10 Sep 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bQYnO/VB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8153220685
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512613; cv=none; b=sOT7bpUxaD65D5b8Cy/ryRPzrjFFWx33FTzjS9ZKnSMWeS/5TRoNFbcZ+1WYwnVglPkPqAktvWDp+3QQll2mIcablokqgDRfEfpchSPWpfpcopaB3cJQODn66eewV60mvhwiD3rasL4uO0sBOxbvYJyTcOrY7Qlj2F3Xk8XkbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512613; c=relaxed/simple;
	bh=3qVeD6pt4doGzEFI9M/LfWLnsGtcKUUR2p1aQUMA9DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCJkY2sa5MxBQ8xMdiwyOg+2wPoSLEeL9n7FDClKRMnkrhODCCnx0BZK9ThUuiFFMS0Tlo6Q5pk8dO3CEIk4z4sHk6fkoeyfMbG/J9HAgS6t1QvztqRzASVBloF8e/KgTj5jrQ9bzAFJsVavnPC8/1Vz9vMgTNUieIjvHvCvlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bQYnO/VB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cMMgF6vXxz9sNb;
	Wed, 10 Sep 2025 15:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757512602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6za6ztX7suRaul/zgf9vzPbpK/mGuLRtUmptZDqt9E=;
	b=bQYnO/VB4mMKgAWdyfCqgyZNoUqaOGx8f1vprAq8sFU0ImkF/W6PTmi2O+FnXmSED0S+65
	zjR5N5HVYmS7/hMWtn23GdPPQGT4yGeZWtZMONe2RJhQYxJLsZd3T0KvbWTlTCw538J1XL
	bu9SkrfC/F09MpMXyIW30O+PYMnWD2dA3xHubaD9UNNRM9YLEPdXnXnWphqota/FyoH0zM
	FvBrcO6QgT8HllZ2657/PEUi3bMLSfTlMVfWSoSsM/p0kV09soaQXuYU3pK+BIPAtRFkgQ
	SaO2Q43PBJAqa751wMnBosq98p+DdzbxuqfATNMqjtN0/rP05pRrwreCEcXVnw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Wed, 10 Sep 2025 15:56:34 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] readahead: Add trace points
Message-ID: <4yz5w6vjnqfidjwss5d4ekprx46u6jityq2b3kq5z7imjj5lpn@de3hz3lglonl>
References: <20250909145849.5090-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909145849.5090-2-jack@suse.cz>
X-Rspamd-Queue-Id: 4cMMgF6vXxz9sNb

On Tue, Sep 09, 2025 at 04:58:50PM +0200, Jan Kara wrote:
> Add a couple of trace points to make debugging readahead logic easier.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/trace/events/readahead.h | 132 +++++++++++++++++++++++++++++++
>  mm/readahead.c                   |   8 ++
>  2 files changed, 140 insertions(+)
>  create mode 100644 include/trace/events/readahead.h
> 
> Changes since v1:
> - moved tracepoint from do_page_cache_ra() to page_cache_ra_unbounded() as
>   that is a more standard function.

Looks good.
Tested-by: Pankaj Raghav <p.raghav@samsung.com>

-- 
Pankaj

