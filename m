Return-Path: <linux-fsdevel+bounces-7710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31658829C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F131F29E96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38614A9B5;
	Wed, 10 Jan 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="wb5UP7bB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E9495CF;
	Wed, 10 Jan 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T993F6GCDz9srG;
	Wed, 10 Jan 2024 15:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704896505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TFsgjOEUTzhIVMLsyeI45IECAzV2lWJXPxnqpzC/k8=;
	b=wb5UP7bB9QDusd95ZHqucVZHSrFi60yZKXXPGV0qYeHMuCHuaA/M4WuhMLmkHhtYH2WN1y
	aqH9klKbEjrIUQk1CponzsDOVVWWKTaDJe2N5kCd+bPlFremOBI/6ihnf1q3iUoiTEztyJ
	NeHEEdUuezCWSXPm0TvbzAup8CrGf9kGh10m/JP+NszoJZLP5FjCvxpG/hM6syXBTo0z4V
	MyW6jGsIbh1D5M22MQsVYCZxlmVY8Z3QJnEb5Yv8PRzqexYRIYwgqK9L/5zYOQfoFcyO5I
	QzLq+WcyTHq7qHY0UGVqB2uKBNvimZSBJ65qpAngy+jmqqfWAUfh0lGbU3ZiBQ==
Date: Wed, 10 Jan 2024 15:21:42 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH v2 3/8] buffer: Add kernel-doc for try_to_free_buffers()
Message-ID: <20240110142142.kxrnkljnofs6o3fv@localhost>
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109143357.2375046-4-willy@infradead.org>

On Tue, Jan 09, 2024 at 02:33:52PM +0000, Matthew Wilcox (Oracle) wrote:
> The documentation for this function has become separated from it over
> time; move it to the right place and turn it into kernel-doc.  Mild
> editing of the content to make it more about what the function does, and
> less about how it does it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

