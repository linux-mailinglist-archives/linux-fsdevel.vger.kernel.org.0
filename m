Return-Path: <linux-fsdevel+bounces-79495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NjSIJCUqWmKAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 15:34:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 660962138EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27F673083867
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6E3A875E;
	Thu,  5 Mar 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SziOaQHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F73A6F0C;
	Thu,  5 Mar 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720859; cv=none; b=oJmZofmamuqH7J+YbI/fnFCTBrwHkZ1djmsqzgKIyD8T7JLGAQamxw65swaTLlp98XiHcJZCgi9kLz5OT7t9nSR4RHGXg3KPzGjrizqbmtsBg0nnbW2QlZAaY2LHNZcGNMO4BMpIoFzvL4XM94ohBSnrz1OX7Guv3N6tkoBcgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720859; c=relaxed/simple;
	bh=hck/tHHv3z8v+VE/arQv3d0oAiX/ouYvA9f3YKBKOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVVJPRFTLfBdxFKt7FduJCXIsHIuo5bukYGp4wivzjFlHfhRB/g7By9bXTM96eoxkhi+ag4ND6/8gTOPi8sHqs3NEwotW1tErr23Z7rKVcYMRRlRbAPLpfk+erK+wyJ8NitwyzaDf6gZldiUunmHRtl6Mum9l+hqwB3bJx3kGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SziOaQHg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hck/tHHv3z8v+VE/arQv3d0oAiX/ouYvA9f3YKBKOdQ=; b=SziOaQHg0WC8s6Y3T/QlO2OzaN
	Buex6G7OVWCDrhOQnqCLM7kr0tgAQIodr0Wc7X6mn3eMI6sLk7hga32etcAuJBQ7DrClJaWBCYB6W
	gwoMOlxVJdAmLNSnp6///6J2uogqA+8HtBqE53Wsdo85owoJEHmn7QXUGvQIMk+cOMtVtNrZGrZb/
	WL95RzGYqS6jR0HFJ7F+CKJFNMyIudU428K8257WNcuC2i/kOSBWu8b+MyCUkTjSRsPTKJOr1Ti8+
	uQb3T2996bw3jvSGUA19D0Gf+G6MbE5j65w23SfRoFb/yG9h8LUsRXD+RCdxrmkza2Wym291jnq6T
	J4Zt7xjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy9fq-00000001zVi-3XNJ;
	Thu, 05 Mar 2026 14:27:34 +0000
Date: Thu, 5 Mar 2026 06:27:34 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aamS1roqYDyEz0P3@infradead.org>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
 <aajObSSRGVXG3sI_@hyunchul-PC02>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aajObSSRGVXG3sI_@hyunchul-PC02>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 660962138EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79495-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:29:33AM +0900, Hyunchul Lee wrote:
> Sorry it's generic/285, not generic/268.
> in generic/285, there is a test that creates a hole exceeding the block
> size and appends small data to the file. hfsplus fails because it fills
> the block device and returns ENOSPC. However if it returns EFBIG
> instead, the test is skipped.

generic/285 needs to call _require_sparse_files.


