Return-Path: <linux-fsdevel+bounces-7546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB95826FE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847601C228F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6744C93;
	Mon,  8 Jan 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="u+FNpHsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AB44C76;
	Mon,  8 Jan 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T7w204wbbz9sZJ;
	Mon,  8 Jan 2024 14:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704720680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oRIFaBZBSyp5TDSxL6kowSEyWtZ3AkKsLMCOdArOrI=;
	b=u+FNpHsSlpUobWJrXYPlQcnKCMDfaVvKm4Bqg2uW1rLn3gFruFCwISezLS1FEnUMFayGf9
	sHIMr0Wy4F52sNYpx2XMugxv0u69pQqnlmbbYC5ilDYJQdj1vrRiqB42u8yupuhfvIuoni
	9hQtlZ90FHvml3K3EZsVCezVCep+kSWnMaIqWJROnhpCyjBvyc1y/oyx/3hDmUXu2gAmK9
	e9AX49PMbvtLAt6I0liCoE5xGka4koGG7piLGtfBQFMR3kW7RxOTQhxwmnn6CpQbdRI6GI
	vpc9jWDrHbFwMQtArdaXK+nBWr9X9Lu+Gz8ZoD17O7xam9Ho5G0edYwJJp9wlw==
Date: Mon, 8 Jan 2024 14:31:17 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <20240108133117.xtkbzeiqq6dtesm5@localhost>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163652.3705753-3-willy@infradead.org>
X-Rspamd-Queue-Id: 4T7w204wbbz9sZJ

> + * If the folio has buffers, the uptodate buffers are set dirty, to
> + * preserve dirty-state coherency between the folio and the buffers.
> + * It the folio does not have buffers then when they are later attached

s/It the folio/If the folio
> + * they will all be set dirty.
Is it better to rephrase it slightly as follows:

If the folio does not have buffers, they will all be set dirty when they
are later attached.

> + *
> + * The buffers are dirtied before the folio is dirtied.  There's a small
> + * race window in which writeback may see the folio cleanness but not the
> + * buffer dirtiness.  That's fine.  If this code were to set the folio

