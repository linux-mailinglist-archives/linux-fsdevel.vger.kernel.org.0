Return-Path: <linux-fsdevel+bounces-60665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8EB4FB7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DB818845E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69191334733;
	Tue,  9 Sep 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TMPwzjkk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8229C328
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421710; cv=none; b=Om6rWYjI6G7gyL51VrjEWtUGvkmviE0PRJVT1iPTa2Hb5wahmv+4mr3rX9mAxNElzhmM1ghCKyeNqpioeKa6iqci6Xf3NhNobqJn3wk/LpCCnGjJiyq1S026Azm3f2cyErlCAF26RcIUcq2antnIiQltFyTzaS1NAZmF19h9QuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421710; c=relaxed/simple;
	bh=hCcmZZr08omRz2ku2Xlc6M3Z3rvoa4JXVHtVWioyHjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSNTzwXJCg+t6n25KkDE1vZhhXX7A1aZsgs0v4FQ85Sg7sHMSZ/An80IICFfJRFAZIXLN1JnOkzlNZYBPp+lHMyE+BkXcXL076w1HYS/K+hZdFFZ4ShQnVNKIRA94IwNpEho3oxrAxHpCZwwl4jLlE5jj1z6DYWJlq3IcrIFtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TMPwzjkk; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cLk373gvLz9t8m;
	Tue,  9 Sep 2025 14:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757421699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVUdhNd+P9h0gfV0HMy1Y0L0QTg5GkmAtstrPmaFDx0=;
	b=TMPwzjkkTW4j8Cvbkqjny5DWR+W7DUefa/Z8x3PwncsEBRVL1pIMr5wxUlg8PNyOoUVgpD
	yM4xxM8fO3Eeacm3Rt7UBHaMVBJgeHXGTcbAbdfH4p2dxQ0tjlZmnkzsf5IValO5qVH7hV
	yfUOamm3A+RxLz8Q7tIcO/GL58wq+pXf83AXRyDtNnoGa2wu3JvzNB/zQBRzvt6M3Q00+q
	U0O0RVkV9eZEzFGwJ53huvwk5A+uUzR95i9D3gf82Z10JGaHFa6+Yundi9r/GN0A9S3XCw
	FYyzOcaQCAHKWHAaHnB8bHwKoTCt95RkgO2gH5qeXYdePoaabfUdK6DfM4qCFQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Tue, 9 Sep 2025 14:41:33 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] readahead: Add trace points
Message-ID: <iruyokxvyziqzq3qrcorpx6mq2pshs6beyvgsokqlcz7loane2@y4bdrxzzitwa>
References: <20250908145533.31528-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908145533.31528-2-jack@suse.cz>
X-Rspamd-Queue-Id: 4cLk373gvLz9t8m

On Mon, Sep 08, 2025 at 04:55:34PM +0200, Jan Kara wrote:
>  
>  /*
> @@ -314,6 +317,7 @@ static void do_page_cache_ra(struct readahead_control *ractl,
>  	loff_t isize = i_size_read(inode);
>  	pgoff_t end_index;	/* The last page we want to read */
>  
> +	trace_do_page_cache_ra(inode, index, nr_to_read, lookahead_size);

Any reason why put a probe here instead of page_cache_ra_unbounded as
that is where the actual readahead happens?

-- 
Pankaj Raghav

