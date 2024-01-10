Return-Path: <linux-fsdevel+bounces-7709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36416829C36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15281F25E30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377BC4B5A5;
	Wed, 10 Jan 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mCCUeypz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3F4A9AB;
	Wed, 10 Jan 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T98s770n7z9t3w;
	Wed, 10 Jan 2024 15:12:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704895980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECG5e9wIUmeNqRsln6dF7Mycb34NtIxoMGw5Bg5bw8Q=;
	b=mCCUeypz7TL2I1fenTBBweZdNqxJbQbqKKY5Ygg9lfN60IRIy06tcCR5rVxDGH1OJWrGlB
	TCB4hhfefJDYp1ZY1yWXUMjUfsdYdb1qz9xx5JoSBepOJoSuVL40MgxP8daVcg14IHEG03
	R+yhgd1pcFcbjbNHXdtnFGjVU5OhoH2bvclC8k08eGJneSy2waD7cKXOfn40YLUy2NjqYk
	YWVDvTGnrh9gAEDY40JGme/0k8N+mPt9cQliOC09nDRizh1hloBaI/4g9lQ2kUreaoKl7E
	afrEU18lIDWlRU//+/w4C/TSnLL+llTKtVz1i2sKZPj4Xi0hpOtOpOcnIMbxCg==
Date: Wed, 10 Jan 2024 15:12:56 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH v2 2/8] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <20240110141256.yx4cwtvv5fa7uxbp@localhost>
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109143357.2375046-3-willy@infradead.org>

On Tue, Jan 09, 2024 at 02:33:51PM +0000, Matthew Wilcox (Oracle) wrote:
> Turn the excellent documentation for this function into kernel-doc.
> Replace 'page' with 'folio' and make a few other minor updates.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

