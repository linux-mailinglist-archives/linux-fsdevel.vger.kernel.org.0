Return-Path: <linux-fsdevel+bounces-61309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E216B57773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB45817F048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEF2FDC37;
	Mon, 15 Sep 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="SODSd712"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25E2FC882;
	Mon, 15 Sep 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934039; cv=none; b=QESTH7vWlI2uh3jEnA/4fJOU9UyPPt1kq84nczLj8ywH7FozqBuVR9nofwVlwxdAIvIDk3t3p6ljb3rKtigSFZRoE75SPvfLGM6AS3VXu8IgUo+vit5DY62abXB1JxcxOruJUlTwxZq4JnXzH6yz8ElRvFUKBYKIgcF/qiPWCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934039; c=relaxed/simple;
	bh=ZV634K57Z5UoPeDWdpklh2Vcy+8cq31Zs8Q4UifwuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DypPl9dL5Ux/+MvzNaT9Lkmx1yw3UuKf2pGcqAtrMBCaLLAkqAi7cBnoTp93Bnnl3A/MZSTW56+16iRUH+P3Mb6xpYM1WFjNmYvsreWh6Znql3rFJujXd7NoqTO5VfNZ9SykaIduHe6E/3qg/mmXsu9C+8Wr3ULXG6lamnSMVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=SODSd712; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cQMJf0YBcz9skw;
	Mon, 15 Sep 2025 12:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757933458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+9m+tPdu7ZSOPdAnVmZPq5aqsjI0BpluCAnTxIHpVk=;
	b=SODSd712Vwn3s0zJIxImpOzkL1Ds8n/tG2aqmjQlefDKtJBz0w3mt7X/3b09NNhRhjQtT/
	87JYdur5Ek9kL2nNQM/S4Q02avxFicve+97dq55YQT34X13ES45cgazCgp3ylAO8QvDtcX
	Pk5blffSxsII9mbIEQGIZ4NQvy3WVByfTVpFqhTgle3N24yib3vjxSQJc4p49OrGo5DZ9k
	xvx/k6Ev5i8681FZ5TGNlUadcIexv4CbmGnwpqBMNpV//uU4blSc0ZNaAes+2TP//FhGcs
	KYYaDZ5utys/E6cAAIp9nMkqiBBYdPugJkvEi1jI83U/Sa+YS9MMrbIpvLNKdQ==
Date: Mon, 15 Sep 2025 12:50:54 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: alexjlzheng@gmail.com
Cc: hch@infradead.org, brauner@kernel.org, djwong@kernel.org, 
	yi.zhang@huawei.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 4/4] iomap: don't abandon the whole copy when we have
 iomap_folio_state
Message-ID: <dhjvmhfpmyf5ncbutlev6mmtgxatnuorfiv7i4q55wpzl7jrvn@asxbr2hv3xfv>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
 <20250913033718.2800561-5-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913033718.2800561-5-alexjlzheng@tencent.com>

> +static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
> +		size_t copied, struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	unsigned block_size, last_blk, last_blk_bytes;
> +
> +	if (!ifs || !copied)
> +		return 0;
> +
> +	block_size = 1 << inode->i_blkbits;
> +	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
> +	last_blk_bytes = (pos + copied) & (block_size - 1);
> +
> +	if (!ifs_block_is_uptodate(ifs, last_blk))
> +		copied -= min(copied, last_blk_bytes);

If pos is aligned to block_size, is there a scenario where 
copied < last_blk_bytes?

Trying to understand why you are using a min() here.
--
Pankaj

