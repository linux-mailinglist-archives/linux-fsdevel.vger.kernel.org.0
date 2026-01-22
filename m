Return-Path: <linux-fsdevel+bounces-74966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HRjM6iXcWngJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:21:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01161457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B29025041F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76743B8BB7;
	Thu, 22 Jan 2026 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="udfspR+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202617BEBF;
	Thu, 22 Jan 2026 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052036; cv=none; b=SkLbx8F5oL1mq6NIVjpYpSM9peHkCIO/ywW8JnUtPYyfKVyzvgLCi/NaezTAK0sm9fGq7uNN8PPSil67j5qiX+Bvw6d/caI5V8ffBLVAZW6OJj+l05GZYx6C5Hr5g2wT1OcbnWHviK6EFKdUTmqBs5Dlmp6rhkrQAv1eHDqs/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052036; c=relaxed/simple;
	bh=QiEzPFyPRp7D4pZHCSHsufA6QBlx7eGD+u+7FP/nPCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA1eR2NOdXtEvAeZeQVqJERsU2Ars/hxSBkuvT2CuZYCS42MEl4Jz2jxDKQYZQkc9MTvKZXzO1OoJlOsQK65R4c9UbgbDUWurrMn2UYYJGUypnNrTaYPKDdpMjWMjW9zTYFujrSJs+rcYHBxXonsf6ZSl1n5LWSCCk3AO8L+xJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=udfspR+g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=31l0nbGeLTjwpa82UsNxbLyFca7m2KDZY12SuZ1x9N8=; b=udfspR+g3unw93P3GndOy/qnL+
	k89TymW4jwCHYhiqN728xO1cj+Qp8izMTkfS1yJVokH3w6HtzXU9htJvTSZl2zKlVyLSvpH2+OElV
	KbgaY2MIY3P/rrSOipJbiAsgH05sCTLpEO7gv3OQUGTaswVXIkLizD4SSRGpNJlPh96eEfQEaenBD
	xe1iRDWBDMsI0A2yv1eQ2FqN94DWw8HIEHtRpFakIjsJNKDOMwSi3C4SeyVvOoYOly7DHiGvKuOeY
	nAnW6Owv5mjA6ly8KU1MMZ9TgfbSB5j235CCeD0BxPhPP/IEg9+eF2WdcBvG6pjXFYtfI2cTobywD
	HCVx3vfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vilGr-0000000CsEq-1hPu;
	Thu, 22 Jan 2026 03:22:09 +0000
Date: Thu, 22 Jan 2026 03:22:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260122032209.GE3183987@ZenIV>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74966-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[zeniv.linux.org.uk,none];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F01161457
X-Rspamd-Action: no action

On Sat, Jan 10, 2026 at 02:24:17PM +0100, Christian Brauner wrote:
> The annual Linux Storage, Filesystem, Memory Management, and BPF
> (LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
> Croatia.
> 
> LSF/MM/BPF is an invitation-only technical workshop to map out
> improvements to the Linux storage, filesystem, BPF, and memory
> management subsystems that will make their way into the mainline
> kernel within the coming years.
> 
> LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> subsystem-specific tracks, cross-track discussions, as well as BoF and
> hacking sessions.

Will there be an option for remote participation this year?

