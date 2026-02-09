Return-Path: <linux-fsdevel+bounces-76706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBXcOvDniWmdDwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:58:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 654FB10FF47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D13301953F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E261E379992;
	Mon,  9 Feb 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="A9bNyPOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A03793AD;
	Mon,  9 Feb 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645423; cv=none; b=u6RBfBJMAd8Yy+i46mUdaead0+GJ794sEL3WamWajsR+UizFNGAJF8r1Lj/RzPJPppPuKCN9vfD6UWz8c+W+/+jmLFUgJwK9rFChxvryIIbOIVeC3x5v92x+aaOZfsrtuZs9s7mdAQ2A+WS1AI8YPmDGQ7pKGiAXRNgb87vUaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645423; c=relaxed/simple;
	bh=0PrYKRQczg+VNl5lzty4yY3HXn9K859irlTbMaToxo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpLWlao7RKu8n1rCOJ+ShffGvpRIp92ZLwqgGmxgl0RxeiEHJYlvQ9RjkgqPA/w0tWpmchhv0N3c2hqkjXP0BDQQ3l8LWbO2jqGiqEZYqM7nUjgs2fSfoxubHyibiyjoJk1J8hfcYfFwJOs/qF7mHZfNALAfToyObZZIz9/eWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=A9bNyPOx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=0PrYKRQczg+VNl5lzty4yY3HXn9K859irlTbMaToxo8=; b=A9bNyPOxfA5exPo547YFN/1F6x
	vhwKzEbbTagpPwpb6zeXy790szN5uK5HA5PNu9qRvTybhURAZDESi5iKqDgIo42Xh5kw8w4R0KqXK
	eeVLD1Z/vqDReBW3aTMyfKCzJWoeIVaF3GMg2GSJq5KFL5TtBPr6mSItJl9oJm7AMCOjoBzwfcBcU
	BSxF4au9OM9LWSF6ZDKcDZ7of2ruxFU02Bt/3+muLBmVMW50DXWMSq5xS1pCsrlP0f+g5hvHDSPtn
	/Lh4QWy1+ErW2zjfkUP/rEBcH0m0qvD+FfNfUfErpIr74MNUWtV2sDNHBaRJxaKzuYESrLRTwrf5P
	w0WDhAtA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vpRkm-009X0U-4k; Mon, 09 Feb 2026 13:56:40 +0000
Date: Mon, 9 Feb 2026 05:56:34 -0800
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, hch@infradead.org, 
	jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <aYnnHJ2TQEcD_xMS@gmail.com>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-76706-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,wbinvd.org,meta.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 654FB10FF47
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
> Perhaps we should discuss this at a venue where we can get some more
> people together? LPC or LSF maybe?

Certainly, I agree. I’ve submitted my subscription to LSFMMBPF with the main
goal to discuss this topic. I wasn’t planning to present it this, given it was
a "overkill"?, but I’m happy to do so if that is the right direction.

Thanks
--breno

